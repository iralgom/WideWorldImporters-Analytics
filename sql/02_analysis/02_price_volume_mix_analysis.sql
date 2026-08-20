/*
===============================================================================
Project:        WideWorldImporters Analytics
File:           02_price_volume_analysis.sql
Purpose:        Evaluate whether changes in revenue are associated with
                volume, effective revenue per unit, or product-mix effects.

Business Focus:
                - Volume effect
                - Effective revenue per unit
                - Product mix
                - Revenue growth drivers

Database:       WideWorldImportersDW
===============================================================================
*/

USE WideWorldImportersDW;
GO


/* ---------------------------------------------------------------------------
   1. Annual price-volume diagnostic

   Purpose:
   Compare annual revenue growth with changes in units sold and
   revenue generated per unit.
--------------------------------------------------------------------------- */

SELECT
    d.[Calendar Year] AS calendar_year,

    SUM(f.[Quantity]) AS units_sold,

    SUM(f.[Total Excluding Tax]) AS revenue,

    CAST(
        SUM(f.[Total Excluding Tax])
        / NULLIF(SUM(f.[Quantity]), 0)
        AS decimal(18,2)
    ) AS revenue_per_unit

FROM Fact.Sale AS f

INNER JOIN Dimension.Date AS d
    ON f.[Invoice Date Key] = d.[Date]

GROUP BY
    d.[Calendar Year]

ORDER BY
    calendar_year;
GO

/* ---------------------------------------------------------------------------
   2. Annual year-over-year price-volume diagnostic

   Purpose:
   Measure annual growth in revenue, units sold, and effective
   revenue per unit to identify the primary drivers of revenue growth.

   Note:
   2016 is a partial year and should not be compared directly with
   complete prior years.
--------------------------------------------------------------------------- */

WITH annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0) AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year]
),

annual_comparison AS (

    SELECT
        calendar_year,
        units_sold,
        revenue,
        revenue_per_unit,

        LAG(units_sold) OVER (
            ORDER BY calendar_year
        ) AS previous_units_sold,

        LAG(revenue) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue,

        LAG(revenue_per_unit) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue_per_unit

    FROM annual_performance
)

SELECT
    calendar_year,

    units_sold,

    CAST(revenue AS decimal(18,2)) AS revenue,

    CAST(revenue_per_unit AS decimal(18,2)) AS revenue_per_unit,

    CAST(
        100.0 * (units_sold - previous_units_sold)
        / NULLIF(previous_units_sold, 0)
        AS decimal(10,2)
    ) AS units_yoy_pct,

    CAST(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0)
        AS decimal(10,2)
    ) AS revenue_yoy_pct,

    CAST(
        100.0 * (revenue_per_unit - previous_revenue_per_unit)
        / NULLIF(previous_revenue_per_unit, 0)
        AS decimal(10,2)
    ) AS revenue_per_unit_yoy_pct

FROM annual_comparison

ORDER BY
    calendar_year;
GO

/* ---------------------------------------------------------------------------
   3. Annual revenue growth decomposition

   Purpose:
   Decompose the change in annual revenue into:
       - volume effect
       - revenue-per-unit effect
       - interaction effect

   Formula:

   Revenue = Units × Revenue per Unit

   ΔRevenue =
       (ΔUnits × Previous Revenue per Unit)
     + (ΔRevenue per Unit × Previous Units)
     + (ΔUnits × ΔRevenue per Unit)

   Note:
   Revenue per unit is an effective realized value and must not yet
   be interpreted as a pure price effect because product mix may
   influence the result.

   2016 is a partial year and should not be compared directly with
   complete prior years.
--------------------------------------------------------------------------- */

WITH annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0) AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year]
),

annual_comparison AS (

    SELECT
        calendar_year,
        units_sold,
        revenue,
        revenue_per_unit,

        LAG(units_sold) OVER (
            ORDER BY calendar_year
        ) AS previous_units_sold,

        LAG(revenue) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue,

        LAG(revenue_per_unit) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue_per_unit

    FROM annual_performance
)

