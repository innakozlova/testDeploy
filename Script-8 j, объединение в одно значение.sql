select b.isbn, b.title, b."year", 
	count (name_genre) as "количество жанров"
	,String_agg(name_genre, ', ')
from book b join genre_affiliation ga on ga.isbn =b.isbn 
group by b.isbn, b.title, b."year";
