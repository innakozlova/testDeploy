 
-- 0) Для каждого автора вывести названия жанров, в которых он НЕ работал

select fio, name  -- все комбинации авторов и жанров
from autor a , genre g
except
select fio, name_genre from autor a join authorship a2 on a.id=a2.id_author -- все жанры, в которых работал автор
join genre_affiliation ga on a2.isbn =ga.isbn 
 


-- 1) Вывести названия книг, которые брали читатели, ни разу не читавшие Толкина

select distinct кчб.title from кто_что_брал2 кчб where кчб."ФИО автора" !='Носов'

select title, nchit 
from vydacha v join exemplar e on v.id_ex =e.id 
join book b on b.isbn =e.isbn 
where nchit not in (
select nchit
from vydacha v2 join exemplar e2 on v2.id_ex = e2.id
join authorship a on a.isbn=e2.isbn
join autor a2 on a2.id=a.id_author
where a2.fio ilike 'Носов%') --список толкинистов


-- 2) Экземпляры, побывавшие в руках более чем 1 читателя

select id_ex
from(
select v.id_ex, count(distinct v.nchit) as kolvo
from vydacha v
group by v.id_ex) yyyy
where yyyy.kolvo>1;


 
select v.id_ex  --count(v.nchit) as читатели, count(distinct v.nchit) as уникальные_читатели
from vydacha v
group by v.id_ex
having count (distinct v.nchit)>1;


-- 3) Самый популярный автор среди читателей,

-- которые прочли более 1 книги Толкина

 

-- 4) Cколько суммарно букв в FIO авторов каждой книги
select b.isbn, sum(LENGTH(a.fio)) as  суммарная_длина_фио --, fio
from autor a join authorship a2 on a.id =a2.id_author 
join book b on a2.isbn =b.isbn 
group by b.isbn; 
 

-- 5) Авторы, которых один и тот же читатель брал более 1 раза
select distinct a.fio,count(*)  --, nchit, count(*)
from autor a  join authorship a2 on a.id =a2.id_author 
join exemplar e on e.isbn =a2.isbn 
join vydacha v on v.id_ex=e.id
group by a.fio, nchit
having count(*)=1 

-- 6) Читатель, который прочитал хотя бы по 1 книге Верна, Толкина и Пушкина

 

-- 7) Сколько в среднем был на руках у читателя каждый автор

-- (учитывать только те книги, которые брали и возвращали)
SELECT EXTRACT(DAY FROM v.date.in, v.date.out)
from vydacha v 

select a.fio, avg(v.date_in - v.date_out) as avg_days, sum(v.date_in - v.date_out), count(*)
from autor a  join authorship a2 on a.id =a2.id_author 
join book b on b.isbn =a2.isbn 
join exemplar e on e.isbn =b.isbn 
join vydacha v on v.id_ex=e.id
where v.date_in is not null
group by a.fio 
 

