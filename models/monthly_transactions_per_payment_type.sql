{{
  config(
    materialized = "table"
  )
}}

SELECT
  CASE
    WHEN payment_type = 1 THEN 'Credit card'
    WHEN payment_type = 2 THEN 'Cash'
    WHEN payment_type = 3 THEN 'No charge'
    WHEN payment_type = 4 THEN 'Dispute'
    WHEN payment_type = 5 THEN 'Unknown'
    WHEN payment_type = 6 THEN 'Voided trip'
  END AS payment_type_name,
  EXTRACT(MONTH FROM lpep_pickup_datetime) AS month,
  ROUND(SUM(total_amount), 2) AS monthly_transactions_per_payment_type,
  {{ dollars_to_idr('total_amount') }} as amount_idr
FROM
  {{source('week3', 'raw_taxi_tripdata')}}
WHERE
    payment_type IS NOT NULL
GROUP BY
  payment_type, month
ORDER BY
  payment_type, month ASC