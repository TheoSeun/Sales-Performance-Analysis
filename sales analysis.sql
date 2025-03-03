-- 1. What is the total sales amount?
SELECT Sum(amount) as Total_amount
FROM sales.order_details;

-- 2. What is the total profit?
SELECT Sum(profit) as Total_profit
FROM sales.order_details;

-- 3. What is the total quantity of products sold?
SELECT sum(quantity)
FROM sales.order_details;

-- 4. What is the average order value (total sales / number of orders)?
SELECT Sum(amount) / Count(distinct order_id) as average_order_value
FROM sales.order_details;

-- 5. How many unique customers have placed orders?
SELECT Count(distinct CustomerName) as no_of_customers
FROM sales.list_of_orders;

-- 6. What are the total sales per month?
SELECT date_format(loo.order_date, '%Y-%m') as month, sum(od.amount) as total_sales
FROM sales.order_details as od
INNER JOIN sales.list_of_orders as loo
	ON od.Order_id = loo.Order_id
GROUP BY month
ORDER BY month;

-- 7. What are the total profits per month?
SELECT 
    DATE_FORMAT(loo.order_date, '%Y-%m') AS month,
    SUM(od.Profit) AS total_profit
FROM
    sales.order_details AS od
        INNER JOIN
    sales.list_of_orders AS loo ON od.Order_id = loo.Order_id
GROUP BY month
ORDER BY month;

-- 10. What is the total sales amount for each product category?
SELECT sum(amount) as total_sales, category
FROM sales.order_details
GROUP BY Category;

-- 11. What is the total profit for each product category?
SELECT sum(profit) as total_profit, category
FROM sales.order_details
GROUP BY Category;

-- 12. Which category has the highest sales?
SELECT  category, sum(amount) as total_sales
FROM sales.order_details
GROUP BY Category
ORDER BY total_sales Desc
Limit 1;

-- 13. Which category has the highest profit?
SELECT category, sum(profit) as total_profit
FROM sales.order_details
GROUP BY Category
ORDER BY total_profit Desc
Limit 1;

-- 16. Compare actual sales vs. sales targets for each category per month.
SELECT date_format(loo.order_date, '%Y-%m' ) as month, sum(od.amount) as total_sales, st.target, st.Category
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON od.order_id = loo.order_id
INNER JOIN sales.sales_target as st
	ON od.category = st.category
GROUP BY month, st.category, st.target;

-- 17. Which categories failed to meet their sales targets?
SELECT od.category, SUM(od.amount) AS actual_sales, st.target
FROM sales.order_details AS od
INNER JOIN sales.sales_target AS st 
	ON od.category = st.category
GROUP BY od.category, st.target
HAVING st.target > actual_sales;
    
-- 18. By how much did each category exceed or fall short of the sales target?
SELECT 
    od.category, 
    SUM(od.amount) AS actual_sales, 
    st.target AS sales_target, 
    (SUM(od.amount) - st.target) AS difference
FROM sales.order_details AS od
INNER JOIN sales.sales_target AS st 
    ON od.category = st.category
GROUP BY od.category, st.target
ORDER BY difference DESC;

-- 19. Which cities have the highest sales?
SELECT city, sum(od.amount) as total_sales
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON loo.order_id = od.order_id
GROUP BY city
ORDER BY total_sales DESC;

-- 20. Which states have the highest sales?
SELECT state, sum(od.amount) as total_sales
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON loo.order_id = od.order_id
GROUP BY state
ORDER BY total_sales DESC;

-- 21. What is the total profit per city?
SELECT city, sum(od.profit) as total_profit 
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON loo.order_id = od.order_id
GROUP BY city
ORDER BY total_profit DESC;

-- 22. What is the total profit per state?
SELECT state, sum(od.profit) as total_profit 
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON loo.order_id = od.order_id
GROUP BY state
ORDER BY total_profit DESC;

-- 23. How many orders were placed each month?
SELECT DATE_FORMAT(loo.order_date, '%Y-%m') AS month, COUNT(DISTINCT od.order_id) AS total_orders
FROM sales.list_of_orders AS loo
INNER JOIN sales.order_details AS od 
	ON loo.order_id = od.order_id
GROUP BY month
ORDER BY month;

-- 24. What is the average number of products per order?
SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS avg_products_per_order
FROM sales.order_details;

-- 25. Which customer has spent the most money?
SELECT loo.customername, sum(od.amount) as total_sales
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON loo.order_id = od.order_id
GROUP BY loo.customername
ORDER BY total_sales DESC
Limit 1;


SELECT loo.customername, SUM(od.amount) AS total_sales
FROM sales.list_of_orders AS loo
INNER JOIN sales.order_details AS od
    ON loo.order_id = od.order_id
GROUP BY loo.customername
ORDER BY total_sales DESC
LIMIT 1;


-- 26. Which customer has placed the most orders?
SELECT loo.customername, count(loo.order_id) as total_orders
FROM sales.list_of_orders as loo
INNER JOIN sales.order_details as od
	ON loo.order_id = od.order_id
GROUP BY loo.customername
ORDER BY total_orders DESC
Limit 1;

-- 27. Which sub-category of products has the highest sales?
SELECT sub_category, sum(amount) AS total_sales
FROM sales.order_details 
GROUP BY sub_category
ORDER BY total_sales DESC
Limit 1;

-- 28. Which sub-category of products has the highest profit?
SELECT sub_category, sum(profit) AS total_profit
FROM sales.order_details 
GROUP BY sub_category
ORDER BY total_profit DESC
Limit 1;

-- 29. Which sub-category of products has the highest quantity sold?
SELECT sub_category, sum(quantity) AS total_quantity
FROM sales.order_details 
GROUP BY sub_category
ORDER BY total_quantity DESC
Limit 1;

-- 30. What is the most profitable product sub-category?
SELECT sub_category, SUM(profit) AS total_profit
FROM sales.order_details
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 1;
