create database HRAnalysis;
use HRanalysis; 
alter table Hremployee
rename to HR_employee;

select * from Hr_employee;

-- 1.Total Employees
select count(*)
from HR_employee;

-- 2.Employees Who Left
select count(*) as employees_left
from HR_employee
where attrition = 'yes';

-- 3.Overall Attrition Rate

select round(100*sum(case when attrition ='yes' then 1 else 0 end)/count(*),2)as Attrition_Rate
from HR_employee;
-- 4.Department Attrition

SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS Employees_Left,
    ROUND(
        100.0 * SUM(CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Attrition_Rate
FROM Hr_employee
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- 5.Overtime Analysis

select overtime ,count(*) as total_employes ,
sum(case  when attrition ='yes' then 1 else 0 end) as employees_left
from Hr_employee
group by overtime;

-- 6.Job Role Analysis
select jobrole ,count(*) as total_employees,
sum(case when attrition = 'yes' then 1 else 0 end) employees_left
from Hr_employee
group by jobrole;

-- 7.Average Salary by Attrition
select attrition, avg(monthlyincome)
from hr_employee
group by attrition;
-- 8.Average Satisfaction by Attrition
select attrition ,avg(jobsatisfaction)
from hr_employee
group by attrition;

-- 9.Employees With No Promotion

select department,count(*) 
from hr_employee
where yearssincelastpromotion =0
group by department;

-- 10.CTE Example

with employees_info as (
select department ,count(*) as total_employees ,
sum(case when attrition = 'yes' then 1 else 0 end) as employees_left
from hr_employee
group by department )

select department ,total_employees,employees_left,
round(employees_left/total_employees*100,2) as attrition_rate
from employees_info;

-- 11. analyse the male and female attrition analysis 
select gender ,count(*),sum(case when attrition = 'yes' then 1 else 0 end) as employees_left
from hr_employee
group by gender;
