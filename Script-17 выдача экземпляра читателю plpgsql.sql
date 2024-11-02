--сделать хранимую процедуру выдачи экземпляра читателю
--параметры: номер экземпляра, номер читательского билета

--результат в таблице vydacha должна добавиться строчка, содержащая указанный номер экзмепляра, указанный нчит, текущую дату в поле date_out и null в поле date_in 

create or replace procedure out_exemplar(o_

id_ex int4, o_nchit int4)
language plpgsql
as $$ begin
--ЕСЛИ нет строчки, говорящей, что экземпляр уже на руках у читателя, 
IF not exists (select* from vydacha where id_ex=o_id_ex and date_in is null)
--ТО
then
--выдать книжку
insert into vydacha (id_ex, nchit, date_out, date_in)
values(o_id_ex, o_nchit, current_date, null);
--ИНАЧЕ
else
--написать сообщение или выбросить исключение, или записать в журнал 
RAISE NOTICE 'Экземпляр уже выдан!!!';
end if;
end;
$$;

call out_exemplar (7,7);
select *from кто_что_брал2 кчб 

call out_exemplar (2,3);
select *from кто_что_брал2 кчб 