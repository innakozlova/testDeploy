--функция возврата книги
--параметры: nchit, id_ex
--результат: изменить строчку в выдачеб заменить пустую дату возврата на текущую

CREATE FUNCTION return_exemplar (v_nchit int4, v_id_ex int4) RETURNS integer  --когда то вернет число (которое внутри функции)
as $$
begin
	update vydacha
	set date_in=current_date
	where id_ex=v_id_ex and nchit=v_nchit and date_in is null;
	return 1; --вернуть результат
end;
$$
language plpgsql;

CREATE FUNCTION return_exemplar2 (v_nchit int4, v_id_ex int4) RETURNS void  --когда то вернет число (которое внутри функции)
as $$
begin
	update vydacha
	set date_in=current_date
	where id_ex=v_id_ex and nchit=v_nchit and date_in is null;
	return; --вернуть результат
end;
$$
language plpgsql;
