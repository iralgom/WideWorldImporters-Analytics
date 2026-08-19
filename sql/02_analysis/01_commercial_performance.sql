/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           01_commercial_performance.sql
Purpose:        Analyze overall commercial performance over time and answer
                Business Questions BQ01-BQ03.

Business Questions:
                BQ01 - How have revenue, profit, units sold, and invoice volume
                       evolved during the available period?

                BQ02 - Is revenue growth accompanied by proportional
                       profit growth?

                BQ03 - Are there meaningful monthly, annual, or seasonal
                       patterns in commercial performance?

Database:       WideWorldImportersDW

Notes:
                - Revenue is measured excluding tax.
                - Fact.Sale has invoice-line grain.
                - Invoice counts therefore use DISTINCT WWI Invoice ID.
                - 2016 contains data only through May 31 and must not be
                  interpreted as a complete annual period.
===============================================================================
*/

USE WideWorldImportersDW;
GO


/* ---------------------------------------------------------------------------
   1. Overall commercial baseline

   Purpose:
   Establish the principal commercial KPIs for the complete available period.
--------------------------------------------------------------------------- */

SELECT
    COUNT(DISTINCT [WWI Invoice ID]) AS invoices,

    SUM([Quantity]) AS units_sold,

    SUM([Total Excluding Tax]) AS revenue,

    SUM([Profit]) AS profit,

    CAST(
        100.0 * SUM([Profit])
        / NULLIF(SUM([Total Excluding Tax]), 0)
        AS decimal(10,2)
    ) AS profit_margin_pct,

    CAST(
        SUM([Total Excluding Tax])
        / NULLIF(COUNT(DISTINCT [WWI Invoice ID]), 0)
        AS decimal(18,2)
    ) AS average_invoice_value,

    CAST(
        SUM([Profit])
        / NULLIF(COUNT(DISTINCT [WWI Invoice ID]), 0)
        AS decimal(18,2)
    ) AS profit_per_invoice

FROM Fact.Sale;
GO


/* ---------------------------------------------------------------------------
   2. Annual commercial performance

   Purpose:
   Compare the principal commercial KPIs across calendar years.
--------------------------------------------------------------------------- */

SELECT
    d.[Calendar Year] AS calendar_year,

    COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices,

    SUM(f.[Quantity]) AS units_sold,

    SUM(f.[Total Excluding Tax]) AS revenue,

    SUM(f.[Profit]) AS profit,

    CAST(
        100.0 * SUM(f.[Profit])
        / NULLIF(SUM(f.[Total Excluding Tax]), 0)
        AS decimal(10,2)
    ) AS profit_margin_pct,

    CAST(
        SUM(f.[Total Excluding Tax])
        / NULLIF(COUNT(DISTINCT f.[WWI Invoice ID]), 0)
        AS decimal(18,2)
    ) AS average_invoice_value

FROM Fact.Sale AS f

INNER JOIN Dimension.Date AS d
    ON f.[Invoice Date Key] = d.[Date]

GROUP BY
    d.[Calendar Year]

ORDER BY
    calendar_year;
GO


/* ---------------------------------------------------------------------------
   3. Annual growth rates

   Purpose:
   Measure year-over-year changes in revenue, profit, invoice volume,
   and units sold.

   Important:
   2016 is a partial year through May 31.
--------------------------------------------------------------------------- */

WITH annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Profit]) AS profit,

        COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices,

        SUM(f.[Quantity]) AS units_sold

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year]
),

annual_with_previous AS (

    SELECT
        calendar_year,
        revenue,
        profit,
        invoices,
        units_sold,

        LAG(revenue) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue,

        LAG(profit) OVER (
            ORDER BY calendar_year
        ) AS previous_profit,

        LAG(invoices) OVER (
            ORDER BY calendar_year
        ) AS previous_invoices,

        LAG(units_sold) OVER (
            ORDER BY calendar_year
        ) AS previous_units

    FROM annual_performance
)

SELECT
    calendar_year,
    revenue,
    profit,
    invoices,
    units_sold,

    CAST(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0)
        AS decimal(10,2)
    ) AS revenue_growth_pct,

    CAST(
        100.0 * (profit - previous_profit)
        / NULLIF(previous_profit, 0)
        AS decimal(10,2)
    ) AS profit_growth_pct,

    CAST(
        100.0 * (invoices - previous_invoices)
        / NULLIF(previous_invoices, 0)
        AS decimal(10,2)
    ) AS invoice_growth_pct,

    CAST(
        100.0 * (units_sold - previous_units)
        / NULLIF(previous_units, 0)
        AS decimal(10,2)
    ) AS units_growth_pct

