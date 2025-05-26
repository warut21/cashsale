document.addEventListener('DOMContentLoaded', function () {
    const addCustomerForm = document.getElementById('addCustomerForm');
    const newCustIdInput = document.getElementById('newCustId');
    const newCustNameInput = document.getElementById('newCustName');
    const addCustomerMessageDiv = document.getElementById('addCustomerMessage');

    const customerSearchTermInput = document.getElementById('customerSearchTerm');
    const searchCustomerBtn = document.getElementById('searchCustomerBtn');
    const customerSearchMessageDiv = document.getElementById('customerSearchMessage');
    const customerListUl = document.getElementById('customerList');

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
            // Check if response is JSON, otherwise return error status
            const contentType = response.headers.get("content-type");
            if (contentType && contentType.indexOf("application/json") !== -1) {
                const data = await response.json();
                if (!response.ok) {
                    return { error: true, message: data.message || `Error: ${response.status}`, status: response.status, data: data };
                }
                return { error: false, data: data, status: response.status };
            } else {
                 const textData = await response.text(); // Or handle as plain text
                 return { error: true, message: `Non-JSON response: ${textData}`, status: response.status, data: textData };
            }
        } catch (error) {
            console.error(`API call to ${endpoint} failed:`, error);
            return { error: true, message: 'Network error or server unavailable.', status: null, data: null };
        }
    }

    function renderCustomers(customers) {
        if (!customerListUl) return;
        customerListUl.innerHTML = ''; // Clear current list

        if (!customers || customers.length === 0) {
            customerListUl.innerHTML = '<li class="list-group-item text-muted">No customers found.</li>';
            return;
        }

        customers.forEach(customer => {
            const li = document.createElement('li');
            li.className = 'list-group-item d-flex justify-content-between align-items-center';
            li.innerHTML = `
                <div>
                    <h6 class="my-0">${customer.CUST_NAME}</h6>
                    <small class="text-muted">ID: ${customer.CUST_ID}</small>
                </div>
                <div>
                    <!-- Future action buttons (edit, delete) can go here -->
                </div>
            `;
            customerListUl.appendChild(li);
        });
    }

    // --- Event Handlers ---
    async function handleAddCustomer(event) {
        event.preventDefault();
        clearMessage(addCustomerMessageDiv);

        const custId = newCustIdInput.value.trim();
        const custName = newCustNameInput.value.trim();

        if (!custId || !custName) {
            displayMessage(addCustomerMessageDiv, 'Customer ID and Name are required.');
            return;
        }

        const result = await apiCall('/customers', 'POST', { CUST_ID: custId, CUST_NAME: custName });

        if (result.error) {
            displayMessage(addCustomerMessageDiv, result.message || 'Failed to add customer.');
        } else {
            displayMessage(addCustomerMessageDiv, result.data.message || 'Customer added successfully!', 'success');
            addCustomerForm.reset();
            // Optionally, refresh the search or add to list if displaying all by default
            // For now, user can search to see the new customer.
            // Or, call handleSearchCustomers with the new custId to show it immediately.
            if (customerSearchTermInput) customerSearchTermInput.value = custId; // Prime search
            handleSearchCustomers(); // Refresh list with the new customer
        }
    }

    async function handleSearchCustomers() {
        clearMessage(customerSearchMessageDiv);
        const searchTerm = customerSearchTermInput.value.trim();

        if (!searchTerm) {
            // displayMessage(customerSearchMessageDiv, 'Please enter a search term.');
            // Optionally, load all customers if search term is empty, or clear list
            customerListUl.innerHTML = '<li class="list-group-item text-muted">Enter a search term to display customers.</li>';
            return;
        }

        const result = await apiCall(`/customers/search?search_term=${encodeURIComponent(searchTerm)}`);

        if (result.error) {
            if (result.status === 404) { // No customers found
                renderCustomers([]); // Clears list and shows "No customers found"
                displayMessage(customerSearchMessageDiv, result.message, 'info');
            } else {
                displayMessage(customerSearchMessageDiv, result.message || 'Failed to search customers.');
            }
        } else {
            renderCustomers(result.data);
        }
    }

    // --- Attach Event Listeners ---
    if (addCustomerForm) {
        addCustomerForm.addEventListener('submit', handleAddCustomer);
    }
    if (searchCustomerBtn) {
        searchCustomerBtn.addEventListener('click', handleSearchCustomers);
    }
    if (customerSearchTermInput) { // Optional: search on enter
        customerSearchTermInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                handleSearchCustomers();
            }
        });
    }
    
    // Initial load (optional - can display all customers or a message)
    // handleSearchCustomers(); // Or leave blank until user searches
     if (customerListUl) customerListUl.innerHTML = '<li class="list-group-item text-muted">Enter a search term or add a new customer.</li>';

});
