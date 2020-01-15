
create view InvoiceBasic 
as
select VendorName, InvoiceNumber, InvoiceTotal
from Vendors
join Invoices
on vendors.VendorID = Invoices.VendorID

select * from InvoiceBasic 
--where VendorName like 'n%' or VendorName like 'o%' or VendorName like 'p%'
where substring(vendorname, 1, 1) in ('N', 'O', 'P')
--where VendorName like '[nop]%'
order by VendorName

alter view top10paidinvoices as
select top 10 vendorname , max(invoicedate) as lastinvoice, sum(invoicetotal) as sumofinvoices
from vendors v inner join invoices i on v.VendorID = i.VendorID
where InvoiceTotal-paymenttotal-CreditTotal=0
group by VendorName
order by 3 desc

select * from top10paidinvoices
