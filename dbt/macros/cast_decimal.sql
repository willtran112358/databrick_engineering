{% macro cast_decimal(column_name, precision=18, scale=2) %}
cast({{ column_name }} as decimal({{ precision }}, {{ scale }}))
{% endmacro %}
