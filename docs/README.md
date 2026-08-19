# WideWorldImporters Analytics — Documentation

This directory contains the analytical and technical documentation for the
**WideWorldImporters Analytics** portfolio project.

The documentation follows the analytical workflow of the project, from initial
data profiling and validation to business analysis, KPI definition, analytical
findings, and ultimately Power BI development.

---

## Documentation Structure

### 01 — Data Profiling Findings

**File:** [`01_data_profiling_findings.md`](01_data_profiling_findings.md)

Documents the initial exploration and validation of the WideWorldImporters
analytical environment.

Topics include:

- source architecture and data coverage;
- `Fact.Sale` analytical grain;
- dimensional structure;
- Slowly Changing Dimension behavior;
- referential integrity;
- completeness and arithmetic validation;
- negative-profit transactions;
- initial data-quality conclusions.

This phase establishes whether the available data is sufficiently reliable for
subsequent business analysis.

---

### 02 — Business Questions & KPI Framework

**File:** [`02_business_questions_kpi_framework.md`](02_business_questions_kpi_framework.md)

Defines the analytical contract for the project before analytical SQL and
Power BI development.

Topics include:

- analytical objective and scope;
- business questions;
- KPI definitions;
- calculation rules;
- analytical dimensions;
- dimensional-history considerations;
- data-quality considerations;
- SQL and Power BI reconciliation principles.

The framework ensures that analytical development is driven by explicit
business questions rather than isolated exploratory queries.

---

### 03 — Commercial Performance Findings

**File:** [`03_commercial_performance_findings.md`](03_commercial_performance_findings.md)

Documents the findings from the initial commercial performance analysis.

The analysis evaluates:

- revenue and profit evolution;
- invoice and unit growth;
- annual and monthly performance;
- year-over-year growth;
- month-over-month growth;
- profit margin behavior;
- commercial efficiency;
- observed seasonality;
- revenue per invoice;
- units per invoice;
- revenue per unit.

This phase establishes the descriptive commercial baseline and identifies the
questions that require deeper diagnostic analysis.

---

## Spanish Analytical Findings

Spanish versions of selected analytical findings are available in the
[`es/`](es/) directory.

These documents provide an alternative-language version of the analytical
interpretation while the English documentation remains the canonical
documentation for the repository.

Current Spanish documentation:

- [`03_hallazgos_desempeno_comercial.md`](es/03_hallazgos_desempeno_comercial.md)

---

## Analytical Workflow

The documentation follows the project workflow:

```text
Data Environment
      │
      ▼
Data Profiling & Quality
      │
      ▼
Business Questions & KPI Framework
      │
      ▼
Commercial Performance Analysis
      │
      ▼
Price / Volume / Mix Analysis
      │
      ▼
Product Analysis
      │
      ▼
Customer Analysis
      │
      ▼
Geographic & Sales Analysis
      │
      ▼
Power BI Semantic Model
      │
      ▼
Dashboard & Business Insights