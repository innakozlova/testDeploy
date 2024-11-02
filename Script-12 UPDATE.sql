insert into book (isbn, title, year)
values($ii, $tt,$yy);

--UPDATE <имя таблицы>
--SET <столбец>=<выражение>, <столбец2>=<выражение2>, <столбец3>=<выражение3>
--WHERE <условие выбора строк, которые изменятся>

-- читателю по фамилии Сидоров изменить фамилию на Смородин
update reader 
set fio='Смородин'
where fio ='Сидоров'

--читатель 12 возвращает экземпляр 2, который брал когда то (не знаем когда, но главное не вернул ранее)

update vydacha
set date_in =current_date
where nchit=12 and id_ex =2 and date_in is null; 

-- читатель 1 возвращает экземпляр 1б который брал 2024-09-12
update vydacha
set date_in =current_date
where nchit=1 and id_ex=1 and date_out='2024-09-12'; 

--изменить фио всех читателей, у которых есть книги на руках, добавить в конце каждому их них *
update reader 
set fio=fio||'*'
where nchit in (select nchit from vydacha where date_in is null)

-- всем убрать звездочки из фио
update reader 
set fio=replace(fio,'*','');

--изменить фио всех читателй, у которых есть книги на руках. добавить в конце $ и количество книг на руках
update reader 
set fio=fio||'$'||(select count(*) from vydacha
					where vydacha.nchit =reader.nchit) 
where nchit in (select nchit from vydacha where date_in is null)

--вернуть как было, то есть часть фио до знака $
update reader 
set fio=split_part(fio,'$',1);

--изменить фио всех читателй, у которых есть книги на руках. добавить в конце $ и количество книг на руках
update reader 
set fio=fio||'$'||(select count(*) from vydacha
					where vydacha.nchit =reader.nchit
					and date_in is null) 
where nchit in (select nchit from vydacha where date_in is null);


