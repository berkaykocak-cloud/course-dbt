  {%- macro sum_of_categories(column_name,category_name) -%}
  SUM(CASE WHEN {{column_name}} = '{{category_name}}' THEN 1 ELSE 0 END)
  {%- endmacro -%}