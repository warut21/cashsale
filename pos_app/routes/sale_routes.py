from flask import Blueprint, request, jsonify
from pos_app.models import db, Control, BillHeader, BillDetail, FinishGood, SalesPerson # Assuming models.py is in pos_app
from pos_app.routes.auth_routes import get_current_user_placeholder # For simulated auth
from datetime import datetime
from sqlalchemy.exc import IntegrityError

sale_bp = Blueprint('sale_bp', __name__, url_prefix='/api/sales') # Changed prefix

# --- Bill Number Generation ---
DEFAULT_COMP_ID = 'DEFAULT_COMP'
DEFAULT_PC_ID = 'DEFAULT_PC'
BILL_NO_LENGTH = 6 # Example length for padding bill numbers

def generate_new_bill_no():
    """
    Generates a new unique bill number based on the Control table.
    Uses DEFAULT_COMP_ID and DEFAULT_PC_ID.
    Returns the new bill number as a string.
    """
    control_record = Control.query.filter_by(COMP_ID=DEFAULT_COMP_ID, PC_ID=DEFAULT_PC_ID).first()
    
    next_bill_no_int = 1
    
    if control_record:
        if control_record.CUR_BILL_NO:
            try:
                next_bill_no_int = int(control_record.CUR_BILL_NO) + 1
            except ValueError:
                # Handle cases where CUR_BILL_NO might not be a valid integer string
                # Fallback to 1 or attempt to parse differently if format is known
                print(f"Warning: CUR_BILL_NO '{control_record.CUR_BILL_NO}' is not an integer. Resetting.")
                # Potentially query max bill_no from BILL_HEAD as a recovery mechanism
                # For now, reset to 1 if parsing fails after existing.
                last_bill_header = BillHeader.query.filter_by(BILLH_COMP_ID=DEFAULT_COMP_ID)\
                                                   .order_by(BillHeader.BILLH_NO.desc())\
                                                   .first()
                if last_bill_header and last_bill_header.BILLH_NO:
                    try:
                        next_bill_no_int = int(last_bill_header.BILLH_NO) + 1
                    except ValueError:
                        pass # Keep next_bill_no_int as 1

        control_record.CUR_BILL_NO = str(next_bill_no_int).zfill(BILL_NO_LENGTH)
    else:
        # Create new control record if it doesn't exist
        start_bill_no = str(next_bill_no_int).zfill(BILL_NO_LENGTH)
        control_record = Control(
            COMP_ID=DEFAULT_COMP_ID,
            PC_ID=DEFAULT_PC_ID,
            PC_NAME="Default Point of Sale", # Optional default name
            STDATE=datetime.utcnow(),
            SALESDATE=datetime.utcnow(),
            CUR_BILL_NO=start_bill_no,
            START_BILL_NO=start_bill_no,
            # Initialize other numeric fields if necessary
            ACCU_AMT=0, ACCU_BILL=0, TODAY_AMT=0, TODAY_BILL=0,
            ACCU_AMT_C=0, ACCU_BILL_C=0, TODAY_AMT_C=0, TODAY_BILL_C=0
        )
        db.session.add(control_record)
        
    try:
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        print(f"Error updating Control table: {e}")
        raise # Re-raise the exception to be caught by the route handler
        
    return str(next_bill_no_int).zfill(BILL_NO_LENGTH)

# --- API Endpoints ---

