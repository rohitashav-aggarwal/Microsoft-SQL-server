-- Name: Rohitashav Aggarwal
-- Date: 13 Jan 2020
-- Id: 000837967
-- Course: Database Management

-- create tables
create table Instructors(
Name varchar(20) Primary key,
OfficeRoom int)

create table Students(
Student# int primary key,
Name varchar(20) constraint Name not null,
Email varchar(40),
MajorSpecialization varchar(10))

create table Courses(
Course# int,
Name varchar(20) constraint Name not null,
InstructorName varchar(20) foreign key references Instructors,
primary key(Course#))

create table Registrations(
Course# int foreign key references Courses(Course#),
Student# int foreign key references Students(Student#),
Grade varchar(1),
primary key(Student#, Course#))

-- Database diagram created

-- insert 2 records atleast in each table

insert into instructors (Name, OfficeRoom) values ('Bob', 1)
insert into instructors (Name, OfficeRoom) values ('Harry', 2)
insert into instructors (Name, OfficeRoom) values ('Alan', 3)
insert into instructors (Name, OfficeRoom) values ('Elena', 4)


insert into students (student#, Name, Email, MajorSpecialization) values (1, 'Robert', 'rob@gmail.com', 'Physics')
insert into students (student#, Name, Email, MajorSpecialization) values (2, 'Elon', 'elon@gmail.com', 'Chemistry')
insert into students (student#, Name, Email, MajorSpecialization) values (3, 'Wade', 'wade@gmail.com', 'Biology')

insert into courses(course#, name, InstructorName) values(101, 'Physics', 'Bob')
insert into courses(course#, name, InstructorName) values(102, 'chemistry', 'Harry')
insert into courses(course#, name, InstructorName) values(103, 'Biology', 'Elena')

insert into Registrations(Student#, Course#, Grade) values(1, 101, 'A')
insert into Registrations(Student#, Course#, Grade) values(2, 102, 'B')
insert into Registrations(Student#, Course#, Grade) values(3, 103, 'C')

-- command to change grade to w 
update registrations set grade = 'W' where Course#=101

-- Command to find out how many students
select count(*) as NumberOfStudents 
from Registrations 
inner join Courses on Courses.Course# = Registrations.Course#

-- command to find instructors that have not assigned courses yet
select i.Name
from Instructors i
left join courses c on c.InstructorName = i.Name
where InstructorName is null

-- unique names of all courses that students are taking and sorted
select distinct s.majorspecialization
from students s
order by MajorSpecialization

-- list all student names and courses they are taking and their grades
select s.name as StudentName, c.name as CourseName, r.grade as Grade
from Students s 
join Registrations r on r.Student# = s.Student#
join Courses c on c.Course# = r.Course#

-- delete one instructor courses and all students registered in that course
--test after deleting
select * from Courses
select * from Registrations


-- delete child element first
delete from Registrations
where Student# in 
(select s.Student# from Students s 
join Registrations r on s.Student# = r.Student#
join courses c on c.Course# = r.Course#
where c.InstructorName = 'Elena')

-- delete parent element now
delete from courses
where Courses.InstructorName = 'Elena'