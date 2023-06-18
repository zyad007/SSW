--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.6

-- Started on 2023-06-06 17:48:09

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 60487)
-- Name: assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignment (
    id integer NOT NULL,
    title character varying(50),
    description character varying(255),
    file_url character varying(255),
    course_id integer
);


ALTER TABLE public.assignment OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 60486)
-- Name: assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assignment_id_seq OWNER TO postgres;

--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 217
-- Name: assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assignment_id_seq OWNED BY public.assignment.id;


--
-- TOC entry 216 (class 1259 OID 60475)
-- Name: chat_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_message (
    id integer NOT NULL,
    content character varying(255),
    user_name character varying(50),
    course_id integer
);


ALTER TABLE public.chat_message OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 60474)
-- Name: chat_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_message_id_seq OWNER TO postgres;

--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 215
-- Name: chat_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_message_id_seq OWNED BY public.chat_message.id;


--
-- TOC entry 212 (class 1259 OID 60451)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name character varying(50),
    description character varying(255),
    no_participants integer
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 60450)
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_id_seq OWNER TO postgres;

--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 211
-- Name: course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_id_seq OWNED BY public.course.id;


--
-- TOC entry 228 (class 1259 OID 60581)
-- Name: note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note (
    id integer NOT NULL,
    time_in_sec integer,
    content character varying(255),
    session_id integer,
    course_id integer,
    user_id integer,
    user_course_id integer
);


ALTER TABLE public.note OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 60580)
-- Name: note_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_id_seq OWNER TO postgres;

--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 227
-- Name: note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.note_id_seq OWNED BY public.note.id;


--
-- TOC entry 222 (class 1259 OID 60530)
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id integer NOT NULL,
    title character varying(50),
    description character varying(255),
    course_id integer
);


ALTER TABLE public.session OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 60529)
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.session_id_seq OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 221
-- Name: session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_id_seq OWNED BY public.session.id;


--
-- TOC entry 226 (class 1259 OID 60569)
-- Name: time_stamp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.time_stamp (
    id integer NOT NULL,
    time_in_sec integer,
    content character varying(255),
    session_id integer
);


ALTER TABLE public.time_stamp OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 60568)
-- Name: time_stamp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.time_stamp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.time_stamp_id_seq OWNER TO postgres;

--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 225
-- Name: time_stamp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.time_stamp_id_seq OWNED BY public.time_stamp.id;


--
-- TOC entry 210 (class 1259 OID 60444)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(50) NOT NULL,
    name character varying(50),
    password character varying(255)
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 60501)
-- Name: user_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_assignment (
    id integer NOT NULL,
    comments character varying(255),
    sub_url character varying(255),
    grade integer,
    course_id integer,
    user_id integer,
    user_course_id integer,
    assignment_id integer
);


ALTER TABLE public.user_assignment OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 60500)
-- Name: user_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_assignment_id_seq OWNER TO postgres;

--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_assignment_id_seq OWNED BY public.user_assignment.id;


--
-- TOC entry 214 (class 1259 OID 60458)
-- Name: user_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_course (
    id integer NOT NULL,
    role character varying(50),
    course_id integer,
    user_id integer
);


ALTER TABLE public.user_course OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 60457)
-- Name: user_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_course_id_seq OWNER TO postgres;

--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 213
-- Name: user_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_course_id_seq OWNED BY public.user_course.id;


--
-- TOC entry 209 (class 1259 OID 60443)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 209
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 224 (class 1259 OID 60542)
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id integer NOT NULL,
    course_id integer,
    user_id integer,
    user_course_id integer,
    session_id integer
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 60541)
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_session_id_seq OWNER TO postgres;

--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_session_id_seq OWNED BY public.user_session.id;


--
-- TOC entry 3213 (class 2604 OID 60490)
-- Name: assignment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment ALTER COLUMN id SET DEFAULT nextval('public.assignment_id_seq'::regclass);


--
-- TOC entry 3212 (class 2604 OID 60478)
-- Name: chat_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message ALTER COLUMN id SET DEFAULT nextval('public.chat_message_id_seq'::regclass);


--
-- TOC entry 3210 (class 2604 OID 60454)
-- Name: course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course ALTER COLUMN id SET DEFAULT nextval('public.course_id_seq'::regclass);


