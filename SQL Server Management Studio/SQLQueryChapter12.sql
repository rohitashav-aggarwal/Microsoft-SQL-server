-- Chapter 12 Exercise 1 and 2

create table Individuals(
IndividualID int Primary Key check (IndividualID != ''),
FirstName varchar check (FirstName != ''),
LastName varchar check (LastName != ''),
Address varchar default null,
Phone varchar default null,
DuesPaid bit default 0)

create table Groups(
GroupID int Primary key,
GroupName varchar,
Dues money default 0 check(Dues>0))

create table GroupMembership(
GroupID int foreign key references Groups,
IndividualID int foreign key references Individuals,
primary key(GroupID, IndividualID))