-- Write a query to display the first day of the month (in datetime format) three months before the current month. Sample current date : 2014-09-03 Expected result : 2014-06-01

SELECT DATE_FORMAT(DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH), '%Y-%m-01') AS first_day;

-- Write a query to display the last day of the month (in datetime format) three months before the current month.

select last_day(date_sub('2014-09-03',interval 3 month)) as asked_date;

-- Write a query to get the distinct Mondays from hiredate in emp tables.

select distinct hiredate, dayname(hiredate)
from emp
where dayname(hiredate) = "Monday";

-- Write a query to get the first day of the current year.

select dayname(DATE_FORMAT(CURDATE(), '%Y-01-01')) AS first_day_of_year;

-- Write a query to get the last day of the current year.

select dayname(date_format(curdate(), '%Y-12-31')) as last_day;

-- Write a query to calculate your age in year.

select timestampdiff(YEAR,'2003-03-25',curdate()) as AGE;

-- Write a query to get the current date in the following format. Sample date : 04-sep-2014 Output : September 4, 2014

select date_format(curdate(),'%M %d, %Y') AS GOOD_FORMAT;

-- Write a query to get the current date in Thursday September 2014 format. Thursday September 2014

select date_format(curdate(),'%W %M %Y') as OK_FORMAT; 

-- Write a query to extract the year from the current date.

select year(curdate()) as YEAR;

-- Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30'

select ename, hiredate 
from emp 
where hiredate between '1987-06-01' and '1987-07-30'; 

-- Write a query to display the current date in the following format. Sample output: Thursday 4th September 2014 00:00:00

select date_format(curdate(), '%W %D %M %Y %H:%i:%S') as New_format;

-- Write a query to display the current date in the following format. Sample output: 05/09/2014

select date_format(curdate(), '%d/%m/%Y') as Newer Format;

-- Write a query to display the current date in the following format. Sample output: 12:00 AM Sep 5, 2014

select date_format(curdate(), '%I:%i %p %b %d, %Y') as Newest_format;

-- Write a query to get the employees who joined in the month of June.

select *
from emp
where month(hiredate) = 6;

-- Write a query to get the years in which more than 10 employees joined.

select year(hiredate) YEAR, count(*) num
from emp
group by YEAR
having count(*) > 10;

-- Write a query to get first name of employees who joined in 1987.

select ename
from emp
where year(hiredate) = 1987;

-- Write a query to get employees whose experience is more than 5 years.

select ename, timestampdiff(YEAR, hiredate, curdate()) as Exp
from emp
where timestampdiff(YEAR, hiredate, curdate()) > 5;

-- Write a query to get employee ID, last name, and date of first salary of the employees.

select empno, ename, date_format(date_add(hiredate, interval 1 month), '%Y-%m-01') as first_salary_day
from emp;

-- Write a query to get first name, hire date and experience of the employees. Sample table: employees

select empno, ename, timestampdiff(YEAR, hiredate, curdate()) as Exp
from emp;

-- Write a query to get the department ID, year, and number of employees joined.

select year(hiredate) as year, deptno, count(*) num_of_emp
from emp
group by year, deptno
order by year, deptno;
