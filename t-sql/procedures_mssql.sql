create procedure znajdz_naj_oplac_akt
as
begin
	declare @max_idaktor int, @idaktor int,
	@sum int = 0, @max_avg int = 0, @avg int = 0, @ilosc int,
	@imie varchar(50), @nazwisko varchar(50);
	declare cursor5 cursor for select distinct idaktor from obsada;
	open cursor5;
	fetch next from cursor5 into @idaktor;
	while @@FETCH_STATUS = 0
	begin
		select @ilosc = count(1), @sum = sum(gaza) from obsada 
		where idaktor = @idaktor;
		set @avg = @sum/@ilosc;
		if @avg > @max_avg
		begin
			set @max_avg = @avg;
			set @max_idaktor = @idaktor;
		end
	fetch next from cursor5 into @idaktor;
	end
	close cursor5;
	deallocate cursor5;
	select @imie = imie, @nazwisko = nazwisko from osoba
	where idosoba = @max_idaktor;
	print 'Srednio najlepiej oplacanym aktorem jest ' + @imie + ' ' + @nazwisko;
end;






create procedure znajdz_naj_kontr_rezy
as
begin
	declare @idrecenzja int, @idrezyser int, @roznica int,
	@imie varchar(50), @nazwisko varchar(50);
	select top 1 @idrecenzja = IdRecenzja,
	@roznica = abs(opinia_krytykow - opinia_publicznosci) from recenzja 
	order by abs(opinia_krytykow - opinia_publicznosci) desc;
	select @idrezyser = idrezyser from film
	where idrecenzja = @idrecenzja;
	select @imie = imie, @nazwisko = nazwisko from osoba
	where idosoba = @idrezyser;
	print 'Najbardziej kontrowersyjnym rezyserem jest ' + @imie + ' ' + @nazwisko
			+ ' o roznicy glosow wynoszacej ' + cast(@roznica as varchar);
end






create trigger t_aktualizacja_gazy on obsada 
for insert, update
as
begin
	declare @idobsada int, @idfilm int, @sum int, @budzet_dla_gaz decimal;
	if exists (select 1 from deleted) and update(gaza)
	begin
		declare cursor6 cursor local for select idobsada, idfilm from inserted;
		open cursor6;
		fetch next from cursor6 into @idobsada, @idfilm;
		while @@FETCH_STATUS = 0
		begin
			select @sum = sum(gaza) from obsada
			where idfilm = @idfilm;
			select @budzet_dla_gaz = budzet*0.2 from film
			where idfilm = @idfilm;
			if @sum > @budzet_dla_gaz
			begin
				declare @stara_gaza int;
				select @stara_gaza = gaza from deleted
				where idobsada = @idobsada;
				update obsada set gaza = @stara_gaza
				where idobsada = @idobsada;
			end
			fetch next from cursor6 into @idobsada, @idfilm;
		end
		close cursor6;
		deallocate cursor6;
	end
	else if exists (select 1 from inserted) and not exists (select 1 from deleted)
	begin
		declare cursor7 cursor local for select idobsada, idfilm from inserted;
		open cursor7;
		fetch next from cursor7 into @idobsada, @idfilm;
		while @@FETCH_STATUS = 0
		begin
			select @sum = sum(gaza) from obsada
			where idfilm = @idfilm;
			select @budzet_dla_gaz = budzet*0.2 from film
			where idfilm = @idfilm;
			if @sum > @budzet_dla_gaz
			begin
				delete from obsada where idobsada = @idobsada;
			end
			fetch next from cursor7 into @idobsada, @idfilm;
		end
		close cursor7;
		deallocate cursor7;
	end
end;






create trigger t_usuniecie_roli on obsada
for delete
as
begin
	declare @gaza_sum int = 0, @procent decimal, @idfilm int, @tytul varchar(50), @budzet int;
	declare cursor4 cursor for select idfilm from deleted;
	open cursor4;
	fetch next from cursor4 into @idfilm;
	while @@FETCH_STATUS = 0 
	begin
		select @gaza_sum = sum(gaza) from obsada
		where idfilm = @idfilm;
		select @budzet = budzet, @tytul = tytul from film
		where idfilm = @idfilm;
		set @procent = cast (@gaza_sum as float)/cast (@budzet as float)*100;
		print 'Po usunieciu roli, pozostale gaze w filmie ' + @tytul + ' wynosza ' +
				convert(varchar,@gaza_sum) + ' co stanowi ' + convert(varchar,@procent) + '% budzetu';
		fetch next from cursor4 into @idfilm;
	end
	close cursor4;
	deallocate cursor4;
end