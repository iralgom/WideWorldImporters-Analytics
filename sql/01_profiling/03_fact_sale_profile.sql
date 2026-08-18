/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           03_fact_sale_profile.sql
Purpose:        Profile Fact.Sale to validate grain, nullability, duplicates,
                and arithmetic consistency of core commercial measures.

Database:       WideWorldImportersDW
===============================================================================
*/

USE WideWorldImportersDW;
GO


/* ---------------------------------------------------------------------------
   1. Confirm fact grain
--------------------------------------------------------------------------- */

SELECT
    COUNT(*) AS fact_rows,
    COUNT(DISTINCT [WWI Invoice ID]) AS distinct_invoices,
    COUNT(DISTINCT CONCAT(
        [WWI Invoice ID], '|',
        [Stock Item Key], '|',
        [Description], '|',
        [Unit Price]
    )) AS distinct_candidate_lines
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   2. Distribution of invoice lines
--------------------------------------------------------------------------- */

SELECT
    invoice_lines,
    COUNT(*) AS invoice_count
FROM (
    SELECT
        [WWI Invoice ID],
        COUNT(*) AS invoice_lines
    FROM Fact.Sale
    GROUP BY
        [WWI Invoice ID]
) AS x
GROUP BY
    invoice_lines
ORDER BY
    invoice_lines;
GO


/* ---------------------------------------------------------------------------
   3. Null profile
--------------------------------------------------------------------------- */

SELECT
    SUM(CASE WHEN [Delivery Date Key] IS NULL THEN 1 ELSE 0 END)
        AS null_delivery_date,

    SUM(CASE WHEN [City Key] IS NULL THEN 1 ELSE 0 END)
        AS null_city_key,

    SUM(CASE WHEN [Customer Key] IS NULL THEN 1 ELSE 0 END)
        AS null_customer_key,

    SUM(CASE WHEN [Stock Item Key] IS NULL THEN 1 ELSE 0 END)
        AS null_stock_item_key,

    SUM(CASE WHEN [Salesperson Key] IS NULL THEN 1 ELSE 0 END)
        AS null_salesperson_key,

    SUM(CASE WHEN [Quantity] IS NULL THEN 1 ELSE 0 END)
        AS null_quantity,

    SUM(CASE WHEN [Unit Price] IS NULL THEN 1 ELSE 0 END)
        AS null_unit_price,

    SUM(CASE WHEN [Profit] IS NULL THEN 1 ELSE 0 END)
        AS null_profit
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   4. Duplicate Sale Key validation
--------------------------------------------------------------------------- */

SELECT
    COUNT(*) AS duplicate_sale_keys
FROM (
    SELECT
        [Sale Key]
    FROM Fact.Sale
    GROUP BY
        [Sale Key]
    HAVING COUNT(*) > 1
) AS d;
GO


/* ---------------------------------------------------------------------------
   5. Arithmetic consistency
--------------------------------------------------------------------------- */

SELECT
    SUM(
        CASE
            WHEN ABS(
                ([Total Excluding Tax] + [Tax Amount])
                - [Total Including Tax]
            ) > 0.01
            THEN 1
            ELSE 0
        END
    ) AS inconsistent_total_rows
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   6. Value range checks
--------------------------------------------------------------------------- */

SELECT
    MIN([Quantity]) AS min_quantity,
    MAX([Quantity]) AS max_quantity,
    MIN([Unit Price]) AS min_unit_price,
    MAX([Unit Price]) AS max_unit_price,
    MIN([Profit]) AS min_profit,
    MAX([Profit]) AS max_profit
FROM Fact.Sale;
GO