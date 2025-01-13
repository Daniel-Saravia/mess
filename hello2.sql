-- 3. Insert Sample Data

-- 3.1. Vendors
INSERT INTO vendor VALUES ('PG', 'Pacific Gear');
INSERT INTO vendor VALUES ('MK', 'Mountain King');

-- 3.2. Categories
INSERT INTO category VALUES ('CP', 'Camping');
INSERT INTO category VALUES ('FW', 'Footwear');

-- 3.3. Products
INSERT INTO product VALUES (1, 'Zzz Bag',      100, 'PG', 'CP');
INSERT INTO product VALUES (2, 'Easy Boot',     70, 'MK', 'FW');
INSERT INTO product VALUES (3, 'Cozy Sock',     15, 'MK', 'FW');
INSERT INTO product VALUES (4, 'Dura Boot',     90, 'PG', 'FW');
INSERT INTO product VALUES (5, 'Tiny Tent',    150, 'MK', 'CP');
INSERT INTO product VALUES (6, 'Medium Tent',  200, 'MK', 'CP');
INSERT INTO product VALUES (7, 'Biggy Tent',   250, 'MK', 'CP');

-- 3.4. Regions
INSERT INTO region VALUES ('C', 'Chicagoland');
INSERT INTO region VALUES ('T', 'Tristate');

-- 3.5. Stores
INSERT INTO store VALUES ('S1', '60600', 'C');
INSERT INTO store VALUES ('S2', '60605', 'C');
INSERT INTO store VALUES ('S3', '35400', 'T');

-- 3.6. Customers
INSERT INTO customer VALUES (1, 'Tina Adams',     '60137');
INSERT INTO customer VALUES (2, 'Tony Barksdale', '60611');
INSERT INTO customer VALUES (3, 'Pam Connor',     '35401');
INSERT INTO customer VALUES (4, 'Paul Davis',     '35406');
INSERT INTO customer VALUES (5, 'Amy Evans',      '35401');

-- 3.7. Sales Transactions
INSERT INTO salestransaction VALUES (1, 1, 'S1', '2024-01-01');
INSERT INTO salestransaction VALUES (2, 2, 'S2', '2024-01-01');
INSERT INTO salestransaction VALUES (3, 1, 'S3', '2024-01-02');
INSERT INTO salestransaction VALUES (4, 3, 'S3', '2024-01-02');
INSERT INTO salestransaction VALUES (5, 2, 'S3', '2024-01-02');
INSERT INTO salestransaction VALUES (6, 5, 'S1', '2024-01-03');
INSERT INTO salestransaction VALUES (7, 4, 'S2', '2024-01-03');

-- 3.8. SoldVia
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
