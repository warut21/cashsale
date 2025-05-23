from . import db # Import db from the current package's __init__.py
from sqlalchemy import Numeric, Float, DateTime, ForeignKeyConstraint, PrimaryKeyConstraint
from sqlalchemy.orm import relationship

class Company(db.Model):
    __tablename__ = 'COMPANY'
    COMP_ID = db.Column(db.String(255), primary_key=True)
    COMP_NAME = db.Column(db.String(255))
    COMP_ADD1 = db.Column(db.String(255))
    COMP_ADD2 = db.Column(db.String(255))
    COMP_ADD3 = db.Column(db.String(255))
    COMP_POST = db.Column(db.String(255))
    COMP_TAX = db.Column(db.String(255))
    COMP_BRANCH = db.Column(db.String(255))

    # Relationships
    sales_people = relationship("SalesPerson", back_populates="company")
    controls = relationship("Control", back_populates="company")
    bill_headers = relationship("BillHeader", back_populates="company")

class Customer(db.Model):
    __tablename__ = 'CUSTOMER'
    CUST_ID = db.Column(db.String(255), primary_key=True)
    CUST_NAME = db.Column(db.String(255))

    # Relationships
    bill_headers = relationship("BillHeader", back_populates="customer")

class ProdGroup(db.Model):
    __tablename__ = 'PRODGROUP'
    GRP_ID = db.Column(db.String(255), primary_key=True)
    GRP_NT = db.Column(db.String(255))
    GRP_NE = db.Column(db.String(255))

    # Relationships
    finish_goods = relationship("FinishGood", back_populates="prod_group")
    bill_headers = relationship("BillHeader", back_populates="prod_group")


class Unit(db.Model): # Changed from UNITS to Unit for singular convention
    __tablename__ = 'UNITS'
    UNITS_ID = db.Column(db.String(255), primary_key=True)
    UNITS_NAME = db.Column(db.String(255))

    # Relationships
    finish_goods = relationship("FinishGood", back_populates="unit")

class FinishGood(db.Model):
    __tablename__ = 'FINISH_GOODS'
    FG_ID = db.Column(db.String(255), primary_key=True)
    FG_SHORT = db.Column(db.String(255))
    FG_GRP = db.Column(db.String(255), db.ForeignKey('PRODGROUP.GRP_ID'))
    FG_UNITS = db.Column(db.String(255), db.ForeignKey('UNITS.UNITS_ID'))
    FG_BAR_CODE = db.Column(db.String(255))
    FG_GRADE = db.Column(db.String(255))
    FG_DES = db.Column(db.String(255))
    FG_WH = db.Column(db.String(255)) # Assuming Warehouse ID, no FK defined in schema for now
    FG_PRICE = db.Column(Numeric(15, 2))
    FG_COST = db.Column(Numeric(15, 2))

    # Relationships
    prod_group = relationship("ProdGroup", back_populates="finish_goods")
    unit = relationship("Unit", back_populates="finish_goods")
    bill_details = relationship("BillDetail", back_populates="finish_good")
    promo_details = relationship("PromoDetail", back_populates="finish_good")

class SalesPerson(db.Model): # Renamed from SALESMAN for clarity
    __tablename__ = 'SALESMAN'
    COMP_ID = db.Column(db.String(255), db.ForeignKey('COMPANY.COMP_ID'), primary_key=True)
    SALES_ID = db.Column(db.String(255), primary_key=True)
    SALES_PASS = db.Column(db.String(255))
    SALES_NAME = db.Column(db.String(255))
    ROLE = db.Column(db.String(255))
    REG_DATE = db.Column(DateTime)
    EXP_DATE = db.Column(DateTime)

    # Relationships
    company = relationship("Company", back_populates="sales_people")
    bill_headers = relationship("BillHeader", back_populates="sales_person")
    
    __table_args__ = (
        PrimaryKeyConstraint('COMP_ID', 'SALES_ID', name='pk_salesman'),
    )

