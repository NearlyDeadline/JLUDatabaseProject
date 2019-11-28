坑:
1.不支持intersect
2.不支持except
3.不支持with as(MySQL 8.0后支持)

1.select * from course;

2.select title from course;

3.select distinct title from course natural join section;
select distinct title from course where course_id in (select course_id from section);

4.select * from student limit 6;

5.select S.ID, S.name from student as S where not exists (select course_id from course where dept_name = 'Comp. Sci.' and course_id not in(select T.course_id from takes as T where S.ID = T.ID));

6.select distinct course_id from section 
where semester = 'Spring' and year = '2019' 
and course_id in 
(select course_id from section 
where course_id not in 
(select course_id from section where year = '2018'));

7.SELECT ID, name, dept_name, (80-tot_cred) as A FROM university.student where dept_name = 'Comp. Sci.' and tot_cred <= 80 order by A desc;

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

11.select S.ID, S.name, sum(credits) from student as S, course as C, takes as T, instructor as I where I.ID in (select ID from instructor where name = 'Kim') and (S.ID, I.ID) in (select A.s_ID, A.i_ID from advisor as A) and year = '2009' and semester = 'Spring' and T.ID = S.ID and T.course_id = C.course_id group by S.ID;

11.select prereq_id from prereq where course_id in (select course_id from course where title = 'A') and course_id in (select prereq_id from prereq where course_id in (select course_id from course where title = 'B'));

12.select year, count(course_id) from section where course_id in (select course_id from course where dept_name = 'Comp. Sci.') and (year = '2016' or year = '2017' or year = '2018') group by year;

13.select course_id, title from course where course_id not like '%004%' or course_id not like '%007%' or course_id not like '%013%';

14.select * from course where title like 'D%e'; 

15.select * from course where title like '%制作%' and not like '制作%' and title not like '%制作';

16.select * from student where name like '_宝%';

17.select * from student where name not like '刘%';

18.select T.course_id from course as T where 1 < (select count(R.course_id) from course, section as R where T.course_id = R.course_id and R.year =  '2018');

19.select ID, name, tot_cred from student where dept_name = 'Comp. Sci.' and ID in (select ID from takes where course_id in (select course_id from course where dept_name = 'Comp. Sci.') and (course_id, sec_id, semester, year) in (select course_id, sec_id, semester, year from teaches where ID in (select ID from instructor where dept_name <> 'Comp. Sci.')));

20.select * from section as S where semester = 'Spring' and year = '2019' and 15 < (select count(ID) from takes as T where T.course_id = S.course_id) and 25 > (select count(ID) from takes as T where T.course_id = S.course_id);

21.select count(course_id) from section where year = '2018' and course_id not in (select course_id from course where dept_name = 'Comp. Sci.');

22.with table(course_id, sec_id, semester, year, building, room_number, time_slot_id) as
 (select (course_id, sec_id, semester, year, building, room_number, time_slot_id) from section as S 
where 15 < (select count(ID) from takes as T where T.course_id = S.course_id) 
and 25 > (select count(ID) from takes as T where T.course_id = S.course_id) 
select table.* from table, takes as T where table.course_id = T.course_id group by T.course_id, T.sec_id, T.semester, T.year order by count(T.ID) desc;

23.select avg(salary) from instructor as I where (I.dept_name in
(select D.dept_name from department as D where D.dept_name <> 'Comp. Sci.' and D.building in (select D.building from department as D where D.dept_name = 'Comp. Sci.'))) group by I.dept_name;

24.update instructor I set I.salary = I.salary * 1.5 where I.dept_name in (select D.dept_name from department as D where D.building = '匡亚明');

25.select dept_name, count(ID) from student group by dept_name;

26.select * from student where dept_name = 'Comp. Sci.' order by tot_cred desc limit 10;

27.select count(T.ID) from teaches as T where (T.year = '2017' or T.year = '2018' or T.year = '2019') and T.ID in (select I.ID from instructor as I where I.name = '李四');

28.select * from instructor where dept_name = 'Comp. Sci.' and salary > (select min(salary) from instructor where dept_name = 'Physics') and salary < (select max(salary) from instructor where dept_name = 'Physics');

29.select A.id - B.id from (select count(course_id) as id from section where course_id in (select course_id from course where dept_name = 'Comp. Sci.')) as A, (select count(course_id) as id from section where course_id in (select course_id from course where dept_name = 'Biology')) as B;

30.select count(S.course_id) from section as S where S.year = '2019' and S.semester = 'Spring' and 1 > (select count(T.ID) from takes as T where S.course_id = T.course_id);

31.select * from instructor as I where I.ID in (select A.i_ID from advisor as A where A.s_ID in (select S.ID from student as S where S.dept_name = 'Comp. Sci.'));
select * from advisor natural join instructor  where student.dept_name = 'Comp. Sci.';

32.update department set budget = budget * 1.2 where budget < (select * from (select avg(budget) from department) a );

33.select count(A.s_ID) from advisor as A where A.i_ID in (select I.ID from instructor as I where I.name = '李四');

34.select S.* from student as S where S.ID in 
(select T.ID from takes as T where T.course_id in 
(select P.prereq_id from prereq as P where P.course_id in 
(select C.course_id from course as C where C.title = 'Robotics')));

35.select distinct S.name as student_name, I.name as instructor_name, TA.course_id, TA.sec_id from student as S, instructor as I, takes as TA, teaches as TE where TA.year = '2009' and TA.semester = 'Spring' and TE.year = TA.year and TE.semester = TA.semester and (TA.ID, TE.ID) in (select s_ID, i_ID from advisor) and (TA.course_id, TA.sec_id, TA.semester, TA.year) in (select course_id, sec_id, semester, year from teaches) and S.ID = TA.ID and I.ID = TE.ID;