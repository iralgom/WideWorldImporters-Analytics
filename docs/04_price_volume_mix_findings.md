# Price–Volume–Mix Analysis Findings

## 1. Executive Summary

WideWorldImporters generated sustained revenue growth across the three complete
calendar years available in the dataset.

Revenue increased from **$45.71 million in 2013 to $53.99 million in 2015**,
while units sold increased from **2.40 million to 2.74 million**.

The analysis initially investigated whether revenue growth was driven by higher
sales volume or increases in effective revenue per unit. Although aggregate
revenue per unit increased from **$19.03 in 2013 to $19.70 in 2015**,
product-level validation showed that none of the 219 comparable products
experienced a change in effective revenue per unit between consecutive complete
years.

The increase in aggregate revenue per unit therefore reflects a change in the
composition of units sold rather than observed within-product revenue-per-unit
growth.

A volume–mix decomposition shows that:

- **74.71%** of 2014 revenue growth was attributable to volume and **25.29%**
  to product mix.
- **82.76%** of 2015 revenue growth was attributable to volume and **17.24%**
  to product mix.

Revenue growth was therefore predominantly **volume-driven**, with favorable
product mix providing an additional positive contribution. The relative
contribution of mix declined in 2015, increasing the dependence of revenue
growth on unit expansion.

---

## 2. Business Question

The analysis addresses the following primary business question:

> What drove WideWorldImporters' revenue growth during the complete
> 2013–2015 period: additional unit volume, changes in effective product value,
> or changes in the composition of products sold?

Supporting questions included:

- Did revenue grow faster than units sold?
- Did effective revenue per unit change at the individual-product level?
- Did the composition of units sold change toward relatively higher-value
  products?
- How much revenue growth can be attributed to volume versus product mix?
- Which products were the largest positive and negative contributors to the
  mix effect?

---

## 3. Analytical Scope and Methodology

### Data sources

The analysis uses the following objects from `WideWorldImportersDW`:

- `Fact.Sale`
- `Dimension.Date`
- `Dimension.[Stock Item]`

`WWI Stock Item ID` is used as the business-product identifier to prevent
historical dimension versions from being interpreted as separate products.

### Time period

The principal year-over-year analysis is restricted to:

- 2013
- 2014
- 2015

These are the complete calendar years available in the dataset.

The warehouse also contains 2016 sales data, but only through May 31, 2016.
Consequently, 2016 is not used in full-year year-over-year conclusions.

### Effective revenue per unit

For this analysis:

**Revenue per Unit = Total Excluding Tax / Quantity**

This metric represents effective revenue generated per unit in `Fact.Sale`.

It should not automatically be interpreted as catalog price, list price, or
the result of a formal pricing action.

---

## 4. Annual Commercial Performance

Annual performance increased consistently across the three complete years.

| Calendar Year | Units Sold | Revenue | Revenue per Unit |
|---|---:|---:|---:|
| 2013 | 2,401,657 | $45,707,188.00 | $19.03 |
| 2014 | 2,567,401 | $49,929,487.20 | $19.45 |
| 2015 | 2,740,266 | $53,991,490.45 | $19.70 |

From 2013 to 2015:

- units sold increased by **338,609 units**;
- revenue increased by **$8,284,302.45**;
- aggregate revenue per unit increased from **$19.03 to $19.70**.

The simultaneous increase in volume and aggregate revenue per unit required
further decomposition to determine the underlying source of revenue growth.

---

## 5. Year-over-Year Growth

### 2014 vs. 2013

| Metric | YoY Change |
|---|---:|
| Units Sold | +6.90% |
| Revenue | +9.24% |
| Revenue per Unit | +2.19% |

Revenue increased faster than unit volume.

### 2015 vs. 2014

| Metric | YoY Change |
|---|---:|
| Units Sold | +6.73% |
| Revenue | +8.14% |
| Revenue per Unit | +1.31% |

Revenue again increased faster than unit volume.

At the aggregate level, these results could be interpreted as evidence of an
increase in effective product value. Product-level validation was therefore
required before assigning the difference to a price or value effect.

---

## 6. Product-Level Validation

### Product coverage

The same number of distinct business products recorded sales in each complete
calendar year.

| Calendar Year | Products Sold |
|---|---:|
| 2013 | 219 |
| 2014 | 219 |
| 2015 | 219 |

