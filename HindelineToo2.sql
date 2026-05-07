-- Hindeline töö2 --

--1.Leian mitu klienti on tabelis Customer
--(Kasutan Count)
select count(*) from SalesLT.Customer

--2.Leian tellimuste kogu arv tabelis SalesOrderHeader
--(Kasutan COUNT_BIG)
Select count_big (*) from SalesLT.SalesOrderHeader

--3.Leian suurim tellimuse summa (TotalDue)
--(Kasutan MAX)
select max(cast(TotalDue as int)) from SalesLT.SalesOrderHeader

--4.Leian väikseim tellimuse summa (TotalDue)
--(Kasutan MIN)
select min(cast(TotalDue as int)) from SalesLT.SalesOrderHeader

--5.Leian kõigi tellimuste summa (TotalDue)
--(Kasutan SUM)
select sum(cast(TotalDue as int)) from SalesLT.SalesOrderHeader

--6.Leian mitu tooted on tabelis Product, mille hind (ListPrice) on 
--suurem kui 100.
select count (*) from SalesLT.Product where ListPrice > 100

--7.Leian kõige kallima (ListPrice),mille hind on 
--väiksem kui 1000 (Kasutan MAX + WHERE) 
select max(cast(ListPrice as int))from SalesLT.Product where ListPrice < 1000

--8.Leian kõige odavama toode (ListPrice),mille hind on 
--suurem kui 0 (Kasutan MIN + WHERE)
select min(cast(ListPrice as int))from SalesLT.Product where ListPrice > 0

--9.Leian kõikide toodete koguhind (ListPrice), mille värv (Color) ei 
--ole NULL.(Kasutan SUM + WHERE)
select sum(cast(ListPrice as int))from SalesLT.Product where Color is not null


--10.Leian mitu klienti on liitunud pärast aastat 2010 (ModifiedDate)
 select count (*) as klientideArv from SalesLT.Customer where ModifiedDate >= '2010'
 
--11.Leian kõige varasem muutuse (ModifiedDate) SalesOrderDetail
--seast, kus on tehtud muutus enne 2009a.(Kautan MIN + WHERE)
select MIN(ModifiedDate) as VarasemMuutus from SalesLT.SalesOrderDetail
where ModifiedDate <= '2009'

--12.Leian tellimuste kogusumma (TotalDue) iga kliendi kohta.
--(Kautan SUM + GROUB BY CustomerID)
select CustomerId, sum(TotalDue) as kogusumma from SalesLT.SalesOrderHeader
group by CustomerId

--13.Leian iga kliendi tellimuste arv.
--(Kasutan Customer + SalesOrderHeader + ProductCategory, kasutan Count ja ORDER BY)

select CustomerId,
count(s.SalesOrderId) as TellimusteArv
from SalesLT.Customer
join soh.SalesOrderId
on c.CustomerId = soh.CustomerId
group by cast.CustomerId

--14.Leian iga tootekategootia toodete arv 
select CustomerId, 
from 
(
  select SalesLT.Customer count(s.SalesOrderId) as TellimusteArv
  join soh.SalesOrderId
  on c.CustomerId = soh.CustomerId
  group by CustomerId
)


--tehke päring, kus on kaks CTE päringut sees
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
    select DepartmentName, count(Employee.Id) as TotalEmployees
    from Employee
    join Department
    on Employee.DepartmentId = Department.Id
    where DepartmentName in ('Payroll', 'IT')
    group by DepartmentName
),
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
    select DepartmentName, count(Employee.Id) as TotalEmployees
    from Employee
    join Department
    on Employee.DepartmentId = Department.Id
    group by DepartmentName
)
select Name 
count (ProductId) as
from Product
join ProductSubcategory  

--15.Leian iag kliendi tellimuste kogusumma (TotalDue), kuid 
--näita ainult neid kellel on kogu summa üle 10000.
select CustomerId,
sum(TotalDue) as kogusumma
from SalesLT.SalesOrderHeader
group by CustomerId
having sum(TotalDue) > 10000