class PromoHead(db.Model):
    __tablename__ = 'PROMO_HEAD'
    PRO_NO = db.Column(db.String(255), primary_key=True)
    PRO_DESC = db.Column(db.String(255))
    PRO_FGNO = db.Column(db.String(255))

    # Relationships
    bill_details = relationship("BillDetail", back_populates="promo_head")
    bill_promos = relationship("BillPromo", back_populates="promo_head")
    promo_details = relationship("PromoDetail", back_populates="promo_head")


class BillHeader(db.Model):
    __tablename__ = 'BILL_HEAD'
    BILLH_COMP_ID = db.Column(db.String(255), db.ForeignKey('COMPANY.COMP_ID'), primary_key=True)
    BILLH_NO = db.Column(db.String(255), primary_key=True)
    BILLH_DATE = db.Column(DateTime)
    BILLH_CUST_ID = db.Column(db.String(255), db.ForeignKey('CUSTOMER.CUST_ID'))
    BILLH_SALES_ID = db.Column(db.String(255)) # Part of composite FK with BILLH_COMP_ID
    BILLH_FG_GRP = db.Column(db.String(255), db.ForeignKey('PRODGROUP.GRP_ID'))
    BILLH_NUM = db.Column(db.Integer)
    BILLH_AMT = db.Column(Numeric(15, 2))
    BILLH_AMT_VAT = db.Column(Numeric(15, 2))
    BILLH_STATUS = db.Column(db.String(255))
    BILLH_PRINT = db.Column(db.String(255))
    BILLH_LOAD = db.Column(db.String(255))
    BILLH_TOTAMT = db.Column(Numeric(15, 2))
    BILLH_DISCOUNT = db.Column(Numeric(15, 2))
    BILLH_TOTPAY = db.Column(Numeric(15, 2))

    # Relationships
    company = relationship("Company", back_populates="bill_headers")
    customer = relationship("Customer", back_populates="bill_headers")
    sales_person = relationship("SalesPerson", 
                                foreign_keys="[BillHeader.BILLH_COMP_ID, BillHeader.BILLH_SALES_ID]",
                                back_populates="bill_headers")
    prod_group = relationship("ProdGroup", back_populates="bill_headers")
    details = relationship("BillDetail", back_populates="header")
    bill_promos = relationship("BillPromo", back_populates="bill_header")

    __table_args__ = (
        PrimaryKeyConstraint('BILLH_COMP_ID', 'BILLH_NO', name='pk_bill_head'),
        ForeignKeyConstraint(['BILLH_COMP_ID', 'BILLH_SALES_ID'], 
                             ['SALESMAN.COMP_ID', 'SALESMAN.SALES_ID'], 
                             name='fk_billh_salesman')
    )

class BillDetail(db.Model):
    __tablename__ = 'BILL_DETAIL'
    BILLD_COMP_ID = db.Column(db.String(255), primary_key=True)
    BILLD_NO = db.Column(db.String(255), primary_key=True)
    BILLD_LINE = db.Column(db.Integer, primary_key=True)
    BILLD_GOODS_ID = db.Column(db.String(255), db.ForeignKey('FINISH_GOODS.FG_ID'))
    BILLD_GOODS_PRC = db.Column(Numeric(15, 2))
    BILLD_GOODS_NUM = db.Column(Float) # MySQL type was DOUBLE
    BILLD_AMT = db.Column(Numeric(15, 2))
    BILLD_AMT_VAT = db.Column(Numeric(15, 2))
    BILLD_STATUS = db.Column(db.String(255))
    BILLD_LOAD = db.Column(db.String(255))
    BILLD_PROMO = db.Column(db.String(255), db.ForeignKey('PROMO_HEAD.PRO_NO'))

    # Relationships
    header = relationship("BillHeader", 
                          foreign_keys="[BillDetail.BILLD_COMP_ID, BillDetail.BILLD_NO]",
                          back_populates="details")
    finish_good = relationship("FinishGood", back_populates="bill_details")
    promo_head = relationship("PromoHead", back_populates="bill_details")

    __table_args__ = (
        PrimaryKeyConstraint('BILLD_COMP_ID', 'BILLD_NO', 'BILLD_LINE', name='pk_bill_detail'),
        ForeignKeyConstraint(['BILLD_COMP_ID', 'BILLD_NO'], 
                             ['BILL_HEAD.BILLH_COMP_ID', 'BILL_HEAD.BILLH_NO'], 
                             name='fk_billd_bill_head')
    )

