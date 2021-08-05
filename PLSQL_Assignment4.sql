-- 
-- 
-- Multiple Table
-- 
-- 
create table multable(a int(5), x int(5), prod int(5));

DELIMITER //
create procedure multiple(in x int)
begin
declare a int(5);
declare pro int(5);
set a=1;
mul_loop: loop
if a>x then
leave mul_loop;
end if;
set pro=a*x;
-- select a,x,pro;
insert into multable values(a,x,pro);
set a=a+1;
iterate mul_loop;
end loop;
select * from multable;
end//

call multiple(5);


-- 
-- 
-- Whole Number Table
-- 
-- 



create table whonum(num int(5));

DELIMITER //
create procedure whole_num(in x int(5))
begin
declare a int(5);
set a=0;
new_loop:loop
if a>x then
leave new_loop;
end if;
insert into whonum values(a);
set a=a+1;
iterate new_loop;
end loop;
select * from whonum;
end //

call whole_num(50);


-- 
-- 
-- Check Palindrome
-- 
-- 

DELIMITER //
create procedure pali(in var varchar(255))
begin
declare rev varchar(225);
set rev = reverse(var);
if(strcmp(rev, var)=0) then
select 'The String is Palindrome';
else
select 'The String is not palindrome';
end if;
end //


call pali('moon');

-- 
-- 
-- Trigger to insertion in empo table;
-- 
-- 

create table empo(id int(15), name varchar(30));

desc empo;


-- Field	Type			Null
-- id		int				YES
-- name		varchar(30)		YES

insert into empo values(1,'Goku'),(2,'vegeta'),(3,'gohan');

select * from empo;

-- id	name
-- 1	Goku
-- 2	vegeta
-- 3	gohan

DELIMITER //
create trigger empo_tgr before insert on empo for each row
begin
set new.name = upper(new.name);
end //

insert into empo values(5,'krillen');

select * from empo;

-- id	name
-- 1	Goku
-- 2	vegeta
-- 3	gohan
-- 88	trunks
-- 88	KRILLEN



-- 
-- Procedure to delete in Worker Table
-- 
-- 

create table worker(wid int(5), wname varchar(30), wage int(3), wcity varchar(20));

desc worker;

-- Field	Type			Null
-- wid		int				YES
-- wname	varchar(30)		YES
-- wage		int				YES
-- wcity	varchar(20)		YES

insert into worker values(1,'goku',55,'Chennai'),(2,'vegeta',58,'Madurai'),(3,'eren',23,'Velore'),(4,'gohan',30,'Trichy'),(5,'trunks',30,'Selam'),(6,'goten',20,'Pondy'),(7,'krillen',50,'Banglore');

select * from worker;

-- wid	wname	wage	wcity
-- 1	goku	55		Chennai
-- 2	vegeta	58		Madurai
-- 3	eren	23		Velore
-- 4	gohan	30		Trichy
-- 5	trunks	30		Selam
-- 6	goten	20		Pondy
-- 7	krillen	50		Banglore

DELIMITER //
create procedure delete_worker(in id int(5))
begin
if id<0 then
select 'Wrong input';
else
delete from worker where wid=id;
end if;
end //


select * from worker;

-- 
--
-- CURSOR
-- 
-- 

create table empo1(eid int(4)primary key, ename varchar(30),sal int(5), comm int(5));  

insert into empo1 values(1,'goku',2000,1500),(2,'goku',2000,null),(3,'goku',2000,2000),(4,'goku',2000,null),(5,'goku',3000,1500);

select * from empo1;

-- eid	ename	sal		comm
-- 1	goku	2000	1500
-- 2	goku	2000	
-- 3	goku	2000	2000
-- 4	goku	2000	
-- 5	goku	3000	1500

DELIMITER //
create function my_cur() returns varchar(100) reads sql data
begin
declare sum int(8);
declare res varchar(200);
declare sum_cur cursor for select * from empo1 where sal+comm>3000;

open sum_cur;
-- if sum_cur.sal+sum_cur.comm >3000 then
fetch sum_cur into res;
-- end if;
close sum_cur;

return res;
end //

select my_cur();
