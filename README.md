# 1. DBT Project </br>

Welcome to your new dbt project! 🚀  </br>
This repository contains a starter dbt setup to help you begin building analytics models and tests. </br>

Getting Started </br>

Once your environment is set up, try running the following commands:</br>

dbt run </br>
dbt test </br>

Resources: </br>
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction) </br>
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers </br>
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support </br>
- Find [dbt events](https://events.getdbt.com) near you </br>
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices 

# 2. Data Warehouse Design
## a. ERD Design
<img src="img\erd_diagram.png" alt="image" width="200"/>

## b. Tables
* Fact table (fact_sales_order)
- Primary key: SK_Fact_Sales (Suggorate key)
- Foreign keys - Unique keys: order_id, product_id, date_id, location_id, customer_id,store_id
* Dimension tables
- dim_customers: customer_id - primary key
- dim_date: date_id - primary key
- dim_location: location_id - primary key 
- dim_products: product_id - primary key
- dim_store: store_id - primary key 

# 3. Looker Dashboard
## a. Revenue analysis
* Scorecard: Total amount (revenue) through time UTC
* Linegraph: TOTAL AMOUNT OVER TIME
## b. Geographic Distribution
* Bar Chart: Total Amount by Location
* Table: Location Detail
## c. Time-Based Trends
* Line graph: Quantity Over Time, Order Over Time
## d. Product Performance
* Bar chart: Total Amount by Product, Quantity by Product