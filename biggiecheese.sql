-- File: canyon_sales_update.sql

-- 1. Add a New Item to SalesTransaction T007
-- Insert 'Easy Boot' with quantity 2 into the SoldVia table
INSERT INTO soldvia (product_id, transaction_id, quantity)
VALUES (2, 7, 2);

-- 2. Select Customer Name, Item Ordered, and Quantity
-- Query to display customer name, product name, and quantity for each transaction
SELECT 
    c.customer_name, 
    p.product_name, 
    sv.quantity
FROM 
    customer c
JOIN 
    salestransaction st ON c.customer_id = st.customer_id
JOIN 
    soldvia sv ON st.transaction_id = sv.transaction_id
JOIN 
    product p ON sv.product_id = p.product_id;

-- 3. Add the New SoldVia Transaction to the Data Warehouse
-- Assuming the data warehouse table is dw_soldvia
INSERT INTO dw_soldvia (product_id, transaction_id, quantity)
VALUES (2, 7, 2);

-- Optionally, migrate the transaction using SELECT for verification
INSERT INTO dw_soldvia (product_id, transaction_id, quantity)
SELECT 
    product_id, transaction_id, quantity
FROM 
    soldvia
WHERE 
    transaction_id = 7 AND product_id = 2;
