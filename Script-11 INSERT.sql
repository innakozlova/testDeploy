--insert

--1)добавление по 1 строке или несколько заранее известных строк

insert into reader (fio)
values ('Qwerty');

insert into reader (fio)
values ('Один читатель'),
		('Второй читатель'),
		('Ещё читатель');
		
--2) добавление результатов SELECT
	
	-- допустим мы хотим выдать экземпляр номер 12 читателю, чье фио сидоров
	--в сегодняшнюю дату
	
insert into vydacha (id_ex, nchit, date_out)
values (4, (select nchit from reader where fio ilike 'Сидоров'), current_date) --одно значение в скобках

insert into vydacha (id_ex, nchit, date_out)
select 3, nchit, current_date
from reader where fio ilike 'Сидоров'

-- хотим выдать читателю 3 любой имеющийся в доступе экземпляр "Властелин колец"
select id 
from book b join exemplar e on b.isbn =e.isbn 
--left join vydacha v on e.id =v.id_ex 
where title ilike 'Властелин колец'
--and (date_in is not null or date_out is null)
	except
select id_ex
from vydacha v2 
where date_in is null
limit 1

select id 
from book b join exemplar e on b.isbn =e.isbn 
where title ilike 'Властелин колец'
and id not in ( select id_ex from vydacha v2 
where date_in is null
)
limit 1

insert into vydacha (id_ex, nchit, date_out)
select id, 3, current_date
from book b join exemplar e on b.isbn =e.isbn 
where title ilike 'Властелин колец'
and id not in ( select id_ex from vydacha v2 
where date_in is null
)
limit 1

delete from reader 
where fio='Qwerty'

delete from reader 
where fio like '% читатель';

delete from reader 
where fio like 'Сидоров'

delete from reader 
where nchit =3



