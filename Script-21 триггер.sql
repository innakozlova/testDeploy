--сделать триггер, который при добавлении или изменении автора, будет записывать это событие в отдельную таблицу
create table log(
	id int4 generated always as identity not null primary key,
	event varchar); 

CREATE or replace FUNCTION on_autor_insert1() RETURNS trigger
language plpgsql
as $$
begin
	--insert into log(event)
	--values(TG_OP);	
if TG_OP='INSERT'
then
insert into log(event)
select TG_OP||' '||new.fio;
--from new; new - это не представление или таблица, а одна строка
else
insert into log(event)
select TG_OP||' '|| old.fio||'->'||new.fio;
end if;
	Return new;
end;
$$;

CREATE TRIGGER trig1 AFTER INSERT or update ON autor
    FOR EACH ROW EXECUTE FUNCTION on_autor_insert1();
    
insert into autor (fio) values('Бананов');