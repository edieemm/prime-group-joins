-------------BASE GOALS --------------
-- Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" ON "addresses".customer_id = "customers".id;

-- Get all orders and their line items (orders, quantity and product).
SELECT * FROM "line_items"
JOIN "orders" ON "line_items".order_id = "orders".id
JOIN "products" ON "line_items".product_id = "products".id;

-- Which warehouses have cheetos?
-- -- DELTA
SELECT * FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'cheetos';

-- Which warehouses have diet pepsi?
-- -- ALPHA, DELTA, GAMMA
SELECT * FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'diet pepsi';

-- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "customers".id, "customers".first_name, count("orders") FROM "customers"
JOIN "addresses" ON "addresses".customer_id = "customers".id
JOIN "orders" ON "orders".address_id = "addresses".id
GROUP BY "customers".id;

-- How many customers do we have?
-- -- 4
SELECT count("customers") FROM "customers";

-- How many products do we carry?
-- -- 7
SELECT count("products") FROM "products";

-- What is the total available on-hand quantity of diet pepsi?
-- -- 92
SELECT sum("warehouse_product".on_hand) FROM "warehouse_product"
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'diet pepsi';



-------- STRETCH GOALS -------------
-- How much was the total cost for each order?
SELECT "orders".id, sum("products".unit_price) FROM "orders"
JOIN "line_items" ON "line_items".order_id = "orders".id
JOIN "products" ON "line_items".product_id = "products".id
GROUP BY "orders".id;

-- How much has each customer spent in total?
SELECT "customers".first_name, sum("products".unit_price) FROM "orders"
JOIN "line_items" ON "line_items".order_id = "orders".id
JOIN "products" ON "line_items".product_id = "products".id
JOIN "addresses" ON "orders".address_id = "addresses".id
JOIN "customers" ON "addresses".customer_id = "customers".id
GROUP BY "customers".first_name;

-- How much has each customer spent in total? 
-- Customers who have spent $0 should still show up in the table. 
-- It should say 0, not NULL (research coalesce).
-- -- no