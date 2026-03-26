--Iseseisev töö --
--Inner join
select
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice
from SalesLT.SalesOrderHeader as soh
inner join SalesLT.SalesOrderDetail as sod
    on soh.SalesOrderID = sod.SalesOrderID
--tagastab ainult read, mis on mõlemas tabelis olemas.

--Left join
select 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.EmailAddress,
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue
from SalesLT.Customer as c
LEFT JOIN SalesLT.SalesOrderHeader as soh
    on c.CustomerID = soh.CustomerID
--näitab kõik vasakust tabelist ja vastavad
--paremad read, puuduvatel veergudel NULL.

--Rigth join
	select 
    pc.ProductCategoryID,
    pc.Name as CategoryName,
    p.ProductID,
    p.Name as ProductName,
    p.StandardCost,
    p.ListPrice
from SalesLT.ProductCategory as pc
RIGHT JOIN SalesLT.Product as p
    on pc.ProductCategoryID = p.ProductCategoryID
--on nagu LEFT JOIN, aga kõiki parema 
--tabeli ridu näidatakse; FULL OUTER

--Full outer join
	select 
    pm.ProductModelID,
    pm.Name as ModelName,
    p.ProductID,
    p.Name as ProductName,
    p.Color,
    p.ListPrice
from SalesLT.ProductModel as pm
full OUTER JOIN SalesLT.Product as p
    on pm.ProductModelID = p.ProductModelID
--tagastab kõik read mõlemast tabelist; 
--kui vastet pole, tuleb NULL.

--Cross join
select 
    pc.Name as CategoryName,
    pm.Name as ModelName
from SalesLT.ProductCategory as pc
CROSS JOIN SalesLT.ProductModel as pm
order by pc.Name, pm.Name
--teeb kõik võimalikud kombinatsioonid kahe 
--tabeli ridade vahel.



--Lihtne SELECT – GetAllCustomers
--Eesmärk: Tagastab kõik kliendid tabelist.

create procedure GetAllCustomers
as
begin
    select * from SalesLT.Customer;
end
exec GetAllCustomers;
--Parameetriga päring – GetCustomerByID
--Eesmärk: Otsib konkreetse kliendi ID järgi.
create procedure GetCustomerByID
    @CustomerID int
as
begin
    select 
        FirstName,
        LastName,
        EmailAddress
    from SalesLT.Customer
    where CustomerID = @CustomerID;
end
exec GetCustomerByID @CustomerID = 1;


--Kuupäevavahemik – GetOrdersByDateRange
--Eesmärk: Tagastab tellimused, mis jäävad etteantud kuupäevavahemikku.

create procedure GetOrdersByDateRange
    @StartDate date,
    @EndDate date
as
begin
    select *
    from SalesLT.SalesOrderHeader
    where OrderDate BETWEEN @StartDate AND @EndDate;
end
exec GetOrdersByDateRange 
    @StartDate = '2008-01-01', 
    @EndDate = '2008-12-31';

--INSERT protseduur – AddNewProduct
--Eesmärk: Lisab uue toote andmebaasi.

create procedure AddNewProduct
    @Name nvarchar(50),
    @ProductNumber nvarchar(25),
    @ListPrice money
as
BEGIN
    insert into SalesLT.Product 
        (Name, ProductNumber, ListPrice, StandardCost, SellStartDate)
    values 
        (@Name, @ProductNumber, @ListPrice, @ListPrice * 0.6, GETDATE());
end
exec AddNewProduct 
    @Name = 'TestToode', 
    @ProductNumber = 'TEST-001', 
    @ListPrice = 299.99;
--StandardCost on arvutatud automaatselt 60% ListPrice-ist – saad seda muuta vastavalt vajadusele.

--5. UPDATE protseduur – UpdateProductPrice
--Eesmärk: Uuendab olemasoleva toote hinda.


create procedure UpdateProductPrice
    @ProductID int,
    @NewPrice money
as
begin
    update SalesLT.Product
    set ListPrice = @NewPrice
    where ProductID = @ProductID;
end

exec UpdateProductPrice 
    @ProductID = 680, 
    @NewPrice = 499.99;
--6. DELETE kontrolliga – DeleteCustomer
--Eesmärk: Kustutab kliendi ainult siis, kui tal pole ühtegi tellimust.


create procedure DeleteCustomer
    @CustomerID int
as
begin
    -- Kontrollime, kas kliendil on tellimusi
    if EXISTS (
        select 1 
        from SalesLT.SalesOrderHeader 
        Where CustomerID = @CustomerID
    )
    begin
        print 'Klienti ei saa kustutada – tal on aktiivseid tellimusi!';
    end
    else
    begin
        delete from SalesLT.Customer
        where CustomerID = @CustomerID;

        print 'Klient edukalt kustutatud.';
    end
end

exec DeleteCustomer @CustomerID = 1;

--OUTPUT parameeter – GetOrderCountByCustomer
--Eesmärk: Tagastab OUTPUT parameetri kaudu kliendi tellimuste arvu.


create procedure GetOrderCountByCustomer
    @CustomerID int,
    @OrderCount int output
as
begin
    select @OrderCount = COUNT(*)
    from SalesLT.SalesOrderHeader
    where CustomerID = @CustomerID;
end
declare @Count int

exec GetOrderCountByCustomer 
    @CustomerID = 29722, 
    @OrderCount = @Count output

print 'Tellimuste arv: ' + cast(@Count as varchar);
--IF tingimus – CheckProductPriceLevel
--Eesmärk: Hindab toote hinnataset ja väljastab vastava sõnumi.


create procedure CheckProductPriceLevel
    @ProductID int
as
begin
    declare @Price money;
    declare @ProductName nvarchar(50);

    -- Võtame toote hinna ja nime
    select 
        @Price = ListPrice,
        @ProductName = Name
    from SalesLT.Product
    where ProductID = @ProductID;

    -- Kontrollime, kas toode eksisteerib
    if @Price IS NULL
    begin
        print 'Toodet ei leitud!';
        return
    end

    -- Hinnataseme kontroll
    if @Price > 1000  
        print @ProductName + ' – hind ' + CAST(@Price as varchar) + ' → Kallis';
    else if @Price >= 100
        print @ProductName + ' – hind ' + CAST(@Price as varchar) + ' → Keskmine';
    else
        print @ProductName + ' – hind ' + CAST(@Price as varchar) + ' → Soodne';
end

exec CheckProductPriceLevel @ProductID = 680;   -- Kallis
exec CheckProductPriceLevel @ProductID = 712;   -- Keskmine