-- To find all managers with salary >1500

select * 
from emp e
where empno = any (
select mgr 
from emp d
where e.empno = d.mgr) 
and sal > 1500;

-- OR

SELECT * 
FROM employee
WHERE JOB = 'MANAGER' AND SAL > 1500;

-- List all employees with sal >1200 and < 2000

select *
from emp
where sal between 1201 and 1999;

-- list all employees with sal is 1600 or sal is 800 or sal is 1900

select *
from emp
where sal in (800,1600,1900);

-- list all employees with R at second last position in name

select *
from emp
where ename like '%r_';

-- or

select *
from emp
where ename regexp 'r.$'

-- List all employees with name starts with A and ends with N

select *
from emp
where ename like 'A%N';

-- or

select *
from emp
where ename regexp '^A.*N$';

-- list all employees with salary > 1250 and dept no=30

select * 
from emp 
where sal > 1250 and deptno = 30;

-- list all employees with salary >=1250 and <= 3000

select * 
from emp
where sal between 1250 and 3000;

-- list all employees with salary >1250 and < 3000

select * 
from emp
where sal between 1251 and 2999;

-- list all employees with salary either equal to 3000 or 1250 or 2500

select * 
from emp
where sal in (1250 , 3000, 2500);

-- list all employee with name=SMITH

select * 
from emp
where ename = "SMITH";

-- list all employees with name starting with S

select * 
from emp
where ename like 's%';

-- or  

select * 
from emp
where ename regexp '^s';

-- list all employees with name ending with S

select * 
from emp
where ename regexp 's$';

-- or

select * 
from emp
where ename like '%s';

-- list all employees with name contains I at 2nd position

select * 
from emp
where ename like '_i%';

-- or 

select * 
from emp
where ename regexp '^.i';

-- list all employees with name starts with A ends with N and somewhere in between L is there

select * 
from emp
where ename like 'A%L%N';

-- or

select * 
from emp
where ename regexp '^A.*L.*N$';

-- list all employees with name starts with A and B at 3 rd position and P at second last 
position

select * 
from emp
where ename regexp '^A..B.*P.$';

-- or 

select * 
from emp
where ename like 'A_B%P_';

-- List all employees with name starts with either A or starts with S or starts with W

select * 
from emp
where ename regexp '^A|^S|^W';

-- or 

select * 
from emp
where ename like 'A%' or ename like 'S%' or ename like 'W%';

-- find max sal and min sal for each job

select job, max(sal), min(sal) 
from emp
group by job;

-- find how many employess have not received commission

select * 
from emp
where comm is null or comm =0;

-- find sum of sal of all employees working in dept no 10

select deptno,sum(sal) total_sal 
from emp
where deptno = 10
group by deptno; 

-- find maximum salary,average sal for each job in every department

select deptno, job, max(sal) as Max_salary, avg(sal) as AVG_salary
from emp
group by deptno, job;

-- find max salary for every department if deptno is > 15  and arrange data in deptno order.

select deptno, max(sal)
from emp
where deptno > 15
group by deptno
order by deptno;

-- find sum salary for every department if sum is > 3000

select deptno,sum(sal) total 
from emp
group by deptno
having total > 3000;

-- list all department which has minimum 5 employees

select deptno, count(empno) no_of_emp
from emp
group by deptno 
having no_of_emp >= 5;

-- count how many employees earn salary more than 2000 in each job

select job, count(empno) numberofemp
from emp
where sal > 2000
group by job;

-- list all enames and jobs in small case letter

select lower(ename) name , lower(job) job
from emp;

-- list all names and jobs so that the length of name should be 15 if it is smaller then add spaces to left

select ename, job ,lpad(concat(ename,job),15,' ') newname
from emp;

-- display min sal,max sal, average sal for all employees working under same manager

select mgr,min(sal) minimum_sal,max(sal) maximum_sal,avg(sal) average_sal
from emp
group by mgr; 

-- find sum of total earnings(sal+comm), average of sal+comm, for all employees who earn sal > 2000 and work in either dept no  10 or 20

select sum(sal+ifnull(comm, 0)) total_earnings, avg(sal+ifnull(comm, 0)) avg_earnings
from emp
where sal > 2000 and deptno in (10,20);

-- list all employees who joined in Aug 1980 and salary is >1500  and < 2500

select *
from emp
where hiredate regexp '1980-08-[0-9][0-9]' and sal between 1501 and 2499;