FROM annual_with_previous

ORDER BY
    calendar_year;
GO


/* ---------------------------------------------------------------------------
   4. Monthly commercial performance

   Purpose:
   Analyze monthly revenue, profit, invoice volume, units sold,
   and profitability.
--------------------------------------------------------------------------- */

SELECT
    d.[Calendar Year] AS calendar_year,

    d.[Calendar Month Number] AS month_number,

    d.[Month] AS month_name,

    COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices,

    SUM(f.[Quantity]) AS units_sold,

    SUM(f.[Total Excluding Tax]) AS revenue,

    SUM(f.[Profit]) AS profit,

    CAST(
        100.0 * SUM(f.[Profit])
        / NULLIF(SUM(f.[Total Excluding Tax]), 0)
        AS decimal(10,2)
    ) AS profit_margin_pct

FROM Fact.Sale AS f

INNER JOIN Dimension.Date AS d
    ON f.[Invoice Date Key] = d.[Date]

GROUP BY
    d.[Calendar Year],
    d.[Calendar Month Number],
    d.[Month]

ORDER BY
    calendar_year,
    month_number;
GO


/* ---------------------------------------------------------------------------
   5. Year-over-year monthly comparison

   Purpose:
   Compare each month against the same calendar month in the previous year.

   This comparison reduces the distortion caused by seasonal patterns.
--------------------------------------------------------------------------- */

WITH monthly_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        d.[Calendar Month Number] AS month_number,

        d.[Month] AS month_name,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Profit]) AS profit,

        COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year],
        d.[Calendar Month Number],
        d.[Month]
),

monthly_comparison AS (

    SELECT
        calendar_year,
        month_number,
        month_name,
        revenue,
        profit,
        invoices,

        LAG(revenue, 12) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_year_revenue,

        LAG(profit, 12) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_year_profit,

        LAG(invoices, 12) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_year_invoices

    FROM monthly_performance
)

SELECT
    calendar_year,
    month_number,
    month_name,
    revenue,
    profit,
    invoices,

    CAST(
        100.0 * (revenue - previous_year_revenue)
        / NULLIF(previous_year_revenue, 0)
        AS decimal(10,2)
    ) AS revenue_yoy_pct,

    CAST(
        100.0 * (profit - previous_year_profit)
        / NULLIF(previous_year_profit, 0)
        AS decimal(10,2)
    ) AS profit_yoy_pct,

    CAST(
        100.0 * (invoices - previous_year_invoices)
        / NULLIF(previous_year_invoices, 0)
        AS decimal(10,2)
    ) AS invoices_yoy_pct

FROM monthly_comparison

ORDER BY
    calendar_year,
    month_number;
GO


/* ---------------------------------------------------------------------------
   6. Month-over-month commercial growth

   Purpose:
   Measure short-term changes between consecutive months.

   Unlike YoY analysis, MoM helps identify acceleration, deceleration,
   and abrupt changes in commercial activity.
--------------------------------------------------------------------------- */

WITH monthly_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        d.[Calendar Month Number] AS month_number,

        d.[Month] AS month_name,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Profit]) AS profit,

        COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices,

        SUM(f.[Quantity]) AS units_sold

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year],
        d.[Calendar Month Number],
        d.[Month]
),

monthly_with_previous AS (

    SELECT
        calendar_year,
        month_number,
        month_name,
        revenue,
        profit,
        invoices,
        units_sold,

        LAG(revenue) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_month_revenue,

        LAG(profit) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_month_profit,

        LAG(invoices) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_month_invoices,

        LAG(units_sold) OVER (
            ORDER BY calendar_year, month_number
        ) AS previous_month_units

    FROM monthly_performance
)

SELECT
    calendar_year,
    month_number,
    month_name,

    revenue,
    profit,
    invoices,
    units_sold,

    CAST(
        100.0 * (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0)
        AS decimal(10,2)
    ) AS revenue_mom_pct,

    CAST(
        100.0 * (profit - previous_month_profit)
        / NULLIF(previous_month_profit, 0)
        AS decimal(10,2)
    ) AS profit_mom_pct,

    CAST(
        100.0 * (invoices - previous_month_invoices)
        / NULLIF(previous_month_invoices, 0)
        AS decimal(10,2)
    ) AS invoices_mom_pct,

    CAST(
        100.0 * (units_sold - previous_month_units)
        / NULLIF(previous_month_units, 0)
        AS decimal(10,2)
    ) AS units_mom_pct

