-- which job title has the most entry level staffs and which one has the most expert level staffs
with job_info as (
		select job_title,
        case when experience_level = 'EX' then 'Expert'
			 when experience_level = 'SE' then 'Intermediate'
             when experience_level = 'MI' then 'Junior'
             else 'Entry'
		 end as experience,
        count(*) as total from ds_salaries_bk_up
		group by job_title, experience_level),
	 t1 as (
		select * from job_info where experience = 'Expert'
        order by total desc
        limit 1),
	 t2 as (
		select * from job_info where experience = 'Entry'
        order by total desc
		limit 1)
select * from t1
union
select * from t2