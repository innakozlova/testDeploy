--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-10-31 09:39:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 232 (class 1255 OID 16616)
-- Name: add_author(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_author(IN x_fio character varying, IN x_penname character varying DEFAULT NULL::character varying)
    LANGUAGE sql
    AS $$
	insert into autor(fio, penname)
	values(x_fio,x_penname);
$$;


ALTER PROCEDURE public.add_author(IN x_fio character varying, IN x_penname character varying) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16617)
-- Name: add_author2(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_author2(IN x_fio character varying, IN x_penname character varying DEFAULT 'нет псевдонима'::character varying)
    LANGUAGE sql
    AS $$
	insert into autor(fio, penname)
	values(x_fio,x_penname);
$$;


ALTER PROCEDURE public.add_author2(IN x_fio character varying, IN x_penname character varying) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16618)
-- Name: add_book(character varying, smallint, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_book(IN b_title character varying, IN b_year smallint, IN b_isbn integer, IN a_fio character varying)
    LANGUAGE sql
    AS $$
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


ALTER PROCEDURE public.add_book(IN b_title character varying, IN b_year smallint, IN b_isbn integer, IN a_fio character varying) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 16619)
-- Name: add_book(character varying, integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_book(IN b_title character varying, IN b_year integer, IN b_isbn integer, IN a_fio character varying)
    LANGUAGE sql
    AS $$
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


ALTER PROCEDURE public.add_book(IN b_title character varying, IN b_year integer, IN b_isbn integer, IN a_fio character varying) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 16620)
-- Name: out_exemplar(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.out_exemplar(IN o_id_ex integer, IN o_nchit integer)
    LANGUAGE plpgsql
    AS $$ begin
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


ALTER PROCEDURE public.out_exemplar(IN o_id_ex integer, IN o_nchit integer) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16621)
-- Name: return_exemplar(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.return_exemplar(v_nchit integer, v_id_ex integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	update vydacha
	set date_in=current_date
	where id_ex=v_id_ex and nchit=v_nchit and date_in is null;
	return 1;
end;
$$;


ALTER FUNCTION public.return_exemplar(v_nchit integer, v_id_ex integer) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16622)
-- Name: return_exemplar2(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.return_exemplar2(v_nchit integer, v_id_ex integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
	update vydacha
	set date_in=current_date
	where id_ex=v_id_ex and nchit=v_nchit and date_in is null;
	return; --вернуть результат
end;
$$;


ALTER FUNCTION public.return_exemplar2(v_nchit integer, v_id_ex integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16436)
-- Name: authorship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorship (
    isbn integer NOT NULL,
    id_author integer NOT NULL
);


ALTER TABLE public.authorship OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16419)
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autor (
    id integer NOT NULL,
    fio character varying NOT NULL,
    penname character varying
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16418)
-- Name: autor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.autor ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.autor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16429)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    isbn integer NOT NULL,
    title character varying NOT NULL,
    year smallint NOT NULL
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16453)
-- Name: genre_affiliation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre_affiliation (
    isbn integer NOT NULL,
    name_genre character varying NOT NULL
);


ALTER TABLE public.genre_affiliation OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16608)
-- Name: boo_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.boo_info AS
 SELECT b.isbn,
    b.title,
    b.year,
    a2.fio AS fio_author,
    ga.name_genre
   FROM (((public.book b
     LEFT JOIN public.authorship a ON ((b.isbn = a.isbn)))
     LEFT JOIN public.autor a2 ON ((a2.id = a.id_author)))
     LEFT JOIN public.genre_affiliation ga ON ((b.isbn = ga.isbn)));


ALTER VIEW public.boo_info OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16476)
-- Name: exemplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exemplar (
    id integer NOT NULL,
    isbn integer NOT NULL,
    condition text
);


ALTER TABLE public.exemplar OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16475)
-- Name: exemplar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.exemplar ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.exemplar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16612)
-- Name: fresh_books; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.fresh_books AS
 SELECT isbn,
    year AS "год издания",
    title AS "название"
   FROM public.book b
  WHERE (year > 2001);


ALTER VIEW public.fresh_books OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16446)
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    name character varying NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16405)
-- Name: reader; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reader (
    nchit smallint NOT NULL,
    fio character varying NOT NULL
);