-- or

select *
from emp
where hiredate like '1980-08-__' and sal between 1501 and 2499;

-- list all employees joined in either aug or may or dec

select *
from emp
where month(hiredate) in (8,5,12);

-- display name and hiredate in dd/mm/yy format for all employees whose job is clerk and they earn some commission

select ename, date_format(hiredate, '%d/%m/%y') as date, comm
from emp
where job = 'clerk' and comm is not null or comm != 0;

-- list empcode,empno,name and job for each employee. (note :empcode is 3 to 5 characters from name and last 2 characters of job)

select concat((substr(ename, 3, 5)), right(job,2)) as empcode, empno, ename, job
from emp;

-- display thousand separator and $ symbol for commission if it is null then display it as 0 for all employees whose name starts with A and ends with N

select ename, sal, concat('$',format(ifnull(comm,0),2)) as new_comm
from emp
where ename like 'A%N';


-- Display empid,name,sal,comm,remark Remark should base on following conditions: comm >= 600 "excellent Keep it up", if it < 600 or not null "good", otherwise "Need improvement"

select empno, ename, sal, comm, 
case 
when comm>=600 then 'excellent. Keep it up'
when comm<600 or comm is not null then 'good'
else 'need improvement'
end
remark
from emp;

-- Display empid, name, deptno and department name by using following conditions.
-- dept 10 then "Hr"
-- if 20 then "Admin"
-- if 30 then "accounts"
-- otherwise purchase

select empno, ename, deptno, 
case 
when deptno=10 then 'HR'
when deptno=20 then 'Admin'
when deptno=30 then 'Accounts'
else 'Purchase'
end
deptname
from emp;

-- Creating following tables

-- MySQL syntax:
create table mydept_DBDA
	(
	deptid int primary key,
	dname varchar(20) not null unique,
	dloc varchar(20)
	)
-- Oracle syntax:
	create table mydept_DBDA
	(
	deptid number primary key,
	dname varchar2(20) not null unique,
	dloc varchar2(20)
	)
	insert into mydept_DBDA values(30,'Purchase','Mumbai');
-- MySql syntax:
	create table myemployee
	(
	empno int primary key,
	fname varchar(15) not null,
	mname varchar(15),
	lname varchar(15) not null,
	sal float(9,2) check(sal >=1000),
	doj date,
	passportnum varchar(15) unique,
	deptno int,
	constraint fk_deptno foreign key(deptno) references mydept_DBDA(deptid) on 
	delete set null
	on update cascade
	)
-- Oracle syntax:
	create table myemployee
	(
	empno number(5) primary key,
	fname varchar2(15) not null,
	mname varchar2(15),
	lname varchar2(15) not null,
	sal number(9,2) check(sal >=1000),
	doj date default sysdate,
	passportnum varchar2(15) unique,
	deptno number constraint fk_deptno references mydept_DBDA(deptid) on delete 
	cascade
	)

-- Create following tables Student, Course

create table student(
sid int primary key not null,
sname varchar(30));

insert into student values
(1,'a'),
(2,'b');

create table course(
cid int primary key not null,
cname varchar(20));

insert into course values
(1,'c1'),
(2,'c2'),
(3,'c3');

create table marks(
studid int,
courseid int,
marks int,
constraint pk primary key(studid,courseid),
constraint fk_sid foreign key (studid) references student(sid) on delete cascade,
constraint fk_cid foreign key (courseid) references course(cid)
);

INSERT INTO marks VALUES
(1,1,99),
(1,3,98),
(2,1,95),
(2,2,97);

-- Create empty table emp10 with table structure same as emp table.

create table emp10 as
(
select *
from emp
where 1=2;
)

-- Solve following using alter table

alter table emp
add primary key (empno);

alter table dept
add primary key (deptno);

alter table salgrade
add primary key (grade);

alter table emp
add constraint fk_dept foreign key(deptno) references dept(deptno);

alter table emp
add netsal int default 1000;

-- Update employee sal ---- increase sal of each employee by 15 % sal +comm, change the job to manager and mgr to 7777 for all employees in deptno 10.

UPDATE test
SET sal = sal + (sal * 0.15) + IFNULL(comm, 0),
job = 'MANAGER',
mgr = 7777
WHERE deptno = 10;

-- change job of smith to senior clerk 

