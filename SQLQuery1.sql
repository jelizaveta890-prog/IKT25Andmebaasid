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
