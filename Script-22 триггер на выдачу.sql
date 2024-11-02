--контролировать таблицу выдача. а именно добавление строк
--запретить выдавать экземпляр, если в указанную дату выдачи он уже выдан и еще не возвращен

CREATE or replace FUNCTION on_vydacha() RETURNS trigger
language plpgsql
as $$
begin
		
if exists (
select* from vydacha v
where v.id_ex=new.id_ex
and new.date_out >= v.date_out 
and (new.date_out <= v.date_in or v.date_in is null)
)
then
raise notice 'дата неправильная'; 
	return null;
end if;
	raise notice 'дата правильная';
	Return new;
end;
$$;

CREATE TRIGGER trig2 before INSERT ON vydacha
    FOR EACH ROW EXECUTE FUNCTION on_vydacha();
    
   
insert into vydacha(id_ex, nchit, date_out)
values(4, 2, '2024-10-18');