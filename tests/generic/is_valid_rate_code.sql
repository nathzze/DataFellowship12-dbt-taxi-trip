{% test is_valid_rate_code (model, column_name) %}

SELECT COUNT(*) AS cnt
FROM {{ this }}
WHERE RateCodeID NOT IN (1, 2, 3, 4, 5, 6)
  OR RateCodeID IS NULL
  OR RateCodeID < 0

EXPECT {{ cnt }} = 0;

{% endtest %}