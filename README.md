# Python Flask POS System

## Overview

A Point of Sale (POS) application developed using Python, Flask, and MySQL. This project aims to migrate and modernize features from an older Delphi-based system, providing a web-based interface for sales operations. This README covers Phase 1 of the project.

## Features (Phase 1)

*   **User Login:** Secure login for Salespersons.
*   **Customer Management:** Ability to add new customers and search for existing ones.
*   **Product Lookup:** Functionality to search for products by name or description.
*   **Sales Operations:**
    *   Initiate a new sales bill.
    *   Add items to the current bill.
    *   Automatic calculation of bill totals.
    *   Process payments and mark bills as paid.
*   **Data Storage:** Sales data, product information, and customer details are stored in a MySQL database.
*   **Backend API:** A RESTful API built with Flask, providing endpoints for all core operations.
*   **Testing:** Unit and integration tests for the backend API using `pytest`.

## Technology Stack

*   **Backend:** Python 3.8+
    *   Flask: Web framework.
    *   Flask-SQLAlchemy: ORM for database interaction.
    *   mysql-connector-python: MySQL driver.
*   **Database:** MySQL (version 5.7 or higher recommended).
*   **Testing:** pytest, pytest-flask, Flask-Testing.
*   **Frontend:** HTML, CSS (basic inline/embedded), JavaScript (vanilla JS for client-side logic).

## Prerequisites

*   Python (version 3.8 or higher recommended).
*   MySQL Server (version 5.7 or higher recommended).
*   Git (for cloning the repository).
*   **OS Compatibility:** The application is compatible with Windows, Linux, and macOS, provided the other prerequisites are met.

## Setup Instructions

**1. Clone the Repository:**
   ```bash
   git clone <your_repository_url_here>
   cd <repository_directory_name>
   ```
   *(Replace `<your_repository_url_here>` and `<repository_directory_name>` with actual values)*

**2. Create and Activate a Python Virtual Environment:**
   *   Ensure you are using `python` or `python3` as appropriate for your system (typically `python` on Windows if installed from python.org, and `python3` on Linux/macOS).
   ```bash
   python -m venv venv
   ```
   *   Activate the virtual environment:
     *   **On Windows (Command Prompt/PowerShell):**
       ```bash
       venv\Scripts\activate
       ```
     *   **On Linux/macOS (bash/zsh):**
       ```bash
       source venv/bin/activate
       ```

**3. Install Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

**4. MySQL Database Setup:**
   *   Ensure your MySQL server is running.
   *   Connect to MySQL (e.g., using `mysql -u your_mysql_user -p`).
   *   Create the database if it doesn't exist. The application expects the database name `py_pos_db`.
     ```sql
     CREATE DATABASE IF NOT EXISTS py_pos_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
     ```
   *   **Note:** The application is designed to create the necessary tables automatically when `run.py` is executed for the first time (via `db.create_all()` and SQLAlchemy models). The `schema.sql` file in the repository is for reference.

**5. Application Configuration (Review):**
   *   The primary database configuration is located in `pos_app/config.py`.
   *   By default, it's configured to connect to a MySQL database named `py_pos_db` on `localhost` using user `root` with an empty password.
     ```python
     # Default connection string in pos_app/config.py
     SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://root:@localhost/py_pos_db'
     ```
   *   If your MySQL setup differs (e.g., different user, password, host, or port), you should adjust the `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_HOST`, or the full `SQLALCHEMY_DATABASE_URI` in `pos_app/config.py`, or set the corresponding environment variables.

**6. Windows Specific Notes (Optional):**
   *   **Python Installation:** When installing Python on Windows from python.org, ensure the option "Add Python to PATH" is checked during installation.
   *   **MySQL Server:** For Windows, you can install MySQL Community Server directly. During setup, configuring it to run as a Windows service is recommended. Alternatively, packages like XAMPP or WAMP include MySQL and can be used.
   *   **MySQL Client Tools:** Ensure MySQL command-line tools are added to your system's PATH if you want to use commands like `mysql` directly from Command Prompt or PowerShell. This is usually an option during MySQL Server installation.

## Running the Application

*   Ensure your MySQL server is running and the database `py_pos_db` exists.
*   From the project root directory (where `run.py` is located), execute:
    ```bash
    python run.py
    ```
*   This will start the Flask development server. By default, it should be accessible at `http://127.0.0.1:5000/` or `http://0.0.0.0:5000/`.
*   The first time you run the application, `run.py` will:
    1.  Create all necessary database tables if they don't already exist.
    2.  Seed some initial data:
        *   A default company (`DEFAULT_COMP`).
        *   A default salesperson (`S001` for company `DEFAULT_COMP`).
        *   A default control record for bill numbering.
        *   A default product group and unit.
        *   A sample product.

## Accessing the Application

*   Open your web browser and navigate to `http://127.0.0.1:5000/`.
*   You will be redirected to the login page.

*   **Default Login Credentials (for testing Phase 1):**
    *   Sales ID: `S001`
    *   Password: `password`

    *(These credentials are created by the `run.py` script for the `DEFAULT_COMP` company if they don't already exist in the database).*

## Running Tests

*   Ensure you have installed the development dependencies from `requirements.txt` (which includes `pytest`).
*   From the project root directory, execute:
    ```bash
    pytest
    ```
    This will discover and run all tests located in the `tests/` directory.

## Project Structure (Brief Overview)

```
.
├── pos_app/                  # Main application package
│   ├── __init__.py           # Flask app factory (create_app) and blueprint registration
│   ├── config.py             # Configuration settings (database URI, etc.)
│   ├── models.py             # SQLAlchemy database models
│   ├── routes/               # Directory for Flask blueprints (API and view routes)
│   │   ├── auth_routes.py
│   │   ├── customer_routes.py
│   │   ├── product_routes.py
│   │   ├── sale_routes.py
│   │   └── view_routes.py    # Routes for rendering HTML pages
│   ├── static/               # Static files (CSS, JavaScript)
│   │   └── js/
│   │       ├── login.js
│   │       └── sales.js
│   └── templates/            # HTML templates
│       ├── login.html
│       └── sales.html
├── tests/                    # Unit and integration tests
│   ├── conftest.py           # Pytest fixtures and configuration
│   ├── integration/          # Integration tests for API endpoints
│   │   ├── test_auth_api.py
│   │   ├── test_customer_api.py
│   │   ├── test_product_api.py
│   │   └── test_sale_api.py
│   └── unit/                 # Unit tests (currently basic placeholders)
│       └── test_utils.py
├── run.py                    # Main script to run the Flask application and seed initial data
├── requirements.txt          # Python dependencies for the project
├── schema.sql                # MySQL schema definition (for reference; tables created by app)
└── README.md                 # This file
```

---
*This README provides a guide for setting up and running Phase 1 of the Python Flask POS System.*
