-- Data Cleaning

-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null/Blank Values
-- 4. Remove Unneeded Columns

CREATE TABLE layoffs(
company text,
location text,
industry text,
total_laid_off integer,
percentage_laid_off numeric(5,4),
date text,
stage text,
country text,
funds_raised_millions numeric(10,2)
);

create table layoffs_staging
(like layoffs including all);

insert into layoffs_staging
select *
from layoffs;