@sale_bp.route('/new_bill', methods=['POST'])
def initiate_new_bill():
    current_user = get_current_user_placeholder() # Simulated authentication
    if not current_user:
        return jsonify({"message": "Authentication required or dummy user setup failed"}), 401

    try:
        new_bill_no = generate_new_bill_no()
    except Exception as e:
        return jsonify({"message": "Failed to generate new bill number", "error": str(e)}), 500

    # Use COMP_ID from the (simulated) current user, or default if not set
    bill_comp_id = current_user.COMP_ID if current_user.COMP_ID else DEFAULT_COMP_ID
    
    new_bill_header = BillHeader(
        BILLH_COMP_ID=bill_comp_id,
        BILLH_NO=new_bill_no,
        BILLH_DATE=datetime.utcnow(),
        BILLH_SALES_ID=current_user.SALES_ID,
        BILLH_STATUS='pending',
        BILLH_AMT=0,
        BILLH_AMT_VAT=0,
        BILLH_TOTAMT=0,
        BILLH_DISCOUNT=0,
        BILLH_TOTPAY=0
        # BILLH_CUST_ID can be set later if needed
        # BILLH_FG_GRP can be set later or based on first item
    )
    
    try:
        db.session.add(new_bill_header)
        db.session.commit()
        
        # Update control table today's bill count
        control_record = Control.query.filter_by(COMP_ID=bill_comp_id, PC_ID=DEFAULT_PC_ID).first()
        if control_record:
            control_record.TODAY_BILL = (control_record.TODAY_BILL or 0) + 1
            control_record.ACCU_BILL = (control_record.ACCU_BILL or 0) + 1
            db.session.commit()

        return jsonify({
            "message": "New bill initiated successfully",
            "bill_header": {
                "BILLH_COMP_ID": new_bill_header.BILLH_COMP_ID,
                "BILLH_NO": new_bill_header.BILLH_NO,
                "BILLH_DATE": new_bill_header.BILLH_DATE.isoformat(),
                "BILLH_SALES_ID": new_bill_header.BILLH_SALES_ID,
                "BILLH_STATUS": new_bill_header.BILLH_STATUS
            }
        }), 201
    except IntegrityError as e:
        db.session.rollback()
        return jsonify({"message": "Failed to create new bill header, possible duplicate bill number.", "error": str(e)}), 409
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to create new bill header", "error": str(e)}), 500


@sale_bp.route('/add_item', methods=['POST'])
def add_item_to_bill():
    current_user = get_current_user_placeholder() # Simulated authentication
    if not current_user:
        return jsonify({"message": "Authentication required"}), 401

    data = request.get_json()
    required_fields = ['BILLH_COMP_ID', 'BILLH_NO', 'BILLD_GOODS_ID', 'BILLD_GOODS_NUM']
    if not all(field in data for field in required_fields):
        return jsonify({"message": "Missing required fields"}), 400

    bill_comp_id = data.get('BILLH_COMP_ID')
    bill_no = data.get('BILLH_NO')
    goods_id = data.get('BILLD_GOODS_ID')
    quantity = data.get('BILLD_GOODS_NUM')

    try:
        quantity = float(quantity)
        if quantity <= 0:
            return jsonify({"message": "Quantity must be positive"}), 400
    except ValueError:
        return jsonify({"message": "Invalid quantity format"}), 400

    bill_header = BillHeader.query.filter_by(BILLH_COMP_ID=bill_comp_id, BILLH_NO=bill_no).first()
    if not bill_header:
        return jsonify({"message": "Bill header not found"}), 404
    
    if bill_header.BILLH_STATUS != 'pending':
        return jsonify({"message": f"Bill is not pending, current status: {bill_header.BILLH_STATUS}"}), 400

    product = FinishGood.query.get(goods_id)
    if not product:
        return jsonify({"message": "Product not found"}), 404
    if product.FG_PRICE is None:
         return jsonify({"message": f"Product {goods_id} does not have a price defined."}), 400


    # Determine next line number
    last_detail = BillDetail.query.filter_by(BILLD_COMP_ID=bill_comp_id, BILLD_NO=bill_no)\
                                .order_by(BillDetail.BILLD_LINE.desc())\
                                .first()
    next_line_no = (last_detail.BILLD_LINE + 1) if last_detail else 1

    item_price = product.FG_PRICE
    item_amount = item_price * quantity
    item_vat_amount = 0  # Assuming 0 VAT for now. Calculation: item_amount * (VAT_RATE / 100)

    new_bill_detail = BillDetail(
        BILLD_COMP_ID=bill_comp_id,
        BILLD_NO=bill_no,
        BILLD_LINE=next_line_no,
        BILLD_GOODS_ID=goods_id,
        BILLD_GOODS_PRC=item_price,
        BILLD_GOODS_NUM=quantity,
        BILLD_AMT=item_amount,
        BILLD_AMT_VAT=item_vat_amount,
        BILLD_STATUS='active' # Or some other status
    )

    # Update BillHeader totals
    bill_header.BILLH_AMT = (bill_header.BILLH_AMT or 0) + item_amount
    bill_header.BILLH_AMT_VAT = (bill_header.BILLH_AMT_VAT or 0) + item_vat_amount
    bill_header.BILLH_TOTAMT = bill_header.BILLH_AMT + bill_header.BILLH_AMT_VAT # Simple total, no discount yet

    try:
        db.session.add(new_bill_detail)
        db.session.commit()
        
        # Update control table today's amount
        control_record = Control.query.filter_by(COMP_ID=bill_comp_id, PC_ID=DEFAULT_PC_ID).first()
        if control_record:
            control_record.TODAY_AMT = (control_record.TODAY_AMT or 0) + item_amount
            control_record.ACCU_AMT = (control_record.ACCU_AMT or 0) + item_amount
            db.session.commit()

        return jsonify({
            "message": "Item added to bill successfully",
            "bill_detail": {
                "BILLD_LINE": new_bill_detail.BILLD_LINE,
                "BILLD_GOODS_ID": new_bill_detail.BILLD_GOODS_ID,
                "BILLD_GOODS_PRC": float(new_bill_detail.BILLD_GOODS_PRC),
                "BILLD_GOODS_NUM": new_bill_detail.BILLD_GOODS_NUM,
                "BILLD_AMT": float(new_bill_detail.BILLD_AMT)
            },
            "updated_bill_header_totals": {
                "BILLH_AMT": float(bill_header.BILLH_AMT),
                "BILLH_AMT_VAT": float(bill_header.BILLH_AMT_VAT),
                "BILLH_TOTAMT": float(bill_header.BILLH_TOTAMT)
            }
        }), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to add item to bill", "error": str(e)}), 500


