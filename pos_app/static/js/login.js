document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('loginForm');
    const errorMessageDiv = document.getElementById('errorMessage');

    if (loginForm) {
        loginForm.addEventListener('submit', async function (event) {
            event.preventDefault(); // Prevent default form submission

            const salesId = document.getElementById('sales_id').value;
            const salesPassword = document.getElementById('sales_password').value;
            errorMessageDiv.textContent = ''; // Clear previous errors

            if (!salesId || !salesPassword) {
                errorMessageDiv.textContent = 'Sales ID and Password are required.';
                return;
            }

            try {
                const response = await fetch('/api/auth/login', { // Changed URL
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        SALES_ID: salesId,
                        SALES_PASS: salesPassword
                        // If COMP_ID is needed for login by the backend, add it here:
                        // COMP_ID: 'DEFAULT_COMP' // Or get from another form field
                    }),
                });

                const data = await response.json();

                if (response.ok) { // HTTP status 200-299
                    if (data.user) {
                        localStorage.setItem('currentUser', JSON.stringify(data.user));
                        // Redirect to the sales page
                        window.location.href = '/sales';
                    } else {
                        errorMessageDiv.textContent = data.message || 'Login successful, but no user data returned.';
                    }
                } else {
                    errorMessageDiv.textContent = data.message || `Login failed with status: ${response.status}`;
                }
            } catch (error) {
                console.error('Login error:', error);
                errorMessageDiv.textContent = 'An error occurred during login. Please try again.';
            }
        });
    }

    // Redirect to sales page if already logged in (basic check)
    // This is a simple check. A more robust solution would involve verifying the token/session with the backend.
    if (window.location.pathname.includes('/login') || window.location.pathname === '/') {
        const currentUser = localStorage.getItem('currentUser');
        if (currentUser) {
            // Optional: verify with backend if user is still valid before redirecting
            // For now, simple redirect if user info exists
            // window.location.href = '/sales';
        }
    }
});
