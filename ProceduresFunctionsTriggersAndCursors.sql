-- write a procedure to insert record into employee table. the procedure should accept empno, ename, sal, job, hiredate as input parameter. write insert statement inside procedure insert_rec to add one record into table

create procedure insert_rec(pno int , pnm varchar(20), psal int, pjob varchar(20), phd date)
begin
insert into emp(empno,ename,sal,job,hiredate) values (pno, pnm, psal, pjob, phd);
end//

-- write a procedure to delete record from employee table. the procedure should accept empno as input parameter. write delete statement inside procedure delete_emp to delete one record from emp table

create procedure delete_emp(pempno int)
begin
	delete from emp where empno = pempno;
end//

-- write a procedure to display empno,ename,deptno,dname for all employees with sal > given salary. pass salary as a parameter to procedure

create procedure p1_1(in psal int)
begin
	declare vempno, vdeptno, vsal, v int default 0;
	declare vename,vdname varchar(20);
	declare empcur cursor for select empno, ename, sal, e.deptno, dname 
		from emp e, dept d
		where d.deptno = e.deptno and sal > psal;
	declare continue handler for NOT FOUND set v = 1;
	open empcur;
	label1:loop
		fetch empcur into vempno, vename, vsal, vdeptno, vdname;
		if v=1 then
			leave label1;
		end if;
		select vempno, vename, vsal, vdeptno, vdname;
	end loop;
	close empcur;
end//

-- write a procedure to find min,max,avg of salary and number of employees in the given deptno.
-- deptno --→ in parameter
-- min,max,avg and count ---→ out type parameter
-- execute procedure and then display values min,max,avg and count

create procedure p2(in dno int, out cnt int,out minsal int,maxsal int, avgsal float(9,2))
begin
select count(*), min(sal),max(sal),avg(sal) into cnt,minsal,maxsal,avgsal
from emp
where deptno=dno;
select minsal,maxsal,cnt,avgsal;
end//

call p2(10, @cnt, @minsal, @maxsal, @avgsal);

-- write a procedure to display all pid,pname,cid,cname and salesman name(use product,category and salesman table)

create procedure p3_1()
begin
	select pid, pname, c.cid, cname, sname
	from product p, category c, salesman s
	where p.cid = c.cid and p.sid = s.sid;
end//

-- write a procedure to display all vehicles bought by a customer. pass cutome name as
a parameter.(use vehicle,salesman,custome and relation table)

create procedure p44(in pcname varchar(20))
begin
select cname, vname, sname,buy_price
from vehicle v left join cust_vehicle cv
on v.vid=cv.vid
left join customer c
on c.cid=cv.custid left join salesman s
on s.sid=cv.sid 
where cname=pcname;
end //

-- Write a procedure that displays the following information of all emp
-- Empno,Name,job,Salary,Status,deptno
-- Note: - Status will be (Greater, Lesser or Equal) respective to average salary of their own
-- department. Display an error message Emp table is empty if there is no matching
-- record.

create procedure p7_3()
begin
	if (select count(*) from emp) = 0
	then
		select 'emp table is empty' as ErrorMessage;
	else
		select e.empno, e.ename, e.job, e.sal,
		case
		when e.sal > d.avg_sal then 'greater'
		when e.sal < d.avg_sal then 'lesser'
		else 'equal'
		end as status,
		e.deptno
		from emp e
		join (
		select deptno, avg(sal) as avg_sal 
		from emp
		group by deptno
		) d on
		d.deptno = e.deptno;
	end if;
	end//

-- Write a procedure to update salary in emp table based on following rules.
-- Exp <= 35 then no Update
-- Exp> 35 and <=38 then 20% of salary
-- Exp> 38 then 25% of salary

CREATE PROCEDURE p703_1()
BEGIN
UPDATE emp
SET sal = CASE
WHEN TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 38 THEN sal * 1.25
WHEN TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 35 THEN sal * 1.20
ELSE sal
END;
select * from emp;
END //

-- Write a function to calculate number of years of experience of employee.(note:
-- pass hiredate as a parameter)

create function f1(hiredate date)
returns int
begin
	declare exp int;
	set exp = timestampdiff(YEAR, hiredate, CURDATE());
	return exp;
end//

-- Write a function to compute the following. Function should take sal and hiredate as i/p and return the cost to company.
-- DA = 15% Salary, HRA= 20% of Salary, TA= 8% of Salary.
-- Special Allowance will be decided based on the service in the company.
-- < 1 Year Nil
-- >=1 Year< 2 Year 10% of Salary
-- >=2 Year< 4 Year 20% of Salary
-- >4 Year 30% of Salary

create function f2(sal int, hiredate date)
returns int
begin
	declare cc int;
	set cc = 
	case 
	when timestampdiff(YEAR, hiredate, CURDATE()) < 1 then 1.43*sal
	when timestampdiff(YEAR, hiredate, CURDATE()) >=1 and timestampdiff(YEAR, hiredate, CURDATE()) < 2 then 1.53*sal
	when timestampdiff(YEAR, hiredate, CURDATE()) >=2 and timestampdiff(YEAR, hiredate, CURDATE()) < 4 then 1.63*sal
	else 1.73*sal
	end;
	return cc;
end//

-- Write query to display empno,ename,sal,cost to company for all employees(note: use function written in question 10)

create procedure p705()
begin
select empno, ename, sal, 
case 
when timestampdiff(YEAR, hiredate, CURDATE()) < 1 then 1.43*sal
when timestampdiff(YEAR, hiredate, CURDATE()) >=1 and timestampdiff(YEAR, hiredate, CURDATE()) < 2 then 1.53*sal
when timestampdiff(YEAR, hiredate, CURDATE()) >=2 and timestampdiff(YEAR, hiredate, CURDATE()) < 4 then 1.63*sal
else 1.73*sal
end as CC
from emp;
end//

-- Write trigger
-- 1. Write a tigger to store the old salary details in Emp _Back (Emp _Back has the same structure as emp table without any constraint) table.

create table emp_back(
empno int,
ename varchar(20),
oldsal decimal(9,2),
newsal decimal(9,2)
);

create trigger updateempsal after update on emp
for each row
insert into emp_back values(new.empno, new.ename, old.sal, new.sal);
