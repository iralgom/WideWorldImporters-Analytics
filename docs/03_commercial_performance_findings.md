# Commercial Performance Findings

## 1. Purpose

This document summarizes the findings obtained from the initial commercial performance analysis performed on `Fact.Sale`.

The analysis addresses:

- **BQ01** — How have revenue, profit, units sold, and invoice volume evolved?
- **BQ02** — Is revenue growth accompanied by proportional profit growth?
- **BQ03** — Are there meaningful annual, monthly, or seasonal patterns?

The objective of this phase is to establish the overall commercial behavior of Wide World Importers before investigating the underlying drivers by product, customer, geography, and salesperson.

---

## 2. Analysis Period

The available sales data covers:

**January 1, 2013 through May 31, 2016**

The 2016 period is incomplete and contains only five months of activity.

Therefore:

> Full-year comparisons between 2016 and previous calendar years are not analytically valid.

2016 should instead be evaluated through comparable-period metrics such as monthly YoY analysis or January-May comparisons.

---

## 3. Overall Commercial Baseline

Across the complete available period, the business generated:

| KPI | Result |
|---|---:|
| Invoices | 70,510 |
| Units Sold | 8,950,628 |
| Revenue | $172,261,341.20 |
| Profit | $85,729,180.90 |
| Profit Margin | 49.77% |
| Average Invoice Value | $2,443.08 |
| Profit per Invoice | $1,215.84 |

Revenue is measured excluding tax according to the KPI framework.

These values establish the commercial baseline against which subsequent analytical results and Power BI measures should be reconciled. :contentReference[oaicite:0]{index=0}

---

## 4. Annual Performance

Commercial activity expanded consistently across the three complete calendar years.

| Year | Invoices | Units Sold | Revenue | Profit | Margin |
|---|---:|---:|---:|---:|---:|
| 2013 | 18,767 | 2,401,657 | $45.71M | $22.77M | 49.81% |
| 2014 | 20,303 | 2,567,401 | $49.93M | $24.83M | 49.73% |
| 2015 | 22,250 | 2,740,266 | $53.99M | $26.96M | 49.93% |

Revenue, profit, invoices, and units all increased from 2013 through 2015. :contentReference[oaicite:1]{index=1}

### Annual Growth

2014 versus 2013:

- Revenue: **+9.24%**
- Profit: **+9.05%**
- Invoices: **+8.18%**
- Units: **+6.90%**

2015 versus 2014:

- Revenue: **+8.14%**
- Profit: **+8.58%**
- Invoices: **+9.59%**
- Units: **+6.73%** :contentReference[oaicite:2]{index=2}

### Finding

The commercial expansion between 2013 and 2015 was broad-based rather than dependent on a single top-level metric.

Revenue growth was accompanied by increases in:

- invoice volume;
- units sold;
- aggregate profit.

Profit also grew at approximately the same rate as revenue.

This indicates that the expansion did not require a material sacrifice in aggregate profitability.

---

## 5. Profit Margin Stability

Although monthly profit margin fluctuates, the aggregate annual margin remained remarkably stable.

Annual margins were:

- 2013: **49.81%**
- 2014: **49.73%**
- 2015: **49.93%**

Across individual months, observed profit margins ranged approximately from:

**48.79% to 50.62%**. :contentReference[oaicite:3]{index=3}

### Finding

The available evidence does **not** support describing overall profitability as highly volatile.

A more accurate interpretation is:

> Aggregate profitability remained structurally stable around 50%, despite short-term monthly fluctuations.

This stability may nevertheless conceal substantial differences between products, customers, territories, or individual transactions.

The previously identified negative-profit transactions provide evidence that aggregate margin can mask materially different underlying profitability patterns.

---

## 6. Monthly Performance Variability

Monthly commercial activity exhibits substantially greater variability than annual aggregates.

Examples include:

### 2015

April versus March:

- Revenue: **+12.04%**
- Profit: **+12.70%**
- Invoices: **+10.93%**
- Units: **+7.01%**

May versus April:

- Revenue: **-11.68%**
- Profit: **-12.24%**
- Invoices: **-8.07%**
- Units: **-11.73%**

July versus June:

- Revenue: **+14.17%**
- Profit: **+16.01%**
- Invoices: **+15.34%**
- Units: **+19.18%**

August versus July:

- Revenue: **-23.61%**
- Profit: **-23.98%**
- Invoices: **-24.19%**
- Units: **-23.33%**. :contentReference[oaicite:4]{index=4}

### Finding

Short-term commercial activity is significantly more volatile than the annual trend suggests.

Revenue, profit, invoice volume, and units frequently move in the same direction, which indicates that volume is an important driver of month-to-month fluctuations.

However, the magnitude of these movements is not always identical, suggesting that additional effects such as product mix or effective selling price may also be present.

---

## 7. Year-over-Year Monthly Performance

Monthly YoY analysis reveals that annual growth was not uniformly distributed across months.

Examples from 2015 versus 2014 include:

- April revenue: **+23.88%**
- April profit: **+24.83%**
- May revenue: **-2.39%**
- May profit: **-2.35%**
- September revenue: **+20.08%**
- September profit: **+18.75%**. :contentReference[oaicite:5]{index=5}

The first five months of 2016 also show mixed results:

- January revenue: +1.05%
- February: -4.52%
- March: +2.59%
- April: -10.04%
- May: +10.94%. :contentReference[oaicite:6]{index=6}

### Finding

Annual growth masks meaningful monthly divergence.

The business does not appear to follow a simple uninterrupted growth trajectory.

Instead, commercial performance alternates between periods of strong expansion and temporary contraction.

