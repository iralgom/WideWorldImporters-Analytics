/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           02_table_profile.sql
Purpose:        Profile key OLTP and DW tables used in commercial analytics.

Focus:
                - Sales
                - Customers
                - Products
                - Geography
                - Employees
                - Transactional volume
===============================================================================
*/


/* ---------------------------------------------------------------------------
   1. OLTP — Key table row counts
--------------------------------------------------------------------------- */

USE WideWorldImporters;
GO

SELECT
    s.name AS schema_name,
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
INNER JOIN sys.partitions AS p
    ON t.object_id = p.object_id
WHERE
    p.index_id IN (0, 1)
    AND (
        (s.name = 'Sales' AND t.name IN (
            'Customers',
            'Orders',
            'OrderLines',
            'Invoices',
            'InvoiceLines',
            'CustomerTransactions'
        ))
        OR
        (s.name = 'Warehouse' AND t.name IN (
            'StockItems',
            'StockItemTransactions'
        ))
        OR
        (s.name = 'Application' AND t.name IN (
            'People',
            'Cities'
        ))
    )
GROUP BY
    s.name,
    t.name
ORDER BY
    row_count DESC;
GO


/* ---------------------------------------------------------------------------
   2. OLTP — Transaction date coverage
--------------------------------------------------------------------------- */

SELECT
    'Sales.Orders' AS source_table,
    MIN(OrderDate) AS first_date,
    MAX(OrderDate) AS last_date,
    COUNT(*) AS row_count
FROM Sales.Orders

UNION ALL

SELECT
    'Sales.Invoices',
    MIN(InvoiceDate),
    MAX(InvoiceDate),
    COUNT(*)
FROM Sales.Invoices

UNION ALL

SELECT
    'Warehouse.StockItemTransactions',
    MIN(TransactionOccurredWhen),
    MAX(TransactionOccurredWhen),
    COUNT(*)
FROM Warehouse.StockItemTransactions;
GO


/* ---------------------------------------------------------------------------
   3. DW — Key fact table profile
--------------------------------------------------------------------------- */

USE WideWorldImportersDW;
GO

SELECT
    'Fact.Sale' AS table_name,
    COUNT(*) AS row_count,
    COUNT(DISTINCT [WWI Invoice ID]) AS distinct_business_documents,
    COUNT(DISTINCT [Customer Key]) AS distinct_customers,
    COUNT(DISTINCT [Stock Item Key]) AS distinct_products,
    COUNT(DISTINCT [City Key]) AS distinct_cities,
    COUNT(DISTINCT [Salesperson Key]) AS distinct_salespeople
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   4. DW — Fact.Sale date coverage
--------------------------------------------------------------------------- */

SELECT
    MIN([Invoice Date Key]) AS first_invoice_date,
    MAX([Invoice Date Key]) AS last_invoice_date,
    COUNT(DISTINCT [Invoice Date Key]) AS active_sales_dates
FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   5. DW — Dimension cardinality
--------------------------------------------------------------------------- */

SELECT
    'Dimension.Customer' AS dimension_name,
    COUNT(*) AS row_count
FROM Dimension.Customer

UNION ALL

SELECT
    'Dimension.Stock Item',
    COUNT(*)
FROM Dimension.[Stock Item]

UNION ALL

SELECT
    'Dimension.City',
    COUNT(*)
FROM Dimension.City

UNION ALL

SELECT
    'Dimension.Employee',
    COUNT(*)
FROM Dimension.Employee

UNION ALL

SELECT
    'Dimension.Date',
    COUNT(*)
FROM Dimension.Date;
GO


/* ---------------------------------------------------------------------------
   6. DW — Basic Fact.Sale measure profile
--------------------------------------------------------------------------- */

SELECT
    COUNT(*) AS fact_rows,
    SUM(Quantity) AS total_units,
    SUM([Total Excluding Tax]) AS revenue_ex_tax,
    SUM([Tax Amount]) AS tax_amount,
    SUM([Total Including Tax]) AS revenue_inc_tax,
    SUM(Profit) AS profit
FROM Fact.Sale;
GO