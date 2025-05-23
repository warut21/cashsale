from flask import Blueprint, request, jsonify
from pos_app.models import SalesPerson, db # Assuming models.py is in pos_app
# For a real app, you'd use a proper password hashing library like werkzeug.security
# from werkzeug.security import check_password_hash, generate_password_hash

auth_bp = Blueprint('auth_bp', __name__, url_prefix='/auth')

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if not data or not data.get('SALES_ID') or not data.get('SALES_PASS'):
        return jsonify({"message": "Missing SALES_ID or SALES_PASS"}), 400

    sales_id = data.get('SALES_ID')
    password = data.get('SALES_PASS')
    
    # Assuming COMP_ID is also needed for login, or SALES_ID is unique across companies.
    # For now, let's assume SALES_ID is enough to find the user,
    # or a default COMP_ID is implied.
    # If COMP_ID is required from client:
    # comp_id = data.get('COMP_ID')
    # if not comp_id:
    #     return jsonify({"message": "Missing COMP_ID"}), 400
    # sales_person = SalesPerson.query.filter_by(COMP_ID=comp_id, SALES_ID=sales_id).first()

    # Simplified: Querying only by SALES_ID. This might not be unique if multiple companies exist.
    # A more robust login would require COMP_ID.
    sales_person = SalesPerson.query.filter_by(SALES_ID=sales_id).first()

    if sales_person:
        # In a real app, compare hashed passwords:
        # if check_password_hash(sales_person.SALES_PASS, password):
        # For this example, direct comparison (highly insecure, placeholder only)
        if sales_person.SALES_PASS == password:
            # TODO: Implement session/token generation (e.g., Flask-Login, JWT)
            return jsonify({
                "message": "Login successful", 
                "user": {
                    "COMP_ID": sales_person.COMP_ID,
                    "SALES_ID": sales_person.SALES_ID,
                    "SALES_NAME": sales_person.SALES_NAME,
                    "ROLE": sales_person.ROLE
                }
            }), 200
        else:
            return jsonify({"message": "Invalid SALES_ID or password"}), 401
    else:
        return jsonify({"message": "Invalid SALES_ID or password"}), 401

@auth_bp.route('/logout', methods=['POST'])
def logout():
    # TODO: Implement actual session/token invalidation
    return jsonify({"message": "Logout successful (placeholder)"}), 200

# Utility to get current user (placeholder)
# In a real app, this would come from session/token
def get_current_user_placeholder():
    # This is a placeholder. In a real app, you'd get the user from a session or token.
    # For testing, we might assume a default authenticated user.
    # This user should exist in your SALESMAN table.
    # Example: return SalesPerson.query.filter_by(COMP_ID='DEFAULT_COMP', SALES_ID='S001').first()
    # For now, returning a dictionary to simulate a logged-in user's identity
    # This needs to be adapted based on how login is handled for other endpoints.
    # If other endpoints need the actual SalesPerson object, this needs to provide it.
    # For now, let's assume 'DEFAULT_COMP' and 'S001' for testing sale_routes
    user = SalesPerson.query.filter_by(COMP_ID='DEFAULT_COMP', SALES_ID='S001').first()
    if not user:
        # Create a dummy user if not exists for dev purposes - this should NOT be in production
        print("WARN: Creating dummy sales person DEFAULT_COMP/S001 for testing.")
        # First ensure company 'DEFAULT_COMP' exists or create it
        from pos_app.models import Company
        default_company = Company.query.get('DEFAULT_COMP')
        if not default_company:
            default_company = Company(COMP_ID='DEFAULT_COMP', COMP_NAME='Default Company')
            db.session.add(default_company)
            # db.session.commit() # Commit separately or let it commit with salesperson

        user = SalesPerson(COMP_ID='DEFAULT_COMP', SALES_ID='S001', SALES_NAME='Test User', SALES_PASS='password')
        db.session.add(user)
        try:
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            print(f"Error creating dummy user: {e}")
            return None # Cannot proceed if dummy user creation fails
    return user
