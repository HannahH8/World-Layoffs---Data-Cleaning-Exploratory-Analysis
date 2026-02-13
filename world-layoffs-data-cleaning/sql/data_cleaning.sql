-- Data Cleaning

-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null/Blank Values
-- 4. Remove Unneeded Columns

-- ===========================================================
-- 1. Removing Duplicates
-- ===========================================================

-- preview duplicates
-- Assigns a row number to records that share identical values
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
from layoffs_staging;

-- view duplicate rows
with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, "date", stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1;

-- delete duplicate rows
with duplicate_cte as
(
select ctid,
row_number() over(
partition by company, location, industry, total_laid_off, "date", stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete from layoffs_staging
where ctid in (
    select ctid
    from duplicate_cte
    where row_num > 1
);

-- ============================================================
-- 2. Standardizing Data
-- ============================================================

-- review distinct company values for inconsistencies
select distinct(company)
from layoffs_staging;

-- remove leading/trailing spaces from company names
update layoffs_staging
set company = trim(company);

-- review distinct industry values for inconsistencies
select distinct(industry)
from layoffs_staging
order by 1;

-- Standardize variations of "Crypto" into one consistent label
select *
from layoffs_staging
where industry like 'Crypto%';

update layoffs_staging
set industry = 'Crypto'
where industry like 'Crypto%';

-- review disctinct country values
select distinct(country)
from layoffs_staging
order by 1

-- remove trailing period from "United States"
update layoffs_staging
set country = trim(trailing '.' from country)
where country like 'United States%'

-- convert date column from text to date datatype
alter table layoffs_staging
alter column "date" type date
using to_date("date", 'MM/DD/YYYY')

-- ======================================================
--  3. Handling NULL and Missing Values
-- ======================================================

-- identify rows where industry is null or blank
select *
from layoffs_staging
where industry is null
or industry = '';

-- preview missing industry values
select *
from layoffs_staging
where company = 'Airbnb'

select ls1.company, ls1.industry, ls2.industry
from layoffs_staging ls1
join layoffs_staging ls2
	on ls1.company = ls2.company
where (ls1.industry is null or ls1.industry = '')
and ls2.industry is not null

-- update missing industry values using matching company records
update layoffs_staging ls1
set industry = ls2.industry
from layoffs_staging ls2
where ls1.company = ls2.company
and (ls1.industry is null or ls1.industry = '')
and ls2.industry is not null;

-- ==================================================
-- 4. Removing Unneeded Columns & Rows
-- ==================================================

-- delete rows where both layoff metrics are missing
delete 
from layoffs_staging
where total_laid_off is null
and percentage_laid_off is null

select *
from layoffs_staging