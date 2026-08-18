/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           04_dimension_profile.sql
Purpose:        Profile key dimensions used by Fact.Sale and evaluate
                entity cardinality, version history, and referential integrity.

Database:       WideWorldImportersDW
===============================================================================
*/

USE WideWorldImportersDW;
GO 


/* ---------------------------------------------------------------------------
   1. Dimension row count vs business entity count
--------------------------------------------------------------------------- */

SELECT
    'Customer' AS dimension_name,
    COUNT(*) AS dimension_rows,
    COUNT(DISTINCT [WWI Customer ID]) AS business_entities,
    COUNT(*) - COUNT(DISTINCT [WWI Customer ID]) AS additional_version_rows
FROM Dimension.Customer

UNION ALL

SELECT
    'Stock Item',
    COUNT(*),
    COUNT(DISTINCT [WWI Stock Item ID]),
    COUNT(*) - COUNT(DISTINCT [WWI Stock Item ID])
FROM Dimension.[Stock Item]

UNION ALL

SELECT
    'Employee',
    COUNT(*),
    COUNT(DISTINCT [WWI Employee ID]),
    COUNT(*) - COUNT(DISTINCT [WWI Employee ID])
FROM Dimension.Employee

UNION ALL

SELECT
    'City',
    COUNT(*),
    COUNT(DISTINCT [WWI City ID]),
    COUNT(*) - COUNT(DISTINCT [WWI City ID])
FROM Dimension.City;
GO


/* ---------------------------------------------------------------------------
   2. Version distribution by dimension
--------------------------------------------------------------------------- */

SELECT
    'Customer' AS dimension_name,
    versions_per_entity,
    COUNT(*) AS entity_count
FROM (
    SELECT
        [WWI Customer ID],
        COUNT(*) AS versions_per_entity
    FROM Dimension.Customer
    GROUP BY [WWI Customer ID]
) AS customer_versions
GROUP BY versions_per_entity

UNION ALL

SELECT
    'Stock Item',
    versions_per_entity,
    COUNT(*)
FROM (
    SELECT
        [WWI Stock Item ID],
        COUNT(*) AS versions_per_entity
    FROM Dimension.[Stock Item]
    GROUP BY [WWI Stock Item ID]
) AS stock_versions
GROUP BY versions_per_entity

UNION ALL

SELECT
    'Employee',
    versions_per_entity,
    COUNT(*)
FROM (
    SELECT
        [WWI Employee ID],
        COUNT(*) AS versions_per_entity
    FROM Dimension.Employee
    GROUP BY [WWI Employee ID]
) AS employee_versions
GROUP BY versions_per_entity

UNION ALL

SELECT
    'City',
    versions_per_entity,
    COUNT(*)
FROM (
    SELECT
        [WWI City ID],
        COUNT(*) AS versions_per_entity
    FROM Dimension.City
    GROUP BY [WWI City ID]
) AS city_versions
GROUP BY versions_per_entity

ORDER BY
    dimension_name,
    versions_per_entity;
GO


/* ---------------------------------------------------------------------------
   3. Inspect Stock Item entities with multiple historical versions
--------------------------------------------------------------------------- */

SELECT TOP 20
    [WWI Stock Item ID],
    COUNT(*) AS number_of_versions,
    MIN([Valid From]) AS first_valid_from,
    MAX([Valid From]) AS latest_version_start
FROM Dimension.[Stock Item]
GROUP BY
    [WWI Stock Item ID]
HAVING COUNT(*) > 1
ORDER BY
    number_of_versions DESC,
    [WWI Stock Item ID];
GO


/* ---------------------------------------------------------------------------
   4. Inspect one example of Stock Item version history
--------------------------------------------------------------------------- */

DECLARE @StockItemID INT;

SELECT TOP 1
    @StockItemID = [WWI Stock Item ID]
FROM Dimension.[Stock Item]
GROUP BY
    [WWI Stock Item ID]
HAVING COUNT(*) > 1
ORDER BY
    COUNT(*) DESC,
    [WWI Stock Item ID];

SELECT
    [Stock Item Key],
    [WWI Stock Item ID],
    [Stock Item],
    [Color],
    [Brand],
    [Size],
    [Unit Price],
    [Recommended Retail Price],
    [Valid From],
    [Valid To]
FROM Dimension.[Stock Item]
WHERE [WWI Stock Item ID] = @StockItemID
ORDER BY
    [Valid From];
GO


/* ---------------------------------------------------------------------------
   5. Referential integrity from Fact.Sale
--------------------------------------------------------------------------- */

SELECT
    SUM(CASE WHEN c.[Customer Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_customer_rows,

    SUM(CASE WHEN si.[Stock Item Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_stock_item_rows,

    SUM(CASE WHEN ci.[City Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_city_rows,

    SUM(CASE WHEN e.[Employee Key] IS NULL THEN 1 ELSE 0 END)
        AS unmatched_salesperson_rows

FROM Fact.Sale AS f

LEFT JOIN Dimension.Customer AS c
    ON f.[Customer Key] = c.[Customer Key]

LEFT JOIN Dimension.[Stock Item] AS si
    ON f.[Stock Item Key] = si.[Stock Item Key]

LEFT JOIN Dimension.City AS ci
    ON f.[City Key] = ci.[City Key]

LEFT JOIN Dimension.Employee AS e
    ON f.[Salesperson Key] = e.[Employee Key];
GO