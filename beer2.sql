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
