-- creates a new back up table
create table ds_salaries_bk_up
as 
select * from ds_salaries where 1=2;


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