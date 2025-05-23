import pyodbc
import mysql.connector
import datetime
import os

# --- Configuration ---
# MS Access Configuration
ACCESS_DB_FILE = "pos_data.accdb"  # Path to your Access database file
# For Linux, using MDBTools (ensure odbc-mdbtools is installed)
# The driver name might vary. Check /etc/odbcinst.ini or `odbcinst -q -d`
ACCESS_DRIVER = "{MDBToolsODBC}" # Or "{Microsoft Access Driver (*.mdb, *.accdb)}" on Windows

# MySQL Configuration
MYSQL_HOST = "localhost"
MYSQL_USER = "root"  # Assumes sudo mysql was used, so root user might not need a password for local connections
MYSQL_PASSWORD = ""  # Adjust if you have a password for MySQL root
MYSQL_DATABASE = "py_pos_db"

# Tables to migrate (in order of dependency if possible, or handle FKs appropriately)
# COMPANY and CUSTOMER have no FKs to other tables in this list.
# SALESMAN depends on COMPANY.
# CONTROL depends on COMPANY.
# FINISH_GOODS has FKs (FG_GRP, FG_UNITS) to tables not in this specific migration batch.
TABLES_TO_MIGRATE = [
    "COMPANY",
    "CUSTOMER",
    "PRODGROUP", # Dependency for FINISH_GOODS
    "UNITS",     # Dependency for FINISH_GOODS
    "FINISH_GOODS",
    "SALESMAN",
    "CONTROL",
    "PROMO_HEAD", # Dependency for BILL_DETAIL, BILL_PROMO
    "BILL_HEAD",  # Depends on COMPANY, CUSTOMER, SALESMAN, PRODGROUP
    "BILL_DETAIL",# Depends on BILL_HEAD, FINISH_GOODS, PROMO_HEAD
    "BILL_PROMO", # Depends on BILL_HEAD, PROMO_HEAD
    "PROMO_DETAIL",# Depends on PROMO_HEAD, FINISH_GOODS
    # "PROGRAMER" # Table PROGRAMER has no data in Access usually, or specific migration needs
]

# Targeted tables for this specific subtask (override for focused migration)
TARGETED_TABLES = [
    "COMPANY",
    "CUSTOMER",
    "FINISH_GOODS", # Note: FG_GRP and FG_UNITS FKs might point to non-existent rows if PRODGROUP/UNITS not migrated
    "SALESMAN",
    "CONTROL"
]
# For FINISH_GOODS to work based on schema, PRODGROUP and UNITS need to be populated.
# So, let's adjust TARGETED_TABLES if we want a clean run, or acknowledge potential FK issues.
# For this exercise, let's assume we'd ideally migrate PRODGROUP and UNITS first if they had data.
# Since the task focuses on specific tables and the Access DB is missing anyway, this is more about script structure.


def get_access_connection():
    """
    Establishes a connection to the MS Access database.
    Returns a pyodbc connection object or None if connection fails or file missing.
    """
    if not os.path.exists(ACCESS_DB_FILE):
        print(f"ERROR: MS Access database file '{ACCESS_DB_FILE}' not found. Cannot migrate data.")
        return None

    conn_str = f"DRIVER={ACCESS_DRIVER};DBQ={ACCESS_DB_FILE};"
    try:
        print(f"Attempting to connect to Access DB: {ACCESS_DB_FILE} using driver: {ACCESS_DRIVER}")
        access_conn = pyodbc.connect(conn_str)
        print("Successfully connected to Access database.")
        return access_conn
    except pyodbc.Error as ex:
        sqlstate = ex.args[0]
        print(f"ERROR connecting to Access: {sqlstate}")
        print(ex)
        print("Please ensure 'odbc-mdbtools' is installed and configured correctly on Linux.")
        print("Verify the driver name in /etc/odbcinst.ini or from 'odbcinst -q -d'.")
        print(f"Connection string used: {conn_str}")
        # Common issue: driver not found, file not found, or ACCDB format limitations with mdbtools.
        if '01000' in sqlstate or 'IM002' in sqlstate : # IM002 is Data source name not found and no default driver specified
             print("Driver not found. Please check your ODBC configuration (odbcinst.ini and odbc.ini).")
        return None