ALTER TABLE public.reader OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16410)
-- Name: reader_nchit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reader ALTER COLUMN nchit ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reader_nchit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16488)
-- Name: vydacha; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vydacha (
    nchit integer NOT NULL,
    id_ex integer NOT NULL,
    date_out date NOT NULL,
    date_in date,
    period integer DEFAULT 10,
    CONSTRAINT vydacha_check CHECK ((date_out <= date_in))
);


ALTER TABLE public.vydacha OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16598)
-- Name: кто_что_брал; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."кто_что_брал" AS
 SELECT r.nchit,
    r.fio AS "фио читателя",
    v.id_ex,
    e.condition,
    b.isbn,
    b.title,
    b.year,
    a.id AS "ID автора",
    a.fio AS "ФИО автора",
    a.penname,
    v.date_out,
    v.date_in
   FROM (((((public.autor a
     JOIN public.authorship a2 ON ((a.id = a2.id_author)))
     JOIN public.book b ON ((a2.isbn = b.isbn)))
     JOIN public.exemplar e ON ((b.isbn = e.isbn)))
     JOIN public.vydacha v ON ((e.id = v.id_ex)))
     JOIN public.reader r ON ((v.nchit = r.nchit)));


ALTER VIEW public."кто_что_брал" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16603)
-- Name: кто_что_брал2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."кто_что_брал2" AS
 SELECT r.nchit,
    r.fio AS "фио читателя",
    v.id_ex,
    e.condition,
    b.isbn,
    b.title,
    b.year,
    a.id AS "ID автора",
    a.fio AS "ФИО автора",
    a.penname,
    v.date_out,
    v.date_in,
    v.period
   FROM (((((public.autor a
     JOIN public.authorship a2 ON ((a.id = a2.id_author)))
     JOIN public.book b ON ((a2.isbn = b.isbn)))
     JOIN public.exemplar e ON ((b.isbn = e.isbn)))
     JOIN public.vydacha v ON ((e.id = v.id_ex)))
     JOIN public.reader r ON ((v.nchit = r.nchit)));


ALTER VIEW public."кто_что_брал2" OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 16436)
-- Dependencies: 222
-- Data for Name: authorship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorship (isbn, id_author) FROM stdin;
111	1
222	2
333	3
444	3
555	4
777	5
888	7
888	6
666	1
999	8
700	8
800	1
900	16
\.


--
-- TOC entry 4925 (class 0 OID 16419)
-- Dependencies: 220
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autor (id, fio, penname) FROM stdin;
1	Народные сказки	\N
2	Носов	\N
3	Успенский	\N
4	Маршак	\N
5	Роулинг	\N
6	Стругацкий А	\N
7	Стругацкий Б	\N
8	Верн	\N
9	Оруэлл	\N
10	Даррелл	\N
11	Чейни	Джек Лондон
12	Байрон	нет псевдонима
13	Лукьяненко	\N
16	Толкин	\N
\.


--
-- TOC entry 4926 (class 0 OID 16429)
-- Dependencies: 221
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (isbn, title, year) FROM stdin;
111	Колобок	1885
222	Незнайка	1985
333	Крокодил Гена	1976
444	Простоквашино	1995
555	Чиполлино	1973
666	Дом, который построил Джек	1990
777	Гарри Поттер	2003
888	Пикник на обочине	2000
700	Таинственный остров	1987
999	Дети капитана Гранта	1973
800	Неизвестное	1960
900	Властелин колец	2015
789	Пятнадцатилетний капитан	1990
487	СОЛЯРИС	2024
133	1984	1984
\.


--
-- TOC entry 4931 (class 0 OID 16476)
-- Dependencies: 226
-- Data for Name: exemplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exemplar (id, isbn, condition) FROM stdin;
1	111	пометки на полях
2	111	рваные страницы
3	222	новое
4	222	обложка помята
5	900	хорошее
6	900	\N
7	900	\N
\.


--
-- TOC entry 4928 (class 0 OID 16446)
-- Dependencies: 223
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (name) FROM stdin;
Фантастика
Детектив
Народные сказки
Драма
Детская литература
Философский роман
Научная фантастика
Политическая экономия
Приключения
\.


--
-- TOC entry 4929 (class 0 OID 16453)
-- Dependencies: 224
-- Data for Name: genre_affiliation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre_affiliation (isbn, name_genre) FROM stdin;
777	Фантастика
111	Народные сказки
222	Детская литература
333	Детская литература
444	Детская литература
555	Драма
666	Драма
888	Философский роман
222	Политическая экономия
222	Фантастика
700	Приключения
\.


