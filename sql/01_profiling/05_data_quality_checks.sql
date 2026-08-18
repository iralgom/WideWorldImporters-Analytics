/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           05_data_quality_checks.sql
Purpose:        Consolidate data quality checks for Fact.Sale and its main
                dimensions, including uniqueness, nulls, referential integrity,
                date consistency, and arithmetic validation.

Database:       WideWorldImportersDW
===============================================================================
*/

USE WideWorldImportersDW;
GO


/* ---------------------------------------------------------------------------
   1. Primary key uniqueness
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
   2. Required field null checks
--------------------------------------------------------------------------- */

SELECT
    SUM(CASE WHEN [Sale Key] IS NULL THEN 1 ELSE 0 END)
        AS null_sale_key,

    SUM(CASE WHEN [WWI Invoice ID] IS NULL THEN 1 ELSE 0 END)
        AS null_invoice_id,

    SUM(CASE WHEN [Invoice Date Key] IS NULL THEN 1 ELSE 0 END)
        AS null_invoice_date,

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
        AS null_profit,

    SUM(CASE WHEN [Delivery Date Key] IS NULL THEN 1 ELSE 0 END)
        AS null_delivery_date
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   3. Referential integrity
--------------------------------------------------------------------------- */

SELECT
    SUM(CASE WHEN c.[Customer Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_customer_rows,

    SUM(CASE WHEN bc.[Customer Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_bill_to_customer_rows,

    SUM(CASE WHEN si.[Stock Item Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_stock_item_rows,

    SUM(CASE WHEN ci.[City Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_city_rows,

    SUM(CASE WHEN e.[Employee Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_salesperson_rows,

    SUM(CASE WHEN id.[Date] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_invoice_date_rows,

    SUM(
        CASE
            WHEN f.[Delivery Date Key] IS NOT NULL
             AND dd.[Date] IS NULL
            THEN 1
            ELSE 0
        END
    ) AS unmatched_delivery_date_rows

FROM Fact.Sale AS f

LEFT JOIN Dimension.Customer AS c
    ON f.[Customer Key] = c.[Customer Key]

LEFT JOIN Dimension.Customer AS bc
    ON f.[Bill To Customer Key] = bc.[Customer Key]

LEFT JOIN Dimension.[Stock Item] AS si
    ON f.[Stock Item Key] = si.[Stock Item Key]

LEFT JOIN Dimension.City AS ci
    ON f.[City Key] = ci.[City Key]

LEFT JOIN Dimension.Employee AS e
    ON f.[Salesperson Key] = e.[Employee Key]

LEFT JOIN Dimension.Date AS id
    ON f.[Invoice Date Key] = id.[Date]

LEFT JOIN Dimension.Date AS dd
    ON f.[Delivery Date Key] = dd.[Date];
GO


/* ---------------------------------------------------------------------------
   4. Date consistency
--------------------------------------------------------------------------- */

SELECT
    SUM(
        CASE
            WHEN [Delivery Date Key] IS NOT NULL
             AND [Delivery Date Key] < [Invoice Date Key]
            THEN 1
            ELSE 0
        END
    ) AS delivery_before_invoice_rows,

    MIN([Invoice Date Key]) AS first_invoice_date,
    MAX([Invoice Date Key]) AS last_invoice_date,

    MIN([Delivery Date Key]) AS first_delivery_date,
    MAX([Delivery Date Key]) AS last_delivery_date
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   5. Numeric domain checks
--------------------------------------------------------------------------- */

SELECT
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END)
        AS non_positive_quantity_rows,

    SUM(CASE WHEN [Unit Price] < 0 THEN 1 ELSE 0 END)
        AS negative_unit_price_rows,

    SUM(CASE WHEN [Tax Rate] < 0 THEN 1 ELSE 0 END)
        AS negative_tax_rate_rows,

    SUM(CASE WHEN [Total Excluding Tax] < 0 THEN 1 ELSE 0 END)
        AS negative_revenue_rows,

    SUM(CASE WHEN [Tax Amount] < 0 THEN 1 ELSE 0 END)
        AS negative_tax_rows,

    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END)
        AS negative_profit_rows
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   6. Arithmetic consistency
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
    ) AS inconsistent_total_rows,

    SUM(
        CASE
            WHEN ABS(
                ([Quantity] * [Unit Price])
                - [Total Excluding Tax]
            ) > 0.01
            THEN 1
            ELSE 0
        END
    ) AS inconsistent_extended_price_rows
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   7. Negative profit profile
--------------------------------------------------------------------------- */

SELECT
    COUNT(*) AS negative_profit_rows,
    COUNT(DISTINCT [WWI Invoice ID]) AS affected_invoices,
    COUNT(DISTINCT [Stock Item Key]) AS affected_products,
    MIN(Profit) AS minimum_profit,
    SUM(Profit) AS total_negative_profit
FROM Fact.Sale
WHERE Profit < 0;
GO


/* ---------------------------------------------------------------------------
   8. Delivery date null profile
--------------------------------------------------------------------------- */

SELECT
    COUNT(*) AS null_delivery_rows,
    COUNT(DISTINCT [WWI Invoice ID]) AS affected_invoices,
    MIN([Invoice Date Key]) AS first_invoice_date,
    MAX([Invoice Date Key]) AS last_invoice_date
FROM Fact.Sale
WHERE [Delivery Date Key] IS NULL;
GO