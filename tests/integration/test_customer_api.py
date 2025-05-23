import pytest
import json

# Use a unique customer ID for each test run or ensure cleanup
# For this test, we'll use specific IDs and rely on potential cleanup or test isolation.
NEW_CUST_ID = "TESTCUST001"
NEW_CUST_NAME = "Test Customer One"

@pytest.fixture(autouse=True)
def setup_teardown_customer(db):
    """Fixture to ensure the test customer does not exist before a test and is cleaned up after."""
    # Setup: Ensure customer does not exist
    from pos_app.models import Customer
    cust = Customer.query.get(NEW_CUST_ID)
    if cust:
        db.session.delete(cust)
        db.session.commit()
    
    yield # Test runs here
    
    # Teardown: Remove the customer if it was created
    cust = Customer.query.get(NEW_CUST_ID)
    if cust:
        db.session.delete(cust)
        db.session.commit()


def test_create_new_customer(client):
    """Test creating a new customer."""
    response = client.post('/customers', json={
        'CUST_ID': NEW_CUST_ID,
        'CUST_NAME': NEW_CUST_NAME
    })
    assert response.status_code == 201
    data = response.get_json()
    assert data['message'] == 'Customer created successfully'
    assert data['customer']['CUST_ID'] == NEW_CUST_ID
    assert data['customer']['CUST_NAME'] == NEW_CUST_NAME

    # Verify customer is in DB (optional, API response is primary check)
    from pos_app.models import Customer
    cust = Customer.query.get(NEW_CUST_ID)
    assert cust is not None
    assert cust.CUST_NAME == NEW_CUST_NAME


def test_create_existing_customer_fails(client):
    """Test that creating a customer with an existing CUST_ID fails."""
    # First, create the customer
    client.post('/customers', json={'CUST_ID': NEW_CUST_ID, 'CUST_NAME': NEW_CUST_NAME})
    
    # Attempt to create it again
    response = client.post('/customers', json={
        'CUST_ID': NEW_CUST_ID,
        'CUST_NAME': "Another Name"
    })
    assert response.status_code == 409 # Conflict
    data = response.get_json()
    assert f"Customer with CUST_ID '{NEW_CUST_ID}' already exists" in data['message']


def test_create_customer_missing_fields(client):
    """Test creating a customer with missing fields."""
    response = client.post('/customers', json={'CUST_ID': 'SomeID'}) # Missing CUST_NAME
    assert response.status_code == 400
    data = response.get_json()
    assert 'Missing CUST_ID or CUST_NAME' in data['message']

    response = client.post('/customers', json={'CUST_NAME': 'Some Name'}) # Missing CUST_ID
    assert response.status_code == 400
    data = response.get_json()
    assert 'Missing CUST_ID or CUST_NAME' in data['message']


def test_search_customer_by_id(client):
    """Test searching for an existing customer by CUST_ID."""
    # Create customer first
    client.post('/customers', json={'CUST_ID': NEW_CUST_ID, 'CUST_NAME': NEW_CUST_NAME})

    response = client.get(f'/customers/search?search_term={NEW_CUST_ID}')
    assert response.status_code == 200
    data = response.get_json()
    assert isinstance(data, list)
    assert len(data) == 1
    assert data[0]['CUST_ID'] == NEW_CUST_ID
    assert data[0]['CUST_NAME'] == NEW_CUST_NAME


def test_search_customer_by_name(client):
    """Test searching for an existing customer by CUST_NAME."""
    # Create customer first
    client.post('/customers', json={'CUST_ID': NEW_CUST_ID, 'CUST_NAME': NEW_CUST_NAME})

    search_query = "Test Customer" # Partial name
    response = client.get(f'/customers/search?search_term={search_query}')
    assert response.status_code == 200
    data = response.get_json()
    assert isinstance(data, list)
    assert len(data) >= 1 # Could be more if other "Test Customer" exists
    
    found = any(c['CUST_ID'] == NEW_CUST_ID and c['CUST_NAME'] == NEW_CUST_NAME for c in data)
    assert found, f"Customer {NEW_CUST_ID} not found in search results for '{search_query}'"


def test_search_customer_not_found(client):
    """Test searching for a customer that does not exist."""
    response = client.get('/customers/search?search_term=NONEXISTENTCUST123')
    assert response.status_code == 404 # As per current customer_routes.py logic
    data = response.get_json()
    assert data['message'] == 'No customers found'

def test_search_customer_missing_search_term(client):
    """Test searching customer with missing search_term parameter."""
    response = client.get('/customers/search')
    assert response.status_code == 400
    data = response.get_json()
    assert data['message'] == 'Missing search_term parameter'