def get_mysql_connection():
    """
    Establishes a connection to the MySQL database.
    Returns a mysql.connector connection object or None if connection fails.
    """
    try:
        mysql_conn = mysql.connector.connect(
            host=MYSQL_HOST,
            user=MYSQL_USER,
            password=MYSQL_PASSWORD,
            database=MYSQL_DATABASE
        )
        print(f"Successfully connected to MySQL database '{MYSQL_DATABASE}'.")
        return mysql_conn
    except mysql.connector.Error as err:
        print(f"ERROR connecting to MySQL: {err}")
        return None


def migrate_table_data(access_conn, mysql_conn, table_name):
    """
    Migrates data for a single table from Access to MySQL.
    """
    if access_conn is None:
        print(f"Skipping migration for table '{table_name}' due to missing Access connection.")
        return 0

    print(f"\n--- Migrating table: {table_name} ---")
    
    access_cursor = access_conn.cursor()
    mysql_cursor = mysql_conn.cursor()

    # Get column names from MySQL table to build the INSERT statement
    try:
        mysql_cursor.execute(f"DESCRIBE `{table_name}`") # Use backticks for table names
        mysql_columns = [col[0] for col in mysql_cursor.fetchall()]
    except mysql.connector.Error as err:
        print(f"ERROR describing MySQL table {table_name}: {err}")
        return 0

    placeholders = ", ".join(["%s"] * len(mysql_columns))
    insert_sql = f"INSERT INTO `{table_name}` ({', '.join(mysql_columns)}) VALUES ({placeholders})"

    rows_migrated = 0
    try:
        # Fetch data from Access
        # Note: Access table/column names might need to be quoted if they contain spaces or special chars
        # For simplicity, assuming standard names here.
        access_cursor.execute(f"SELECT * FROM [{table_name}]") # Brackets for Access table names
        
        rows = access_cursor.fetchall()
        if not rows:
            print(f"No data found in Access table '{table_name}'.")
            return 0

        for row_num, access_row in enumerate(rows):
            # Convert row to list for easier manipulation if needed, and handle data types
            data_to_insert = []
            for i, value in enumerate(access_row):
                if isinstance(value, datetime.datetime):
                    # MySQL connector handles Python datetime objects
                    data_to_insert.append(value)
                elif isinstance(value, float) and mysql_columns[i] in ('FG_PRICE', 'FG_COST', 'ACCU_AMT', 'TODAY_AMT', 'ACCU_AMT_C', 'TODAY_AMT_C'):
                    # Ensure float is compatible with DECIMAL(15,2) - this should be fine
                    data_to_insert.append(value)
                elif value is None:
                    data_to_insert.append(None)
                else:
                    data_to_insert.append(value)
            
            # Ensure data_to_insert matches column count
            if len(data_to_insert) != len(mysql_columns):
                print(f"WARNING: Column count mismatch for table {table_name}. Access: {len(data_to_insert)}, MySQL: {len(mysql_columns)}. Skipping row {row_num + 1}.")
                # print(f"Access row data: {access_row}")
                # print(f"MySQL columns: {mysql_columns}")
                continue

            try:
                mysql_cursor.execute(insert_sql, tuple(data_to_insert))
                rows_migrated += 1
            except mysql.connector.Error as err:
                print(f"ERROR inserting row into MySQL table {table_name}: {err}")
                print(f"Problematic row data (from Access): {access_row}")
                print(f"Data prepared for MySQL: {data_to_insert}")
                # Optionally, decide whether to continue or stop on error
            except Exception as e:
                print(f"An unexpected error occurred during insertion into {table_name}: {e}")
                print(f"Problematic row data (from Access): {access_row}")
                print(f"Data prepared for MySQL: {data_to_insert}")


        mysql_conn.commit()
        print(f"Successfully migrated {rows_migrated} rows to MySQL table '{table_name}'.")

    except pyodbc.Error as ex:
        print(f"ERROR reading from Access table {table_name}: {ex}")
        # This can happen if table doesn't exist or column names are problematic
    except Exception as e:
        print(f"An unexpected error occurred during migration of table {table_name}: {e}")
        mysql_conn.rollback() # Rollback on any other error during processing for this table
    
    finally:
        access_cursor.close()
        mysql_cursor.close()
    
    return rows_migrated


