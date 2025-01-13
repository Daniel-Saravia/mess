# Canyon Retail Company Sales Database Requirements

## 1. Create the Database

```sql
-- Create the database
CREATE DATABASE CanyonRetailOperations;

-- Select the database for use
USE CanyonRetailOperations;
```

---

## 2. Create Tables

### 2.1. Vendor

```sql
CREATE TABLE vendor (
    vendor_id   CHAR(2)       NOT NULL,
    vendor_name VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_vendor PRIMARY KEY (vendor_id)
);
```

### 2.2. Category

```sql
CREATE TABLE category (
    category_id   CHAR(2)       NOT NULL,
    category_name VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_category PRIMARY KEY (category_id)
);
```

### 2.3. Product

```sql
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
```

### 2.4. Region

```sql
CREATE TABLE region (
    region_id   CHAR(1)       NOT NULL,
    region_name VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_region PRIMARY KEY (region_id)
);
```

### 2.5. Store

```sql
CREATE TABLE store (
    store_id   CHAR(2)      NOT NULL,
    zip_code   CHAR(5)      NOT NULL,
    region_id  CHAR(1)      NOT NULL,
    CONSTRAINT PK_store PRIMARY KEY (store_id),
    CONSTRAINT FK_store_region
        FOREIGN KEY (region_id) REFERENCES region(region_id)
);
```

### 2.6. Customer

```sql
CREATE TABLE customer (
    customer_id   INT          NOT NULL,
    customer_name VARCHAR(50)  NOT NULL,
    zip_code      CHAR(5)      NOT NULL,
    CONSTRAINT PK_customer PRIMARY KEY (customer_id)
);
```

### 2.7. SalesTransaction

```sql
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
```

### 2.8. SoldVia

```sql
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
```

---

## 3. Insert Sample Data

### 3.1. Vendors

```sql
INSERT INTO vendor VALUES ('PG', 'Pacific Gear');
INSERT INTO vendor VALUES ('MK', 'Mountain King');
```

### 3.2. Categories

```sql
INSERT INTO category VALUES ('CP', 'Camping');
INSERT INTO category VALUES ('FW', 'Footwear');
```

### 3.3. Products

```sql
INSERT INTO product VALUES (1, 'Zzz Bag',      100, 'PG', 'CP');
INSERT INTO product VALUES (2, 'Easy Boot',     70, 'MK', 'FW');
INSERT INTO product VALUES (3, 'Cozy Sock',     15, 'MK', 'FW');
INSERT INTO product VALUES (4, 'Dura Boot',     90, 'PG', 'FW');
INSERT INTO product VALUES (5, 'Tiny Tent',    150, 'MK', 'CP');
INSERT INTO product VALUES (6, 'Medium Tent',  200, 'MK', 'CP');
INSERT INTO product VALUES (7, 'Biggy Tent',   250, 'MK', 'CP');
```

### 3.4. Regions

```sql
INSERT INTO region VALUES ('C', 'Chicagoland');
INSERT INTO region VALUES ('T', 'Tristate');
```

### 3.5. Stores

```sql
INSERT INTO store VALUES ('S1', '60600', 'C');
INSERT INTO store VALUES ('S2', '60605', 'C');
INSERT INTO store VALUES ('S3', '35400', 'T');
```

### 3.6. Customers

```sql
INSERT INTO customer VALUES (1, 'Tina Adams',     '60137');
INSERT INTO customer VALUES (2, 'Tony Barksdale', '60611');
INSERT INTO customer VALUES (3, 'Pam Connor',     '35401');
INSERT INTO customer VALUES (4, 'Paul Davis',     '35406');
INSERT INTO customer VALUES (5, 'Amy Evans',      '35401');
```

### 3.7. Sales Transactions

```sql
INSERT INTO salestransaction VALUES (1, 1, 'S1', '2024-01-01');
INSERT INTO salestransaction VALUES (2, 2, 'S2', '2024-01-01');
INSERT INTO salestransaction VALUES (3, 1, 'S3', '2024-01-02');
INSERT INTO salestransaction VALUES (4, 3, 'S3', '2024-01-02');
INSERT INTO salestransaction VALUES (5, 2, 'S3', '2024-01-02');
INSERT INTO salestransaction VALUES (6, 5, 'S1', '2024-01-03');
INSERT INTO salestransaction VALUES (7, 4, 'S2', '2024-01-03');
```

### 3.8. SoldVia

```sql
INSERT INTO soldvia VALUES (1, 1, 1);
INSERT INTO soldvia VALUES (2, 2, 1);
INSERT INTO soldvia VALUES (3, 3, 5);
INSERT INTO soldvia VALUES (1, 3, 1);
INSERT INTO soldvia VALUES (4, 4, 1);
INSERT INTO soldvia VALUES (2, 4, 2);
INSERT INTO soldvia VALUES (4, 5, 4);
INSERT INTO soldvia VALUES (7, 5, 2);
INSERT INTO soldvia VALUES (6, 5, 5);
INSERT INTO soldvia VALUES (2, 6, 4);
INSERT INTO soldvia VALUES (3, 6, 7);
INSERT INTO soldvia VALUES (1, 7, 3);
INSERT INTO soldvia VALUES (5, 7, 7);
```

---

## 4. Verifying the Design

- **Vendors → Products**: A vendor can supply multiple products, but each product is associated with exactly one vendor (via `vendor_id` in `product`).
- **Categories → Products**: A category can hold multiple products, each product belongs to exactly one category (via `category_id` in `product`).
- **Regions → Stores**: A region can contain multiple stores, each store belongs to exactly one region (via `region_id` in `store`).
- **Stores → Sales Transactions**: A store can have many transactions, each transaction is associated with exactly one store (via `store_id` in `salestransaction`).
- **Customers → Sales Transactions**: A customer can have multiple transactions, each transaction is for exactly one customer (via `customer_id` in `salestransaction`).
- **Products ↔ Sales Transactions**: Products and transactions have a many-to-many relationship bridged by `soldvia(product_id, transaction_id, quantity)`.

---

## Final Thoughts

This completes a straightforward **third normal form (3NF)** approach for the Canyon Retail Company’s sales database.

