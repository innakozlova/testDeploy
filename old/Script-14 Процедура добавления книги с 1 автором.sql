create or replace procedure add_author(x_fio varchar, x_penname varchar)  
language sql 
as $$
	insert into autor(fio, penname)
	values(x_fio,x_penname);
$$;


CREATE OR REPLACE PROCEDURE add_author(IN x_fio varchar, 
										IN x_penname varchar default null)
 LANGUAGE sql
AS $procedure$
	insert into autor(fio, penname)
	values(x_fio,x_penname);
$procedure$
;

CREATE OR REPLACE PROCEDURE add_author2(IN x_fio varchar, 
										IN x_penname varchar ='нет псевдонима' )
 LANGUAGE sql
AS $procedure$
	insert into autor(fio, penname)
	values(x_fio,x_penname);
$procedure$
;

--нужно описать процедуру добавления книги с указанием автора

--входные параметры 
--название, год издания, isbn, фио_автора
--Последовательность действий:
--1) добавить инфу в book
--insert into book
--2) может быть добавить в autor
--insert into autor (fio)
--select фио_автора
except
select fio from autor a 
--3) добавить в authorship

-- Альтернативный 
--1) добавить инфу в book
--insert into book
--2) если автора с такой фамилией нет, то добавить его
if not exists (select * from autor where fio=фио_автора)
then insert into autor (fio) values (фио_автора); 

create or replace procedure add_book(b_title varchar, b_year int2, b_isbn int4, a_fio varchar)
language sql
as $$
--добавить книжку
insert into book(isbn, title, year)
values(b_isbn, b_title,b_year);

--добавить автора, если такого не было
insert into autor (fio)
select a_fio
except
select fio from autor;
-- добавить связь между ними в таблицу authorship
insert into authorship(isbn, id_author)
values (b_isbn, (select id from autor where fio=a_fio));
$$;
