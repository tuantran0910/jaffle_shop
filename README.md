# Jaffle Shop Analytics Project

## Overview
The `jaffle_shop` project is a demonstration dbt project that transforms raw data from a fictional ecommerce store into analytics-ready models. This project serves as an excellent example of how to structure a dbt project and implement common data modeling patterns.

### What is a Jaffle?
A jaffle is a toasted sandwich with crimped, sealed edges. The fictional Jaffle Shop is an ecommerce store that sells these delicious treats online.

### Dataset
The project includes three core datasets:
- Customers: Customer information and demographics
- Orders: Order details and status
- Payments: Payment transactions and amounts

The raw data represents a simple ecommerce data model with the following relationships:
- Each customer can have multiple orders
- Each order can have multiple payments
- All data is provided as seed files (CSV) for easy setup and testing

## Setup Instructions

### Prerequisites
- Git
- [uv](https://docs.astral.sh/uv/) (Python package and project manager)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/tuantran0910/jaffle_shop.git
cd jaffle_shop
```

2. Install **uv** (Modern Python package installer):

    **2.1. Windows**
    ```bash
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

    **2.2. Linux/MacOS**
    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```

    **2.3. Pip (if you prefer)**
    ```bash
    pip install uv
    ```

    **2.4. Homebrew (MacOS)**
    ```bash
    brew install uv
    ```

3. Create, install dependencies, and activate the virtual environment:
```bash
uv sync --frozen
source .venv/bin/activate  # On Windows use: .venv\Scripts\activate
```

## Using dbt

### Initial Setup

1. Verify dbt installation:
```bash
dbt --version
```

2. Test database connection:
```bash
dbt debug
```

### Running the Project

1. Load seed data:
```bash
dbt seed
```

2. Run the models:
```bash
dbt run
```

3. Test the models:
```bash
dbt test
```

4. Build entire project (seeds, models, tests, and snapshots):
```bash
dbt build
```

5. Generate and view documentation:
```bash
dbt docs generate
dbt docs serve
```

Visit `http://localhost:8080` to view the documentation.

Exit the documentation server with `Ctrl + C`.

## Project Structure

```
jaffle_shop/
├── models/
│   ├── staging/              # Cleaned versions of source tables
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── stg_payments.sql
│   └── marts/
│       ├── core/             # Core business entities
│       │   ├── dim_customers.sql
│       │   └── fct_orders.sql
│       └── sales/            # Sales metrics and reporting
│           └── rpt_sales_metrics.sql
├── seeds/                    # Raw CSV files
│   ├── raw_customers.csv
│   ├── raw_orders.csv
│   └── raw_payments.csv
├── macros/                   # Reusable SQL snippets
├── tests/                    # Custom test definitions
└── dbt_project.yml          # Project configuration
```

## Querying Data

After running the models, you can query the data using DuckDB.

### Querying with DuckDB

Access the DuckDB CLI to run SQL queries directly against the database.

```bash
duckcli jaffle_shop.duckdb
```

Exit the DuckDB CLI with `Ctrl + D` or `exit`.

### Example Queries

Get the top 10 customers by total sales

```sql
SELECT
    customer_id,
    SUM(amount) AS total_sales
FROM fct_orders
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 10;
```

Get the sales metrics by order status

```sql
SELECT *
FROM rpt_sales_metrics
WHERE status = 'completed';
```

## Resources
- [dbt Documentation](https://docs.getdbt.com)
- [dbt Discourse](https://discourse.getdbt.com)
- [dbt Slack](https://community.getdbt.com)
