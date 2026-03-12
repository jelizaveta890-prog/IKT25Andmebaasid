          --Tund nr 1  11.02.2026--
------------------------------------------------
-- teeme andmebaasid e db
create database IKT25tar


--andmebaasi valimine
use IKT25tar

--andmebaasi kustutamine koodiga
drop database IKT25tar

--teeme uuesti andmebaasi IKT25tar
create database IKT25tar

--teeme tabeli
create table Gender 
(
--Meil on muutuja Id,
--mis on täisarv andmetüüp,
--kui sisestad andmed,
--siis see veerg peab olema täidetud,
--tegemist on primaarvõtmega
Id int not null primary key,
--veeru nimi on Gender,
--10 tähemärki on max pikkus,
--andmed peavad olema sisestatud e
--ei tohi olla tühi
Gender nvarchar(10) not null
)

--andmete sisestamine
--Id = 1, Gender = Male 
--Id = 2, Gender = Famele 
insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Famele')

--vaatame tabeli sisu 
--* tähendab, et näita kõik seal sees olevat infot
select * from Gender 

--teeme tabeli nimega person 
--veeru nimed: Id int not null primary key,
--Name nvarchar (30)
--Email nvarchar (30)
--GenderId int 

create table person 
(
    Id int NOT NULL primary key,
    Name nvarchar(30),
    Email nvarchar(30),
    GenderId int
)
          --Tund nr 2  18.02.2026--
------------------------------------------------
insert into person  (Id, Name, Email, GenderId)
values (1,'Superman', 's@s.com', 2),
(2,'Wonderwoman', 'w@w.com', 1),
(3,'Batman', 'b@b.com', 2),
(4,'Aquman', 'a@a.com', 2),
(5,'Catwoman', 'c@c.com', 1),
(6,'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

--näen tabelis olevat infot 
select * from person

--võõrvõtme ühendus loomine kahe tabeli vahel 
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla
--väärtust, siis automaalselt sisestab  sellele reale väärtuse 3
--e unknown
alter table Person 
add constraint DF_Person_GenderId
default 3 for GenderId

insert into Gender (Id, Gender)
values (3, 'Unknow')

insert into person (Id, Name ,Email, GenderId)
values (7, 'Black Panther', 'b@b.com', NULL)

insert into person (Id, Name ,Email)
values (11, 'Spiderman3', 'spider@man.com')

select * from Person

--piirangu kustutamine
alter table Person 
drop constraint DF_Person_GenderId 

--kuidas lisada veergu tabelile Person 
--veeru nimi on Age nvarchar(10)
alter table Person 
add Age nvarchar(10)

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kuidas uuendada andmeid
update Person
set Age = 159
where Id = 7

select * from Person

--soovin kustutada ühe rea 
--kuidas seda teha???
delete from Person where Id = 8 and Id =  9 and Id = 10 

select * from Person

--lisame uue veeru City nvarchar(50)
alter table Person 
add City nvarchar(50)

--kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik,kes ei ela Gothamis
select * from Person where City != 'Gotham'
--variant nr 2. kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'

--näitab teatud vanusega inimesi 
--valime 151, 35, 26
--Versioon 1
select * from Person Where Age in (151, 35, 26)
--Versioon 2
select * from Person Where Age = 151 or Age = 35 or Age = 26

--soovin näha inimesi vahemikus 22 kuni 41
--Versioon 1
select * from Person Where Age between 22 and 41
--Versioon 2
select * from Person where Age >= 22 and  Age <= 41

--Wildcard e näitab kõik g-tähega linnad
select * from Person Where City like 'G%'
--otsib emailid @-märgiga
select * from Person Where Email like '%@%'

--tahan näha, kellel on emailis ees ja peale @-märki üks täht
select * from Person Where Email like '%_@_.%'

--kõik, kellel nimes ei ole esimene täht W, A, S
--Versioon 1
select * from Person Where Name like '[^WAS]%'

--Versioon 2
select * from Person Where Name not like 'W%'
and Name not like 'A%'
and Name not like 'S%'

--kõik, kes elavad Gothamis ja New Yorkis
--Versioon 1
select * from Person where (City = 'Gotham'or City = 'New York')
--Versioon 2
select * from Person where City in ('Gotham', 'New York')

--kõik, kes elavad Gothamis ja New Yorkis ning peavad olema 
--vanema, kui 29
select * from Person where (City = 'Gotham'or City = 'New York')
and (Age > 29)

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks 
--Name veeru 
select * from Person
select * from Person order by Name 

--võtab olm esimest rida Person tabelist
select top 3 * from Person 

          --Tund nr 3  25.02.2026--
------------------------------------------------

--kolm esimest, aga tabeli järjestus on Age ja siis Name
select top 3 Age, Name from Person

--näita esimesed 50% tabelist 
select top 3 Age, Name from Person

select top 50 PERCENT * from Person

--järjestab vanuse järgi isikud

--muudab Age muutuja int-ks ja näitab vanulises järjestuses 
--cast abil saab andmetüüpi muuta 
select * from Person order by cast (Age as int )desc


--aga kõikide isikute koondvanus e liidab kõik kokku
select sum(cast(Age as int))as KoondVanus from Person 
-- "as KoondVanus" annab nimetuse 

--kõige noorem isik tuleb üles leida
select min(cast(Age as int)) from Person 

--kõige vanem isik tuleb üles leida
select max(cast(Age as int)) from Person 

--muudame Age muutuja int peale 
--näeme konkreetse linnades olevate isikute koondvanust
select City, sum(Age)as TotalAge from Person group by City


--kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

--kuvab esimeses reas välja toodud järjestuses ja kuvab Age-i
--TotalAge-ks 
--järjest City-s olevate nimed järgi ja siis Genderid järgi
--kasutada group by-d ja order gy-d
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by GenderId;

--näitab, et mitu rida andmeid on selles tabelis 
select count(*) from Person
--näitab tulemust mitu inimest on Genderid väärtusega 2
--konkreetses linnas
--arvutab kokku selles linnas 
select GenderId, City, sum(Age) as TotalAge, count(Id) as 
[Total person(s)] from person
Where GenderId = '2'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 a ja 
--kui palju neid igas linnas elab 
--eristab inimese soo ära
select GenderId, City, sum(Age) as TotalAge, count(Id) as 
[Total person(s)] from person
Where GenderId = '1'
group by GenderId, City having SUM(Age) > 41

--loome tabelid Employees ja Drpartment
create table Department 
(
Id int primary key, 
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50),
)

