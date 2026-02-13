-- Exploratory Analysis

-- max total laid off (in one day): 1200, max percentage laid off: 100%
select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging;

-- max raised: 2400.00, company: Britishvolt
select *
from layoffs_staging
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- max laid off (sum): 18150, company: Amazon
select company, sum(total_laid_off)
from layoffs_staging
group by company
order by 2 desc;

-- began around early covid
select min("date"), max("date")
from layoffs_staging;

-- industry with most layoffs: consumer
select industry, sum(total_laid_off)
from layoffs_staging
group by industry
order by 2 desc;

-- country with most layoffs: united states
select country, sum(total_laid_off)
from layoffs_staging
group by country
order by 2 desc;

-- year with most layoffs: 2023
select extract(year from "date"), sum(total_laid_off)
from layoffs_staging
group by 1
order by 1 desc;

-- company stage with most layoffs: Post-IPO
select stage, sum(total_laid_off)
from layoffs_staging
group by stage
order by 2 desc;

-- rolling total of layoffs: 378689
with rolling_total as (
select to_char("date", 'yyyy-mm') as month, sum(total_laid_off) as total_off
from layoffs_staging
where "date" is not null
group by month
order by month asc
)
select month, total_off, sum(total_off) over(order by month) as rolling_total
from rolling_total;

-- layoffs per year by company
select company, extract(year from "date"), sum(total_laid_off)
from layoffs_staging
group by company, extract(year from "date")
order by company asc;

-- by sum
select company, extract(year from "date"), sum(total_laid_off)
from layoffs_staging
group by company, extract(year from "date")
order by 3 desc;

-- order and rank company layoffs by year
with company_year (company, years, total_laid_off) as
(
select company, extract(year from "date"), sum(total_laid_off)
from layoffs_staging
group by company, extract(year from "date")
), company_year_rank as
(select *, 
dense_rank() over (partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
and total_laid_off is not null
)
select *
from company_year_rank
where ranking <= 5;

-- order and rank industries layoffs by year
with industry_year (industry, years, total_laid_off) as
(
select industry, extract(year from "date"), sum(total_laid_off)
from layoffs_staging
group by industry, extract(year from "date")
), industry_year_rank as
(select *, 
dense_rank() over (partition by years order by total_laid_off desc) as ranking
from industry_year
where years is not null
and total_laid_off is not null
)
select *
from industry_year_rank
where ranking <= 5


