-- chapter 4 exercises
--1
select * from vendors 
inner join invoices
on invoices.VendorID = Vendors.VendorID

--2
select VendorName, InvoiceNumber, InvoiceDate, (invoicetotal - paymenttotal - credittotal) as Balance
from Vendors
join Invoices on Invoices.VendorID = Vendors.VendorID
where (invoicetotal - paymenttotal - credittotal) > 0
order by VendorName asc

--3
select VendorName, DefaultAccountNo, AccountDescription
from vendors
join GLAccounts on GLAccounts.AccountNo = vendors.DefaultAccountNo
order by AccountDescription, vendorname

--4
select VendorName, InvoiceNumber, InvoiceDate, (invoicetotal - paymenttotal - credittotal) as Balance
from Vendors
left join Invoices on Invoices.VendorID = Vendors.VendorID
where (invoicetotal - paymenttotal - credittotal) > 0
order by VendorName asc

--5
select Vendors.VendorName as Vendor, i.InvoiceDate as Date,
i.InvoiceNumber as Number, li.InvoiceSequence as #, li.InvoiceLineItemAmount as LineItem
from Vendors
join invoices as i on vendors.vendorid = i.vendorid
join InvoiceLineItems as li on i.invoiceid = li.invoiceid
order by Vendor, Date, Number, #

--7
select GLAccounts.AccountNo, AccountDescription
from GLAccounts
left outer join vendors on GLAccounts.AccountNo = vendors.defaultAccountNo
where vendorcity is null

--Library Lab Challenge
select item.isbn, copy_no, on_loan, title, translation, cover
from title
join item on title.title_no = item.title_no
join copy on item.isbn = copy.isbn