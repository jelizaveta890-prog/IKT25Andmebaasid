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
 execute spGetEmployeesCountByGender 'Male', @TotalCount out
 --if ja else, kui TotalCount = 0, siis tuleb tekst TotalCount is null
 if(@TotalCount = 0)
    print '@TotalCount is null'
 else 
    print '@TotalCount is not null'
print @TotalCount
 --plus kasuta printi @TotalCount puhul

           --Tund nr 7  17.03.2026--
------------------------------------------------

--näitab ära, mitu rida vastab nõuetele 

--deklareerime muutuja @TotalCount, mis on int andmetüüp
declare @TotalCount int
--käivitame stored procedure spGetEmployeesCountByGender, kus on parameetrid
--@EmployeeCount = @TotalCount out ja @Gender
execute spGetEmployeesCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
--prindib konsooli välja, kui TotalCount on null või mitte null
print @TotalCount

--sp sisu vaatamine 
sp_help spGetEmployeesCountByGender
--tabeli info vaatamine 
sp_help Employees
--kui soovid sp teksti näha 
sp_helptext spGetEmployeesCountByGender

--vaatame, millest sõltub meie valitud sp
sp_depends spGetEmployeesCountByGender
--näitab, et sp sõltub Employees tabelist, kuna seal on count(Id)
--ja Id on Employees tabelis 

--vaatame tabelit 
sp_depends Employees

--teeme sp, mis annab andmeid Id ja Name veergude kohta Employees tabelis
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
select @Id = Id, @Name = FirstName from Employees
end

--annab kogu tabeli ridade arvu 
create proc spTotalCount2
@TotalCount int output
as begin 
select @TotalCount = count(Id) from Employees
end

--on vaja teha uus  päring, kus kasutame spTotalCount2 sp-d,
--et saada tabeli ridade arv

--tuleb deklareedida muutuja @TotalCount, mis on int andmetüüp
declare @TotalEmployees int
--tuleb execute spTotalCount2, kus on parameeter @TotalCount = @TotalCount out
exec spTotalCount2 @TotalEmployees out
select @TotalEmployees

--mis Id all on keegi nime järgi 
create proc spGetNameById1
@Id int,
@FirstName nvarchar(20) output
as begin 
select @FirstName =FirstName from Employees where Id = @Id
end
--annab tulemuse, kus id 1(seda numbrit saab muuta) real on keegi
--printi tuleb kasutada, et näidata tulemust
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName output
print 'Name of the employee = ' + @FirstName

--tehke sama, mis eelmine aga kasutage spGetNameById sp-d
--FirstName lõpus on out
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName out
print 'Name = ' + @FirstName

--output tagastab muudetud read kohe päringu tulemusena 
--see on salvestatud protseduuris ja ühe väärtuse tagastamine
--out ei anna mitte midagi, kui seda ei määra execute käsus

          --Tund nr 8  19.03.2026--
------------------------------------------------

sp_help spGetNameById

create proc spGetNameById2
@Id int 
--kui on begin, siis on ka end kuskil olemas 
as begin 
return (select FirstName From Employees Where Id = @Id)
end

--tuleb veatedae kuna kutsusime välja int-i, aga Tom on nvarchar
declare @EmploteeName nvarchar(50)
execute @EmploteeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

--sisseehitatud string funktsioonid 
--see konverteerib ASCII tähe väärtuse numbriks
select ASCII('A')

select char(65)

--prindime kogu tähestiku välja 
declare @Start int
set @Start = 97
--ksutate while, et näidata kogu tähestiku ette 
while (@Start <= 122)
begin
select char (@Start)
set @Start = @Start + 1
end

--eemaldame tühjad kohad sulgudes
select ('        Hello')
select LTRIM('        Hello')

--tühikute eemaldamine veerust, mis on tabelis 

select FirstName, MiddleName, LastName from Employees
--eemaldage tühikud FirstName veerust ära
select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

--parema poolt tühjad stringid lüikab ära 
select RTRIM('    Hello     ')