SELECT
    calendar_year,

    CAST(
        revenue - previous_revenue
        AS decimal(18,2)
    ) AS revenue_change,

    CAST(
        (units_sold - previous_units_sold)
        * previous_revenue_per_unit
        AS decimal(18,2)
    ) AS volume_effect,

    CAST(
        (revenue_per_unit - previous_revenue_per_unit)
        * previous_units_sold
        AS decimal(18,2)
    ) AS revenue_per_unit_effect,

    CAST(
        (units_sold - previous_units_sold)
        * (revenue_per_unit - previous_revenue_per_unit)
        AS decimal(18,2)
    ) AS interaction_effect

FROM annual_comparison

ORDER BY
    calendar_year;
GO

/* ---------------------------------------------------------------------------
   4. Revenue growth decomposition - contribution percentages

   Purpose:
   Express each component of revenue growth as a percentage of the
   total annual revenue change.

   Important:
   Revenue-per-unit effect must not yet be interpreted as a pure
   price effect because changes in product mix may influence it.
--------------------------------------------------------------------------- */

WITH annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0) AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    GROUP BY
        d.[Calendar Year]
),

annual_comparison AS (

    SELECT
        calendar_year,
        units_sold,
        revenue,
        revenue_per_unit,

        LAG(units_sold) OVER (
            ORDER BY calendar_year
        ) AS previous_units_sold,

        LAG(revenue) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue,

        LAG(revenue_per_unit) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue_per_unit

    FROM annual_performance
),

revenue_decomposition AS (

    SELECT
        calendar_year,

        revenue - previous_revenue
            AS revenue_change,

        (units_sold - previous_units_sold)
            * previous_revenue_per_unit
            AS volume_effect,

        (revenue_per_unit - previous_revenue_per_unit)
            * previous_units_sold
            AS revenue_per_unit_effect,

        (units_sold - previous_units_sold)
            * (revenue_per_unit - previous_revenue_per_unit)
            AS interaction_effect

    FROM annual_comparison
)

SELECT
    calendar_year,

    CAST(revenue_change AS decimal(18,2))
        AS revenue_change,

    CAST(volume_effect AS decimal(18,2))
        AS volume_effect,

    CAST(
        100.0 * volume_effect
        / NULLIF(revenue_change, 0)
        AS decimal(10,2)
    ) AS volume_contribution_pct,

    CAST(revenue_per_unit_effect AS decimal(18,2))
        AS revenue_per_unit_effect,

    CAST(
        100.0 * revenue_per_unit_effect
        / NULLIF(revenue_change, 0)
        AS decimal(10,2)
    ) AS revenue_per_unit_contribution_pct,

    CAST(interaction_effect AS decimal(18,2))
        AS interaction_effect,

    CAST(
        100.0 * interaction_effect
        / NULLIF(revenue_change, 0)
        AS decimal(10,2)
    ) AS interaction_contribution_pct

FROM revenue_decomposition

ORDER BY
    calendar_year;
GO

/* ---------------------------------------------------------------------------
   5. Product-level annual price-volume diagnostic

   Purpose:
   Evaluate annual units, revenue, and effective revenue per unit at the
   individual Stock Item level.

   This provides the foundation for distinguishing changes in product-level
   selling value from changes in the overall product mix.
--------------------------------------------------------------------------- */

SELECT
    d.[Calendar Year] AS calendar_year,

    si.[WWI Stock Item ID] AS stock_item_id,

    si.[Stock Item] AS stock_item,

    SUM(f.[Quantity]) AS units_sold,

    CAST(
        SUM(f.[Total Excluding Tax])
        AS decimal(18,2)
    ) AS revenue,

    CAST(
        SUM(f.[Total Excluding Tax])
        / NULLIF(SUM(f.[Quantity]), 0)
        AS decimal(18,2)
    ) AS revenue_per_unit

