-- num of jobs by company location and size for each year
with company_loc as (
		select company_size, company_location, count(*) as count from ds_salaries_bk_up
		group by company_size, company_location)
select Name, company_size, count
from company_loc cl 
join data_csv dc on cl.company_location = dc.Code
order by company_size, count desc