class Control(db.Model):
    __tablename__ = 'CONTROL'
    COMP_ID = db.Column(db.String(255), db.ForeignKey('COMPANY.COMP_ID'), primary_key=True)
    PC_ID = db.Column(db.String(255), primary_key=True)
    PC_NAME = db.Column(db.String(255))
    STDATE = db.Column(DateTime)
    SALESDATE = db.Column(DateTime)
    TRANSFERDATE = db.Column(DateTime)
    ACCU_AMT = db.Column(Numeric(15, 2))
    ACCU_BILL = db.Column(db.Integer)
    TODAY_AMT = db.Column(Numeric(15, 2))
    TODAY_BILL = db.Column(db.Integer)
    ACCU_AMT_C = db.Column(Numeric(15, 2))
    ACCU_BILL_C = db.Column(db.Integer)
    TODAY_AMT_C = db.Column(Numeric(15, 2))
    TODAY_BILL_C = db.Column(db.Integer)
    START_BILL_NO = db.Column(db.String(255))
    CUR_BILL_NO = db.Column(db.String(255))

    # Relationships
    company = relationship("Company", back_populates="controls")

    __table_args__ = (
        PrimaryKeyConstraint('COMP_ID', 'PC_ID', name='pk_control'),
    )

class BillPromo(db.Model):
    __tablename__ = 'BILL_PROMO'
    BILLH_COMP_ID = db.Column(db.String(255), primary_key=True)
    BILLH_NO = db.Column(db.String(255), primary_key=True)
    SEQ_NO = db.Column(db.String(255), primary_key=True) # VARCHAR in schema, usually INT for sequence
    PRO_NO = db.Column(db.String(255), db.ForeignKey('PROMO_HEAD.PRO_NO'), nullable=False)

    # Relationships
    bill_header = relationship("BillHeader", 
                               foreign_keys="[BillPromo.BILLH_COMP_ID, BillPromo.BILLH_NO]",
                               back_populates="bill_promos")
    promo_head = relationship("PromoHead", back_populates="bill_promos")
    
    __table_args__ = (
        PrimaryKeyConstraint('BILLH_COMP_ID', 'BILLH_NO', 'SEQ_NO', name='pk_bill_promo'),
        ForeignKeyConstraint(['BILLH_COMP_ID', 'BILLH_NO'],
                             ['BILL_HEAD.BILLH_COMP_ID', 'BILL_HEAD.BILLH_NO'],
                             name='fk_billpromo_bill_head')
    )

class PromoDetail(db.Model):
    __tablename__ = 'PROMO_DETAIL'
    PRO_NO = db.Column(db.String(255), db.ForeignKey('PROMO_HEAD.PRO_NO'), primary_key=True)
    PRO_LN = db.Column(db.String(255), primary_key=True) # VARCHAR in schema, usually INT for line
    PRO_FG_ID = db.Column(db.String(255), db.ForeignKey('FINISH_GOODS.FG_ID'))
    PRO_FG_PRICE = db.Column(Numeric(15, 2))

    # Relationships
    promo_head = relationship("PromoHead", back_populates="promo_details")
    finish_good = relationship("FinishGood", back_populates="promo_details")
    
    __table_args__ = (
        PrimaryKeyConstraint('PRO_NO', 'PRO_LN', name='pk_promo_detail'),
    )

class Programer(db.Model):
    __tablename__ = 'PROGRAMER'
    date = db.Column(DateTime, primary_key=True, name='date') # Quoted 'date' in schema
    author = db.Column(db.String(255), primary_key=True)
    create_date = db.Column(db.String(255)) # VARCHAR in schema

    __table_args__ = (
        PrimaryKeyConstraint('date', 'author', name='pk_programer'),
    )

# To create these tables in the database, you would typically run:
# from pos_app import create_app, db
# app = create_app()
# with app.app_context():
#     db.create_all()
#
# Or using Flask-Migrate for migrations.
# Make sure the database 'py_pos_db' exists and MySQL server is running.
# The connection string in config.py should be correct.