This provides a stable product universe for the year-over-year comparison.

### Revenue-per-unit stability

Each product's effective revenue per unit was compared with the preceding year.

| Calendar Year | Products Compared | Increased | Decreased | Unchanged |
|---|---:|---:|---:|---:|
| 2014 | 219 | 0 | 0 | 219 |
| 2015 | 219 | 0 | 0 | 219 |

The result is unambiguous within the observed data:

**all 219 comparable products maintained unchanged effective revenue per unit
between consecutive complete years.**

Therefore, the increase in aggregate revenue per unit cannot be attributed to
observed within-product revenue-per-unit increases.

The evidence instead indicates a **product-mix effect**: the relative weights of
products within total units sold changed.

---

## 7. Volume–Mix Decomposition

Revenue growth was decomposed into:

### Volume Effect

The revenue change attributable to the change in total units sold, evaluated
using the previous year's aggregate revenue per unit.

### Mix Effect

The remaining revenue change associated with the shift in aggregate revenue per
unit.

Because product-level revenue per unit remained unchanged across all 219
comparable products, this residual is attributable to changes in the
composition of units sold within the observed product universe.

### Results

| Comparison | Revenue Change | Volume Effect | Volume Contribution | Mix Effect | Mix Contribution |
|---|---:|---:|---:|---:|---:|
| 2014 vs. 2013 | $4,222,299.20 | $3,154,360.42 | 74.71% | $1,067,938.78 | 25.29% |
| 2015 vs. 2014 | $4,062,003.25 | $3,361,788.98 | 82.76% | $700,214.27 | 17.24% |

The decomposition fully allocates the observed revenue change:

**2014**

`$3,154,360.42 + $1,067,938.78 = $4,222,299.20`

**2015**

`$3,361,788.98 + $700,214.27 = $4,062,003.25`

Volume was the dominant source of growth in both periods.

Its contribution increased from **74.71% to 82.76%**, while the contribution
from favorable product mix declined from **25.29% to 17.24%**.

---

## 8. How Product Mix Generated Revenue Growth

A product's mix contribution depends on two factors:

1. how its share of total units changed; and
2. whether its revenue per unit was above or below the portfolio average.

A favorable mix effect can therefore arise through either:

- increased share of relatively high-value products; or
- decreased share of relatively low-value products.

An unfavorable mix effect can arise through:

- decreased share of relatively high-value products; or
- increased share of relatively low-value products.

This distinction is important because a large change in unit share does not
necessarily represent a large economic impact.

---

## 9. Principal Mix Drivers

### 2014 vs. 2013

The five largest positive mix contributors were:

| Product | Revenue per Unit | Unit Share Change | Mix Effect |
|---|---:|---:|---:|
| 10 mm Double sided bubble wrap 50m | $105.00 | +0.1051 pp | +$232,057.68 |
| 32 mm Double sided bubble wrap 50m | $112.00 | +0.0858 pp | +$204,758.13 |
| Shipping carton (Brown) 500x310x310mm | $2.55 | -0.4284 pp | +$181,275.12 |
| Shipping carton (Brown) 305x305x305mm | $3.50 | -0.3824 pp | +$152,493.80 |
| Black and orange glass with care despatch tape 48mmx75m | $3.70 | -0.3506 pp | +$137,999.68 |

The results show both mechanisms of favorable mix movement.

Relatively high-value bubble-wrap products gained unit share, while several
low-value packaging products lost share.

### 2015 vs. 2014

The five largest positive mix contributors were:

| Product | Revenue per Unit | Unit Share Change | Mix Effect |
|---|---:|---:|---:|
| Shipping carton (Brown) 305x305x305mm | $3.50 | -0.5102 pp | +$222,970.93 |
| 20 mm Double sided bubble wrap 50m | $108.00 | +0.0860 pp | +$208,636.35 |
| 20 mm Anti static bubble wrap (Blue) 50m | $102.00 | +0.0905 pp | +$204,834.43 |
| Shipping carton (Brown) 229x229x229mm | $1.05 | -0.2254 pp | +$113,654.16 |
| Black and orange fragile despatch tape 48mmx100m | $4.10 | -0.2518 pp | +$105,879.78 |

The strongest 2015 driver was not a high-value product gaining share.