FROM Fact.Sale AS f

INNER JOIN Dimension.Date AS d
    ON f.[Invoice Date Key] = d.[Date]

INNER JOIN Dimension.[Stock Item] AS si
    ON f.[Stock Item Key] = si.[Stock Item Key]

GROUP BY
    d.[Calendar Year],
    si.[WWI Stock Item ID],
    si.[Stock Item]

ORDER BY
    calendar_year,
    revenue DESC;
GO

/* ---------------------------------------------------------------------------
   6. Product-level year-over-year comparison

   Purpose:
   Compare annual units, revenue, and effective revenue per unit for each
   business product.

   This analysis helps determine whether changes in aggregate revenue per unit
   are associated with changes within individual products.

   Note:
   WWI Stock Item ID is used as the business-product identifier so historical
   dimensional versions are analyzed as a single business entity.
--------------------------------------------------------------------------- */

WITH product_annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        si.[WWI Stock Item ID] AS stock_item_id,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0) AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    INNER JOIN Dimension.[Stock Item] AS si
        ON f.[Stock Item Key] = si.[Stock Item Key]

    GROUP BY
        d.[Calendar Year],
        si.[WWI Stock Item ID]
),

product_comparison AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue,
        revenue_per_unit,

        LAG(units_sold) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_units_sold,

        LAG(revenue) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_revenue,

        LAG(revenue_per_unit) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_revenue_per_unit

    FROM product_annual_performance
)

SELECT
    calendar_year,
    stock_item_id,

    units_sold,
    previous_units_sold,

    CAST(
        revenue
        AS decimal(18,2)
    ) AS revenue,

    CAST(
        previous_revenue
        AS decimal(18,2)
    ) AS previous_revenue,

    CAST(
        revenue_per_unit
        AS decimal(18,2)
    ) AS revenue_per_unit,

    CAST(
        previous_revenue_per_unit
        AS decimal(18,2)
    ) AS previous_revenue_per_unit,

    CAST(
        100.0 * (units_sold - previous_units_sold)
        / NULLIF(previous_units_sold, 0)
        AS decimal(10,2)
    ) AS units_yoy_pct,

    CAST(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0)
        AS decimal(10,2)
    ) AS revenue_yoy_pct,

    CAST(
        100.0 * (revenue_per_unit - previous_revenue_per_unit)
        / NULLIF(previous_revenue_per_unit, 0)
        AS decimal(10,2)
    ) AS revenue_per_unit_yoy_pct

FROM product_comparison

WHERE calendar_year IN (2014, 2015)

ORDER BY
    calendar_year,
    ABS(
        100.0 * (revenue_per_unit - previous_revenue_per_unit)
        / NULLIF(previous_revenue_per_unit, 0)
    ) DESC;
GO


/* ---------------------------------------------------------------------------
   7. Product-level revenue-per-unit change summary

   Purpose:
   Determine how many products experienced changes in effective revenue
   per unit between consecutive complete years.

   This helps evaluate whether aggregate revenue-per-unit growth is driven
   by within-product changes or by changes in product mix.
--------------------------------------------------------------------------- */

WITH product_annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        si.[WWI Stock Item ID] AS stock_item_id,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0) AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    INNER JOIN Dimension.[Stock Item] AS si
        ON f.[Stock Item Key] = si.[Stock Item Key]

    GROUP BY
        d.[Calendar Year],
        si.[WWI Stock Item ID]
),

product_comparison AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,

        LAG(revenue_per_unit) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_revenue_per_unit

    FROM product_annual_performance
)

