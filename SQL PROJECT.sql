create database maste_tabler;
show databases;
select * from hr_2;
select count("employee ID") from hr_2;

-- Average Attrition Rate for all Departments


alter table hr_1 add column Attrition_count int;
select * from hr_1;
set sql_safe_updates=0;
update hr_1 set Attrition_count=case Attrition
when "Yes" then 1
else 0
end ;
select round(sum(Attrition_count)*100/count(EmployeeNumber),1) as Attrition_Rate,Department from hr_1 group by Department;

-- Average Hourly rate of Male Research Scientist
 
select avg(hourlyrate) from hr_1 join hr_2 on hr_1.employeenumber=hr_2.`Employee ID` where Gender="Male" and JobRole="Research Scientist";


-- attrition rate vs monthly income stats


alter table hr_2 add column monthly_stats varchar(40);
update hr_2 set monthly_stats = case 
when MonthlyIncome>=50000 then "High Salary"
when Monthlyincome>=25000 and Monthlyincome<500000 then "Medium Salary"
else "low Salary"
end;
select * from hr_2;
select concat(round(sum(Attrition_count)*100/count(EmployeeNumber),2),"%") as Attrition_rate,jobrole,monthly_stats from hr_1 join hr_2 on hr_1.EmployeeNumber=hr_2.`Employee ID` group by JobRole,monthly_stats;

-- average working years for each department


select Department,round(avg(totalworkingyears),2) as "Avg Working years" from hr_1 join hr_2 on hr_1.EmployeeNumber=hr_2.`Employee ID` group by department;

-- job role vs work life balce

alter table hr_2 add column life_stats varchar(40);
update hr_2 set life_stats =case
when worklifebalance>=4 then "Good"
when  worklifebalance>=2 and worklifebalance<4 then "Average"
else "bad"
end;
select jobrole,life_stats,avg(WorkLifeBalance) as Avg_work_life_bal from hr_1 join hr_2 on hr_1.EmployeeNumber=hr_2.`Employee ID` group by life_stats,jobrole order by jobrole;


-- Attrition rate Vs Year since last promotion relation


select yearssincelastpromotion, sum(Attrition_count) from hr_1 join hr_2 on hr_1.EmployeeNumber=hr_2.`Employee ID` group by YearsSinceLastPromotion 
order by YearsSinceLastPromotion;


