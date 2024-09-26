--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: link; Type: TABLE; Schema: public; Owner: movieapp
--

CREATE TABLE public.link (
    label character varying NOT NULL,
    url character varying(2048) NOT NULL,
    image character varying,
    movie_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.link OWNER TO movieapp;

--
-- Name: link_id_seq; Type: SEQUENCE; Schema: public; Owner: movieapp
--

CREATE SEQUENCE public.link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.link_id_seq OWNER TO movieapp;

--
-- Name: link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: movieapp
--

ALTER SEQUENCE public.link_id_seq OWNED BY public.link.id;


--
-- Name: movie; Type: TABLE; Schema: public; Owner: movieapp
--

CREATE TABLE public.movie (
    title character varying NOT NULL,
    runtime integer NOT NULL,
    release_year integer NOT NULL,
    rating integer,
    id integer NOT NULL,
    CONSTRAINT movie_rating_check CHECK (((rating >= 0) AND (rating <= 1000)))
);


ALTER TABLE public.movie OWNER TO movieapp;

--
-- Name: movie_id_seq; Type: SEQUENCE; Schema: public; Owner: movieapp
--

CREATE SEQUENCE public.movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_id_seq OWNER TO movieapp;

--
-- Name: movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: movieapp
--

ALTER SEQUENCE public.movie_id_seq OWNED BY public.movie.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: movieapp
--

CREATE TABLE public.tag (
    name character varying NOT NULL,
    category character varying NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.tag OWNER TO movieapp;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: movieapp
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO movieapp;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: movieapp
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: tagged_movie; Type: TABLE; Schema: public; Owner: movieapp
--

CREATE TABLE public.tagged_movie (
    movie_id integer NOT NULL,
    tag_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.tagged_movie OWNER TO movieapp;

--
-- Name: tagged_movie_id_seq; Type: SEQUENCE; Schema: public; Owner: movieapp
--

CREATE SEQUENCE public.tagged_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tagged_movie_id_seq OWNER TO movieapp;

--
-- Name: tagged_movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: movieapp
--

ALTER SEQUENCE public.tagged_movie_id_seq OWNED BY public.tagged_movie.id;


--
-- Name: link id; Type: DEFAULT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.link ALTER COLUMN id SET DEFAULT nextval('public.link_id_seq'::regclass);


--
-- Name: movie id; Type: DEFAULT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.movie ALTER COLUMN id SET DEFAULT nextval('public.movie_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: tagged_movie id; Type: DEFAULT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tagged_movie ALTER COLUMN id SET DEFAULT nextval('public.tagged_movie_id_seq'::regclass);


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: movieapp
--

COPY public.link (label, url, image, movie_id, id) FROM stdin;
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTI0OTdhMzMtMjdlYi00M2M3LTlmMmMtOGE1ODJkNmEyZGFlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	2	2
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNWQzZmVhYWUtYWNlMC00MmU0LThmY2YtYTI3MTI1ZmJmZDNlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	3	3
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjc4NDY3MWYtNDNhNC00YjI0LThhM2UtZjgzNmUxOWFiODRjXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	4	4
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNGFhM2VhOTktOGYxOC00Yjc3LTlmMzEtZDZhYzAwYjVlYjVlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	5	5
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzk0NDRmMzQtZTQwMC00YzdkLTgxZGEtMTQ2YTU2ODNmYTZhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	6	6
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjc4Yzg4ZWItMGVmNi00ZjFjLWI2ZDYtNzc2ODBmNTY4NzExXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	7	7
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTYxZTIzYjMtMTdmNi00ZGM2LTg3NGItMWU2ZDYyYWRlMzkwXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	8	8
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNDNkYmQ4NDMtZTI3ZS00NzkzLTk2OWUtN2I5MDcwYWQ1M2E5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	9	9
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYmUwNjA1N2QtYWY1Zi00MDZiLTlkZjUtZDA5NTFlZjU1ZTNmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	10	10
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTEzMjgxNjk3MDZeQTJeQWpwZ15BbWU4MDUzNjg2MTUz.UX400.jpg&w=3840&q=75	\N	11	11
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYjgwNjU5YzUtNjlkMy00NDY3LWI4OTYtMTU2NTAyOTU4MmRkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	12	12
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYTc4MWZiZTAtOTdjMy00NTVlLTkyZGQtOTFmMjI1MjNmOTExXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	13	13
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYjc0MmY4N2ItYjE3NC00YmVjLTk0ZGUtODg0MTNmNWRjY2E2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	14	14
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDkwZTMwMTctYjBkMS00ZTExLWIzM2QtMWU3ODAxYTAwNWI1XkEyXkFqcGdeQXVyODA3NjUxNTM%40.UX400.jpg&w=3840&q=75	\N	15	15
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDM3ZDg4OGMtMGEwZi00ODIzLTllZjAtMDIzYjU2Y2YzN2E5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	16	16
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZThiYmEyNDQtMzU4Zi00NzY3LTljYTgtOTNjYzU1NGFiNDA0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	17	17
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTAzMTkyNzk4MDdeQTJeQWpwZ15BbWU3MDMxMTE0MTg%40.UX400.jpg&w=3840&q=75	\N	18	18
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDg1NzlkMTEtMmRhMy00ZmM2LTk4ZjYtZTBmODZhNDI2M2YyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	19	19
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYmY5OTlmNTAtNWY3NC00OTIxLTg1N2QtMGE3MTJkNTgyMDA3XkEyXkFqcGdeQXVyMDAyMjM2OQ%40%40.UX400.jpg&w=3840&q=75	\N	20	20
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2Y4NmFjMGYtNjZmOS00OGUwLWI5YjAtYjJlOWVkNjlhMGUxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	21	21
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDU1N2U5NTItODI0ZC00YWM2LTg2NDMtZjY2NjMyMGIwODFhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	22	22
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDdjNmM0ZmYtNjQ3ZS00ZmM4LTgwMjktMzZiNTJhY2IzYjEzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	23	23
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzRiZjc3YzUtNWNiZC00ZjgwLWExNjUtOThhMzcwOGE1ZTY0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	24	24
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjE1NDY0NDk3Ml5BMl5BanBnXkFtZTcwMTAzMTM3NA%40%40.UX400.jpg&w=3840&q=75	\N	25	25
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZjY1ZDEzNDQtMDRlYS00YTMxLWFjMjEtMTk4NmNlYmM5YzYzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	26	26
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjIwYzBjYWItOGQwNS00ZGZiLTk4ZWMtZmQxNzYyNTZiYmI3XkEyXkFqcGdeQXVyNzI2ODAwMzM%40.UX400.jpg&w=3840&q=75	\N	27	27
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDUwZjdlZjAtNzVhYi00NTBkLTg3MWYtNzM1MDYwZDMzOWEzXkEyXkFqcGdeQXVyMjYzNTk1NTE%40.UX400.jpg&w=3840&q=75	\N	28	28
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzJiYmE2MmMtZDVjZC00ZTU2LWFlNDUtOWE2NjkzZDE5MGM4XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	29	29
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZWJjNTExN2EtOGY4Yy00OWZjLWIzNWUtNmM1NmE3MTMxNDgwXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	30	30
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZmNiMDhlNzMtMDBmOS00Nzg4LTkzNzYtNDAzNTE1NGFhNmVkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	31	31
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTk0NzM3MDY1OV5BMl5BanBnXkFtZTYwNTkwODc5.UX400.jpg&w=3840&q=75	\N	32	32
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODkwNzc4ODYtMWJmMS00N2NkLTgxYWEtMzM3MmIwMWJlMGVjXkEyXkFqcGdeQXVyNDgyODgxNjE%40.UX400.jpg&w=3840&q=75	\N	33	33
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BM2E2Y2Q2OGYtZmExYi00MGM5LTg4MzItYjk5NjI0MjgwY2JlXkEyXkFqcGdeQXVyMTQ3Njg3MQ%40%40.UX400.jpg&w=3840&q=75	\N	34	34
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZWRlZmRhM2EtZGY4Mi00NGRkLWIxNGEtNmU3YzE2NGI4OWU1XkEyXkFqcGdeQXVyOTg4MDYyNw%40%40.UX400.jpg&w=3840&q=75	\N	35	35
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMGIwYzE1MGYtNzUwMy00Y2I1LWJhMDMtNDNkMTQ1YmRhZjI0XkEyXkFqcGdeQXVyNDAzNDkxNTU%40.UX400.jpg&w=3840&q=75	\N	36	36
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTU4ZWFhNmYtYWQzYi00NTBhLTliYWUtZmM1ZWJiOTNiOGFkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	37	37
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYjdmNDMyY2QtZGNiYy00YmIwLTg1MmYtNDBkNWMxNzcyZTk3XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	38	38
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTQ3NzE3NjM0Ml5BMl5BanBnXkFtZTcwNjQ1NjgxMQ%40%40.UX400.jpg&w=3840&q=75	\N	39	39
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODJmZDgyMjItNzI1Mi00ZjdiLWFiOGEtMmE1NDJmYjZlY2E1XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	40	40
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDljNWE4YTEtMWIwYi00NTY3LWFjNTYtMTI3NWEyMzI5NDM5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	41	41
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODRmMjliN2UtZTUyZS00ZjQ5LWFlZmQtNmU0MmYzYjBjN2M5XkEyXkFqcGdeQXVyMTY5Nzc4MDY%40.UX400.jpg&w=3840&q=75	\N	42	42
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYjE2NDE2M2QtNzE1My00YTViLWJhOTItMzhlZTNlYTZiNDdiXkEyXkFqcGdeQXVyNTAyODkwOQ%40%40.UX400.jpg&w=3840&q=75	\N	43	43
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzU3YzNlZGYtNTE4YS00NWY0LWJhYTgtYWI5Y2E4MGZlODAyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	44	44
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMGE2Y2YxNTktMjg2YS00Y2ZlLWJkNzUtZTQ0ZGMwMGJmMDhmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	45	45
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZWU1MmFlN2QtMDg2ZC00MThmLTkxMDktZjE3YzkyYmE2NTNkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	46	46
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWFkNzIzNDUtNWI1Mi00ODA2LTgyMTMtYTZiYWMxMDFlNmNhL2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ%40%40.UX400.jpg&w=3840&q=75	\N	47	47
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNDYyNzNmODctMzA5NS00ZGNiLWJjM2MtMzVmNzk2MGVhNmYzXkEyXkFqcGdeQXVyMjUyNzM5MDA%40.UX400.jpg&w=3840&q=75	\N	48	48
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOGJmNDM3MjAtMzYyZC00ZTE1LWE0MjgtZjk0YTAwMDhjNGIwL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY%40.UX400.jpg&w=3840&q=75	\N	49	49
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNGIzOWVhMDMtYmU2MS00MmFhLWI3ODEtMDQwODc0MjI4NWVlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	50	50
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMGZkOTY5YzMtZWQzYS00NzE0LThhM2QtMzU4OGNkYTcyZDJlXkEyXkFqcGdeQXVyMTUzMDUzNTI3.UX400.jpg&w=3840&q=75	\N	51	51
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDM0YTM3Y2UtNzY5MC00OTc4LThhZTYtMmM0ZGZjMmU1ZjdmXkEyXkFqcGdeQXVyNjc1NTYyMjg%40.UX400.jpg&w=3840&q=75	\N	52	52
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BM2M1MGQyNjgtYWQ2My00MDViLWFkMDMtOTY2NDc0OTcxN2RlXkEyXkFqcGdeQXVyODE5NzE3OTE%40.UX400.jpg&w=3840&q=75	\N	53	53
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODIzOGNmODEtYzA5OS00MWJiLTkyOGEtYmMyNTQwN2MzMTY5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	54	54
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2U4OGUxMDYtMjczOC00ZTZmLWI4MzYtYTkyZjc2OGMxMDI1XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	55	55
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzk4MmZmODgtNzNjMi00ZTQyLWEwZjgtMzI3NjRlNTA2MWZmXkEyXkFqcGdeQXVyNzc5MjA3OA%40%40.UX400.jpg&w=3840&q=75	\N	56	56
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYmYyNDQ3ZTUtMTFmMi00NDBmLTkyNTAtNmIwZWJlMDY0ZTZmXkEyXkFqcGdeQXVyMTY5Nzc4MDY%40.UX400.jpg&w=3840&q=75	\N	57	57
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGFmNmRlNjQtZGQ4YS00YjA3LWJkZWQtYjViNjAxNmFkZGJlXkEyXkFqcGdeQXVyMjk4MTY4NzY%40.UX400.jpg&w=3840&q=75	\N	58	58
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNGZmMmMxY2MtY2Y4NS00Y2JmLTg1YmQtNzBjNDczYjUyZjgzXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	59	59
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNmU5M2E2ODktOWJlNi00YTM0LTgzNzMtM2JhNGUyYzM4Mzg1XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	60	60
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDFkZjZlMDAtYjc1YS00ZTE4LTkzOWMtMzAxM2RiNmVhZmFmXkEyXkFqcGdeQXVyNTEyNTE5Mjk%40.UX400.jpg&w=3840&q=75	\N	61	61
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BN2I4OGYxN2UtM2NkNS00ZjBmLWFmYmEtZGE2MzhmNTQyZGIxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	62	62
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTIxNzcxMTg5MF5BMl5BanBnXkFtZTcwNzYxOTI0MQ%40%40.UX400.jpg&w=3840&q=75	\N	63	63
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTY0Y2E3YWYtMzQ2NC00Y2U2LWEzYmMtOWJlZTY5YzE3Mzk0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	64	64
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDVhYjg5OGEtYjZkZS00YjBmLTljMzItOWMxMmQ4N2YwNjliXkEyXkFqcGdeQXVyMTA0MjU0Ng%40%40.UX400.jpg&w=3840&q=75	\N	65	65
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOGZhYTFhZDEtNDFhYy00OWFkLThkM2MtMDM2NmQwOTVkNjZjXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	66	66
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjFhMmMwMjAtZTZmNi00NmQ5LWE0ZTItZTM4Njc3YzEwNmExXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	67	67
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWMzNTI0NTYtOGNhMy00YWZhLWI1MjQtNGRjZGY4M2QzNmEyXkEyXkFqcGdeQXVyMTI1Mzg0ODA5.UX400.jpg&w=3840&q=75	\N	68	68
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMGJhYjk2NWMtODBkNC00NjEwLWE2NGUtYjYwZDFkNjc2YzU0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	69	69
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTg2MDA1ODQyMl5BMl5BanBnXkFtZTgwNDY1NDc2MTE%40.UX400.jpg&w=3840&q=75	\N	70	70
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BM2E4OTc4MGMtYmE3My00ZTE5LWE5ZTMtMDg1MGYyNzdiNzFkXkEyXkFqcGdeQXVyMDI2NDg0NQ%40%40.UX400.jpg&w=3840&q=75	\N	71	71
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZjQzZTIzY2EtYmQwZC00NGRkLTg3NGUtYjIwM2YzYzNiZDM1XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	72	72
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOWNhNzc5MGEtMWUyNi00ZDg0LThiNjItOThmYjg2MGZlYWQ1L2ltYWdlXkEyXkFqcGdeQXVyNDU5NDI3NjQ%40.UX400.jpg&w=3840&q=75	\N	73	73
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWE0ZjI1NjYtOGU0Ni00NmJiLWI5ZmQtM2JlOTMzM2I5ZDIwXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	74	74
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGI2ZDg1ODAtZDE0Ni00MzJjLTkzMzYtNDY5OWY4ZmIyZTVkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	75	75
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGVhZTkzMzEtOWM0ZC00OTliLTkwNzktMDkxNzRmM2ViYjVlXkEyXkFqcGdeQXVyMjcxNjI4NTk%40.UX400.jpg&w=3840&q=75	\N	76	76
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2IxN2ZjNzgtNGRmNS00ZjQ5LWI0OGEtNThmM2FlOGE2ZWUzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	77	77
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNWIwOTVmMDktNjIzYS00Yzc1LTk0Y2MtYzFhMzUwZjNiOWQ4XkEyXkFqcGdeQXVyMTEzNzg0Mjkx.UX400.jpg&w=3840&q=75	\N	78	78
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTQwMDA2MjA3MV5BMl5BanBnXkFtZTcwODU3NTQ5OQ%40%40.UX400.jpg&w=3840&q=75	\N	79	79
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWUzMzY2NmMtODdhOS00YTQwLTkwZGYtNmU0ZTQ0YjYwODFkXkEyXkFqcGdeQXVyMzg1ODEwNQ%40%40.UX400.jpg&w=3840&q=75	\N	80	80
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODNjNWI1OTEtOGE0Mi00ZDQwLWJiOTktZWIzYWNjYTIzOWIzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	81	81
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOGI3ZDZlNjctZmM4YS00ZGEwLTg0NjktM2EyYzU2NWEwZDM5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	82	82
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGEwZGQxYmMtM2MzMS00Yzk5LWJhNGItYzA3NjRiZDQzMmM4XkEyXkFqcGdeQXVyMTIxMzA5MDI%40.UX400.jpg&w=3840&q=75	\N	83	83
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGZhYTQ4NTEtMDNlMy00Y2Q2LWFhZGEtM2RhZjE5YzNmYTYyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	84	84
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BN2U4NThhY2MtNzczNS00NmEzLWEyNjAtMTBlZDEwM2VlYzkwXkEyXkFqcGdeQXVyNTQwNzI4MzE%40.UX400.jpg&w=3840&q=75	\N	85	85
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNDE1MzJlNWEtY2E1ZC00OTFiLWEwYWQtMDYyMWM5MDhkODNkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	86	86
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZTdmMTcwMmEtMDJkOS00N2JiLWI5YzAtNTM1NTk5M2U5NWFlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	87	87
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTY4NDQzNzkxNl5BMl5BanBnXkFtZTcwODMzMjI3NA%40%40.UX400.jpg&w=3840&q=75	\N	88	88
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTkzNzQwNDQ0M15BMl5BanBnXkFtZTcwNTc5MDQxOA%40%40.UX400.jpg&w=3840&q=75	\N	89	89
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNmYwMWE2NDktMTYzZi00YzljLTk4NzEtZThmZTJlNjNjZDc3XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	90	90
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjNlNGEyM2QtODk4MC00ZjRlLWFkYjEtYjk0MTcyMjJiZjdkXkEyXkFqcGdeQXVyOTY0NzE2NTU%40.UX400.jpg&w=3840&q=75	\N	91	91
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYWIyNGE3MWQtNjI3ZC00MDQzLTg0OTQtYTIzYmI1MjQ1ZGNkXkEyXkFqcGdeQXVyOTI2MjI5MQ%40%40.UX400.jpg&w=3840&q=75	\N	92	92
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTM4NDgwNjU4Ml5BMl5BanBnXkFtZTgwNzU2OTI1MDE%40.UX400.jpg&w=3840&q=75	\N	93	93
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjEyMzM4ODg4N15BMl5BanBnXkFtZTgwMjQ4NzEwMjE%40.UX400.jpg&w=3840&q=75	\N	94	94
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNDllOGZkYTQtZGE1MC00MWM2LTgzMTMtMTNmZGYzNWUyOWRjXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	95	95
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzIwNDQ2N2EtODAyOS00MmVmLTkxMzktMDEwZGFmMGNhMDI1XkEyXkFqcGdeQXVyNDUxNjc5NjY%40.UX400.jpg&w=3840&q=75	\N	96	96
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZWYxNDhjNGUtNDgwYi00ZjBkLTljYWMtMjQ0NWY4N2JkNmRmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	97	97
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzU4OGI2OGUtNDEzNS00OWEzLTgyYzAtMDYyYmIxNjI4NmFmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	98	98
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BM2Q4Njk3NGQtYWI1Zi00MDQ3LThjNTgtZjZjMzQ1NWYxYmQ1XkEyXkFqcGdeQXVyMDgzNjI3MA%40%40.UX400.jpg&w=3840&q=75	\N	99	99
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODM1YzVlYmItNDJmYi00MzIzLTgyMjUtMWEzMGUwZWM3MGIxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	100	100
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTkxNzgyMzExMF5BMl5BanBnXkFtZTgwMTI2OTI3MjE%40.UX400.jpg&w=3840&q=75	\N	101	101
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTQ2MjI3NDA3MF5BMl5BanBnXkFtZTgwMjcxMzk3MTE%40.UX400.jpg&w=3840&q=75	\N	102	102
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjI1ODczNjAyOF5BMl5BanBnXkFtZTgwODE0MDYyMTE%40.UX400.jpg&w=3840&q=75	\N	103	103
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2RiMTYwYTAtNTQ5ZS00NDNiLWI3NjctN2VlOTc3YmVhMDVmXkEyXkFqcGdeQXVyNjk2MjAwOTg%40.UX400.jpg&w=3840&q=75	\N	104	104
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTE0ZDYxZjItNmI0Mi00YjA4LTk2NDctZWM1MjY3Y2UxY2FiXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	105	105
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZmMwOWE1ZmEtNzZkYy00MGI1LWE4OTEtZGQ5Y2M5YTc4MzQ0XkEyXkFqcGdeQXVyMzIwNjE0MzY%40.UX400.jpg&w=3840&q=75	\N	106	106
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNWI4MTFmZTYtOWYwYS00MWJjLWFjZWQtYzBkOGY3YWZmYTM3XkEyXkFqcGdeQXVyMjQzMzQzODY%40.UX400.jpg&w=3840&q=75	\N	107	107
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzVhMmZkYjMtMjY2ZC00NmQ5LWEzYzYtMDE3Zjg1ZDc3ODNhXkEyXkFqcGdeQXVyNjc5NjEzNA%40%40.UX400.jpg&w=3840&q=75	\N	108	108
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNmZiNGFkODAtNTU0ZS00NmZmLWEzMTYtMDM2ZmE0YzlhYTRhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	109	109
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZjM5OTVkMDEtZWU1ZS00ODExLWE0MjktNDE4MTQ5NDk2NmMwXkEyXkFqcGdeQXVyNDc2NjEyMw%40%40.UX400.jpg&w=3840&q=75	\N	110	110
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZjYyNDMyYjYtMDk5MC00MTM1LTg1M2MtMTExYzA1YTYwYTViXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	111	111
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTk4YzQxZDQtZjExMS00ZDM2LWI2NjctOWNkZjhkYzg3MWY3XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	112	112
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDE1ZjNjNzUtNmU2OC00ZWU1LWFkZmUtN2UwMWMwNzEzYTdjXkEyXkFqcGdeQXVyMTA4NjE0NjEy.UX400.jpg&w=3840&q=75	\N	113	113
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjA0NzczOTMwMV5BMl5BanBnXkFtZTcwNDY4MzcyNA%40%40.UX400.jpg&w=3840&q=75	\N	114	114
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BN2QxYmExOGYtM2VkMi00Y2E3LTg0OTYtZWUwYjA2MTk3YWI1XkEyXkFqcGdeQXVyMTM2MzAwOA%40%40.UX400.jpg&w=3840&q=75	\N	115	115
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTc2ZmQwMDctZjBkYS00ZTg5LTk2MzUtMDVhOTRkNDM3OGI2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	116	116
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTBlNTliNTItY2VhNS00MjA5LTllYzItMmQyNGRjYTAyZWQxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	117	117
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTk4MDg2ODk4Ml5BMl5BanBnXkFtZTcwODY4NDQzMQ%40%40.UX400.jpg&w=3840&q=75	\N	118	118
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTg5NDk3MTM1NV5BMl5BanBnXkFtZTcwMTEyNTgyMQ%40%40.UX400.jpg&w=3840&q=75	\N	119	119
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjFhYjczOWEtM2VkZS00MWNlLWJmY2YtMTQwOWNhYzcwYzlmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	120	120
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTUxOTg5NjQ3Ml5BMl5BanBnXkFtZTcwMjkxMzA3Nw%40%40.UX400.jpg&w=3840&q=75	\N	121	121
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDIwNzY3ZWItODBlNC00ZTU2LThlODUtOTViM2NhOTcyNDg0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	122	122
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOWVkZWQ5YTEtNjYyZS00NmJjLWE5NTktZDc2MWVlMGIwM2I0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	123	123
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDljMzBjMWUtMDk3Ni00NzNiLTg1NjMtZGU3NzY4YTJmOWI1XkEyXkFqcGdeQXVyMTAyNDU2NDM%40.UX400.jpg&w=3840&q=75	\N	124	124
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWRhMTY4NTgtYTljZi00ZGQzLWE3NWMtMmNjNzRkZmUyZjIyXkEyXkFqcGdeQXVyNjc1NTYyMjg%40.UX400.jpg&w=3840&q=75	\N	125	125
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzE5NTAyYWUtYTc5OS00YmIyLWExMTQtZGNjYTljYTUyNzRhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	126	126
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTY3NTA5ZjktMDI3MS00Y2JlLTg3ZTAtZDdlZDdkNzMwMjI2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	127	127
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzBkMzAyMDUtZTFkZS00OWUyLTgwM2ItNGI3MTQ5NzA3NTVkXkEyXkFqcGdeQXVyMTkxNjUyNQ%40%40.UX400.jpg&w=3840&q=75	\N	128	128
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTAyYjljNDctODg5Mi00YjYxLTk5MTMtZTk3MDk4NGZkN2MwXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	129	129
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzk3MTFmZjQtMjY2Ni00MGM5LWJlOTgtYTM1NDM0YWUwNTI4XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	130	130
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjZkODBmMTEtMTMwNC00OWY0LWFkOTgtOWY0MTNjNzdhN2UyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	131	131
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzM5MjRhN2YtZTBmZi00ODA0LWEzZWUtZmQwMTUxMjAyZDIxXkEyXkFqcGdeQXVyNzgzODI1OTE%40.UX400.jpg&w=3840&q=75	\N	132	132
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2ZiMjFkNDEtMTY5Mi00NTA1LTllOGQtZGI1NWI4MGQ2NjBlXkEyXkFqcGdeQXVyMDI2NDg0NQ%40%40.UX400.jpg&w=3840&q=75	\N	133	133
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWM0MDljMzQtNDE2Zi00OWUwLWJkZDEtZDcwMDgxY2FkYmFiXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	134	134
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZTA1ZDczNjktZjRiYS00MjE4LTgwNWEtYjFjNzcwNzBjMTVmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	135	135
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZjllMmIwOGItNTZjOS00MzNiLWE5MTYtZTZhZTdlZDk0MzJkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	136	136
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BM2Q0YTdhZmItNGQzZC00YzY2LTg2YzgtNTdlMTMyOGIzOWU4XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	137	137
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTZkOTU2M2QtYzQxOS00MGIxLWIyNTUtN2Q1MWEzZGVlYmFiXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	138	138
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTFjNjdjNDQtYWNmNS00Y2U5LWE1YzctOTdkZGFmOWE5MWFiXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	139	139
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDczN2I3NzItNjdlMS00YmNhLTkyODQtZGI1YWQ0NmViMTgwXkEyXkFqcGdeQXVyNjMwMjk0MTQ%40.UX400.jpg&w=3840&q=75	\N	140	140
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2RiOTM0ZDgtNDRlMi00MDMzLWI1NDYtY2NjZDM4YTkwNWVlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	141	141
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGFmNDg3ZmMtMmMyMC00NjA5LWFmNGMtYmY2YjFhMDc5YjI1XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	142	142
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOWRmOTdkNjctY2YxMC00Y2E4LWFkMjktMzVmNjAxN2RmODJhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	143	143
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYjI1NTMzNjgtYjFmOS00YzFjLTg3MTEtMDgxZTcwZTE2NDM2XkEyXkFqcGdeQXVyMTUyNjc3NDQ4.UX400.jpg&w=3840&q=75	\N	144	144
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMmMxYzQ4ZDgtNTNhMC00YzhjLThhYmItZTJjN2I4MTYwZjU2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	145	145
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZGEzMDM4NjctYmJlMC00MTM5LWJiNTktMDRjNDdhZjQ4MWQ2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	146	146
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BM2NmYjZjOGItYTQ0ZC00YjcyLTk3MWUtYzdmZjY1MGNkMDViXkEyXkFqcGdeQXVyNzc5MjA3OA%40%40.UX400.jpg&w=3840&q=75	\N	147	147
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZjE1NGE5MTgtMTFlMi00OWY4LTk5ZmQtZjYxODkxZWFiZjhjXkEyXkFqcGdeQXVyMzIzNDU1NTY%40.UX400.jpg&w=3840&q=75	\N	148	148
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDNlYTI3NjgtZWE4ZC00OTlkLWEyMmItZWIxNDQ2YjZjMmYzXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	149	149
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNWY4Yzc2NjUtOTk3ZC00MzJjLTg3ZDMtNjI5OTNiYTk0ZmNkXkEyXkFqcGdeQXVyMzU4Njk4MzE%40.UX400.jpg&w=3840&q=75	\N	150	150
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNGE5Nzc5ZDUtYjQ4OC00OGU0LWE2YzEtMjE2NjRkYTFjYjgxXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	151	151
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODhmOTljMzQtNjg2ZC00ZDE3LWFhZWYtMjM0NmJkNTMyMzllXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	152	152
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BN2ZmNjVmM2MtOTE4YS00Y2ViLWIwNTAtMzZhMjMwODg2MDI3XkEyXkFqcGdeQXVyODM1NjQzOTA%40.UX400.jpg&w=3840&q=75	\N	153	153
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODBlODAzZmQtYWY4MC00NzI0LTkzY2MtNzgyNDIxNDA5Zjk1XkEyXkFqcGdeQXVyNjEwNTM2Mzc%40.UX400.jpg&w=3840&q=75	\N	154	154
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjA3YWQzNzgtY2M4MS00YmY1LTgyZTMtYTE3Yzg3MmI0MTllXkEyXkFqcGdeQXVyMTQ2MjQyNDc%40.UX400.jpg&w=3840&q=75	\N	155	155
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODE4Y2JiYmQtMGVkZS00ZDQzLTg4ZjAtOTNiODM2N2JmODUxXkEyXkFqcGdeQXVyNDM1ODc2NzE%40.UX400.jpg&w=3840&q=75	\N	156	156
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTg5MTE2NDY3NF5BMl5BanBnXkFtZTgwNjYyMTgwNjE%40.UX400.jpg&w=3840&q=75	\N	157	157
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYTFmODliMDgtZjZkZC00NTIyLWJlNzktNmM1MWY4NTY4Y2IwXkEyXkFqcGdeQXVyNTg2Njg2MTE%40.UX400.jpg&w=3840&q=75	\N	158	158
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTlkMDdlMDItNWQ2ZC00NjNjLWFhYjktZWFlYzI1OWMzNWJkXkEyXkFqcGdeQXVyNDAxNTY2NzI%40.UX400.jpg&w=3840&q=75	\N	159	159
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2ZiYWUxN2ItYmQxZi00NDlkLWE2NDAtOTNmYTg1MDI0NDk1XkEyXkFqcGdeQXVyNjUwNzk3NDc%40.UX400.jpg&w=3840&q=75	\N	160	160
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNmE1Mzg2YjgtMWJmNi00YTFkLTliNGItOTQ0YWRjY2E4NGY3XkEyXkFqcGdeQXVyNTA0OTU0OTQ%40.UX400.jpg&w=3840&q=75	\N	161	161
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzEzODFiNjctN2IwNC00NTJlLWE0MWQtZTU5YmI2ZmViYWUzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	162	162
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDU0MzlhMTEtMzdmZC00ZDZiLTk1NGQtZjNmOWE4ZWNlZDI2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	163	163
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTNlNDE0YjgtNjkwMi00YWJkLWJjNGYtNGU4ZTI0YzI4MjE3XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	164	164
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOWNjMjgyNmMtNWMzZC00YjI4LWI1NmUtMTY0ZTA0ZDQ4Y2EwXkEyXkFqcGdeQXVyNTUyMzE4Mzg%40.UX400.jpg&w=3840&q=75	\N	165	165
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzcwYjEwMzEtZTZmMi00ZGFhLWJhZjItMDAzNDVkNjZmM2U5L2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	166	166
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTgwOTc2MTItZDU4Yi00NzIwLTgwNmMtYjQxNjE5MTFjMzZhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	167	167
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzRmNTFjMjMtNzQ3Mi00ZTY5LTg3OTYtMzk4OTM1ZmM5Njk2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	168	168
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BN2IwZmQ2YzMtNWQxNS00ZmQ5LWExMTQtODRhMDc1NTVmYjA0XkEyXkFqcGdeQXVyODc0OTEyNDU%40.UX400.jpg&w=3840&q=75	\N	169	169
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjc4Yzg4ZWItMGVmNi00ZjFjLWI2ZDYtNzc2ODBmNTY4NzExXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	170	170
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzliMzRhODItODBiNS00NmVlLWE3OGQtY2UyNmVlYWY3M2VkXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	171	171
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjI0Yjc4YzYtZTNlZC00ZWYyLThiMzgtOWExZmUzMjUxYzhlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	172	172
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDQzMGE5ODYtZDdiNC00MzZjLTg2NjAtZTk0ODlkYmY4MTQzXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	173	173
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODk0OTExMDUxOV5BMl5BanBnXkFtZTgwNDk3MzQyMDI%40.UX400.jpg&w=3840&q=75	\N	174	174
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BODljNTU2ZGMtMWI5Yy00MGNkLTg2MTktN2NhZjY0NDcwMDhiL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	175	175
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNDY3YjFmZGMtYTY4ZS00NTc1LWE5ZGUtNDAyNWYxZDBhZGI5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	176	176
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzE0MjliZmEtOWM0Zi00OTczLThhZGYtZjVmOGE0NjkzZDEyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	177	177
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTMwNDg0NzcyMV5BMl5BanBnXkFtZTcwNjg4MjQyMw%40%40.UX400.jpg&w=3840&q=75	\N	178	178
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOTY0MDAwNjM0NV5BMl5BanBnXkFtZTgwNzUzMDU2MzE%40.UX400.jpg&w=3840&q=75	\N	179	179
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNWMxOTdlYTUtZDlkMi00Yzk2LTljM2EtMGRlYmY4MmUzYTIxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	180	180
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjU3NGY2MTktZjkzOC00YTQyLTkxOTUtYmZiZjZkNzJjNzg0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	181	181
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZWQ4YTlkMTctNGQyYi00ZDYyLTg4MzItMmQ0MzJhYWQ3MTk2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	182	182
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOGQ4NjlhZTktOTBlMi00OTE1LTk1MTAtMDExODY2NzRiZDIyXkEyXkFqcGdeQXVyMTQxNzMzNDI%40.UX400.jpg&w=3840&q=75	\N	183	183
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTA4ODEwOTAzNTReQTJeQWpwZ15BbWU4MDAzMDEyMTIx.UX400.jpg&w=3840&q=75	\N	184	184
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTJmYTk5YjYtNjhjNC00Y2E1LTljOGQtNDY4NTVhN2Q1ZWUwXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	185	185
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWI1YjZhNGEtMzk3NS00MWE3LThhZmUtNmQ1Mjc2NDBiNDBmXkEyXkFqcGdeQXVyOTQwNjAzMjM%40.UX400.jpg&w=3840&q=75	\N	186	186
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BY2Y2ZTEwNGMtMWJhNC00NGUyLThhNDUtYjBkMDUxZTJmZTY0XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	187	187
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzA3MTcxNDQtNDIyYy00YjU1LWExMmEtNzdhZjNkOTI4ZTlhXkEyXkFqcGdeQXVyMjQ2MTk1OTE%40.UX400.jpg&w=3840&q=75	\N	188	188
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOWFmOWJlNGQtOGY2NS00OTM2LThjYzEtYzYzMjRjNTFlN2IxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	189	189
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMWU1NjI5OWMtZDJjMS00ZTRkLWIxZjAtMjY1NzVlN2IzYzU5XkEyXkFqcGdeQXVyMTkzODUwNzk%40.UX400.jpg&w=3840&q=75	\N	190	190
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTc5NDY5NTYxMV5BMl5BanBnXkFtZTcwNjU3MzE5Nw%40%40.UX400.jpg&w=3840&q=75	\N	191	191
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjI0Mjk2NjE5N15BMl5BanBnXkFtZTYwNDg1Nzc5.UX400.jpg&w=3840&q=75	\N	192	192
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMGE0ZGMxMGMtNGJmNi00ZWIwLTkzMjEtMDFmMmMwMzY1MWM0XkEyXkFqcGdeQXVyNjgxNDEyMDY%40.UX400.jpg&w=3840&q=75	\N	193	193
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMzhhZjY0ZjAtODMyNS00ZjRkLWFhZDktMDc0MGZiZTg1ZmUyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	194	194
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BZDNiMjZhZjMtNWQwMi00N2QwLWIwMDYtNjczNjQzNzFjZmUyXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	195	195
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNjE1YWMyMWUtZDFiYy00NTE3LTkyZDktOWVhNzg0MGQ4MzhmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	196	196
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYWUxZjIwYzctYzJlNi00ZjFjLWI0Y2QtY2E0N2MwMGEyMzcxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	197	197
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNWM1OGEyOWYtMjRiZi00NGZmLTg3N2QtN2VhN2U1OGU3MTkzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	198	198
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzg5NmFkNmItNDJiYi00NTFlLWFhMDMtY2UwYTM4MWI3YWI4XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	199	199
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BOWI5NDdlNjktOWUyMi00OGU0LWJlYzktYzQxZGRkZDBiZGQ3XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	200	200
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNzc4NjQxNGMtMzRmYS00OTZjLWE3NTUtNmM2MTFmMGNkMDJhXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	201	201
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYzEwNDNiMjEtNzliZC00YTM3LTk2ODQtOGQwM2NkMmRkMjk5XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	202	202
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMjg4OGE4M2ItODU5OC00MDRlLThkNDEtZTE4MzQ4Mjg2NmVlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	203	203
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMDNmODQzMmEtMGVjYi00NjcwLTk5NTItYzI1NWVlODk0YzMxXkEyXkFqcGdeQXVyMjI4NzAzNjg%40.UX400.jpg&w=3840&q=75	\N	204	204
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BYjAwOGY3OTAtZjEzZC00YjE5LTliMWEtY2VjNzgwYTBjNDgzXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	205	205
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTdhZWYxY2UtNDk3Ny00ODc4LThlNWEtOTJjZjE0OTI1YTk2XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	206	206
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTYwZDcwNzMtNWI0NS00ZjE0LTg4NDQtODJhY2FmMTEwZDVlXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	207	207
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNmZhZmViMTgtYTc3Zi00OGVlLTgzNDAtMDNkZmRhODI5OTBmXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	208	208
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BMTI3MzgzMDQtOWIwOC00NWNhLWI3NjMtNWViMjZkOWI5MjMxXkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	209	209
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNTliZTRjNDgtNjRlYy00ZWMwLWIwNGEtNGIzOTAxZDhmNGQ1XkEyXkFqcGc%40.UX400.jpg&w=3840&q=75	\N	210	210
Cover	/_next/image?url=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BNmZkZDQ1ZWEtMzRlZC00ZWY2LTlhNTItMzdhOTQxMzJlMjgyXkEyXkFqcGdeQXVyOTc3NDM4Ng%40%40.UX400.jpg&w=3840&q=75	\N	211	211
\.


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: movieapp
--

COPY public.movie (title, runtime, release_year, rating, id) FROM stdin;
Harry Potter und der Feuerkelch	171	2005	499	2
Harry Potter und der Gefangene von Askaban	66	2004	338	3
Harry Potter und die Kammer des Schreckens	91	2002	352	4
Harry Potter und die Heiligtümer des Todes - Teil 2	92	2011	327	5
Harry Potter und der Orden des Phönix	153	2007	480	6
Harry Potter und der Halbblutprinz	142	2009	475	7
Harry Potter und die Heiligtümer des Todes - Teil 1	161	2010	344	8
Harry Potter and the Stone	107	2024	307	9
Harry Potter und der geheime Pornokeller	143	2008	488	10
Harry Potter: A History of Magic	166	2017	452	11
Harry Potter und ein Stein	132	2006	396	12
The Real! Harry Potter - Young Adult or Occult?	93	2024	405	13
Creating the World of Harry Potter, Part 4: Sound and Music	72	2010	474	14
Harry Potter and the Untold Stories of Hogwarts	162	2012	344	15
Harry Potter und der Plastikpokal	86	2008	314	16
The Harry Potter Saga Analyzed	72	2018	338	17
The Seekers Guide to Harry Potter	136	2010	301	18
Darla's Book Club: Discussing the Harry Potter Series	171	2020	445	19
John Williams: The Berlin Concert	87	2022	456	20
The Romance of Three Kingdoms	168	2015	417	21
Guardians of the Galaxy Vol. 3	171	2023	396	22
Terminator 3: Rebellion der Maschinen	162	2003	369	23
Die drei Tage des Condor	62	1975	483	24
Stoppt die Todesfahrt der U-Bahn 1-2-3	83	1974	341	25
On the Count of Three	156	2021	320	26
Die Abenteuer von Sharkboy und Lavagirl in 3-D	144	2005	372	27
The Wonderful Story of Henry Sugar and Three More	163	2024	384	28
Three Burials - Die drei Begräbnisse des Melquiades Estrada	81	2005	354	29
Three Kilometres to the End of the World	166	2024	323	30
Eva mit 3 Gesichtern	75	1957	437	31
Pokémon 3 - Im bann des Unbekannten	131	2000	381	32
Arthur und die Minimoys 3 - Die große Entscheidung	158	2010	358	33
Die drei Leben des Thomasina	150	1963	460	34
Rise of the Footsoldier III - Die Pat Tate Story	142	2017	338	35
Kingdom 3: The Flame of Destiny	161	2023	394	36
Three Kingdoms - Der Krieg der drei Königreiche	101	2008	422	37
1/3 the Evolution of Suicide Telugu Movie	155	2024	444	38
Karate Tiger VI - Entscheidung in Rio	146	1992	445	39
Die Sex-Abenteuer der drei Musketiere	177	1971	490	40
Xi xiang yan tan	82	1997	435	41
The Romance of Rosy Ridge	88	1947	473	42
Die drei Welten des Gulliver	131	1960	453	43
A Champion Heart	151	2018	453	44
Tong tian lao shu xia jiang nan	83	1978	496	45
Leave This House	124	2000	482	46
1984	73	1984	450	47
1984	160	2023	406	48
1984	61	1956	480	49
Wonder Woman 1984	60	2020	472	50
Die Klasse von 1984	120	1982	463	51
Brazil	165	1985	474	52
Punjab 1984	180	2014	351	53
Life of Crime 1984-2020	76	2021	409	54
Nightmare - Mörderische Träume	105	1984	440	55
Angel	92	1983	301	56
La chiave	178	1983	331	57
1984 el otro Abril	77	2019	324	58
Die Herrschaft der Ninja	77	1984	424	59
Midnight Oil: 1984	120	2018	366	60
77 Minutes	78	2016	331	61
1984, When the Sun Didn't Rise	155	2017	331	62
Tjenare kungen	119	2005	316	63
Rückkehr aus einer anderen Welt	129	1984	307	64
Menschen am Fluss	162	1984	480	65
1984, Choi Dong Won	138	2021	408	66
Lonestar: Stevie Ray Vaughan - 1984-1989	160	2017	304	67
Der Powerman	136	1984	362	68
Alice im Wunderland	139	2010	450	69
Alice im Wunderland	135	1951	451	70
Alice im Wunderland	154	1933	386	71
Alice im Wunderland	109	1915	311	72
Alice im Wunderland	172	1949	357	73
Alicia en la España de las maravillas	110	1978	468	74
Alicia en el país de las maravillas	143	1976	440	75
Alice in Wonderland	110	1931	496	76
Alice im Wunderland: Hinter den Spiegeln	162	2016	489	77
Alice in Wonderland	94	2005	420	78
Alice in Wonderland	82	2010	304	79
Alice of Wonderland in Paris	109	1966	320	80
Alice in Wonderland	170	1988	484	81
Alice im Wunderland	144	1972	352	82
VIViD	68	2011	453	83
Passion and Performance presents Alice in Wonderland	100	2022	495	84
Alice: Boy from Wonderland	141	2015	479	85
Little Alice's Storytime: Alice in Wonderland	149	2000	393	86
Fireside Reading of Alice in Wonderland	105	2022	412	87
Alice in Murderland	140	2010	403	88
The Initiation of Alice in Wonderland: The Looking Glass of Lewis Carroll	122	2010	493	89
Alice: A look into Alice's adventures in Wonderland and at the curious relationship between Alice Liddell and Lewis Carroll	152	2010	431	90
Faust: Love of the Damned	166	2000	442	91
Faust	61	1926	487	92
Faust	102	2011	307	93
Faust	156	1994	454	94
Faust	130	1960	468	95
Faust XX	101	1966	488	96
Faust	142	2000	415	97
Faust	177	2012	439	98
King Kongs Faust	86	1985	450	99
Goethes Faust	99	2020	397	100
Die Faust im Nacken	112	1954	454	101
Faust 2.0	176	2014	486	102
Faust	137	2000	343	103
Faust the Necromancer	153	2020	355	104
Faustrecht der Freiheit	147	1975	390	105
Der letzte Faust	152	2019	488	106
Faustine et le bel été	69	1972	368	107
Die Faust des Drachen	123	1972	458	108
Walking Tall - Auf eigene Faust	150	2004	496	109
Mit stählerner Faust	81	1990	400	110
Faust Sonnengesang	160	2011	421	111
La leggenda di Faust	89	1949	489	112
Royal Opera House: Faust	177	2019	304	113
Die Faust der Rebellen	178	1972	454	114
Fausto 5.0	109	2001	443	115
Der Schlachter	82	1970	407	116
Die Fliege	151	1986	461	117
Kalte Duschen	122	2005	382	118
Sex Sells: The Making of 'Touché'	104	2005	358	119
Douche	147	2018	445	120
Jean-Pierre und ich	118	1996	398	121
Berühre nicht die weiße Frau	148	1974	328	122
Pas sur la bouche	157	2003	472	123
Gotcha! - Ein irrer Trip	171	1985	447	124
Die Fliege	159	1958	439	125
Die Katze läßt das Mausen nicht	94	1960	315	126
L'amour à la bouche	104	1974	471	127
Ready or Not - Auf die Plätze, fertig, tot	86	2019	451	128
Die Fliege 2	75	1989	399	129
Wer spritzt denn da am Mittelmeer?	61	1980	428	130
El Guau	122	2022	430	131
Sie kämpften für die Heimat	132	1975	397	132
Lustige Sünder	155	1936	336	133
Auf der Flucht	122	1993	354	134
Flucht in Ketten	74	1958	374	135
Touché	91	2023	452	136
Touched	140	2023	366	137
Mouchette	160	1967	371	138
Pleure pas la bouche pleine!	80	1973	369	139
Herr der Fliegen	67	1990	498	140
Herr der Fliegen	90	1963	326	141
Der Herr der Ringe: Die Gefährten	120	2001	450	142
Der Herr der Ringe: Die Rückkehr des Königs	180	2003	455	143
Der Herr der Ringe: Die Schlacht der Rohirrim	107	2024	455	144
Der Herr der Ringe: Die zwei Türme	168	2002	345	145
Der Herr der Ringe	162	1978	489	146
Greystoke - Die Legende von Tarzan, Herr der Affen	148	1984	410	147
Il signore delle formiche	106	2022	482	148
Ein Pfeil in den Himmel	162	1991	435	149
Lord of the Streets	68	2022	322	150
Das Böse III	114	1994	355	151
Edges of the Lord	64	2001	313	152
The Lord of the Rings: The Empire of Saruman	75	2000	380	153
The Day of the Lord	167	2020	303	154
Lord of the Jungle	96	1955	444	155
Povelitel vetra	170	2023	428	156
Lord of the Freaks	180	2015	492	157
Ringers: Lord of the Fans	80	2005	451	158
Lord of the Dance: Dangerous Games	167	2014	307	159
Tarzan	84	1999	342	160
Tex und das Geheimnis der Todesgrotten	178	1985	361	161
Sepa: Nuestro Señor de los milagros	102	1986	406	162
Die Braut des Prinzen	87	1987	360	163
A Prince There Was	152	1921	423	164
Der Prinz von Ägypten	90	1998	383	165
Plötzlich Prinzessin!	125	2001	308	166
Prinzessin Mononoke	129	1997	301	167
Der Grinch	169	2000	443	168
Küss den Frosch	75	2009	328	169
Harry Potter und der Halbblutprinz	127	2009	416	170
Robin Hood - König der Diebe	145	1991	433	171
Der Grinch	60	2018	340	172
Little Princess - Die kleine Prinzessin	71	1995	441	173
Die Eisprinzessin	102	2005	471	174
Plötzlich Prinzessin 2	154	2004	418	175
The Princess	140	2022	377	176
John Carpenter's Die Fürsten der Dunkelheit	178	1987	336	177
Prince of Persia: Der Sand der Zeit	84	2010	435	178
Princess	138	2014	406	179
Der kleine Prinz	139	2015	392	180
Die Schwanenprinzessin	84	1994	389	181
Der Prinz & ich	146	2004	469	182
Der Herr der Gezeiten	68	1991	500	183
The Prince - Only God Forgives	162	2014	328	184
Die Chroniken von Narnia - Prinz Kaspian von Narnia	88	2008	486	185
Ningen shikkaku: Dazai Osamu to 3-nin no onnatachi	103	2019	432	186
Shin ningen shikkaku	158	1978	423	187
Ningen shikkaku	101	2010	477	188
Kumang: Aku Ukai 17 Agi	175	2023	319	189
A Comédia Divina	70	2017	451	190
The Divine Comedy	157	2012	477	191
Die göttliche Komödie	176	1991	332	192
The Divine Comedy: Dante's Hell	145	2016	457	193
The Divine Stand-Up Comedy Special	173	2000	347	194
Amen	157	2013	324	195
A Not So Divine Comedy	63	2000	499	196
Divine Comedy	69	2008	463	197
Divine Comedy: Hawaii 2006	129	2006	326	198
Bohemia docta aneb Labyrint sveta a lusthauz srdce (Bozská komedie)	134	2000	335	199
La Divina Cometa	89	2022	477	200
Divine Comédie, des planches à l'écran	76	2015	309	201
La Divine Comédie	73	2000	303	202
The Discovery of the Divine Consciousness	69	2000	481	203
Drei Sünderinnen	75	1954	316	204
Red Girl	94	2021	396	205
The Maze Man	176	2021	387	206
Caliovas	114	2022	444	207
Blue Egg	168	2021	389	208
Thousands of Years	136	2021	496	209
Over the World	161	2022	311	210
Joy of Wolf	70	2018	489	211
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: movieapp
--

COPY public.tag (name, category, id) FROM stdin;
Daniel Radcliffe	actor	1
Rupert Grint	actor	2
Emma Watson	actor	3
Coldmirror	actor	4
Imelda Staunton	actor	5
Warwick Davis	actor	6
J.K. Rowling	actor	7
Ryan Glista	actor	8
Forrest Grover	actor	9
Houston Coley	actor	10
Geo Athena Trevarthen	actor	11
John Williams	actor	12
Berliner Philharmoniker	actor	13
Zhixiao Feng	actor	14
Weikang Li	actor	15
Chris Pratt	actor	16
Chukwudi Iwuji	actor	17
Arnold Schwarzenegger	actor	18
Nick Stahl	actor	19
Robert Redford	actor	20
Faye Dunaway	actor	21
Walter Matthau	actor	22
Robert Shaw	actor	23
Jerrod Carmichael	actor	24
Christopher Abbott	actor	25
Cayden Boyd	actor	26
George Lopez	actor	27
Richard Ayoade	actor	28
Benedict Cumberbatch	actor	29
Tommy Lee Jones	actor	30
Barry Pepper	actor	31
Valeriu Andriuta	actor	32
Ingrid Berescu	actor	33
Joanne Woodward	actor	34
David Wayne	actor	35
Veronica Taylor	actor	36
Eric Stuart	actor	37
Mia Farrow	actor	38
Ron Crawford	actor	39
Patrick McGoohan	actor	40
Susan Hampshire	actor	41
Craig Fairbrass	actor	42
Terry Stone	actor	43
Kento Yamazaki	actor	44
Ryô Yoshizawa	actor	45
Andy Lau	actor	46
Sammo Kam-Bo Hung	actor	47
Sasha Mitchell	actor	48
Dennis Chan	actor	49
Peter Graf	actor	50
Ingrid Steeger	actor	51
Chisato Kawamura	actor	52
Shu-Kei Wong	actor	53
Van Johnson	actor	54
Thomas Mitchell	actor	55
Kerwin Mathews	actor	56
Jo Morrow	actor	57
Mandy Grace	actor	58
Devan Key	actor	59
Barry Chan	actor	60
Fu-Hsiung Cheng	actor	61
Katelyn Nevin	actor	62
Scott Hale	actor	63
John Hurt	actor	64
Richard Burton	actor	65
Aleksandr Obmanov	actor	66
Vladimir Ivaniy	actor	67
Edmond O'Brien	actor	68
Michael Redgrave	actor	69
Gal Gadot	actor	70
Chris Pine	actor	71
Perry King	actor	72
Merrie Lynn Ross	actor	73
Jonathan Pryce	actor	74
Kim Greist	actor	75
Diljit Dosanjh	actor	76
Kirron Kher	actor	77
Deliris	actor	78
Freddy	actor	79
Heather Langenkamp	actor	80
Johnny Depp	actor	81
Cliff Gorman	actor	82
Susan Tyrrell	actor	83
Frank Finlay	actor	84
Stefania Sandrelli	actor	85
Arístides Arroyo	actor	86
Manuel Brito	actor	87
Shô Kosugi	actor	88
Lucinda Dickey	actor	89
Midnight Oil	actor	90
Carlos Amezcua	actor	91
Maria Aquino	actor	92
Josefin Neldén	actor	93
Cecilia Wallin	actor	94
Timothy Hutton	actor	95
Lindsay Crouse	actor	96
Mel Gibson	actor	97
Sissy Spacek	actor	98
Thomas Arnold	actor	99
Timothy Duckworth	actor	100
Jackie Chan	actor	101
Biao Yuen	actor	102
Mia Wasikowska	actor	103
Kathryn Beaumont	actor	104
Ed Wynn	actor	105
Richard Arlen	actor	106
Roscoe Ates	actor	107
Viola Savoy	actor	108
Herbert Rice	actor	109
Stephen Murray	actor	110
Ernest Milton	actor	111
Mireia Ros	actor	112
Silvia Aguilar	actor	113
Mónica von Reust	actor	114
Carlos Lorca	actor	115
Ruth Gilbert	actor	116
Ralph Hertz	actor	117
Jayaram	actor	118
Sandhya	actor	119
Sarah Brooks	actor	120
Lauren Nicole Goode	actor	121
Luce Ennis	actor	122
Norma MacMillan	actor	123
Fiona Fullerton	actor	124
Michael Jayston	actor	125
Keith Kraft	actor	126
Devanny Pinn	actor	127
Jessica Calder	actor	128
Kennedy Cullen	actor	129
Hong Jong-hyun	actor	130
Jung So-min	actor	131
Carol Bee	actor	132
Paul Castro Jr.	actor	133
Gildart Jackson	actor	134
Malerie Grady	actor	135
Marlene Mc'Cohen	actor	136
Julie Dickson-Gardiner	actor	137
Philip Gardiner	actor	138
Mark Frost	actor	139
Isabel Brook	actor	140
Gösta Ekman	actor	141
Emil Jannings	actor	142
Johannes Zeiler	actor	143
Anton Adasinsky	actor	144
Petr Cepek	actor	145
Jan Kraus	actor	146
Will Quadflieg	actor	147
Gustaf Gründgens	actor	148
Emil Botta	actor	149
Iurie Darie	actor	150
Michael Schlembach	actor	151
Annemarie Brinz	actor	152
Leonard Lansink	actor	153
Werner Grassmann	actor	154
Bernardo Arias Porras	actor	155
Heidrun Bartholomäus	actor	156
Marlon Brando	actor	157
Karl Malden	actor	158
Frida Liljevall	actor	159
Thomas Hedengran	actor	160
Terrance Willis	actor	161
Freddie Webster III	actor	162
Rainer Werner Fassbinder	actor	163
Peter Chatel	actor	164
Steven Berkoff	actor	165
Martin Hancock	actor	166
Isabelle Adjani	actor	167
Muriel Catalá	actor	168
Bruce Lee	actor	169
Chuck Norris	actor	170
Dwayne Johnson	actor	171
Ashley Scott	actor	172
Jean-Claude Van Damme	actor	173
Robert Guillaume	actor	174
Maria Happel	actor	175
Corinna Harfouch	actor	176
Italo Tajo	actor	177
Nelly Corradi	actor	178
Marta Fontanals-Simmons	actor	179
James Unsworth	actor	180
Barbara Hershey	actor	181
David Carradine	actor	182
Miguel Ángel Solá	actor	183
Eduard Fernández	actor	184
Stéphane Audran	actor	185
Jean Yanne	actor	186
Jeff Goldblum	actor	187
Geena Davis	actor	188
Johan Libéreau	actor	189
Salomé Stévenin	actor	190
Mark DeCarlo	actor	191
Darby Daniels	actor	192
Matti Boustedt	actor	193
Albin Johnsen	actor	194
Sandra Sammartino	actor	195
Denise Aron-Schropfer	actor	196
Marcello Mastroianni	actor	197
Catherine Deneuve	actor	198
Sabine Azéma	actor	199
Isabelle Nanty	actor	200
Anthony Edwards	actor	201
Linda Fiorentino	actor	202
David Hedison	actor	203
Patricia Owens	actor	204
Bernadette Lafont	actor	205
Françoise Brion	actor	206
Nadine Perles	actor	207
Elton Frame	actor	208
Samara Weaving	actor	209
Adam Brody	actor	210
Eric Stoltz	actor	211
Daphne Zuniga	actor	212
Sylvain Chamarande	actor	213
Victoria Abril	actor	214
Sebastian Dante	actor	215
Sirena Ortiz	actor	216
Vasiliy Shukshin	actor	217
Vyacheslav Tikhonov	actor	218
Jean Harlow	actor	219
William Powell	actor	220
Harrison Ford	actor	221
Tony Curtis	actor	222
Sidney Poitier	actor	223
Isold Halldórudóttir	actor	224
Stavros Zafeiris	actor	225
Nadine Nortier	actor	226
Jean-Claude Guilbert	actor	227
Bernard Menez	actor	228
Christiane Chamaret	actor	229
Balthazar Getty	actor	230
Chris Furrh	actor	231
James Aubrey	actor	232
Tom Chapin	actor	233
Elijah Wood	actor	234
Ian McKellen	actor	235
Viggo Mortensen	actor	236
Brian Cox	actor	237
Miranda Otto	actor	238
Christopher Guard	actor	239
William Squire	actor	240
Christopher Lambert	actor	241
Andie MacDowell	actor	242
Luigi Lo Cascio	actor	243
Elio Germano	actor	244
Tom Berenger	actor	245
John Lithgow	actor	246
Anthony 'Treach' Criss	actor	247
Quinton 'Rampage' Jackson	actor	248
Reggie Bannister	actor	249
A. Michael Baldwin	actor	250
Haley Joel Osment	actor	251
Willem Dafoe	actor	252
George Smith	actor	253
Linda Rosejchnöt	actor	254
Juli Fàbregas	actor	255
Hector Illanes	actor	256
Johnny Sheffield	actor	257
Wayne Morris	actor	258
Fedor Bondarchuk	actor	259
Anna Mikhalkova	actor	260
Josh Altman	actor	261
Karen Jin Beck	actor	262
Dominic Monaghan	actor	263
James Keegan	actor	264
Thomas Cunningham	actor	265
Tony Goldwyn	actor	266
Minnie Driver	actor	267
Giuliano Gemma	actor	268
William Berger	actor	269
Burkhard Driest	actor	270
Mario Vargas Llosa	actor	271
Cary Elwes	actor	272
Mandy Patinkin	actor	273
Thomas Meighan	actor	274
Mildred Harris	actor	275
Val Kilmer	actor	276
Ralph Fiennes	actor	277
Julie Andrews	actor	278
Anne Hathaway	actor	279
Yôji Matsuda	actor	280
Yuriko Ishida	actor	281
Jim Carrey	actor	282
Taylor Momsen	actor	283
Anika Noni Rose	actor	284
Keith David	actor	285
Kevin Costner	actor	286
Morgan Freeman	actor	287
Cameron Seely	actor	288
Liesel Matthews	actor	289
Eleanor Bron	actor	290
Michelle Trachtenberg	actor	291
Kim Cattrall	actor	292
Callum Blue	actor	293
Joey King	actor	294
Olga Kurylenko	actor	295
Donald Pleasence	actor	296
Lisa Blount	actor	297
Jake Gyllenhaal	actor	298
Gemma Arterton	actor	299
Keren Mor	actor	300
Shira Haas	actor	301
Jeff Bridges	actor	302
Mackenzie Foy	actor	303
Jack Palance	actor	304
Howard McGillin	actor	305
Julia Stiles	actor	306
Luke Mably	actor	307
Barbra Streisand	actor	308
Nick Nolte	actor	309
Jason Patric	actor	310
Bruce Willis	actor	311
Ben Barnes	actor	312
Skandar Keynes	actor	313
Yûdai Chiba	actor	314
Tatsuya Fujiwara	actor	315
Hiroshi Ohmori	actor	316
Yasushi Suzuki	actor	317
Tôma Ikuta	actor	318
Yûsuke Iseya	actor	319
Eve	actor	320
Nancytor	actor	321
Murilo Rosa	actor	322
Monica Iozzi	actor	323
J. LaMont Bryant	actor	324
Jeremiah Edward Hobbs	actor	325
Maria de Medeiros	actor	326
Miguel Guilherme	actor	327
Sofia Debrot	actor	328
Wanderson Feitosa	actor	329
Jason DeStefano	actor	330
Fahadh Faasil	actor	331
Indrajith Sukumaran	actor	332
Peyton Buhler	actor	333
Taylor Busby	actor	334
John Bok	actor	335
Egon Bondy	actor	336
Laurie Anderson	actor	337
Tomas Arana	actor	338
Mathieu Amalric	actor	339
Yves Angelo	actor	340
Alyssa Lynch	actor	341
Jordan Taylor Wright	actor	342
Peppino De Filippo	actor	343
Silvana Pampanini	actor	344
Meredith Binder	actor	345
Henry S Brown Jr.	actor	346
Travis Doane	actor	347
Daniel J. Harmon	actor	348
Briana Bui	actor	349
Hank N. Baker	actor	350
Jesica Avellone	actor	351
tag_0	keyword	352
tag_1	keyword	353
tag_2	keyword	354
tag_3	keyword	355
tag_4	keyword	356
tag_5	keyword	357
tag_6	keyword	358
tag_7	keyword	359
tag_8	keyword	360
tag_9	keyword	361
\.


--
-- Data for Name: tagged_movie; Type: TABLE DATA; Schema: public; Owner: movieapp
--

COPY public.tagged_movie (movie_id, tag_id, id) FROM stdin;
2	3	3
10	4	4
11	5	5
11	6	6
13	7	7
15	8	8
15	9	9
17	10	10
18	11	11
20	12	12
20	13	13
21	14	14
21	15	15
22	16	16
22	17	17
23	18	18
23	19	19
24	20	20
24	21	21
25	22	22
25	23	23
26	24	24
26	25	25
27	26	26
27	27	27
28	28	28
28	29	29
29	30	30
29	31	31
30	32	32
30	33	33
31	34	34
31	35	35
32	36	36
32	37	37
33	38	38
33	39	39
34	40	40
34	41	41
35	42	42
35	43	43
36	44	44
36	45	45
37	46	46
37	47	47
39	48	48
39	49	49
40	50	50
40	51	51
41	52	52
41	53	53
42	54	54
42	55	55
43	56	56
43	57	57
44	58	58
44	59	59
45	60	60
45	61	61
46	62	62
46	63	63
47	64	64
47	65	65
48	66	66
48	67	67
49	68	68
49	69	69
50	70	70
50	71	71
51	72	72
51	73	73
52	74	74
52	75	75
53	76	76
53	77	77
54	78	78
54	79	79
55	80	80
55	81	81
56	82	82
56	83	83
57	84	84
57	85	85
58	86	86
58	87	87
59	88	88
59	89	89
60	90	90
61	91	91
61	92	92
63	93	93
63	94	94
64	95	95
64	96	96
65	97	97
65	98	98
67	99	99
67	100	100
68	101	101
68	102	102
69	103	103
70	104	104
70	105	105
71	106	106
71	107	107
72	108	108
72	109	109
73	110	110
73	111	111
74	112	112
74	113	113
75	114	114
75	115	115
76	116	116
76	117	117
78	118	118
78	119	119
79	120	120
79	121	121
80	122	122
80	123	123
82	124	124
82	125	125
83	126	126
83	127	127
84	128	128
84	129	129
85	130	130
85	131	131
86	132	132
86	133	133
87	134	134
88	135	135
88	136	136
89	137	137
89	138	138
91	139	139
91	140	140
92	141	141
92	142	142
93	143	143
93	144	144
94	145	145
94	146	146
95	147	147
95	148	148
96	149	149
96	150	150
97	151	151
97	152	152
99	153	153
99	154	154
100	155	155
100	156	156
101	157	157
101	158	158
102	159	159
102	160	160
104	161	161
104	162	162
105	163	163
105	164	164
106	165	165
106	166	166
107	167	167
107	168	168
108	169	169
108	170	170
109	171	171
109	172	172
110	173	173
110	174	174
111	175	175
111	176	176
112	177	177
112	178	178
113	179	179
113	180	180
114	181	181
114	182	182
115	183	183
115	184	184
116	185	185
116	186	186
117	187	187
117	188	188
118	189	189
118	190	190
119	191	191
119	192	192
120	193	193
120	194	194
121	195	195
121	196	196
122	197	197
122	198	198
123	199	199
123	200	200
124	201	201
124	202	202
125	203	203
125	204	204
126	205	205
126	206	206
127	207	207
127	208	208
128	209	209
128	210	210
129	211	211
129	212	212
130	213	213
130	214	214
131	215	215
131	216	216
132	217	217
132	218	218
133	219	219
133	220	220
134	221	221
135	222	222
135	223	223
137	224	224
137	225	225
138	226	226
138	227	227
139	228	228
139	229	229
140	230	230
140	231	231
141	232	232
141	233	233
142	234	234
142	235	235
143	236	236
144	237	237
144	238	238
146	239	239
146	240	240
147	241	241
147	242	242
148	243	243
148	244	244
149	245	245
149	246	246
150	247	247
150	248	248
151	249	249
151	250	250
152	251	251
152	252	252
153	253	253
153	254	254
154	255	255
154	256	256
155	257	257
155	258	258
156	259	259
156	260	260
157	261	261
157	262	262
158	263	263
159	264	264
159	265	265
160	266	266
160	267	267
161	268	268
161	269	269
162	270	270
162	271	271
163	272	272
163	273	273
164	274	274
164	275	275
165	276	276
165	277	277
166	278	278
166	279	279
167	280	280
167	281	281
168	282	282
168	283	283
169	284	284
169	285	285
171	286	286
171	287	287
172	288	288
173	289	289
173	290	290
174	291	291
174	292	292
175	293	293
176	294	294
176	295	295
177	296	296
177	297	297
178	298	298
178	299	299
179	300	300
179	301	301
180	302	302
180	303	303
181	304	304
181	305	305
182	306	306
182	307	307
183	308	308
183	309	309
184	310	310
184	311	311
185	312	312
185	313	313
186	314	314
186	315	315
187	316	316
187	317	317
188	318	318
188	319	319
189	320	320
189	321	321
190	322	322
190	323	323
191	324	324
191	325	325
192	326	326
192	327	327
193	328	328
193	329	329
194	330	330
195	331	331
195	332	332
198	333	333
198	334	334
199	335	335
199	336	336
200	337	337
200	338	338
201	339	339
201	340	340
203	341	341
203	342	342
204	343	343
204	344	344
205	345	345
205	346	346
206	347	347
206	348	348
208	349	349
209	350	350
211	351	351
2	356	355
2	357	356
2	355	357
3	354	358
3	359	359
3	356	360
4	352	361
4	360	362
4	358	363
5	360	364
5	360	365
5	360	366
6	356	367
6	356	368
6	358	369
7	356	370
7	356	371
7	354	372
8	352	373
8	356	374
8	353	375
9	353	376
9	358	377
9	358	378
10	356	379
10	356	380
10	361	381
11	352	382
11	352	383
11	354	384
12	356	385
12	358	386
12	355	387
13	352	388
13	358	389
13	356	390
14	361	391
14	361	392
14	353	393
15	356	394
15	356	395
15	353	396
16	354	397
16	358	398
16	354	399
17	361	400
17	354	401
17	353	402
18	355	403
18	361	404
18	359	405
19	356	406
19	356	407
19	361	408
20	361	409
20	354	410
20	361	411
21	357	412
21	354	413
21	358	414
22	360	415
22	360	416
22	360	417
23	356	418
23	356	419
23	356	420
24	360	421
24	359	422
24	352	423
25	355	424
25	355	425
25	357	426
26	353	427
26	355	428
26	359	429
27	360	430
27	355	431
27	360	432
28	358	433
28	356	434
28	354	435
29	356	436
29	352	437
29	361	438
30	361	439
30	356	440
30	359	441
31	359	442
31	358	443
31	358	444
32	360	445
32	357	446
32	357	447
33	356	448
33	352	449
33	354	450
34	358	451
34	361	452
34	356	453
35	357	454
35	356	455
35	360	456
36	353	457
36	358	458
36	355	459
37	352	460
37	352	461
37	355	462
38	359	463
38	357	464
38	353	465
39	358	466
39	354	467
39	358	468
40	360	469
40	360	470
40	354	471
41	357	472
41	357	473
41	355	474
42	354	475
42	359	476
42	352	477
43	361	478
43	354	479
43	357	480
44	357	481
44	352	482
44	359	483
45	355	484
45	357	485
45	355	486
46	357	487
46	352	488
46	358	489
47	361	490
47	360	491
47	361	492
48	357	493
48	360	494
48	356	495
49	354	496
49	354	497
49	353	498
50	357	499
50	357	500
50	357	501
51	360	502
51	361	503
51	352	504
52	355	505
52	355	506
52	356	507
53	360	508
53	360	509
53	354	510
54	357	511
54	359	512
54	360	513
55	359	514
55	358	515
55	354	516
56	361	517
56	353	518
56	355	519
57	357	520
57	356	521
57	359	522
58	361	523
58	359	524
58	360	525
59	360	526
59	359	527
59	358	528
60	355	529
60	353	530
60	354	531
61	355	532
61	352	533
61	360	534
62	361	535
62	358	536
62	352	537
63	360	538
63	360	539
63	361	540
64	354	541
64	358	542
64	353	543
65	360	544
65	357	545
65	355	546
66	355	547
66	361	548
66	354	549
67	358	550
67	352	551
67	358	552
68	361	553
68	360	554
68	355	555
69	361	556
69	356	557
69	352	558
70	352	559
70	356	560
70	354	561
71	352	562
71	358	563
71	358	564
72	354	565
72	355	566
72	355	567
73	355	568
73	352	569
73	361	570
74	357	571
74	355	572
74	361	573
75	355	574
75	361	575
75	352	576
76	353	577
76	353	578
76	360	579
77	353	580
77	355	581
77	360	582
78	356	583
78	357	584
78	357	585
79	359	586
79	355	587
79	355	588
80	361	589
80	360	590
80	359	591
81	353	592
81	353	593
81	360	594
82	353	595
82	354	596
82	361	597
83	355	598
83	361	599
83	352	600
84	357	601
84	356	602
84	353	603
85	359	604
85	361	605
85	357	606
86	353	607
86	358	608
86	358	609
87	361	610
87	359	611
87	355	612
88	355	613
88	360	614
88	357	615
89	353	616
89	358	617
89	357	618
90	360	619
90	361	620
90	352	621
91	352	622
91	356	623
91	361	624
92	359	625
92	352	626
92	355	627
93	361	628
93	354	629
93	360	630
94	356	631
94	355	632
94	354	633
95	353	634
95	354	635
95	360	636
96	360	637
96	353	638
96	358	639
97	360	640
97	353	641
97	352	642
98	353	643
98	354	644
98	359	645
99	359	646
99	354	647
99	356	648
100	354	649
100	357	650
100	357	651
101	360	652
101	353	653
101	359	654
102	360	655
102	359	656
102	360	657
103	360	658
103	359	659
103	353	660
104	359	661
104	360	662
104	352	663
105	352	664
105	354	665
105	359	666
106	359	667
106	354	668
106	360	669
107	352	670
107	353	671
107	355	672
108	358	673
108	361	674
108	361	675
109	361	676
109	357	677
109	359	678
110	358	679
110	359	680
110	355	681
111	352	682
111	358	683
111	354	684
112	355	685
112	359	686
112	358	687
113	355	688
113	355	689
113	359	690
114	360	691
114	355	692
114	361	693
115	354	694
115	356	695
115	352	696
116	359	697
116	354	698
116	355	699
117	356	700
117	360	701
117	356	702
118	352	703
118	352	704
118	352	705
119	355	706
119	355	707
119	352	708
120	353	709
120	354	710
120	353	711
121	354	712
121	352	713
121	356	714
122	358	715
122	358	716
122	357	717
123	359	718
123	353	719
123	357	720
124	359	721
124	357	722
124	356	723
125	358	724
125	359	725
125	359	726
126	358	727
126	354	728
126	356	729
127	361	730
127	356	731
127	358	732
128	354	733
128	352	734
128	361	735
129	353	736
129	355	737
129	361	738
130	358	739
130	359	740
130	353	741
131	354	742
131	353	743
131	359	744
132	356	745
132	355	746
132	352	747
133	354	748
133	352	749
133	358	750
134	356	751
134	355	752
134	354	753
135	355	754
135	353	755
135	358	756
136	356	757
136	356	758
136	353	759
137	359	760
137	358	761
137	360	762
138	357	763
138	359	764
138	359	765
139	360	766
139	361	767
139	353	768
140	354	769
140	358	770
140	354	771
141	360	772
141	355	773
141	352	774
142	359	775
142	357	776
142	356	777
143	356	778
143	355	779
143	356	780
144	358	781
144	360	782
144	357	783
145	358	784
145	352	785
145	355	786
146	353	787
146	353	788
146	357	789
147	358	790
147	352	791
147	355	792
148	356	793
148	352	794
148	357	795
149	353	796
149	354	797
149	359	798
150	357	799
150	360	800
150	356	801
151	355	802
151	361	803
151	354	804
152	360	805
152	360	806
152	361	807
153	354	808
153	357	809
153	352	810
154	353	811
154	353	812
154	359	813
155	355	814
155	359	815
155	360	816
156	353	817
156	352	818
156	357	819
157	356	820
157	352	821
157	361	822
158	356	823
158	359	824
158	355	825
159	360	826
159	359	827
159	361	828
160	357	829
160	361	830
160	360	831
161	356	832
161	357	833
161	358	834
162	355	835
162	357	836
162	360	837
163	354	838
163	358	839
163	361	840
164	356	841
164	353	842
164	352	843
165	360	844
165	355	845
165	353	846
166	356	847
166	352	848
166	356	849
167	359	850
167	358	851
167	358	852
168	355	853
168	355	854
168	358	855
169	361	856
169	357	857
169	361	858
170	356	859
170	360	860
170	357	861
171	353	862
171	355	863
171	354	864
172	354	865
172	357	866
172	358	867
173	356	868
173	354	869
173	357	870
174	355	871
174	361	872
174	354	873
175	360	874
175	358	875
175	360	876
176	359	877
176	356	878
176	357	879
177	355	880
177	353	881
177	355	882
178	353	883
178	356	884
178	353	885
179	359	886
179	359	887
179	355	888
180	357	889
180	353	890
180	361	891
181	358	892
181	354	893
181	353	894
182	354	895
182	353	896
182	353	897
183	355	898
183	354	899
183	358	900
184	360	901
184	353	902
184	358	903
185	360	904
185	353	905
185	353	906
186	356	907
186	354	908
186	359	909
187	357	910
187	361	911
187	361	912
188	360	913
188	355	914
188	361	915
189	352	916
189	359	917
189	359	918
190	357	919
190	358	920
190	354	921
191	358	922
191	352	923
191	361	924
192	352	925
192	352	926
192	354	927
193	359	928
193	354	929
193	361	930
194	359	931
194	352	932
194	355	933
195	353	934
195	358	935
195	360	936
196	352	937
196	359	938
196	354	939
197	358	940
197	361	941
197	356	942
198	352	943
198	360	944
198	355	945
199	353	946
199	360	947
199	357	948
200	357	949
200	354	950
200	353	951
201	355	952
201	361	953
201	360	954
202	353	955
202	359	956
202	354	957
203	354	958
203	360	959
203	355	960
204	359	961
204	361	962
204	356	963
205	354	964
205	358	965
205	354	966
206	357	967
206	354	968
206	352	969
207	361	970
207	354	971
207	359	972
208	359	973
208	360	974
208	357	975
209	353	976
209	354	977
209	360	978
210	361	979
210	355	980
210	355	981
211	358	982
211	359	983
211	358	984
\.


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: movieapp
--

SELECT pg_catalog.setval('public.link_id_seq', 211, true);


--
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: movieapp
--

SELECT pg_catalog.setval('public.movie_id_seq', 211, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: movieapp
--

SELECT pg_catalog.setval('public.tag_id_seq', 361, true);


--
-- Name: tagged_movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: movieapp
--

SELECT pg_catalog.setval('public.tagged_movie_id_seq', 984, true);


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (id);


--
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- Name: tag tag_name_key; Type: CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_name_key UNIQUE (name);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tagged_movie tagged_movie_pkey; Type: CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tagged_movie
    ADD CONSTRAINT tagged_movie_pkey PRIMARY KEY (id);


--
-- Name: link link_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(id) ON DELETE CASCADE;


--
-- Name: tagged_movie tagged_movie_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tagged_movie
    ADD CONSTRAINT tagged_movie_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(id);


--
-- Name: tagged_movie tagged_movie_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: movieapp
--

ALTER TABLE ONLY public.tagged_movie
    ADD CONSTRAINT tagged_movie_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- PostgreSQL database dump complete
--

