��:
1.��֧��intersect
2.��֧��except
3.��֧��with as(MySQL 8.0��֧��)

1.select * from course;

2.select title from course;

3.select distinct title from course natural join section;
select distinct title from course where course_id in (select course_id from section);

4.select * from student limit 6;

5.//������
with A(id) as (select course_id from course as C where dept_name = 'Comp. Sci.'),
B(id) as (select course_id from student as S, takes as T where S.ID = T.ID),
C(id1, id2) as (select * from A left join B on A.id = B.id)
select S.ID, S.name from S where not exists (select id1 from C where id2 = null);

select S.ID,S.name from student as S where not exists(select * from(select course_id from course where dept_name='Comp. Sci.')as K where K.course_id  not in (select T.course_id from takes as T where S.ID=T.ID));

6.select distinct course_id from section 
where semester = 'Spring' and year = '2019' 
and course_id in 
(select course_id from section 
where course_id not in 
(select course_id from section where year = '2018'));

7.//������

8.with a(course_id, val) as 
(select takes.course_id, count(*) from course, takes 
where course.course_id = takes.course_id 
and takes.year = '2019' and takes.semester = 'Spring' group by course.course_id) 
select course_id, max(val) from a;

9.select dept_name, avg(salary) as avg_salary from instructor group by dept_name;

10.with choose(ID, name) as 
(select student.ID, student.name from student, takes 
where year = '2009' and semester = 'Spring' and student.ID = takes.ID)
select distinct student.ID, student.name 
from student left join choose 
on (student.ID = choose.ID and student.name = choose.name) 
where choose.ID is null;

11.//������
select sum(credits) from course where course_id in(
select distinct ID, course_id from takes where ID in (select s_ID from advisor where i_ID in (select ID from instructor where name = 'Kim'))); and semester = 'Spring' and year = '2009');

11.//������

12.select year, count(course_id) from section where course_id in (select course_id from course where dept_name = 'Comp. Sci.') and (year = '2016' or year = '2017' or year = '2018') group by year;

13.select course_id, title from course where course_id not like '%004%' or course_id not like '%007%' or course_id not like '%013%';

14.select * from course where title like 'D%e'; 

15.select * from course where title like '%����%' and not like '����%' and title not like '%����';

16.select * from student where name like '_��%';

17.select * from student where name not like '��%';

18.select T.course_id from course as T where 1 < (select count(R.course_id) from course, section as R where T.course_id = R.course_id and R.year =  '2018');

19.//������

20.select * from section as S where semester = 'Spring' and year = '2019' and 15 < (select count(ID) from takes as T where T.course_id = S.course_id) and 25 > (select count(ID) from takes as T where T.course_id = S.course_id);

21.select count(course_id) from section where year = '2018' and course_id not in (select course_id from course where dept_name = 'Comp. Sci.');

22.with table(course_id, sec_id, semester, year, building, room_number, time_slot_id) as
 (select (course_id, sec_id, semester, year, building, room_number, time_slot_id) from section as S 
where 15 < (select count(ID) from takes as T where T.course_id = S.course_id) 
and 25 > (select count(ID) from takes as T where T.course_id = S.course_id) 
select table.* from table, takes as T where table.course_id = T.course_id group by T.course_id, T.sec_id, T.semester, T.year order by count(T.ID) desc;

23.select avg(salary) from instructor as I where (I.dept_name in
(select D.dept_name from department as D where D.dept_name <> 'Comp. Sci.' and D.building in (select D.building from department as D where D.dept_name = 'Comp. Sci.'))) group by I.dept_name;

24.update instructor I set I.salary = I.salary * 1.5 where I.dept_name in (select D.dept_name from department as D where D.building = '������');

25.select dept_name, count(ID) from student group by dept_name;

26.select * from student where dept_name = 'Comp. Sci.' order by tot_cred desc limit 10;

27.select count(T.ID) from teaches as T where (T.year = '2017' or T.year = '2018' or T.year = '2019') and T.ID in (select I.ID from instructor as I where I.name = '����');

28.select * from instructor where dept_name = 'Comp. Sci.' and salary > (select min(salary) from instructor where dept_name = 'Physics') and salary < (select max(salary) from instructor where dept_name = 'Physics');

29.//������
select count(S.course_id) from section as S where S.course_id in (select C.course_id from course as C where C.dept_name = 'Comp. Sci.');

30.select count(S.course_id) from section as S where S.year = '2019' and S.semester = 'Spring' and 1 > (select count(T.ID) from takes as T where S.course_id = T.course_id);

31.select * from instructor as I where I.ID in (select A.i_ID from advisor as A where A.s_ID in (select S.ID from student as S where S.dept_name = 'Comp. Sci.'));
select * from advisor natural join instructor  where student.dept_name = 'Comp. Sci.';

32.//������

33.select count(A.s_ID) from advisor as A where A.i_ID in (select I.ID from instructor as I where I.name = '����');

34.//������
select S.* from student as S where S.ID in 
(select T.ID from takes as T where T.course.id in 
(select P.prereq_id from prereq as P where P.course_id in 
(select C.course_id from course as C where C.title = 'Robotics')));

35.//������