--на данный момент в базе данных нет автора XYZ
select *from autor a;
-- на данный момент в БД нет книги  QWERTY
select *from book b;

--тест1
--добавить книгу QWERTY с указанием автора XYZ
call add_book('QWERTY', 2024, 1000,'XYZ');
--по итогу должна быть строчка в представлении boo_info, где сказано, что книгу QWERTY написал XYZ
select *from boo_info bi order by year desc; 

--тест2
--добавить книгу YTREWQ с указанием автора XYZ
call add_book('YTREWQ', 2024, 1002,'XYZ');
--по итогу должна быть строчка в представлении boo_info, где сказано, что книгу YTREWQ написал XYZ
select *from boo_info bi order by year desc; 
--автор XYZ должен быть только один в таблице autor
select count(*) from autor a where fio='XYZ';

--очистка после теста
delete from authorship where isbn in (1000,1002);
delete from autor where fio='XYZ';
delete from book where isbn in (1000,1002);