--keerab klooni sees olevad andmed vastupidiseks 
--vastavalt lower-ga ja upper-ga muuta märkide suurust
--reverse funktsioon pöörab kõik ümber
select reverse(upper(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName), 
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees


--left, right, substring
--vasakul poolt neli esimest tähte 
select LEFT('ABCDEF', 4)
--paremalt poolt kolm tähte
select right('ABCDEF', 3)

--kuvab @-tähtemärgi asetuste mitmes on @_ märk
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr pele komakohta näitab et miotmendas alustab ja 
--siis mitu nr peale seda kuvada 
select SUBSTRING('pam@bbb.com',5 , 2)

--@-märgist kuvab kolm tähe märki.Viimas numbri saab määrata pikkust
select SUBSTRING('pam@bb.com', CHARINDEX('@', 'pam@bb.com') + 1, 3)

--pele @- märki hakkab kuvama tulemust, nr saab kaugust seadistada 
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bb.com') + 5,
LEN('pam@bb.com') - CHARINDEX('@', 'pam@bbb.com'))

alter table Employees 
add Email nvarchar(20)

select * from Employees

update Employees set Email = 'tom@aaa.com' where Id = 1;
update Employees set Email = 'pam@bbb.com' where Id = 2;
update Employees set Email = 'john@aaa.com' where Id = 3;
update Employees set Email = 'sam@bbb.com' where Id = 4;
update Employees set Email = 'todd@bbb.com' where Id = 5;
update Employees set Email = 'ben@ccc.com' where Id = 6;
update Employees set Email = 'sara@ccc.com' where Id = 7;
update Employees set Email = 'valarie@aaa.com' where Id = 8;
update Employees set Email = 'james@bbb.com' where Id = 9;
update Employees set Email = 'russell@bbb.com' where Id = 10;

