SELECT
    b.O_ORDERKEY AS ORDER_ID,
    b.O_CUSTKEY AS CUSTOMER_ID,
    b.O_ORDERDATE AS ORDER_DATE,
    b.O_ORDERDATE + interval '20 days' AS TRANSACTION_DATE,
    cast(RPAD(CONCAT(b.O_ORDERKEY, b.O_CUSTKEY, 
      TO_CHAR(b.O_ORDERDATE, 'YYYYMMDD')::text),  24, '0') as numeric) AS TRANSACTION_NUMBER,
    b.O_TOTALPRICE AS AMOUNT,
    CAST(
    CASE ABS(MOD(random()::numeric, 2)) + 1
        WHEN 1 THEN 'DR'
        WHEN 2 THEN 'CR'
    END AS VARCHAR(2)) AS TYPE
FROM {{ source('tpch', 'orders') }}  AS b
LEFT JOIN {{ source('tpch', 'customer') }} AS c
    ON b.O_CUSTKEY = c.C_CUSTKEY
WHERE b.O_ORDERDATE = date('{{ var('load_date') }}')