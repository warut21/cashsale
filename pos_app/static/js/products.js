document.addEventListener('DOMContentLoaded', function () {
    const productSearchTermInput = document.getElementById('productSearchTerm');
    const searchProductBtn = document.getElementById('searchProductBtn');
    const productSearchMessageDiv = document.getElementById('productSearchMessage');
    const productListUl = document.getElementById('productList');

    // --- Helper Functions ---
    function displayMessage(element, message, type = 'danger') {
        if (!element) return;
        element.innerHTML = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                             </div>`;
    }

    function clearMessage(element) {
        if (!element) return;
        element.innerHTML = '';
    }

    async function apiCall(endpoint, method = 'GET', body = null) {
        const options = {
            method,
            headers: { 'Content-Type': 'application/json' },
        };
        if (body) {
            options.body = JSON.stringify(body);
        }
        try {
            const response = await fetch(endpoint, options);
            const contentType = response.headers.get("content-type");
            if (contentType && contentType.indexOf("application/json") !== -1) {
                const data = await response.json();
                 if (!response.ok) {
                    return { error: true, message: data.message || `Error: ${response.status}`, status: response.status, data: data };
                }
                return { error: false, data: data, status: response.status };
            } else {
                const textData = await response.text();
                return { error: true, message: `Non-JSON response: ${textData}`, status: response.status, data: textData };
            }
        } catch (error) {
            console.error(`API call to ${endpoint} failed:`, error);
            return { error: true, message: 'Network error or server unavailable.', status: null, data: null };
        }
    }

    function renderProducts(products) {
        if (!productListUl) return;
        productListUl.innerHTML = ''; // Clear current list

        if (!products || products.length === 0) {
            productListUl.innerHTML = '<li class="list-group-item text-muted">No products found.</li>';
            return;
        }

        products.forEach(product => {
            const li = document.createElement('li');
            li.className = 'list-group-item';
            li.innerHTML = `
                <div class="d-flex w-100 justify-content-between">
                    <h6 class="mb-1">${product.FG_SHORT || 'N/A'} (ID: ${product.FG_ID})</h6>
                    <small class="text-success">$${parseFloat(product.FG_PRICE).toFixed(2)}</small>
                </div>
                <p class="mb-1">${product.FG_DES || 'No description available.'}</p>
                <small class="text-muted">Group: ${product.FG_GRP || 'N/A'} | Units: ${product.FG_UNITS || 'N/A'} | Barcode: ${product.FG_BAR_CODE || 'N/A'}</small>
            `;
            productListUl.appendChild(li);
        });
    }

    // --- Event Handlers ---
    async function handleSearchProducts() {
        clearMessage(productSearchMessageDiv);
        const searchTerm = productSearchTermInput.value.trim();

        if (!searchTerm) {
            // Optionally, load all products if search term is empty
            // For now, just clear list or show prompt.
            productListUl.innerHTML = '<li class="list-group-item text-muted">Enter a search term to display products.</li>';
            // displayMessage(productSearchMessageDiv, 'Please enter a search term.', 'info');
            return;
        }
        
        displayMessage(productSearchMessageDiv, 'Searching products...', 'info');
        const result = await apiCall(`/api/products?search_term=${encodeURIComponent(searchTerm)}`); // Changed URL

        if (result.error) {
            renderProducts([]); // Clears list and shows "No products found" via renderProducts logic
            displayMessage(productSearchMessageDiv, result.message || 'Failed to search products.');
        } else {
            clearMessage(productSearchMessageDiv); // Clear "Searching..." message
            renderProducts(result.data);
        }
    }

    // --- Attach Event Listeners ---
    if (searchProductBtn) {
        searchProductBtn.addEventListener('click', handleSearchProducts);
    }
    if (productSearchTermInput) { // Optional: search on enter
        productSearchTermInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                handleSearchProducts();
            }
        });
    }

    // Initial load (optional - can display all products or a message)
    // To load all products initially:
    // handleSearchProducts(); // Call with empty search term if API supports it, or specific "all" endpoint
    // Or, if API returns all for empty search term, this would work:
    // productSearchTermInput.value = ''; 
    // handleSearchProducts();
    if (productListUl) productListUl.innerHTML = '<li class="list-group-item text-muted">Enter a search term to see product details.</li>';
});
