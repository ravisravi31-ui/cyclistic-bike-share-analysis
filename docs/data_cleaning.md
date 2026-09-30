# Data cleaning and manipulation

## Scope

The final analysis uses the full **2019** trip dataset containing **3,818,004 trips**.

## Workflow

1. Import quarterly CSV files into a MySQL staging table.
2. Validate row counts and duplicate trip IDs.
3. Inspect missing and malformed values.
4. Create a cleaned analysis table.
5. Derive time and demographic fields.
6. Save compact summary tables for reporting.

## Cleaning rules

### Trip duration
`tripduration` is stored in seconds in the source data.

For analysis, it was converted to minutes.

There were 1,848 trips longer than 24 hours (0.05% of all trips). These were not deleted from raw data. Their ride-length metric was set to `NULL` in the cleaned analysis table.

### Birth year
Blank birth years and implausible birth years below 1900 were treated as missing for age analysis. The underlying trip records were retained.

### User type
Source categories were standardized:

- `Subscriber` → `Member`
- `Customer` → `Casual`

### Date/time
Source timestamp strings were converted to MySQL datetime values. Derived fields were created for:

- day of week
- hour
- month
- quarter
- age

## Validation

The project checked:

- Total row counts by period
- Duplicate trip IDs
- Core-field completeness
- Duration minima/maxima
- Invalid duration values
- Birth-year anomalies
- Same-station vs different-station trips

The cleaned dataset preserved all trip records; only invalid metrics were nullified for the specific analyses they could not support.