def main():
    print("Starting data migration process...")

    # Check for Access DB file first
    if not os.path.exists(ACCESS_DB_FILE):
        print(f"CRITICAL ERROR: MS Access database file '{ACCESS_DB_FILE}' not found.")
        print("Please ensure the database file is in the correct location and has the correct name.")
        print("Migration cannot proceed without the source Access database.")
        # Create a dummy report file or output indicating failure
        with open("migration_summary.txt", "w") as f:
            f.write(f"Migration failed: Access DB file '{ACCESS_DB_FILE}' not found.\n")
        return

    access_conn = get_access_connection()
    mysql_conn = get_mysql_connection()

    if access_conn is None or mysql_conn is None:
        print("Cannot proceed with migration due to connection failures.")
        if access_conn:
            access_conn.close()
        if mysql_conn:
            mysql_conn.close()
        return

    total_rows_migrated_all_tables = 0
    migration_summary = []

    # Use the TARGETED_TABLES list for this specific task
    tables_for_this_run = TARGETED_TABLES
    print(f"\nTargeting specific tables for this run: {', '.join(tables_for_this_run)}")


    # For FINISH_GOODS to migrate correctly, PRODGROUP and UNITS would typically be migrated first.
    # If they are not part of TARGETED_TABLES and data exists for them, this script would need adjustment
    # or expect potential FK violations if those tables are empty.
    # Given the Access DB is missing, this is a structural note.
    
    # A more robust approach for dependencies not in TARGETED_TABLES:
    # Check if FINISH_GOODS is in tables_for_this_run and if its dependencies are also there.
    if "FINISH_GOODS" in tables_for_this_run:
        if "PRODGROUP" not in tables_for_this_run:
            print("INFO: FINISH_GOODS is targeted, but PRODGROUP is not. FG_GRP values will be migrated as-is.")
        if "UNITS" not in tables_for_this_run:
            print("INFO: FINISH_GOODS is targeted, but UNITS is not. FG_UNITS values will be migrated as-is.")
            
    # Similarly for SALESMAN and CONTROL depending on COMPANY
    if "SALESMAN" in tables_for_this_run and "COMPANY" not in tables_for_this_run:
        print("WARNING: SALESMAN is targeted, but COMPANY is not. Migration might fail due to FK constraints if COMPANY is empty.")
    if "CONTROL" in tables_for_this_run and "COMPANY" not in tables_for_this_run:
        print("WARNING: CONTROL is targeted, but COMPANY is not. Migration might fail due to FK constraints if COMPANY is empty.")


    for table_name in tables_for_this_run:
        # Special handling for table names if they are different in Access vs MySQL
        # (e.g. if Access uses spaces and MySQL uses underscores)
        # For this script, names are assumed to be identical or handled by quoting.
        
        rows = migrate_table_data(access_conn, mysql_conn, table_name)
        migration_summary.append(f"Table '{table_name}': {rows} rows migrated.")
        total_rows_migrated_all_tables += rows

    print("\n--- Migration Summary ---")
    for summary_line in migration_summary:
        print(summary_line)
    print(f"Total rows migrated across all targeted tables: {total_rows_migrated_all_tables}")

    # Write summary to a file
    with open("migration_summary.txt", "w") as f:
        if not os.path.exists(ACCESS_DB_FILE):
            f.write(f"Migration failed: Access DB file '{ACCESS_DB_FILE}' not found.\n\n")
        for summary_line in migration_summary:
            f.write(summary_line + "\n")
        f.write(f"\nTotal rows migrated across all targeted tables: {total_rows_migrated_all_tables}\n")

    if access_conn:
        access_conn.close()
    if mysql_conn:
        mysql_conn.close()
    print("\nData migration process finished.")

if __name__ == "__main__":
    main()