--
-- TOC entry 3218 (class 2604 OID 60584)
-- Name: note id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note ALTER COLUMN id SET DEFAULT nextval('public.note_id_seq'::regclass);


--
-- TOC entry 3215 (class 2604 OID 60533)
-- Name: session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session ALTER COLUMN id SET DEFAULT nextval('public.session_id_seq'::regclass);


--
-- TOC entry 3217 (class 2604 OID 60572)
-- Name: time_stamp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_stamp ALTER COLUMN id SET DEFAULT nextval('public.time_stamp_id_seq'::regclass);


--
-- TOC entry 3209 (class 2604 OID 60447)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3214 (class 2604 OID 60504)
-- Name: user_assignment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_assignment ALTER COLUMN id SET DEFAULT nextval('public.user_assignment_id_seq'::regclass);


--
-- TOC entry 3211 (class 2604 OID 60461)
-- Name: user_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_course ALTER COLUMN id SET DEFAULT nextval('public.user_course_id_seq'::regclass);


--
-- TOC entry 3216 (class 2604 OID 60545)
-- Name: user_session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session ALTER COLUMN id SET DEFAULT nextval('public.user_session_id_seq'::regclass);


--
-- TOC entry 3405 (class 0 OID 60487)
-- Dependencies: 218
-- Data for Name: assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assignment (id, title, description, file_url, course_id) FROM stdin;
1	ASSIGNMENT1	JAVA CODE	DESKTOP	1
\.


--
-- TOC entry 3403 (class 0 OID 60475)
-- Dependencies: 216
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_message (id, content, user_name, course_id) FROM stdin;
1	javscript usage ?	bichoy	1
2	front-end	ahmed	1
3	c++ oop	zyad	2
4	smart home using embeded system	adhm	6
\.


--
-- TOC entry 3399 (class 0 OID 60451)
-- Dependencies: 212
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, description, no_participants) FROM stdin;
1	Javascript	This is the Javascript course	0
2	C++	This is the C++ course	0
3	C#	This is the C# course	0
4	Java	This is the Java course	0
5	Python	This is the Python course	0
6	Embeded	This is the Embeded by chanlenger adhoum course	0
\.


--
-- TOC entry 3415 (class 0 OID 60581)
-- Dependencies: 228
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note (id, time_in_sec, content, session_id, course_id, user_id, user_course_id) FROM stdin;
1	1	print1	1	1	2	2
2	2	print2	1	1	3	3
3	3	print3	1	1	4	4
\.


--
-- TOC entry 3409 (class 0 OID 60530)
-- Dependencies: 222
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (id, title, description, course_id) FROM stdin;
1	javscript	beginner in javascript	1
2	c++	usage of c++	2
3	java	java oop	4
\.


--
-- TOC entry 3413 (class 0 OID 60569)
-- Dependencies: 226
-- Data for Name: time_stamp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.time_stamp (id, time_in_sec, content, session_id) FROM stdin;
1	1	consle.log(1)	1
2	2	consle.log(12)	1
3	3	consle.log(123)	1
\.


--
-- TOC entry 3397 (class 0 OID 60444)
-- Dependencies: 210
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, name, password) FROM stdin;
1	zyad@mail.com	Zyad Sallem	123456789
2	bichoy@mail.com	Bichoy Atef	987654321
3	ahmed@mail.com	Ahmed Osama	564987321
4	adhoun@mail.com	adhm ehab	111111111
5	ziad@mail.com	ziad hazem	000000000
\.


--
-- TOC entry 3407 (class 0 OID 60501)
-- Dependencies: 220
-- Data for Name: user_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_assignment (id, comments, sub_url, grade, course_id, user_id, user_course_id, assignment_id) FROM stdin;
1	OOP	JAVA CODE	\N	1	2	2	1
2	OOP	JAVA CODE	\N	1	3	3	1
3	OOP	JAVA CODE	\N	1	4	4	1
\.


--
-- TOC entry 3401 (class 0 OID 60458)
-- Dependencies: 214
-- Data for Name: user_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_course (id, role, course_id, user_id) FROM stdin;
1	TEACHER	1	1
2	STUDENT	1	2
3	STUDENT	1	3
4	STUDENT	1	4
5	TEACHER	2	5
6	STUDENT	2	1
7	STUDENT	2	3
8	STUDENT	2	4
9	TEACHER	3	4
10	STUDENT	3	5
\.


