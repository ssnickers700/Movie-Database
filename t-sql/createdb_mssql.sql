drop table Osoba;
drop table Plec;
drop table Rezyser;
drop table Aktor;
drop table Obsada;
drop table Film;
drop table Recenzja;
drop table Kraj;
drop table Gatunek;

create table Osoba
        (IdOsoba int not null,
        Imie varchar(50),
        Nazwisko varchar(50),
        Data_urodzenia date,
        IdPlec int);
        
create table Plec
        (IdPlec int not null,
        Nazwa varchar(50));
        
create table Rezyser
        (IdRezyser int not null);
        
create table Aktor 
        (IdAktor int not null,
        Wzrost int);
        
create table Obsada
        (IdObsada int not null,
        IdFilm int,
        IdAktor int,
        Rola varchar(50),
        Gaza int);
        
create table Film
        (IdFilm int not null,
        Tytul varchar(50),
        IdRezyser int,
        IdGatunek int,
        Data_produkcji date,
        IdKraj int,
        Budzet int,
        IdRecenzja int);
        
create table Recenzja
        (IdRecenzja int not null,
        Opinia_krytykow int,
        Opinia_publicznosci int);
        
create table Kraj
        (IdKraj int not null,
        Nazwa varchar(50));
        
create table Gatunek
        (IdGatunek int not null,
        Nazwa varchar(50));
        
        
        
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
        (1, 'Robert', 'De Niro', CONVERT(date,'1943-08-17'), 1);
insert into Osoba values 
        (2, 'Joe', 'Pesci', CONVERT(date,'1943-02-09'), 1);
insert into Osoba values 
        (3, 'Martin', 'Scorsese', CONVERT(date,'1942-11-17'), 1);
insert into Osoba values 
        (4, 'Jodie', 'Foster', CONVERT(date,'1962-11-19'), 2);
insert into Osoba values 
        (5, 'Alfredo', 'Pacino', CONVERT(date,'1940-04-25'), 1);
insert into Osoba values 
        (6, 'Quentin', 'Tarantino', CONVERT(date,'1963-03-27'), 1);
insert into Osoba values 
        (7, 'John', 'Travolta', CONVERT(date,'1954-02-18'), 1);
insert into Osoba values 
        (8, 'Leonardo', 'DiCaprio', CONVERT(date,'11-11-1974'), 1);
insert into Osoba values 
        (9, 'Brad', 'Pitt', CONVERT(date,'1963-12-18'), 1);
insert into Osoba values 
        (10, 'Steven', 'Spielberg', CONVERT(date,'1946-12-18'), 1);
insert into Osoba values 
        (11, 'David', 'Fincher', CONVERT(date,'1962-08-28'), 1);
        
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
        (1, 'Goodfellas', 3, 1, CONVERT(date,'1990-12-09'), 1, 25000, 1);
insert into Film values
        (2, 'Taxi Driver', 3, 1, CONVERT(date,'1976-02-08'), 1, 2000, 2);
insert into Film values
        (3, 'The Irishman', 3, 1, CONVERT(date,'2019-09-27'), 1, 159000, 3);
insert into Film values
        (4, 'Pulp Fiction', 6, 1, CONVERT(date,'1994-10-14'), 1, 8000, 4);
insert into Film values
        (5, 'Once upon a time in Hollywood', 6, 1, CONVERT(date,'2019-05-21'), 1, 90000, 5);
insert into Film values
        (6, 'Reservoir Dogs', 6, 1, CONVERT(date,'1992-01-21'), 1, 3000, 6);
insert into Film values
        (7, 'Catch Me if You Can', 10, 1, CONVERT(date,'2002-12-18'), 1, 52000, 7);
insert into Film values
        (8, 'Fight Club', 11, 1, CONVERT(date,'1999-09-10'), 1, 63000, 8);
        