update emp
set job='Sr Clerk'
where ename='SMITH';

-- increase salary of all employees by 15% if they are earning some commission

update emp
set sal=1.15*sal
where comm is not null or comm != 0;

-- list all employees with sal>smith's sal

select *
from emp
where sal > 
(select sal
from emp
where ename = 'SMITH');

-- list all employees who are working in smith's department

select *
from emp
where deptno = 
(select deptno
from emp
where ename='smith');

-- list all employees with sal < rajan's sal and salary > revati's sal

select * 
from emp
where sal >
(select sal
from emp
where ename='revati')
AND
sal <
(select sal
from emp
where ename='rajan');

-- delete all employees working in alan's department
 
delete from emp
where deptno = (
select e.ename from (select * from emp) e
where ename = 'allen');

-- change salary of Alan to the salary of Miller.

update emp
set sal=(
select sal
from emp
where ename = 'Miller')
where ename='Alan';

-- change salary of all emplees who working in Wall's department to the salary of Miller.

update emp
set sal=(
select sal
from emp
where ename = 'Miller')
where deptno=(
select deptno
from emp
where ename = 'Wall'
);

-- list all employees with salary > either Smith's salary or alan's sal

select *
from emp
where sal > any (
select sal
from emp
where ename in ('smith','alan')
);

-- list all employees who earn more than average sal of dept 10

select *
from emp
where sal > (
select avg(sal)
from emp
where deptno = 10
);

-- list all employees who earn more than average sal of Alan's department

select *
from emp
where sal > (
select avg(sal)
from emp
where deptno = (
select deptno
from emp
where ename = 'Alan'
)
);

-- list all employees who are working in purchase department

select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno and dname = 'purchase';

-- list all employees who earn more than average salary of their own department

select *
from emp e
where sal > (
select avg(sal)
from emp d
where d.deptno=e.deptno
);

-- list all employees who earn sal < than their managers salary

select *
from emp e
where sal < (
select sal
from emp d
where e.mgr = d.empno
);

-- list all employees who are earning more than average salary of their job

select *
from emp e
where sal > (
select avg(sal)
from emp d
where e.job = d.job
);

-- display employee name and department

select ename, e.deptno , dname
from emp e, dept d
where e.deptno = d.deptno;

-- display empno,name,department name and grade (use emp,dept and salgrade table)

select empno,ename,dname,grade
from emp e,dept d,salgrade s
where e.deptno=d.deptno and sal between losal and hisal;

-- list all employees number,name, mgrno and manager name

select d.empno, d.ename,d.mgr,e.ename manager_name
from emp e,emp d
where e.empno=d.mgr;

---------------------------------------------------------------------

-- create following tables and solve following questions

create table product
(pid int primary key not null,
pname varchar(20),
price int,
qty int,
cid int not null,sid int not null);

 create table salesman
 (sid int primary key not null,
  sname varchar(20),
  address varchar(51));

create table category(
cid int primary key not null, 
cname varchar(20), 
description varchar(121)
);


INSERT INTO category (cid, cname, description) VALUES
(201, 'Electronics', 'Devices and gadgets'),
(202, 'Furniture', 'Home and office furniture'),
(203, 'Books', 'Educational and leisure reading');

INSERT INTO salesman (sid, sname, address) VALUES
(101, 'Amit Sharma', 'pune'),
(102, 'Priya Mehta', 'Mumbai'),
(103, 'Rahul Verma', 'pune');

INSERT INTO product (pid, pname, price, qty, cid, sid) VALUES
(301, 'Laptop', 55000, 10, 201, 101),
(302, 'Office Chair', 4500, 25, 202, 102),
(303, 'Smartphone', 22000, 15, 201, 103),
(304, 'Bookshelf', 3200, 5, 202, 101),
(305, 'Novel - Fiction', 350, 50, 203, 102);


-- list all product name,their category name and name of a person, who sold that product

select pname,cname,sname
from category c,salesman s,product p
where c.cid=p.cid and s.sid=p.sid;

-- list all product name and salesman name for all salesman who stays in pune

select pname,sname
from product p, salesman s
where s.sid = p.sid and address = "pune";

-- list all product name and category name

select pname,cname
from product p,category c
where p.cid=c.cid ;


--------------------------------------------------------------------------------------------------


-- create following tables and solve following questions

create table faculty
(fid int primary key not null,
fname varchar(20),
skill1 varchar(20),
kill2 varchar(20));

