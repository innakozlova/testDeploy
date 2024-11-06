--Теоретико-множественные операции

--1. сложение (объединение) union
--2. вычитание (исключение) except
--3. умножение (полное декартово произведение)
--4. деление (реляционное деление)
--5. пересечение INTERSECT

--UNION
select nchit
from vydacha v 
where date_in  is null 
union
select nchit from reader r where fio  like 'П%'; --без повторений


select nchit
from vydacha v 
where date_in  is null 
union all
select nchit from reader r where fio  like 'П%'; -- с повторениями

--EXCEPT
-- найти читателей, фио которых начинаются с И, за исключением тех, чьи фио заканчиваются на букву А
select* from reader r where fio like 'И%'
except 
select* from reader r2 where fio like '%а'

--найти жанры, в которых не писал Толкин
-- все жанры, за исключением тех, в которых писал

select * from genre g 
except
select name_genre from boo_info bi where fio_author= 'Носов';

--читатели, которые ничего не брали
select * from reader r -- все читатели
except 
select r2.nchit, fio -- читатели, упомянутые в выдаче
from reader r2 join vydacha v on r2.nchit =v.nchit;

