import os

class Config:
    # Database configuration
    # For MySQL, the format is: mysql+mysqlconnector://user:password@host/database
    # Assuming 'root' user with no password for local development as per previous setup.
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', '') # Empty if no password
    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'localhost')
    MYSQL_DB = os.environ.get('MYSQL_DB', 'py_pos_db')

    SQLALCHEMY_DATABASE_URI = f"mysql+mysqlconnector://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}/{MYSQL_DB}"
    
    # Suppress Flask-SQLAlchemy event system warnings
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Optional: Secret key for session management, etc.
    # SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
