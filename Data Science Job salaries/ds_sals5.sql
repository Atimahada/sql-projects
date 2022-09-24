-- Average salary by remote ratio for each work year
select * from (
select work_year,
 case when remote_ratio = 0 then 'No remote'
	 when remote_ratio = 50 then 'Partially remote'
     when remote_ratio = 100 then 'Fully remote'
end as remote_desc,
round(avg(salary_in_usd)) as avg_salary_usd from ds_salaries_bk_up
group by work_year, remote_ratio) avg_sal
order by work_year, avg_salary_usd desc