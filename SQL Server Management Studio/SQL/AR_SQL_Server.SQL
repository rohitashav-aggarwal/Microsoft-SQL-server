create table ar_customers
(customer# numeric(3) primary key,
customer_name char(30),
customer_address char(40),
customer_province char(2),
customer_rating numeric(1));

create table ar_salespeople
(salesperson# numeric(2) primary key,
salesperson_name char(30));

create table ar_invoices
(invoice# numeric(3) primary key,
customer# numeric(3) references ar_customers(customer#),
salesperson# numeric(2) references ar_salespeople(salesperson#),
invoice_date datetime,
invoice_amount numeric(10,2),
amount_paid numeric(10,2),
current_month_interest_charges numeric(10,2),
total_interest_charges numeric(10,2));

insert into ar_salespeople values(1,'bob');
insert into ar_salespeople values(2,'mary');
insert into ar_salespeople values(3,'tim');

insert into ar_customers values(1,'bill','123 main st.','ab',1);
insert into ar_customers values(2,'ed','456 main st.','bc',2);
insert into ar_customers values(3,'john','789 main st.','ab',3);

insert into ar_invoices values(1,1,1,getdate()-20,100,1,0,0);
insert into ar_invoices values(2,2,2,getdate()-40,50,0,5,10);
insert into ar_invoices values(3,3,2,getdate()-20,70,0,10,20);
insert into ar_invoices values(4,2,1,getdate(),80,0,0,0);

commit;
