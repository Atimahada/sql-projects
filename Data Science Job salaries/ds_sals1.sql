-- for each year get the highest paid job title by company_size
select work_year, job_title, salary_in_usd as salary_per_annum, company_size from (
	select *, rank() over(partition by work_year, company_size order by salary_in_usd desc) as rnk 
	from ds_salaries_bk_up) ds
where rnk = 1
order by company_size desc;