--soovime teade saada domeeninimesid emailides
select SUBSTRING (Email, charindex('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

--alates teisest tähest emailis kuni @ märgini on tärnid
select FirstName, LastName,
substring(Email, 1, 2) + replicate('*', 5 ) +
substring(Email, charindex('@', Email), len(Email) - charindex('@', Email)+1) as Email
from Employees

--kolm korda näitab stringis olevat väärtust
select REPLACE('asd', 3)

--tühiku sisestamine
select space(5)

--tühiku sisestamine Firstname ja LastName vahele
select FirstName + SPACE(25) + LastName  as FullName
from Employees

--PATINDEX
--sama, mis charindex, aga dünaamiliselt kasuta wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOcurence
from Employees 
where PATINDEX('%@aaa.com', Email) > 0
--leian kõik selle domeeni esindaja alates mitmendas märgist algab @


--kõik .com emailid asendab .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees


--soovin asendada peale sesimest märki kolm tähte viie täringa
select FirstName, LastName, Email,
 stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

create table DateTime 
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset, 
)

select * from DateTime

--konkreetse masina kellaaega 
select getdate(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

select * from DateTime                 

update DateTime set c_datetimeoffset = '2026-03-19 14:25:48.6266667 +10:00'
where c_datetimeoffset = '2026-03-19 14:25:48.6266667 +00:00'


select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP'--AJA PÄRING
select SYSDATETIME(), 'SYSDATETIME'--veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET'--täpne aeg koos ajalise nihkega 
select GETUTCDATE(), 'GETUTCDATE'--UCT aeg

--saab kontrollida, kas on õige andmetüüp
select isdate('asd')--tagastab 0 kuna string ei ole date
select isdate(getdate()) --kuidas saada vastuseks 1 isdate puhul?
select  isdate('2026-03-19 14:25:48.6266667')--tagastab 0 kuna max kolm komakohta võib olla 
select  isdate('2026-03-19 14:25:48.626')--tagastab 1
select DAY(getdate())--annab tänas epäeva nr
select DAY('01/24/2026')--annab stringis oleva kp ja järjestus ja olema õige
select MONTH(GETDATE()) --annab tänase kuu nr
select MONTH('01/24/2026')--annab stringis oleva kuu ja järjestus peab olema õige
select year(GETDATE()) --annab tänase aasta nr
select year('01/24/2026')--annab stringis oleva aasta ja järjestus peab olema õige

select DATENAME(DAY, '2026-03-19 14:26:02.983') --annab stringis oleva päeva nr
select DATENAME(Month, '2026-03-19 14:26:02.983') --annab stringis oleva kuu nr
select DATENAME(WEEKDAY, '2026-03-19 14:26:02.983') --annab stringis oleva nädala nr

create table EmployeeWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (1, 'Sam', '1999-01-10 15:56:02.983');
insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (2, 'Ken', '2000-02-21 10:16:02.983');
insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (3, 'Andrew', '2010-01-26 02:26:02.983');
insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (4, 'Katy', '2007-08-20 09:35:02.983')

select * from EmployeeWithDates

          --Tund nr 9  24.03.2026--
------------------------------------------------

--kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud 

--vaatab DoB veerust päeva ja kuvab päeva nimetuse sõnana
select Name, DateOfBirth, Datename(weekday, DateOfBirth) as [Day], 
 --vaatab VoB veerust kuupäevasi ja kuvab kuu nr
 Month(DateOfBirth) as MonthNumber,
 --vaatab DoB veerust kuud ja kuvab sõnana
 DateName(Month, DateOfBirth) as [MonthName],
 --võtab DoB veerust aasta
 Year(DateOfBirth) as [Year]
 from EmployeeWithDates

 --kuvab 3 kuna USA nädal algab pühapäevaga 
 select Datepart(weekday, '2026-03-24 09:35:02.983')
 --tehke sama aga, kasutame kuu-d
 select Datepart(month, '2026-03-24 09:35:02.983')
 --liidab stringis oleva kp 20 päeva juurde
 select Dateadd(day, 20, '2026-03-24 09:35:02.983')
 --lahutab 20 päeva maha 
 select Dateadd(day, -20, '2026-03-24 09:35:02.983')
 --kuvab kahe stringis oleva kuudevahelist aega nr-na
 select datediff(month, '11/20/2026', '01/20/2024')
 --tehke sama, aga kasutage aastat
 select datediff(year, '11/20/2026', '01/20/2028')

 --alguse uurigte, mis on funktsioon MS SQL 
 --eelkirjutatud toimingud,salvestatud tegevus,andmebaasis salvestatud alamprogramm.

 --miks seda on vaja 
 --pakkuda DB-s korduvkasutatud funktsionaalsus, korduvate arvutuste lihtsustamiseks.
 
 --mis on selle eelised ja puudused
--saada kiiresti kasutada toiminguid ja ei pea uuesti koodi kirjutama 
--Funktsioonid ei tohi muuta andmebaasi olekut

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
    declare @tempdate datetime, @years int, @months int, @days int
select @tempdate = @DOB

select @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - case when (month(@DOB)>
MONTH(GETDATE())) or (MONTH(@DOB) = MONTH(GETDATE())and day(@DOB) > DAY(GETDATE()))
then 1 else 0 end
select @tempdate = DATEADD(YEAR, @years, @tempdate)

select @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - case when DAY(@DOB) >
DAY(getdate()) then 1 else 0 end
select @tempdate = DATEADD(MONTH, @months, @tempdate)

select @days = datediff(day, @tempdate, GETDATE())

declare @Age nvarchar(50)
   set @Age = CAST (@years as nvarchar(4)) + 'Years' + CAST(@months as nvarchar(2))
+ 'Months' + CAST (@days as nvarchar(2)) + 'Days old'
    return @Age
end

select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth)
as Age from EmployeeWithDates  

		  --Tund nr 10  31.03.2026--
------------------------------------------------
--kui kasutame seda funktsiooni, siis saame teada tänase päeva vahet stringis välja tooduga
select dbo.fnComputeAge('02/24/2010') as age

--nn peale DOB muutuja näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 108) as ConvertedDOB
from EmployeeWithDates  

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeeWithDates  

select cast(getdate() as date) --tänane kuupäev

--tänane kuupäev, aga kasutate convert-i, et kuvada stringina 
select convert(date, getdate()) as TänaneKuupäev

--matemaatilised funktsioonid
select ABS(-5) --abs on absoluutväärtusega number ja tulemuseks saame ilma miinus märgita 5
select ceiling(4.2)--ceiling on funktsioon, mis ümardab ülespoole ja tulemuseks saame 5
select ceiling(-4.2)--ceiling ümardab ka miinus numbri ülespoole, mis tähendab, et saame -4 
select floor(15.2) --floor on funktsioon, mis ümbritseb alla ja tulemuseks saame 15
select floor(-15.2)--floor ümardab ka miinus numbri alla, mis tähendab, et saame -16
select power(2, 4) --kaks astems neli
select square(9) --antud juhul üheksa ruudus
select sqrt(16) --antud juhul 16 ruutjuur


