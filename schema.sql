--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA IF NOT EXISTS public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: club; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.club (
    name character varying(255) NOT NULL,
    creation_date date,
    id_creator bigint NOT NULL,
    name_non_id character varying(255),
    passkey character varying(255)
);


ALTER TABLE public.club OWNER TO postgres;

--
-- Name: competition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competition (
    competition_id character varying(255) NOT NULL,
    creation_date date NOT NULL,
    display_name character varying(255),
    end_date date,
    start_date date,
    type character varying(255)
);


ALTER TABLE public.competition OWNER TO postgres;

--
-- Name: image_proof; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image_proof (
    competition_id character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    image oid,
    time_stamp date
);


ALTER TABLE public.image_proof OWNER TO postgres;

--
-- Name: password_reset_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_token (
    id bigint NOT NULL,
    expiry_date timestamp(6) without time zone,
    reset_password_token character varying(255)
);


ALTER TABLE public.password_reset_token OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    id bigint
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    competition_id character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL,
    club_name character varying(255) NOT NULL,
    team_display_name character varying(255) NOT NULL
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: team_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_member (
    competition_id character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.team_member OWNER TO postgres;

--
-- Name: team_member_score; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_member_score (
    competition_id character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    bulls_eye_count integer NOT NULL,
    creation_date date,
    sum double precision NOT NULL
);


ALTER TABLE public.team_member_score OWNER TO postgres;

--
-- Name: user_; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_ (
    id bigint NOT NULL,
    creation_date date,
    email character varying(255),
    last_login date,
    legal_name character varying(255),
    part_of_club character varying(255),
    password character varying(255),
    username character varying(255)
);


ALTER TABLE public.user_ OWNER TO postgres;

--
-- Name: user__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user__id_seq OWNER TO postgres;

--
-- Name: user__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user__id_seq OWNED BY public.user_.id;


--
-- Name: user_ id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_ ALTER COLUMN id SET DEFAULT nextval('public.user__id_seq'::regclass);


--
-- Data for Name: club; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.club (name, creation_date, id_creator, name_non_id, passkey) FROM stdin;
\.


--
-- Data for Name: competition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition (competition_id, creation_date, display_name, end_date, start_date, type) FROM stdin;
\.


--
-- Data for Name: image_proof; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image_proof (competition_id, file_name, team_name, user_id, image, time_stamp) FROM stdin;
\.


--
-- Data for Name: password_reset_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_token (id, expiry_date, reset_password_token) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role, user_id, id) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (competition_id, team_name, club_name, team_display_name) FROM stdin;
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member (competition_id, team_name, user_id) FROM stdin;
\.


--
-- Data for Name: team_member_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member_score (competition_id, team_name, user_id, bulls_eye_count, creation_date, sum) FROM stdin;
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_ (id, creation_date, email, last_login, legal_name, part_of_club, password, username) FROM stdin;
\.


--
-- Name: user__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user__id_seq', 1, false);


--
-- Name: club club_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.club
    ADD CONSTRAINT club_pkey PRIMARY KEY (name);


--
-- Name: competition competition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition
    ADD CONSTRAINT competition_pkey PRIMARY KEY (competition_id);


--
-- Name: image_proof image_proof_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_proof
    ADD CONSTRAINT image_proof_pkey PRIMARY KEY (competition_id, file_name, team_name, user_id);


--
-- Name: password_reset_token password_reset_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT password_reset_token_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role, user_id);


--
-- Name: team_member team_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (competition_id, team_name, user_id);


--
-- Name: team_member_score team_member_score_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member_score
    ADD CONSTRAINT team_member_score_pkey PRIMARY KEY (competition_id, team_name, user_id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (competition_id, team_name);


--
-- Name: password_reset_token uk_bpi82sb5pfhyl572tejgpgefo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT uk_bpi82sb5pfhyl572tejgpgefo UNIQUE (reset_password_token);


--
-- Name: user_ uk_ha67cvlhy4nk1prswl5gj1y0y; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT uk_ha67cvlhy4nk1prswl5gj1y0y UNIQUE (email);


--
-- Name: user_ uk_wqsqlvajcne4rlyosglqglhk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT uk_wqsqlvajcne4rlyosglqglhk UNIQUE (username);


--
-- Name: user_ user__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__pkey PRIMARY KEY (id);


--
-- Name: team_member fk3fi820e3nsm0yyd1pm6nf44ti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT fk3fi820e3nsm0yyd1pm6nf44ti FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: team_member_score fk40uj7cbxbqebqrbmdatolafvw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member_score
    ADD CONSTRAINT fk40uj7cbxbqebqrbmdatolafvw FOREIGN KEY (competition_id, team_name, user_id) REFERENCES public.team_member(competition_id, team_name, user_id);


--
-- Name: team_member fk9ae9nuasjib5wngdti8rj2sc8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT fk9ae9nuasjib5wngdti8rj2sc8 FOREIGN KEY (competition_id, team_name) REFERENCES public.team(competition_id, team_name);


--
-- Name: team fkhcjvfp3ccepk78v7la3m3ycuy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT fkhcjvfp3ccepk78v7la3m3ycuy FOREIGN KEY (club_name) REFERENCES public.club(name);


--
-- Name: role fkjs8yncb18jawa23is8eejdjfm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT fkjs8yncb18jawa23is8eejdjfm FOREIGN KEY (id) REFERENCES public.user_(id);


--
-- Name: image_proof fknlenavcfp7tawq2c2fwr56f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_proof
    ADD CONSTRAINT fknlenavcfp7tawq2c2fwr56f1 FOREIGN KEY (competition_id, team_name, user_id) REFERENCES public.team_member_score(competition_id, team_name, user_id);


--
-- Name: team fkqhhapgh63c9yjo4tc0uf6ynt1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT fkqhhapgh63c9yjo4tc0uf6ynt1 FOREIGN KEY (competition_id) REFERENCES public.competition(competition_id);


--
-- PostgreSQL database dump complete
--

