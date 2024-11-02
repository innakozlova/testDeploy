-когда в последний раз брали каждого писателя
select fio, max(date_out) as "когда брали в последний раз"  --, nchit, count(*)
from autor a  join authorship a2 on a.id =a2.id_author 
join exemplar e on e.isbn =a2.isbn 
join vydacha v on v.id_ex=e.id
group by fio

-когда в первый раз что-то брал каждый читатель
select fio, min(date_out)
from reader r left join vydacha v on r.nchit= v.nchit
group by fio

--читатель, который самый первый кто-то взял
select fio, (date_out)
from reader r left join vydacha v on r.nchit= v.nchit
order by date_out
limit 1

--читатели, которые что-то брали в тот день, в который самым последним что-то брали
select fio, (date_out)
from reader r join vydacha v on r.nchit= v.nchit
where date_out= (select max(date_out) from vydacha v2 
);
--order by date_out desc


-- сколько раз брали каждого автора = рейтинг читаемости авторов (самый популярный вверху)
-- 2 наиболее популярных автора в октябре
select a2.fio  as "ФИО автора"
, count (v2.date_out) as "Кол-во читателей"
, row number () over (order by count(a2.fio) desc) as rn
from vydacha v2 join exemplar e2 on v2.id_ex = e2.id
join authorship a on a.isbn=e2.isbn
join autor a2 on a2.id=a.id_author
where date_part('month', date_out)=10 and date_part('year', date_out)
group by a2.fio 
)ttt
where ttt.rn=2;

-- 3) Самый популярный автор среди читателей,

-- которые прочли более 1 книги Толкина

select a.fio, count(v.id_ex) --, v.nchit --, count(*)
from autor a  join authorship a2 on a.id =a2.id_author 
              join exemplar e on e.isbn =a2.isbn 
			  join vydacha v on v.id_ex=e.id
	where v.nchit in (
				select v.nchit
					from autor a
						join authorship a2 on a.id =a2.id_author 
	           		    join exemplar e on e.isbn =a2.isbn 
					    join vydacha v on v.id_ex=e.id
				where a.fio ilike '%Носов%'
				group by v.nchit
				having count(v.id_ex)>1
				) 
group by a.fio
order by count(*) desc
limit 1;


-- 6) Читатель, который прочитал хотя бы по 1 книге Верна, Толкина и Пушкина
select r.fio --aa.fio
from reader r join vydacha v  on r.nchit =v.nchit 
join exemplar e on v.id_ex =e.id 
join authorship a on e.isbn =a.isbn 
join autor a2 on a.id_author =a2.id 
--where a2.fio like 'Верн' or a2.fio like 'Дойль' or a2.fio 'Толкин'
where a2.fio in ('Верн', 'Дойль','Толкин')
group by r.fio
having count (distinct a.id_author) = 3;