Instead, the $3.50 `Shipping carton (Brown) 305x305x305mm` declined from
**1.3632% to 0.8530%** of units sold, a reduction of **0.5102 percentage
points**.

Because the product's revenue per unit was substantially below the portfolio
average, its lower weight improved the aggregate product mix and contributed
**$222,970.93** to the calculated mix effect.

---

## 10. Principal Mix Detractors

### 2014 vs. 2013

The five largest negative mix contributors were:

| Product | Revenue per Unit | Unit Share Change | Mix Effect |
|---|---:|---:|---:|
| Air cushion machine (Blue) | $1,899.00 | -0.0031 pp | -$148,792.80 |
| 32 mm Anti static bubble wrap (Blue) 20m | $48.00 | -0.1363 pp | -$101,374.09 |
| Shipping carton (Brown) 356x229x229mm | $1.14 | +0.1829 pp | -$83,999.25 |
| Black and orange fragile despatch tape 48mmx100m | $4.10 | +0.1618 pp | -$62,039.67 |
| Black and yellow heavy despatch tape 48mmx100m | $4.10 | +0.1560 pp | -$59,809.56 |

### 2015 vs. 2014

The five largest negative mix contributors were:

| Product | Revenue per Unit | Unit Share Change | Mix Effect |
|---|---:|---:|---:|
| Shipping carton (Brown) 279x254x217mm | $1.11 | +0.2385 pp | -$119,834.49 |
| Air cushion machine (Blue) | $1,899.00 | -0.0020 pp | -$104,731.70 |
| Black and yellow heavy despatch tape 48mmx100m | $4.10 | +0.2290 pp | -$96,317.24 |
| 3 kg Courier post bag (White) 300x190x95mm | $0.66 | +0.1724 pp | -$88,752.84 |
| 32 mm Double sided bubble wrap 50m | $112.00 | -0.0342 pp | -$86,760.15 |

The `Air cushion machine (Blue)` illustrates why unit-share change should not
be evaluated independently from product value.

In 2015 its unit share decreased by only **0.0020 percentage points**, from
**0.0658% to 0.0638%**.

However, its revenue per unit was **$1,899.00**, resulting in a calculated
negative mix contribution of **$104,731.70**.

A small share movement can therefore have a material economic effect when the
product's unit value is substantially different from the portfolio average.

---

## 11. Product-Level Reconciliation

As a validation control, all individual product mix contributions were summed
and compared with the aggregate mix effect.

| Calendar Year | Aggregate Mix Effect | Reconciled Product Mix Effect | Difference |
|---|---:|---:|---:|
| 2014 | $1,067,938.78 | $1,067,938.62 | $0.16 |
| 2015 | $700,214.27 | $700,214.11 | $0.16 |

The $0.16 differences are immaterial relative to the calculated mix effects
and are consistent with numerical precision in intermediate calculations.

The reconciliation establishes analytical traceability between:

**total revenue growth → volume/mix decomposition → individual product
contributions.**

---

## 12. Key Findings

### 12.1 Revenue growth was predominantly volume-driven

Revenue increased by **$4.22 million in 2014** and **$4.06 million in 2015**.

Volume accounted for:

- **74.71%** of the 2014 increase;
- **82.76%** of the 2015 increase.

The evidence therefore does not support characterizing revenue growth as
primarily driven by increases in effective revenue per unit.

### 12.2 Aggregate revenue-per-unit growth was a composition effect

Aggregate revenue per unit increased:

- from **$19.03 in 2013**
- to **$19.45 in 2014**
- to **$19.70 in 2015**.

However, all 219 comparable products showed unchanged individual revenue per
unit.

The aggregate increase was therefore generated by changes in the relative
composition of units sold.

### 12.3 Product mix contributed positively in both complete-year comparisons

Product mix contributed:

- **$1,067,938.78** to 2014 revenue growth;
- **$700,214.27** to 2015 revenue growth.

The mix effect was positive in both periods.

### 12.4 The contribution of favorable mix weakened in 2015

Mix represented **25.29%** of revenue growth in 2014 but only **17.24%** in
2015.

At the same time, the volume contribution increased to **82.76%**.

The 2015 growth profile was therefore more dependent on unit expansion than the
2014 growth profile.

