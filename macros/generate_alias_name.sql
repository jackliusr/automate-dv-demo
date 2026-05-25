{% macro generate_alias_name(custom_alias_name=none, node=none) -%}
    {%- if custom_alias_name -%}
        {{ custom_alias_name | trim | lower }}
    {%- else -%}
        {{ node.name | trim | lower }}
    {%- endif -%}
{%- endmacro %}