import pytest
import json

def test_list_all_products(client, seed_data):
    """Test fetching all products when some products exist."""
    # seed_data fixture ensures products TESTPROD001 and TESTPROD002 are in the DB
    
    response = client.get('/products')
    assert response.status_code == 200
    data = response.get_json()
    
    assert isinstance(data, list)
    assert len(data) >= 2 # Expecting at least the two seeded products

    # Check for one of the seeded products
    found_prod1 = any(p['FG_ID'] == 'TESTPROD001' for p in data)
    found_prod2 = any(p['FG_ID'] == 'TESTPROD002' for p in data)
    assert found_prod1, "TESTPROD001 not found in product list"
    assert found_prod2, "TESTPROD002 not found in product list"

    for product in data:
        assert 'FG_ID' in product
        assert 'FG_SHORT' in product
        assert 'FG_PRICE' in product


def test_search_product_by_full_name(client, seed_data):
    """Test searching for a product by its full short name."""
    search_name = "Test Product 1" # From seed_data
    expected_id = "TESTPROD001"

    response = client.get(f'/products?search_term={search_name}')
    assert response.status_code == 200
    data = response.get_json()
    
    assert isinstance(data, list)
    assert len(data) >= 1
    
    found_product = None
    for p in data:
        if p['FG_ID'] == expected_id:
            found_product = p
            break
    
    assert found_product is not None, f"Product with ID {expected_id} not found in search results for '{search_name}'"
    assert found_product['FG_SHORT'] == search_name
    assert found_product['FG_PRICE'] == 10.99


def test_search_product_by_partial_name(client, seed_data):
    """Test searching for products by a partial name."""
    search_term = "Product" # Should match both "Test Product 1" and "Another Product"
    
    response = client.get(f'/products?search_term={search_term}')
    assert response.status_code == 200
    data = response.get_json()
    
    assert isinstance(data, list)
    assert len(data) >= 2 # Both seeded products should match
    
    ids_found = {p['FG_ID'] for p in data}
    assert 'TESTPROD001' in ids_found
    assert 'TESTPROD002' in ids_found


def test_search_product_no_results(client, seed_data):
    """Test searching for a product that does not exist."""
    search_term = "NonExistentProductXYZ"
    
    response = client.get(f'/products?search_term={search_term}')
    assert response.status_code == 200 # API returns 200 with empty list for no results
    data = response.get_json()
    
    assert isinstance(data, list)
    assert len(data) == 0


def test_list_products_empty_search_term(client, seed_data):
    """Test that an empty search term returns all products."""
    response_all = client.get('/products')
    assert response_all.status_code == 200
    all_products_data = response_all.get_json()

    response_empty_search = client.get('/products?search_term=')
    assert response_empty_search.status_code == 200
    empty_search_data = response_empty_search.get_json()

    assert len(empty_search_data) == len(all_products_data)
    # Basic check if content seems similar (order might differ)
    assert sorted([p['FG_ID'] for p in empty_search_data]) == sorted([p['FG_ID'] for p in all_products_data])