### 12.5 Mix impact cannot be evaluated from share movement alone

The analysis identified products with very small share movements but material
mix effects, as well as low-value products whose declining share contributed
positively to aggregate revenue per unit.

Product-level economic value and direction of share movement must therefore be
evaluated together.

### 12.6 Product roles changed between periods

Some products changed from drivers to detractors between 2014 and 2015.

For example:

- `10 mm Double sided bubble wrap 50m` generated a **+$232,057.68** mix effect
  in 2014 but a **-$85,941.51** effect in 2015.
- `32 mm Double sided bubble wrap 50m` generated a **+$204,758.13** effect in
  2014 but a **-$86,760.15** effect in 2015.
- `Shipping carton (Brown) 279x254x217mm` generated a **+$72,522.26** effect
  in 2014 but a **-$119,834.49** effect in 2015.

The favorable aggregate mix effect therefore did not result from a fixed group
of permanently favorable products. Product contributions changed materially
between periods.

---

## 13. Business Interpretation

The evidence supports the following interpretation:

> WideWorldImporters' revenue growth across the complete 2013–2015 period was
> driven primarily by increased unit volume and supplemented by favorable
> changes in product mix. The contribution from product mix remained positive
> but weakened in 2015, making growth increasingly dependent on additional
> unit volume.

This distinction is commercially relevant.

Volume-driven revenue growth requires the business to continue generating
additional unit demand. Depending on the underlying cause, that could require
more customers, more transactions, larger orders, greater purchase frequency,
or other sources of volume expansion.

The current analysis does **not** identify which of those mechanisms caused the
observed volume growth.

Likewise, the analysis establishes which products contributed to mix movement
but does not establish why their relative demand changed.

Those are separate analytical questions requiring additional evidence.

---

## 14. Analytical Limitations

### Partial 2016 data

The dataset contains:

- 1,241,304 units;
- $22,633,175.55 in revenue;
- 227 products sold

during the available 2016 period.

However, sales observations end on **May 31, 2016**.

The apparent year-over-year values of **-54.70% in units** and **-58.08% in
revenue** are therefore not interpreted as annual performance declines because
they compare a partial year with a complete year.

### Revenue per unit is an analytical measure

`Revenue per Unit` is calculated from transactional revenue and quantity.

The analysis does not establish that this metric is equivalent to a list price,
catalog price, or formal pricing policy.

Consequently, the finding is expressed as stability in **effective revenue per
unit**, not as proof that no pricing changes occurred anywhere in the business.

### Decomposition is descriptive, not causal

The volume–mix model explains how observed revenue growth can be mathematically
allocated.

It does not establish the business causes of:

- increased unit volume;
- changing product shares;
- customer purchasing behavior;
- product availability;
- promotions;
- geographic differences;
- salesforce activity; or
- seasonality.

Those explanations require additional analysis.

---

## 15. Recommended Next Analytical Questions

The current analysis answers the revenue growth-driver question sufficiently to
close this analytical module.

The highest-value follow-up questions are:

1. **What drove unit-volume growth?**  
   Determine whether growth came from more customers, more invoices, more units
   per invoice, or changes in customer purchasing frequency.

2. **Did revenue growth translate into proportional profit growth?**  
   Evaluate whether volume and favorable mix also improved profitability.

3. **Which products drive negative-profit transactions?**  
   Previous data-quality and commercial analysis identified negative-profit
   rows that warrant separate investigation.

4. **Are product-mix movements associated with specific customers or customer
   segments?**  
   Determine whether favorable mix is broad-based or concentrated.

5. **Are product-mix changes persistent or seasonal?**  
   Extend the decomposition to appropriate monthly or seasonal comparisons.

These questions should be addressed in separate analytical modules rather than
added to the current script without a defined business objective.

---

## 16. Reproducibility

The calculations supporting this document are implemented in:

`sql/02_analysis/02_price_volume_mix_analysis.sql`

The script includes:

- annual revenue, units, and effective revenue-per-unit analysis;
- year-over-year growth calculations;
- product-level revenue-per-unit validation;
- product coverage controls;
- volume–mix decomposition;
- product unit-share analysis;
- product-level mix attribution;
- reconciliation controls; and
- driver/detractor rankings.

All quantitative findings reported in this document are based on the validated
outputs of that analysis.