select rand() --rand on funktsioon, mis genereerib
--juhusliku numbri vahemikus 0 kuni 1

--kuidas saada täisnumber iga kord
select floor(rand() * 100) --korrutab sajaga iga suvalist numbrit

--iga kord näitab 10 suvalist numbrid
declare @counter int = 1
set @counter = 1
while (@counter <= 10)
begin
    print floor(rand() * 100)
    set @counter = @counter + 1
end

select round(850.556, 2) 
--round on funktsioon, mis ümardab kaks komakohta 
--ja tulemuseks saame 850.56
select round(850.556, 2, 1) 
--round on funktsioon, mis ümardab kaks komakohta ja 
--kui kolmas parameeter on 1, siis ümardab alla
select round(850.556, 1) 
--round on funktsioon, mis ümardab ühe komakoha ja 
--tulemuseks saame 850.6
select round(850.556, 1, 1) --ümardab alla ühe komakoha pealt
--ja tulemuseks saame 850.5
select round(850.556, -2) --ümardab täisnumber ülesepoole ja tulemus 900
select round(850.556, -1) --ümardab täisnumber alla ja tulemus on 850


---
create function dbo.CalculateAge(@DOB date)
returns int
as begin 
declare @Age int 

    set @Age = datediff(year, @DOB, getdate()) -
	case
	 when (month(@DOB) > month(getdate())) or
	      (month(@DOB) > month(getdate()) and day(@DOB) > day(getdate()))
		  then 1 else 0 end
  return @Age
end

--kui valmis, siis proovige seda funktsiooni 
--ja vaadake, kas annab õige vanuse
exec dbo.CalculateAge '1980-12-30'

--arvutab välja, kui vana on isik ja võtab arvesse kuud ning päevad
--antud juhul näitab kõike, kes on üle 36 a vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeeWithDates
where dbo.CalculateAge(DateOfBirth) < 36

		  --Tund nr 11  02.04.2026--
------------------------------------------------

--- inline table valued function
alter table EmployeeWithDates
add DepartmentId int 
alter table EmployeeWithDates
add Gender nvarchar(10)

select * from EmployeeWithDates

update EmployeeWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeeWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeeWithDates set Gender = 'Male', DepartmentId = 3
where Id = 3
update EmployeeWithDates set Gender = 'Female', DepartmentId = 1
where Id = 4
insert into EmployeeWithDates  (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-08-20 09:35:02.983', 1, 'Male')

--scalar function annab mingis vahemikus andmeid,
--inline table values ei kasuta begin ja end funktsioone
--scalar annab väärtused ja inline annab tabeli
create function fn_EmployeeByGender(@Gender nvarchar(10))
returns table 
as 
return (select Id ,Name, DateOfBirth, DepartmentId, Gender
        From EmployeeWithDates
		where Gender = @Gender)

--kuidas leida kõik naised tabelis EmployeeWithDates
-- ja kasutada funktsiooni fn_EmployeeByGender

select * from fn_EmployeeByGender('Female')

--tahaks ainult Pami nime näha
select * from fn_EmployeeByGender('Female') 
where Name = 'Pam'

select * from Department

--kahest erinevates tabelis andmete võtmine ja 
--koos kuvamine 
--esimene on funktsioon ja teine tabel

select Name, Gender, DepartmentName
from fn_EmployeeByGender('Male') E
join Department D on D.Id = E.DepartmentId

--multi tabel statement 
--inline funktsioon
create function fn_GetEmployees()
returns table as 
return(select Id, Name, cast(DateOfBirth as date)
       as DOB 
       from EmployeeWithDates)

select * from fn_GetEmployees()

--multi - state puhul peab defineerima uue tabeli veerud koos muutujatega
--funktsiooni nimi on fn_MS_GetEmployees()
--peab edastama meile Id, Name, DOB tabelis EmployeeWithDates

create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
    insert into @Table
    select Id, Name, cast(DateOfBirth as date) from EmployeeWithDates
    return
end
select * from fn_MS_GetEmployees()

--inline tabeli funktsioonid on paremini täätamas kuna käsitletakse vaatena
--multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

--muudame andmeid ja vaatame, kas  iline funktsiooni on muutused kajastatud

















