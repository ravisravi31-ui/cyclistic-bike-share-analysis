# Cyclistic Bike-Share Analysis — 2019

A SQL + Excel data analytics case study answering the business question:

> **How do annual Members and Casual riders use Cyclistic bikes differently?**

## Project overview

This project analyzes **3,818,004 Cyclistic trips from 2019**. The analysis was performed in MySQL and summarized/visualized in Excel.

The project follows the case-study workflow:

**Ask → Prepare → Process → Analyze → Share → Act**

## Tools

- MySQL / SQL
- Excel
- GitHub
- Data visualization and business storytelling

## Key findings

- Members account for the majority of rides.
- Casual riders have substantially longer average rides.
- Casual usage has a stronger weekend component.
- Ride demand rises strongly during the warmer months and peaks in Q3.
- 17:00 is the highest-volume hour in the 2019 dataset.
- 72.6% of rides with valid duration are under 20 minutes.

## Data preparation

The raw trip data was loaded into a MySQL staging table and then transformed into an analysis-ready table.

Key transformations included:

- Converting timestamps into MySQL datetime values
- Converting trip duration from seconds to minutes
- Creating day-of-week, hour, month and quarter fields
- Standardizing `Subscriber` / `Customer` into `Member` / `Casual`
- Creating age groups
- Identifying missing/invalid birth years
- Identifying extreme ride durations

### Ride-duration treatment

There were **1,848 rides longer than 24 hours (0.05%)**. These trips were retained in the raw data but excluded from ride-length metrics so that extreme durations did not distort duration-based analysis.

### Demographic treatment

Blank or implausible birth years were not used to calculate age, but the associated trip records were retained for non-demographic analysis.

## Analysis

The SQL analysis covers:

- Member vs Casual ride volume
- Average ride length
- Day-of-week patterns
- Month and quarter trends
- Hourly demand
- Weekday vs weekend
- Ride-length distribution
- Age and gender
- Top starting and ending stations
- Top station-to-station routes

## Repository structure

```text
cyclistic-bike-share-analysis/
├── README.md
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_station_history.sql
│   ├── 03_trip_staging_and_loading.sql
│   ├── 04_trip_cleaning.sql
│   ├── 05_analysis_queries.sql
│   └── 06_summary_tables.sql
├── docs/
│   ├── data_cleaning.md
│   └── findings_and_recommendations.md
├── data/
│   └── README.md
├── images/
│   └── chart assets
└── reports/
    ├── Excel analysis workbook
    ├── Case study report
    └── Presentation
```

## Important note about data files

The original CSV files are not included in this repository. The analysis was performed locally in MySQL. Keeping the raw files outside Git prevents a very large repository and preserves the distinction between source data and derived project artifacts.

## Deliverables

See the `reports/` folder for the analysis workbook, case-study report and presentation.

## Recommendations

The recommended next step is to test membership-conversion campaigns during high-Casual-usage periods and evaluate conversion using campaign exposure, sign-up and retention metrics. These are testable recommendations rather than causal conclusions.
