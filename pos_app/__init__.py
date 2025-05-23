from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from .config import Config

# Initialize SQLAlchemy so it can be imported by models.py
db = SQLAlchemy()

def create_app(config_class=Config):
    """
    Factory function to create and configure the Flask application.
    """
    app = Flask(__name__)
    app.config.from_object(config_class)

    # Initialize extensions
    db.init_app(app)

    # Import and register blueprints
    from .routes.auth_routes import auth_bp
    from .routes.product_routes import product_bp
    from .routes.customer_routes import customer_bp
    from .routes.sale_routes import sale_bp
    from .routes.view_routes import view_bp # Added view_bp
    
    app.register_blueprint(auth_bp)
    app.register_blueprint(product_bp)
    app.register_blueprint(customer_bp)
    app.register_blueprint(sale_bp)
    app.register_blueprint(view_bp) # Registered view_bp

    # Import models here if they need to be accessed during app setup,
    # or ensure they are imported where needed (e.g. in blueprint files).
    # Models are already imported in blueprint files where they are used.
    # from . import models # This line could be added if models need to be globally registered/checked here.

    # Example: Test connection (optional, can be removed)
    # This context is useful for running one-off commands or tests that need the app context.
    # with app.app_context():
    #     try:
    #         # The following line ensures that the Company table (and others) are known to SQLAlchemy
    #         # if you were to run db.create_all() for example.
    #         # from .models import Company 
    #         db.engine.connect()
    #         print("Successfully connected to the database via SQLAlchemy!")
    #     except Exception as e:
    #         print(f"Failed to connect to the database via SQLAlchemy: {e}")

    return app
