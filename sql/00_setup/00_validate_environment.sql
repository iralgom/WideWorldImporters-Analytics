/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           00_validate_environment.sql
Purpose:        Validate the SQL Server environment and confirm that the
                WideWorldImporters databases required by the project are
                available and operational.

Database:       master
===============================================================================
*/

USE master;
GO

/* ---------------------------------------------------------------------------
   1. SQL Server version
--------------------------------------------------------------------------- */

SELECT
    @@SERVERNAME AS server_name,
    @@VERSION AS sql_server_version;
GO


/* ---------------------------------------------------------------------------
   2. Validate project databases
--------------------------------------------------------------------------- */

SELECT
    name AS database_name,
    state_desc AS database_status,
    recovery_model_desc AS recovery_model,
    compatibility_level
FROM sys.databases
WHERE name IN (
    'WideWorldImporters',
    'WideWorldImportersDW'
)
ORDER BY name;
GO


/* ---------------------------------------------------------------------------
   3. Confirm database accessibility
--------------------------------------------------------------------------- */

SELECT
    DB_ID('WideWorldImporters') AS wwi_database_id,
    DB_ID('WideWorldImportersDW') AS wwi_dw_database_id;
GO


/* ---------------------------------------------------------------------------
   4. Validate WideWorldImportersDW schemas
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
   5. Validate analytical fact tables
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
    s.name = 'Fact'
    AND p.index_id IN (0, 1)
GROUP BY
    s.name,
    t.name
ORDER BY
    row_count DESC;
GO