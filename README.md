# 1. DBT Project 

Welcome to your new dbt project! 🚀  
This repository contains a starter dbt setup to help you begin building analytics models and tests. </br>
Getting Started 

Once your environment is set up, try running the following commands: 
```
dbt run 
```
```
dbt test 
```

Resources: </br>
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction) </br>
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers </br>
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support </br>
- Find [dbt events](https://events.getdbt.com) near you </br>
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices 

# 2. Project structure

```
GLAMIRA/
├── .vscode/                     # VS Code workspace settings
├── analyses/                    # Ad-hoc analytical SQL queries
├── dbt_internal_packages/       # dbt internal dependencies (auto-generated)
├── dbt_packages/                # dbt external packages
├── img/                         # Dashboard screenshots and documentation images
├── logs/                        # dbt execution logs
├── macros/                      # Custom dbt macros
├── models/                      # Core dbt models
│   ├── marts/                   # Analytics-ready data models
│   │   ├── dim_customers.sql    # Customer dimension table
│   │   ├── dim_date.sql         # Date dimension table
│   │   ├── dim_location.sql     # Location dimension table
│   │   ├── dim_products.sql     # Product dimension table
│   │   ├── dim_store.sql        # Store dimension table
│   │   ├── fact_sales_order.sql # Fact table for sales orders
│   │   └── schema.yml           # Tests and documentation for mart models
│   │
│   └── staging/                 # Staging layer (raw data cleaning)
│       ├── glamira_src.yml      # Source definitions
│       ├── stg_customers.sql    # Staged customer data
│       ├── stg_location.sql     # Staged location data
│       ├── stg_products.sql     # Staged product data
│       ├── stg_sales_order.sql  # Staged sales order data
│       ├── stg_store.sql        # Staged store data
│       └── stg_test.yml         # Tests for staging models
│
├── seeds/                       # Static seed data (if any)
├── snapshots/                   # Slowly Changing Dimension (SCD) snapshots
├── target/                      # dbt compiled SQL & run artifacts (auto-generated)
├── tests/                       # Custom data tests
├── .gitignore                   # Git ignore configuration
└── README.md                    # Project documentation
```

# 3. Data Warehouse Design
## 3.1. ERD Design
<img src="img\erd_diagram.png" alt="image" width="1000"/>

## 3.2. Tables
### a. Fact table (fact_sales_order)
* Primary key: SK_Fact_Sales (Suggorate key)
* Foreign keys - Unique keys: order_id, product_id, date_id, location_id, customer_id,store_id
### b. Dimension tables
* dim_customers: customer_id - primary key
* dim_date: date_id - primary key
* dim_location: location_id - primary key 
* dim_products: product_id - primary key
* dim_store: store_id - primary key 

# 4. Looker Dashboard
## a. Revenue analysis
* Scorecard: Total amount (revenue) through time UTC
* Linegraph: TOTAL AMOUNT OVER TIME
<img src="img\1.PNG" alt="image" width="1000"/>


## b. Geographic Distribution
* Bar Chart: Total Amount by Location
* Table: Location Detail
<img src="img\2.PNG" alt="image" width="1000"/>


## c. Time-Based Trends
* Line graph: Quantity Over Time, Order Over Time
<img src="img\3.PNG" alt="image" width="1000"/>


## d. Product Performance
* Bar chart: Total Amount by Product, Quantity by Product
<img src="img\4.PNG" alt="image" width="1000"/>