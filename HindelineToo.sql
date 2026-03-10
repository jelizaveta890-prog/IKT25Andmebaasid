     --1.versioon
  --Raamatukogu süsteem--
--------------------------

--1.Loon tabeli
--Tabel nimega Raamatud järgmiste veergudega:
--id - INT (primaarvõti)
--Pealkiri - VARCHAR(100)
--Autor - VARCHAR(100)
--aasta - INT 
--Hind - DECIMAL(5,2)

create table Raamatud
(
Id int primary key, 
Pealkiri VARCHAR(100),
Autor VARCHAR(100),
aasta  INT,
Hind DECIMAL(5,2)
)
insert into Raamatud (Id, Pealkiri, Autor, aasta, Hind)
values (1, 'Tom', 'L.Koidula',1954, 24.20),
(2, 'Pam', 'A.Uibo',2007, 23.50),
(3, 'John', 'L.Koidula', 1940, 13.99),
(4, 'Sam', 'L.Koidula', 1943, 15.60),
(5, 'Todd', 'L.Koidula',1947, 27.00),
(6, 'Ben', 'A.Uibo', 2005, 16.30),
(7, 'Sara', 'A.Uibo',2002, 18.00)
select *from Raamatud

  --Andmete muutmine--
--------------------------

--Raamatu hinda muutmine
update Raamatud
set Hind = 21.22
where Id = 5
select * from Raamatud

--Raamatu autori muutmine
update Raamatud
set Autor = 'S.Jarev'
where Id = 4
select * from Raamatud

   --Veeru Lisamine--
--------------------------

alter table Raamatud 
add laos_kogus INT


select * from Raamatud  where laos_kogus = 227
select * from Raamatud  where laos_kogus = 363
select * from Raamatud  where laos_kogus = 423
   
   --Veeru kustutamine--
--------------------------

--kustutame veeru nimega Hind Employees tabelist
alter table Raamatud
drop column Hind

--kustutan tabelist üks raamat, kasutades Where
delete from Raamatud where Id = 7  