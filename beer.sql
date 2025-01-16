-- File: canyon_sales_add_transaction.sql

-- 1. Add a New SalesTransaction
-- Adding a new sales transaction
INSERT INTO salestransaction (transaction_id, customer_id, store_id, date_of_transaction)
VALUES (8, 2, 'S1', '2024-01-10');

-- 2. Update the SoldVia Table
-- Adding two purchased items for the new transaction
INSERT INTO soldvia (product_id, transaction_id, quantity)
VALUES 
    (2, 8, 1),  -- Easy Boot, 1 unit
    (3, 8, 3);  -- Cozy Sock, 3 units

-- 3. Query to Show Vendor Name, Product Name, Date Sold, and Quantity Sold
SELECT 
    v.vendor_name, 
    p.product_name, 
    st.date_of_transaction AS date_sold, 
    sv.quantity AS quantity_sold
FROM 
    soldvia sv
JOIN 
    product p ON sv.product_id = p.product_id
JOIN 
    vendor v ON p.vendor_id = v.vendor_id
JOIN 
    salestransaction st ON sv.transaction_id = st.transaction_id;

-- 4. Add the New Data to the Data Warehouse
-- Adding new transaction details to the data warehouse
INSERT INTO fact_sales (sales_id, product_id, customer_id, store_id, time_id, quantity, total_sales)
SELECT 
    ROW_NUMBER() OVER (ORDER BY sv.transaction_id),
    sv.product_id,
    st.customer_id,
    st.store_id,
    t.time_id,
    sv.quantity,
    p.price * sv.quantity
FROM 
    soldvia sv
JOIN 
    salestransaction st ON sv.transaction_id = st.transaction_id
JOIN 
    dim_time t ON t.day = DAYNAME(st.date_of_transaction) 
                AND t.month = MONTHNAME(st.date_of_transaction) 
                AND t.year = YEAR(st.date_of_transaction)
JOIN 
    product p ON sv.product_id = p.product_id
WHERE 
    sv.transaction_id = 8;
