create database Employee;

use Employee;

 create table Tbl_employee(
							employee_name varchar(255) NOT NULL,
							street varchar(255),
							city varchar(255),
							primary key (employee_name)
							);
create table Tbl_works(
							employee_name varchar(255) NOT NULL,
							company_name varchar(255) NOT NULL,
							salary integer,
							primary key (employee_name)
							);

create table Tbl_company(
							company_name varchar(255),
							city varchar(255),
							primary key  (company_name)
							);

create table Tbl_manages(
							employee_name varchar(255),
							manager_name varchar(255),
							primary key  (employee_name)
							);

--Addition of Foreign Keys

Alter table Tbl_works
 add foreign key (employee_name) references Tbl_employee(employee_name);

Alter table Tbl_works
 add foreign key (company_name) references Tbl_company(company_name);

Alter table Tbl_manages
 add foreign key (employee_name) references Tbl_employee(employee_name);


 --Inserting data into Table

insert into Tbl_employee(employee_name,street,city)
				values('Shyam','Ghattekulo','Kathmandu'),
				('Grk','Kritipur','Kathmandu'),
				('Shahas','Neupane tol','Bhaktapur'),
				('Rajendra','Chabahil','Kathmandu'),
				('Raj','Ghattekulo','Kathmandu'),
				('Anuj','Basundhara','Kathmandu'),
				('Biraj','Pepsicola','Bhaktapur'),
				('Jay','Anamnagar','Kathmandu'),
				('Bijay','Chandragiri','Bhaktapur'),
				('Roshan','Baneswor','Kathmandu'),
				('Ram','Kalopul','Kathmandu');


insert into Tbl_works(employee_name,company_name,salary)
	values('Shyam','First Bank Corporation',250000),
			('Grk','Small Bank Corporation',70000),
			('Shahas','Small Bank Corporation',45000),
			('Rajendra','First Bank Corporation',50000),
			('Raj','First Bank Corporation',10000),
			('Anuj','First Bank Corporation',50000),
			('Biraj','First Bank Corporation',8000),
			('Jay','Small Bank Corporation',20000),
			('Bijay','First Bank Corporation',40000),
			('Roshan','Small Bank Corporation',70000),
			('Ram','Small Bank Corporation',6000);

insert into Tbl_company(company_name,city)
			values('First Bank Corporation','Kathmandu'),
			('Small Bank Corporation','Bhaktapur');

insert into Tbl_manages(employee_name,manager_name)
			values('Jay','Grk'),
				('Raj','Shayam'),
				('Ram','Jay'),
				('Anuj','Rajendra'),
				('Bijay','Anuj'),
				('Shahas','Roshan'),
				('Biraj','Raj');


--Q2a
	select employee_name from Tbl_works where company_name='First Bank Corporation';


--Q2b

	select employee_name, city from Tbl_employee
		where employee_name in (select employee_name from Tbl_works where company_name = 'First Bank Corporation');

--Q2c

	select employee_name,street,city from Tbl_employee where employee_name in
		(select employee_name from Tbl_works where company_name='First Bank Corporation' and salary>10000);

--Q2d

	select employee_name,city from Tbl_employee e where e.city=
		(select city from Tbl_company c where c.company_name= 
			(select company_name from Tbl_works w where w.employee_name=e.employee_name )); 

--Q2e

	select * from Tbl_employee e where e.city=
		(select city from Tbl_employee e where e.city= 
			(select manager_name from Tbl_manages m where  m.manager_name=e.employee_name));

--Q2f

	select * from Tbl_works w where w.company_name!='First Bank Corporation'; 

--Q2g

	select * from Tbl_works w where	w.salary>
		(select max(salary) from Tbl_works  join Tbl_company where company_name='Small Bank Corporation');

--Q2h

	select * from Tbl_company c where c.city=(select city from Tbl_company where company_name='Small Bank Corporation');
			
--Q2i

	select * from Tbl_works w where w.salary> (select avg(salary) from Tbl_works w where w.company_name=w.company_name);

--Question3

--Q3A

	update Tbl_employee  set city='bhaktapur' where employee_name='Arun' ;

--Q3b

up	date Tbl_works  set salary=salary*1.1 where company_name='First Bank Corporation';

--q3c

	update Tbl_works  SET salary=salary*1.1 where employee_name in 
		(select manager_name from Tbl_manages where manager_name in 
			(select employee_name from Tbl_works where company_name='First Bank Corporation'));
--Q3d

	update Tbl_works set salary=
			case
				when salary>100000 then salary*1.03
			else salary*1.1
			end
			where Tbl_works.employee_name in 
				(select manager_name from Tbl_manages where Tbl_manages.manager_name=Tbl_works.employee_name
					and Tbl_works.company_name='First Bank Corporation');

--Q3e
	
	select * from tbl_works, tbl_manages
	where tbl_manages.manager_name = tbl_works.employee_name and tbl_works.company_name = 'First Bank Corporation';

	delete from works
	where company_name = 'Small Bank Corporation';