create table courses
(cid int primary key not null,
cname varchar(20),
rid int not null,fid int not null
);

create table room
(roomid int primary key not null,
rname varchar(20),
rloc varchar(20)
);

-- list all courses for which no room is assigned and all rooms for which are available

SELECT cid AS course_id, cname, NULL AS room_id, NULL as rname
FROM courses
WHERE rid IS NULL
UNION
SELECT NULL AS course_id, NULL as cname,roomid AS room_id, rname
FROM room
WHERE roomid NOT IN (SELECT rid FROM courses WHERE rid IS NOT NULL);

-- list all faculties who are not allocated to any course and rooms which are not allocated to any course

SELECT f.fid, fname, null, null
FROM faculty f
WHERE f.fid NOT IN (
    SELECT c1.fid
    FROM courses c1
    WHERE c1.fid IS NOT NULL
)
UNION
SELECT null, null, roomid, rname
FROM room
WHERE roomid NOT IN (
    SELECT c2.rid
    FROM courses c2
    WHERE c2.rid IS NOT NULL
);

-- list all rooms which are allocated or not allocated to any courses

select roomid
from room;

-- list all rooms which are not allocated to any courses

select roomid, rname
from room
where roomid NOT IN(
SELECT rid
from courses
WHERE rid IS NOT NULL);

-- display courses and faculty assigned to those courses whose special skill is database

select f.fid, fname, cname
from faculty f inner join courses c
on f.fid = c.fid
where skill1 = 'database' or skill2 = 'database';

-- display time table --- it should contain course details , faculty and room details

select cid, cname, roomid, rname, rloc, f.fid, fname
from courses c, room r, faculty f
where c.rid = r.roomid and c.fid = f.fid;

--or

select cid, cname, roomid, rname, rloc, c.fid, fname
from (courses c 
inner join faculty f 
on
c.fid = f.fid) 
inner join room r 
on 
c.rid=r.roomid;

-- create following tables with given constraints

CREATE TABLE product (
    prodid INT PRIMARY KEY,
    pname VARCHAR(100) NOT NULL UNIQUE,
    qty INT CHECK (qty > 0) DEFAULT 20,
    price DECIMAL(6,2),
    catid INT,
    sid INT
);

CREATE TABLE salesman (
    sid INT PRIMARY KEY,
    sname VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

CREATE TABLE category (
    cid INT PRIMARY KEY,
    cname VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

INSERT INTO product VALUES
(123, 'lays', 30, 30.00, 1, 12),
(111, 'pepsi', 40, 50.00, 4, 11),
(134, 'nachos', 50, 50.00, 1, 12),
(124, 'dairy milk', 40, 60.00, 2, 14),
(125, 'pringles', 40, 60.00, 1, 14);

INSERT INTO salesman VALUES
(11, 'Rahul', 'Pune'),
(12, 'Kirti', 'Mumbai'),
(13, 'Prasad', 'Nashik'),
(14, 'Arnav', 'Amaravati');

INSERT INTO category VALUES
(1, 'chips', 'very crunchy'),
(2, 'chocolate', 'very chocolaty'),
(3, 'snacks', 'yummy'),
(4, 'cold drinks', 'thanda thanda cool cool');

-- List all products with category chips

select * from category
where cname = 'chips';

-- Display all products sold by kirti

select prodid,pname 
from product p , category c
where p.catid = c.cid and c.cid = 1;

-- Display all salesman who do not sold any product

select s.sid, sname
from salesman s
where s.sid not in 
(select sid
from product p
where s.sid = p.sid);

-- Display all category for which no product is there

select cid,cname 
from category c
where c.cid not in
(select catid
from product p
where c.cid = p.catid);

-- display all products with no category assigned
Sol:

select *
from product
where catid IS NULL;

-- list all salesman who stays in city with name starts with P or N

select * from salesman
where city like 'P%'
or city like "N%";

-- or

select * from salesman
where city regexp '^P|^N';

-- add new column in salesman table by name credit limit

alter table salesman
add Credit_limit int;

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
from worker w , title t 
where worker_id = worker_ref_id and worker_title = 'manager';

-- Write an SQL query to fetch duplicate records having matching data in some fields of a table.

-- checking for duplicate name here ->

select ename, count(ename) duplicate_count
from emp
group by ename
having count(ename) > 1;

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
