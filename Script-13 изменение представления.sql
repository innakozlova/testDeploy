create view fresh_books
as
select isbn, year as "год издания", title as название
from book b 
where year >2001;

select *from fresh_books fb;

insert into fresh_books (isbn, "год издания", название)
values(487,2024, 'Солярис'); 

update fresh_books 
set название='СОЛЯРИС'
where isbn=487;

insert into fresh_books (isbn, "год издания", название)
values(133,1984,'1984'); 

CALL add_author('Даррелл');

CALL add_author('Чейни', 'Джек Лондон');
select * from autor a  

CALL add_author2('Байрон');
select * from autor a  

CALL add_author2('Лукьяненко', null);
select * from autor a 