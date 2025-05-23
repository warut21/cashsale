import pytest
from pos_app import create_app, db as _db # _db to avoid conflict with fixture

@pytest.fixture(scope='session')
def app():
    """
    Creates a Flask application instance for the test session.
    The configuration is set to 'TESTING'.
    """
    # Create an app instance using the factory
    flask_app = create_app() 
    flask_app.config['TESTING'] = True
    # SQLALCHEMY_DATABASE_URI is already set by Config, assuming it points to py_pos_db
    # If a separate test DB (e.g., SQLite in-memory) was desired, it would be configured here:
    # flask_app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    # flask_app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    return flask_app


@pytest.fixture(scope='session')
def db(app):
    """
    Session-wide database fixture.
    Ensures all tables are created.
    Provides the database instance.
    """
    with app.app_context():
        # Ensure all tables are created. If they already exist, this does nothing.
        _db.create_all() 
        
        # The get_current_user_placeholder in auth_routes might try to create
        # 'DEFAULT_COMP' and 'S001' user. Let's ensure it can happen here or
        # handle it in tests that rely on it.
        # For instance, pre-creating the 'DEFAULT_COMP' company can be done here.
        from pos_app.models import Company, SalesPerson
        default_company = Company.query.get('DEFAULT_COMP')
        if not default_company:
            default_company = Company(COMP_ID='DEFAULT_COMP', COMP_NAME='Default Test Company')
            _db.session.add(default_company)
            _db.session.commit() # Commit it so SalesPerson can link to it

        default_salesperson = SalesPerson.query.filter_by(COMP_ID='DEFAULT_COMP', SALES_ID='S001').first()
        if not default_salesperson:
            # This mimics what get_current_user_placeholder does, ensuring it's available
            # even if no API call has triggered its creation yet.
            sp = SalesPerson(COMP_ID='DEFAULT_COMP', SALES_ID='S001', SALES_NAME='Test User', SALES_PASS='password')
            _db.session.add(sp)
            _db.session.commit()

        yield _db

        # Teardown: Drop all tables after the test session to clean up.
        # This makes tests idempotent if they run on a dedicated test database.
        # If running on shared py_pos_db, this might be too destructive.
        # For now, as per instructions, using existing py_pos_db.
        # Let's clear data from specific tables used in tests instead of dropping all.
        # Or, for this exercise, we might not clean up automatically to inspect data after tests.
        # If full cleanup is needed:
        # _db.session.remove()
        # _db.drop_all()
        # For now, no automatic drop_all() to preserve py_pos_db state based on instructions.
        # Test-specific cleanup should be handled in tests if needed.


@pytest.fixture()
def client(app, db): # Depend on db to ensure it's set up
    """
    Provides a Flask test client for making requests to the application.
    This fixture has function scope, so a new client is created for each test.
    """
    with app.test_client() as client:
        with app.app_context(): # Ensure operations within client usage have app context
            yield client
            # Clean up session after each test to avoid interference
            db.session.remove() 
            # If we want to clear specific tables after each test:
            # for table in reversed(db.metadata.sorted_tables):
            #     db.session.execute(table.delete())
            # db.session.commit()


# Helper fixture to clear specific tables for test isolation if needed
@pytest.fixture(scope='function')
def clear_tables(db):
    """Clears data from tables that are typically modified during tests."""
    yield # Test runs here
    # Teardown: clear data from these tables
    # Order matters due to foreign key constraints
    tables_to_clear = [
        'BILL_DETAIL', 'BILL_PROMO', 'BILL_HEAD', 
        'CONTROL', 'CUSTOMER', 'FINISH_GOODS', 
        'PROMO_DETAIL', 'PROMO_HEAD',
        # 'SALESMAN', 'COMPANY', 'PRODGROUP', 'UNITS' are more like setup data
        # Be careful about clearing SALESMAN if default user is needed across tests
        # For now, keeping it simple, focusing on transactional data.
    ]
    with db.engine.connect() as connection:
        transaction = connection.begin()
        for table_name in tables_to_clear:
            if table_name in db.metadata.tables: # Check if table exists
                connection.execute(db.metadata.tables[table_name].delete())
        transaction.commit()
    db.session.commit() # Ensure session reflects the changes.

# Fixture to pre-populate some data for testing, e.g., products
@pytest.fixture(scope='function')
def seed_data(db):
    from pos_app.models import ProdGroup, Unit, FinishGood

    # Ensure ProdGroup and Unit exist
    pg1 = ProdGroup.query.get('PG001')
    if not pg1:
        pg1 = ProdGroup(GRP_ID='PG001', GRP_NT='Test Group 1')
        db.session.add(pg1)
    
    u1 = Unit.query.get('UNIT01')
    if not u1:
        u1 = Unit(UNITS_ID='UNIT01', UNITS_NAME='Piece')
        db.session.add(u1)
    db.session.commit()

    # Add sample products
    p1_data = {'FG_ID': 'TESTPROD001', 'FG_SHORT': 'Test Product 1', 'FG_PRICE': 10.99, 'FG_GRP': 'PG001', 'FG_UNITS': 'UNIT01'}
    p2_data = {'FG_ID': 'TESTPROD002', 'FG_SHORT': 'Another Product', 'FG_PRICE': 5.00, 'FG_GRP': 'PG001', 'FG_UNITS': 'UNIT01'}
    
    p1 = FinishGood.query.get(p1_data['FG_ID'])
    if not p1:
        p1 = FinishGood(**p1_data)
        db.session.add(p1)

    p2 = FinishGood.query.get(p2_data['FG_ID'])
    if not p2:
        p2 = FinishGood(**p2_data)
        db.session.add(p2)
        
    db.session.commit()
    return [p1_data, p2_data]
