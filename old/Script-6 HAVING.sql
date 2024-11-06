--
select fio, name
from autor a , genre g
order by fio;


select year --, count(*) 
from book b 
group by "year"
having count(*)=2; --фильтр для групп

--найти такие года, у которых количество выпущенных книг равно 2
select *
from(
	select year, count(*) as kolvo 
	from book b 
	group by "year") yyyy
where yyyy.kolvo=2;

-- для каждой буквы подсчитать, сколько есть читателй, начинающихся на эту букву
--п 3
--и 2

select left(fio,1) as "первая буква фио", count(*) 
from reader r 
group by "первая буква фио"; 

--найти буквы, на которые начинается не более 2 фио читателй

select left(fio,1) as "первая буква фио", count(*) 
from reader r 
group by "первая буква фио"
having count(*)<=2; 

-- сколько раз брал книжки каждый читатель
select v.nchit, fio, count(*)
from reader r join vydacha v on r.nchit =v.nchit 
group by v.nchit, fio 

-- сколько раз брал книжки каждый читатель, включая тех, кто не брал
select r.nchit,v.nchit, fio, count(v.date_out)
from reader r left join vydacha v on r.nchit =v.nchit 
group by r.nchit, v.nchit, fio 

--сколько раз возвращал книжки каждый читатель, включая тех, кто не брал
select r.nchit, fio, count(v.date_in)
from reader r left join vydacha v on r.nchit =v.nchit 
group by r.nchit, fio 
having count(v.date_in)>=1; 