create table Employees
(
Id int primary key, 
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male',4000, 1),
(2, 'Pam', 'Female',3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male',2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female',4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male',6500, NULL),
(10, 'Russell', 'Male',8800, NULL)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
Values(1, 'IT', 'London','Rick'),
(2, 'Payroll', 'Delhi','Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Syndey', 'Cindrella')

select *from  Department
select *from  Employees 

---

select Name, Gender, Salary, DepartmentName
from Employees 
left join Department
on Employees.DepartmentId = Department.Id
---

--arvutab kõikide palgad kokku Emloyees tabelist
select sum(cast(salary as int))from Employees--arvutab kõikide palgad kokku 
--kõige väiksem palga saaja 
select min(cast(salary as int))from Employees
--näitab veerge Location ja Palka.Palga veerg kuvatakse TotalSalary-ks
--teha left join Department tabeliga
--grupitab Locationiga
select Location,sum(cast(salary as int)) as TotalSalary
from Employees 
left join Department
on Employees.DepartmentId = Department.Id
group by Location
          
		  --Tund nr 4  03.03.2026--
------------------------------------------------

select * from Employees
select sum(cast(Salary as int))from Employees --arvutab kõikide palgad kokku

--Lisame veeru City pikkus on 30  
alter table Employees 
add City nvarchar(30)

select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender

--peaaegu sama päring, aga linnad on tähestikulises järjrstuses
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

select * from Employees 
--on vaja teada, et mitu inimest on nimekirjas 
select count(*) from Employees 

--mitu töötajat on soo ja linna kaupa töötamas 
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City 

--kuvab ka snaised või mehed linnade kaupa 
--kasutage where
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Female'
group by Gender, City 

--sama tulemus nagu eelmine kord, aga kasutage: having
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City 
having Gender = 'Female'

--kõik, kes teenuivad rohkem, kui 4000
select * from Employees where sum(cast(salary as it)) > 4000

--teeme variandi, kus saame tulemuse
--variant 1
select * from Employees where salary >= 4000
--variant 2
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City 
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt numerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
insert into Test1 values ('x')
select * from Test1

          --Tund nr 5  04.03.2026--
------------------------------------------------

--kustutame veeru nimega City Employees tabelist
alter table Employees
drop column City


--inner join 
--kuvab neid, kellel on DepartmentName all olemas väärtus 
--mitte kattuvad read eemaldatakse tulemusest 
--ja sellepärast ei näita Jamesi ja Russelit tabelis
--kuna neil on DepartmentId NULL 
select Name, Gender, Salary, DepartmentName
from Employees  
inner join Department
on Employees.DepartmentId = Department.Id

--left join 
select Name, Gender, Salary, DepartmentName
from Employees 
left join Department--võib kasutada LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id
--uurige mis on left join 

--näitab andmeid, kus vasakpoolsest tabelist isegi, siis kui seal puusub
--võõrvõtme reas väärtus

--right join
select Name, Gender, Salary, DepartmentName
from Employees  
right join Department --võib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id
--right join näitab paremas tabelis olevaisd väärtuseid 
--mis ei ühti vasaku (Employees) tabeliga 

--outer join 
select Name, Gender, Salary, DepartmentName
from Employees  
outer join Department 
on Employees.DepartmentId = Department.Id
--mõlema tabeli read kuvab 

--teha cross join
select Name, Gender, Salary, DepartmentName 
from Employees
cross join Department
--korrutab kõik omavahel läbi 

--teha left join, kus Employees tabelist Department on null
select Name, Gender, Salary, DepartmentName
from Employees  
left join Department 
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--teine variant ja sama tulemus
select Name, Gender, Salary, DepartmentName
from Employees  
left join Department 
on Employees.DepartmentId = Department.Id
where Department.Id is null
--näitab aniult neid kellel on vasakus tabelis (Employees)
--DepartmentId null 

select Name, Gender, Salary, DepartmentName
from Employees  
right join Department 
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
--nätab ainult paremst tabelis olevat rida, 
--mis ei kattu  Employees-ga.

--full join 
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja 
select Name, Gender, Salary, DepartmentName
from Employees  
full join Department 
on Employees.DepartmentId = Department.Id
where Department.Id is null
or Department.Id is null

--teete AndventureWorksLT20019 andmebaasile join päringuid:
--inner join, left join, right join, cross join ja full join 
--tabeleid sellese andmebaasi juurde ei tohi teha

--Mõnikord peab muutuja ette kirjutama tabeli nimetuse nagu on Product.Name,
--et editor saak aru, et kuma tabeli muutuja soovitakse kasutada ja ei tekiks
--segadust 
select Product.Name, ProductNumber,ListPrice,
ProductModel.Name as [Product Model Name], 
Product.ProductModelId, ProductModel.ProductModeId
--mõnikord peab ka tabeli ette kirjuama täpsustava info 
--nagu on SelesLt.Product
from SalesLt.Product
inner join SalesLt.ProductModel
--antud juhul Producti tabelis ProductModelId võõrvõti,
--mis productModeli tabelis on primaarvõtti
on Product.ProductModelId = PRODUCTModel.productModelId


--inner join--
------------------
select p.Name AS ProductName, pc.Name AS CategoryName
from SalesLT.Product p
inner join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--left join--
------------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
left join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--right join--
-----------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
right join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--full join--
-----------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
full join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--cross join--
-----------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
cross join SalesLT.ProductCategory pc

          --Tund nr 6  12.03.2026--
------------------------------------------------
--isnull funksiooni kasutamine
select isnull ('Ingvar', 'No Manager')as Manager

--Null asemel kuvab No Meneger
select coalesce(NULL, 'No Manager')as Manager

alter table Employees
add ManagerId int

--neile, kellel ei ole ülamust, siis paneb neile No Manager teksti
--kasutage left joini
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--kasutame inner joinid 
--kuvab ainult Manager all olevate isikute väärtuseid 
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--kõik saavd kõikide ülemused olla 
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

--lisame Employees tabelise uued veerud 
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName Nvarchar(30)

--muudame olemasoleva veeru nimetust
sp_rename 'Employees.Name', 'FristName'

UPDATE Employees
SET FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
WHERE Id = 1;

UPDATE Employees
SET FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
WHERE Id = 2;

UPDATE Employees
SET FirstName = 'John', MiddleName = NULL, LastName = NULL
WHERE Id = 3;

UPDATE Employees
SET FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
WHERE Id = 4;

UPDATE Employees
SET FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
WHERE Id = 5;

UPDATE Employees
SET FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
WHERE Id = 6;

UPDATE Employees
SET FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
WHERE Id = 7;

UPDATE Employees
SET FirstName = 'Valarine', MiddleName = 'Balerine', LastName = NULL
WHERE Id = 8;

UPDATE Employees
SET FirstName = 'James', MiddleName = '007', LastName = 'Bond'
WHERE Id = 9;

UPDATE Employees
SET FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
WHERE Id = 10;

--igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
--coalesce
select * from Employees 
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

--loome kaks tabelit 
create table IndianCustomers
(
 Id int identity,
 Name nvarchar(25),
 Email nvarchar(25),
)
create table UKCustomers
(
 Id int identity(1,1),
 Name nvarchar(25),
 Email nvarchar(25),
)

--sisestame tabelisse andmeid 
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, mis täitab kõik ridu 
--union all ühendab tabelit ja näitab sisu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate väärtustega read pannakse ühte ja ei korrta
select Id, Name, Email from IndianCustomers
union 
select Id, Name, Email from UKCustomers

--kasutada union all, aga sorteerida nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name


--stored procedure
--tavaliselt pannkse nimetuse ette sp, mis tähendab stored procedure
create procedure spGetEmployees
as begin
select FirstName, Gender from Employees
end

--nüüd saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
--@ - tähendab muutujat
@Gender nvarchar (20),
@DepartmentId int
as begin
select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
and DepartmentId = @DepartmentId
end

--kui nüüd allolevate käsklust käima panna, siis nõuab gender parameetri 
spGetEmployeesByGenderAndDepartment

--õige variant
spGetEmployeesByGenderAndDepartment 'Female', 1

--niimodi saab sp kirja pandud järjekorras mööda minna, kui ise pened muutuja paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab vaadata sp sisu result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja panna sinna välja peale, et keegi teine peale teie ei saaks muuta
--kuskile tuleb lisada with encryption

alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar (20),
@DepartmentId int
with encryption
as begin
select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
and DepartmentId = @DepartmentId
end

--sp tegemine
create proc spGetEmployeesByGender
create proc spGetEmployeesByGender
@Gender nvarchar (20),
@EmployeeCount int output
as begin 
select @EmployeeCount = count(Id) from Employees where Gender = @Gender
  end
 --annab tulemuse, kus loendab ära nõuetele vastavad read 
 --prindib ka tulemuse kirja teel 
 --tuleb teha declare muutuja @TotalCount, mis on int
 declare @TotalCount int
 --execute spGetEmployeeCountByGender sp, kus on parameetrid Male ja TotalCount 
 execute spGetEmployeesByGender 'Male', @TotalCount out
 --if ja else, kui TotalCount = 0, siis tuleb tekst TotalCount is null
 if(@TotalCount = 0)
    print '@TotalCount is null'
 else 
    print '@TotalCount is not null'
print @TotalCount
 --plus kasuta printi @TotalCount puhul