SELECT
    calendar_year,

    COUNT(*) AS compared_products,

    SUM(
        CASE
            WHEN revenue_per_unit > previous_revenue_per_unit
            THEN 1
            ELSE 0
        END
    ) AS products_with_increase,

    SUM(
        CASE
            WHEN revenue_per_unit < previous_revenue_per_unit
            THEN 1
            ELSE 0
        END
    ) AS products_with_decrease,

    SUM(
        CASE
            WHEN revenue_per_unit = previous_revenue_per_unit
            THEN 1
            ELSE 0
        END
    ) AS products_without_change

FROM product_comparison

WHERE
    previous_revenue_per_unit IS NOT NULL
    AND calendar_year IN (2014, 2015)

GROUP BY
    calendar_year

ORDER BY
    calendar_year;
GO

/* ---------------------------------------------------------------------------
   8. Product coverage across years

   Purpose:
   Determine how many distinct business products were sold in each year
   and identify whether the comparable product universe changes over time.

   This validation is required before attributing aggregate revenue-per-unit
   changes entirely to product mix.
--------------------------------------------------------------------------- */

SELECT
    d.[Calendar Year] AS calendar_year,

    COUNT(
        DISTINCT si.[WWI Stock Item ID]
    ) AS products_sold,

    SUM(f.[Quantity]) AS units_sold,

    CAST(
        SUM(f.[Total Excluding Tax])
        AS decimal(18,2)
    ) AS revenue

FROM Fact.Sale AS f

INNER JOIN Dimension.Date AS d
    ON f.[Invoice Date Key] = d.[Date]

INNER JOIN Dimension.[Stock Item] AS si
    ON f.[Stock Item Key] = si.[Stock Item Key]

GROUP BY
    d.[Calendar Year]

ORDER BY
    calendar_year;
GO


/* ---------------------------------------------------------------------------
   9. Annual volume-mix decomposition

   Purpose:
   Decompose annual revenue growth into:

       - volume effect
       - product-mix effect

   The analysis is restricted to complete years (2013-2015).

   Previous analysis confirmed that all 219 products sold during these
   complete years maintained unchanged product-level revenue per unit.
   Therefore, changes in aggregate revenue per unit are attributable to
   changes in product mix rather than within-product value changes.

   Method:

   Volume Effect =
       (Current Total Units - Previous Total Units)
       × Previous Aggregate Revenue per Unit

   Mix Effect =
       Actual Revenue Change - Volume Effect

   Because product-level revenue per unit is constant across the complete
   years, the residual captures the revenue impact associated with changes
   in the composition of units sold.
--------------------------------------------------------------------------- */

WITH annual_performance AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax]) AS revenue,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0) AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    WHERE
        d.[Calendar Year] BETWEEN 2013 AND 2015

    GROUP BY
        d.[Calendar Year]
),

annual_comparison AS (

    SELECT
        calendar_year,
        units_sold,
        revenue,
        revenue_per_unit,

        LAG(units_sold) OVER (
            ORDER BY calendar_year
        ) AS previous_units_sold,

        LAG(revenue) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue,

        LAG(revenue_per_unit) OVER (
            ORDER BY calendar_year
        ) AS previous_revenue_per_unit

    FROM annual_performance
),

decomposition AS (

    SELECT
        calendar_year,

        revenue - previous_revenue
            AS revenue_change,

        (units_sold - previous_units_sold)
            * previous_revenue_per_unit
            AS volume_effect,

        (revenue - previous_revenue)
        -
        (
            (units_sold - previous_units_sold)
            * previous_revenue_per_unit
        ) AS mix_effect

    FROM annual_comparison
)

SELECT
    calendar_year,

    CAST(
        revenue_change
        AS decimal(18,2)
    ) AS revenue_change,

    CAST(
        volume_effect
        AS decimal(18,2)
    ) AS volume_effect,

    CAST(
        100.0 * volume_effect
        / NULLIF(revenue_change, 0)
        AS decimal(10,2)
    ) AS volume_contribution_pct,

    CAST(
        mix_effect
        AS decimal(18,2)
    ) AS mix_effect,

    CAST(
        100.0 * mix_effect
        / NULLIF(revenue_change, 0)
        AS decimal(10,2)
    ) AS mix_contribution_pct

