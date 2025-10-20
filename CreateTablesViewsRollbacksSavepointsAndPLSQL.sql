-- create all given tables

CREATE TABLE Vehicle (
    Vid INT PRIMARY KEY,
    Vname VARCHAR(50) NOT NULL,
    Price DECIMAL(12,2) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE Customer (
    Cid INT PRIMARY KEY,
    Cname VARCHAR(50) NOT NULL,
    address VARCHAR(100)
);

CREATE TABLE Salesman (
    Sid INT PRIMARY KEY,
    Sname VARCHAR(50) NOT NULL,
    address VARCHAR(100)
);

CREATE TABLE Cust_Vehicle (
    Custid INT,
    Vid INT,
    Sid INT,
    Buy_price DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (Custid, Vid, Sid),
    FOREIGN KEY (Custid) REFERENCES Customer(Cid),
    FOREIGN KEY (Vid) REFERENCES Vehicle(Vid),
    FOREIGN KEY (Sid) REFERENCES Salesman(Sid)
);

INSERT INTO Vehicle VALUES
(1, 'Activa', 80000, 'Two-wheeler scooter'),
(2, 'Santro', 800000, 'Small family car'),
(3, 'Motor bike', 100000, 'Sports bike'),
(4, 'SUV', 1500000, 'Luxury SUV');

INSERT INTO Customer VALUES
(1, 'Nilima', 'Pimpari'),
(2, 'Ganesh', 'Pune'),
(3, 'Pankaj', 'Mumbai'),
(4, 'Sneha', 'Pune');

INSERT INTO Salesman VALUES
(10, 'Rajesh', 'Mumbai'),
(11, 'Seema', 'Pune'),
(12, 'Rakhi', 'Pune');

INSERT INTO Cust_Vehicle VALUES
(1, 1, 10, 75000),
(1, 2, 10, 790000),
(2, 1, 11, 80000),
(2, 3, 11, 85000),
(3, 2, 12, 800000),
(4, 3, 12, 95000);

-- create index on vehicle table based on price

CREATE INDEX idx_vehicle_price ON Vehicle(price);

-- find all customer name,vehicle name, salesman name, discount earn by all customer

select cname, vname, sname, (Price - Buy_price) as discount
from customer c left join cust_vehicle cv on cv.custid = c.cid left join vehicle v on v.vid = cv.vid left join salesman s on s.sid = cv.sid;

-- find all customer name,vehicle name,salesman name for all salesman who stays in pune

select cname, vname, sname
from salesman s left join cust_vehicle cv on cv.sid = s.sid left join vehicle v on v.vid = cv.vid left join customer c on c.cid = cv.custid
where s.address like '%Pune%';

-- find how many customers bought motor bike

select count(cname) as Number_of_customers
from customer c, cust_vehicle cv, vehicle v
where c.cid = cv.custid and v.vid = cv.vid and vname = 'Motor bike';

-- create a view find_discount which displays output

create view find_discount
as
select cname,vname,price,buy_price,price-buy_price “discount”
from customer c inner join cust_vehicle cv on c.cid=cv.custid inner join vehicle v on
v.vid=cv.vid;

select * from find_discount;

-- find all customer name, vehicle name, salesman name, discount earn by all customer

select cname, vname, sname,discount
from find_discount fd inner join cust_vehicle cv
on fd.buy_price = cv.buy_price inner join salesman s
on cv.sid=s.sid;

-- create view my_hr to display empno,ename,job,comm for all employees who earn commission

create view my_hr 
as 
select empno,ename,job,comm 
from emp
where comm is not null and comm != 0;


-- create view mgr30 to display all employees from department 30

create view mgr30
as 
select * from emp
where deptno = 30;

-- insert 3 employees in view mgr30 check whether insertion is possible

INSERT INTO mgr30 VALUES
(9999, 'Rajesh', 'manager',7698,'1981-09-09',6.00,65.00,30,1000),
(8888, 'Seema', 'Salesman',7698,'1982-09-09',6.00,65.00,30,1000),
(7777, 'Rakhi', 'clerk',7698,'1983-09-09',6.00,65.00,30,1000);

-- insert 3 records in dept and display all records from dept

INSERT INTO dept VALUES
(100, 'Accounting', 'Mumbai'),
(200, 'SALES', 'Pune'),
(300, 'XXXXX', 'yyyy');

select * from dept;

-- use rollback command check what happens

rollback;    -- because of DML statements they are auto commited and saved


-- do the following
-- insert row in emp with empno 100
-- insert row in emp with empno 101
-- insert row in emp with empno 102
-- add savepoint A
-- insert row in emp with empno 103
-- insert row in emp with empno 104
-- insert row in emp with empno 105
-- add savepoint B
-- delete emp with empno 100
-- delete emp with emp no 104
-- rollback upto svaepoint B
-- check what all records will appear in employee table
-- rollback upto A
-- check what all records will appear in employee table
-- commit all changes
-- check what all records will appear in employee table
-- check whether you can roll back the contents.

insert into emp(empno) values(100),(101),(102);

savepoint A;

insert into emp(empno) values(103),(104),(105);

savepoint B;

delete from emp
where empno in (100,104);

ROLLBACK TO SAVEPOINT B;

select * from emp;

ROLLBACK TO SAVEPOINT A;

select * from emp;

commit;

select * from emp;

rollback; -- It didn't rollback because we just used commit before it.

-- create a procedure getMin(deptno,minsal) to find minimum salary of given table.

delimiter //

create procedure getMin(in dno int, out minsal int)
begin
	select min(sal) into minsal
	from emp
	where deptno = dno;
end//

delimiter ;

call getMin(10, @m);

select @m;
