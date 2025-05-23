-- SQL Schema generated from Access table definitions

-- Table: COMPANY
CREATE TABLE COMPANY (
    COMP_ID VARCHAR(255) NOT NULL,
    COMP_NAME VARCHAR(255),
    COMP_ADD1 VARCHAR(255),
    COMP_ADD2 VARCHAR(255),
    COMP_ADD3 VARCHAR(255),
    COMP_POST VARCHAR(255),
    COMP_TAX VARCHAR(255),
    COMP_BRANCH VARCHAR(255),
    PRIMARY KEY (COMP_ID)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: CUSTOMER
CREATE TABLE CUSTOMER (
    CUST_ID VARCHAR(255) NOT NULL,
    CUST_NAME VARCHAR(255),
    PRIMARY KEY (CUST_ID)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: PRODGROUP
CREATE TABLE PRODGROUP (
    GRP_ID VARCHAR(255) NOT NULL,
    GRP_NT VARCHAR(255),
    GRP_NE VARCHAR(255),
    PRIMARY KEY (GRP_ID)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: UNITS
CREATE TABLE UNITS (
    UNITS_ID VARCHAR(255) NOT NULL,
    UNITS_NAME VARCHAR(255),
    PRIMARY KEY (UNITS_ID)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: FINISH_GOODS
CREATE TABLE FINISH_GOODS (
    FG_ID VARCHAR(255) NOT NULL,
    FG_SHORT VARCHAR(255),
    FG_GRP VARCHAR(255),
    FG_UNITS VARCHAR(255),
    FG_BAR_CODE VARCHAR(255),
    FG_GRADE VARCHAR(255),
    FG_DES VARCHAR(255),
    FG_WH VARCHAR(255), -- Assuming Warehouse ID
    FG_PRICE DECIMAL(15,2),
    FG_COST DECIMAL(15,2),
    PRIMARY KEY (FG_ID),
    INDEX idx_fg_grp (FG_GRP),
    INDEX idx_fg_units (FG_UNITS),
    FOREIGN KEY (FG_GRP) REFERENCES PRODGROUP(GRP_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (FG_UNITS) REFERENCES UNITS(UNITS_ID) ON DELETE RESTRICT ON UPDATE CASCADE
    -- Assuming FG_WH might reference a WAREHOUSE table not defined here.
    -- FOREIGN KEY (FG_WH) REFERENCES WAREHOUSE(WH_ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: SALESMAN
CREATE TABLE SALESMAN (
    COMP_ID VARCHAR(255) NOT NULL,
    SALES_ID VARCHAR(255) NOT NULL,
    SALES_PASS VARCHAR(255),
    SALES_NAME VARCHAR(255),
    ROLE VARCHAR(255),
    REG_DATE DATETIME,
    EXP_DATE DATETIME,
    PRIMARY KEY (COMP_ID, SALES_ID),
    INDEX idx_salesman_comp_id (COMP_ID),
    FOREIGN KEY (COMP_ID) REFERENCES COMPANY(COMP_ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: BILL_HEAD
CREATE TABLE BILL_HEAD (
    BILLH_COMP_ID VARCHAR(255) NOT NULL,
    BILLH_NO VARCHAR(255) NOT NULL,
    BILLH_DATE DATETIME,
    BILLH_CUST_ID VARCHAR(255),
    BILLH_SALES_ID VARCHAR(255),
    BILLH_FG_GRP VARCHAR(255), -- This seems like a product group ID
    BILLH_NUM INT, -- Assuming this is a count or sequence, not an amount
    BILLH_AMT DECIMAL(15,2),
    BILLH_AMT_VAT DECIMAL(15,2),
    BILLH_STATUS VARCHAR(255),
    BILLH_PRINT VARCHAR(255),
    BILLH_LOAD VARCHAR(255),
    BILLH_TOTAMT DECIMAL(15,2),
    BILLH_DISCOUNT DECIMAL(15,2),
    BILLH_TOTPAY DECIMAL(15,2),
    PRIMARY KEY (BILLH_COMP_ID, BILLH_NO),
    INDEX idx_billh_comp_id (BILLH_COMP_ID),
    INDEX idx_billh_cust_id (BILLH_CUST_ID),
    INDEX idx_billh_sales_id (BILLH_SALES_ID),
    INDEX idx_billh_fg_grp (BILLH_FG_GRP),
    FOREIGN KEY (BILLH_COMP_ID) REFERENCES COMPANY(COMP_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (BILLH_CUST_ID) REFERENCES CUSTOMER(CUST_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (BILLH_COMP_ID, BILLH_SALES_ID) REFERENCES SALESMAN(COMP_ID, SALES_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (BILLH_FG_GRP) REFERENCES PRODGROUP(GRP_ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: BILL_DETAIL
CREATE TABLE BILL_DETAIL (
    BILLD_COMP_ID VARCHAR(255) NOT NULL,
    BILLD_NO VARCHAR(255) NOT NULL,
    BILLD_LINE INT NOT NULL,
    BILLD_GOODS_ID VARCHAR(255),
    BILLD_GOODS_PRC DECIMAL(15,2),
    BILLD_GOODS_NUM DOUBLE, -- Number of goods, can be fractional
    BILLD_AMT DECIMAL(15,2),
    BILLD_AMT_VAT DECIMAL(15,2),
    BILLD_STATUS VARCHAR(255),
    BILLD_LOAD VARCHAR(255),
    BILLD_PROMO VARCHAR(255), -- Potentially references PROMO_HEAD
    PRIMARY KEY (BILLD_COMP_ID, BILLD_NO, BILLD_LINE),
    INDEX idx_billd_comp_id_no (BILLD_COMP_ID, BILLD_NO),
    INDEX idx_billd_goods_id (BILLD_GOODS_ID),
    -- BILLD_PROMO might reference PROMO_HEAD.PRO_NO. Assuming it for now.
    -- If PROMO_HEAD has a composite key with COMP_ID, that should be reflected here.
    -- For now, assuming PROMO_HEAD.PRO_NO is unique across companies for simplicity or PROMO_HEAD has PRO_NO as PK.
    INDEX idx_billd_promo (BILLD_PROMO),
    FOREIGN KEY (BILLD_COMP_ID, BILLD_NO) REFERENCES BILL_HEAD(BILLH_COMP_ID, BILLH_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (BILLD_GOODS_ID) REFERENCES FINISH_GOODS(FG_ID) ON DELETE RESTRICT ON UPDATE CASCADE
    -- FOREIGN KEY (BILLD_PROMO) REFERENCES PROMO_HEAD(PRO_NO) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: PROMO_HEAD
CREATE TABLE PROMO_HEAD (
    PRO_NO VARCHAR(255) NOT NULL,
    PRO_DESC VARCHAR(255),
    PRO_FGNO VARCHAR(255), -- This might be a count of items in promo or a specific FG_ID. Clarification needed.
                           -- Assuming it's a descriptive field for now.
    PRIMARY KEY (PRO_NO)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Now that PROMO_HEAD is defined, we can alter BILL_DETAIL if BILLD_PROMO references it.
-- ALTER TABLE BILL_DETAIL
-- ADD CONSTRAINT fk_billd_promo FOREIGN KEY (BILLD_PROMO) REFERENCES PROMO_HEAD(PRO_NO) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Table: BILL_PROMO
CREATE TABLE BILL_PROMO (
    BILLH_COMP_ID VARCHAR(255) NOT NULL, -- Should be BILLD_COMP_ID to match BILL_DETAIL? Or is it related to BILL_HEAD?
                                      -- Assuming it relates to BILL_HEAD as per column name prefix.
    BILLH_NO VARCHAR(255) NOT NULL,    -- Same as above.
    SEQ_NO VARCHAR(255) NOT NULL,      -- Sequence number for multiple promos on one bill
    PRO_NO VARCHAR(255) NOT NULL,
    PRIMARY KEY (BILLH_COMP_ID, BILLH_NO, SEQ_NO),
    INDEX idx_billpromo_comp_id_no (BILLH_COMP_ID, BILLH_NO),
    INDEX idx_billpromo_pro_no (PRO_NO),
    FOREIGN KEY (BILLH_COMP_ID, BILLH_NO) REFERENCES BILL_HEAD(BILLH_COMP_ID, BILLH_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (PRO_NO) REFERENCES PROMO_HEAD(PRO_NO) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: CONTROL
CREATE TABLE CONTROL (
    COMP_ID VARCHAR(255) NOT NULL,
    PC_ID VARCHAR(255) NOT NULL, -- Assuming PC_ID is part of the PK
    PC_NAME VARCHAR(255),
    STDATE DATETIME,
    SALESDATE DATETIME,
    TRANSFERDATE DATETIME,
    ACCU_AMT DECIMAL(15,2),
    ACCU_BILL INT,
    TODAY_AMT DECIMAL(15,2),
    TODAY_BILL INT,
    ACCU_AMT_C DECIMAL(15,2),
    ACCU_BILL_C INT,
    TODAY_AMT_C DECIMAL(15,2),
    TODAY_BILL_C INT,
    START_BILL_NO VARCHAR(255),
    CUR_BILL_NO VARCHAR(255),
    PRIMARY KEY (COMP_ID, PC_ID),
    INDEX idx_control_comp_id (COMP_ID),
    FOREIGN KEY (COMP_ID) REFERENCES COMPANY(COMP_ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Table: PROGRAMER
CREATE TABLE PROGRAMER (
    `date` DATETIME, -- 'date' is a reserved keyword, quoted
    author VARCHAR(255),
    create_date VARCHAR(255) -- Assuming this is a string like 'YYYY-MM-DD' rather than a DATETIME. If DATETIME, change type.
    -- No obvious primary key. For now, let's assume (author, create_date) or (`date`, author) could be unique.
    -- Adding a surrogate primary key if no natural key is evident or suitable.
    -- PROGRAMER_ID INT AUTO_INCREMENT PRIMARY KEY
    -- For now, leaving without explicit PK as per Access definition unless one is implied.
    -- If this table is for logging, a timestamp might be a good PK or part of one.
) ENGINE=InnoDB CHARSET=utf8mb4;
-- To make it valid, let's add a composite PK, assuming date+author is unique for an entry.
ALTER TABLE PROGRAMER ADD PRIMARY KEY (`date`, author);


-- Table: PROMO_DETAIL
CREATE TABLE PROMO_DETAIL (
    PRO_NO VARCHAR(255) NOT NULL,
    PRO_LN VARCHAR(255) NOT NULL, -- Line number for the promo
    PRO_FG_ID VARCHAR(255),
    PRO_FG_PRICE DECIMAL(15,2),
    PRIMARY KEY (PRO_NO, PRO_LN),
    INDEX idx_promodetail_pro_no (PRO_NO),
    INDEX idx_promodetail_fg_id (PRO_FG_ID),
    FOREIGN KEY (PRO_NO) REFERENCES PROMO_HEAD(PRO_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (PRO_FG_ID) REFERENCES FINISH_GOODS(FG_ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Final check for BILL_DETAIL's BILLD_PROMO FK, uncomment if PROMO_HEAD.PRO_NO is the correct reference
-- If PROMO_HEAD might have COMP_ID as part of its key, then BILL_DETAIL's FK needs to include BILLD_COMP_ID.
-- For now, the current setup assumes PRO_NO in PROMO_HEAD is globally unique or BILLD_PROMO refers to this global PRO_NO.

-- Consider adding an explicit primary key to PROGRAMER table if needed, e.g., an auto-incrementing ID.
-- CREATE TABLE PROGRAMER (
--     PROGRAMER_ID INT AUTO_INCREMENT NOT NULL,
--     `date` DATETIME,
--     author VARCHAR(255),
--     create_date VARCHAR(255),
--     PRIMARY KEY (PROGRAMER_ID),
--     UNIQUE KEY uq_programer_date_author (`date`, author) -- If date and author should be unique together
-- ) ENGINE=InnoDB CHARSET=utf8mb4;
-- The ALTER TABLE statement for PROGRAMER above adds a PK.

-- Re-enabling the FK for BILL_DETAIL to PROMO_HEAD as it's likely intended.
ALTER TABLE BILL_DETAIL
ADD CONSTRAINT fk_billd_promo FOREIGN KEY (BILLD_PROMO) REFERENCES PROMO_HEAD(PRO_NO) ON DELETE RESTRICT ON UPDATE CASCADE;
-- This assumes BILLD_PROMO directly maps to PRO_NO. If PROMO_HEAD is company-specific (e.g. PK is COMP_ID, PRO_NO),
-- then BILL_DETAIL would need a composite foreign key (BILLD_COMP_ID, BILLD_PROMO) referencing PROMO_HEAD(COMP_ID, PRO_NO).
-- The current PROMO_HEAD definition does not include COMP_ID in its PK.

-- Note on BILL_PROMO:
-- BILLH_COMP_ID, BILLH_NO suggests it links a Promotion (PRO_NO) directly to a Bill Header (BILL_HEAD).
-- This seems reasonable.

-- Note on BILL_HEAD.BILLH_SALES_ID:
-- The FK is (BILLH_COMP_ID, BILLH_SALES_ID) to SALESMAN(COMP_ID, SALES_ID). This is correct.

-- Note on VARCHAR lengths:
-- Used VARCHAR(255) as a default. This should be reviewed and adjusted based on actual maximum data lengths.

-- Note on DOUBLE vs DECIMAL:
-- BILLD_GOODS_NUM is kept as DOUBLE as it's a quantity.
-- Amounts (prices, totals) are DECIMAL(15,2). This precision (15 total digits, 2 after decimal) is a common choice for currency.
-- ACCU_AMT, TODAY_AMT etc in CONTROL table also mapped to DECIMAL(15,2).

-- Note on PROGRAMER table:
-- `date` column is quoted as it's a reserved word.
-- `create_date` is VARCHAR, assuming it stores date as string. If it's an actual date, DATETIME would be better.
-- Added a PK (`date`, `author`) via ALTER TABLE as an example of making it valid if no single column PK is obvious.
-- If this table is purely for logging and entries are not unique by (date, author), then an auto-incrementing ID would be better.
-- The problem description does not specify a PK for PROGRAMER.
-- The initial `CREATE TABLE PROGRAMER` has been modified by an `ALTER TABLE` to add a PK.
-- For a cleaner final script, the PK should be in the `CREATE TABLE` statement itself if decided.
-- Let's redefine PROGRAMER with the PK directly for clarity.

-- Redefining PROGRAMER with PK for clarity (instead of ALTER)
DROP TABLE IF EXISTS PROGRAMER; -- Remove table if it was created by the statement above
CREATE TABLE PROGRAMER (
    `date` DATETIME NOT NULL,
    author VARCHAR(255) NOT NULL,
    create_date VARCHAR(255), -- Consider DATETIME if it's an actual date
    PRIMARY KEY (`date`, author)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Final considerations:
-- BILL_DETAIL.BILLD_PROMO FK to PROMO_HEAD.PRO_NO: This assumes PRO_NO is unique across all promotions.
-- If PROMO_HEAD promotions can be company-specific (e.g., PROMO_HEAD has a PK of COMP_ID, PRO_NO), then:
-- 1. PROMO_HEAD primary key would need to be (COMP_ID, PRO_NO).
-- 2. BILL_DETAIL would need a foreign key like (BILLD_COMP_ID, BILLD_PROMO) referencing PROMO_HEAD(COMP_ID, PRO_NO).
-- 3. BILL_PROMO would need a foreign key like (BILLH_COMP_ID, PRO_NO) referencing PROMO_HEAD(COMP_ID, PRO_NO).
-- Given the current definition of PROMO_HEAD (PK is PRO_NO only), the current FKs are consistent with that.
-- If COMP_ID should be part of PROMO_HEAD's key, PROMO_HEAD definition needs to change first.

-- Assuming current definitions are intentional.
-- The script should now be complete based on the requirements and assumptions made.
-- The `ALTER TABLE BILL_DETAIL ADD CONSTRAINT fk_billd_promo...` is important.
