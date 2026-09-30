# Source data

The raw Cyclistic CSV files are intentionally not included in this repository.

The analysis used quarterly 2019 trip CSVs, imported into MySQL locally. The source files were kept separately from the Git repository because they are large and are not required to reproduce the documented SQL logic.

Place local source files outside this repository and update the paths in `sql/03_trip_staging_and_loading.sql` when reproducing the import.