--
-- TOC entry 3411 (class 0 OID 60542)
-- Dependencies: 224
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, course_id, user_id, user_course_id, session_id) FROM stdin;
1	1	2	2	1
2	1	3	3	1
3	1	4	4	1
4	2	1	6	2
5	2	3	7	2
6	2	4	8	2
\.


--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 217
-- Name: assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assignment_id_seq', 1, true);


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 215
-- Name: chat_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_message_id_seq', 4, true);


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 211
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 6, true);


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 227
-- Name: note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.note_id_seq', 3, true);


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 221
-- Name: session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_id_seq', 3, true);


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 225
-- Name: time_stamp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.time_stamp_id_seq', 3, true);


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_assignment_id_seq', 3, true);


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 213
-- Name: user_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_course_id_seq', 10, true);


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 209
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 5, true);


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_session_id_seq', 6, true);


--
-- TOC entry 3228 (class 2606 OID 60494)
-- Name: assignment assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_pkey PRIMARY KEY (id);


--
-- TOC entry 3226 (class 2606 OID 60480)
-- Name: chat_message chat_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_pkey PRIMARY KEY (id);


--
-- TOC entry 3222 (class 2606 OID 60456)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 60586)
-- Name: note note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 60535)
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 60574)
-- Name: time_stamp time_stamp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_stamp
    ADD CONSTRAINT time_stamp_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 60508)
-- Name: user_assignment user_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_assignment
    ADD CONSTRAINT user_assignment_pkey PRIMARY KEY (id);


--
-- TOC entry 3224 (class 2606 OID 60463)
-- Name: user_course user_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_course
    ADD CONSTRAINT user_course_pkey PRIMARY KEY (id);


--
-- TOC entry 3220 (class 2606 OID 60449)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 60547)
-- Name: user_session user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 60524)
-- Name: user_assignment fk_assignment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_assignment
    ADD CONSTRAINT fk_assignment FOREIGN KEY (assignment_id) REFERENCES public.assignment(id) ON DELETE CASCADE;


--
-- TOC entry 3239 (class 2606 OID 60464)
-- Name: user_course fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_course
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3241 (class 2606 OID 60481)
-- Name: chat_message fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3242 (class 2606 OID 60495)
-- Name: assignment fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3243 (class 2606 OID 60509)
-- Name: user_assignment fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_assignment
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3247 (class 2606 OID 60536)
-- Name: session fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3248 (class 2606 OID 60548)
-- Name: user_session fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3254 (class 2606 OID 60592)
-- Name: note fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON DELETE CASCADE;


--
-- TOC entry 3251 (class 2606 OID 60563)
-- Name: user_session fk_session; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.session(id) ON DELETE CASCADE;


--
-- TOC entry 3252 (class 2606 OID 60575)
-- Name: time_stamp fk_session; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_stamp
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.session(id) ON DELETE CASCADE;


--
-- TOC entry 3253 (class 2606 OID 60587)
-- Name: note fk_session; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.session(id) ON DELETE CASCADE;


--
-- TOC entry 3240 (class 2606 OID 60469)
-- Name: user_course fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_course
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3244 (class 2606 OID 60514)
-- Name: user_assignment fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_assignment
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3249 (class 2606 OID 60553)
-- Name: user_session fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3255 (class 2606 OID 60597)
-- Name: note fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3245 (class 2606 OID 60519)
-- Name: user_assignment fk_user_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_assignment
    ADD CONSTRAINT fk_user_course FOREIGN KEY (user_course_id) REFERENCES public.user_course(id) ON DELETE CASCADE;


--
-- TOC entry 3250 (class 2606 OID 60558)
-- Name: user_session fk_user_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT fk_user_course FOREIGN KEY (user_course_id) REFERENCES public.user_course(id) ON DELETE CASCADE;


--
-- TOC entry 3256 (class 2606 OID 60602)
-- Name: note fk_user_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT fk_user_course FOREIGN KEY (user_course_id) REFERENCES public.user_course(id) ON DELETE CASCADE;


-- Completed on 2023-06-06 17:48:09

--
-- PostgreSQL database dump complete
--

