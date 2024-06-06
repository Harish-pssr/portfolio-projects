# Pizza Sales Analysis

## Summary
This project involves analyzing pizza sales data to gain insights into order patterns, revenue generation, popular pizza types, and other key metrics. The analysis is conducted using SQL queries to extract and process data from a relational database.

## Project Overview
The goal of this project is to analyze the pizza sales data to identify trends, measure performance, and uncover insights that can help in decision-making. The analysis includes basic metrics, intermediate insights, and advanced analyses.

## Data Sources

The dataset used for this analysis is obtained from Kaggle: [Pizza Sales Data]( https://www.kaggle.com/datasets/mysarahmadbhat/pizza-place-sales).

The dataset includes the following tables and columns:

- **pizzas**: pizza_id, pizza_type_id, size, price
- **orders**: order_id, order_time, order_date
- **order_details**: order_Details_id, order_id, pizza_id, quantity
- **pizza_types**: pizza_type_id, name, category, ingredients

## Cleaning + Transformation
The dataset was preprocessed to ensure consistency and accuracy:
- **Date Formatting**: Ensured date columns are in the appropriate format.
- **Data Types**: Converted data types where necessary (price, quantity to numeric).

## Data Analysis

### Basic Analysis
- **Total Number of Orders**: Count of all orders placed.
- **Total Revenue**: Sum of the revenue generated from all orders.
- **Highest Priced Pizza**: Identifying the most expensive pizza in the menu.
- **Most Common Pizza Size**: Determined by order count and quantity count.
- **Top 5 Most Ordered Pizza Types**: Based on total quantities ordered.

### Intermediate Analysis
- **Total Quantity by Pizza Category**: Summing quantities for each category.
- **Order Distribution by Hour**: Count of orders grouped by hour of the day.
- **Category-wise Pizza Distribution**: Count of pizzas in each category.
- **Average Pizzas Ordered Per Day**: Average number of pizzas ordered each day.
- **Top 3 Pizza Types by Revenue**: Based on total revenue generated.

### Advanced Analysis
- **Percentage Contribution to Revenue**: 
  - By pizza type.
  - By pizza category.
- **Cumulative Revenue Over Time**: Tracking revenue accumulation by date.
- **Top 3 Pizza Types by Revenue for Each Category**: Detailed ranking within categories.

## Recommendations
Based on the analysis, here are some recommendations:
- **Optimize Inventory**: Focus on stocking ingredients for the most popular and highest-revenue pizzas.
- **Promotional Strategies**: Target promotions during peak ordering hours and on the most popular pizza sizes and types.
- **Menu Adjustments**: Consider revising the menu to highlight top-performing pizzas and possibly discontinue less popular ones.

## Findings

- **Popular Pizza Types and Sizes**: Highlighted the most commonly ordered pizzas and sizes.
- **Order Patterns**: Observed peak order times and distribution across categories.
- **Performance by Category**: Detailed insights into each pizza category’s performance.