import pytest
import json

# Default credentials for the test user created in conftest.py or by get_current_user_placeholder
DEFAULT_SALES_ID = 'S001'
DEFAULT_PASSWORD = 'password'
DEFAULT_COMP_ID = 'DEFAULT_COMP' # Assuming this is the company for the default user

def test_login_success(client):
    """Test successful login with default credentials."""
    response = client.post('/auth/login', json={
        'SALES_ID': DEFAULT_SALES_ID,
        'SALES_PASS': DEFAULT_PASSWORD
        # If your login endpoint strictly requires COMP_ID, add it here:
        # 'COMP_ID': DEFAULT_COMP_ID 
    })
    assert response.status_code == 200
    data = response.get_json()
    assert data['message'] == 'Login successful'
    assert data['user']['SALES_ID'] == DEFAULT_SALES_ID
    assert data['user']['COMP_ID'] == DEFAULT_COMP_ID # Ensure COMP_ID is returned

def test_login_failure_wrong_password(client):
    """Test login failure with incorrect password."""
    response = client.post('/auth/login', json={
        'SALES_ID': DEFAULT_SALES_ID,
        'SALES_PASS': 'wrongpassword'
    })
    assert response.status_code == 401
    data = response.get_json()
    assert data['message'] == 'Invalid SALES_ID or password'

def test_login_failure_wrong_sales_id(client):
    """Test login failure with non-existent sales ID."""
    response = client.post('/auth/login', json={
        'SALES_ID': 'S999',
        'SALES_PASS': 'password'
    })
    assert response.status_code == 401
    data = response.get_json()
    assert data['message'] == 'Invalid SALES_ID or password'

def test_login_failure_missing_fields(client):
    """Test login failure with missing fields."""
    response = client.post('/auth/login', json={
        'SALES_ID': DEFAULT_SALES_ID
        # SALES_PASS is missing
    })
    assert response.status_code == 400
    data = response.get_json()
    assert 'Missing SALES_ID or SALES_PASS' in data['message']

    response = client.post('/auth/login', json={
        'SALES_PASS': 'password'
        # SALES_ID is missing
    })
    assert response.status_code == 400
    data = response.get_json()
    assert 'Missing SALES_ID or SALES_PASS' in data['message']

def test_logout(client):
    """Test logout (placeholder)."""
    # First, "login" - although stateless for this simple auth, good practice
    client.post('/auth/login', json={'SALES_ID': DEFAULT_SALES_ID, 'SALES_PASS': DEFAULT_PASSWORD})
    
    response = client.post('/auth/logout')
    assert response.status_code == 200
    data = response.get_json()
    assert data['message'] == 'Logout successful (placeholder)'
