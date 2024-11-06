--создать триггер, который покажет, что он работает
--при добавлении записи в таблицу автор

CREATE or replace FUNCTION on_autor_insert0() RETURNS trigger
language plpgsql
as $$
begin
	Raise notice 'сработал триггер на добавление автора';	
Return new;
end;
$$;

CREATE TRIGGER trig0 BEFORE INSERT ON autor
    FOR EACH ROW EXECUTE FUNCTION on_autor_insert0();
    
   --пример использования insert, которое вызовет срабатывание триггера
   insert into autor (fio) values('Войскунский'), ('Лукодьянов');
   
  call add_author('Жуков');