FROM decomposition

WHERE
    revenue_change IS NOT NULL

ORDER BY
    calendar_year;
GO

/* ---------------------------------------------------------------------------
   10. Product unit-share movement

   Purpose:
   Measure changes in each product's share of total units sold.

   Because product-level revenue per unit remained constant across the
   complete years, changes in unit share provide direct evidence of
   product-mix movement.

   Positive share change:
       Product gained weight in the sales mix.

   Negative share change:
       Product lost weight in the sales mix.
--------------------------------------------------------------------------- */

WITH product_annual AS (

    SELECT
        d.[Calendar Year] AS calendar_year,

        si.[WWI Stock Item ID] AS stock_item_id,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0)
            AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    INNER JOIN Dimension.[Stock Item] AS si
        ON f.[Stock Item Key] = si.[Stock Item Key]

    WHERE
        d.[Calendar Year] BETWEEN 2013 AND 2015

    GROUP BY
        d.[Calendar Year],
        si.[WWI Stock Item ID]
),

product_share AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,

        1.0 * units_sold
        / SUM(units_sold) OVER (
            PARTITION BY calendar_year
        ) AS unit_share

    FROM product_annual
),

product_comparison AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,
        unit_share,

        LAG(unit_share) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_unit_share

    FROM product_share
)

SELECT
    calendar_year,
    stock_item_id,

    units_sold,

    CAST(
        revenue_per_unit
        AS decimal(18,2)
    ) AS revenue_per_unit,

    CAST(
        100.0 * previous_unit_share
        AS decimal(10,4)
    ) AS previous_unit_share_pct,

    CAST(
        100.0 * unit_share
        AS decimal(10,4)
    ) AS current_unit_share_pct,

    CAST(
        100.0 * (unit_share - previous_unit_share)
        AS decimal(10,4)
    ) AS unit_share_change_pp

FROM product_comparison

WHERE
    calendar_year IN (2014, 2015)
    AND previous_unit_share IS NOT NULL

ORDER BY
    calendar_year,
    ABS(unit_share - previous_unit_share) DESC;
GO


/* ---------------------------------------------------------------------------
   11. Product contribution to annual mix effect

   Purpose:
   Quantify how changes in each product's unit share contributed to the 
   aggregate product-mix effect.

   A product contributes positively when its share movement improves the
   portfolio's effective revenue per unit relative to the prior-year average.

   Formula:

   Product Mix Contribution =
       Current Total Units
       × Change in Product Unit Share
       × (Product Revenue per Unit - Previous Aggregate Revenue per Unit)

   The sum of all product contributions reconciles to the aggregate
   mix effect calculated in Section 9.
--------------------------------------------------------------------------- */

WITH product_annual AS (

    SELECT
        d.[Calendar Year] AS calendar_year,
        si.[WWI Stock Item ID] AS stock_item_id,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0)
            AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    INNER JOIN Dimension.[Stock Item] AS si
        ON f.[Stock Item Key] = si.[Stock Item Key]

    WHERE
        d.[Calendar Year] BETWEEN 2013 AND 2015

    GROUP BY
        d.[Calendar Year],
        si.[WWI Stock Item ID]
),

product_share AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,

        1.0 * units_sold
            / SUM(units_sold) OVER (
                PARTITION BY calendar_year
            ) AS unit_share,

        SUM(units_sold) OVER (
            PARTITION BY calendar_year
        ) AS total_units,

        SUM(units_sold * revenue_per_unit) OVER (
            PARTITION BY calendar_year
        )
        / NULLIF(
            SUM(units_sold) OVER (
                PARTITION BY calendar_year
            ),
            0
        ) AS aggregate_revenue_per_unit

    FROM product_annual
),

product_comparison AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,
        unit_share,
        total_units,

        LAG(unit_share) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_unit_share,

        LAG(aggregate_revenue_per_unit) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_aggregate_revenue_per_unit

    FROM product_share
),

