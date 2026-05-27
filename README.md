📊 Tech Industry Layoffs – Data Cleaning & Exploratory Analysis (PostgreSQL)
Visualizations: https://public.tableau.com/views/WorldLayoffsDataCleaningAnalysis/Top5LayoffsByIndustry?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

📌 Project Overview

This project analyzes a real-world tech industry layoffs dataset using PostgreSQL. The workflow is divided into two main phases: structured data cleaning and exploratory data analysis (EDA). The objective was to transform raw data into a clean, reliable dataset and extract meaningful insights about workforce reductions across companies, industries, countries, funding stages, and time periods.

🗂 Project Structure

data_cleaning.sql – Data cleaning and transformation queries

exploratory_analysis.sql – Analytical queries and insight generation

🧹 Phase 1: Data Cleaning (data_cleaning.sql)

A staging table was created to preserve the integrity of the original dataset before applying transformations.

Cleaning Steps Performed:

Created a duplicate of the raw dataset as a staging table

Removed duplicate records using window functions

Standardized inconsistent text values (e.g., company names, industry labels)

Trimmed whitespace and corrected formatting inconsistencies

Converted and standardized date fields

Handled NULL and missing values

Removed unnecessary or incomplete records

This process ensured the dataset was structured, consistent, and ready for analysis.

📈 Phase 2: Exploratory Data Analysis (exploratory_analysis.sql)

After cleaning, exploratory analysis was conducted to identify trends and extreme values within the dataset.

Key Analyses:

Identified the maximum total layoffs and highest percentage layoffs

Determined companies with the largest cumulative layoffs

Aggregated layoffs by industry and country

Analyzed layoffs by company funding stage

Performed year-over-year layoff analysis using date extraction

Calculated rolling monthly layoff totals using window functions

Ranked top companies per year using DENSE_RANK()

Used Common Table Expressions (CTEs) to structure complex queries

🛠 Skills Demonstrated

PostgreSQL

Data cleaning & transformation

Window functions (ROW_NUMBER, DENSE_RANK)

Aggregate functions (SUM, MAX, COUNT)

Subqueries

CTEs

Time-series analysis

Analytical thinking & business insight extraction

🎯 Key Insights Generated

Identified companies responsible for the largest workforce reductions

Observed concentration of layoffs within specific industries and countries

Detected significant increases in layoffs during specific years

Highlighted funding-stage patterns associated with layoffs

🚀 Project Purpose

This project demonstrates the ability to:

Clean and prepare raw relational data

Write structured, production-style SQL queries

Perform exploratory data analysis using advanced SQL techniques

Translate raw data into meaningful business insights
