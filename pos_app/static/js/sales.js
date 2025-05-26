document.addEventListener('DOMContentLoaded', function () {
    // --- State Variables ---
    let currentUser = null;
    let currentBill = null; // { COMP_ID, BILLH_NO, STATUS, items: [], totals: {} }
    let selectedProduct = null; // { FG_ID, FG_PRICE, FG_SHORT }
    let selectedCustomer = null; // { CUST_ID, CUST_NAME }

    // --- DOM Elements ---
    const loggedInUserSpan = document.getElementById('loggedInUser');
    const logoutBtn = document.getElementById('logoutBtn');

    const customerSearchTermInput = document.getElementById('customerSearchTerm');
    const searchCustomerBtn = document.getElementById('searchCustomerBtn');
    const customerSearchResultsUl = document.getElementById('customerSearchResults');
    const currentCustomerDisplayDiv = document.getElementById('currentCustomerDisplay');
    // Removed: newCustomerForm, newCustIdInput, newCustNameInput

    const productSearchTermInput = document.getElementById('productSearchTerm');
    const searchProductBtn = document.getElementById('searchProductBtn');
    const productSearchResultsUl = document.getElementById('productSearchResults');
    const selectedProductDisplayDiv = document.getElementById('selectedProductDisplay');
    const itemQuantityInput = document.getElementById('itemQuantity');
    const addItemToBillBtn = document.getElementById('addItemToBillBtn');

    const currentBillIdDisplaySpan = document.getElementById('currentBillIdDisplay');
    const currentBillStatusDisplaySpan = document.getElementById('currentBillStatusDisplay');
    const billItemsListUl = document.getElementById('billItemsList');
    const billTotalsDisplayDiv = document.getElementById('billTotalsDisplay');

    const newBillBtn = document.getElementById('newBillBtn');
    const payBillBtn = document.getElementById('payBillBtn');
    const salesMessageAreaDiv = document.getElementById('salesMessageArea');

    // --- Initialization ---
    function initializePage() {
        const storedUser = localStorage.getItem('currentUser');
        if (!storedUser) {
            window.location.href = '/login';
            return;
        }
        currentUser = JSON.parse(storedUser);
        if (loggedInUserSpan) {
            loggedInUserSpan.textContent = `${currentUser.SALES_NAME} (${currentUser.SALES_ID})`;
        }
        resetSalesPage(); // Initialize displays
        attachEventListeners();
    }

    function resetSalesPage() {
        currentBill = null;
        selectedProduct = null;
        selectedCustomer = null;
        
        if (currentBillIdDisplaySpan) currentBillIdDisplaySpan.textContent = 'N/A';
        if (currentBillStatusDisplaySpan) currentBillStatusDisplaySpan.textContent = 'N/A';
        if (billItemsListUl) billItemsListUl.innerHTML = '<li class="list-group-item text-muted">No items yet.</li>';
        if (billTotalsDisplayDiv) billTotalsDisplayDiv.innerHTML = '<p>Subtotal: $0.00</p><p>VAT: $0.00</p><p>Total: $0.00</p>';
        if (productSearchResultsUl) productSearchResultsUl.innerHTML = '';
        if (customerSearchResultsUl) customerSearchResultsUl.innerHTML = '';
        if (selectedProductDisplayDiv) selectedProductDisplayDiv.textContent = 'Select a product from search results.';
        if (currentCustomerDisplayDiv) currentCustomerDisplayDiv.textContent = 'None';
        if (addItemToBillBtn) addItemToBillBtn.disabled = true;
        if (payBillBtn) payBillBtn.disabled = true;
        if (salesMessageAreaDiv) salesMessageAreaDiv.innerHTML = '';
        if (itemQuantityInput) itemQuantityInput.value = '1';
    }

    // --- Helper Functions ---
    function displayMessage(message, type = 'error') { // Changed 'error' to 'danger' for Bootstrap alert consistency
        if (!salesMessageAreaDiv) return;
        // Using Bootstrap alert styling for messages
        const alertType = type === 'success' ? 'alert-success' : 'alert-danger'; // Default to danger for 'error' or other
        salesMessageAreaDiv.innerHTML = `<div class="alert ${alertType} alert-dismissible fade show" role="alert">
                                            ${message}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                         </div>`;
        // salesMessageAreaDiv.className = `message-area ${type}`; // Old way
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
            const data = await response.json(); // Assume JSON response
            if (!response.ok) {
                // Display message using the new displayMessage function for consistency
                displayMessage(data.message || `Error: ${response.status}`, 'danger');
                return null; 
            }
            return data;
        } catch (error) {
            console.error(`API call to ${endpoint} failed:`, error);
            displayMessage('Network error or server unavailable.', 'danger');
            return null;
        }
    }
    
    function updateBillDisplay() {
        if (!currentBill) {
            resetSalesPage(); 
            return;
        }
        if (currentBillIdDisplaySpan) currentBillIdDisplaySpan.textContent = `${currentBill.BILLH_COMP_ID}/${currentBill.BILLH_NO}`;
        if (currentBillStatusDisplaySpan) currentBillStatusDisplaySpan.textContent = currentBill.STATUS;
        
        if (billItemsListUl) {
            billItemsListUl.innerHTML = ''; 
            if (currentBill.items.length === 0) {
                billItemsListUl.innerHTML = '<li class="list-group-item text-muted">No items yet.</li>';
            } else {
                currentBill.items.forEach(item => {
                    const li = document.createElement('li');
                    li.className = 'list-group-item';
                    li.textContent = `L${item.BILLD_LINE}: ${item.product_name || item.BILLD_GOODS_ID} - Qty: ${item.BILLD_GOODS_NUM} @ $${parseFloat(item.BILLD_GOODS_PRC).toFixed(2)} = $${parseFloat(item.BILLD_AMT).toFixed(2)}`;
                    billItemsListUl.appendChild(li);
                });
            }
        }
        
        if (billTotalsDisplayDiv) {
             billTotalsDisplayDiv.innerHTML = `
                <p class="mb-1">Subtotal: $${parseFloat(currentBill.totals.BILLH_AMT || 0).toFixed(2)}</p>
                <p class="mb-1">VAT: $${parseFloat(currentBill.totals.BILLH_AMT_VAT || 0).toFixed(2)}</p>
                <p class="fw-bold mb-0">Total: $${parseFloat(currentBill.totals.BILLH_TOTAMT || 0).toFixed(2)}</strong></p>
            `;
        }
        if (payBillBtn) payBillBtn.disabled = currentBill.STATUS !== 'pending';
    }

    // --- Event Handlers ---
    function handleLogout() {
        localStorage.removeItem('currentUser');
        window.location.href = '/login';
    }

    async function handleNewBill() {
        displayMessage('Initiating new bill...', 'info'); // Use 'info' for non-error/success
        const data = await apiCall('/api/sales/new_bill', 'POST'); // Changed URL
        if (data && data.bill_header) {
            currentBill = {
                BILLH_COMP_ID: data.bill_header.BILLH_COMP_ID,
                BILLH_NO: data.bill_header.BILLH_NO,
                STATUS: data.bill_header.BILLH_STATUS,
                items: [],
                totals: { BILLH_AMT: 0, BILLH_AMT_VAT: 0, BILLH_TOTAMT: 0 } 
            };
            updateBillDisplay();
            displayMessage('New bill initiated successfully.', 'success');
        } else {
            // displayMessage is called by apiCall on error
        }
    }

    async function handleSearchProducts() {
        const searchTerm = productSearchTermInput.value.trim();
        if (!searchTerm) {
            productSearchResultsUl.innerHTML = '';
            return;
        }
        displayMessage('Searching products...', 'info');
        const products = await apiCall(`/api/products?search_term=${encodeURIComponent(searchTerm)}`); // Verified URL is correct
        productSearchResultsUl.innerHTML = '';
        if (products && products.length > 0) { // apiCall now returns data directly on success
            products.forEach(product => {
                const li = document.createElement('li');
                li.className = 'list-group-item list-group-item-action'; // Bootstrap class
                li.textContent = `${product.FG_SHORT} (ID: ${product.FG_ID}) - $${parseFloat(product.FG_PRICE).toFixed(2)}`;
                li.dataset.productId = product.FG_ID;
                li.dataset.productPrice = product.FG_PRICE;
                li.dataset.productName = product.FG_SHORT;
                li.addEventListener('click', () => {
                    selectedProduct = { 
                        FG_ID: product.FG_ID, 
                        FG_PRICE: parseFloat(product.FG_PRICE),
                        FG_SHORT: product.FG_SHORT
                    };
                    if (selectedProductDisplayDiv) selectedProductDisplayDiv.textContent = `Selected: ${product.FG_SHORT} ($${parseFloat(product.FG_PRICE).toFixed(2)})`;
                    if (addItemToBillBtn) addItemToBillBtn.disabled = false;
                    if (productSearchResultsUl) productSearchResultsUl.innerHTML = ''; 
                });
                productSearchResultsUl.appendChild(li);
            });
            // Clear "Searching..." message if results are found
            if (salesMessageAreaDiv.textContent === 'Searching products...') salesMessageAreaDiv.innerHTML = '';
        } else if (products && products.length === 0) {
            displayMessage('No products found matching your search.', 'info');
        }
        // If apiCall returned null, it already displayed an error.
    }
    
    async function handleAddItemToBill() {
        if (!currentBill || currentBill.STATUS !== 'pending') {
            displayMessage('Cannot add items. No active pending bill.', 'danger');
            return;
        }
        if (!selectedProduct) {
            displayMessage('Please select a product first.', 'danger');
            return;
        }
        const quantity = parseInt(itemQuantityInput.value);
        if (isNaN(quantity) || quantity <= 0) {
            displayMessage('Please enter a valid quantity.', 'danger');
            return;
        }

        displayMessage('Adding item...', 'info');
        const itemData = {
            BILLH_COMP_ID: currentBill.BILLH_COMP_ID,
            BILLH_NO: currentBill.BILLH_NO,
            BILLD_GOODS_ID: selectedProduct.FG_ID,
            BILLD_GOODS_NUM: quantity
        };
        
        const result = await apiCall('/api/sales/add_item', 'POST', itemData); // Changed URL
        if (result && result.bill_detail) { // apiCall returns data directly
            result.bill_detail.product_name = selectedProduct.FG_SHORT;
            currentBill.items.push(result.bill_detail);
            currentBill.totals = result.updated_bill_header_totals;
            updateBillDisplay();
            displayMessage('Item added successfully.', 'success');
            selectedProduct = null;
            if (selectedProductDisplayDiv) selectedProductDisplayDiv.textContent = 'Select a product from search results.';
            if (addItemToBillBtn) addItemToBillBtn.disabled = true;
            if (itemQuantityInput) itemQuantityInput.value = '1';
        }
        // If apiCall returned null, it already displayed an error.
    }

    async function handleSearchCustomers() {
        const searchTerm = customerSearchTermInput.value.trim();
        if (!searchTerm) {
            customerSearchResultsUl.innerHTML = '';
            return;
        }
        displayMessage('Searching customers...', 'info');
        const customers = await apiCall(`/api/customers/search?search_term=${encodeURIComponent(searchTerm)}`); // Changed URL
        customerSearchResultsUl.innerHTML = '';
        if (customers && customers.length > 0) { // apiCall returns data directly
            customers.forEach(customer => {
                const li = document.createElement('li');
                li.className = 'list-group-item list-group-item-action'; // Bootstrap class
                li.textContent = `${customer.CUST_NAME} (ID: ${customer.CUST_ID})`;
                li.dataset.customerId = customer.CUST_ID;
                li.dataset.customerName = customer.CUST_NAME;
                li.addEventListener('click', () => {
                    selectedCustomer = { CUST_ID: customer.CUST_ID, CUST_NAME: customer.CUST_NAME };
                    if (currentCustomerDisplayDiv) currentCustomerDisplayDiv.textContent = `ID: ${customer.CUST_ID}, Name: ${customer.CUST_NAME}`;
                    if (customerSearchResultsUl) customerSearchResultsUl.innerHTML = ''; 
                    // TODO: Associate customer with currentBill if active.
                    // This would typically involve an API call to update the BillHeader.
                    // E.g., PATCH /sales/bill_header/{comp_id}/{bill_no} with { CUST_ID: customer.CUST_ID }
                    if (currentBill) {
                        currentBill.CUST_ID = customer.CUST_ID; // Local state update
                        displayMessage(`Customer ${customer.CUST_NAME} selected for current bill. (Backend update for bill customer not implemented in this step)`, 'info');
                    }
                });
                customerSearchResultsUl.appendChild(li);
            });
             if (salesMessageAreaDiv.textContent === 'Searching customers...') salesMessageAreaDiv.innerHTML = '';
        } else if (customers && customers.length === 0) {
            displayMessage('No customers found.', 'info');
        }
         // If apiCall returned null, it already displayed an error.
    }
    
    // Removed handleAddCustomer function

    async function handlePayBill() {
        if (!currentBill || currentBill.STATUS !== 'pending') {
            displayMessage('No pending bill to pay or bill already processed.', 'danger');
            return;
        }
        const amountToPay = currentBill.totals.BILLH_TOTAMT; 
        
        displayMessage('Processing payment...', 'info');
        const paymentData = {
            BILLH_COMP_ID: currentBill.BILLH_COMP_ID,
            BILLH_NO: currentBill.BILLH_NO,
            BILLH_TOTPAY: amountToPay 
        };
        const result = await apiCall('/api/sales/pay_bill', 'POST', paymentData); // Changed URL
        if (result && result.bill_header) { // apiCall returns data directly
            currentBill.STATUS = result.bill_header.BILLH_STATUS;
            currentBill.totals.BILLH_TOTPAY = result.bill_header.BILLH_TOTPAY; 
            updateBillDisplay();
            displayMessage('Bill paid successfully.', 'success');
            if (payBillBtn) payBillBtn.disabled = true;
        }
        // If apiCall returned null, it already displayed an error.
    }

    // --- Attach Event Listeners ---
    function attachEventListeners() {
        if (logoutBtn) logoutBtn.addEventListener('click', handleLogout);
        if (newBillBtn) newBillBtn.addEventListener('click', handleNewBill);
        if (searchProductBtn) searchProductBtn.addEventListener('click', handleSearchProducts);
        if (addItemToBillBtn) addItemToBillBtn.addEventListener('click', handleAddItemToBill);
        if (searchCustomerBtn) searchCustomerBtn.addEventListener('click', handleSearchCustomers);
        // Removed: event listener for newCustomerForm
        if (payBillBtn) payBillBtn.addEventListener('click', handlePayBill);
        
        if (productSearchTermInput) productSearchTermInput.addEventListener('keypress', function(e) { if (e.key === 'Enter') handleSearchProducts(); });
        if (customerSearchTermInput) customerSearchTermInput.addEventListener('keypress', function(e) { if (e.key === 'Enter') handleSearchCustomers(); });
    }

    // --- Start the app ---
    initializePage();
});
