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