This reinforces the need to investigate underlying product, customer, and mix drivers rather than relying exclusively on annual aggregates.

---

## 8. Seasonality

Average monthly revenue by calendar month shows meaningful variation.

The highest observed average monthly revenue occurs in:

**July — approximately $4.77M**

The lowest occurs in:

**February — approximately $3.61M**

Other relatively strong months include:

- May — approximately $4.62M
- April — approximately $4.45M
- June — approximately $4.28M. :contentReference[oaicite:7]{index=7}

### Finding

The results suggest a recurring seasonal pattern:

- February tends to be relatively weak.
- Commercial activity strengthens toward spring and early summer.
- July is the strongest observed month.
- August shows a notable decline following July.

However, only three complete calendar years are available.

Therefore:

> The pattern should be described as **observed seasonality**, not as a proven long-term seasonal structure.

A longer historical period would be required for stronger statistical confirmation.

---

## 9. Commercial Efficiency

Monthly commercial efficiency was evaluated using:

- Profit Margin;
- Revenue per Invoice;
- Units per Invoice;
- Revenue per Unit.

### Profit Margin

The metric remains relatively stable across the observed period, generally close to 50%.

This suggests that changes in total profit are primarily associated with changes in the scale and composition of sales rather than dramatic changes in aggregate margin.

### Revenue per Invoice

Monthly revenue per invoice generally remains within a relatively narrow range around the overall baseline of approximately $2.44K.

Examples include:

- January 2013: $2,300.43
- August 2014: $2,598.91
- May 2016: $2,551.81. :contentReference[oaicite:8]{index=8}

### Units per Invoice

Average units per invoice vary more noticeably over time.

Examples include:

- January 2013: 117.92
- May 2013: 133.60
- September 2015: 117.69
- May 2016: 138.62. :contentReference[oaicite:9]{index=9}

### Revenue per Unit

Revenue per unit also changes across periods.

Observed values include approximately:

- $18.19 in August 2013;
- $21.00 in August 2014;
- $20.66 in February 2015;
- $17.77 in January 2016. :contentReference[oaicite:10]{index=10}

### Interpretation

The combined movement of units sold and revenue per unit suggests that commercial growth cannot yet be attributed exclusively to volume or pricing.

An increase in revenue per unit can result from:

1. higher selling prices;
2. selling a greater proportion of higher-priced products;
3. both effects simultaneously.

Therefore:

> Revenue per unit should be treated as a diagnostic metric rather than a direct measure of price.

A dedicated price-volume-mix analysis is required before assigning causal drivers.

---

## 10. Assessment of the 2014–2015 Growth

Between 2014 and 2015:

- Revenue increased 8.14%.
- Profit increased 8.58%.
- Invoice count increased 9.59%.
- Units increased 6.73%. :contentReference[oaicite:11]{index=11}

### Observed Fact

Revenue grew faster than units.

### Inference

The difference indicates that volume alone does not fully explain revenue growth.

### What Cannot Yet Be Concluded

The current results do **not** establish that price increases were the principal cause.

Changes in product mix could produce the same aggregate behavior.

### Required Analysis

A subsequent price-volume-mix analysis should determine how much of revenue change is associated with:

- volume;
- effective selling price;
- product mix.

---

## 11. Preliminary Answers to Business Questions

### BQ01 — How has commercial performance evolved?

Commercial activity expanded consistently during the complete years 2013–2015.

Revenue, profit, invoices, and units all increased.

Monthly activity, however, exhibits substantially greater volatility than annual aggregates.

### BQ02 — Is revenue growth accompanied by proportional profit growth?

Yes, at the aggregate annual level.

Revenue and profit grew at similar rates, while profit margin remained approximately stable around 50%.

This suggests that growth did not materially erode aggregate profitability.

### BQ03 — Are meaningful temporal patterns present?

Yes.

The data shows:

- substantial month-to-month variability;
- heterogeneous YoY performance by month;
- recurring strength around July;
- recurring weakness around February and August.

The limited number of complete years means that seasonal conclusions should remain provisional.

---

## 12. Analytical Questions Generated by This Phase

The commercial performance analysis generates several questions requiring deeper investigation:

1. What explains the difference between revenue growth and unit growth?
2. How much of revenue growth comes from volume, price, or product mix?
3. Which products explain monthly peaks and declines?
4. Are the highest-revenue products also the most profitable?
5. Are particular products responsible for fluctuations in aggregate margin?
6. Why are negative-profit transactions concentrated across only 18 products?
7. Do customer composition or geography explain part of the monthly volatility?
8. Are changes in revenue per invoice driven by units, product mix, or pricing?

These questions provide the analytical bridge between descriptive performance analysis and diagnostic analysis.

---

## 13. Conclusion

The initial commercial analysis indicates a business with:

- sustained growth during the complete 2013–2015 period;
- stable aggregate profitability;
- significant short-term monthly variability;
- observable seasonal patterns;
- commercial growth influenced by more than unit volume alone.

The evidence is sufficient to close the descriptive commercial-performance phase.

However, it is not sufficient to establish the causal drivers of revenue growth.

The next analytical phase should therefore focus on decomposing revenue performance into:

> **Volume, Price, and Product-Mix effects.**

---

## 14. Next Step

The next analytical script will be:

`sql/02_analysis/02_price_volume_analysis.sql`

Its purpose will be to determine whether changes in commercial performance are primarily associated with:

- changes in units sold;
- changes in effective selling prices;
- changes in product composition.

This analysis will test the principal hypothesis generated during the commercial-performance phase before proceeding to detailed product-performance analysis.