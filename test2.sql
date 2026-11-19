SELECT * FROM `sql-project-515211.sqlproject.customers_orders` LIMIT 1000

-- standardize order_status
SELECT order_status,
CASE 
 WHEN LOWER(order_status) LIKE '%deliver%' THEN 'Delivered'
 WHEN LOWER(order_status) LIKE '%return%' THEN 'Returned'
 WHEN LOWER(order_status) LIKE '%refund%' THEN 'Refunded'
 WHEN LOWER(order_status) LIKE '%pend%' THEN 'Pending'
 WHEN LOWER(order_status) LIKE '%ship%' THEN 'Shipped'
 ELSE 'Other'
END AS cleaned_order_status
FROM `sql-project-515211.sqlproject.customers_orders`

-- standardize product_name
SELECT order_status,
CASE 
 WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
 WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
 WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
 WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'Macbook Pro'
 WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'iPhone 14'
 ELSE 'Other'
END AS cleaned_order_name
FROM `sql-project-515211.sqlproject.customers_orders`

-- clean quantity
SELECT *,
CASE 
 WHEN LOWER(quantity) = 'two' THEN 2
 ELSE CAST(quantity AS INT64)
END AS cleaned_quantity
FROM `sql-project-515211.sqlproject.customers_orders`

-- clean customer name field
SELECT customer_name,
INITCAP(customer_name) AS customer_name
FROM `sql-project-515211.sqlproject.customers_orders`
WHERE customer_name IS NOT NULL

-- remove duplicated orders
SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER (
  PARTITION BY LOWER(email), LOWER(product_name)
  ORDER BY order_id
) AS rn
FROM `sql-project-515211.sqlproject.customers_orders`
) 
WHERE rn = 1

-- final cleaned data
WITH cleaned_data AS (
  SELECT 
    order_id,

    -- Clean customer name
    INITCAP(customer_name) AS customer_name,
    email,

    -- Standardize product name
    CASE 
      WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
      WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
      WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
      WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
      WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'iPhone 14'
      ELSE 'Other'
    END AS cleaned_product_name,

    -- Clean quantity
    CASE 
      WHEN LOWER(CAST(quantity AS STRING)) = 'two' THEN 2
      ELSE CAST(quantity AS INT64)
    END AS cleaned_quantity,

    -- Standardize date
    COALESCE(
      SAFE.PARSE_DATE('%Y-%m-%d', CAST(order_date AS STRING)),
      SAFE.PARSE_DATE('%m/%d/%Y', CAST(order_date AS STRING))
    ) AS standardized_order_date

  FROM `sql-project-515211.sqlproject.customers_orders`
  WHERE customer_name IS NOT NULL
),

deduplicated_data AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY LOWER(email), LOWER(cleaned_product_name)
      ORDER BY order_id
    ) AS rn
  FROM cleaned_data
),

final_table AS (
SELECT *
FROM deduplicated_data
WHERE rn = 1
)

SELECT * FROM final_table
