
update ar_invoices set current_month_interest_charges = current_month_interest_charges + 
((0.02 * invoice_amount) + total_interest_charges)
where invoice_date < '2019-12-10'
-- t ans
select * from ar_invoices
where datediff(month, invoice_date, getdate())>1

update ar_invoices
set total_interest_charges = total_interest_charges + 0.02 * invoice_amount,
	current_month_interest_charges = 0.02*invoice_amount
	where datediff(month, invoice_date, getdate())>1

--2 ques
select customer_name, sum(current_month_interest_charges)
from ar_customers c
join ar_invoices i on i.customer# = c.customer#
group by c.customer_name
order by 1

--t ans same


select customer_name, sum(invoice_amount + total_interest_charges) as TotalOwing
from ar_customers c
join ar_invoices i on i.customer# = c.customer#
group by customer_name
--T ans same


select salesperson_name , sum(invoice_amount)
from ar_invoices i
join ar_salespeople s 
on i.salesperson# = s.salesperson#
where getdate()-invoice_date<=365
group by salesperson_name
--T ans

select customer_province , sum(invoice_amount)
from ar_invoices i
join ar_customers c on i.customer# = c.customer#
where getdate()-invoice_date<=30
group by customer_province
--T ans


select salesperson_name
from ar_salespeople s
left join ar_invoices i on i.salesperson# = s.salesperson#
where invoice_amount is null
--T ans 4 ways
select salesperson_name
from ar_salespeople s where salesperson# not in (select salesperson# from ar_invoices)

select salesperson# from ar_salespeople except select salesperson# from ar_invoices

select salesperson_name, salesperson#
from ar_salespeople s1 where not exists (select salesperson# from ar_invoices i 
										where s1.salesperson# = i.salesperson#)


--next
select top 1 c.customer_name, c.customer_rating
from ar_customers c
join ar_invoices i on i.customer# = c.customer#
group by c.customer_name, c.customer_rating
having count(invoice#) > 1
--T ans
select customer_name, count(*)
from ar_customers c inner join ar_invoices i on c.customer# = i.customer#
where customer_rating = 2 and getdate()-invoice_date<=365
group by customer_name
having count(*)>1


select s.salesperson_name
from ar_salespeople s
join ar_invoices i on i.salesperson# = s.salesperson#
join ar_customers c on c.customer# = i.customer#
where customer_rating = 3
--T ans same

--Last Ques
select salesperson_name, sum(invoice_amount)
from ar_salespeople s join ar_invoices i on s.salesperson# = i.salesperson#
group by salesperson_name

--T ans
select top 1 salesperson_name, sum(invoice_amount)
from ar_salespeople s join ar_invoices i on s.salesperson# = i.salesperson#
group by salesperson_name
order by sum(invoice_amount) desc

with tempx as
(select salesperson_name, sum(invoice_amount) as total
from ar_salespeople s inner join ar_invoices i on s.salesperson# = i.salesperson#
group by salesperson_name)
select * from tempx where total = (select max(total) from tempx)