mix_contribution AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,
        previous_unit_share,
        unit_share,

        total_units
        * (unit_share - previous_unit_share)
        * (
            revenue_per_unit
            - previous_aggregate_revenue_per_unit
        ) AS mix_effect

    FROM product_comparison

    WHERE
        previous_unit_share IS NOT NULL
)

SELECT
    calendar_year,
    stock_item_id,

    CAST(
        revenue_per_unit
        AS decimal(18,2)
    ) AS revenue_per_unit,

    CAST(
        100.0 * previous_unit_share
        AS decimal(10,4)
    ) AS previous_unit_share_pct,

    CAST(
        100.0 * unit_share
        AS decimal(10,4)
    ) AS current_unit_share_pct,

    CAST(
        100.0 * (unit_share - previous_unit_share)
        AS decimal(10,4)
    ) AS unit_share_change_pp,

    CAST(
        mix_effect
        AS decimal(18,2)
    ) AS mix_effect

FROM mix_contribution

WHERE
    calendar_year IN (2014, 2015)

ORDER BY
    calendar_year,
    ABS(mix_effect) DESC;
GO

/* ---------------------------------------------------------------------------
   12. Product mix reconciliation

   Purpose:
   Validate that the sum of product-level mix contributions reconciles
   with the aggregate mix effect calculated in Section 9.

   Expected results:

       2014 ≈ 1,067,938.78
       2015 ≈   700,214.27

   Any material difference would indicate that the product-level
   decomposition does not fully reconcile with the aggregate analysis.
--------------------------------------------------------------------------- */

WITH product_annual AS (

    SELECT
        d.[Calendar Year] AS calendar_year,
        si.[WWI Stock Item ID] AS stock_item_id,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0)
            AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    INNER JOIN Dimension.[Stock Item] AS si
        ON f.[Stock Item Key] = si.[Stock Item Key]

    WHERE
        d.[Calendar Year] BETWEEN 2013 AND 2015

    GROUP BY
        d.[Calendar Year],
        si.[WWI Stock Item ID]
),

product_share AS (

    SELECT
        calendar_year,
        stock_item_id,
        units_sold,
        revenue_per_unit,

        1.0 * units_sold
            / SUM(units_sold) OVER (
                PARTITION BY calendar_year
            ) AS unit_share,

        SUM(units_sold) OVER (
            PARTITION BY calendar_year
        ) AS total_units,

        SUM(units_sold * revenue_per_unit) OVER (
            PARTITION BY calendar_year
        )
        / NULLIF(
            SUM(units_sold) OVER (
                PARTITION BY calendar_year
            ),
            0
        ) AS aggregate_revenue_per_unit

    FROM product_annual
),

product_comparison AS (

    SELECT
        calendar_year,
        stock_item_id,
        revenue_per_unit,
        unit_share,
        total_units,

        LAG(unit_share) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_unit_share,

        LAG(aggregate_revenue_per_unit) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_aggregate_revenue_per_unit

    FROM product_share
),

mix_contribution AS (

    SELECT
        calendar_year,

        total_units
        * (unit_share - previous_unit_share)
        * (
            revenue_per_unit
            - previous_aggregate_revenue_per_unit
        ) AS mix_effect

    FROM product_comparison

    WHERE
        previous_unit_share IS NOT NULL
)

SELECT
    calendar_year,

    CAST(
        SUM(mix_effect)
        AS decimal(18,2)
    ) AS reconciled_product_mix_effect

FROM mix_contribution

WHERE
    calendar_year IN (2014, 2015)

GROUP BY
    calendar_year

ORDER BY
    calendar_year;
GO


