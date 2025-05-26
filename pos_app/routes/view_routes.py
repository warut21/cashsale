from flask import Blueprint, render_template, redirect, url_for

view_bp = Blueprint('view_bp', __name__)

@view_bp.route('/')
def index():
    # Redirect to login page by default, or render an index page
    return redirect(url_for('view_bp.login_page'))

@view_bp.route('/login')
def login_page():
    return render_template('login.html')

@view_bp.route('/sales')
def sales_page():
    # This page should ideally be protected.
    # The client-side JS will handle redirect if no user info is found in localStorage.
    return render_template('sales.html')

@view_bp.route('/customers')
def customers_page():
    return render_template('customers.html')

@view_bp.route('/products')
def products_page():
    return render_template('products.html')

@view_bp.route('/history')
def sales_history_page():
    # Placeholder for sales history page
    return "Sales History Page - Coming Soon!"
