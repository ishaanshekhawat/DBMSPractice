-- Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.

select FIRST_NAME WORKER_NAME 
from worker;

-- Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.

select upper(FIRST_NAME)  
from worker;

-- Write an SQL query to fetch unique values of DEPARTMENT from Worker table.

SELECT DISTINCT DEPARTMENT 
FROM worker;

-- Write an SQL query to print the first three characters of FIRST_NAME from Worker table.

SELECT left(FIRST_NAME, 3)
from worker;

-- Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.

select instr(FIRST_NAME, 'a')
from worker
where FIRST_NAME = 'Amitabh';

-- Write an SQL query to print the FIRST_NAME, departmentname from Worker table separated by white space.

select concat(FIRST_NAME,' ' ,department) as table
from worker;

-- Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.

select ltrim(DEPARTMENT)
from worker;

-- Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.

select DISTINCT DEPARTMENT, length(DEPARTMENT)
from worker;

-- Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.

select replace(FIRST_NAME, 'a', 'A')
from worker;

-- Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

select concat(FIRST_NAME,' ',LAST_NAME) COMPLETE_NAME
from worker;

-- Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.

select FIRST_NAME
from worker
order by FIRST_NAME;

-- Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

select FIRST_NAME, DEPARTMENT
from worker
order by DEPARTMENT desc, FIRST_NAME;

-- Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.

select *
from worker
where FIRST_NAME in ('Vipul', 'Satish');

-- Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.

select *
from worker
where FIRST_NAME NOT in ('Vipul', 'Satish');

-- Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

select * 
from worker
where department = 'Admin';

-- Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

select * 
from worker
where FIRST_NAME like '%a%';

-- OR

select * 
from worker
where FIRST_NAME regexp 'a';

-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

select * 
from worker
where FIRST_NAME like '%a';

-- OR

select * 
from worker
where FIRST_NAME regexp 'a$';


-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.

select * 
from worker
where FIRST_NAME like '_____h';

-- OR

select * 
from worker
where FIRST_NAME regexp  '^.....h$'; 

-- Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

select * 
from worker
where salary between 100001 and 499999;

-- Write an SQL query to print details of the Workers who have joined in Feb’2014.

select * 
from worker
where date_format(JOINING_DATE, '%b-%Y') = 'Feb-2014';

-- Write an SQL query to fetch the count of employees working in the department ‘Admin’.

select count(DEPARTMENT) total
from worker
where DEPARTMENT='Admin';

-- Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

select FIRST_NAME
from worker
where SALARY between 50000 and 100000;

-- Write an SQL query to fetch the no. of workers for each department in the descending order.

select DEPARTMENT,count(DEPARTMENT) total
from worker
group by DEPARTMENT
order by DEPARTMENT desc;

-- Write an SQL query to print details of the Workers who are also Managers.

select * 
from worker w, title t 
where worker_id = worker_ref_id and worker_title = 'manager';

-- Write an SQL query to show only odd rows from a table.

select * 
from worker
where worker_id % 2 = 1;

-- Write an SQL query to show only even rows from a table.

select * 
from worker
where worker_id % 2 = 0;


-- Write an SQL query to clone a new table from another table.

create table onemoretable
as select * from bonus;

-- Write an SQL query to fetch intersecting records of two tables.

select worker_ref_id from bonus
intersect
select worker_id from worker;

-- Write an SQL query to show records from one table that another table does not have.

select *
from worker
where worker_id NOT IN (
select worker_ref_id
from bonus);

-- Write an SQL query to show the current date and time.

select now();

-- Write an SQL query to show the top n (say 10) records of a table.

select *
from worker
limit 10;

-- Write an SQL query to determine the nth (say n=5) highest salary from a table. n = (1,2,3.......)

select salary
from (
select *, rank() over (order by salary desc) as HiGNHEST
from worker) as ranked
where ranked.HiGNHEST = n;


-- Write an SQL query to determine the 5th highest salary without using TOP or limit method.

select salary
from (
select *, rank() over (order by salary desc) as HiGNHEST
from worker) as ranked
where ranked.HiGNHEST = 5;   

-- or

select max(salary)
from worker
where salary <
(select max(salary)
from worker
where salary <
(select max(salary)
from worker
where salary <
(select max(salary)
from worker
where salary <
(select max(salary)
from worker
where salary < 
(select max(salary)
from worker
)))));

-- Write an SQL query to fetch the list of employees with the same salary.

SELECT CONCAT(First_name, ' ', Last_name) AS name, salary
FROM worker
WHERE salary IN (
    SELECT salary
    FROM worker
    GROUP BY salary
    HAVING COUNT(*) > 1
);

-- Write an SQL query to show the second highest salary from a table.

select distinct salary
from worker
order by salary desc
limit 1,1;

-- Write an SQL query to show one row twice in results from a table.

select worker_ref_id from bonus
union all
select worker_id from worker;

-- Write an SQL query to fetch intersecting records of two tables.

select worker_ref_id from bonus
intersect
select worker_id from worker;

-- Write an SQL query to fetch the first 50% records from a table.

select *
from worker
where worker_id <= (select (count(*)/2)
from worker
);

-- Write an SQL query to fetch the departments that have less than five people in it.

select department, count(*) as number_of_workers
from worker
group by department
having count(*) < 5;

-- Write an SQL query to show all departments along with the number of people in there.

select department, count(*) as number_of_workers
from worker
group by department;

-- Write an SQL query to show the last record from a table.

select *
from worker
order by worker_id desc
limit 1;

-- Write an SQL query to fetch the first row of a table.

select concat(First_name, ' ', Last_name) name, salary
from worker
limit 1;

-- Write an SQL query to fetch the last five records from a table.

select *
from worker
order by worker_id desc
limit 5;

-- Write an SQL query to print the name of employees having the highest salary in each department.

SELECT department, CONCAT(first_name, ' ', last_name) AS name, salary
FROM worker w
WHERE salary = (
    SELECT MAX(salary)
    FROM worker
    WHERE department = w.department 
);


-- Write an SQL query to fetch three max salaries from a table.

select concat(First_name, ' ', Last_name) name, salary
from worker
order by salary desc
limit 3;

-- Write an SQL query to fetch three min salaries from a table.

select concat(First_name, ' ', Last_name) name, salary
from worker
order by salary
limit 3;

-- Write an SQL query to fetch nth max salaries from a table. n = {1,2,3,4,5....}

select concat(First_name, ' ', Last_name) name, salary
from worker
order by salary desc
limit n-1,1;

-- Write an SQL query to fetch departments along with the total salaries paid for each of them.

select department, sum(salary) total
from worker
group by department;

-- Write an SQL query to fetch the names of workers who earn the highest salary.

select concat(First_name, ' ', Last_name) name , salary
from worker
where salary = (select max(salary) from worker);
