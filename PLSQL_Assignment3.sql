create table student(stu_id integer(3)primary key, stu_name varchar(25)not null,sex varchar(10)not null,tot_mark integer(4)not null);

CREATE TABLE `student` (
  `stu_id` int NOT NULL,
  `stu_name` varchar(25) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `tot_mark` int NOT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


desc student;

-- Field 	Type 		Null 	Key 	Default
-- stu_id	int			NO		PRI		NULL
-- stu_name	varchar(25)	NO				NULL
-- sex		varchar(10)	NO				NULL
-- tot_mark	int			NO				NULL

insert into student values(10,'Anu','Female',553),(20,'Anbu','Male',345),(30,'Malini','Female',567),(40,'Sankar','Male',590),(50,'Varshan','Male',587);

select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 20			Anbu		Male		345
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587

select max(tot_mark) from student;

-- max(tot_mark)
-- 590

select sex ,count(*) from student group by sex;

-- sex		count(*)
-- Female	2
-- Male		3

select * from student where tot_mark>(select avg(tot_mark) from student);

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587

select * from student where  stu_name like '___';

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553


select * from student order by sex asc;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 30			Malini		Female		567
-- 20			Anbu		Male		345
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587


select * from student order by tot_mark desc;

-- stu_id		stu_name	sex			tot_mark
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587
-- 30			Malini		Female		567
-- 10			Anu			Female		553
-- 20			Anbu		Male		345


select (max(tot_mark)-min(tot_mark)) as diff from student;

-- diff
-- 245

create view mytab as select * from student where sex='Male' with check option;


desc mytab;

-- Field	Type		Null
-- stu_id	int			NO
-- stu_name	varchar(25)	NO
-- sex		varchar(10)	NO
-- tot_mark	int			NO

select * from mytab;

-- stu_id		stu_name	sex			tot_mark
-- 20			Anbu		Male		345
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587

start transaction;

insert into student values(60,'Jumbo','Male',548);
select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 20			Anbu		Male		345
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587
-- 60			Jumbo		Male		548


insert into student values(70,'Whitey','Female',589);
select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 20			Anbu		Male		345
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587
-- 60			Jumbo		Male		548
-- 70			Whitey		Female		589


insert into student values(80,'Browny','Male',511);
select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 20			Anbu		Male		345
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587
-- 60			Jumbo		Male		548
-- 70			Whitey		Female		589
-- 80			Browny		Male		511 

savepoint s1;

delete from student where tot_mark<500;

select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587
-- 60			Jumbo		Male		548
-- 70			Whitey		Female		589
-- 80			Browny		Male		511 

delete from student where tot_mark%2!=0;
select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 40			Sankar		Male		590
-- 60			Jumbo		Male		548
-- 70			Whitey		Female		589
-- 80			Browny		Male		511 

delete from student where stu_id=70;

delete from student where stu_id=80;


select * from student;
-- stu_id		stu_name	sex			tot_mark
-- 40			Sankar		Male		590
-- 60			Jumbo		Male		548

rollback to savepoint s1;
commit;

select * from students;

-- stu_id		stu_name	sex			tot_mark
-- 10			Anu			Female		553
-- 20			Anbu		Male		345
-- 30			Malini		Female		567
-- 40			Sankar		Male		590
-- 50			Varshan		Male		587
-- 60			Jumbo		Male		548
-- 70			Whitey		Female		589
-- 80			Browny		Male		511 


DELIMITER //
create procedure get_Student()
begin
select * from student;
end//

DELIMITER //
create procedure get_sqt(in x int, in y int, out z int, out w int)
begin
set z= x*x;
set w= y*y*y;
end//

select * from student;

-- stu_id		stu_name	sex			tot_mark
-- 40			Sankar		Male		590
-- 60			Jumbo		Male		548
-- 70			Whitey		Female		589
-- 80			Browny		Male		511

select (select avg(tot_mark) from student where sex='Male' group by sex) as MalAvg, (select avg(tot_mark) from student where sex='Female' group by sex) as FeAvg from student;
select avg(tot_mark), sex from student group by sex;
-- MalAvg		FeAvg
-- 549.6667		589.0000
-- 549.6667		589.0000
-- 549.6667		589.0000
-- 549.6667		589.0000

call get_student();
call get_sqt(25,2,@z,@w);

select @z;
select @w;

-- @z
-- 5

-- @w
-- 8

select * from empl order by salary asc;