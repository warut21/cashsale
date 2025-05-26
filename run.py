from pos_app import create_app, db
from pos_app.models import Company, SalesPerson, Control, ProdGroup, Unit, FinishGood # Import models to help with db.create_all() context if needed

# Create the Flask app instance using the factory function
app = create_app()

if __name__ == '__main__':
    # Print registered URL routes
    with app.app_context(): # Ensure we have app context for url_map
        print("\nRegistered URL Routes (from run.py):")
        rules = list(app.url_map.iter_rules())
        if not rules:
            print("No routes registered or url_map not fully populated yet here.")
        else:
            for rule in rules:
                print(f"Endpoint: {rule.endpoint}, Methods: {','.join(rule.methods)}, Path: {str(rule)}")
        print("\n")

    # The following block is useful if you want to ensure tables are created
    # when run.py is executed directly, especially for the first time or in dev.
    # For production, migrations (e.g. Flask-Migrate) are a better approach.
    with app.app_context():
        # Create database tables if they don't exist
        # db.create_all() will not recreate tables if they already exist.
        db.create_all()

        # Initialize default data if necessary (idempotently)
        # This ensures the 'DEFAULT_COMP' and 'S001' user exist for the
        # get_current_user_placeholder in auth_routes, which is used by sales_routes.
        # This logic is similar to what's in tests/conftest.py's db fixture.

        default_company_id = 'DEFAULT_COMP'
        default_pc_id = 'DEFAULT_PC' # As used in sale_routes.py
        default_sales_id = 'S001'
        default_sales_pass = 'password'
        default_sales_name = 'Default SalesUser'

        # Ensure default company exists
        company = Company.query.get(default_company_id)
        if not company:
            company = Company(COMP_ID=default_company_id, COMP_NAME='Default Company Inc.')
            db.session.add(company)
            print(f"INFO: Created default company '{default_company_id}'.")

        # Ensure default salesperson exists
        sales_person = SalesPerson.query.filter_by(COMP_ID=default_company_id, SALES_ID=default_sales_id).first()
        if not sales_person:
            sales_person = SalesPerson(
                COMP_ID=default_company_id, 
                SALES_ID=default_sales_id, 
                SALES_NAME=default_sales_name,
                SALES_PASS=default_sales_pass, # In a real app, hash this password
                ROLE='Cashier'
            )
            db.session.add(sales_person)
            print(f"INFO: Created default salesperson '{default_sales_id}' for company '{default_company_id}'.")

        # Ensure default Control record exists for bill generation
        control_record = Control.query.filter_by(COMP_ID=default_company_id, PC_ID=default_pc_id).first()
        if not control_record:
            control_record = Control(
                COMP_ID=default_company_id,
                PC_ID=default_pc_id,
                PC_NAME="Main POS Terminal",
                STDATE=db.func.now(), # Use database's now function or Python's datetime
                SALESDATE=db.func.now(),
                CUR_BILL_NO="000000", # Initial value, generate_new_bill_no will increment from this
                START_BILL_NO="000001",
                ACCU_AMT=0, ACCU_BILL=0, TODAY_AMT=0, TODAY_BILL=0,
                ACCU_AMT_C=0, ACCU_BILL_C=0, TODAY_AMT_C=0, TODAY_BILL_C=0
            )
            db.session.add(control_record)
            print(f"INFO: Created default control record for '{default_company_id}/{default_pc_id}'.")

        # Seed some basic ProdGroup and Units if they don't exist, for FinishGoods
        pg_id = 'PG_DEFAULT'
        unit_id = 'UNIT_DEFAULT'
        
        prod_group = ProdGroup.query.get(pg_id)
        if not prod_group:
            prod_group = ProdGroup(GRP_ID=pg_id, GRP_NT='Default Product Group')
            db.session.add(prod_group)
            print(f"INFO: Created default product group '{pg_id}'.")

        unit = Unit.query.get(unit_id)
        if not unit:
            unit = Unit(UNITS_ID=unit_id, UNITS_NAME='Default Unit')
            db.session.add(unit)
            print(f"INFO: Created default unit '{unit_id}'.")
            
        # Seed a sample product if it doesn't exist
        sample_product_id = 'SAMPLEPROD001'
        sample_product = FinishGood.query.get(sample_product_id)
        if not sample_product:
            sample_product = FinishGood(
                FG_ID=sample_product_id,
                FG_SHORT='Sample Product',
                FG_DES='A sample product for testing the POS.',
                FG_PRICE=19.99,
                FG_COST=10.00,
                FG_GRP=pg_id,
                FG_UNITS=unit_id,
                FG_BAR_CODE='1234567890123'
            )
            db.session.add(sample_product)
            print(f"INFO: Created sample product '{sample_product_id}'.")


        try:
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            print(f"ERROR: Could not initialize default data: {e}")


    # Run the Flask development server
    # Host '0.0.0.0' makes it accessible externally (e.g., from host machine if in a container/VM)
    # Debug=True is convenient for development but should be False in production.
    app.run(host='0.0.0.0', port=5000, debug=True)
