drop table Osoba;
drop table Plec;
drop table Rezyser;
drop table Aktor;
drop table Obsada;
drop table Film;
drop table Recenzja;
drop table Kraj;
drop table Gatunek;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY'; 

create table Osoba
        (IdOsoba number not null,
        Imie varchar2(50),
        Nazwisko varchar2(50),
        Data_urodzenia date,
        IdPlec number);
        
create table Plec
        (IdPlec number not null,
        Nazwa varchar2(50));
        
create table Rezyser
        (IdRezyser number not null);
        
create table Aktor 
        (IdAktor number not null,
        Wzrost number);
        
create table Obsada
        (IdObsada number not null,
        IdFilm number,
        IdAktor number,
        Rola varchar2(50),
        Gaza number);
        
create table Film
        (IdFilm number not null,
        Tytul varchar2(50),
        IdRezyser number,
        IdGatunek number,
        Data_produkcji date,
        IdKraj number,
        Budzet number,
        IdRecenzja number);
        
create table Recenzja
        (IdRecenzja number not null,
        Opinia_krytykow number,
        Opinia_publicznosci number);
        
create table Kraj
        (IdKraj number not null,
        Nazwa varchar2(50));
        
create table Gatunek
        (IdGatunek number not null,
        Nazwa varchar2(50));
        
        
        
insert into Plec values (1, 'Mezczyzna');
insert into Plec values (2, 'Kobieta');

insert into Kraj values (1, 'Stany Zjednoczone');
insert into Kraj values (2, 'Wielka Brytania');
insert into Kraj values (3, 'Polska');

insert into Gatunek values (1, 'Dramat');
insert into Gatunek values (2, 'Komedia');
insert into Gatunek values (3, 'Thriller');
insert into Gatunek values (4, 'Horror');

insert into Osoba values 
        (1, 'Robert', 'De Niro', to_date('17-08-1943'), 1);
insert into Osoba values 
        (2, 'Joe', 'Pesci', to_date('09-02-1943'), 1);
insert into Osoba values 
        (3, 'Martin', 'Scorsese', to_date('17-11-1942'), 1);
insert into Osoba values 
        (4, 'Jodie', 'Foster', to_date('19-11-1962'), 2);
insert into Osoba values 
        (5, 'Alfredo', 'Pacino', to_date('25-04-1940'), 1);
insert into Osoba values 
        (6, 'Quentin', 'Tarantino', to_date('27-03-1963'), 1);
insert into Osoba values 
        (7, 'John', 'Travolta', to_date('18-02-1954'), 1);
insert into Osoba values 
        (8, 'Leonardo', 'DiCaprio', to_date('11-11-1974'), 1);
insert into Osoba values 
        (9, 'Brad', 'Pitt', to_date('18-12-1963'), 1);
insert into Osoba values 
        (10, 'Steven', 'Spielberg', to_date('18-12-1946'), 1);
insert into Osoba values 
        (11, 'David', 'Fincher', to_date('28-08-1962'), 1);
        
insert into Aktor values
        (1, 177);
insert into Aktor values
        (2, 163);
insert into Aktor values
        (4, 160);
insert into Aktor values
        (5, 170);
insert into Aktor values
        (7, 188);
insert into Aktor values
        (8, 183);
insert into Aktor values
        (9, 180);
insert into Aktor values
        (6, 185);

insert into Rezyser values (3);
insert into Rezyser values (6);
insert into Rezyser values (10);
insert into Rezyser values (11);

        
insert into Obsada values
        (1, 1, 1, 'James Conway', 3000);
insert into Obsada values
        (2, 1, 2, 'Tommy DeVito', 2000);
insert into Obsada values
        (3, 2, 1, 'Travis Bickle', 100);
insert into Obsada values
        (4, 2, 4, 'Iris', 150);
insert into Obsada values
        (5, 3, 1, 'Frank Sheeran', 14000);
insert into Obsada values
        (6, 3, 5, 'Adam Hoffa', 11000);
insert into Obsada values
        (7, 3, 2, 'Russell Bufalino', 8000);
insert into Obsada values
        (8, 4, 7, 'Vincent Vega', 1200);
insert into Obsada values
        (9, 5, 8, 'Rick Dalton', 13000);
insert into Obsada values
        (10, 5, 9, 'Cliff Booth', 10000);
insert into Obsada values
        (11, 6, 6, 'Mr. Brown', 100);
insert into Obsada values
        (12, 7, 8, 'Frank Abagnale', 9000);
insert into Obsada values
        (13, 8, 9, 'Tyler Durden', 7000);
        
insert into Recenzja values (1, 96, 97);
insert into Recenzja values (2, 96, 93);
insert into Recenzja values (3, 95, 86);
insert into Recenzja values (4, 92, 96);
insert into Recenzja values (5, 85, 70);
insert into Recenzja values (6, 92, 94);
insert into Recenzja values (7, 96, 81);
insert into Recenzja values (8, 79, 96);

insert into Film values
        (1, 'Goodfellas', 3, 1, to_date('09-12-1990'), 1, 25000, 1);
insert into Film values
        (2, 'Taxi Driver', 3, 1, to_date('08-02-1976'), 1, 2000, 2);
insert into Film values
        (3, 'The Irishman', 3, 1, to_date('27-09-2019'), 1, 159000, 3);
insert into Film values
        (4, 'Pulp Fiction', 6, 1, to_date('14-10-1994'), 1, 8000, 4);
insert into Film values
        (5, 'Once upon a time in Hollywood', 6, 1, to_date('21-05-2019'), 1, 90000, 5);
insert into Film values
        (6, 'Reservoir Dogs', 6, 1, to_date('21-01-1992'), 1, 3000, 6);
insert into Film values
        (7, 'Catch Me if You Can', 10, 1, to_date('18-12-2002'), 1, 52000, 7);
insert into Film values
        (8, 'Fight Club', 11, 1, to_date('10-09-1999'), 1, 63000, 8);
        








