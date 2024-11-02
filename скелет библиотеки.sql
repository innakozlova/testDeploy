--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-10-16 11:57:07

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
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


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
-- TOC entry 223 (class 1259 OID 16446)
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    name character varying NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

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
-- TOC entry 4900 (class 0 OID 16436)
-- Dependencies: 222
-- Data for Name: authorship; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4898 (class 0 OID 16419)
-- Dependencies: 220
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4899 (class 0 OID 16429)
-- Dependencies: 221
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--




--
-- TOC entry 4904 (class 0 OID 16476)
-- Dependencies: 226
-- Data for Name: exemplar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4901 (class 0 OID 16446)
-- Dependencies: 223
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4902 (class 0 OID 16453)
-- Dependencies: 224
-- Data for Name: genre_affiliation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4895 (class 0 OID 16405)
-- Dependencies: 217
-- Data for Name: reader; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4905 (class 0 OID 16488)
-- Dependencies: 227
-- Data for Name: vydacha; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 219
-- Name: autor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autor_id_seq', 5, true);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 225
-- Name: exemplar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exemplar_id_seq', 4, true);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 218
-- Name: reader_nchit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reader_nchit_seq', 4, true);


--
-- TOC entry 4734 (class 2606 OID 16440)
-- Name: authorship authorship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_pkey PRIMARY KEY (isbn, id_author);


--
-- TOC entry 4730 (class 2606 OID 16425)
-- Name: autor autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);


--
-- TOC entry 4732 (class 2606 OID 16435)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (isbn);


--
-- TOC entry 4740 (class 2606 OID 16482)
-- Name: exemplar exemplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT exemplar_pkey PRIMARY KEY (id);


--
-- TOC entry 4738 (class 2606 OID 16459)
-- Name: genre_affiliation genre_affiliation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_affiliation
    ADD CONSTRAINT genre_affiliation_pkey PRIMARY KEY (isbn, name_genre);


--
-- TOC entry 4736 (class 2606 OID 16452)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (name);


--
-- TOC entry 4728 (class 2606 OID 16415)
-- Name: reader reader_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reader
    ADD CONSTRAINT reader_pk PRIMARY KEY (nchit);


--
-- TOC entry 4742 (class 2606 OID 16493)
-- Name: vydacha vydacha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vydacha
    ADD CONSTRAINT vydacha_pkey PRIMARY KEY (nchit, id_ex, date_out);


--
-- TOC entry 4743 (class 2606 OID 16441)
-- Name: authorship authorship_autor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_autor_fk FOREIGN KEY (id_author) REFERENCES public.autor(id);


--
-- TOC entry 4744 (class 2606 OID 16470)
-- Name: authorship authorship_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorship
    ADD CONSTRAINT authorship_book_fk FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 4747 (class 2606 OID 16483)
-- Name: exemplar ex_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT ex_book_fk FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 4745 (class 2606 OID 16460)
-- Name: genre_affiliation genre_affiliation_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_affiliation
    ADD CONSTRAINT genre_affiliation_book_fk FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 4746 (class 2606 OID 16465)
-- Name: genre_affiliation genre_affiliation_genre_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_affiliation
    ADD CONSTRAINT genre_affiliation_genre_fk FOREIGN KEY (name_genre) REFERENCES public.genre(name);


--
-- TOC entry 4748 (class 2606 OID 16499)
-- Name: vydacha vyd_exemplar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vydacha
    ADD CONSTRAINT vyd_exemplar_fk FOREIGN KEY (id_ex) REFERENCES public.exemplar(id);


--
-- TOC entry 4749 (class 2606 OID 16494)
-- Name: vydacha vyd_reader_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vydacha
    ADD CONSTRAINT vyd_reader_fk FOREIGN KEY (nchit) REFERENCES public.reader(nchit);


-- Completed on 2024-10-16 11:57:07

--
-- PostgreSQL database dump complete
--

