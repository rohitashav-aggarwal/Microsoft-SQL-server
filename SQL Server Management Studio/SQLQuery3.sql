--chapter 5 exercises
--1
select vendorid, sum(paymenttotal) as PaymentSum  
from invoices 
group by vendorid

--2
select top 10 vendorname, sum(paymenttotal) as PaymentSum  
from invoices join vendors on invoices.VendorID = Vendors.VendorID 
group by vendorname
order by PaymentSum desc

--3  wrong count
select  VendorName, sum(Invoices) as  invoicecount, sum(invoicetotal) as invoicesum
from Invoices join Vendors on Vendors.VendorID  = Invoices.VendorID
group by VendorName
order by invoicecount desc

--4 wrong count
select AccountDescription,
count(InvoiceLineItems.AccountNo) as LineItemCount,
count(InvoiceLineItems.InvoiceLineItemAmount) as LineItemSum
from GLAccounts
join InvoiceLineItems on GLAccounts.AccountNo = InvoiceLineItems.AccountNo
group by AccountDescription
having count(InvoiceLineItems.AccountNo) > 1
order by lineitemcount desc

--5 wrong count
select AccountDescription, invoices.InvoiceDate,
count(InvoiceLineItems.AccountNo) as LineItemCount,
count(InvoiceLineItems.InvoiceLineItemAmount) as LineItemSum
from GLAccounts
join InvoiceLineItems on GLAccounts.AccountNo = InvoiceLineItems.AccountNo
join invoices on Invoices.InvoiceID = InvoiceLineItems.InvoiceID
where invoicedate between 2015-12-01 and 2016-02-29
group by AccountDescription, InvoiceDate
having count(InvoiceLineItems.AccountNo) > 1
order by lineitemcount desc

--6 Library database challenge
select member.member_no, lastname, count(*)
from member
join juvenile on juvenile.adult_member_no = member.member_no 
group by lastname, member.member_no

-- practice ques
select max(total) from (select inv_size , sum(inv_qoh) as total
from inventory group by inv_size) tempstuff

-- chapter 6
-- ques 2
select invoicenumber, invoicetotal, paymenttotal
from invoices
where PaymentTotal > (select avg(paymenttotal) from invoices)
-- ques 6
select max(total) as UnpaidInvoice
from (select sum(Invoices.InvoiceTotal) as total from Invoices group by VendorID) 
tempstuff

-- practice insert, update and delete
insert into item(isbn, cover, title_no, loanable, translation) 
values (10001, 'hardback', 8, 'y', 'English')

update item set cover = 'softback' where isbn = 10001

delete from item where isbn = 10001

-- practice creating tables
create table rainchecks
(rain# numeric(6) primary key,
name char(30) not null,
phone numeric(10) check(phone>0),
comments varchar(300))

create table raincheck_details(
rain# numeric(6) foreign key references rainchecks(rain#),
item# numeric(8),
price numeric(10, 2),
date_promised datetime,
primary key(rain#, item#))

insert into rainchecks values(1, 'bob', 1112222, 'sold out early')
insert into raincheck_details values(1, 101, 10.00, getdate())
insert into raincheck_details values(1, 102, 10.00, getdate())
alter table rainchecks add email varchar(40)
alter table rainchecks alter column name char(35)
alter table raincheck_details drop column date_promised
alter table raincheck_details add constraint needprice check(price>0)
alter table raincheck_details drop constraint needprice

-- chapter 11 ques 2
create table individuals(
individualID int primary key,
firstName varchar,
lastName varchar,
address varchar,
phone varchar)

create table groups(
groupID int primary key,
groupName varchar,
dues money)

create table groupMembership(
groupID int foreign key references groups(groupID),
individualID int foreign key references individuals(individualID),
primary key(groupID, individualID))