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