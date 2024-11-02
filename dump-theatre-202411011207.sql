--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-11-01 12:07:39

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
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16673)
-- Name: cast; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."cast" (
    id integer NOT NULL,
    id_actor integer,
    id_role integer,
    staff character varying
);


ALTER TABLE public."cast" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16672)
-- Name: cast_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."cast" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cast_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16681)
-- Name: director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director (
    id integer NOT NULL,
    fio character varying NOT NULL
);


ALTER TABLE public.director OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16680)
-- Name: director_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.director ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.director_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16638)
-- Name: play; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.play (
    id integer NOT NULL,
    neme character varying,
    id_dir character varying,
    main_role character varying
);


ALTER TABLE public.play OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16637)
-- Name: play_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.play ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.play_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16665)
-- Name: repertoire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.repertoire (
    id integer NOT NULL,
    id_play integer,
    date date NOT NULL,
    staff character varying,
    stage character varying,
    "time" time without time zone NOT NULL
);


ALTER TABLE public.repertoire OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16664)
-- Name: repertoire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.repertoire ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.repertoire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16646)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    "character" character varying NOT NULL,
    id_play integer NOT NULL,
    temper character varying NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16645)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.role ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16657)
-- Name: troupe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.troupe (
    id integer NOT NULL,
    fio character varying NOT NULL,
    age smallint[] NOT NULL,
    type_of_appearance character varying NOT NULL,
    vocal_skills character varying,
    choreographic_skills character varying NOT NULL,
    gender character varying NOT NULL
);


ALTER TABLE public.troupe OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16656)
-- Name: troup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.troupe ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.troup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4888 (class 0 OID 16673)
-- Dependencies: 226
-- Data for Name: cast; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4890 (class 0 OID 16681)
-- Dependencies: 228
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4880 (class 0 OID 16638)
-- Dependencies: 218
-- Data for Name: play; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4886 (class 0 OID 16665)
-- Dependencies: 224
-- Data for Name: repertoire; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4882 (class 0 OID 16646)
-- Dependencies: 220
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4884 (class 0 OID 16657)
-- Dependencies: 222
-- Data for Name: troupe; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 225
-- Name: cast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cast_id_seq', 1, false);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 227
-- Name: director_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.director_id_seq', 1, false);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 217
-- Name: play_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.play_id_seq', 1, false);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 223
-- Name: repertoire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.repertoire_id_seq', 1, false);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 219
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 221
-- Name: troup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.troup_id_seq', 1, false);


--
-- TOC entry 4729 (class 2606 OID 16679)
-- Name: cast cast_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."cast"
    ADD CONSTRAINT cast_pk PRIMARY KEY (id);


--
-- TOC entry 4731 (class 2606 OID 16687)
-- Name: director director_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pk PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 16644)
-- Name: play play_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.play
    ADD CONSTRAINT play_pk PRIMARY KEY (id);


--
-- TOC entry 4727 (class 2606 OID 16671)
-- Name: repertoire repertoire_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.repertoire
    ADD CONSTRAINT repertoire_pk PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 16652)
-- Name: role role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 4725 (class 2606 OID 16663)
-- Name: troupe troup_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.troupe
    ADD CONSTRAINT troup_pk PRIMARY KEY (id);


--
-- TOC entry 4732 (class 2606 OID 16693)
-- Name: cast cast_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."cast"
    ADD CONSTRAINT cast_role_fk FOREIGN KEY (id_role) REFERENCES public.role(id);


--
-- TOC entry 4733 (class 2606 OID 16688)
-- Name: cast cast_troupe_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."cast"
    ADD CONSTRAINT cast_troupe_fk FOREIGN KEY (id_actor) REFERENCES public.troupe(id);


-- Completed on 2024-11-01 12:07:40

--
-- PostgreSQL database dump complete
--

