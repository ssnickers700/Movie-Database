set serveroutput on;
create or replace procedure wyrownaj_place (v_idfilm number)
is
v_srednia number;
v_budzet number;
v_nowa_gaza number;
cursor cursor1 is select gaza, rola, idfilm from obsada where idfilm = v_idfilm for update of gaza;
v_obsada_rekord cursor1%rowtype;
begin
    select budzet into v_budzet from film where idfilm = v_idfilm;
    select sum(budzet)/count(1) into v_srednia from film
    where data_produkcji > add_months(sysdate, -5 * 12);
    
    if v_budzet < v_srednia then
        for v_obsada_rekord in cursor1
        loop
            if v_obsada_rekord.gaza < v_budzet*0.1 then
                v_nowa_gaza := v_obsada_rekord.gaza*1.1;
                update obsada set gaza = gaza*1.1 where current of cursor1;
                update film set budzet = budzet + v_nowa_gaza where idfilm = v_idfilm;
                dbms_output.put_line('Powiekszono gaze za role ' || 
                                    v_obsada_rekord.rola || ' o 10%');
            end if;
        end loop;
		commit;
    else
        dbms_output.put_line('Film jest ponizej sredniego budzetu z ostatnich 5 lat');
    end if;
end;






ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY'; 
set serveroutput on;
create or replace procedure znajdz_naj_ocen_akt (v_data_ur osoba.data_urodzenia%type)
is
v_idrecenzja number;
v_max_ocena number;
v_idfilm number;
v_imie varchar2(50);
v_nazwisko varchar2(50);
v_plec number;
cursor cursor2 is select idaktor, idfilm from obsada;
v_rekord cursor2%rowtype;
begin
    select max((opinia_krytykow+opinia_publicznosci)/2) into v_max_ocena from recenzja;
    select idrecenzja into v_idrecenzja from recenzja
    where (opinia_krytykow+opinia_publicznosci)/2 = v_max_ocena;
    select idfilm into v_idfilm from film
    where idrecenzja = v_idrecenzja;
    
    for v_rekord in cursor2 
    loop
        if v_rekord.idfilm = v_idfilm then
            select imie, nazwisko, idplec into v_imie, v_nazwisko, v_plec from osoba 
            where idosoba = v_rekord.idaktor and data_urodzenia > v_data_ur;
            if v_plec = 1 then
                dbms_output.put_line(v_imie || ' ' || v_nazwisko || ' zagral w najlepszym filmie o ocenie ' || v_max_ocena);
            else
                dbms_output.put_line(v_imie || ' ' || v_nazwisko || ' zagrala w najlepszym filmie o ocenie ' || v_max_ocena);
            end if;
        end if;
    end loop;
    exception
        when NO_DATA_FOUND then
        dbms_output.put_line('Nie znaleziono aktorow w danym przedziale wiekowym w najlepszym filmie');
end;






set serveroutput on;
create or replace trigger t_usuniecie_filmu 
before delete on film
for each row
declare
v_idobsada number;
v_idrecenzja number;
cursor cursor3 is select idobsada, idfilm, rola from obsada;
v_rekord_cursor3 cursor3%rowtype;
begin
    for v_rekord_cursor3 in cursor3 
    loop
        if v_rekord_cursor3.idfilm = :old.idfilm then
            delete from obsada where idobsada = v_rekord_cursor3.idobsada;
            dbms_output.put_line('Usunieto role ' || v_rekord_cursor3.rola || ' z obsady filmu ' || :old.tytul);
        end if;
    end loop;
    delete from recenzja where idrecenzja = :old.idrecenzja;
    if sql%found then
        dbms_output.put_line('Usunieto recenzje filmu ' || :old.tytul);
    end if;
end;






set serveroutput on;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY'; 
create or replace trigger t_usuniecie_osoby
after delete on osoba
for each row
declare
v_ilosc_rol int;
v_ilosc_filmow int;
v_tytul varchar2(50);
cursor cursor8 is select rola, idfilm, idaktor from obsada;
cursor cursor9 is select tytul, idrezyser from film;
v_rekord_cursor8 cursor8%rowtype;
v_rekord_cursor9 cursor9%rowtype;
begin
    select count(1) into v_ilosc_rol from obsada
    where :old.idosoba = idaktor;
    select count(1) into v_ilosc_filmow from film
    where :old.idosoba = idrezyser;
    if v_ilosc_rol > 0 then
        for v_rekord_cursor8 in cursor8
        loop
            if v_rekord_cursor8.idaktor = :old.idosoba then
                select tytul into v_tytul from film
                where idfilm = v_rekord_cursor8.idfilm;
                dbms_output.put_line(:old.imie || ' ' || :old.nazwisko || ' gra jako ' ||
                                    v_rekord_cursor8.rola || ' w filmie ' || v_tytul);
            end if;
        end loop;
    end if;
    if v_ilosc_filmow > 0 then
        for v_rekord_cursor9 in cursor9 
        loop
            if v_rekord_cursor9.idrezyser = :old.idosoba then
                dbms_output.put_line(:old.imie || ' ' || :old.nazwisko || ' rezyseruje film ' ||
                                v_rekord_cursor9.tytul);
            end if;
        end loop;
    end if;
    if v_ilosc_filmow > 0 or v_ilosc_rol > 0 then
        raise_application_error(-20001,'Nie mozna usunac ' || :old.imie || ' ' || :old.nazwisko || 
                            ' z powodu obecnosci w bazie powyzszych aktywnosci osoby');
    end if;
end;