--
-- TOC entry 4922 (class 0 OID 16405)
-- Dependencies: 217
-- Data for Name: reader; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reader (nchit, fio) FROM stdin;
1	Иванов
5	Кукушкина
6	Чапаев
7	Зайцева
8	Зимина
9	Циркулев
10	Яковлев
11	Пупкин Василий
12	Декарт
13	Юдашкин
14	Пожарский
15	Южалин
16	Сюткин
17	Иванов Максим
18	Игнатьева
2	Петров$1
4	Федоров$1
3	Смородин$3
\.


--
-- TOC entry 4932 (class 0 OID 16488)
-- Dependencies: 227
-- Data for Name: vydacha; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vydacha (nchit, id_ex, date_out, date_in, period) FROM stdin;
2	2	2024-10-10	\N	10
10	3	2024-10-01	2024-10-02	10
15	4	2024-09-05	2024-09-11	10
16	3	2023-09-03	2023-09-07	10
17	3	2024-09-03	2024-09-13	10
3	1	2024-09-20	2024-09-25	10
17	1	2024-10-05	2024-11-04	10
1	1	2024-08-29	2024-09-11	10
4	4	2024-09-05	2024-09-11	10
6	3	2024-09-03	2024-09-13	10
14	1	2024-08-29	2024-09-11	10
3	4	2024-10-28	\N	10
3	3	2024-10-28	\N	10
3	6	2024-10-28	\N	10
12	2	2024-10-10	2024-10-29	10
1	1	2024-09-12	2024-10-29	10
7	7	2024-10-30	2024-10-30	10
4	5	2024-09-30	2024-10-30	30
\.


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 219
-- Name: autor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autor_id_seq', 16, true);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 225
-- Name: exemplar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exemplar_id_seq', 7, true);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 218
-- Name: reader_nchit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reader_nchit_seq', 22, true);


--
-- TOC entry 4757 (class 2606 OID 16440)
-- Name: authorship authorship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_pkey PRIMARY KEY (isbn, id_author);


--
-- TOC entry 4753 (class 2606 OID 16425)
-- Name: autor autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 16435)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (isbn);


--
-- TOC entry 4763 (class 2606 OID 16482)
-- Name: exemplar exemplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT exemplar_pkey PRIMARY KEY (id);


--
-- TOC entry 4761 (class 2606 OID 16459)
-- Name: genre_affiliation genre_affiliation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_affiliation
    ADD CONSTRAINT genre_affiliation_pkey PRIMARY KEY (isbn, name_genre);


--
-- TOC entry 4759 (class 2606 OID 16452)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (name);


--
-- TOC entry 4751 (class 2606 OID 16415)
-- Name: reader reader_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reader
    ADD CONSTRAINT reader_pk PRIMARY KEY (nchit);


--
-- TOC entry 4765 (class 2606 OID 16493)
-- Name: vydacha vydacha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vydacha
    ADD CONSTRAINT vydacha_pkey PRIMARY KEY (nchit, id_ex, date_out);


--
-- TOC entry 4766 (class 2606 OID 16441)
-- Name: authorship authorship_autor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_autor_fk FOREIGN KEY (id_author) REFERENCES public.autor(id);


--
-- TOC entry 4767 (class 2606 OID 16470)
-- Name: authorship authorship_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_book_fk FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 4770 (class 2606 OID 16483)
-- Name: exemplar ex_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT ex_book_fk FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 4768 (class 2606 OID 16460)
-- Name: genre_affiliation genre_affiliation_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_affiliation
    ADD CONSTRAINT genre_affiliation_book_fk FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 4769 (class 2606 OID 16465)
-- Name: genre_affiliation genre_affiliation_genre_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_affiliation
    ADD CONSTRAINT genre_affiliation_genre_fk FOREIGN KEY (name_genre) REFERENCES public.genre(name);


--
-- TOC entry 4771 (class 2606 OID 16499)
-- Name: vydacha vyd_exemplar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vydacha
    ADD CONSTRAINT vyd_exemplar_fk FOREIGN KEY (id_ex) REFERENCES public.exemplar(id);


--
-- TOC entry 4772 (class 2606 OID 16494)
-- Name: vydacha vyd_reader_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vydacha
    ADD CONSTRAINT vyd_reader_fk FOREIGN KEY (nchit) REFERENCES public.reader(nchit);


-- Completed on 2024-10-31 09:39:38

--
-- PostgreSQL database dump complete
--

