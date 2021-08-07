create table myemp(eno integer(4)primary key, ename varchar(30),deptno integer(4),esal decimal(8,2));

desc myemp;

-- Field 	Type 			Null 	Key
-- eno		int				NO		PRI
-- ename	varchar(30)		YES	
-- deptno	int				YES	
-- esal		decimal(8,2)	YES	



insert into myemp values(1,'goku',0814,20000),(2,'eren',4587,15000),(3,'naruto',932,5500),(4,'deku',9745,18000),(5,'natsu',1240,9000);

select * from myemp;

-- eno	ename	deptno	esal
-- 1	goku	814		20000.00
-- 2	eren	4587	15000.00
-- 3	naruto	932		5500.00
-- 4	deku	9745	18000.00
-- 5	natsu	1240	9000.00

alter table myemp add(experience integer(2)not null);

desc myemp;

-- Field 		Type 			Null 	Key
-- eno			int				NO		PRI
-- ename		varchar(30)		YES	
-- deptno		int				YES	
-- esal			decimal(8,2)	YES	
-- experience	int				NO	 

update myemp set esal=null where esal between 5000 and 10000;

select * from myemp;
-- eno	ename	deptno		esal		experience
-- 1	goku	814			20000.00	0
-- 2	eren	4587		15000.00	0
-- 3	naruto	932						0
-- 4	deku	9745		18000.00	0
-- 5	natsu	1240					0

alter table myemp add (comm int (5));

desc myemp;

-- Field 		Type 			Null 	Key
-- eno			int				NO		PRI
-- ename		varchar(30)		YES	
-- deptno		int				YES	
-- esal			decimal(8,2)	YES	
-- experience	int				NO	
-- comm			int				YES	


insert into myemp values(6,'tanjiro',5498,25000,5,null),(7,'Askcachm',6985,20000,2,2000);


select * from myemp;

-- eno	ename		deptno		esal		experience		comm
-- 1	goku		814			20000.00		0	
-- 2	eren		4587		15000.00		0	
-- 3	naruto		932							0	
-- 4	deku		9745		18000.00		0	
-- 5	natsu		1240						0	
-- 6	tanjiro		5498		25000.00		5	
-- 7	Askcachm	6985		20000.00		2			2000

create table empcommnul as (select * from myemp where comm is null);
delete from myemp where comm is null;

desc empcommnul;

-- Field 		Type 			Null 	Key
-- eno			int				NO		PRI
-- ename		varchar(30)		YES	
-- deptno		int				YES	
-- esal			decimal(8,2)	YES	
-- experience	int				NO	
-- comm			int				YES	

select * from empcommnul;


-- eno	ename		deptno		esal		experience		comm
-- 1	goku		814		20000.00			0	
-- 2	eren		4587	15000.00			0	
-- 3	naruto		932							0	
-- 4	deku		9745	18000.00			0	
-- 5	natsu		1240						0	
-- 6	tanjiro		5498	25000.00			5	

select * from myemp;

-- eno	ename		deptno		esal		experience		comm
-- 7	Askcachm	6985		20000.00		2			2000


alter table myemp add department int(3);

desc myemp;

select 









create table ebill(cno varchar(10)primary key, cname varchar(30)not null,nounits integer(4)not null,bamt decimal(8,2));

desc ebill;


-- Field 		Type 			Null 	Key
-- cno			varchar(10)		NO		PRI
-- cname		varchar(30)		NO	
-- nounits		int				NO	
-- bamt			decimal(8,2)	YES	



insert into ebill values('C1','goku',50,null),('C2','deku',40,null),('C3','naruto',30,null),('C4','eren',72,null),('C5','tanjiro',90,null);

select * from ebill;

-- cno		cname		nounits		bamt
-- C1		goku		50	
-- C2		deku		40	
-- C3		naruto		30	
-- C4		eren		72	
-- C5		tanjiro		90	


select * from ebill;


DELIMITER //
create procedure cal_bamt(in x varchar(10), out o decimal(8,2))
begin
declare done boolean default 0;
declare uits int(4);
declare amt_cur cursor for
select nounits from ebill where cno=x;
open amt_cur;
fetch amt_cur into uits;
if uits>200 then
set o=(uits-200)*1.5+150;
elseif uits>100 and uits<200 then
set o=(uits-100)*1.5+50;
else
set o=uits*0.5;
end if;
close amt_cur;
update ebill set bamt=o where cno=x;
select * from ebill where cno=x;
end //

call cal_bamt('C1', @va);
select @va;

-- cno	cname	nounits	bamt
-- C1	goku	50		25.00

select * from ebill;

-- cno	cname	nounits	bamt
-- C1	goku	50		25.00
-- C2	deku	40	
-- C3	naruto	30	
-- C4	eren	72	
C5	tanjiro	90	
