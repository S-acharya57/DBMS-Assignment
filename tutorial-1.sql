create database employee_Database;
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Q. NO. 1 Solution



create table tbl_Employee
(
	employee_name varchar(50) primary key,
    street varchar(60),
    city varchar(50)
);

create table tbl_Works
(
	employee_name varchar(50),
    company_name varchar(50),
    salary int
);

create table tbl_Company
(
	company_name varchar(50) primary key,
    city varchar(50)
);

create table tbl_Managers
(
	employee_name varchar(50),
    manager_name varchar(50)
);

alter table tbl_Works 
add foreign key (employee_name) references tbl_Employee(employee_name);

alter table tbl_Works
add foreign key (company_name) references tbl_Company(company_name);

alter table tbl_Managers
add foreign key (employee_name) references tbl_Employee(employee_name);



insert into tbl_Employee (employee_name, street, city) values
('Alex', 'Downtown-2', 'NYC'),
('Johnson', 'Precinct', 'Baltimore'),
('Carlson', 'Vegas', 'Vegas City'),
('Popeye', 'CN', 'LA');

insert into tbl_Company (company_name, city) values
('Specter', 'Manhattan'),
('Hardman', 'Philadelphia'),
('Pearson', 'Charlotte'),
('Jane', 'California City');

insert into tbl_Works (employee_name, company_name, salary) values
('Alex', 'Specter', 60000),
('Johnson', 'Hardman', 120000),
('Carlson', 'Jane', 86000),
('Popeye', 'Hardman', 100000);

insert into tbl_Works (employee_name, company_name, salary) values
('Cara', 'Specter', 12312),
('John', 'Pearson', 76000),
('Carl', 'Jane', 90000),
('Lorie', 'Jane', 45000);

insert into tbl_Managers (employee_name, manager_name) values
('Alex', 'Red John'),
('Johnson', 'Shark'),
('Carlson', 'Walter');

insert into tbl_Employee (employee_name, street, city) values
('Cara', 'Downtown-2', 'Manhattan'),
('John', 'Precinct', 'Charlotte'),
('Carl', 'Vegas', 'California City'),
('Lorie', 'CN', 'California City');


select * from tbl_Employee;

-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Q. NO. 2 


-- 2. a. Find the names of all employees who work for First Bank Corporation

-- solution:
select employee_name from tbl_Works where company_name = 'Hardman';



-- 2. b. Find the names and cities of residence of all employee who work for First Bank Corporation.

-- Solution: 

select * from tbl_Employee join tbl_Company where tbl_Company.company_name = 'Hardman';

-- 2. d. Find all employees in the database who live in the same cities as the companies for which they work. 

-- 2. d. Solution 

	-- By using join:
	select * from tbl_Employee join tbl_Company where tbl_Employee.city = tbl_Company.city;

	-- By using subqueries:
	select tbl_Employee.employee_name from tbl_Employee, tbl_Works, tbl_Company 
    where tbl_Employee.employee_name = tbl_Works.employee_name
    and tbl_works.company_name = tbl_Company.company_name
    and tbl_Company.city = tbl_Employee.city;