/* ---------------------------------------------------------------------------
   13. Top product-mix drivers and detractors

   Purpose:
   Identify the products with the largest positive and negative
   contributions to the annual product-mix effect.

   The ranking translates the aggregate mix effect into actionable
   product-level drivers.

   Positive mix effect:
       Product share movement increased aggregate revenue per unit.

   Negative mix effect:
       Product share movement reduced aggregate revenue per unit.
--------------------------------------------------------------------------- */

WITH product_annual AS (

    SELECT
        d.[Calendar Year] AS calendar_year,
        si.[WWI Stock Item ID] AS stock_item_id,

        MAX(si.[Stock Item]) AS stock_item,

        SUM(f.[Quantity]) AS units_sold,

        SUM(f.[Total Excluding Tax])
            / NULLIF(SUM(f.[Quantity]), 0)
            AS revenue_per_unit

    FROM Fact.Sale AS f

    INNER JOIN Dimension.Date AS d
        ON f.[Invoice Date Key] = d.[Date]

    INNER JOIN Dimension.[Stock Item] AS si
        ON f.[Stock Item Key] = si.[Stock Item Key]

    WHERE
        d.[Calendar Year] BETWEEN 2013 AND 2015

    GROUP BY
        d.[Calendar Year],
        si.[WWI Stock Item ID]
),

product_share AS (

    SELECT
        calendar_year,
        stock_item_id,
        stock_item,
        units_sold,
        revenue_per_unit,

        1.0 * units_sold
            / SUM(units_sold) OVER (
                PARTITION BY calendar_year
            ) AS unit_share,

        SUM(units_sold) OVER (
            PARTITION BY calendar_year
        ) AS total_units,

        SUM(units_sold * revenue_per_unit) OVER (
            PARTITION BY calendar_year
        )
        / NULLIF(
            SUM(units_sold) OVER (
                PARTITION BY calendar_year
            ),
            0
        ) AS aggregate_revenue_per_unit

    FROM product_annual
),

product_comparison AS (

    SELECT
        calendar_year,
        stock_item_id,
        stock_item,
        revenue_per_unit,
        unit_share,
        total_units,

        LAG(unit_share) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_unit_share,

        LAG(aggregate_revenue_per_unit) OVER (
            PARTITION BY stock_item_id
            ORDER BY calendar_year
        ) AS previous_aggregate_revenue_per_unit

    FROM product_share
),

mix_contribution AS (

    SELECT
        calendar_year,
        stock_item_id,
        stock_item,
        revenue_per_unit,
        previous_unit_share,
        unit_share,

        total_units
        * (unit_share - previous_unit_share)
        * (
            revenue_per_unit
            - previous_aggregate_revenue_per_unit
        ) AS mix_effect

    FROM product_comparison

    WHERE
        previous_unit_share IS NOT NULL
),

ranked_products AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            PARTITION BY calendar_year
            ORDER BY mix_effect DESC
        ) AS positive_rank,

        ROW_NUMBER() OVER (
            PARTITION BY calendar_year
            ORDER BY mix_effect ASC
        ) AS negative_rank

    FROM mix_contribution
)

SELECT
    calendar_year,
    stock_item_id,
    stock_item,

    CAST(
        revenue_per_unit
        AS decimal(18,2)
    ) AS revenue_per_unit,

    CAST(
        100.0 * previous_unit_share
        AS decimal(10,4)
    ) AS previous_unit_share_pct,

    CAST(
        100.0 * unit_share
        AS decimal(10,4)
    ) AS current_unit_share_pct,

    CAST(
        100.0 * (unit_share - previous_unit_share)
        AS decimal(10,4)
    ) AS unit_share_change_pp,

    CAST(
        mix_effect
        AS decimal(18,2)
    ) AS mix_effect,

    CASE
        WHEN mix_effect > 0 THEN 'Driver'
        WHEN mix_effect < 0 THEN 'Detractor'
        ELSE 'Neutral'
    END AS mix_role

FROM ranked_products

WHERE
    positive_rank <= 10
    OR negative_rank <= 10

ORDER BY
    calendar_year,
    mix_effect DESC;
GO