-- 1. Create the Database
-- Create the database
CREATE DATABASE CanyonRetailOperations;

-- Select the database for use
USE CanyonRetailOperations;

-- 2. Create Tables

-- 2.1. Vendor
CREATE TABLE vendor (
    vendor_id   CHAR(2)       NOT NULL,
    vendor_name VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_vendor PRIMARY KEY (vendor_id)
);

-- 2.2. Category
CREATE TABLE category (
    category_id   CHAR(2)       NOT NULL,
    category_name VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_category PRIMARY KEY (category_id)
);

-- 2.3. Product
CREATE TABLE product (
    product_id     INT           NOT NULL,
    product_name   VARCHAR(50)   NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    vendor_id      CHAR(2)       NOT NULL,
    category_id    CHAR(2)       NOT NULL,
    CONSTRAINT PK_product PRIMARY KEY (product_id),
    CONSTRAINT FK_product_vendor 
        FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id),
    CONSTRAINT FK_product_category
        FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- 2.4. Region
CREATE TABLE region (
    region_id   CHAR(1)       NOT NULL,
    region_name VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_region PRIMARY KEY (region_id)
);

-- 2.5. Store
CREATE TABLE store (
    store_id   CHAR(2)      NOT NULL,
    zip_code   CHAR(5)      NOT NULL,
    region_id  CHAR(1)      NOT NULL,
    CONSTRAINT PK_store PRIMARY KEY (store_id),
    CONSTRAINT FK_store_region
        FOREIGN KEY (region_id) REFERENCES region(region_id)
);

-- 2.6. Customer
CREATE TABLE customer (
    customer_id   INT          NOT NULL,
    customer_name VARCHAR(50)  NOT NULL,
    zip_code      CHAR(5)      NOT NULL,
    CONSTRAINT PK_customer PRIMARY KEY (customer_id)
);

-- 2.7. SalesTransaction
CREATE TABLE salestransaction (
    transaction_id        INT          NOT NULL,
    customer_id           INT          NOT NULL,
    store_id              CHAR(2)      NOT NULL,
    date_of_transaction   DATE         NOT NULL,
    CONSTRAINT PK_salestransaction PRIMARY KEY (transaction_id),
    CONSTRAINT FK_salestransaction_customer
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT FK_salestransaction_store
        FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- 2.8. SoldVia
CREATE TABLE soldvia (
    product_id     INT  NOT NULL,
    transaction_id INT  NOT NULL,
    quantity       INT  NOT NULL,
    CONSTRAINT PK_soldvia PRIMARY KEY (product_id, transaction_id),
    CONSTRAINT FK_soldvia_product
        FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT FK_soldvia_transaction
        FOREIGN KEY (transaction_id) REFERENCES salestransaction(transaction_id)
);
