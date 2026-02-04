------Retail Sales Data Analysis--------------

use Retail_sales_data_analysis;

select * from Sales;

-- Count total records
SELECT COUNT(*) AS total_records
FROM sales;

-- Check distinct customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales;


-- Total sales revenue
SELECT 
    SUM(quantity * Price_per_Unit) AS total_revenue
FROM sales;

-- Revenue by product
SELECT 
    Product_Category,
    SUM(quantity * Price_per_Unit) AS revenue
FROM sales
GROUP BY Product_Category
ORDER BY revenue DESC;


-- Daily sales trend
SELECT 
    date,
    SUM(quantity * Price_per_Unit) AS daily_sales
FROM sales
GROUP BY date
ORDER BY date;

-- Monthly sales
SELECT 
    EXTRACT(MONTH FROM date) AS month,
    SUM(quantity * Price_per_Unit) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;

-- Top 10 customers by revenue
SELECT 
    customer_id,
    SUM(quantity * Price_per_Unit) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC;

-- Average order value per customer
SELECT 
    customer_id,
    AVG(quantity * Price_per_Unit) AS avg_order_value
FROM sales
GROUP BY customer_id;

-- Best-selling products (by quantity)
SELECT 
    Product_Category,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY Product_Category
ORDER BY total_quantity DESC;

------- Low-performing products
SELECT 
    Product_Category,
    SUM(quantity * Price_per_Unit) AS revenue
FROM sales
GROUP BY Product_Category
ORDER BY revenue ASC;

-- Rank products by revenue
SELECT 
    Product_Category,
    SUM(quantity * Price_per_Unit) AS revenue,
    RANK() OVER (ORDER BY SUM(quantity * price_per_unit) DESC) AS revenue_rank
FROM sales
GROUP BY Product_Category;

--- Running total of sales
SELECT 
    date,
    SUM(quantity * Price_per_Unit) AS daily_sales,
    SUM(SUM(quantity * Price_per_Unit)) OVER (ORDER BY date) AS running_total
FROM sales
GRoup by date
ORDER BY date;

-- Find NULL values
SELECT *
FROM sales
WHERE customer_id IS NULL 
   OR Product_Category IS NULL;

   -- Duplicate records
SELECT transaction_id, COUNT(*)
FROM sales
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

-- Recency: Days since last purchase
SELECT 
    customer_id,
    MAX(date) AS last_purchase_date
FROM sales
GROUP BY customer_id;

-- -- Frequency: Total orders per customer
SELECT 
    customer_id,
    COUNT(DISTINCT transaction_id) AS frequency
FROM sales
GROUP BY customer_id;

-- First purchase date per customer
SELECT 
    customer_id,
    MIN(date) AS first_purchase_date
FROM sales
GROUP BY customer_id;

-- Order size segmentation
SELECT 
    Transaction_ID,
    SUM(quantity * Price_per_Unit) AS order_value,
    CASE 
        WHEN SUM(quantity * Price_per_Unit) < 500 THEN 'Low'
        WHEN SUM(quantity * Price_per_Unit) BETWEEN 500 AND 2000 THEN 'Medium'
        ELSE 'High'
    END AS order_category
FROM sales
GROUP BY Transaction_ID;

-- Fast-moving products
SELECT 
    Product_Category,
    SUM(quantity) AS units_sold
FROM sales
GROUP BY Product_Category
ORDER BY units_sold DESC;