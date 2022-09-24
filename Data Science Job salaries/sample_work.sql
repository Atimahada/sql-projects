-- cleaning the data
-- The dataset contains no null values
-- removing duplicates
-- creating a back up table
/*
insert into ds_salaries_bk_up
-- returns a cleaned table with no duplicates and no null values and inserting it into the new back up table
select work_year, experience_level, employment_type, job_title, 
	   salary, salary_currency, salary_in_usd, employee_residence, 
       remote_ratio, company_location, company_size 
from (-- returns a table with row number given to each records which fulfil the requirements in the partition by clause
	select  *, 
		row_number() over(partition by work_year, experience_level, 
							employment_type, job_title, salary, salary_currency, 
                            salary_in_usd, employee_residence, remote_ratio, company_location, company_size) as rn
	from (-- returns a table with no null values
			select * from ds_salaries
			where (work_year is not null and experience_level is not null and employment_type is not null 
					and job_title is not null and salary is not null and salary_currency is not null
					and salary_in_usd is not null and employee_residence is not null and remote_ratio is not null
					and company_location is not null and company_size is not null)) no_null_table
	order by work_year, company_size, remote_ratio)tb
where rn = 1;
*/

-- Query 1
-- for each year get the highest paid job title by company_size
/*
select work_year, job_title, salary_in_usd as salary_per_annum, company_size from (
	select *, rank() over(partition by work_year, company_size order by salary_in_usd desc) as rnk 
	from ds_salaries_bk_up) ds
where rnk = 1
order by company_size desc;
*/

-- Query 2
-- for each year get the percentage of remoteness (remote_ratio) by company size
/*
with remote1 as (
		select work_year, experience_level, employment_type, 
        job_title, salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size, 
        max(rn) over(partition by work_year, company_size) as sum_total
        from
		(select *, row_number() over(partition by work_year, company_size) as rn
		from ds_salaries_bk_up)t1),
	 remote2 as (
		select *, count(remote_ratio) as total
		from remote1
		group by work_year, company_size, remote_ratio)
select work_year, company_size, round((total/sum_total * 100), 2) as 'remoteness(%)',
case when remote_ratio = 0 then 'No remote'
	 when remote_ratio = 50 then 'Partially remote'
     when remote_ratio = 100 then 'Fully remote'
end as remote_desc
from remote2
order by company_size, remote_desc
*/

-- Query 3 
-- percentage of jobs by company location and company size for each year
/*
with company_loc as (
		select company_size, company_location, count(*) as count from ds_salaries_bk_up
		group by company_size, company_location)
select Name, company_size, count
from company_loc cl 
join data_csv dc on cl.company_location = dc.Code
order by company_size, count desc
*/

-- Query 4
-- which job title has the most entry level staffs and which one has the most expert level staffs
/*
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
*/

-- Query 5
-- Average salary by remote ratio for each work year
/*
select * from (
select work_year,
 case when remote_ratio = 0 then 'No remote'
	 when remote_ratio = 50 then 'Partially remote'
     when remote_ratio = 100 then 'Fully remote'
end as remote_desc,
round(avg(salary_in_usd)) as avg_salary_usd from ds_salaries_bk_up
group by work_year, remote_ratio) avg_sal
order by work_year, avg_salary_usd desc
*/

-- Query 6
-- Average salary by experience level for each work year
/*
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
*/

