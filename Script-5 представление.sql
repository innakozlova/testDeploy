--соединить таблицы Читатель и Выдача, не потеряв строки читаталей, которые ничего не брали

select *
from reader r left outer join vydacha v on r.nchit =v.nchit; 

--соединить экземпляры и все имеющиеся книги
select *
from exemplar e right join book b on e.isbn =b.isbn 

--соединить все книги с соответствующими им авторами (даже без автора)
select *
from book b left join authorship a on b.isbn =a.isbn 
left join autor a2 on a2.id =a.id_author 

-- сделать представление полной информации обо всех книгах, включая авторов и жанры
-- если автор или жанр не указаны, должны быть NULL в строках

select *
from book b left join authorship a on b.isbn =a.isbn 
left join autor a2 on a2.id =a.id_author 
left join genre_affiliation ga on b.isbn =ga.isbn 
--left join genre g on ga.name_genre =g."name"  

create view boo_info
as
select  b.*,
		fio as fio_author, 
		name_genre 
from book b left join authorship a on b.isbn =a.isbn 
left join autor a2 on a2.id =a.id_author 
left join genre_affiliation ga on b.isbn =ga.isbn; 

select bi.*, e.id 
from reader r join vydacha v on r.nchit =v.nchit 
join exemplar e on e.id =v.id_ex 
join boo_info bi on bi.isbn =e.isbn 
where  fio='Петров';

