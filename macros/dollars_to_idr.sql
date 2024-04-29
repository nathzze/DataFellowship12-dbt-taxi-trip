{% macro dollars_to_idr(column_name, scale=2) %}
  ROUND(SUM({{ column_name }}*16241.5), 2)
{% endmacro %}