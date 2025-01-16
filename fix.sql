-- File: canyon_sales_fact_dim.sql

-- Create the dim_time table
CREATE TABLE dim_time (
    time_id INT IDENTITY(1,1) PRIMARY KEY,
    day VARCHAR(10),
    month VARCHAR(10),
    quarter CHAR(2),
    year INT
);

-- Populate the dim_time table
INSERT INTO dim_time (day, month, quarter, year)
SELECT 
    DATENAME(WEEKDAY, date_of_transaction) AS day,
    DATENAME(MONTH, date_of_transaction) AS month,
    CONCAT('Q', DATEPART(QUARTER, date_of_transaction)) AS quarter,
    YEAR(date_of_transaction) AS year
FROM 
    salestransaction
GROUP BY 
    DATENAME(WEEKDAY, date_of_transaction),
    DATENAME(MONTH, date_of_transaction),
    DATEPART(QUARTER, date_of_transaction),
    YEAR(date_of_transaction);

-- Insert new sales transaction
INSERT INTO salestransaction (transaction_id, customer_id, store_id, date_of_transaction)
VALUES (8, 2, 'S1', '2024-01-10');

-- Update the SoldVia table with purchased items
INSERT INTO soldvia (product_id, transaction_id, quantity)
VALUES 
    (2, 8, 1),  -- Easy Boot, 1 unit
    (3, 8, 3);  -- Cozy Sock, 3 units

-- Insert new transaction into fact_sales
INSERT INTO fact_sales (sales_id, product_id, customer_id, store_id, time_id, quantity, total_sales)
SELECT 
    ROW_NUMBER() OVER (ORDER BY sv.transaction_id) AS sales_id,
    sv.product_id,
    st.customer_id,
    st.store_id,
    t.time_id,
    sv.quantity,
    p.price * sv.quantity AS total_sales
FROM 
    soldvia sv
JOIN 
    salestransaction st ON sv.transaction_id = st.transaction_id
JOIN 
    dim_time t ON t.day = DATENAME(WEEKDAY, st.date_of_transaction) 
                AND t.month = DATENAME(MONTH, st.date_of_transaction) 
                AND t.year = YEAR(st.date_of_transaction)
JOIN 
    product p ON sv.product_id = p.product_id
WHERE 
    sv.transaction_id = 8;

-- Verify dim_time table population
SELECT * FROM dim_time;
