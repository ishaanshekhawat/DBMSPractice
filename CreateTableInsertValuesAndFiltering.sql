-- PG accommodation
-- Assumption : one flat is owned by one owner, one flat can be used by many customers
-- Flats(flatno,bldgname,rooms,ownerid)
-- Customer(cno,cname,address,flatno)
-- Owner(ownerid,oname,mobile)

CREATE TABLE Owner (
    ownerid INT PRIMARY KEY,
    oname VARCHAR(50),
    mobile VARCHAR(15)
);

CREATE TABLE Flats (
    flatno INT PRIMARY KEY,
    bldgname VARCHAR(50),
    rooms INT,
    ownerid INT,
    FOREIGN KEY (ownerid) REFERENCES Owner(ownerid)
);

CREATE TABLE Customer (
    cno INT PRIMARY KEY,
    cname VARCHAR(50),
    address VARCHAR(100),
    flatno INT,
    FOREIGN KEY (flatno) REFERENCES Flats(flatno)
);

INSERT INTO Owner VALUES
(1, 'Ramesh', '9876543210'),
(2, 'Suresh', '9123456780'),
(3, 'Meena', '9988776655');

INSERT INTO Flats VALUES
(101, 'Green Residency', 3, 1),
(102, 'Sky Heights', 2, 2),
(103, 'Palm Grove', 4, 3),
(104, 'Sunshine Villa', 1, 1);  -- Vacant flat

INSERT INTO Customer VALUES
(201, 'Amit', 'Pune', 101),
(202, 'Neha', 'Mumbai', 101),
(203, 'Rohit', 'Nagpur', 102);

INSERT INTO Customer VALUES
(204, 'Priya', 'Delhi', NULL); 

-- List all customers along with flatno and building name

select cname,c.flatno,bldgname
from customer c left outer join flats f
on c.flatno=f.flatno; 

-- List all flats which are vacant
 
select flatno,bldgname
from flats f
where not exists 
(select flatno 
from customer c 
where f.flatno=c.flatno);


-- List the flat details along with owner names

select flatno,bldgname,rooms,o.ownerid,oname,mobile
from flats f left outer join owner o
on
f.ownerid=o.ownerid;


-- Display flat details, owner details and customer details for all customers who has taken pg accommodation

select f.flatno,bldgname,rooms,o.ownerid,oname,mobile,cname,address
from flats f,customer c,owner o
where f.flatno=c.flatno 
and
f.ownerid=o.ownerid;

-- List all customers who has not yet booked pg accommodation

select cname
from customer c
where not exists
(select flatno
from flats f
where f.flatno=c.flatno);

-- Faculty course example

-- Assumption : one faculty can conduct many courses, one course can be assigned to many faculties

-- Faculty (fid, fname,address)
-- Course(cid, cname,duration days)
-- Course-faculty(cid,fid,date of assignment)

CREATE TABLE Faculty (
    fid INT PRIMARY KEY,
    fname VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Course (
    cid INT PRIMARY KEY,
    cname VARCHAR(50),
    duration_days INT
);

CREATE TABLE Course_Faculty (
    cid INT,
    fid INT,
    date_of_assignment DATE,
    FOREIGN KEY (cid) REFERENCES Course(cid),
    FOREIGN KEY (fid) REFERENCES Faculty(fid)
);

INSERT INTO Faculty VALUES
(1, 'Rohit', 'Pune'),
(2, 'Namrata', 'Mumbai'),
(3, 'Amit', 'Delhi'),
(4, 'Sneha', 'Bangalore'),  
(5, 'Karan', 'Hyderabad');

INSERT INTO Course VALUES
(101, 'Java', 45),
(102, 'Python', 30),
(103, 'SQL', 20),
(104, 'Data Science', 60),
(105, 'Cloud Computing', 25); 

INSERT INTO Course_Faculty VALUES
(101, 1, '2025-05-10'),  
(102, 2, '2025-04-15'),  
(103, 1, '2025-03-20'),  
(104, 2, '2025-06-01');  

-- Find all faculties who have course java assigned in may

select fname
from faculty f, course c, course_faculty cf
where f.fid=cf.fid and cf.cid=c.cid and cname = 'Java' and month(date_of_assignment) = 5;

-- List all faculties for whom no course is assigned

select fname
from faculty f
where NOT EXISTS (
select cid
from course_faculty cf
where f.fid=cf.fid
);

-- List all courses for which no faculty is assigned

select cname
from course c
where NOT EXISTS (
select fid
from course_faculty cf
where c.cid=cf.cid
);

-- List all courses, faculty details who stays in either pune or Mumbai

select cname, f.fid, fname
from course c left outer join course_faculty cf on
c.cid = cf.cid
left outer join faculty f on cf.fid=f.fid
where f.address IN ('Pune', 'Mumbai');

-- List all course details, faculty details for courses with duration > 30 days

select c.cid, cname, duration_days, f.fid, fname, address
from course c left outer join course_faculty cf on
c.cid = cf.cid
left outer join faculty f on cf.fid=f.fid
where duration_days > 30;

-- List all faculties for whom no course is assigned also display faculty with courses assigned

select cname, f.fid, fname
from course c left outer join course_faculty cf on
c.cid = cf.cid
right outer join faculty f on cf.fid=f.fid;
