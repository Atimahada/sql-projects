-- Average salary by experience level for each work year
select * from (
select work_year,
case when experience_level = 'EX' then 'Expert'
	 when experience_level = 'SE' then 'Intermediate'
	 when experience_level = 'MI' then 'Junior'
	 else 'Entry'
end as experience,
round(avg(salary_in_usd)) as avg_salary_usd from ds_salaries_bk_up
group by work_year, experience_level) avg_sal
order by work_year, avg_salary_usd desc