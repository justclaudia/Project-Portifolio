SELECT MAX(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1;

Select*
From layoffs_staging2
WHERE percentage_laid_off = 1
Order by total_laid_off desc;

select company, sum(total_laid_off)
From layoffs_staging2
group by company
order by 2 desc;

select substring(`date`, 1, 7) as `month`, sum(total_laid_off)
From layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc;

With Rolling_total As
(
select substring(`date`, 1, 7) as `MONTH`, sum(total_laid_off) as total_layoff
From layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc
)

select `MONTH`,  total_layoff
,Sum(total_layoff) over(order by `MONTH`) as rolling_total
From Rolling_total;

select company, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
group by company, YEAR(`date`)
order by company asc;

With Company_Year (Company, years, total_laid_off) AS
(
select company, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
group by company, YEAR(`date`)
),  Company_Year_Rank as
(
Select*, dense_rank() over (partition by years order by total_laid_off desc) as Ranking
From Company_Year
Where years is not null
)
Select*
From  Company_Year_Rank
Where Ranking <= 5;