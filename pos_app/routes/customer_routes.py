from flask import Blueprint, request, jsonify
from pos_app.models import Customer, db # Assuming models.py is in pos_app
from sqlalchemy import or_

customer_bp = Blueprint('customer_bp', __name__, url_prefix='/customers')

@customer_bp.route('/search', methods=['GET'])
def search_customers():
    search_term = request.args.get('search_term', None)
    
    if not search_term:
        return jsonify({"message": "Missing search_term parameter"}), 400
        
    query = Customer.query
    
    # Search by CUST_ID (exact match) or CUST_NAME (partial, case-insensitive)
    search_pattern = f"%{search_term}%"
    query = query.filter(
        or_(
            Customer.CUST_ID == search_term,
            Customer.CUST_NAME.ilike(search_pattern)
        )
    )
    
    customers = query.all()
    
    output = []
    for customer in customers:
        customer_data = {
            "CUST_ID": customer.CUST_ID,
            "CUST_NAME": customer.CUST_NAME
        }
        output.append(customer_data)
        
    if not output:
        return jsonify({"message": "No customers found"}), 404
        
    return jsonify(output), 200

@customer_bp.route('', methods=['POST'])
def create_customer():
    data = request.get_json()
    
    if not data or not data.get('CUST_ID') or not data.get('CUST_NAME'):
        return jsonify({"message": "Missing CUST_ID or CUST_NAME"}), 400
        
    cust_id = data.get('CUST_ID')
    cust_name = data.get('CUST_NAME')
    
    # Check if customer already exists
    if Customer.query.get(cust_id):
        return jsonify({"message": f"Customer with CUST_ID '{cust_id}' already exists"}), 409 # 409 Conflict
        
    new_customer = Customer(CUST_ID=cust_id, CUST_NAME=cust_name)
    
    try:
        db.session.add(new_customer)
        db.session.commit()
        customer_data = {
            "CUST_ID": new_customer.CUST_ID,
            "CUST_NAME": new_customer.CUST_NAME
        }
        return jsonify({"message": "Customer created successfully", "customer": customer_data}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": "Failed to create customer", "error": str(e)}), 500
