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
    const newCustomerForm = document.getElementById('newCustomerForm');
    const newCustIdInput = document.getElementById('newCustId');
    const newCustNameInput = document.getElementById('newCustName');
    // const addCustomerBtn = document.getElementById('addCustomerBtn'); // Handled by form submit

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
        if (billItemsListUl) billItemsListUl.innerHTML = '';
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
    function displayMessage(message, type = 'error') {
        if (!salesMessageAreaDiv) return;
        salesMessageAreaDiv.textContent = message;
        salesMessageAreaDiv.className = `message-area ${type}`; // 'error' or 'success'
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
            const data = await response.json();
            if (!response.ok) {
                displayMessage(data.message || `Error: ${response.status}`);
                return null;
            }
            return data;
        } catch (error) {
            console.error(`API call to ${endpoint} failed:`, error);
            displayMessage('Network error or server unavailable.');
            return null;
        }
    }
    
    function updateBillDisplay() {
        if (!currentBill) {
            resetSalesPage(); // Should clear relevant parts
            return;
        }
        if (currentBillIdDisplaySpan) currentBillIdDisplaySpan.textContent = `${currentBill.BILLH_COMP_ID}/${currentBill.BILLH_NO}`;
        if (currentBillStatusDisplaySpan) currentBillStatusDisplaySpan.textContent = currentBill.STATUS;
        
        if (billItemsListUl) {
            billItemsListUl.innerHTML = ''; // Clear existing items
            currentBill.items.forEach(item => {
                const li = document.createElement('li');
                li.textContent = `L${item.BILLD_LINE}: ${item.product_name || item.BILLD_GOODS_ID} - Qty: ${item.BILLD_GOODS_NUM} @ $${parseFloat(item.BILLD_GOODS_PRC).toFixed(2)} = $${parseFloat(item.BILLD_AMT).toFixed(2)}`;
                billItemsListUl.appendChild(li);
            });
        }
        
        if (billTotalsDisplayDiv) {
             billTotalsDisplayDiv.innerHTML = `
                <p>Subtotal: $${parseFloat(currentBill.totals.BILLH_AMT || 0).toFixed(2)}</p>
                <p>VAT: $${parseFloat(currentBill.totals.BILLH_AMT_VAT || 0).toFixed(2)}</p>
                <p><strong>Total: $${parseFloat(currentBill.totals.BILLH_TOTAMT || 0).toFixed(2)}</strong></p>
            `;
        }
        if (payBillBtn) payBillBtn.disabled = currentBill.STATUS !== 'pending';
    }


    // --- Event Handlers ---
    function handleLogout() {
        localStorage.removeItem('currentUser');
        // No need to call API if it's just placeholder. If real tokens, call /auth/logout
        window.location.href = '/login';
    }

    async function handleNewBill() {
        displayMessage('Initiating new bill...', 'info');
        const data = await apiCall('/sales/new_bill', 'POST');
        if (data && data.bill_header) {
            currentBill = {
                BILLH_COMP_ID: data.bill_header.BILLH_COMP_ID,
                BILLH_NO: data.bill_header.BILLH_NO,
                STATUS: data.bill_header.BILLH_STATUS,
                items: [],
                totals: { BILLH_AMT: 0, BILLH_AMT_VAT: 0, BILLH_TOTAMT: 0 } // Initial totals
            };
            updateBillDisplay();
            displayMessage('New bill initiated successfully.', 'success');
        } else {
            displayMessage(data?.message || 'Failed to initiate new bill.');
        }
    }

    async function handleSearchProducts() {
        const searchTerm = productSearchTermInput.value.trim();
        if (!searchTerm) {
            productSearchResultsUl.innerHTML = '';
            return;
        }
        displayMessage('Searching products...', 'info');
        const products = await apiCall(`/products?search_term=${encodeURIComponent(searchTerm)}`);
        productSearchResultsUl.innerHTML = '';
        if (products && products.length > 0) {
            products.forEach(product => {
                const li = document.createElement('li');
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
                    if (productSearchResultsUl) productSearchResultsUl.innerHTML = ''; // Clear results after selection
                });
                productSearchResultsUl.appendChild(li);
            });
            displayMessage('', 'info'); // Clear searching message
        } else {
            displayMessage('No products found matching your search.');
        }
    }
    
    async function handleAddItemToBill() {
        if (!currentBill || currentBill.STATUS !== 'pending') {
            displayMessage('Cannot add items. No active pending bill.');
            return;
        }
        if (!selectedProduct) {
            displayMessage('Please select a product first.');
            return;
        }
        const quantity = parseInt(itemQuantityInput.value);
        if (isNaN(quantity) || quantity <= 0) {
            displayMessage('Please enter a valid quantity.');
            return;
        }

        displayMessage('Adding item...', 'info');
        const itemData = {
            BILLH_COMP_ID: currentBill.BILLH_COMP_ID,
            BILLH_NO: currentBill.BILLH_NO,
            BILLD_GOODS_ID: selectedProduct.FG_ID,
            BILLD_GOODS_NUM: quantity
        };
        
        const result = await apiCall('/sales/add_item', 'POST', itemData);
        if (result && result.bill_detail) {
            // Add product name to the detail for display purposes
            result.bill_detail.product_name = selectedProduct.FG_SHORT;
            currentBill.items.push(result.bill_detail);
            currentBill.totals = result.updated_bill_header_totals;
            updateBillDisplay();
            displayMessage('Item added successfully.', 'success');
            // Reset selection
            selectedProduct = null;
            if (selectedProductDisplayDiv) selectedProductDisplayDiv.textContent = 'Select a product from search results.';
            if (addItemToBillBtn) addItemToBillBtn.disabled = true;
            if (itemQuantityInput) itemQuantityInput.value = '1';

        } else {
             displayMessage(result?.message || 'Failed to add item.');
        }
    }

    async function handleSearchCustomers() {
        const searchTerm = customerSearchTermInput.value.trim();
        if (!searchTerm) {
            customerSearchResultsUl.innerHTML = '';
            return;
        }
        displayMessage('Searching customers...', 'info');
        const customers = await apiCall(`/customers/search?search_term=${encodeURIComponent(searchTerm)}`);
        customerSearchResultsUl.innerHTML = '';
        if (customers && customers.length > 0) {
            customers.forEach(customer => {
                const li = document.createElement('li');
                li.textContent = `${customer.CUST_NAME} (ID: ${customer.CUST_ID})`;
                li.dataset.customerId = customer.CUST_ID;
                li.dataset.customerName = customer.CUST_NAME;
                li.addEventListener('click', () => {
                    selectedCustomer = { CUST_ID: customer.CUST_ID, CUST_NAME: customer.CUST_NAME };
                    if (currentCustomerDisplayDiv) currentCustomerDisplayDiv.textContent = `ID: ${customer.CUST_ID}, Name: ${customer.CUST_NAME}`;
                     if (customerSearchResultsUl) customerSearchResultsUl.innerHTML = ''; // Clear results
                    // TODO: Associate customer with currentBill if one is active
                    // This might involve an API call or just local state update if bill header allows CUST_ID update.
                    // For now, just updating display. Backend BillHeader needs CUST_ID.
                    // If a bill is active, one might want to update the BillHeader's CUST_ID.
                    // This part is not implemented in the backend's /sales/new_bill or /sales/add_item
                });
                customerSearchResultsUl.appendChild(li);
            });
            displayMessage('', 'info');
        } else {
            displayMessage('No customers found.');
        }
    }

    async function handleAddCustomer(event) {
        event.preventDefault();
        const custId = newCustIdInput.value.trim();
        const custName = newCustNameInput.value.trim();
        if (!custId || !custName) {
            displayMessage('Customer ID and Name are required to add a new customer.');
            return;
        }
        displayMessage('Adding customer...', 'info');
        const result = await apiCall('/customers', 'POST', { CUST_ID: custId, CUST_NAME: custName });
        if (result && result.customer) {
            displayMessage(`Customer ${result.customer.CUST_NAME} added.`, 'success');
            selectedCustomer = result.customer; // Auto-select the new customer
            if (currentCustomerDisplayDiv) currentCustomerDisplayDiv.textContent = `ID: ${selectedCustomer.CUST_ID}, Name: ${selectedCustomer.CUST_NAME}`;
            newCustomerForm.reset();
        } else {
            displayMessage(result?.message || 'Failed to add customer.');
        }
    }
    
    async function handlePayBill() {
        if (!currentBill || currentBill.STATUS !== 'pending') {
            displayMessage('No pending bill to pay or bill already processed.');
            return;
        }
        // For simplicity, assuming total amount is paid.
        // A real POS would have input for amount tendered.
        const amountToPay = currentBill.totals.BILLH_TOTAMT; 
        
        displayMessage('Processing payment...', 'info');
        const paymentData = {
            BILLH_COMP_ID: currentBill.BILLH_COMP_ID,
            BILLH_NO: currentBill.BILLH_NO,
            BILLH_TOTPAY: amountToPay 
        };
        const result = await apiCall('/sales/pay_bill', 'POST', paymentData);
        if (result && result.bill_header) {
            currentBill.STATUS = result.bill_header.BILLH_STATUS;
            currentBill.totals.BILLH_TOTPAY = result.bill_header.BILLH_TOTPAY; // Update if backend sends it
            updateBillDisplay();
            displayMessage('Bill paid successfully.', 'success');
            if (payBillBtn) payBillBtn.disabled = true;
        } else {
            displayMessage(result?.message || 'Failed to process payment.');
        }
    }

    // --- Attach Event Listeners ---
    function attachEventListeners() {
        if (logoutBtn) logoutBtn.addEventListener('click', handleLogout);
        if (newBillBtn) newBillBtn.addEventListener('click', handleNewBill);
        if (searchProductBtn) searchProductBtn.addEventListener('click', handleSearchProducts);
        if (addItemToBillBtn) addItemToBillBtn.addEventListener('click', handleAddItemToBill);
        if (searchCustomerBtn) searchCustomerBtn.addEventListener('click', handleSearchCustomers);
        if (newCustomerForm) newCustomerForm.addEventListener('submit', handleAddCustomer);
        if (payBillBtn) payBillBtn.addEventListener('click', handlePayBill);
        
        // Optional: search on enter for input fields
        if (productSearchTermInput) productSearchTermInput.addEventListener('keypress', function(e) { if (e.key === 'Enter') handleSearchProducts(); });
        if (customerSearchTermInput) customerSearchTermInput.addEventListener('keypress', function(e) { if (e.key === 'Enter') handleSearchCustomers(); });
    }

    // --- Start the app ---
    initializePage();
});
