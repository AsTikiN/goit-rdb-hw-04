-- ДЗ4, пункти 3–4. База теми 3.
-- Зв'язки:
--   order_details.order_id   = orders.id
--   order_details.product_id = products.id
--   products.category_id     = categories.id
--   products.supplier_id     = suppliers.id
--   orders.customer_id       = customers.id
--   orders.employee_id       = employees.employee_id
--   orders.shipper_id        = shippers.id

USE goit_rdb_hw_03;

-- 3. Усі вісім таблиць через INNER JOIN.
SELECT *
FROM order_details
INNER JOIN orders ON orders.id = order_details.order_id
INNER JOIN products ON products.id = order_details.product_id
INNER JOIN categories ON categories.id = products.category_id
INNER JOIN customers ON customers.id = orders.customer_id
INNER JOIN employees ON employees.employee_id = orders.employee_id
INNER JOIN shippers ON shippers.id = orders.shipper_id
INNER JOIN suppliers ON suppliers.id = products.supplier_id;

-- 4.1 Скільки рядків дав попередній запит.
-- На цьому CSV: 518. Це число рядків order_details:
-- кожна позиція має рівно одне замовлення, товар, категорію,
-- постачальника, клієнта, співробітника і перевізника.
SELECT COUNT(*) AS inner_join_rows
FROM order_details
INNER JOIN orders ON orders.id = order_details.order_id
INNER JOIN products ON products.id = order_details.product_id
INNER JOIN categories ON categories.id = products.category_id
INNER JOIN customers ON customers.id = orders.customer_id
INNER JOIN employees ON employees.employee_id = orders.employee_id
INNER JOIN shippers ON shippers.id = orders.shipper_id
INNER JOIN suppliers ON suppliers.id = products.supplier_id;

-- 4.2 Кілька INNER замінено на LEFT і RIGHT.
-- Відповідь, чому кількість не змінюється: p4_join_explanation.txt
SELECT COUNT(*) AS outer_join_rows
FROM order_details
LEFT JOIN orders ON orders.id = order_details.order_id
INNER JOIN products ON products.id = order_details.product_id
INNER JOIN categories ON categories.id = products.category_id
INNER JOIN customers ON customers.id = orders.customer_id
RIGHT JOIN employees ON employees.employee_id = orders.employee_id
INNER JOIN shippers ON shippers.id = orders.shipper_id
INNER JOIN suppliers ON suppliers.id = products.supplier_id;

-- 4.3–4.7 Один запит, умови додаються по черзі.
-- employee_id > 3 і <= 10, група за назвою категорії,
-- середня кількість у позиції > 21, спадання за числом рядків,
-- чотири рядки, перший пропущено.
SELECT
  categories.name AS category_name,
  COUNT(*) AS row_count,
  AVG(order_details.quantity) AS avg_quantity
FROM order_details
INNER JOIN orders ON orders.id = order_details.order_id
INNER JOIN products ON products.id = order_details.product_id
INNER JOIN categories ON categories.id = products.category_id
INNER JOIN customers ON customers.id = orders.customer_id
INNER JOIN employees ON employees.employee_id = orders.employee_id
INNER JOIN shippers ON shippers.id = orders.shipper_id
INNER JOIN suppliers ON suppliers.id = products.supplier_id
WHERE employees.employee_id > 3
  AND employees.employee_id <= 10
GROUP BY categories.name
HAVING AVG(order_details.quantity) > 21
ORDER BY row_count DESC
LIMIT 4 OFFSET 1;
