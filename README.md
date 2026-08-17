# WideWorldImporters Analytics

End-to-end Business Intelligence and Data Analytics project developed using the Microsoft WideWorldImporters sample databases.

## Project Objective

The objective of this project is to analyze the commercial operations of Wide World Importers and transform transactional data into business insights through SQL Server, dimensional modeling, data validation, and Power BI.

The project follows a structured analytics workflow:

1. Database discovery and profiling
2. Business question and KPI definition
3. Analytical SQL development
4. Data quality and validation
5. Semantic modeling
6. Power BI dashboard development
7. Business insight generation

## Data Sources

The project uses Microsoft's WideWorldImporters sample databases:

- `WideWorldImporters` — OLTP transactional database
- `WideWorldImportersDW` — analytical data warehouse

The original SQL Server backup files (`.bak`) are stored locally and are intentionally excluded from version control.

## Technology Stack

- SQL Server 2025
- SQL Server Management Studio
- Visual Studio Code
- Git / GitHub
- Power BI

## Repository Structure

```text
WideWorldImporters-Analytics/
├── docs/                # Project documentation
├── images/              # Dashboard and project screenshots
├── powerbi/             # Power BI project files
├── sql/
│   ├── 00_setup/        # Environment and database validation
│   ├── 01_profiling/    # Data discovery and profiling
│   ├── 02_analysis/     # Business analysis queries
│   └── 03_validation/   # Data quality and reconciliation
├── .gitignore
└── README.md