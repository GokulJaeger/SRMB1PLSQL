show databases;

-- DAY-1 PLSQL ASSIGNMENT --
use plsql;

create table depart(depart_id integer(4)primary key, depart_name varchar(30)not null, manager_id integer(6)unique);

CREATE TABLE `depart` (
  `depart_id` int NOT NULL,
  `depart_name` varchar(30) NOT NULL,
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`depart_id`),
  UNIQUE KEY `manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

show tables;
desc depart;


create table employees(emp_id integer(6)primary key, emp_name varchar(20), email character(25),phone_number varchar(10),dept_id integer(4));

CREATE TABLE `empl` (
  `emp_id` int PRIMARY KEY NOT NULL,
  `emp_name` varchar(20) DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

show tables;
desc employees;

-- Field 		     Type 			Null 	Key 
-- emp_id		    int				NO			PRI
-- emp_name		varchar(20)		YES			
-- phone_number	varchar(10)		YES			
-- dept_id		int				YES			
-- salary		decimal(8,2)	YES	
-- email    varchar(20)   YES


alter table employees add(salary decimal(8,2));
desc employees;
alter table employees add foreign key(dept_id) references depart(depart_id);

desc employees;

-- Field 		     Type 			Null 	Key 
-- emp_id		    int				NO			PRI
-- emp_name		varchar(20)		YES			
-- phone_number	varchar(10)		YES			
-- dept_id		int				YES			MUL
-- salary		decimal(8,2)	YES	


alter table employees drop primary key;

desc employees;

alter table employees drop dept_id;

alter table employees drop foreign key employees_ibfk_1;

alter table employees drop index dept_id;

desc employees;

-- Field 		     Type 			Null 	Key 
-- emp_id		    int				NO			
-- emp_name		varchar(20)		YES			
-- phone_number	varchar(10)		YES			
-- dept_id		int				YES			
-- salary		decimal(8,2)	YES		

alter table employees drop email;

alter table empl add constraint check_salary check (salary>10000);

desc employees;
-- Field 		     Type 			Null 	Key 
-- emp_id		    int				NO			
-- emp_name		varchar(20)		YES			
-- phone_number	varchar(10)		YES			
-- dept_id		int				YES			
-- salary		decimal(8,2)	YES		

alter table employees rename to empl;

show tables;

desc empl;

create table depart1 like depart;

desc depart;

-- Field 		Type 			Null 	Key 
-- depart_id	int				NO		PRI		
-- depart_name	varchar(30)		NO			
-- manager_id	int				YES		UNI		

drop table depart1;

show tables;

desc empl;

-- Field 		     Type 			Null 	Key 
-- emp_id		    int				NO			
-- emp_name		varchar(20)		YES			
-- phone_number	varchar(10)		YES			
-- dept_id		int				YES			
-- salary		decimal(8,2)	YES				


-- DAY-2 PLSQL ASSIGNMENT --

insert into depart values(10,'purchase',123),(20,'inventory',345),(30,'sales',567),(40,'material',789),(50,'production',901);

insert into empl values(101,'goku','68462684',10,15000.50);

desc empl;

select * from empl;
-- emp_id	emp_name	phone_number	dept_id		salary
-- 101		goku		68462684		10			15000.50
-- 102		vegeta		687268385		20			14000.50
-- 103		gohan		4752385			30			11000.50
-- 104		trunks		12548385		50			23000.50
-- 105		pikallo		7845285			40			12000.50

insert into empl values(102,'vegeta','687268385',20,14000.50),(103,'gohan','4752385',30,11000.50),(104,'trunks','12548385',50,23000.50),(105,'pikallo','7845285',40,12000.50);

select * from depart;

-- depart_id	depart_name		manager_id
-- 10			purchase		123
-- 20			inventory		345
-- 30			sales			567
-- 40			material		789
-- 50			production		901

select * from empl e, depart d where e.dept_id = d.depart_id and d.depart_name='material';

-- emp_id		emp_name	phone_number	dept_id		salary
-- 105			pikallo		7845285			40			12000.50

select depart_id, emp_name from empl, depart where depart_id=dept_id and depart_name='sales';

-- depart_id	emp_name
-- 30			gohan

select emp_name from empl, depart where depart_id=dept_id and depart_name='material' and salary>10000;

-- emp_name
-- pikallo

select emp_name, salary+(salary*0.05) as sal from empl;

-- emp_name	sal
-- goku		15750.5250
-- vegeta	14700.5250
-- gohan	11550.5250
-- trunks	24150.5250
-- pikallo	12600.5250

select * from empl where emp_name like 'g%';

-- emp_id		emp_name	phone_number	dept_id		salary
-- 101			goku		68462684			10		15000.50
-- 103			gohan		4752385				30		11000.50

update empl, depart set salary=salary+(salary*0.1) where  depart_id=dept_id and depart_name='sales';

select * from empl;

-- emp_id		emp_name	phone_number	dept_id		salary
-- 101			goku		68462684			10		15000.50
-- 102			vegeta		687268385			20		14000.50
-- 103			gohan		4752385				30		12100.00
-- 104			trunks		12548385			50		23000.50
-- 105			pikallo		7845285				40		12000.50

update empl, depart set salary=salary-(salary*0.01) where  depart_id=dept_id and depart_name='inventory';


select * from empl;

-- emp_id		emp_name	phone_number	dept_id		salary
-- 101			goku		68462684			10		15000.50
-- 102			vegeta		687268385			20		13860.50
-- 103			gohan		4752385				30		12100.00
-- 104			trunks		12548385			50		23000.50
-- 105			pikallo		7845285				40		12000.50

create table updatedemp as select emp_id, emp_name, phone_number from empl where dept_id>20;

desc updatedemp;

-- Field 	Type 			Null 	Key 
-- emp_id	int				NO			
-- emp_name	varchar(20)		YES			
-- phone_number	varchar(10)	YES			

select * from updatedemp;

-- emp_id	emp_name	phone_number
-- 103		gohan		4752385
-- 104		trunks		12548385
-- 105		pikallo		7845285

delete from empl where salary<13000;

select *from empl;

-- emp_id		emp_name	phone_number	dept_id		salary
-- 101			goku			68462684		10		15000.50
-- 102			vegeta			687268385		20		13860.50
-- 104			trunks			12548385		50		23000.50

create view view_updatedemp as select * from updatedemp;

select * from view_updatedemp;

-- emp_id	emp_name	phone_number
-- 103		gohan		4752385
-- 104		trunks		12548385
-- 105		pikallo		7845285

create view view_empl as select emp_id, emp_name, dept_id from empl where salary>=12000;

select * from view_empl;

-- emp_id		emp_name	dept_id
-- 101			goku		10
-- 102			vegeta		20
-- 104			trunks		50

select * from empl order by salary asc;

-- emp_id		emp_name	phone_number	dept_id		salary
-- 102			vegeta		687268385			20		13860.50
-- 101			goku		68462684			10		15000.50
-- 104			trunks		12548385			50		23000.50

select * from empl order by emp_name desc;

-- emp_id		emp_name	phone_number	dept_id		salary
-- 102			vegeta		687268385			20		13860.50
-- 104			trunks		12548385			50		23000.50
-- 101			goku		68462684			10		15000.50


