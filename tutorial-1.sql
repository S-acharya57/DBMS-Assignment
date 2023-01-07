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

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////


-- 2. b. Find the names and cities of residence of all employee who work for First Bank Corporation.

-- Solution: 

select * from tbl_Employee join tbl_Company where tbl_Company.company_name = 'Hardman';

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////


-- 2. c Find the names, street addresses and cities of residence of all employees who work for First Bank Corporation and earn more than 10,000. 

-- solution: 
	-- subqueries
    select tbl_Employee.employee_name, tbl_Employee.street, tbl_Employee.city from tbl_Employee, tbl_Works where 
    tbl_Employee.employee_name = tbl_Works.employee_name and
    tbl_Works.company_name = 'Hardman' and tbl_Works.salary > 10000;
 
	-- join 
    select employee_name, street, city from (tbl_Employee join tbl_Works) where 
    company_name = 'Hardman' and salary>10000;
 
 
-- 2. d. Find all employees in the database who live in the same cities as the companies for which they work. 

-- 2. d. Solution 

	-- By using join:
	select employee_name, street, tbl_Employee.city from (tbl_Employee join tbl_Company)
    where tbl_Employee.city = tbl_Company.city;

	-- By using subqueries:
	select tbl_Employee.employee_name from tbl_Employee, tbl_Works, tbl_Company 
    where tbl_Employee.employee_name = tbl_Works.employee_name
    and tbl_works.company_name = tbl_Company.company_name
    and tbl_Company.city = tbl_Employee.city;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////


-- 2 e. Find all employees in the database who live in the same cities and on the same streets
-- as do their managers.

-- 2. e. solution

select tbl_Managers.employee_name, tbl_Managers.manager_name
from tbl_Managers
inner join
tbl_Employee as employees on tbl_Managers.employee_name = employees.employee_name
inner join 
tbl_Employee as Managers on tbl_Managers.manager_name = Managers.employee_name
where
employees.city = Managers.city
and employees.street = Managers.street; 

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////



-- 2. f. Find all employees in the database who do not work for First Bank Corporation.

-- 2. f. Solution:

	select Tbl_Works.employee_name from tbl_Works where tbl_Works.company_name !='Hardman';

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////


    
-- 2. g. Find all employees in the database who earn more than each employee of Small Bank
-- Corporation.

-- 2. g. Solution: 

select employee_name, company_name, salary from tbl_Works 
where salary >
(select max(tbl_Works.salary) from tbl_Works
where tbl_Works.company_name = 'Specter');

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 2. h. Assume that the companies may be located in several cities. Find all companies located
-- in every city in which Small Bank Corporation is located.

-- 2 .h. Solution: 

select company_name from tbl_Company 
where city =
(select city from tbl_Company where company_name = 'Hardman');


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 2. i. Find all employees who earn more than the average salary of all employees of their company.

-- 2. i. solution:

select tbl_Works.employee_name from 
(select company_name, avg(salary) as avg_salary
from tbl_works
group by company_name) as AVG_SAL
join tbl_Works on AVG_SAL.company_name = tbl_Works.company_name
where tbl_Works.salary> AVG_SAL.avg_salary;

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- 2. j. Find the company that has the most employees.

-- 2. j. solution:

select company_name, count(employee_name) as count_emp from tbl_Works
as tbl_Works group by company_name
order by count_emp desc
limit 1;


-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 2. k. Find the company that has the smallest payroll.


-- 2. k. solution:
select company_name from tbl_Works
order by salary asc
limit 1;


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 2. l. Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation

-- 2. l.. Solution

select company_name from 
(select company_name, avg(salary) as avg_sal
from tbl_Works
group by company_name) as AVG_SAL
where AVG_SAL.avg_sal> 
(select average2 from
( select company_name, avg(salary) as average2 from tbl_Works
group by company_name) as all_avg_sal
where all_avg_sal.company_name = 'Jane');


-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 3. Consider the relational database of Figure 5. Give an expression in SQL for each of the following queries

-- 3. .a. Modify the database so that Cara now lives in Newtown.

-- 3. a. solution:

update tbl_Employee
set city = 'Newton' 
where employee_name = 'Cara';

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////


-- 3. b. Give all employees of First Bank Corporation a 10 percent raise
-- 3. b. solution:


update tbl_Works 
set salary = 1.1*salary
where company_name = 'Hardman';

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////

-- 3. c. Give all managers of First Bank Corporation a 10 percent raise.

-- 3. c. solution: 

update tbl_Works
set salary = 1.1*salary
where employee_name = any(
select distinct manager_name from tbl_Managers)
and company_name = 'Hardman';

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////

-- 3. d.  Give all managers of First Bank Corporation a 10 percent raise unless the salary becomes greater than $100,000;
-- in such cases, give only a 3 percent raise.

-- 3.d. Solution:

update tbl_Works
set salary = if(salary<100000,
	salary*1.1,
    salary*1.03)
where employee_name = any(
select distinct manager_name from tbl_Managers)
and company_name = 'Hardman';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- 3. e. Delete all tuples in the works relation for employees of Small Bank Corporation.

-- 3. e. solution:


-- disabling the foreign key check
set foreign_key_checks = 0;

DELETE tbl_Works , tbl_Employee , tbl_Managers FROM tbl_Works
        JOIN
    tbl_Employee ON tbl_Employee.employee_name = tbl_Works.employee_name
        JOIN
    tbl_Managers ON tbl_Works.employee_name = tbl_Managers.employee_name 
WHERE
    tbl_Works.company_name = 'Hardman';

-- after deletion, enabling the foreign key check
set foreign_key_checks = 1;

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
