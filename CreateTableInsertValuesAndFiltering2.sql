-- Create a table - 
-- Location(loc_id, lname,address)
-- Server (sid,sname,configuration,lid, adminid)
-- Admin(adminid,username,password,mobile,name)

CREATE TABLE Location (
    loc_id INT PRIMARY KEY,
    lname VARCHAR(50),
    address VARCHAR(100)
);

INSERT INTO Location VALUES
(1, 'Aundh', 'Pune'),
(2, 'Deccan', 'Pune'),
(3, 'M.G. Road', 'Pune'),
(4, 'Baner', 'Pune');

CREATE TABLE Admin (
    adminid INT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50),
    mobile VARCHAR(15),
    name VARCHAR(50)
);

INSERT INTO Admin VALUES
(101, 'rohit123', 'pass1', '9876543210', 'Rohit'),
(102, 'namrata456', 'pass2', '9123456780', 'Namrata'),
(103, 'amit789', 'pass3', '9988776655', 'Amit'),
(104, 'neha321', 'pass4', '9001122334', 'Neha');

CREATE TABLE Server (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    configuration VARCHAR(100),
    lid INT,
    adminid INT,
    FOREIGN KEY (lid) REFERENCES Location(loc_id),
    FOREIGN KEY (adminid) REFERENCES Admin(adminid)
);

INSERT INTO Server VALUES
(201, 'Server_A', 'Intel Xeon, 32GB RAM', 1, 101),
(202, 'Server_B', 'AMD EPYC, 64GB RAM', 2, 101),
(203, 'Server_C', 'Intel i9, 16GB RAM', 3, 102),
(204, 'Server_D', 'ARM Cortex, 8GB RAM', NULL, 102);

-- Display all server-name, location of the server

select sname,address
from server s,location l
where s.lid=l.loc_id;

-- Display all server-name, admin-name, admin mobile

select sname, name, mobile
from server s, admin a
where s.adminid=a.adminid;

-- Display all server which are managed by admin rohit

select sname 
from server s , admin a
where s.adminid=a.adminid
and name = 'Rohit';

-- Display all server and the locations, for which admin is rohit

select sname,address 
from server s , admin a, location l
where s.adminid=a.adminid and s.lid = l.loc_id
and name = 'Rohit';

-- Display all admins, for whom no server is assigned

select name
from admin a
where not exists (select adminid from server s
where a.adminid=s.adminid);

-- Display all servers and admin details, and also display admins for whom no server is assigned

select sid, sname, a.adminid, username, password, mobile, name
from admin a left outer join server s
on s.adminid = a.adminid;

-- display  servers, admins and location of the server

select sname, name, lname
from server s, admins a, location l
where s.adminid=a.adminid
and s.lid=l.loc_id;

-- to display all admins for whom no server is assigned also display locations at which no server is placed

select name, null as lname
from admin a
where not exists (select * from server s1
where a.adminid=s1.adminid)
union
select null as name, lname
from location l
where not exists (select * from server s2
where l.loc_id=s2.lid);

-- display all servers for which no location is assigned

select sname
from server s
where NOT EXISTS
(select *
from location l
where l.loc_id=s.lid);

-- display all servers, for which no location is assigned, whose admin is namrata

select sname
from server s, admin a
where s.adminid=a.adminid
AND
name = 'Namrata'
AND
NOT EXISTS
(select *
from location l
where l.loc_id=s.lid);
