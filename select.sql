1.select * from course;

2.select title from course;

3.select distinct title from course natural join section;
select distinct title from course where course_id in (select course_id from section);

4.select * from student limit 6;

5.with A(id) as (select course_id from course as C where dept_name = 'Comp. Sci.'),
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

7.

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

11.with one