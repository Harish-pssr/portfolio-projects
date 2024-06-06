-- Basic:

-- Retrieve the total number of orders placed.
SELECT  COUNT(*) AS total_no_of_orders
FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT  ROUND(SUM(price*quantity)) AS total_revenue
FROM order_details
JOIN pizzas
ON order_Details.pizza_id = pizzas.pizza_id;
 
-- Identify the highest-priced pizza.
SELECT  name, category, size, price
FROM pizzas
JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

-- Based on order count
SELECT  size, COUNT(order_id) AS total_orders
FROM order_details
JOIN pizzas
ON order_Details.pizza_id = pizzas.pizza_id
GROUP BY  size
ORDER BY  2 DESC
LIMIT 1;

-- Based on quantity count
SELECT  size, SUM(quantity) AS total_quantity_ordered
FROM order_details
JOIN pizzas
ON order_Details.pizza_id = pizzas.pizza_id
GROUP BY  size
ORDER BY  2 DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT  name, SUM(quantity) AS total_quantity_ordered
FROM order_details
JOIN pizzas
ON order_Details.pizza_id = pizzas.pizza_id
JOIN pizza_types
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY  name
ORDER BY  2 DESC
LIMIT 5;




-- Intermediate:

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT  category, SUM(quantity) AS total_quantity_ordered
FROM order_details
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY  category
ORDER BY  2 desc;

-- Determine the distribution of orders by hour of the day.
SELECT  HOUR(order_time) AS hour, COUNT(order_id)  AS total_orders
FROM orders
GROUP BY  HOUR(order_time)
ORDER BY  2 desc;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT  category, COUNT(name)
FROM pizza_types
GROUP BY  category
ORDER BY  2 desc;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT  ROUND(SUM(quantity) / COUNT(DISTINCT order_date)) AS avg_pizzas_ordered_per_day
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT  name, SUM(price*quantity) AS total_revenue
FROM order_details
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY  name
ORDER BY  2 DESC
LIMIT 3;

-- Advanced:

-- Calculate the percentage contribution of each pizza type to total revenue.

-- Based on pizza type name
WITH revenue_sub_query AS
(
	SELECT  name, SUM(price*quantity) AS revenue_generated
	FROM order_details
	JOIN pizzas
	ON order_details.pizza_id = pizzas.pizza_id
	JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
	GROUP BY  name
)
SELECT  name, ROUND(100 * revenue_generated/(
SELECT  SUM(revenue_generated)
FROM revenue_sub_query), 2) AS revenue_percentage
FROM revenue_sub_query
ORDER BY 2 desc;

-- Based on pizza type category
WITH revenue_sub_query AS
(
	SELECT  category, SUM(price*quantity) AS revenue_generated
	FROM order_details
	JOIN pizzas
	ON order_details.pizza_id = pizzas.pizza_id
	JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
	GROUP BY  category
)
SELECT  category, ROUND(100 * revenue_generated/(SELECT SUM(revenue_generated) FROM revenue_sub_query), 2) AS revenue_percentage
FROM revenue_sub_query
ORDER BY 2 desc;

-- Analyze the cumulative revenue generated over time.
SELECT  DISTINCT order_date, ROUND(SUM(price*quantity) OVER (order by order_date),2) AS cumulative_revenue
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
WITH category_sub_query AS
(
	SELECT  category, name, SUM(price*quantity) AS revenue
	FROM order_details
	JOIN pizzas
	ON order_details.pizza_id = pizzas.pizza_id
	JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
	GROUP BY  category
	         ,name
), category_rank_query AS
(
	SELECT  category, name, revenue, rank() OVER (PARTITION BY category ORDER BY  revenue DESC) AS category_rank
	FROM category_sub_query
)
SELECT  category, name, revenue
FROM category_rank_query
WHERE category_rank <= 3;