@sale_bp.route('/pay_bill', methods=['POST'])
def mark_bill_paid():
    current_user = get_current_user_placeholder() # Simulated authentication
    if not current_user:
        return jsonify({"message": "Authentication required"}), 401

    data = request.get_json()
    required_fields = ['BILLH_COMP_ID', 'BILLH_NO', 'BILLH_TOTPAY']
    if not all(field in data for field in required_fields):
        return jsonify({"message": "Missing required fields"}), 400

    bill_comp_id = data.get('BILLH_COMP_ID')
    bill_no = data.get('BILLH_NO')
    amount_paid = data.get('BILLH_TOTPAY')

    try:
        amount_paid = float(amount_paid)
    except ValueError:
        return jsonify({"message": "Invalid amount_paid format"}), 400

    bill_header = BillHeader.query.filter_by(BILLH_COMP_ID=bill_comp_id, BILLH_NO=bill_no).first()
    if not bill_header:
        return jsonify({"message": "Bill header not found"}), 404
    
    if bill_header.BILLH_STATUS == 'paid':
        return jsonify({"message": "Bill is already paid"}), 400
    
    # Basic check: amount paid should ideally match total amount
    # For simplicity, we are just marking it paid with the amount provided.
    # if amount_paid < bill_header.BILLH_TOTAMT:
    #     return jsonify({"message": f"Amount paid ({amount_paid}) is less than total amount ({bill_header.BILLH_TOTAMT})"}), 400


    bill_header.BILLH_STATUS = 'paid'
    bill_header.BILLH_TOTPAY = amount_paid
    # Potentially set BILLH_PAYDATE = datetime.utcnow() if there's such a field
    
    try:
        db.session.commit()
        return jsonify({
            "message": "Bill marked as paid successfully",
            "bill_header": {
                "BILLH_COMP_ID": bill_header.BILLH_COMP_ID,
                "BILLH_NO": bill_header.BILLH_NO,
                "BILLH_STATUS": bill_header.BILLH_STATUS,
                "BILLH_TOTPAY": float(bill_header.BILLH_TOTPAY),
                "BILLH_TOTAMT": float(bill_header.BILLH_TOTAMT)
            }
        }), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to mark bill as paid", "error": str(e)}), 500
