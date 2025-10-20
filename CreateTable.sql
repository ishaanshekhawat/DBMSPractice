-- Following are the tables (database: practice6):
-- BRANCH (BID INTEGER, BRNAME CHAR (30), BRCITY CHAR (10))

create table branch(
bid int primary key not null,
brname varchar(30) not null,
brcity varchar(10) not null
);

-- CUSTOMER (CNO INTEGER, CNAME CHAR (20), CADDR CHAR (35), CITY CHAR(20))

create table customer(
cno int primary key not null,
cname varchar(20) not null,
caddr varchar(35),
city varchar(20)
);

-- LOAN_APPLICATION (LNO INTEGER, LAMTREQUIRED MONEY, LAMTAPPROVED MONEY, L_DATE DATE)

create table loan_application(
lno int primary key not null,
lamtrequired DECIMAL(10,2),
lamtapproved DECIMAL(10,2),
l_date date
);

-- The relationship is as follows:
-- BRANCH, CUSTOMER, LOAN_APPLICATION are related with ternary relationship.
-- TERNARY (BID INTEGER, CNO INTEGER, LNO INTEGER).

create table relationship
(bid int,
cno int,
lno int,
primary key (bid,cno,lno),
constraint fk_bid foreign key(bid) references branch(bid)
on delete cascade
on update cascade,
constraint fk_cno foreign key(cno) references customer(cno)
on delete cascade
on update cascade,
constraint fk_lno foreign key(lno) references loan_application(lno)
on delete cascade
on update cascade
);

-- Solve the Queries

-- Find the names of the customers for the “Aundh” branch.

select cname 
from branch b, customer c, relationship r
where b.bid = r.bid and c.cno = r.cno and b.brname = 'Aundh';

-- List the names of the customers who have received loan less than their requirement.

select cname
from loan_application l, customer c, relationship r
where l.lno = r.lno and c.cno = r.cno and lamtapproved < lamtrequired;

-- Find the maximum loan amount approved.

select max(lamtapproved) as MAX_loan_approved
from loan_application;

-- Find out the total loan amount sanctioned by "Deccan" branch.

select sum(lamtapproved) as Deccan_amt_sanctioned
from branch b, relationship r, loan_application l 
where b.bid = r.bid and l.lno= r.lno and brname = 'Deccan';

-- Count the number of loan applications received by “M.G.ROAD” branch.

select count(*) as MG_Road_applications
from branch b, relationship r, loan_application l 
where b.bid = r.bid and l.lno= r.lno and brname = 'M.G. Road';

-- List the names of the customer along with the branch names who have applied for loan in the month of September.

select cname,brname
from branch b, customer c, relationship r, loan_application l 
where b.bid = r.bid and l.lno= r.lno and c.cno = r.cno and month(l_date)=9;
