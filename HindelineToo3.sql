-- HINDELINE TÖÖ --

--1.AND operaator leia kõik tooted, mille hind on suurem kui 500 eurot ja kaal suurem kui 500grammi.
--Väljasta :ProductId, Name, ListPrice, Weight

select ProductId, Name, ListPrice, Weight 
from SalesLT.Product
Where ListPrice > 500 and Weight > 500



--2. OR ja NOT  operaator Leia kõik tooted, mis kuuluvad kategooriasse „Mountain Bikes“ või „Road Bikes“, kuid mille nimi ei sisalda „women „
--Väljasta: ProductId, Name
alter table SalesLT.Product
add ProductCategory nvarchar(50)

select ProductId, Name
from SalesLT.Product
where ProductCategory = 'Mountain Bikes' 
or ProductCategory = 'Road Bikes'
or not (lower(name)) = 'woman'


--3. Allahindlus Kuva kõik tooted koos 15 % sooduhinnaga.
--Väljasta: Name, ListPrice, Discountprice
select Name, ListPrice, Discountprice = ListPrice * 0.85
from SalesLT.Product



--4.käibimaksu arvutamine Arvuta toodete hinnad koos 22% käibimaksuga.
--Väljesta:Name, ListPirce, PriceWithVAT
select Name, ListPrice, PriceWithVAT = ListPrice * 0.22
from SalesLT.Product



--5.Toote otsimine Id Järgi 
--Loo store procedure, mis tagastab ühe toote andmed ProductId alusel.
create procedure Product333
as begin
select ProductId, Name
from SalesLT.Product
where ProductId = 788
end
exec Product333

--6.kategooria toode nimekiri 
--Loo stored procedure , mis kuvab kõik tooted etteantud kategooriast
create procedure Product322
as begin
select ProductId, Name, ListPrice, ProductCategoryId
from SalesLT.Product
where ProductCategoryId = 20
end
exec Product322

--7.Uue kliendi lisamine 
--Loo stored procedure uue kliendi lisamiseks


--8.Logi uute toodete lisamine 

create table LogId
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

insert into LogId (Id, Name,DateOfBirth)
values (1, 'Sam', '1999-01-10 15:56:02.983');
insert into LogId (Id, Name,DateOfBirth)
values (2, 'Ken', '2000-02-21 10:16:02.983');
insert into LogId (Id, Name,DateOfBirth)
values (3, 'Andrew', '2010-01-26 02:26:02.983');
insert into LogId (Id, Name,DateOfBirth)
values (4, 'Katy', '2007-08-20 09:35:02.983')

select * from LogId