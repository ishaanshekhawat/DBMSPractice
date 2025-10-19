-- To list all records with sal > 2000 and comm>200

select * 
from emp 
where sal > 2000 and comm > 200;

-- To list all record with job=’Clerk’ or sal>2000

select * 
from emp
where job = 'Clerk' or sal>2000;

-- To list all the record with sal=1250 or 1100 or 2850

select * 
from emp
where sal in (1250, 1100, 2850);

-- To list all employees with sal>1250 and <2850

select ename 
from emp
where sal between 1251 and 2849;

-- To list all employees with name ends with AS

select ename 
from emp 
where ename like '%AS';

-- To list all employees with job starts with C and ends with K

select * 
from emp
where job like 'c%k';

-- To list all emploees with job contains L at third position and M at third last position

select * 
from emp
where job like '__l%m__';

-- To list all the record with sal not equal to 1250 or 1100 or 2850

select * 
from emp
where sal not in (1250, 1100, 2850);

-- To list all employees with salnot >1250 and <2850

select * 
from emp
where sal not between 1251 and 2849;

-- To list all employees with job starts with C , E at 3rd position and ends with K

select * 
from emp
where job like 'C_E%K';

-- To list all rows with comm is null

select * 
from emp
where comm is NULL;

-- To list all employees with sal is null and name starts with ‘S’

select * 
from emp
where sal IS NULL and ename like 'S%';

-- To list all employees with job contains 5 characters

select * 
form emp
where job like '_____';

-- To list all employees with name contain ‘A’ at 1 position and job Contains 5 characters

select * 
from emp
where ename like 'A%' and job like '_____';

-- Retrieve the details (Name, Salary and dept no) of the emp who are working in department code 20, 30 and 40.

select ename name, sal salary, deptno 'dept no'
from emp
where deptno in (20,30,40);

-- Display the total salary of all employees . Total salary will be calculated as sal+comm+sal*0.10

select *, sal+ifnull(comm,0)+sal*0.1 as totalSal 
from emp;

-- List the Name and job of the emp who have joined before 1 jan 1986 and whose salary range is between 1200and 2500. Display the columns with user defined Column headers.

select ename as NAME, job as EMPJOB 
from emp
where hiredate < '1986-01-01' and
sal between 1201 and 2499;

-- List the empno, name, and department number of the emp works under manager with id 7698

select empno, ename, deptno, mgr
from emp
where mgr=7698;

-- List the name, job, and salary of the emp who are working in departments 10 and 30.

select ename, job, sal 
from emp
where deptno in (10,30);

-- Display name concatenated with dept code separated by comma and space. Name the column as ‘Emp info’.

select concat(ename, ', ',deptno) 'Emp info'
from emp;

-- Display the emp details who do not have manager.

select * 
from emp
where mgr is NULL;

-- Write a query which will display name, department no and date of joining of all employee who were joined January 1, 1981 and March 31, 1983. Sort it based on date of joining (ascending).

select ename, deptno, hiredate date_of_joining
from emp
where hiredate in ('1981-01-01','1983-03-31')
order by date_of_joining;

-- Display the employee details where the job contains word ‘AGE’ anywhere in the Job

select * 
from emp
where job like '%AGE%'; 

-- List the details of the employee, whose names start with ‘A’ and end with ‘S’ or whose names contain N as the second or third character, and ending with either ‘N’ or ‘S’.

select *
from emp
where ename REGEXP '^A.*S$|^..?N.*[NS]$'

-- List the names of the emp having ‘_’ character in their name.

select * 
from emp
where ename regexp "^.*_.*$";


-- Single Row Functions
-- To list all employees and their email, to generate email use 2 to 5 characters from ename. Concat it with 2 to 4 characters in job and then concat it with ‘@mycompany.com’

select ename, concat(lower(substr(ename,2,4)),lower(substr(job,2,3)),'@mycompany.com') email
from emp;

-- List all employees who joined in September.

select * 
from emp
where month(hiredate) = 9;
  
-- List the empno, name, and department number of the emp who have experience of 18 or more years and sort them based on their experience.

select empno, ename, deptno, timestampdiff(YEAR,hiredate,curdate()) EXP
from emp
having EXP >= 18
order by EXP;

-- Display the employee details who joined on 3rd of any month or any year

select *
from emp
where day(hiredate) = '3';

-- Display all employees who joined between years 1981 to 1983.

select * from emp
where year(hiredate) between '1981' and '1983';

-- Group functions

-- Display the Highest, Lowest, Total & Average salary of all employee. Label the columns Maximum, Minimum, Total and Average respectively for each Department. Also round the result to the nearest whole number.

select deptno, ROUND(MAX(sal)) as MAXIMUM ,round(MIN(sal)) as MINIMUM,round(SUM(sal)) as TOTAL,round(AVG(sal)) as AVERAGE
from emp
group by deptno;

-- Display Department no and number of managers working in that department. Label the column as ‘Total Number of Managers’ for each department.

select deptno, COUNT(mgr) as NUMBER_OF_MANAGERS
from emp
group by deptno;

-- Get the Department number, and sum of Salary of all non managers where the sum is greater than 20000.

select deptno, sum(sal) total
from emp
where mgr IS NULL
Group by deptno
having total > 20000;
