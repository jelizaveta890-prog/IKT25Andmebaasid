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

--näitab tetud vanusega inimesi 
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
--ótsib emailid @-märgiga
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