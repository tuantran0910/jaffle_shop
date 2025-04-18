{{
    config(
        materialized = 'table',
    )
}}

WITH
    orders AS (
        SELECT *
        FROM {{ ref('fct_orders') }}
    ),

    status_stats AS (
        SELECT
            status,
            COUNT(*) AS order_count,
            SUM(amount) AS total_amount
        FROM orders
        GROUP BY status
    ),

    final AS (
        SELECT
            status,
            {{ safe_divide('order_count', 'total_amount') }} AS avg_order_value
        FROM status_stats
    )

SELECT *
FROM final