FROM monthly_with_previous

ORDER BY
    calendar_year,
    month_number;
GO


/* ---------------------------------------------------------------------------
   7. Monthly commercial efficiency metrics

   Purpose:
   Evaluate commercial performance beyond absolute revenue by measuring
   profitability, invoice value, transaction volume, and revenue per unit.

   Important:
   Revenue per unit is not equivalent to product price.
   Changes may reflect both pricing and product-mix effects.
--------------------------------------------------------------------------- */

WITH monthly_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        d.[Calendar Month Number] AS month_number,

        d.[Month] AS month_name,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Profit]) AS profit,

        COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices,

        SUM(f.[Quantity]) AS units_sold

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year],
        d.[Calendar Month Number],
        d.[Month]
)

SELECT
    calendar_year,
    month_number,
    month_name,

    CAST(
        revenue
        AS decimal(18,2)
    ) AS revenue,

    CAST(
        profit
        AS decimal(18,2)
    ) AS profit,

    invoices,

    units_sold,

    -- Profit generated for every 100 monetary units of revenue
    CAST(
        100.0 * profit
        / NULLIF(revenue, 0)
        AS decimal(10,2)
    ) AS profit_margin_pct,

    -- Average commercial value of each invoice
    CAST(
        revenue
        / NULLIF(invoices, 0)
        AS decimal(18,2)
    ) AS revenue_per_invoice,

    -- Average number of units contained in each invoice
    CAST(
        1.0 * units_sold
        / NULLIF(invoices, 0)
        AS decimal(18,2)
    ) AS units_per_invoice,

    -- Average revenue generated by each unit sold
    CAST(
        revenue
        / NULLIF(units_sold, 0)
        AS decimal(18,2)
    ) AS revenue_per_unit

FROM monthly_performance

ORDER BY
    calendar_year,
    month_number;
GO


/* ---------------------------------------------------------------------------
   8. Month-of-year seasonality

   Purpose:
   Identify recurring monthly performance patterns across available years.

   Average monthly values are used instead of total values because
   January-May appear in four years while June-December appear in only
   three complete years.
--------------------------------------------------------------------------- */

SELECT
    d.[Calendar Month Number] AS month_number,

    d.[Month] AS month_name,

    COUNT(
        DISTINCT CONCAT(
            d.[Calendar Year],
            '-',
            d.[Calendar Month Number]
        )
    ) AS observed_months,

    SUM(f.[Total Excluding Tax]) AS total_revenue,

    CAST(
        SUM(f.[Total Excluding Tax])
        /
        NULLIF(
            COUNT(
                DISTINCT CONCAT(
                    d.[Calendar Year],
                    '-',
                    d.[Calendar Month Number]
                )
            ),
            0
        )
        AS decimal(18,2)
    ) AS average_monthly_revenue,

    SUM(f.[Profit]) AS total_profit,

    CAST(
        SUM(f.[Profit])
        /
        NULLIF(
            COUNT(
                DISTINCT CONCAT(
                    d.[Calendar Year],
                    '-',
                    d.[Calendar Month Number]
                )
            ),
            0
        )
        AS decimal(18,2)
    ) AS average_monthly_profit

FROM Fact.Sale AS f

INNER JOIN Dimension.Date AS d
    ON f.[Invoice Date Key] = d.[Date]

GROUP BY
    d.[Calendar Month Number],
    d.[Month]

ORDER BY
    month_number;
GO


/* ---------------------------------------------------------------------------
   9. Daily sales activity

   Purpose:
   Provide the lowest temporal aggregation required for subsequent
   trend validation and Power BI reconciliation.
--------------------------------------------------------------------------- */

SELECT
    f.[Invoice Date Key] AS invoice_date,

    COUNT(DISTINCT f.[WWI Invoice ID]) AS invoices,

    SUM(f.[Quantity]) AS units_sold,

    SUM(f.[Total Excluding Tax]) AS revenue,

    SUM(f.[Profit]) AS profit

FROM Fact.Sale AS f

GROUP BY
    f.[Invoice Date Key]

ORDER BY
    invoice_date;
GO