# Data Profiling Findings

## 1. Purpose

This document summarizes the main findings from the initial data discovery, profiling, and quality assessment performed on the Microsoft WideWorldImporters databases.

The profiling phase was designed to establish whether the available data is structurally reliable and analytically suitable before defining business KPIs or developing Power BI dashboards.

The analysis covers both:

- `WideWorldImporters` — operational OLTP database
- `WideWorldImportersDW` — analytical data warehouse

---

## 2. Source Architecture

The project uses two complementary database models.

### WideWorldImporters

The OLTP database represents the operational system and contains transactional domains including:

- `Application`
- `Purchasing`
- `Sales`
- `Warehouse`

Key commercial tables include:

- `Sales.Orders`
- `Sales.OrderLines`
- `Sales.Invoices`
- `Sales.InvoiceLines`
- `Sales.Customers`
- `Sales.CustomerTransactions`
- `Warehouse.StockItems`
- `Warehouse.StockItemTransactions`

### WideWorldImportersDW

The analytical database reorganizes operational information into a dimensional model.

The main analytical schemas are:

- `Dimension`
- `Fact`
- `Integration`

The initial commercial analysis focuses on `Fact.Sale` and its related dimensions.

---

## 3. Data Coverage

The sales data covers the period:

**2013-01-01 to 2016-05-31**

Key OLTP volumes identified during profiling include:

| Table | Rows |
|---|---:|
| `Warehouse.StockItemTransactions` | 236,667 |
| `Sales.OrderLines` | 231,412 |
| `Sales.InvoiceLines` | 228,265 |
| `Sales.CustomerTransactions` | 97,147 |
| `Sales.Orders` | 73,595 |
| `Sales.Invoices` | 70,510 |
| `Sales.Customers` | 663 |
| `Warehouse.StockItems` | 227 |

The correspondence between `Sales.InvoiceLines` and `Fact.Sale`, both containing 228,265 rows, provides evidence of the transformation from operational invoice-line data into the analytical sales fact.

---

## 4. Fact.Sale Grain

Profiling established that `Fact.Sale` contains:

- **228,265 fact rows**
- **70,510 distinct invoices**
- **227 distinct products referenced by sales**
- **403 distinct customers**
- **1,240 distinct cities**
- **101 distinct salesperson surrogate keys**

Invoices contain between one and five sales lines.

The analytical grain is therefore defined as:

> **One row in `Fact.Sale` represents one product line within an invoice.**

This distinction is critical for metric design.

For example:

- `COUNT(*)` measures sales lines.
- `COUNT(DISTINCT [WWI Invoice ID])` measures invoices.
- `SUM(Quantity)` measures units sold.

Using the fact-row count as an invoice count would materially overstate transaction volume.

---

## 5. Dimensional Model

`Fact.Sale` is connected to the following principal dimensions:

- `Dimension.Customer`
- `Dimension.Stock Item`
- `Dimension.City`
- `Dimension.Employee`
- `Dimension.Date`

Some dimensions are used in multiple analytical roles.

Examples include:

- `Dimension.Customer` as Customer and Bill-To Customer.
- `Dimension.Date` as Invoice Date and Delivery Date.

This represents a role-playing dimension pattern within the dimensional model.

---

## 6. Dimension History

Profiling identified different historical behaviors across dimensions.

| Dimension | Dimension Rows | Business Entities | Additional Version Rows |
|---|---:|---:|---:|
| Customer | 403 | 403 | 0 |
| Stock Item | 672 | 228 | 444 |
| Employee | 213 | 20 | 193 |
| City | 116,295 | 37,941 | 78,354 |

`Stock Item`, `Employee`, and `City` contain multiple surrogate-key versions for the same source business entity.

The presence of:

- surrogate keys;
- source-system identifiers;
- `Valid From`;
- `Valid To`;

is consistent with a Slowly Changing Dimension Type 2 pattern used to preserve historical dimensional states.

`Dimension.Customer`, however, contains no additional historical versions in the available dataset.

---

## 7. Referential Integrity

Referential integrity tests were performed between `Fact.Sale` and its primary analytical dimensions.

No unmatched records were identified for:

- Customer
- Bill-To Customer
- Stock Item
- City
- Salesperson
- Invoice Date
- non-null Delivery Date

This indicates that the sales fact can be joined to its principal dimensions without producing orphaned fact records.

---

## 8. Completeness

Required analytical fields showed no missing values for:

- Sale Key
- WWI Invoice ID
- Invoice Date
- Customer Key
- Stock Item Key
- Salesperson Key
- Quantity
- Unit Price
- Profit

The only material null finding was:

**284 rows with a null Delivery Date Key, affecting 84 invoices.**

All 284 records correspond to invoices dated:

**2016-05-31**

This is also the final transaction date available in the dataset.

A plausible interpretation is that these invoices had not yet reached delivery status when the warehouse snapshot was generated.

This interpretation remains provisional and should not be treated as a confirmed business rule without additional source-system validation.

The records will therefore be retained rather than removed as data-quality errors.

---

## 9. Arithmetic Consistency

The sales fact passed the principal arithmetic validation tests.

No inconsistencies were found for:

`Quantity × Unit Price = Total Excluding Tax`

or:

`Total Excluding Tax + Tax Amount = Total Including Tax`

No records were found with:

- non-positive quantities;
- negative unit prices;
- negative tax rates;
- negative revenue;
- negative tax amounts.

This supports the use of the stored fact measures for subsequent analytical calculations.

---

## 10. Sales Baseline

The initial aggregate commercial baseline is:

| Metric | Value |
|---|---:|
| Sales lines | 228,265 |
| Invoices | 70,510 |
| Units sold | 8,950,628 |
| Revenue excluding tax | $172,261,341.20 |
| Tax amount | $25,782,098.25 |
| Revenue including tax | $198,043,439.45 |
| Profit | $85,729,180.90 |

These values establish reconciliation baselines that can later be used to validate analytical queries and Power BI measures.

---

## 11. Negative Profit Finding

A non-trivial profitability pattern was identified during quality profiling.

The dataset contains:

- **4,626 sales lines with negative profit**
- **4,494 affected invoices**
- **18 affected products**
- **minimum line profit of -$645.00**
- **aggregate negative profit of -$320,493.55**

Negative profit does not automatically indicate a data-quality problem.

The transactions passed the principal quantity, price, revenue, and arithmetic consistency checks.

The concentration of negative-profit transactions across only 18 products makes this a candidate for further business analysis.

Potential analytical questions include:

- Which products generate negative profit?
- Is negative profit concentrated in specific periods?
- Are particular customers or customer categories involved?
- Is the pattern geographically concentrated?
- Are negative-profit sales associated with particular salespeople?
- Does the pattern reflect pricing strategy, cost changes, promotions, or another operational mechanism?

No causal conclusion is made during the profiling phase.

---

## 12. Profiling Conclusion

The initial profiling phase indicates that `Fact.Sale` and its primary dimensions are sufficiently complete and internally consistent for commercial analytics.

The principal findings requiring further investigation are:

1. Negative-profit transactions concentrated across a limited number of products.
2. Null delivery dates concentrated entirely on the final available transaction date.
3. Historical dimensional versions that must be handled correctly when designing analytical relationships and interpreting dimensional attributes.

The dataset is considered suitable to proceed to business analysis and KPI definition.

---

## 13. Next Phase

The next project phase will move from technical profiling to business analysis.

The analysis will define:

- business questions;
- KPI definitions;
- calculation rules;
- analytical dimensions;
- profitability analysis;
- customer analysis;
- product analysis;
- temporal and geographic performance.

These definitions will be established before Power BI dashboard development begins.