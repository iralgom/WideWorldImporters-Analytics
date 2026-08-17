/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           01_database_inventory.sql
Purpose:        Build a structural inventory of the WideWorldImporters OLTP
                database and the WideWorldImportersDW analytical database.

Databases:
                WideWorldImporters
                WideWorldImportersDW
===============================================================================
*/


/* ---------------------------------------------------------------------------
   1. Database inventory
--------------------------------------------------------------------------- */

USE master;
GO

SELECT
    name AS database_name,
    state_desc AS database_status,
    recovery_model_desc AS recovery_model,
    compatibility_level,
    create_date
FROM sys.databases
WHERE name IN (
    'WideWorldImporters',
    'WideWorldImportersDW'
)
ORDER BY name;
GO


/* ---------------------------------------------------------------------------
   2. WideWorldImporters — schema and table inventory
--------------------------------------------------------------------------- */

USE WideWorldImporters;
GO

SELECT
    s.name AS schema_name,
    COUNT(t.object_id) AS number_of_tables
FROM sys.schemas AS s
INNER JOIN sys.tables AS t
    ON s.schema_id = t.schema_id
GROUP BY
    s.name
ORDER BY
    s.name;
GO


/* ---------------------------------------------------------------------------
   3. WideWorldImporters — table inventory and approximate row counts
--------------------------------------------------------------------------- */

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
GROUP BY
    s.name,
    t.name
ORDER BY
    s.name,
    row_count DESC;
GO


/* ---------------------------------------------------------------------------
   4. WideWorldImportersDW — schema and table inventory
--------------------------------------------------------------------------- */

USE WideWorldImportersDW;
GO

SELECT
    s.name AS schema_name,
    COUNT(t.object_id) AS number_of_tables
FROM sys.schemas AS s
INNER JOIN sys.tables AS t
    ON s.schema_id = t.schema_id
GROUP BY
    s.name
ORDER BY
    s.name;
GO


/* ---------------------------------------------------------------------------
   5. WideWorldImportersDW — table inventory and approximate row counts
--------------------------------------------------------------------------- */

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
GROUP BY
    s.name,
    t.name
ORDER BY
    s.name,
    row_count DESC;
GO