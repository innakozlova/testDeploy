--автоматически созданный select, выбирающий все из таблицы book
SELECT isbn, title, "year"
FROM public.book;

select *from book;

--книги, изданные до 2000 года

select *from book b 
where "year" <2000;

--книги, изданные с 1990 по 2005 год

select *from book b 
where "year" >= 1990 and "year" <=2005;

select *from book b 
where "year" between 2000 and 2005;

--книги, изданные в 1985 году
select *from book b 
where "year" = 1985;

-- книги, не изданные в 1985 году
select *from book b 
where "year" <> 1985;

select *from book b 
where not"year" = 1985;

--выбрать информацию о книгах, которые называются 'Колобок'
select *from book b 
where title = 'Колобок';

select *from book b 
where title like 'Колобок';

select *from book b 
where title ilike 'колобок';

--простые шаблоны для строк
--% означает любое количество любых символов
--_ один любой символ

--- книги на букву Т

select *from book b 
where title like 'Г%';

select *from book b 
where title ilike '%остров%';

select *from autor a 
where (fio ilike '%ий') or (fio ilike '%ий %');

-- узнать nchit читателя по фамилии Петров

select nchit 
from reader r 
where r.fio like 'Петров';

--в какие даты брал книги Петров

select v.date_out 
from vydacha v 
where nchit =(select nchit 
from reader r 
where r.fio like 'Иванов');

--книги, изданные в 1995, 1997, 2002, 2003
select *from book b 
--where "year" = 1995 or "year" =1997 or "year" =2002 or "year" =2003;

where "year" in (1995, 1997, 2002, 2003);

select distinct year  
from book b;

select year  
from book b
group by year;

select * from reader  
where fio not like '%ов'
and fio not like '%ов ';

select * from reader  
where fio ilike '%ю%' 
or fio ilike '%ж%'
or fio ilike '%кар%';

select nchit from vydacha v  
--where date_in between '2024-09-01' and '2024-09-30'; --указаны конкретные даты начала и конца периода
where date_part('month', date_in) =9 and date_part('year', date_in)=2024;  

select nchit from vydacha v  
where extract (month from v.date_in)=9 and extract (year from v.date_in)=2024;

select id_ex from vydacha v 
where date_part('month', date_in)=date_part('month', date_out)
and date_part('year', date_in)=date_part('year', date_out);

select count(*) --количество строк, полученных из from после применения where
from authorship a 
where id_author=1

select count(*), count(isbn) as колво_isbn --количество непустых значений в столбце isbn
from authorship a 
where id_author=2

select count(year) as "кол-во непустых столбцов year" 
, count(distinct year) as "кол-во разных столбцов year" 
from book b;

select *from reader r, vydacha v
where r.nchit =v.nchit;

select *from book b, exemplar e 
where b.isbn =e.isbn;

select *from book b, authorship a, autor a2 
where b.isbn =a.isbn and a.id_author =a2.id;

-- внутреннее соединение, прописанное целиком в секции from
select *
from book b inner join authorship a on b.isbn=a.isbn 
inner join autor a2 on a.id_author=a2.id;

select *
from book b join authorship a on b.isbn=a.isbn 
			join autor a2 on a.id_author=a2.id;

select b.title , ga.name_genre 
from book b join genre_affiliation ga on b.isbn=ga.isbn;	

select count(*) from book b;


