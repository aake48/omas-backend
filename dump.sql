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

CREATE SCHEMA public;


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
    creation_date date,
    id_creator bigint NOT NULL,
    name character varying(255) NOT NULL,
    name_non_id character varying(255),
    passkey character varying(255)
);


ALTER TABLE public.club OWNER TO postgres;

--
-- Name: competition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competition (
    creation_date date NOT NULL,
    end_date date,
    start_date date,
    competition_id character varying(255) NOT NULL,
    display_name character varying(255),
    type character varying(255)
);


ALTER TABLE public.competition OWNER TO postgres;

--
-- Name: image_proof; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image_proof (
    time_stamp date,
    user_id bigint NOT NULL,
    competition_id character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL,
    image oid
);


ALTER TABLE public.image_proof OWNER TO postgres;

--
-- Name: password_reset_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_token (
    expiry_date timestamp(6) without time zone,
    id bigint NOT NULL,
    reset_password_token character varying(255)
);


ALTER TABLE public.password_reset_token OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id bigint,
    user_id bigint NOT NULL,
    role character varying(255) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    club_name character varying(255) NOT NULL,
    competition_id character varying(255) NOT NULL,
    team_display_name character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: team_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_member (
    user_id bigint NOT NULL,
    competition_id character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL
);


ALTER TABLE public.team_member OWNER TO postgres;

--
-- Name: team_member_score; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_member_score (
    bulls_eye_count integer NOT NULL,
    creation_date date,
    sum double precision NOT NULL,
    user_id bigint NOT NULL,
    competition_id character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL
);


ALTER TABLE public.team_member_score OWNER TO postgres;

--
-- Name: user_; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_ (
    creation_date date,
    last_login date,
    id bigint NOT NULL,
    email character varying(255),
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

COPY public.club (creation_date, id_creator, name, name_non_id, passkey) FROM stdin;
2024-04-17	0	Poliisiseura	Poliisiseura	\N
2024-04-17	0	Koiraseura	Koiraseura	\N
2024-04-17	0	Hammaspeikkoseura	Hammaspeikkoseura	\N
2024-04-17	0	dog	dog	\N
2024-04-17	0	Savu_Seura	Savu Seura	\N
2024-04-17	0	OMAS	OMAS	\N
2024-04-17	0	Pelleseura	Pelleseura	\N
2024-04-17	0	Yung_Tallent	Yung Tallent	\N
2024-04-17	0	Aseharrastajien_Yhtenaisyys	Aseharrastajien Yhten├ñisyys	\N
2024-04-17	0	Tahtaysmestarit	T├ñht├ñysmestarit	\N
2024-04-17	0	Laukausryhma_Aurora	Laukausryhm├ñ Aurora	\N
2024-04-17	0	Ampumataito	Ampumataito	\N
\.


--
-- Data for Name: competition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition (creation_date, end_date, start_date, competition_id, display_name, type) FROM stdin;
2024-04-17	2024-05-31	2024-05-06	Kesan_Ampujaiset	Kes├ñn Ampujaiset	rifle
2024-04-17	2023-05-22	2022-05-07	Talvi_Pistooli	Talvi Pistooli	rifle
2024-04-17	2024-06-30	2024-05-24	Tarkkuuslaukaus-festivaali	Tarkkuuslaukaus-festivaali	rifle
2024-04-17	2024-05-02	2024-03-29	Kivaarikilpailujen_huipennus	Kiv├ñ├ñrikilpailujen huipennus	rifle
2024-04-17	2022-08-19	2022-05-16	Polaris-ampumaharjoitus	Polaris-ampumaharjoitus	rifle
2024-04-17	2024-06-21	2024-05-14	Aamunkoiton_tahtays	Aamunkoiton t├ñht├ñys	rifle
2024-04-17	2024-02-23	2023-12-19	Nordic_Sharpshooters_Cup	Nordic Sharpshooters Cup	rifle
2024-04-17	2024-03-28	2024-03-02	Taivaanranta-tulitus	Taivaanranta-tulitus	rifle
2024-04-17	2026-10-26	2024-10-31	Lumivyory-ammunta	Lumivy├Âry-ammunta	rifle
2024-04-17	2026-03-31	2025-07-04	Tarkka-ammunta_Cup	Tarkka-ammunta Cup	pistol
2024-04-17	2024-07-07	2024-05-13	Nopean_laukauksen_mestaruus	Nopean laukauksen mestaruus	pistol
2024-04-17	2024-06-18	2024-04-24	Moniottelu	Moniottelu	pistol
2024-04-17	2024-06-20	2024-06-07	Kansallinen_tahtayskilpailu	Kansallinen t├ñht├ñyskilpailu	pistol
2024-04-17	2024-04-05	2024-02-27	Kaupunkiammunta-challenge	Kaupunkiammunta-challenge	pistol
2024-04-17	2022-12-26	2022-09-29	Laukausmaraton	Laukausmaraton	pistol
2024-04-17	2026-02-13	2024-12-23	Vapaa-asekilpailu	Vapaa-asekilpailu	pistol
2024-04-17	2024-11-16	2024-04-16	Taitoluodikko-turnaus	Taitoluodikko-turnaus	pistol
2024-04-17	2026-05-04	2024-08-18	Precision_Pistol_Cup	Precision Pistol Cup	pistol
2024-04-17	2024-11-19	2023-07-15	Tulevaisuuden_Ampuja	Tulevaisuuden Ampuja	pistol
2024-04-17	2024-04-19	2024-03-08	Pikakivaari-klassikko	Pikakiv├ñ├ñri-klassikko	pistol
\.


--
-- Data for Name: image_proof; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image_proof (time_stamp, user_id, competition_id, file_name, team_name, image) FROM stdin;
\.


--
-- Data for Name: password_reset_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_token (expiry_date, id, reset_password_token) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, user_id, role) FROM stdin;
\N	1	ROLE_USER
\N	1	ROLE_ADMIN
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (club_name, competition_id, team_display_name, team_name) FROM stdin;
Poliisiseura	Kesan_Ampujaiset	Poliisiseura	Poliisiseura
Koiraseura	Kesan_Ampujaiset	Koiraseura	Koiraseura
Hammaspeikkoseura	Kesan_Ampujaiset	Hammaspeikkoseura	Hammaspeikkoseura
dog	Kesan_Ampujaiset	dog	dog
Savu_Seura	Kesan_Ampujaiset	Savu Seura	Savu_Seura
OMAS	Kesan_Ampujaiset	OMAS	OMAS
Pelleseura	Kesan_Ampujaiset	Pelleseura	Pelleseura
Yung_Tallent	Kesan_Ampujaiset	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Kesan_Ampujaiset	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Kesan_Ampujaiset	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Kesan_Ampujaiset	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Kesan_Ampujaiset	Ampumataito	Ampumataito
Poliisiseura	Talvi_Pistooli	Poliisiseura	Poliisiseura
Koiraseura	Talvi_Pistooli	Koiraseura	Koiraseura
Hammaspeikkoseura	Talvi_Pistooli	Hammaspeikkoseura	Hammaspeikkoseura
dog	Talvi_Pistooli	dog	dog
Savu_Seura	Talvi_Pistooli	Savu Seura	Savu_Seura
OMAS	Talvi_Pistooli	OMAS	OMAS
Pelleseura	Talvi_Pistooli	Pelleseura	Pelleseura
Yung_Tallent	Talvi_Pistooli	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Talvi_Pistooli	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Talvi_Pistooli	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Talvi_Pistooli	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Talvi_Pistooli	Ampumataito	Ampumataito
Poliisiseura	Tarkkuuslaukaus-festivaali	Poliisiseura	Poliisiseura
Koiraseura	Tarkkuuslaukaus-festivaali	Koiraseura	Koiraseura
Hammaspeikkoseura	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura	Hammaspeikkoseura
dog	Tarkkuuslaukaus-festivaali	dog	dog
Savu_Seura	Tarkkuuslaukaus-festivaali	Savu Seura	Savu_Seura
OMAS	Tarkkuuslaukaus-festivaali	OMAS	OMAS
Pelleseura	Tarkkuuslaukaus-festivaali	Pelleseura	Pelleseura
Yung_Tallent	Tarkkuuslaukaus-festivaali	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Tarkkuuslaukaus-festivaali	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Tarkkuuslaukaus-festivaali	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Tarkkuuslaukaus-festivaali	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Tarkkuuslaukaus-festivaali	Ampumataito	Ampumataito
Poliisiseura	Kivaarikilpailujen_huipennus	Poliisiseura	Poliisiseura
Koiraseura	Kivaarikilpailujen_huipennus	Koiraseura	Koiraseura
Hammaspeikkoseura	Kivaarikilpailujen_huipennus	Hammaspeikkoseura	Hammaspeikkoseura
dog	Kivaarikilpailujen_huipennus	dog	dog
Savu_Seura	Kivaarikilpailujen_huipennus	Savu Seura	Savu_Seura
OMAS	Kivaarikilpailujen_huipennus	OMAS	OMAS
Pelleseura	Kivaarikilpailujen_huipennus	Pelleseura	Pelleseura
Yung_Tallent	Kivaarikilpailujen_huipennus	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Kivaarikilpailujen_huipennus	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Kivaarikilpailujen_huipennus	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Kivaarikilpailujen_huipennus	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Kivaarikilpailujen_huipennus	Ampumataito	Ampumataito
Poliisiseura	Polaris-ampumaharjoitus	Poliisiseura	Poliisiseura
Koiraseura	Polaris-ampumaharjoitus	Koiraseura	Koiraseura
Hammaspeikkoseura	Polaris-ampumaharjoitus	Hammaspeikkoseura	Hammaspeikkoseura
dog	Polaris-ampumaharjoitus	dog	dog
Savu_Seura	Polaris-ampumaharjoitus	Savu Seura	Savu_Seura
OMAS	Polaris-ampumaharjoitus	OMAS	OMAS
Pelleseura	Polaris-ampumaharjoitus	Pelleseura	Pelleseura
Yung_Tallent	Polaris-ampumaharjoitus	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Polaris-ampumaharjoitus	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Polaris-ampumaharjoitus	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Polaris-ampumaharjoitus	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Polaris-ampumaharjoitus	Ampumataito	Ampumataito
Poliisiseura	Aamunkoiton_tahtays	Poliisiseura	Poliisiseura
Koiraseura	Aamunkoiton_tahtays	Koiraseura	Koiraseura
Hammaspeikkoseura	Aamunkoiton_tahtays	Hammaspeikkoseura	Hammaspeikkoseura
dog	Aamunkoiton_tahtays	dog	dog
Savu_Seura	Aamunkoiton_tahtays	Savu Seura	Savu_Seura
OMAS	Aamunkoiton_tahtays	OMAS	OMAS
Pelleseura	Aamunkoiton_tahtays	Pelleseura	Pelleseura
Yung_Tallent	Aamunkoiton_tahtays	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Aamunkoiton_tahtays	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Aamunkoiton_tahtays	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Aamunkoiton_tahtays	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Aamunkoiton_tahtays	Ampumataito	Ampumataito
Poliisiseura	Nordic_Sharpshooters_Cup	Poliisiseura	Poliisiseura
Koiraseura	Nordic_Sharpshooters_Cup	Koiraseura	Koiraseura
Hammaspeikkoseura	Nordic_Sharpshooters_Cup	Hammaspeikkoseura	Hammaspeikkoseura
dog	Nordic_Sharpshooters_Cup	dog	dog
Savu_Seura	Nordic_Sharpshooters_Cup	Savu Seura	Savu_Seura
OMAS	Nordic_Sharpshooters_Cup	OMAS	OMAS
Pelleseura	Nordic_Sharpshooters_Cup	Pelleseura	Pelleseura
Yung_Tallent	Nordic_Sharpshooters_Cup	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Nordic_Sharpshooters_Cup	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Nordic_Sharpshooters_Cup	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Nordic_Sharpshooters_Cup	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Nordic_Sharpshooters_Cup	Ampumataito	Ampumataito
Poliisiseura	Taivaanranta-tulitus	Poliisiseura	Poliisiseura
Koiraseura	Taivaanranta-tulitus	Koiraseura	Koiraseura
Hammaspeikkoseura	Taivaanranta-tulitus	Hammaspeikkoseura	Hammaspeikkoseura
dog	Taivaanranta-tulitus	dog	dog
Savu_Seura	Taivaanranta-tulitus	Savu Seura	Savu_Seura
OMAS	Taivaanranta-tulitus	OMAS	OMAS
Pelleseura	Taivaanranta-tulitus	Pelleseura	Pelleseura
Yung_Tallent	Taivaanranta-tulitus	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Taivaanranta-tulitus	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Taivaanranta-tulitus	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Taivaanranta-tulitus	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Taivaanranta-tulitus	Ampumataito	Ampumataito
Poliisiseura	Lumivyory-ammunta	Poliisiseura	Poliisiseura
Koiraseura	Lumivyory-ammunta	Koiraseura	Koiraseura
Hammaspeikkoseura	Lumivyory-ammunta	Hammaspeikkoseura	Hammaspeikkoseura
dog	Lumivyory-ammunta	dog	dog
Savu_Seura	Lumivyory-ammunta	Savu Seura	Savu_Seura
OMAS	Lumivyory-ammunta	OMAS	OMAS
Pelleseura	Lumivyory-ammunta	Pelleseura	Pelleseura
Yung_Tallent	Lumivyory-ammunta	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Lumivyory-ammunta	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Lumivyory-ammunta	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Lumivyory-ammunta	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Lumivyory-ammunta	Ampumataito	Ampumataito
Poliisiseura	Tarkka-ammunta_Cup	Poliisiseura	Poliisiseura
Koiraseura	Tarkka-ammunta_Cup	Koiraseura	Koiraseura
Hammaspeikkoseura	Tarkka-ammunta_Cup	Hammaspeikkoseura	Hammaspeikkoseura
dog	Tarkka-ammunta_Cup	dog	dog
Savu_Seura	Tarkka-ammunta_Cup	Savu Seura	Savu_Seura
OMAS	Tarkka-ammunta_Cup	OMAS	OMAS
Pelleseura	Tarkka-ammunta_Cup	Pelleseura	Pelleseura
Yung_Tallent	Tarkka-ammunta_Cup	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Tarkka-ammunta_Cup	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Tarkka-ammunta_Cup	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Tarkka-ammunta_Cup	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Tarkka-ammunta_Cup	Ampumataito	Ampumataito
Poliisiseura	Nopean_laukauksen_mestaruus	Poliisiseura	Poliisiseura
Koiraseura	Nopean_laukauksen_mestaruus	Koiraseura	Koiraseura
Hammaspeikkoseura	Nopean_laukauksen_mestaruus	Hammaspeikkoseura	Hammaspeikkoseura
dog	Nopean_laukauksen_mestaruus	dog	dog
Savu_Seura	Nopean_laukauksen_mestaruus	Savu Seura	Savu_Seura
OMAS	Nopean_laukauksen_mestaruus	OMAS	OMAS
Pelleseura	Nopean_laukauksen_mestaruus	Pelleseura	Pelleseura
Yung_Tallent	Nopean_laukauksen_mestaruus	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Nopean_laukauksen_mestaruus	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Nopean_laukauksen_mestaruus	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Nopean_laukauksen_mestaruus	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Nopean_laukauksen_mestaruus	Ampumataito	Ampumataito
Poliisiseura	Moniottelu	Poliisiseura	Poliisiseura
Koiraseura	Moniottelu	Koiraseura	Koiraseura
Hammaspeikkoseura	Moniottelu	Hammaspeikkoseura	Hammaspeikkoseura
dog	Moniottelu	dog	dog
Savu_Seura	Moniottelu	Savu Seura	Savu_Seura
OMAS	Moniottelu	OMAS	OMAS
Pelleseura	Moniottelu	Pelleseura	Pelleseura
Yung_Tallent	Moniottelu	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Moniottelu	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Moniottelu	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Moniottelu	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Moniottelu	Ampumataito	Ampumataito
Poliisiseura	Kansallinen_tahtayskilpailu	Poliisiseura	Poliisiseura
Koiraseura	Kansallinen_tahtayskilpailu	Koiraseura	Koiraseura
Hammaspeikkoseura	Kansallinen_tahtayskilpailu	Hammaspeikkoseura	Hammaspeikkoseura
dog	Kansallinen_tahtayskilpailu	dog	dog
Savu_Seura	Kansallinen_tahtayskilpailu	Savu Seura	Savu_Seura
OMAS	Kansallinen_tahtayskilpailu	OMAS	OMAS
Pelleseura	Kansallinen_tahtayskilpailu	Pelleseura	Pelleseura
Yung_Tallent	Kansallinen_tahtayskilpailu	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Kansallinen_tahtayskilpailu	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Kansallinen_tahtayskilpailu	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Kansallinen_tahtayskilpailu	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Kansallinen_tahtayskilpailu	Ampumataito	Ampumataito
Poliisiseura	Kaupunkiammunta-challenge	Poliisiseura	Poliisiseura
Koiraseura	Kaupunkiammunta-challenge	Koiraseura	Koiraseura
Hammaspeikkoseura	Kaupunkiammunta-challenge	Hammaspeikkoseura	Hammaspeikkoseura
dog	Kaupunkiammunta-challenge	dog	dog
Savu_Seura	Kaupunkiammunta-challenge	Savu Seura	Savu_Seura
OMAS	Kaupunkiammunta-challenge	OMAS	OMAS
Pelleseura	Kaupunkiammunta-challenge	Pelleseura	Pelleseura
Yung_Tallent	Kaupunkiammunta-challenge	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Kaupunkiammunta-challenge	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Kaupunkiammunta-challenge	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Kaupunkiammunta-challenge	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Kaupunkiammunta-challenge	Ampumataito	Ampumataito
Poliisiseura	Laukausmaraton	Poliisiseura	Poliisiseura
Koiraseura	Laukausmaraton	Koiraseura	Koiraseura
Hammaspeikkoseura	Laukausmaraton	Hammaspeikkoseura	Hammaspeikkoseura
dog	Laukausmaraton	dog	dog
Savu_Seura	Laukausmaraton	Savu Seura	Savu_Seura
OMAS	Laukausmaraton	OMAS	OMAS
Pelleseura	Laukausmaraton	Pelleseura	Pelleseura
Yung_Tallent	Laukausmaraton	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Laukausmaraton	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Laukausmaraton	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Laukausmaraton	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Laukausmaraton	Ampumataito	Ampumataito
Poliisiseura	Vapaa-asekilpailu	Poliisiseura	Poliisiseura
Koiraseura	Vapaa-asekilpailu	Koiraseura	Koiraseura
Hammaspeikkoseura	Vapaa-asekilpailu	Hammaspeikkoseura	Hammaspeikkoseura
dog	Vapaa-asekilpailu	dog	dog
Savu_Seura	Vapaa-asekilpailu	Savu Seura	Savu_Seura
OMAS	Vapaa-asekilpailu	OMAS	OMAS
Pelleseura	Vapaa-asekilpailu	Pelleseura	Pelleseura
Yung_Tallent	Vapaa-asekilpailu	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Vapaa-asekilpailu	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Vapaa-asekilpailu	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Vapaa-asekilpailu	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Vapaa-asekilpailu	Ampumataito	Ampumataito
Poliisiseura	Taitoluodikko-turnaus	Poliisiseura	Poliisiseura
Koiraseura	Taitoluodikko-turnaus	Koiraseura	Koiraseura
Hammaspeikkoseura	Taitoluodikko-turnaus	Hammaspeikkoseura	Hammaspeikkoseura
dog	Taitoluodikko-turnaus	dog	dog
Savu_Seura	Taitoluodikko-turnaus	Savu Seura	Savu_Seura
OMAS	Taitoluodikko-turnaus	OMAS	OMAS
Pelleseura	Taitoluodikko-turnaus	Pelleseura	Pelleseura
Yung_Tallent	Taitoluodikko-turnaus	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Taitoluodikko-turnaus	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Taitoluodikko-turnaus	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Taitoluodikko-turnaus	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Taitoluodikko-turnaus	Ampumataito	Ampumataito
Poliisiseura	Precision_Pistol_Cup	Poliisiseura	Poliisiseura
Koiraseura	Precision_Pistol_Cup	Koiraseura	Koiraseura
Hammaspeikkoseura	Precision_Pistol_Cup	Hammaspeikkoseura	Hammaspeikkoseura
dog	Precision_Pistol_Cup	dog	dog
Savu_Seura	Precision_Pistol_Cup	Savu Seura	Savu_Seura
OMAS	Precision_Pistol_Cup	OMAS	OMAS
Pelleseura	Precision_Pistol_Cup	Pelleseura	Pelleseura
Yung_Tallent	Precision_Pistol_Cup	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Precision_Pistol_Cup	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Precision_Pistol_Cup	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Precision_Pistol_Cup	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Precision_Pistol_Cup	Ampumataito	Ampumataito
Poliisiseura	Tulevaisuuden_Ampuja	Poliisiseura	Poliisiseura
Koiraseura	Tulevaisuuden_Ampuja	Koiraseura	Koiraseura
Hammaspeikkoseura	Tulevaisuuden_Ampuja	Hammaspeikkoseura	Hammaspeikkoseura
dog	Tulevaisuuden_Ampuja	dog	dog
Savu_Seura	Tulevaisuuden_Ampuja	Savu Seura	Savu_Seura
OMAS	Tulevaisuuden_Ampuja	OMAS	OMAS
Pelleseura	Tulevaisuuden_Ampuja	Pelleseura	Pelleseura
Yung_Tallent	Tulevaisuuden_Ampuja	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Tulevaisuuden_Ampuja	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Tulevaisuuden_Ampuja	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Tulevaisuuden_Ampuja	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Tulevaisuuden_Ampuja	Ampumataito	Ampumataito
Poliisiseura	Pikakivaari-klassikko	Poliisiseura	Poliisiseura
Koiraseura	Pikakivaari-klassikko	Koiraseura	Koiraseura
Hammaspeikkoseura	Pikakivaari-klassikko	Hammaspeikkoseura	Hammaspeikkoseura
dog	Pikakivaari-klassikko	dog	dog
Savu_Seura	Pikakivaari-klassikko	Savu Seura	Savu_Seura
OMAS	Pikakivaari-klassikko	OMAS	OMAS
Pelleseura	Pikakivaari-klassikko	Pelleseura	Pelleseura
Yung_Tallent	Pikakivaari-klassikko	Yung Tallent	Yung_Tallent
Aseharrastajien_Yhtenaisyys	Pikakivaari-klassikko	Aseharrastajien Yhten├ñisyys	Aseharrastajien_Yhtenaisyys
Tahtaysmestarit	Pikakivaari-klassikko	T├ñht├ñysmestarit	Tahtaysmestarit
Laukausryhma_Aurora	Pikakivaari-klassikko	Laukausryhm├ñ Aurora	Laukausryhma_Aurora
Ampumataito	Pikakivaari-klassikko	Ampumataito	Ampumataito
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member (user_id, competition_id, team_name) FROM stdin;
2	Tarkka-ammunta_Cup	Poliisiseura
2	Nopean_laukauksen_mestaruus	Poliisiseura
2	Moniottelu	Poliisiseura
2	Kansallinen_tahtayskilpailu	Poliisiseura
2	Kaupunkiammunta-challenge	Poliisiseura
2	Laukausmaraton	Poliisiseura
2	Vapaa-asekilpailu	Poliisiseura
2	Taitoluodikko-turnaus	Poliisiseura
2	Precision_Pistol_Cup	Poliisiseura
2	Tulevaisuuden_Ampuja	Poliisiseura
2	Pikakivaari-klassikko	Poliisiseura
3	Tarkka-ammunta_Cup	Poliisiseura
3	Nopean_laukauksen_mestaruus	Poliisiseura
3	Moniottelu	Poliisiseura
3	Kansallinen_tahtayskilpailu	Poliisiseura
3	Kaupunkiammunta-challenge	Poliisiseura
3	Laukausmaraton	Poliisiseura
3	Vapaa-asekilpailu	Poliisiseura
3	Taitoluodikko-turnaus	Poliisiseura
3	Precision_Pistol_Cup	Poliisiseura
3	Tulevaisuuden_Ampuja	Poliisiseura
3	Pikakivaari-klassikko	Poliisiseura
4	Tarkka-ammunta_Cup	Poliisiseura
4	Nopean_laukauksen_mestaruus	Poliisiseura
4	Moniottelu	Poliisiseura
4	Kansallinen_tahtayskilpailu	Poliisiseura
4	Kaupunkiammunta-challenge	Poliisiseura
4	Laukausmaraton	Poliisiseura
4	Vapaa-asekilpailu	Poliisiseura
4	Taitoluodikko-turnaus	Poliisiseura
4	Precision_Pistol_Cup	Poliisiseura
4	Tulevaisuuden_Ampuja	Poliisiseura
4	Pikakivaari-klassikko	Poliisiseura
5	Tarkka-ammunta_Cup	Koiraseura
5	Nopean_laukauksen_mestaruus	Koiraseura
5	Moniottelu	Koiraseura
5	Kansallinen_tahtayskilpailu	Koiraseura
5	Kaupunkiammunta-challenge	Koiraseura
5	Laukausmaraton	Koiraseura
5	Vapaa-asekilpailu	Koiraseura
5	Taitoluodikko-turnaus	Koiraseura
5	Precision_Pistol_Cup	Koiraseura
5	Tulevaisuuden_Ampuja	Koiraseura
5	Pikakivaari-klassikko	Koiraseura
6	Tarkka-ammunta_Cup	Koiraseura
6	Nopean_laukauksen_mestaruus	Koiraseura
6	Moniottelu	Koiraseura
6	Kansallinen_tahtayskilpailu	Koiraseura
6	Kaupunkiammunta-challenge	Koiraseura
6	Laukausmaraton	Koiraseura
6	Vapaa-asekilpailu	Koiraseura
6	Taitoluodikko-turnaus	Koiraseura
6	Precision_Pistol_Cup	Koiraseura
6	Tulevaisuuden_Ampuja	Koiraseura
6	Pikakivaari-klassikko	Koiraseura
7	Tarkka-ammunta_Cup	Koiraseura
7	Nopean_laukauksen_mestaruus	Koiraseura
7	Moniottelu	Koiraseura
7	Kansallinen_tahtayskilpailu	Koiraseura
7	Kaupunkiammunta-challenge	Koiraseura
7	Laukausmaraton	Koiraseura
7	Vapaa-asekilpailu	Koiraseura
7	Taitoluodikko-turnaus	Koiraseura
7	Precision_Pistol_Cup	Koiraseura
7	Tulevaisuuden_Ampuja	Koiraseura
7	Pikakivaari-klassikko	Koiraseura
8	Tarkka-ammunta_Cup	Koiraseura
8	Nopean_laukauksen_mestaruus	Koiraseura
8	Moniottelu	Koiraseura
8	Kansallinen_tahtayskilpailu	Koiraseura
8	Kaupunkiammunta-challenge	Koiraseura
8	Laukausmaraton	Koiraseura
8	Vapaa-asekilpailu	Koiraseura
8	Taitoluodikko-turnaus	Koiraseura
8	Precision_Pistol_Cup	Koiraseura
8	Tulevaisuuden_Ampuja	Koiraseura
8	Pikakivaari-klassikko	Koiraseura
9	Tarkka-ammunta_Cup	Koiraseura
9	Nopean_laukauksen_mestaruus	Koiraseura
9	Moniottelu	Koiraseura
9	Kansallinen_tahtayskilpailu	Koiraseura
9	Kaupunkiammunta-challenge	Koiraseura
9	Laukausmaraton	Koiraseura
9	Vapaa-asekilpailu	Koiraseura
9	Taitoluodikko-turnaus	Koiraseura
9	Precision_Pistol_Cup	Koiraseura
9	Tulevaisuuden_Ampuja	Koiraseura
9	Pikakivaari-klassikko	Koiraseura
10	Tarkka-ammunta_Cup	Hammaspeikkoseura
10	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
10	Moniottelu	Hammaspeikkoseura
10	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
10	Kaupunkiammunta-challenge	Hammaspeikkoseura
10	Laukausmaraton	Hammaspeikkoseura
10	Vapaa-asekilpailu	Hammaspeikkoseura
10	Taitoluodikko-turnaus	Hammaspeikkoseura
10	Precision_Pistol_Cup	Hammaspeikkoseura
10	Tulevaisuuden_Ampuja	Hammaspeikkoseura
10	Pikakivaari-klassikko	Hammaspeikkoseura
11	Tarkka-ammunta_Cup	Hammaspeikkoseura
11	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
11	Moniottelu	Hammaspeikkoseura
11	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
11	Kaupunkiammunta-challenge	Hammaspeikkoseura
11	Laukausmaraton	Hammaspeikkoseura
11	Vapaa-asekilpailu	Hammaspeikkoseura
11	Taitoluodikko-turnaus	Hammaspeikkoseura
11	Precision_Pistol_Cup	Hammaspeikkoseura
11	Tulevaisuuden_Ampuja	Hammaspeikkoseura
11	Pikakivaari-klassikko	Hammaspeikkoseura
12	Tarkka-ammunta_Cup	Hammaspeikkoseura
12	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
12	Moniottelu	Hammaspeikkoseura
12	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
12	Kaupunkiammunta-challenge	Hammaspeikkoseura
12	Laukausmaraton	Hammaspeikkoseura
12	Vapaa-asekilpailu	Hammaspeikkoseura
12	Taitoluodikko-turnaus	Hammaspeikkoseura
12	Precision_Pistol_Cup	Hammaspeikkoseura
12	Tulevaisuuden_Ampuja	Hammaspeikkoseura
12	Pikakivaari-klassikko	Hammaspeikkoseura
13	Tarkka-ammunta_Cup	Hammaspeikkoseura
13	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
13	Moniottelu	Hammaspeikkoseura
13	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
13	Kaupunkiammunta-challenge	Hammaspeikkoseura
13	Laukausmaraton	Hammaspeikkoseura
13	Vapaa-asekilpailu	Hammaspeikkoseura
13	Taitoluodikko-turnaus	Hammaspeikkoseura
13	Precision_Pistol_Cup	Hammaspeikkoseura
13	Tulevaisuuden_Ampuja	Hammaspeikkoseura
13	Pikakivaari-klassikko	Hammaspeikkoseura
14	Tarkka-ammunta_Cup	Hammaspeikkoseura
14	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
14	Moniottelu	Hammaspeikkoseura
14	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
14	Kaupunkiammunta-challenge	Hammaspeikkoseura
14	Laukausmaraton	Hammaspeikkoseura
14	Vapaa-asekilpailu	Hammaspeikkoseura
14	Taitoluodikko-turnaus	Hammaspeikkoseura
14	Precision_Pistol_Cup	Hammaspeikkoseura
14	Tulevaisuuden_Ampuja	Hammaspeikkoseura
14	Pikakivaari-klassikko	Hammaspeikkoseura
15	Tarkka-ammunta_Cup	dog
15	Nopean_laukauksen_mestaruus	dog
15	Moniottelu	dog
15	Kansallinen_tahtayskilpailu	dog
15	Kaupunkiammunta-challenge	dog
15	Laukausmaraton	dog
15	Vapaa-asekilpailu	dog
15	Taitoluodikko-turnaus	dog
15	Precision_Pistol_Cup	dog
15	Tulevaisuuden_Ampuja	dog
15	Pikakivaari-klassikko	dog
16	Tarkka-ammunta_Cup	dog
16	Nopean_laukauksen_mestaruus	dog
16	Moniottelu	dog
16	Kansallinen_tahtayskilpailu	dog
16	Kaupunkiammunta-challenge	dog
16	Laukausmaraton	dog
16	Vapaa-asekilpailu	dog
16	Taitoluodikko-turnaus	dog
16	Precision_Pistol_Cup	dog
16	Tulevaisuuden_Ampuja	dog
16	Pikakivaari-klassikko	dog
17	Tarkka-ammunta_Cup	dog
17	Nopean_laukauksen_mestaruus	dog
17	Moniottelu	dog
17	Kansallinen_tahtayskilpailu	dog
17	Kaupunkiammunta-challenge	dog
17	Laukausmaraton	dog
17	Vapaa-asekilpailu	dog
17	Taitoluodikko-turnaus	dog
17	Precision_Pistol_Cup	dog
17	Tulevaisuuden_Ampuja	dog
17	Pikakivaari-klassikko	dog
18	Tarkka-ammunta_Cup	dog
18	Nopean_laukauksen_mestaruus	dog
18	Moniottelu	dog
18	Kansallinen_tahtayskilpailu	dog
18	Kaupunkiammunta-challenge	dog
18	Laukausmaraton	dog
18	Vapaa-asekilpailu	dog
18	Taitoluodikko-turnaus	dog
18	Precision_Pistol_Cup	dog
18	Tulevaisuuden_Ampuja	dog
18	Pikakivaari-klassikko	dog
19	Tarkka-ammunta_Cup	Savu_Seura
19	Nopean_laukauksen_mestaruus	Savu_Seura
19	Moniottelu	Savu_Seura
19	Kansallinen_tahtayskilpailu	Savu_Seura
19	Kaupunkiammunta-challenge	Savu_Seura
19	Laukausmaraton	Savu_Seura
19	Vapaa-asekilpailu	Savu_Seura
19	Taitoluodikko-turnaus	Savu_Seura
19	Precision_Pistol_Cup	Savu_Seura
19	Tulevaisuuden_Ampuja	Savu_Seura
19	Pikakivaari-klassikko	Savu_Seura
20	Tarkka-ammunta_Cup	Savu_Seura
20	Nopean_laukauksen_mestaruus	Savu_Seura
20	Moniottelu	Savu_Seura
20	Kansallinen_tahtayskilpailu	Savu_Seura
20	Kaupunkiammunta-challenge	Savu_Seura
20	Laukausmaraton	Savu_Seura
20	Vapaa-asekilpailu	Savu_Seura
20	Taitoluodikko-turnaus	Savu_Seura
20	Precision_Pistol_Cup	Savu_Seura
20	Tulevaisuuden_Ampuja	Savu_Seura
20	Pikakivaari-klassikko	Savu_Seura
21	Tarkka-ammunta_Cup	Savu_Seura
21	Nopean_laukauksen_mestaruus	Savu_Seura
21	Moniottelu	Savu_Seura
21	Kansallinen_tahtayskilpailu	Savu_Seura
21	Kaupunkiammunta-challenge	Savu_Seura
21	Laukausmaraton	Savu_Seura
21	Vapaa-asekilpailu	Savu_Seura
21	Taitoluodikko-turnaus	Savu_Seura
21	Precision_Pistol_Cup	Savu_Seura
21	Tulevaisuuden_Ampuja	Savu_Seura
21	Pikakivaari-klassikko	Savu_Seura
22	Tarkka-ammunta_Cup	Savu_Seura
22	Nopean_laukauksen_mestaruus	Savu_Seura
22	Moniottelu	Savu_Seura
22	Kansallinen_tahtayskilpailu	Savu_Seura
22	Kaupunkiammunta-challenge	Savu_Seura
22	Laukausmaraton	Savu_Seura
22	Vapaa-asekilpailu	Savu_Seura
22	Taitoluodikko-turnaus	Savu_Seura
22	Precision_Pistol_Cup	Savu_Seura
22	Tulevaisuuden_Ampuja	Savu_Seura
22	Pikakivaari-klassikko	Savu_Seura
23	Tarkka-ammunta_Cup	Savu_Seura
23	Nopean_laukauksen_mestaruus	Savu_Seura
23	Moniottelu	Savu_Seura
23	Kansallinen_tahtayskilpailu	Savu_Seura
23	Kaupunkiammunta-challenge	Savu_Seura
23	Laukausmaraton	Savu_Seura
23	Vapaa-asekilpailu	Savu_Seura
23	Taitoluodikko-turnaus	Savu_Seura
23	Precision_Pistol_Cup	Savu_Seura
23	Tulevaisuuden_Ampuja	Savu_Seura
23	Pikakivaari-klassikko	Savu_Seura
24	Tarkka-ammunta_Cup	OMAS
24	Nopean_laukauksen_mestaruus	OMAS
24	Moniottelu	OMAS
24	Kansallinen_tahtayskilpailu	OMAS
24	Kaupunkiammunta-challenge	OMAS
24	Laukausmaraton	OMAS
24	Vapaa-asekilpailu	OMAS
24	Taitoluodikko-turnaus	OMAS
24	Precision_Pistol_Cup	OMAS
24	Tulevaisuuden_Ampuja	OMAS
24	Pikakivaari-klassikko	OMAS
25	Tarkka-ammunta_Cup	OMAS
25	Nopean_laukauksen_mestaruus	OMAS
25	Moniottelu	OMAS
25	Kansallinen_tahtayskilpailu	OMAS
25	Kaupunkiammunta-challenge	OMAS
25	Laukausmaraton	OMAS
25	Vapaa-asekilpailu	OMAS
25	Taitoluodikko-turnaus	OMAS
25	Precision_Pistol_Cup	OMAS
25	Tulevaisuuden_Ampuja	OMAS
25	Pikakivaari-klassikko	OMAS
26	Tarkka-ammunta_Cup	OMAS
26	Nopean_laukauksen_mestaruus	OMAS
26	Moniottelu	OMAS
26	Kansallinen_tahtayskilpailu	OMAS
26	Kaupunkiammunta-challenge	OMAS
26	Laukausmaraton	OMAS
26	Vapaa-asekilpailu	OMAS
26	Taitoluodikko-turnaus	OMAS
26	Precision_Pistol_Cup	OMAS
26	Tulevaisuuden_Ampuja	OMAS
26	Pikakivaari-klassikko	OMAS
27	Tarkka-ammunta_Cup	OMAS
27	Nopean_laukauksen_mestaruus	OMAS
27	Moniottelu	OMAS
27	Kansallinen_tahtayskilpailu	OMAS
27	Kaupunkiammunta-challenge	OMAS
27	Laukausmaraton	OMAS
27	Vapaa-asekilpailu	OMAS
27	Taitoluodikko-turnaus	OMAS
27	Precision_Pistol_Cup	OMAS
27	Tulevaisuuden_Ampuja	OMAS
27	Pikakivaari-klassikko	OMAS
28	Tarkka-ammunta_Cup	Pelleseura
28	Nopean_laukauksen_mestaruus	Pelleseura
28	Moniottelu	Pelleseura
28	Kansallinen_tahtayskilpailu	Pelleseura
28	Kaupunkiammunta-challenge	Pelleseura
28	Laukausmaraton	Pelleseura
28	Vapaa-asekilpailu	Pelleseura
28	Taitoluodikko-turnaus	Pelleseura
28	Precision_Pistol_Cup	Pelleseura
28	Tulevaisuuden_Ampuja	Pelleseura
28	Pikakivaari-klassikko	Pelleseura
29	Tarkka-ammunta_Cup	Pelleseura
29	Nopean_laukauksen_mestaruus	Pelleseura
29	Moniottelu	Pelleseura
29	Kansallinen_tahtayskilpailu	Pelleseura
29	Kaupunkiammunta-challenge	Pelleseura
29	Laukausmaraton	Pelleseura
29	Vapaa-asekilpailu	Pelleseura
29	Taitoluodikko-turnaus	Pelleseura
29	Precision_Pistol_Cup	Pelleseura
29	Tulevaisuuden_Ampuja	Pelleseura
29	Pikakivaari-klassikko	Pelleseura
30	Tarkka-ammunta_Cup	Pelleseura
30	Nopean_laukauksen_mestaruus	Pelleseura
30	Moniottelu	Pelleseura
30	Kansallinen_tahtayskilpailu	Pelleseura
30	Kaupunkiammunta-challenge	Pelleseura
30	Laukausmaraton	Pelleseura
30	Vapaa-asekilpailu	Pelleseura
30	Taitoluodikko-turnaus	Pelleseura
30	Precision_Pistol_Cup	Pelleseura
30	Tulevaisuuden_Ampuja	Pelleseura
30	Pikakivaari-klassikko	Pelleseura
31	Tarkka-ammunta_Cup	Pelleseura
31	Nopean_laukauksen_mestaruus	Pelleseura
31	Moniottelu	Pelleseura
31	Kansallinen_tahtayskilpailu	Pelleseura
31	Kaupunkiammunta-challenge	Pelleseura
31	Laukausmaraton	Pelleseura
31	Vapaa-asekilpailu	Pelleseura
31	Taitoluodikko-turnaus	Pelleseura
31	Precision_Pistol_Cup	Pelleseura
31	Tulevaisuuden_Ampuja	Pelleseura
31	Pikakivaari-klassikko	Pelleseura
32	Tarkka-ammunta_Cup	Yung_Tallent
32	Nopean_laukauksen_mestaruus	Yung_Tallent
32	Moniottelu	Yung_Tallent
32	Kansallinen_tahtayskilpailu	Yung_Tallent
32	Kaupunkiammunta-challenge	Yung_Tallent
32	Laukausmaraton	Yung_Tallent
32	Vapaa-asekilpailu	Yung_Tallent
32	Taitoluodikko-turnaus	Yung_Tallent
32	Precision_Pistol_Cup	Yung_Tallent
32	Tulevaisuuden_Ampuja	Yung_Tallent
32	Pikakivaari-klassikko	Yung_Tallent
33	Tarkka-ammunta_Cup	Yung_Tallent
33	Nopean_laukauksen_mestaruus	Yung_Tallent
33	Moniottelu	Yung_Tallent
33	Kansallinen_tahtayskilpailu	Yung_Tallent
33	Kaupunkiammunta-challenge	Yung_Tallent
33	Laukausmaraton	Yung_Tallent
33	Vapaa-asekilpailu	Yung_Tallent
33	Taitoluodikko-turnaus	Yung_Tallent
33	Precision_Pistol_Cup	Yung_Tallent
33	Tulevaisuuden_Ampuja	Yung_Tallent
33	Pikakivaari-klassikko	Yung_Tallent
34	Tarkka-ammunta_Cup	Yung_Tallent
34	Nopean_laukauksen_mestaruus	Yung_Tallent
34	Moniottelu	Yung_Tallent
34	Kansallinen_tahtayskilpailu	Yung_Tallent
34	Kaupunkiammunta-challenge	Yung_Tallent
34	Laukausmaraton	Yung_Tallent
34	Vapaa-asekilpailu	Yung_Tallent
34	Taitoluodikko-turnaus	Yung_Tallent
34	Precision_Pistol_Cup	Yung_Tallent
34	Tulevaisuuden_Ampuja	Yung_Tallent
34	Pikakivaari-klassikko	Yung_Tallent
35	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
35	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
35	Moniottelu	Aseharrastajien_Yhtenaisyys
35	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
35	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
35	Laukausmaraton	Aseharrastajien_Yhtenaisyys
35	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
35	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
35	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
35	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
35	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
36	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
36	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
36	Moniottelu	Aseharrastajien_Yhtenaisyys
36	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
36	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
36	Laukausmaraton	Aseharrastajien_Yhtenaisyys
36	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
36	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
36	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
36	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
36	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
37	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
37	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
37	Moniottelu	Aseharrastajien_Yhtenaisyys
37	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
37	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
37	Laukausmaraton	Aseharrastajien_Yhtenaisyys
37	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
37	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
37	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
37	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
37	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
38	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
38	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
38	Moniottelu	Aseharrastajien_Yhtenaisyys
38	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
38	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
38	Laukausmaraton	Aseharrastajien_Yhtenaisyys
38	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
38	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
38	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
38	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
38	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
39	Tarkka-ammunta_Cup	Tahtaysmestarit
39	Nopean_laukauksen_mestaruus	Tahtaysmestarit
39	Moniottelu	Tahtaysmestarit
39	Kansallinen_tahtayskilpailu	Tahtaysmestarit
39	Kaupunkiammunta-challenge	Tahtaysmestarit
39	Laukausmaraton	Tahtaysmestarit
39	Vapaa-asekilpailu	Tahtaysmestarit
39	Taitoluodikko-turnaus	Tahtaysmestarit
39	Precision_Pistol_Cup	Tahtaysmestarit
39	Tulevaisuuden_Ampuja	Tahtaysmestarit
39	Pikakivaari-klassikko	Tahtaysmestarit
40	Tarkka-ammunta_Cup	Tahtaysmestarit
40	Nopean_laukauksen_mestaruus	Tahtaysmestarit
40	Moniottelu	Tahtaysmestarit
40	Kansallinen_tahtayskilpailu	Tahtaysmestarit
40	Kaupunkiammunta-challenge	Tahtaysmestarit
40	Laukausmaraton	Tahtaysmestarit
40	Vapaa-asekilpailu	Tahtaysmestarit
40	Taitoluodikko-turnaus	Tahtaysmestarit
40	Precision_Pistol_Cup	Tahtaysmestarit
40	Tulevaisuuden_Ampuja	Tahtaysmestarit
40	Pikakivaari-klassikko	Tahtaysmestarit
41	Tarkka-ammunta_Cup	Tahtaysmestarit
41	Nopean_laukauksen_mestaruus	Tahtaysmestarit
41	Moniottelu	Tahtaysmestarit
41	Kansallinen_tahtayskilpailu	Tahtaysmestarit
41	Kaupunkiammunta-challenge	Tahtaysmestarit
41	Laukausmaraton	Tahtaysmestarit
41	Vapaa-asekilpailu	Tahtaysmestarit
41	Taitoluodikko-turnaus	Tahtaysmestarit
41	Precision_Pistol_Cup	Tahtaysmestarit
41	Tulevaisuuden_Ampuja	Tahtaysmestarit
41	Pikakivaari-klassikko	Tahtaysmestarit
42	Tarkka-ammunta_Cup	Tahtaysmestarit
42	Nopean_laukauksen_mestaruus	Tahtaysmestarit
42	Moniottelu	Tahtaysmestarit
42	Kansallinen_tahtayskilpailu	Tahtaysmestarit
42	Kaupunkiammunta-challenge	Tahtaysmestarit
42	Laukausmaraton	Tahtaysmestarit
42	Vapaa-asekilpailu	Tahtaysmestarit
42	Taitoluodikko-turnaus	Tahtaysmestarit
42	Precision_Pistol_Cup	Tahtaysmestarit
42	Tulevaisuuden_Ampuja	Tahtaysmestarit
42	Pikakivaari-klassikko	Tahtaysmestarit
43	Tarkka-ammunta_Cup	Laukausryhma_Aurora
43	Nopean_laukauksen_mestaruus	Laukausryhma_Aurora
43	Moniottelu	Laukausryhma_Aurora
43	Kansallinen_tahtayskilpailu	Laukausryhma_Aurora
43	Kaupunkiammunta-challenge	Laukausryhma_Aurora
43	Laukausmaraton	Laukausryhma_Aurora
43	Vapaa-asekilpailu	Laukausryhma_Aurora
43	Taitoluodikko-turnaus	Laukausryhma_Aurora
43	Precision_Pistol_Cup	Laukausryhma_Aurora
43	Tulevaisuuden_Ampuja	Laukausryhma_Aurora
43	Pikakivaari-klassikko	Laukausryhma_Aurora
44	Tarkka-ammunta_Cup	Laukausryhma_Aurora
44	Nopean_laukauksen_mestaruus	Laukausryhma_Aurora
44	Moniottelu	Laukausryhma_Aurora
44	Kansallinen_tahtayskilpailu	Laukausryhma_Aurora
44	Kaupunkiammunta-challenge	Laukausryhma_Aurora
44	Laukausmaraton	Laukausryhma_Aurora
44	Vapaa-asekilpailu	Laukausryhma_Aurora
44	Taitoluodikko-turnaus	Laukausryhma_Aurora
44	Precision_Pistol_Cup	Laukausryhma_Aurora
44	Tulevaisuuden_Ampuja	Laukausryhma_Aurora
44	Pikakivaari-klassikko	Laukausryhma_Aurora
45	Tarkka-ammunta_Cup	Laukausryhma_Aurora
45	Nopean_laukauksen_mestaruus	Laukausryhma_Aurora
45	Moniottelu	Laukausryhma_Aurora
45	Kansallinen_tahtayskilpailu	Laukausryhma_Aurora
45	Kaupunkiammunta-challenge	Laukausryhma_Aurora
45	Laukausmaraton	Laukausryhma_Aurora
45	Vapaa-asekilpailu	Laukausryhma_Aurora
45	Taitoluodikko-turnaus	Laukausryhma_Aurora
45	Precision_Pistol_Cup	Laukausryhma_Aurora
45	Tulevaisuuden_Ampuja	Laukausryhma_Aurora
45	Pikakivaari-klassikko	Laukausryhma_Aurora
46	Tarkka-ammunta_Cup	Ampumataito
46	Nopean_laukauksen_mestaruus	Ampumataito
46	Moniottelu	Ampumataito
46	Kansallinen_tahtayskilpailu	Ampumataito
46	Kaupunkiammunta-challenge	Ampumataito
46	Laukausmaraton	Ampumataito
46	Vapaa-asekilpailu	Ampumataito
46	Taitoluodikko-turnaus	Ampumataito
46	Precision_Pistol_Cup	Ampumataito
46	Tulevaisuuden_Ampuja	Ampumataito
46	Pikakivaari-klassikko	Ampumataito
47	Tarkka-ammunta_Cup	Ampumataito
47	Nopean_laukauksen_mestaruus	Ampumataito
47	Moniottelu	Ampumataito
47	Kansallinen_tahtayskilpailu	Ampumataito
47	Kaupunkiammunta-challenge	Ampumataito
47	Laukausmaraton	Ampumataito
47	Vapaa-asekilpailu	Ampumataito
47	Taitoluodikko-turnaus	Ampumataito
47	Precision_Pistol_Cup	Ampumataito
47	Tulevaisuuden_Ampuja	Ampumataito
47	Pikakivaari-klassikko	Ampumataito
48	Tarkka-ammunta_Cup	Ampumataito
48	Nopean_laukauksen_mestaruus	Ampumataito
48	Moniottelu	Ampumataito
48	Kansallinen_tahtayskilpailu	Ampumataito
48	Kaupunkiammunta-challenge	Ampumataito
48	Laukausmaraton	Ampumataito
48	Vapaa-asekilpailu	Ampumataito
48	Taitoluodikko-turnaus	Ampumataito
48	Precision_Pistol_Cup	Ampumataito
48	Tulevaisuuden_Ampuja	Ampumataito
48	Pikakivaari-klassikko	Ampumataito
2	Kesan_Ampujaiset	Poliisiseura
2	Talvi_Pistooli	Poliisiseura
2	Tarkkuuslaukaus-festivaali	Poliisiseura
2	Kivaarikilpailujen_huipennus	Poliisiseura
2	Polaris-ampumaharjoitus	Poliisiseura
2	Aamunkoiton_tahtays	Poliisiseura
2	Nordic_Sharpshooters_Cup	Poliisiseura
2	Taivaanranta-tulitus	Poliisiseura
2	Lumivyory-ammunta	Poliisiseura
3	Kesan_Ampujaiset	Poliisiseura
3	Talvi_Pistooli	Poliisiseura
3	Tarkkuuslaukaus-festivaali	Poliisiseura
3	Kivaarikilpailujen_huipennus	Poliisiseura
3	Polaris-ampumaharjoitus	Poliisiseura
3	Aamunkoiton_tahtays	Poliisiseura
3	Nordic_Sharpshooters_Cup	Poliisiseura
3	Taivaanranta-tulitus	Poliisiseura
3	Lumivyory-ammunta	Poliisiseura
4	Kesan_Ampujaiset	Poliisiseura
4	Talvi_Pistooli	Poliisiseura
4	Tarkkuuslaukaus-festivaali	Poliisiseura
4	Kivaarikilpailujen_huipennus	Poliisiseura
4	Polaris-ampumaharjoitus	Poliisiseura
4	Aamunkoiton_tahtays	Poliisiseura
4	Nordic_Sharpshooters_Cup	Poliisiseura
4	Taivaanranta-tulitus	Poliisiseura
4	Lumivyory-ammunta	Poliisiseura
5	Kesan_Ampujaiset	Koiraseura
5	Talvi_Pistooli	Koiraseura
5	Tarkkuuslaukaus-festivaali	Koiraseura
5	Kivaarikilpailujen_huipennus	Koiraseura
5	Polaris-ampumaharjoitus	Koiraseura
5	Aamunkoiton_tahtays	Koiraseura
5	Nordic_Sharpshooters_Cup	Koiraseura
5	Taivaanranta-tulitus	Koiraseura
5	Lumivyory-ammunta	Koiraseura
6	Kesan_Ampujaiset	Koiraseura
6	Talvi_Pistooli	Koiraseura
6	Tarkkuuslaukaus-festivaali	Koiraseura
6	Kivaarikilpailujen_huipennus	Koiraseura
6	Polaris-ampumaharjoitus	Koiraseura
6	Aamunkoiton_tahtays	Koiraseura
6	Nordic_Sharpshooters_Cup	Koiraseura
6	Taivaanranta-tulitus	Koiraseura
6	Lumivyory-ammunta	Koiraseura
7	Kesan_Ampujaiset	Koiraseura
7	Talvi_Pistooli	Koiraseura
7	Tarkkuuslaukaus-festivaali	Koiraseura
7	Kivaarikilpailujen_huipennus	Koiraseura
7	Polaris-ampumaharjoitus	Koiraseura
7	Aamunkoiton_tahtays	Koiraseura
7	Nordic_Sharpshooters_Cup	Koiraseura
7	Taivaanranta-tulitus	Koiraseura
7	Lumivyory-ammunta	Koiraseura
8	Kesan_Ampujaiset	Koiraseura
8	Talvi_Pistooli	Koiraseura
8	Tarkkuuslaukaus-festivaali	Koiraseura
8	Kivaarikilpailujen_huipennus	Koiraseura
8	Polaris-ampumaharjoitus	Koiraseura
8	Aamunkoiton_tahtays	Koiraseura
8	Nordic_Sharpshooters_Cup	Koiraseura
8	Taivaanranta-tulitus	Koiraseura
8	Lumivyory-ammunta	Koiraseura
9	Kesan_Ampujaiset	Koiraseura
9	Talvi_Pistooli	Koiraseura
9	Tarkkuuslaukaus-festivaali	Koiraseura
9	Kivaarikilpailujen_huipennus	Koiraseura
9	Polaris-ampumaharjoitus	Koiraseura
9	Aamunkoiton_tahtays	Koiraseura
9	Nordic_Sharpshooters_Cup	Koiraseura
9	Taivaanranta-tulitus	Koiraseura
9	Lumivyory-ammunta	Koiraseura
10	Kesan_Ampujaiset	Hammaspeikkoseura
10	Talvi_Pistooli	Hammaspeikkoseura
10	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
10	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
10	Polaris-ampumaharjoitus	Hammaspeikkoseura
10	Aamunkoiton_tahtays	Hammaspeikkoseura
10	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
10	Taivaanranta-tulitus	Hammaspeikkoseura
10	Lumivyory-ammunta	Hammaspeikkoseura
11	Kesan_Ampujaiset	Hammaspeikkoseura
11	Talvi_Pistooli	Hammaspeikkoseura
11	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
11	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
11	Polaris-ampumaharjoitus	Hammaspeikkoseura
11	Aamunkoiton_tahtays	Hammaspeikkoseura
11	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
11	Taivaanranta-tulitus	Hammaspeikkoseura
11	Lumivyory-ammunta	Hammaspeikkoseura
12	Kesan_Ampujaiset	Hammaspeikkoseura
12	Talvi_Pistooli	Hammaspeikkoseura
12	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
12	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
12	Polaris-ampumaharjoitus	Hammaspeikkoseura
12	Aamunkoiton_tahtays	Hammaspeikkoseura
12	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
12	Taivaanranta-tulitus	Hammaspeikkoseura
12	Lumivyory-ammunta	Hammaspeikkoseura
13	Kesan_Ampujaiset	Hammaspeikkoseura
13	Talvi_Pistooli	Hammaspeikkoseura
13	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
13	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
13	Polaris-ampumaharjoitus	Hammaspeikkoseura
13	Aamunkoiton_tahtays	Hammaspeikkoseura
13	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
13	Taivaanranta-tulitus	Hammaspeikkoseura
13	Lumivyory-ammunta	Hammaspeikkoseura
14	Kesan_Ampujaiset	Hammaspeikkoseura
14	Talvi_Pistooli	Hammaspeikkoseura
14	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
14	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
14	Polaris-ampumaharjoitus	Hammaspeikkoseura
14	Aamunkoiton_tahtays	Hammaspeikkoseura
14	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
14	Taivaanranta-tulitus	Hammaspeikkoseura
14	Lumivyory-ammunta	Hammaspeikkoseura
15	Kesan_Ampujaiset	dog
15	Talvi_Pistooli	dog
15	Tarkkuuslaukaus-festivaali	dog
15	Kivaarikilpailujen_huipennus	dog
15	Polaris-ampumaharjoitus	dog
15	Aamunkoiton_tahtays	dog
15	Nordic_Sharpshooters_Cup	dog
15	Taivaanranta-tulitus	dog
15	Lumivyory-ammunta	dog
16	Kesan_Ampujaiset	dog
16	Talvi_Pistooli	dog
16	Tarkkuuslaukaus-festivaali	dog
16	Kivaarikilpailujen_huipennus	dog
16	Polaris-ampumaharjoitus	dog
16	Aamunkoiton_tahtays	dog
16	Nordic_Sharpshooters_Cup	dog
16	Taivaanranta-tulitus	dog
16	Lumivyory-ammunta	dog
17	Kesan_Ampujaiset	dog
17	Talvi_Pistooli	dog
17	Tarkkuuslaukaus-festivaali	dog
17	Kivaarikilpailujen_huipennus	dog
17	Polaris-ampumaharjoitus	dog
17	Aamunkoiton_tahtays	dog
17	Nordic_Sharpshooters_Cup	dog
17	Taivaanranta-tulitus	dog
17	Lumivyory-ammunta	dog
18	Kesan_Ampujaiset	dog
18	Talvi_Pistooli	dog
18	Tarkkuuslaukaus-festivaali	dog
18	Kivaarikilpailujen_huipennus	dog
18	Polaris-ampumaharjoitus	dog
18	Aamunkoiton_tahtays	dog
18	Nordic_Sharpshooters_Cup	dog
18	Taivaanranta-tulitus	dog
18	Lumivyory-ammunta	dog
19	Kesan_Ampujaiset	Savu_Seura
19	Talvi_Pistooli	Savu_Seura
19	Tarkkuuslaukaus-festivaali	Savu_Seura
19	Kivaarikilpailujen_huipennus	Savu_Seura
19	Polaris-ampumaharjoitus	Savu_Seura
19	Aamunkoiton_tahtays	Savu_Seura
19	Nordic_Sharpshooters_Cup	Savu_Seura
19	Taivaanranta-tulitus	Savu_Seura
19	Lumivyory-ammunta	Savu_Seura
20	Kesan_Ampujaiset	Savu_Seura
20	Talvi_Pistooli	Savu_Seura
20	Tarkkuuslaukaus-festivaali	Savu_Seura
20	Kivaarikilpailujen_huipennus	Savu_Seura
20	Polaris-ampumaharjoitus	Savu_Seura
20	Aamunkoiton_tahtays	Savu_Seura
20	Nordic_Sharpshooters_Cup	Savu_Seura
20	Taivaanranta-tulitus	Savu_Seura
20	Lumivyory-ammunta	Savu_Seura
21	Kesan_Ampujaiset	Savu_Seura
21	Talvi_Pistooli	Savu_Seura
21	Tarkkuuslaukaus-festivaali	Savu_Seura
21	Kivaarikilpailujen_huipennus	Savu_Seura
21	Polaris-ampumaharjoitus	Savu_Seura
21	Aamunkoiton_tahtays	Savu_Seura
21	Nordic_Sharpshooters_Cup	Savu_Seura
21	Taivaanranta-tulitus	Savu_Seura
21	Lumivyory-ammunta	Savu_Seura
22	Kesan_Ampujaiset	Savu_Seura
22	Talvi_Pistooli	Savu_Seura
22	Tarkkuuslaukaus-festivaali	Savu_Seura
22	Kivaarikilpailujen_huipennus	Savu_Seura
22	Polaris-ampumaharjoitus	Savu_Seura
22	Aamunkoiton_tahtays	Savu_Seura
22	Nordic_Sharpshooters_Cup	Savu_Seura
22	Taivaanranta-tulitus	Savu_Seura
22	Lumivyory-ammunta	Savu_Seura
23	Kesan_Ampujaiset	Savu_Seura
23	Talvi_Pistooli	Savu_Seura
23	Tarkkuuslaukaus-festivaali	Savu_Seura
23	Kivaarikilpailujen_huipennus	Savu_Seura
23	Polaris-ampumaharjoitus	Savu_Seura
23	Aamunkoiton_tahtays	Savu_Seura
23	Nordic_Sharpshooters_Cup	Savu_Seura
23	Taivaanranta-tulitus	Savu_Seura
23	Lumivyory-ammunta	Savu_Seura
24	Kesan_Ampujaiset	OMAS
24	Talvi_Pistooli	OMAS
24	Tarkkuuslaukaus-festivaali	OMAS
24	Kivaarikilpailujen_huipennus	OMAS
24	Polaris-ampumaharjoitus	OMAS
24	Aamunkoiton_tahtays	OMAS
24	Nordic_Sharpshooters_Cup	OMAS
24	Taivaanranta-tulitus	OMAS
24	Lumivyory-ammunta	OMAS
25	Kesan_Ampujaiset	OMAS
25	Talvi_Pistooli	OMAS
25	Tarkkuuslaukaus-festivaali	OMAS
25	Kivaarikilpailujen_huipennus	OMAS
25	Polaris-ampumaharjoitus	OMAS
25	Aamunkoiton_tahtays	OMAS
25	Nordic_Sharpshooters_Cup	OMAS
25	Taivaanranta-tulitus	OMAS
25	Lumivyory-ammunta	OMAS
26	Kesan_Ampujaiset	OMAS
26	Talvi_Pistooli	OMAS
26	Tarkkuuslaukaus-festivaali	OMAS
26	Kivaarikilpailujen_huipennus	OMAS
26	Polaris-ampumaharjoitus	OMAS
26	Aamunkoiton_tahtays	OMAS
26	Nordic_Sharpshooters_Cup	OMAS
26	Taivaanranta-tulitus	OMAS
26	Lumivyory-ammunta	OMAS
27	Kesan_Ampujaiset	OMAS
27	Talvi_Pistooli	OMAS
27	Tarkkuuslaukaus-festivaali	OMAS
27	Kivaarikilpailujen_huipennus	OMAS
27	Polaris-ampumaharjoitus	OMAS
27	Aamunkoiton_tahtays	OMAS
27	Nordic_Sharpshooters_Cup	OMAS
27	Taivaanranta-tulitus	OMAS
27	Lumivyory-ammunta	OMAS
28	Kesan_Ampujaiset	Pelleseura
28	Talvi_Pistooli	Pelleseura
28	Tarkkuuslaukaus-festivaali	Pelleseura
28	Kivaarikilpailujen_huipennus	Pelleseura
28	Polaris-ampumaharjoitus	Pelleseura
28	Aamunkoiton_tahtays	Pelleseura
28	Nordic_Sharpshooters_Cup	Pelleseura
28	Taivaanranta-tulitus	Pelleseura
28	Lumivyory-ammunta	Pelleseura
29	Kesan_Ampujaiset	Pelleseura
29	Talvi_Pistooli	Pelleseura
29	Tarkkuuslaukaus-festivaali	Pelleseura
29	Kivaarikilpailujen_huipennus	Pelleseura
29	Polaris-ampumaharjoitus	Pelleseura
29	Aamunkoiton_tahtays	Pelleseura
29	Nordic_Sharpshooters_Cup	Pelleseura
29	Taivaanranta-tulitus	Pelleseura
29	Lumivyory-ammunta	Pelleseura
30	Kesan_Ampujaiset	Pelleseura
30	Talvi_Pistooli	Pelleseura
30	Tarkkuuslaukaus-festivaali	Pelleseura
30	Kivaarikilpailujen_huipennus	Pelleseura
30	Polaris-ampumaharjoitus	Pelleseura
30	Aamunkoiton_tahtays	Pelleseura
30	Nordic_Sharpshooters_Cup	Pelleseura
30	Taivaanranta-tulitus	Pelleseura
30	Lumivyory-ammunta	Pelleseura
31	Kesan_Ampujaiset	Pelleseura
31	Talvi_Pistooli	Pelleseura
31	Tarkkuuslaukaus-festivaali	Pelleseura
31	Kivaarikilpailujen_huipennus	Pelleseura
31	Polaris-ampumaharjoitus	Pelleseura
31	Aamunkoiton_tahtays	Pelleseura
31	Nordic_Sharpshooters_Cup	Pelleseura
31	Taivaanranta-tulitus	Pelleseura
31	Lumivyory-ammunta	Pelleseura
32	Kesan_Ampujaiset	Yung_Tallent
32	Talvi_Pistooli	Yung_Tallent
32	Tarkkuuslaukaus-festivaali	Yung_Tallent
32	Kivaarikilpailujen_huipennus	Yung_Tallent
32	Polaris-ampumaharjoitus	Yung_Tallent
32	Aamunkoiton_tahtays	Yung_Tallent
32	Nordic_Sharpshooters_Cup	Yung_Tallent
32	Taivaanranta-tulitus	Yung_Tallent
32	Lumivyory-ammunta	Yung_Tallent
33	Kesan_Ampujaiset	Yung_Tallent
33	Talvi_Pistooli	Yung_Tallent
33	Tarkkuuslaukaus-festivaali	Yung_Tallent
33	Kivaarikilpailujen_huipennus	Yung_Tallent
33	Polaris-ampumaharjoitus	Yung_Tallent
33	Aamunkoiton_tahtays	Yung_Tallent
33	Nordic_Sharpshooters_Cup	Yung_Tallent
33	Taivaanranta-tulitus	Yung_Tallent
33	Lumivyory-ammunta	Yung_Tallent
34	Kesan_Ampujaiset	Yung_Tallent
34	Talvi_Pistooli	Yung_Tallent
34	Tarkkuuslaukaus-festivaali	Yung_Tallent
34	Kivaarikilpailujen_huipennus	Yung_Tallent
34	Polaris-ampumaharjoitus	Yung_Tallent
34	Aamunkoiton_tahtays	Yung_Tallent
34	Nordic_Sharpshooters_Cup	Yung_Tallent
34	Taivaanranta-tulitus	Yung_Tallent
34	Lumivyory-ammunta	Yung_Tallent
35	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
35	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
35	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
35	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
35	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
35	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
35	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
35	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
35	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
36	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
36	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
36	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
36	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
36	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
36	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
36	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
36	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
36	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
37	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
37	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
37	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
37	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
37	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
37	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
37	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
37	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
37	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
38	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
38	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
38	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
38	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
38	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
38	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
38	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
38	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
38	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
39	Kesan_Ampujaiset	Tahtaysmestarit
39	Talvi_Pistooli	Tahtaysmestarit
39	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
39	Kivaarikilpailujen_huipennus	Tahtaysmestarit
39	Polaris-ampumaharjoitus	Tahtaysmestarit
39	Aamunkoiton_tahtays	Tahtaysmestarit
39	Nordic_Sharpshooters_Cup	Tahtaysmestarit
39	Taivaanranta-tulitus	Tahtaysmestarit
39	Lumivyory-ammunta	Tahtaysmestarit
40	Kesan_Ampujaiset	Tahtaysmestarit
40	Talvi_Pistooli	Tahtaysmestarit
40	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
40	Kivaarikilpailujen_huipennus	Tahtaysmestarit
40	Polaris-ampumaharjoitus	Tahtaysmestarit
40	Aamunkoiton_tahtays	Tahtaysmestarit
40	Nordic_Sharpshooters_Cup	Tahtaysmestarit
40	Taivaanranta-tulitus	Tahtaysmestarit
40	Lumivyory-ammunta	Tahtaysmestarit
41	Kesan_Ampujaiset	Tahtaysmestarit
41	Talvi_Pistooli	Tahtaysmestarit
41	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
41	Kivaarikilpailujen_huipennus	Tahtaysmestarit
41	Polaris-ampumaharjoitus	Tahtaysmestarit
41	Aamunkoiton_tahtays	Tahtaysmestarit
41	Nordic_Sharpshooters_Cup	Tahtaysmestarit
41	Taivaanranta-tulitus	Tahtaysmestarit
41	Lumivyory-ammunta	Tahtaysmestarit
42	Kesan_Ampujaiset	Tahtaysmestarit
42	Talvi_Pistooli	Tahtaysmestarit
42	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
42	Kivaarikilpailujen_huipennus	Tahtaysmestarit
42	Polaris-ampumaharjoitus	Tahtaysmestarit
42	Aamunkoiton_tahtays	Tahtaysmestarit
42	Nordic_Sharpshooters_Cup	Tahtaysmestarit
42	Taivaanranta-tulitus	Tahtaysmestarit
42	Lumivyory-ammunta	Tahtaysmestarit
43	Kesan_Ampujaiset	Laukausryhma_Aurora
43	Talvi_Pistooli	Laukausryhma_Aurora
43	Tarkkuuslaukaus-festivaali	Laukausryhma_Aurora
43	Kivaarikilpailujen_huipennus	Laukausryhma_Aurora
43	Polaris-ampumaharjoitus	Laukausryhma_Aurora
43	Aamunkoiton_tahtays	Laukausryhma_Aurora
43	Nordic_Sharpshooters_Cup	Laukausryhma_Aurora
43	Taivaanranta-tulitus	Laukausryhma_Aurora
43	Lumivyory-ammunta	Laukausryhma_Aurora
44	Kesan_Ampujaiset	Laukausryhma_Aurora
44	Talvi_Pistooli	Laukausryhma_Aurora
44	Tarkkuuslaukaus-festivaali	Laukausryhma_Aurora
44	Kivaarikilpailujen_huipennus	Laukausryhma_Aurora
44	Polaris-ampumaharjoitus	Laukausryhma_Aurora
44	Aamunkoiton_tahtays	Laukausryhma_Aurora
44	Nordic_Sharpshooters_Cup	Laukausryhma_Aurora
44	Taivaanranta-tulitus	Laukausryhma_Aurora
44	Lumivyory-ammunta	Laukausryhma_Aurora
45	Kesan_Ampujaiset	Laukausryhma_Aurora
45	Talvi_Pistooli	Laukausryhma_Aurora
45	Tarkkuuslaukaus-festivaali	Laukausryhma_Aurora
45	Kivaarikilpailujen_huipennus	Laukausryhma_Aurora
45	Polaris-ampumaharjoitus	Laukausryhma_Aurora
45	Aamunkoiton_tahtays	Laukausryhma_Aurora
45	Nordic_Sharpshooters_Cup	Laukausryhma_Aurora
45	Taivaanranta-tulitus	Laukausryhma_Aurora
45	Lumivyory-ammunta	Laukausryhma_Aurora
46	Kesan_Ampujaiset	Ampumataito
46	Talvi_Pistooli	Ampumataito
46	Tarkkuuslaukaus-festivaali	Ampumataito
46	Kivaarikilpailujen_huipennus	Ampumataito
46	Polaris-ampumaharjoitus	Ampumataito
46	Aamunkoiton_tahtays	Ampumataito
46	Nordic_Sharpshooters_Cup	Ampumataito
46	Taivaanranta-tulitus	Ampumataito
46	Lumivyory-ammunta	Ampumataito
47	Kesan_Ampujaiset	Ampumataito
47	Talvi_Pistooli	Ampumataito
47	Tarkkuuslaukaus-festivaali	Ampumataito
47	Kivaarikilpailujen_huipennus	Ampumataito
47	Polaris-ampumaharjoitus	Ampumataito
47	Aamunkoiton_tahtays	Ampumataito
47	Nordic_Sharpshooters_Cup	Ampumataito
47	Taivaanranta-tulitus	Ampumataito
47	Lumivyory-ammunta	Ampumataito
48	Kesan_Ampujaiset	Ampumataito
48	Talvi_Pistooli	Ampumataito
48	Tarkkuuslaukaus-festivaali	Ampumataito
48	Kivaarikilpailujen_huipennus	Ampumataito
48	Polaris-ampumaharjoitus	Ampumataito
48	Aamunkoiton_tahtays	Ampumataito
48	Nordic_Sharpshooters_Cup	Ampumataito
48	Taivaanranta-tulitus	Ampumataito
48	Lumivyory-ammunta	Ampumataito
\.


--
-- Data for Name: team_member_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member_score (bulls_eye_count, creation_date, sum, user_id, competition_id, team_name) FROM stdin;
10	2024-04-17	363.41014236175994	2	Tarkka-ammunta_Cup	Poliisiseura
10	2024-04-17	321.69792308104286	2	Nopean_laukauksen_mestaruus	Poliisiseura
10	2024-04-17	351.56479272552684	2	Moniottelu	Poliisiseura
10	2024-04-17	332.3317075002108	2	Kansallinen_tahtayskilpailu	Poliisiseura
10	2024-04-17	293.43625440548084	2	Kaupunkiammunta-challenge	Poliisiseura
10	2024-04-17	362.26173083121273	2	Laukausmaraton	Poliisiseura
10	2024-04-17	288.44049059400527	2	Vapaa-asekilpailu	Poliisiseura
10	2024-04-17	337.0693834080598	2	Taitoluodikko-turnaus	Poliisiseura
10	2024-04-17	315.4134970904193	2	Precision_Pistol_Cup	Poliisiseura
10	2024-04-17	269.7752453748767	2	Tulevaisuuden_Ampuja	Poliisiseura
10	2024-04-17	361.6721450650425	2	Pikakivaari-klassikko	Poliisiseura
10	2024-04-17	276.5847325205541	3	Tarkka-ammunta_Cup	Poliisiseura
10	2024-04-17	321.64383867559803	3	Nopean_laukauksen_mestaruus	Poliisiseura
10	2024-04-17	304.1258784742152	3	Moniottelu	Poliisiseura
10	2024-04-17	319.13201282239254	3	Kansallinen_tahtayskilpailu	Poliisiseura
10	2024-04-17	313.9871062698231	3	Kaupunkiammunta-challenge	Poliisiseura
10	2024-04-17	351.4483160754454	3	Laukausmaraton	Poliisiseura
10	2024-04-17	315.30138711986393	3	Vapaa-asekilpailu	Poliisiseura
10	2024-04-17	346.1848950232469	3	Taitoluodikko-turnaus	Poliisiseura
10	2024-04-17	324.2244140133291	3	Precision_Pistol_Cup	Poliisiseura
10	2024-04-17	345.71418300701026	3	Tulevaisuuden_Ampuja	Poliisiseura
10	2024-04-17	301.30724032385643	3	Pikakivaari-klassikko	Poliisiseura
10	2024-04-17	388.7847710026959	4	Tarkka-ammunta_Cup	Poliisiseura
10	2024-04-17	299.3202221301433	4	Nopean_laukauksen_mestaruus	Poliisiseura
10	2024-04-17	283.3555810228573	4	Moniottelu	Poliisiseura
10	2024-04-17	338.0637014520635	4	Kansallinen_tahtayskilpailu	Poliisiseura
10	2024-04-17	366.1728726001856	4	Kaupunkiammunta-challenge	Poliisiseura
10	2024-04-17	304.9961537303509	4	Laukausmaraton	Poliisiseura
10	2024-04-17	327.8000756984385	4	Vapaa-asekilpailu	Poliisiseura
10	2024-04-17	323.5361356069312	4	Taitoluodikko-turnaus	Poliisiseura
10	2024-04-17	303.1410421601207	4	Precision_Pistol_Cup	Poliisiseura
10	2024-04-17	327.59630778014497	4	Tulevaisuuden_Ampuja	Poliisiseura
10	2024-04-17	343.372100895096	4	Pikakivaari-klassikko	Poliisiseura
10	2024-04-17	317.28860982133784	5	Tarkka-ammunta_Cup	Koiraseura
10	2024-04-17	337.46520134428306	5	Nopean_laukauksen_mestaruus	Koiraseura
10	2024-04-17	335.30310280315996	5	Moniottelu	Koiraseura
10	2024-04-17	298.78173523675247	5	Kansallinen_tahtayskilpailu	Koiraseura
10	2024-04-17	342.02846993390875	5	Kaupunkiammunta-challenge	Koiraseura
10	2024-04-17	300.7917492515107	5	Laukausmaraton	Koiraseura
10	2024-04-17	329.85526416326377	5	Vapaa-asekilpailu	Koiraseura
10	2024-04-17	293.1899127622272	5	Taitoluodikko-turnaus	Koiraseura
10	2024-04-17	343.9189096204457	5	Precision_Pistol_Cup	Koiraseura
10	2024-04-17	320.5320696318082	5	Tulevaisuuden_Ampuja	Koiraseura
10	2024-04-17	326.02726243934643	5	Pikakivaari-klassikko	Koiraseura
10	2024-04-17	323.6014583771661	6	Tarkka-ammunta_Cup	Koiraseura
10	2024-04-17	343.3191615957152	6	Nopean_laukauksen_mestaruus	Koiraseura
10	2024-04-17	362.49834521176194	6	Moniottelu	Koiraseura
10	2024-04-17	329.9145365676819	6	Kansallinen_tahtayskilpailu	Koiraseura
10	2024-04-17	293.1639257188614	6	Kaupunkiammunta-challenge	Koiraseura
10	2024-04-17	300.58019290379843	6	Laukausmaraton	Koiraseura
10	2024-04-17	304.03430922054974	6	Vapaa-asekilpailu	Koiraseura
10	2024-04-17	260.24122776775647	6	Taitoluodikko-turnaus	Koiraseura
10	2024-04-17	322.3401799482685	6	Precision_Pistol_Cup	Koiraseura
10	2024-04-17	309.7580133836471	6	Tulevaisuuden_Ampuja	Koiraseura
10	2024-04-17	356.3874550570732	6	Pikakivaari-klassikko	Koiraseura
10	2024-04-17	333.83224008908206	7	Tarkka-ammunta_Cup	Koiraseura
10	2024-04-17	307.87130204058707	7	Nopean_laukauksen_mestaruus	Koiraseura
10	2024-04-17	321.9612910706206	7	Moniottelu	Koiraseura
10	2024-04-17	370.93813992070136	7	Kansallinen_tahtayskilpailu	Koiraseura
10	2024-04-17	291.35288200516175	7	Kaupunkiammunta-challenge	Koiraseura
10	2024-04-17	345.7845406574137	7	Laukausmaraton	Koiraseura
10	2024-04-17	337.78035208890753	7	Vapaa-asekilpailu	Koiraseura
10	2024-04-17	340.18293209442817	7	Taitoluodikko-turnaus	Koiraseura
10	2024-04-17	369.3016390606673	7	Precision_Pistol_Cup	Koiraseura
10	2024-04-17	324.03109667005384	7	Tulevaisuuden_Ampuja	Koiraseura
10	2024-04-17	317.89050739253065	7	Pikakivaari-klassikko	Koiraseura
10	2024-04-17	321.7218248662985	8	Tarkka-ammunta_Cup	Koiraseura
10	2024-04-17	333.3743604844556	8	Nopean_laukauksen_mestaruus	Koiraseura
10	2024-04-17	311.8414775430718	8	Moniottelu	Koiraseura
10	2024-04-17	337.29687344210436	8	Kansallinen_tahtayskilpailu	Koiraseura
10	2024-04-17	337.9588727128265	8	Kaupunkiammunta-challenge	Koiraseura
10	2024-04-17	339.05695358799295	8	Laukausmaraton	Koiraseura
10	2024-04-17	277.81466565454883	8	Vapaa-asekilpailu	Koiraseura
10	2024-04-17	349.5949653448016	8	Taitoluodikko-turnaus	Koiraseura
10	2024-04-17	326.8395618975207	8	Precision_Pistol_Cup	Koiraseura
10	2024-04-17	367.7772316434848	8	Tulevaisuuden_Ampuja	Koiraseura
10	2024-04-17	318.48393898409506	8	Pikakivaari-klassikko	Koiraseura
10	2024-04-17	308.28198800426765	9	Tarkka-ammunta_Cup	Koiraseura
10	2024-04-17	327.31028919424995	9	Nopean_laukauksen_mestaruus	Koiraseura
10	2024-04-17	307.5915317275629	9	Moniottelu	Koiraseura
10	2024-04-17	336.2529757709198	9	Kansallinen_tahtayskilpailu	Koiraseura
10	2024-04-17	340.91775357716557	9	Kaupunkiammunta-challenge	Koiraseura
10	2024-04-17	369.6577121882074	9	Laukausmaraton	Koiraseura
10	2024-04-17	314.556157791757	9	Vapaa-asekilpailu	Koiraseura
10	2024-04-17	345.6504307279337	9	Taitoluodikko-turnaus	Koiraseura
10	2024-04-17	295.3730650422106	9	Precision_Pistol_Cup	Koiraseura
10	2024-04-17	332.2599930262883	9	Tulevaisuuden_Ampuja	Koiraseura
10	2024-04-17	322.7339682102719	9	Pikakivaari-klassikko	Koiraseura
10	2024-04-17	313.92334802829356	10	Tarkka-ammunta_Cup	Hammaspeikkoseura
10	2024-04-17	314.25113811724566	10	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
10	2024-04-17	320.1804502324923	10	Moniottelu	Hammaspeikkoseura
10	2024-04-17	319.84572077737124	10	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
10	2024-04-17	365.1531589766012	10	Kaupunkiammunta-challenge	Hammaspeikkoseura
10	2024-04-17	264.05160416858234	10	Laukausmaraton	Hammaspeikkoseura
10	2024-04-17	325.1095952871726	10	Vapaa-asekilpailu	Hammaspeikkoseura
10	2024-04-17	342.3743673921464	10	Taitoluodikko-turnaus	Hammaspeikkoseura
10	2024-04-17	312.9582923714789	10	Precision_Pistol_Cup	Hammaspeikkoseura
10	2024-04-17	331.02375832848156	10	Tulevaisuuden_Ampuja	Hammaspeikkoseura
10	2024-04-17	338.4265326877292	10	Pikakivaari-klassikko	Hammaspeikkoseura
10	2024-04-17	357.1760936610209	11	Tarkka-ammunta_Cup	Hammaspeikkoseura
10	2024-04-17	285.39175774223827	11	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
10	2024-04-17	307.8092194622255	11	Moniottelu	Hammaspeikkoseura
10	2024-04-17	358.93290755168175	11	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
10	2024-04-17	309.4790178584068	11	Kaupunkiammunta-challenge	Hammaspeikkoseura
10	2024-04-17	316.7001297844039	11	Laukausmaraton	Hammaspeikkoseura
10	2024-04-17	347.6133145465406	11	Vapaa-asekilpailu	Hammaspeikkoseura
10	2024-04-17	319.4877263043283	11	Taitoluodikko-turnaus	Hammaspeikkoseura
10	2024-04-17	296.00680229625254	11	Precision_Pistol_Cup	Hammaspeikkoseura
10	2024-04-17	296.12393857610516	11	Tulevaisuuden_Ampuja	Hammaspeikkoseura
10	2024-04-17	306.2857551197267	11	Pikakivaari-klassikko	Hammaspeikkoseura
10	2024-04-17	327.7619818546748	12	Tarkka-ammunta_Cup	Hammaspeikkoseura
10	2024-04-17	306.4546990282173	12	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
10	2024-04-17	297.9726598822134	12	Moniottelu	Hammaspeikkoseura
10	2024-04-17	367.330487780863	12	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
10	2024-04-17	363.4616341570999	12	Kaupunkiammunta-challenge	Hammaspeikkoseura
10	2024-04-17	320.7190426513173	12	Laukausmaraton	Hammaspeikkoseura
10	2024-04-17	317.9798376001622	12	Vapaa-asekilpailu	Hammaspeikkoseura
10	2024-04-17	307.5922997389656	12	Taitoluodikko-turnaus	Hammaspeikkoseura
10	2024-04-17	330.28781366108507	12	Precision_Pistol_Cup	Hammaspeikkoseura
10	2024-04-17	325.5489214912161	12	Tulevaisuuden_Ampuja	Hammaspeikkoseura
10	2024-04-17	336.04328110755824	12	Pikakivaari-klassikko	Hammaspeikkoseura
10	2024-04-17	356.583043328966	13	Tarkka-ammunta_Cup	Hammaspeikkoseura
10	2024-04-17	366.49722994857956	13	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
10	2024-04-17	363.70238089432934	13	Moniottelu	Hammaspeikkoseura
10	2024-04-17	339.9294317965279	13	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
10	2024-04-17	297.85014120240135	13	Kaupunkiammunta-challenge	Hammaspeikkoseura
10	2024-04-17	334.8590617820913	13	Laukausmaraton	Hammaspeikkoseura
10	2024-04-17	309.5656338776729	13	Vapaa-asekilpailu	Hammaspeikkoseura
10	2024-04-17	299.81944221870526	13	Taitoluodikko-turnaus	Hammaspeikkoseura
10	2024-04-17	347.79955543038824	13	Precision_Pistol_Cup	Hammaspeikkoseura
10	2024-04-17	341.12671030650034	13	Tulevaisuuden_Ampuja	Hammaspeikkoseura
10	2024-04-17	324.1319500765102	13	Pikakivaari-klassikko	Hammaspeikkoseura
10	2024-04-17	335.9231525632662	14	Tarkka-ammunta_Cup	Hammaspeikkoseura
10	2024-04-17	299.165359257124	14	Nopean_laukauksen_mestaruus	Hammaspeikkoseura
10	2024-04-17	335.46395011706426	14	Moniottelu	Hammaspeikkoseura
10	2024-04-17	344.1686768100197	14	Kansallinen_tahtayskilpailu	Hammaspeikkoseura
10	2024-04-17	294.2783231570573	14	Kaupunkiammunta-challenge	Hammaspeikkoseura
10	2024-04-17	371.2424889134418	14	Laukausmaraton	Hammaspeikkoseura
10	2024-04-17	409.0452915094738	14	Vapaa-asekilpailu	Hammaspeikkoseura
10	2024-04-17	316.49538792482053	14	Taitoluodikko-turnaus	Hammaspeikkoseura
10	2024-04-17	337.5326181458418	14	Precision_Pistol_Cup	Hammaspeikkoseura
10	2024-04-17	365.72605065512386	14	Tulevaisuuden_Ampuja	Hammaspeikkoseura
10	2024-04-17	350.25322248572235	14	Pikakivaari-klassikko	Hammaspeikkoseura
10	2024-04-17	392.6905532233648	15	Tarkka-ammunta_Cup	dog
10	2024-04-17	330.8464411782549	15	Nopean_laukauksen_mestaruus	dog
10	2024-04-17	333.4135005228962	15	Moniottelu	dog
10	2024-04-17	326.0588342982079	15	Kansallinen_tahtayskilpailu	dog
10	2024-04-17	320.3911865881305	15	Kaupunkiammunta-challenge	dog
10	2024-04-17	303.16886227033103	15	Laukausmaraton	dog
10	2024-04-17	330.47398570655156	15	Vapaa-asekilpailu	dog
10	2024-04-17	393.66188531338673	15	Taitoluodikko-turnaus	dog
10	2024-04-17	316.0352378641719	15	Precision_Pistol_Cup	dog
10	2024-04-17	296.4438469477914	15	Tulevaisuuden_Ampuja	dog
10	2024-04-17	371.4084213715414	15	Pikakivaari-klassikko	dog
10	2024-04-17	291.98952853165974	16	Tarkka-ammunta_Cup	dog
10	2024-04-17	333.3964842916553	16	Nopean_laukauksen_mestaruus	dog
10	2024-04-17	336.56431013476873	16	Moniottelu	dog
10	2024-04-17	351.2519471894711	16	Kansallinen_tahtayskilpailu	dog
10	2024-04-17	333.8692066789486	16	Kaupunkiammunta-challenge	dog
10	2024-04-17	366.72958487054524	16	Laukausmaraton	dog
10	2024-04-17	345.37336905336787	16	Vapaa-asekilpailu	dog
10	2024-04-17	340.3378843874163	16	Taitoluodikko-turnaus	dog
10	2024-04-17	311.12069393540037	16	Precision_Pistol_Cup	dog
10	2024-04-17	352.01065676858514	16	Tulevaisuuden_Ampuja	dog
10	2024-04-17	344.91424417375003	16	Pikakivaari-klassikko	dog
10	2024-04-17	333.7788968085131	17	Tarkka-ammunta_Cup	dog
10	2024-04-17	299.44321961712757	17	Nopean_laukauksen_mestaruus	dog
10	2024-04-17	313.37081897338845	17	Moniottelu	dog
10	2024-04-17	366.73967285271925	17	Kansallinen_tahtayskilpailu	dog
10	2024-04-17	340.760386771699	17	Kaupunkiammunta-challenge	dog
10	2024-04-17	318.8435841856961	17	Laukausmaraton	dog
10	2024-04-17	312.5716439849019	17	Vapaa-asekilpailu	dog
10	2024-04-17	299.9869907664926	17	Taitoluodikko-turnaus	dog
10	2024-04-17	336.9530710772219	17	Precision_Pistol_Cup	dog
10	2024-04-17	286.61915423689135	17	Tulevaisuuden_Ampuja	dog
10	2024-04-17	329.6736723411452	17	Pikakivaari-klassikko	dog
10	2024-04-17	306.8864992975051	18	Tarkka-ammunta_Cup	dog
10	2024-04-17	349.4696153685212	18	Nopean_laukauksen_mestaruus	dog
10	2024-04-17	309.1535832158106	18	Moniottelu	dog
10	2024-04-17	304.2480966167165	18	Kansallinen_tahtayskilpailu	dog
10	2024-04-17	322.4387500239618	18	Kaupunkiammunta-challenge	dog
10	2024-04-17	298.42879626626365	18	Laukausmaraton	dog
10	2024-04-17	310.7012615718887	18	Vapaa-asekilpailu	dog
10	2024-04-17	345.71629224704577	18	Taitoluodikko-turnaus	dog
10	2024-04-17	316.3392194285615	18	Precision_Pistol_Cup	dog
10	2024-04-17	309.0784846058156	18	Tulevaisuuden_Ampuja	dog
10	2024-04-17	359.63515861743974	18	Pikakivaari-klassikko	dog
10	2024-04-17	297.8140454499151	19	Tarkka-ammunta_Cup	Savu_Seura
10	2024-04-17	303.49295508275145	19	Nopean_laukauksen_mestaruus	Savu_Seura
10	2024-04-17	325.7963591165167	19	Moniottelu	Savu_Seura
10	2024-04-17	337.0911997524053	19	Kansallinen_tahtayskilpailu	Savu_Seura
10	2024-04-17	312.74057891546187	19	Kaupunkiammunta-challenge	Savu_Seura
10	2024-04-17	269.8275098567018	19	Laukausmaraton	Savu_Seura
10	2024-04-17	358.4008302838614	19	Vapaa-asekilpailu	Savu_Seura
10	2024-04-17	332.46636884558063	19	Taitoluodikko-turnaus	Savu_Seura
10	2024-04-17	345.2047694771194	19	Precision_Pistol_Cup	Savu_Seura
10	2024-04-17	320.01371384059104	19	Tulevaisuuden_Ampuja	Savu_Seura
10	2024-04-17	312.00562328484915	19	Pikakivaari-klassikko	Savu_Seura
10	2024-04-17	377.96297060136845	20	Tarkka-ammunta_Cup	Savu_Seura
10	2024-04-17	348.9728904333953	20	Nopean_laukauksen_mestaruus	Savu_Seura
10	2024-04-17	355.2435017328602	20	Moniottelu	Savu_Seura
10	2024-04-17	351.24542578167984	20	Kansallinen_tahtayskilpailu	Savu_Seura
10	2024-04-17	334.9062365532793	20	Kaupunkiammunta-challenge	Savu_Seura
10	2024-04-17	356.41232875718373	20	Laukausmaraton	Savu_Seura
10	2024-04-17	348.5849081357374	20	Vapaa-asekilpailu	Savu_Seura
10	2024-04-17	324.58083476911884	20	Taitoluodikko-turnaus	Savu_Seura
10	2024-04-17	332.4811707591585	20	Precision_Pistol_Cup	Savu_Seura
10	2024-04-17	305.8128657628695	20	Tulevaisuuden_Ampuja	Savu_Seura
10	2024-04-17	298.5155094572758	20	Pikakivaari-klassikko	Savu_Seura
10	2024-04-17	332.6230715089814	21	Tarkka-ammunta_Cup	Savu_Seura
10	2024-04-17	331.00466622465706	21	Nopean_laukauksen_mestaruus	Savu_Seura
10	2024-04-17	334.2254161826112	21	Moniottelu	Savu_Seura
10	2024-04-17	345.47050889703974	21	Kansallinen_tahtayskilpailu	Savu_Seura
10	2024-04-17	343.2768231495596	21	Kaupunkiammunta-challenge	Savu_Seura
10	2024-04-17	335.127686921272	21	Laukausmaraton	Savu_Seura
10	2024-04-17	369.56082344263825	21	Vapaa-asekilpailu	Savu_Seura
10	2024-04-17	367.70058717550535	21	Taitoluodikko-turnaus	Savu_Seura
10	2024-04-17	310.6093365127272	21	Precision_Pistol_Cup	Savu_Seura
10	2024-04-17	340.12338869609454	21	Tulevaisuuden_Ampuja	Savu_Seura
10	2024-04-17	359.1582779176514	21	Pikakivaari-klassikko	Savu_Seura
10	2024-04-17	371.7228820430563	22	Tarkka-ammunta_Cup	Savu_Seura
10	2024-04-17	323.53118276651054	22	Nopean_laukauksen_mestaruus	Savu_Seura
10	2024-04-17	349.9099427157366	22	Moniottelu	Savu_Seura
10	2024-04-17	328.9020694734823	22	Kansallinen_tahtayskilpailu	Savu_Seura
10	2024-04-17	284.98169216616293	22	Kaupunkiammunta-challenge	Savu_Seura
10	2024-04-17	305.2319917115182	22	Laukausmaraton	Savu_Seura
10	2024-04-17	330.6011235760175	22	Vapaa-asekilpailu	Savu_Seura
10	2024-04-17	316.6576722035828	22	Taitoluodikko-turnaus	Savu_Seura
10	2024-04-17	361.99452534496265	22	Precision_Pistol_Cup	Savu_Seura
10	2024-04-17	285.98137945118253	22	Tulevaisuuden_Ampuja	Savu_Seura
10	2024-04-17	342.98549638193606	22	Pikakivaari-klassikko	Savu_Seura
10	2024-04-17	331.74956647979434	23	Tarkka-ammunta_Cup	Savu_Seura
10	2024-04-17	342.85278186726805	23	Nopean_laukauksen_mestaruus	Savu_Seura
10	2024-04-17	329.1079757579976	23	Moniottelu	Savu_Seura
10	2024-04-17	310.76143643368636	23	Kansallinen_tahtayskilpailu	Savu_Seura
10	2024-04-17	337.16872111723575	23	Kaupunkiammunta-challenge	Savu_Seura
10	2024-04-17	348.40030146266895	23	Laukausmaraton	Savu_Seura
10	2024-04-17	308.6983226481257	23	Vapaa-asekilpailu	Savu_Seura
10	2024-04-17	318.94476136423714	23	Taitoluodikko-turnaus	Savu_Seura
10	2024-04-17	306.86624369599883	23	Precision_Pistol_Cup	Savu_Seura
10	2024-04-17	380.3711800054749	23	Tulevaisuuden_Ampuja	Savu_Seura
10	2024-04-17	329.26778479001456	23	Pikakivaari-klassikko	Savu_Seura
10	2024-04-17	339.3702663291668	24	Tarkka-ammunta_Cup	OMAS
10	2024-04-17	346.3995898446871	24	Nopean_laukauksen_mestaruus	OMAS
10	2024-04-17	316.4840777408003	24	Moniottelu	OMAS
10	2024-04-17	298.3824342701552	24	Kansallinen_tahtayskilpailu	OMAS
10	2024-04-17	363.15063956103046	24	Kaupunkiammunta-challenge	OMAS
10	2024-04-17	382.7906687068924	24	Laukausmaraton	OMAS
10	2024-04-17	303.7041432126286	24	Vapaa-asekilpailu	OMAS
10	2024-04-17	376.77579623577606	24	Taitoluodikko-turnaus	OMAS
10	2024-04-17	342.6820436520986	24	Precision_Pistol_Cup	OMAS
10	2024-04-17	290.07037848169466	24	Tulevaisuuden_Ampuja	OMAS
10	2024-04-17	336.1648548623262	24	Pikakivaari-klassikko	OMAS
10	2024-04-17	322.29054534456344	25	Tarkka-ammunta_Cup	OMAS
10	2024-04-17	381.8939963131057	25	Nopean_laukauksen_mestaruus	OMAS
10	2024-04-17	292.73326217028034	25	Moniottelu	OMAS
10	2024-04-17	353.5889854710115	25	Kansallinen_tahtayskilpailu	OMAS
10	2024-04-17	319.6808576673673	25	Kaupunkiammunta-challenge	OMAS
10	2024-04-17	358.7889327424389	25	Laukausmaraton	OMAS
10	2024-04-17	369.19988105866815	25	Vapaa-asekilpailu	OMAS
10	2024-04-17	316.87392139712165	25	Taitoluodikko-turnaus	OMAS
10	2024-04-17	323.5183752792121	25	Precision_Pistol_Cup	OMAS
10	2024-04-17	333.5731995859644	25	Tulevaisuuden_Ampuja	OMAS
10	2024-04-17	379.1154836640125	25	Pikakivaari-klassikko	OMAS
10	2024-04-17	325.0521415561171	26	Tarkka-ammunta_Cup	OMAS
10	2024-04-17	316.63860270026834	26	Nopean_laukauksen_mestaruus	OMAS
10	2024-04-17	337.54374662771914	26	Moniottelu	OMAS
10	2024-04-17	356.1905559516224	26	Kansallinen_tahtayskilpailu	OMAS
10	2024-04-17	299.7406216417492	26	Kaupunkiammunta-challenge	OMAS
10	2024-04-17	301.31920502193225	26	Laukausmaraton	OMAS
10	2024-04-17	319.25922050214706	26	Vapaa-asekilpailu	OMAS
10	2024-04-17	291.9694165851349	26	Taitoluodikko-turnaus	OMAS
10	2024-04-17	355.6553652442696	26	Precision_Pistol_Cup	OMAS
10	2024-04-17	345.02892365204116	26	Tulevaisuuden_Ampuja	OMAS
10	2024-04-17	295.56433237730465	26	Pikakivaari-klassikko	OMAS
10	2024-04-17	334.14474257800003	27	Tarkka-ammunta_Cup	OMAS
10	2024-04-17	333.09767149184034	27	Nopean_laukauksen_mestaruus	OMAS
10	2024-04-17	303.3678948353449	27	Moniottelu	OMAS
10	2024-04-17	375.82574319863676	27	Kansallinen_tahtayskilpailu	OMAS
10	2024-04-17	307.50951758120533	27	Kaupunkiammunta-challenge	OMAS
10	2024-04-17	315.9040044869916	27	Laukausmaraton	OMAS
10	2024-04-17	266.77289076224196	27	Vapaa-asekilpailu	OMAS
10	2024-04-17	317.0211169408056	27	Taitoluodikko-turnaus	OMAS
10	2024-04-17	355.75988827987453	27	Precision_Pistol_Cup	OMAS
10	2024-04-17	318.3449519420841	27	Tulevaisuuden_Ampuja	OMAS
10	2024-04-17	355.4663168877421	27	Pikakivaari-klassikko	OMAS
10	2024-04-17	297.05902438549623	28	Tarkka-ammunta_Cup	Pelleseura
10	2024-04-17	327.54293272583345	28	Nopean_laukauksen_mestaruus	Pelleseura
10	2024-04-17	343.33440843939917	28	Moniottelu	Pelleseura
10	2024-04-17	295.88391022687074	28	Kansallinen_tahtayskilpailu	Pelleseura
10	2024-04-17	330.7818114768453	28	Kaupunkiammunta-challenge	Pelleseura
10	2024-04-17	341.1134714398022	28	Laukausmaraton	Pelleseura
10	2024-04-17	331.51989366392235	28	Vapaa-asekilpailu	Pelleseura
10	2024-04-17	267.2681243983813	28	Taitoluodikko-turnaus	Pelleseura
10	2024-04-17	331.9966540312851	28	Precision_Pistol_Cup	Pelleseura
10	2024-04-17	329.22372428340105	28	Tulevaisuuden_Ampuja	Pelleseura
10	2024-04-17	358.86747379202797	28	Pikakivaari-klassikko	Pelleseura
10	2024-04-17	284.4293175904788	29	Tarkka-ammunta_Cup	Pelleseura
10	2024-04-17	306.87486363276116	29	Nopean_laukauksen_mestaruus	Pelleseura
10	2024-04-17	334.2841304116305	29	Moniottelu	Pelleseura
10	2024-04-17	345.86804436299064	29	Kansallinen_tahtayskilpailu	Pelleseura
10	2024-04-17	352.0472502907645	29	Kaupunkiammunta-challenge	Pelleseura
10	2024-04-17	333.65497363960134	29	Laukausmaraton	Pelleseura
10	2024-04-17	346.78692340733596	29	Vapaa-asekilpailu	Pelleseura
10	2024-04-17	324.6589068105389	29	Taitoluodikko-turnaus	Pelleseura
10	2024-04-17	289.0599016776135	29	Precision_Pistol_Cup	Pelleseura
10	2024-04-17	307.4945395742859	29	Tulevaisuuden_Ampuja	Pelleseura
10	2024-04-17	298.7790175952097	29	Pikakivaari-klassikko	Pelleseura
10	2024-04-17	312.8355801942421	30	Tarkka-ammunta_Cup	Pelleseura
10	2024-04-17	345.8337679335199	30	Nopean_laukauksen_mestaruus	Pelleseura
10	2024-04-17	300.87661619743153	30	Moniottelu	Pelleseura
10	2024-04-17	299.9790908008222	30	Kansallinen_tahtayskilpailu	Pelleseura
10	2024-04-17	339.56473734570545	30	Kaupunkiammunta-challenge	Pelleseura
10	2024-04-17	334.9470740168819	30	Laukausmaraton	Pelleseura
10	2024-04-17	335.15700508555375	30	Vapaa-asekilpailu	Pelleseura
10	2024-04-17	305.1780523189507	30	Taitoluodikko-turnaus	Pelleseura
10	2024-04-17	340.7990270859869	30	Precision_Pistol_Cup	Pelleseura
10	2024-04-17	346.7402948404337	30	Tulevaisuuden_Ampuja	Pelleseura
10	2024-04-17	345.33886121109384	30	Pikakivaari-klassikko	Pelleseura
10	2024-04-17	338.6118258325587	31	Tarkka-ammunta_Cup	Pelleseura
10	2024-04-17	350.92631402788135	31	Nopean_laukauksen_mestaruus	Pelleseura
10	2024-04-17	328.12339682959384	31	Moniottelu	Pelleseura
10	2024-04-17	286.08614911712516	31	Kansallinen_tahtayskilpailu	Pelleseura
10	2024-04-17	312.45826231577826	31	Kaupunkiammunta-challenge	Pelleseura
10	2024-04-17	291.44767321697987	31	Laukausmaraton	Pelleseura
10	2024-04-17	322.46111534278674	31	Vapaa-asekilpailu	Pelleseura
10	2024-04-17	334.18715834859256	31	Taitoluodikko-turnaus	Pelleseura
10	2024-04-17	267.98881460142144	31	Precision_Pistol_Cup	Pelleseura
10	2024-04-17	338.7520626839666	31	Tulevaisuuden_Ampuja	Pelleseura
10	2024-04-17	291.3665288491905	31	Pikakivaari-klassikko	Pelleseura
10	2024-04-17	311.88338888730146	32	Tarkka-ammunta_Cup	Yung_Tallent
10	2024-04-17	300.54678864607934	32	Nopean_laukauksen_mestaruus	Yung_Tallent
10	2024-04-17	285.6355451819561	32	Moniottelu	Yung_Tallent
10	2024-04-17	311.8180354551242	32	Kansallinen_tahtayskilpailu	Yung_Tallent
10	2024-04-17	330.10256317580115	32	Kaupunkiammunta-challenge	Yung_Tallent
10	2024-04-17	353.17340557494043	32	Laukausmaraton	Yung_Tallent
10	2024-04-17	367.8640623631853	32	Vapaa-asekilpailu	Yung_Tallent
10	2024-04-17	354.7954063779625	32	Taitoluodikko-turnaus	Yung_Tallent
10	2024-04-17	365.93490727672406	32	Precision_Pistol_Cup	Yung_Tallent
10	2024-04-17	312.6029719001642	32	Tulevaisuuden_Ampuja	Yung_Tallent
10	2024-04-17	301.650684859805	32	Pikakivaari-klassikko	Yung_Tallent
10	2024-04-17	354.47642194628673	33	Tarkka-ammunta_Cup	Yung_Tallent
10	2024-04-17	313.21432609589414	33	Nopean_laukauksen_mestaruus	Yung_Tallent
10	2024-04-17	329.8324387322617	33	Moniottelu	Yung_Tallent
10	2024-04-17	318.5948183677568	33	Kansallinen_tahtayskilpailu	Yung_Tallent
10	2024-04-17	360.7842121248878	33	Kaupunkiammunta-challenge	Yung_Tallent
10	2024-04-17	301.1874313747633	33	Laukausmaraton	Yung_Tallent
10	2024-04-17	307.7835215398133	33	Vapaa-asekilpailu	Yung_Tallent
10	2024-04-17	328.0624757104564	33	Taitoluodikko-turnaus	Yung_Tallent
10	2024-04-17	347.24831920376477	33	Precision_Pistol_Cup	Yung_Tallent
10	2024-04-17	337.7334236583843	33	Tulevaisuuden_Ampuja	Yung_Tallent
10	2024-04-17	305.0300225388174	33	Pikakivaari-klassikko	Yung_Tallent
10	2024-04-17	311.14383272588105	34	Tarkka-ammunta_Cup	Yung_Tallent
10	2024-04-17	306.5611611757173	34	Nopean_laukauksen_mestaruus	Yung_Tallent
10	2024-04-17	337.06476231262207	34	Moniottelu	Yung_Tallent
10	2024-04-17	312.9926426894559	34	Kansallinen_tahtayskilpailu	Yung_Tallent
10	2024-04-17	331.8807644671139	34	Kaupunkiammunta-challenge	Yung_Tallent
10	2024-04-17	302.15509121876175	34	Laukausmaraton	Yung_Tallent
10	2024-04-17	352.9799793384601	34	Vapaa-asekilpailu	Yung_Tallent
10	2024-04-17	304.3827578085878	34	Taitoluodikko-turnaus	Yung_Tallent
10	2024-04-17	353.38528520500694	34	Precision_Pistol_Cup	Yung_Tallent
10	2024-04-17	310.56797555123245	34	Tulevaisuuden_Ampuja	Yung_Tallent
10	2024-04-17	348.1520996610557	34	Pikakivaari-klassikko	Yung_Tallent
10	2024-04-17	297.1627785626971	35	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	303.2747956796912	35	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	312.9325508442822	35	Moniottelu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	370.1845376951317	35	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	304.257368198878	35	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
10	2024-04-17	341.8676964906167	35	Laukausmaraton	Aseharrastajien_Yhtenaisyys
10	2024-04-17	292.80493627401165	35	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	319.02722004243714	35	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	318.38171873602545	35	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	325.6748047419383	35	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
10	2024-04-17	352.2606036493502	35	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
10	2024-04-17	315.5305113677222	36	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	321.6619902463556	36	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	354.24133577423623	36	Moniottelu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	297.70962562096867	36	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	324.7754160491461	36	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
10	2024-04-17	297.81908250786597	36	Laukausmaraton	Aseharrastajien_Yhtenaisyys
10	2024-04-17	286.43630950334455	36	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	347.73378863990104	36	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	322.4643810569604	36	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	380.29794830891234	36	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
10	2024-04-17	371.1043110338401	36	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
10	2024-04-17	376.56358981618115	37	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	295.69486738330073	37	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	319.5892874971393	37	Moniottelu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	349.2482761267571	37	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	322.61514046844326	37	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
10	2024-04-17	348.722664802329	37	Laukausmaraton	Aseharrastajien_Yhtenaisyys
10	2024-04-17	358.583854148153	37	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	344.199537842302	37	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	290.16305207058036	37	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	323.8042048099304	37	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
10	2024-04-17	342.277314559846	37	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
10	2024-04-17	342.6861069836928	38	Tarkka-ammunta_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	315.31307209101914	38	Nopean_laukauksen_mestaruus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	305.68033835092746	38	Moniottelu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	314.24814866145107	38	Kansallinen_tahtayskilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	273.7398044496034	38	Kaupunkiammunta-challenge	Aseharrastajien_Yhtenaisyys
10	2024-04-17	331.33455525386097	38	Laukausmaraton	Aseharrastajien_Yhtenaisyys
10	2024-04-17	296.1849106757256	38	Vapaa-asekilpailu	Aseharrastajien_Yhtenaisyys
10	2024-04-17	347.6591092940707	38	Taitoluodikko-turnaus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	315.3489588310775	38	Precision_Pistol_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	354.53190088418734	38	Tulevaisuuden_Ampuja	Aseharrastajien_Yhtenaisyys
10	2024-04-17	340.5605056842248	38	Pikakivaari-klassikko	Aseharrastajien_Yhtenaisyys
10	2024-04-17	329.2714009837343	39	Tarkka-ammunta_Cup	Tahtaysmestarit
10	2024-04-17	335.75118591683776	39	Nopean_laukauksen_mestaruus	Tahtaysmestarit
10	2024-04-17	307.9173222945532	39	Moniottelu	Tahtaysmestarit
10	2024-04-17	297.80424615749223	39	Kansallinen_tahtayskilpailu	Tahtaysmestarit
10	2024-04-17	318.2304037376407	39	Kaupunkiammunta-challenge	Tahtaysmestarit
10	2024-04-17	343.6036580996403	39	Laukausmaraton	Tahtaysmestarit
10	2024-04-17	333.9053378875132	39	Vapaa-asekilpailu	Tahtaysmestarit
10	2024-04-17	332.2932821655495	39	Taitoluodikko-turnaus	Tahtaysmestarit
10	2024-04-17	346.27677709021464	39	Precision_Pistol_Cup	Tahtaysmestarit
10	2024-04-17	329.6519970310157	39	Tulevaisuuden_Ampuja	Tahtaysmestarit
10	2024-04-17	345.71872017397214	39	Pikakivaari-klassikko	Tahtaysmestarit
10	2024-04-17	298.80581802362263	40	Tarkka-ammunta_Cup	Tahtaysmestarit
10	2024-04-17	307.43890894439846	40	Nopean_laukauksen_mestaruus	Tahtaysmestarit
10	2024-04-17	282.26042457459414	40	Moniottelu	Tahtaysmestarit
10	2024-04-17	369.64516920051625	40	Kansallinen_tahtayskilpailu	Tahtaysmestarit
10	2024-04-17	368.8892981868391	40	Kaupunkiammunta-challenge	Tahtaysmestarit
10	2024-04-17	353.68526668744425	40	Laukausmaraton	Tahtaysmestarit
10	2024-04-17	329.0662843929348	40	Vapaa-asekilpailu	Tahtaysmestarit
10	2024-04-17	323.48497235808645	40	Taitoluodikko-turnaus	Tahtaysmestarit
10	2024-04-17	341.57869703101073	40	Precision_Pistol_Cup	Tahtaysmestarit
10	2024-04-17	382.0488973746249	40	Tulevaisuuden_Ampuja	Tahtaysmestarit
10	2024-04-17	311.28993539441484	40	Pikakivaari-klassikko	Tahtaysmestarit
10	2024-04-17	331.49649573841805	41	Tarkka-ammunta_Cup	Tahtaysmestarit
10	2024-04-17	313.3420715733887	41	Nopean_laukauksen_mestaruus	Tahtaysmestarit
10	2024-04-17	341.23658185896755	41	Moniottelu	Tahtaysmestarit
10	2024-04-17	326.6651464619692	41	Kansallinen_tahtayskilpailu	Tahtaysmestarit
10	2024-04-17	328.1711755271905	41	Kaupunkiammunta-challenge	Tahtaysmestarit
10	2024-04-17	304.5200160578674	41	Laukausmaraton	Tahtaysmestarit
10	2024-04-17	343.03740880633785	41	Vapaa-asekilpailu	Tahtaysmestarit
10	2024-04-17	279.0700661657193	41	Taitoluodikko-turnaus	Tahtaysmestarit
10	2024-04-17	313.90065951095613	41	Precision_Pistol_Cup	Tahtaysmestarit
10	2024-04-17	340.545235901107	41	Tulevaisuuden_Ampuja	Tahtaysmestarit
10	2024-04-17	283.989197970626	41	Pikakivaari-klassikko	Tahtaysmestarit
10	2024-04-17	322.97733790788425	42	Tarkka-ammunta_Cup	Tahtaysmestarit
10	2024-04-17	308.4031932130868	42	Nopean_laukauksen_mestaruus	Tahtaysmestarit
10	2024-04-17	337.59228449020515	42	Moniottelu	Tahtaysmestarit
10	2024-04-17	330.7493270550224	42	Kansallinen_tahtayskilpailu	Tahtaysmestarit
10	2024-04-17	293.4813977218267	42	Kaupunkiammunta-challenge	Tahtaysmestarit
10	2024-04-17	314.7739701847257	42	Laukausmaraton	Tahtaysmestarit
10	2024-04-17	315.6302682585321	42	Vapaa-asekilpailu	Tahtaysmestarit
10	2024-04-17	312.233582227657	42	Taitoluodikko-turnaus	Tahtaysmestarit
10	2024-04-17	325.86563494447773	42	Precision_Pistol_Cup	Tahtaysmestarit
10	2024-04-17	326.882217817936	42	Tulevaisuuden_Ampuja	Tahtaysmestarit
10	2024-04-17	331.81770999958394	42	Pikakivaari-klassikko	Tahtaysmestarit
10	2024-04-17	304.8982471889354	43	Tarkka-ammunta_Cup	Laukausryhma_Aurora
10	2024-04-17	313.5496042253207	43	Nopean_laukauksen_mestaruus	Laukausryhma_Aurora
10	2024-04-17	345.0528016360655	43	Moniottelu	Laukausryhma_Aurora
10	2024-04-17	308.91637815352743	43	Kansallinen_tahtayskilpailu	Laukausryhma_Aurora
10	2024-04-17	324.9448972742234	43	Kaupunkiammunta-challenge	Laukausryhma_Aurora
10	2024-04-17	316.92615394883677	43	Laukausmaraton	Laukausryhma_Aurora
10	2024-04-17	337.4440947200092	43	Vapaa-asekilpailu	Laukausryhma_Aurora
10	2024-04-17	358.6872631296438	43	Taitoluodikko-turnaus	Laukausryhma_Aurora
10	2024-04-17	308.8511419870748	43	Precision_Pistol_Cup	Laukausryhma_Aurora
10	2024-04-17	335.7245261365474	43	Tulevaisuuden_Ampuja	Laukausryhma_Aurora
10	2024-04-17	322.1888460157997	43	Pikakivaari-klassikko	Laukausryhma_Aurora
10	2024-04-17	326.21565537275114	44	Tarkka-ammunta_Cup	Laukausryhma_Aurora
10	2024-04-17	338.0373587692301	44	Nopean_laukauksen_mestaruus	Laukausryhma_Aurora
10	2024-04-17	288.04982915539847	44	Moniottelu	Laukausryhma_Aurora
10	2024-04-17	317.3790417900404	44	Kansallinen_tahtayskilpailu	Laukausryhma_Aurora
10	2024-04-17	343.8456742939307	44	Kaupunkiammunta-challenge	Laukausryhma_Aurora
10	2024-04-17	351.79100372757784	44	Laukausmaraton	Laukausryhma_Aurora
10	2024-04-17	298.7434108802746	44	Vapaa-asekilpailu	Laukausryhma_Aurora
10	2024-04-17	326.8265477069967	44	Taitoluodikko-turnaus	Laukausryhma_Aurora
10	2024-04-17	302.4265617594889	44	Precision_Pistol_Cup	Laukausryhma_Aurora
10	2024-04-17	369.3914577292111	44	Tulevaisuuden_Ampuja	Laukausryhma_Aurora
10	2024-04-17	312.13635138980305	44	Pikakivaari-klassikko	Laukausryhma_Aurora
10	2024-04-17	359.60892935000254	45	Tarkka-ammunta_Cup	Laukausryhma_Aurora
10	2024-04-17	384.7695318432116	45	Nopean_laukauksen_mestaruus	Laukausryhma_Aurora
10	2024-04-17	286.13732925194734	45	Moniottelu	Laukausryhma_Aurora
10	2024-04-17	351.7985061817401	45	Kansallinen_tahtayskilpailu	Laukausryhma_Aurora
10	2024-04-17	319.6527394954428	45	Kaupunkiammunta-challenge	Laukausryhma_Aurora
10	2024-04-17	296.7929678165682	45	Laukausmaraton	Laukausryhma_Aurora
10	2024-04-17	318.70091403856276	45	Vapaa-asekilpailu	Laukausryhma_Aurora
10	2024-04-17	330.4131989683933	45	Taitoluodikko-turnaus	Laukausryhma_Aurora
10	2024-04-17	339.288895536326	45	Precision_Pistol_Cup	Laukausryhma_Aurora
10	2024-04-17	308.75603808997596	45	Tulevaisuuden_Ampuja	Laukausryhma_Aurora
10	2024-04-17	393.02668484509206	45	Pikakivaari-klassikko	Laukausryhma_Aurora
10	2024-04-17	306.92059655333964	46	Tarkka-ammunta_Cup	Ampumataito
10	2024-04-17	304.44554014470447	46	Nopean_laukauksen_mestaruus	Ampumataito
10	2024-04-17	299.06699359177907	46	Moniottelu	Ampumataito
10	2024-04-17	391.6094963274065	46	Kansallinen_tahtayskilpailu	Ampumataito
10	2024-04-17	305.08817980970093	46	Kaupunkiammunta-challenge	Ampumataito
10	2024-04-17	312.77362943247823	46	Laukausmaraton	Ampumataito
10	2024-04-17	346.725030344958	46	Vapaa-asekilpailu	Ampumataito
10	2024-04-17	293.61451676096027	46	Taitoluodikko-turnaus	Ampumataito
10	2024-04-17	352.7595033030211	46	Precision_Pistol_Cup	Ampumataito
10	2024-04-17	299.62841447848393	46	Tulevaisuuden_Ampuja	Ampumataito
10	2024-04-17	303.5145582684148	46	Pikakivaari-klassikko	Ampumataito
10	2024-04-17	301.82641042772826	47	Tarkka-ammunta_Cup	Ampumataito
10	2024-04-17	331.514796767139	47	Nopean_laukauksen_mestaruus	Ampumataito
10	2024-04-17	314.3398305436129	47	Moniottelu	Ampumataito
10	2024-04-17	313.14987692329106	47	Kansallinen_tahtayskilpailu	Ampumataito
10	2024-04-17	374.65135371630817	47	Kaupunkiammunta-challenge	Ampumataito
10	2024-04-17	323.43640831836797	47	Laukausmaraton	Ampumataito
10	2024-04-17	304.855083989483	47	Vapaa-asekilpailu	Ampumataito
10	2024-04-17	345.8393464506915	47	Taitoluodikko-turnaus	Ampumataito
10	2024-04-17	312.5961639476364	47	Precision_Pistol_Cup	Ampumataito
10	2024-04-17	316.08689480460475	47	Tulevaisuuden_Ampuja	Ampumataito
10	2024-04-17	343.5597039819518	47	Pikakivaari-klassikko	Ampumataito
10	2024-04-17	357.75412179102926	48	Tarkka-ammunta_Cup	Ampumataito
10	2024-04-17	333.093426032145	48	Nopean_laukauksen_mestaruus	Ampumataito
10	2024-04-17	331.03651194185954	48	Moniottelu	Ampumataito
10	2024-04-17	308.97194032762667	48	Kansallinen_tahtayskilpailu	Ampumataito
10	2024-04-17	328.25933207542414	48	Kaupunkiammunta-challenge	Ampumataito
10	2024-04-17	354.96171709459975	48	Laukausmaraton	Ampumataito
10	2024-04-17	299.5851908894807	48	Vapaa-asekilpailu	Ampumataito
10	2024-04-17	315.12144255872295	48	Taitoluodikko-turnaus	Ampumataito
10	2024-04-17	303.92154994888267	48	Precision_Pistol_Cup	Ampumataito
10	2024-04-17	377.0313572510263	48	Tulevaisuuden_Ampuja	Ampumataito
10	2024-04-17	311.7893939216002	48	Pikakivaari-klassikko	Ampumataito
10	2024-04-17	338.34503108673465	2	Kesan_Ampujaiset	Poliisiseura
10	2024-04-17	399.10085886029555	2	Talvi_Pistooli	Poliisiseura
10	2024-04-17	359.96513881452717	2	Tarkkuuslaukaus-festivaali	Poliisiseura
10	2024-04-17	318.69014845372925	2	Kivaarikilpailujen_huipennus	Poliisiseura
10	2024-04-17	344.8758009793513	2	Polaris-ampumaharjoitus	Poliisiseura
10	2024-04-17	307.502928871854	2	Aamunkoiton_tahtays	Poliisiseura
10	2024-04-17	313.99219402134025	2	Nordic_Sharpshooters_Cup	Poliisiseura
10	2024-04-17	337.33330027023106	2	Taivaanranta-tulitus	Poliisiseura
10	2024-04-17	338.40923124049664	2	Lumivyory-ammunta	Poliisiseura
10	2024-04-17	338.7488985202711	3	Kesan_Ampujaiset	Poliisiseura
10	2024-04-17	312.5851680543348	3	Talvi_Pistooli	Poliisiseura
10	2024-04-17	363.53867705990405	3	Tarkkuuslaukaus-festivaali	Poliisiseura
10	2024-04-17	322.7407930752628	3	Kivaarikilpailujen_huipennus	Poliisiseura
10	2024-04-17	322.3197837367341	3	Polaris-ampumaharjoitus	Poliisiseura
10	2024-04-17	306.7117536527624	3	Aamunkoiton_tahtays	Poliisiseura
10	2024-04-17	347.0684484556185	3	Nordic_Sharpshooters_Cup	Poliisiseura
10	2024-04-17	310.19187673055836	3	Taivaanranta-tulitus	Poliisiseura
10	2024-04-17	316.71010298385863	3	Lumivyory-ammunta	Poliisiseura
10	2024-04-17	257.51687420485604	4	Kesan_Ampujaiset	Poliisiseura
10	2024-04-17	327.91115325671024	4	Talvi_Pistooli	Poliisiseura
10	2024-04-17	335.11217080129217	4	Tarkkuuslaukaus-festivaali	Poliisiseura
10	2024-04-17	304.61980907837784	4	Kivaarikilpailujen_huipennus	Poliisiseura
10	2024-04-17	313.5834404023133	4	Polaris-ampumaharjoitus	Poliisiseura
10	2024-04-17	358.83425188593725	4	Aamunkoiton_tahtays	Poliisiseura
10	2024-04-17	342.33901915443175	4	Nordic_Sharpshooters_Cup	Poliisiseura
10	2024-04-17	307.7618477759508	4	Taivaanranta-tulitus	Poliisiseura
10	2024-04-17	405.320312616646	4	Lumivyory-ammunta	Poliisiseura
10	2024-04-17	327.91808366677816	5	Kesan_Ampujaiset	Koiraseura
10	2024-04-17	337.83923406108426	5	Talvi_Pistooli	Koiraseura
10	2024-04-17	321.94227983559404	5	Tarkkuuslaukaus-festivaali	Koiraseura
10	2024-04-17	343.59106659580846	5	Kivaarikilpailujen_huipennus	Koiraseura
10	2024-04-17	336.7374434955192	5	Polaris-ampumaharjoitus	Koiraseura
10	2024-04-17	310.45485596022553	5	Aamunkoiton_tahtays	Koiraseura
10	2024-04-17	326.83976577438074	5	Nordic_Sharpshooters_Cup	Koiraseura
10	2024-04-17	337.54488080586	5	Taivaanranta-tulitus	Koiraseura
10	2024-04-17	314.7060810435216	5	Lumivyory-ammunta	Koiraseura
10	2024-04-17	341.6938579594974	6	Kesan_Ampujaiset	Koiraseura
10	2024-04-17	298.2460392885066	6	Talvi_Pistooli	Koiraseura
10	2024-04-17	359.8908593814436	6	Tarkkuuslaukaus-festivaali	Koiraseura
10	2024-04-17	328.0152600061455	6	Kivaarikilpailujen_huipennus	Koiraseura
10	2024-04-17	360.56481130531364	6	Polaris-ampumaharjoitus	Koiraseura
10	2024-04-17	334.11257396069374	6	Aamunkoiton_tahtays	Koiraseura
10	2024-04-17	320.49918407186516	6	Nordic_Sharpshooters_Cup	Koiraseura
10	2024-04-17	342.1982389709516	6	Taivaanranta-tulitus	Koiraseura
10	2024-04-17	316.2549703586386	6	Lumivyory-ammunta	Koiraseura
10	2024-04-17	333.6263416785648	7	Kesan_Ampujaiset	Koiraseura
10	2024-04-17	297.20896288789294	7	Talvi_Pistooli	Koiraseura
10	2024-04-17	319.40418049601055	7	Tarkkuuslaukaus-festivaali	Koiraseura
10	2024-04-17	312.63205614953836	7	Kivaarikilpailujen_huipennus	Koiraseura
10	2024-04-17	301.1692524206582	7	Polaris-ampumaharjoitus	Koiraseura
10	2024-04-17	289.41163747431824	7	Aamunkoiton_tahtays	Koiraseura
10	2024-04-17	322.1654350060992	7	Nordic_Sharpshooters_Cup	Koiraseura
10	2024-04-17	345.9997693733697	7	Taivaanranta-tulitus	Koiraseura
10	2024-04-17	314.71618283457747	7	Lumivyory-ammunta	Koiraseura
10	2024-04-17	353.70731656116857	8	Kesan_Ampujaiset	Koiraseura
10	2024-04-17	320.6179882627225	8	Talvi_Pistooli	Koiraseura
10	2024-04-17	360.21516621997347	8	Tarkkuuslaukaus-festivaali	Koiraseura
10	2024-04-17	266.83009800875783	8	Kivaarikilpailujen_huipennus	Koiraseura
10	2024-04-17	327.6451248915985	8	Polaris-ampumaharjoitus	Koiraseura
10	2024-04-17	329.26347191409207	8	Aamunkoiton_tahtays	Koiraseura
10	2024-04-17	319.1676798266909	8	Nordic_Sharpshooters_Cup	Koiraseura
10	2024-04-17	270.780526373786	8	Taivaanranta-tulitus	Koiraseura
10	2024-04-17	320.1386387000997	8	Lumivyory-ammunta	Koiraseura
10	2024-04-17	320.3882272947279	9	Kesan_Ampujaiset	Koiraseura
10	2024-04-17	345.5426265796255	9	Talvi_Pistooli	Koiraseura
10	2024-04-17	326.7910050497865	9	Tarkkuuslaukaus-festivaali	Koiraseura
10	2024-04-17	283.11274392155195	9	Kivaarikilpailujen_huipennus	Koiraseura
10	2024-04-17	310.44911805071905	9	Polaris-ampumaharjoitus	Koiraseura
10	2024-04-17	318.84586314714767	9	Aamunkoiton_tahtays	Koiraseura
10	2024-04-17	325.37739191800597	9	Nordic_Sharpshooters_Cup	Koiraseura
10	2024-04-17	315.12724329554965	9	Taivaanranta-tulitus	Koiraseura
10	2024-04-17	316.55653895701664	9	Lumivyory-ammunta	Koiraseura
10	2024-04-17	319.24352605232116	10	Kesan_Ampujaiset	Hammaspeikkoseura
10	2024-04-17	301.6064623170605	10	Talvi_Pistooli	Hammaspeikkoseura
10	2024-04-17	296.7920751157441	10	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
10	2024-04-17	324.4270033164639	10	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
10	2024-04-17	318.7305144875262	10	Polaris-ampumaharjoitus	Hammaspeikkoseura
10	2024-04-17	328.8761727380563	10	Aamunkoiton_tahtays	Hammaspeikkoseura
10	2024-04-17	312.58468324655416	10	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
10	2024-04-17	361.19697305262565	10	Taivaanranta-tulitus	Hammaspeikkoseura
10	2024-04-17	343.82001028926516	10	Lumivyory-ammunta	Hammaspeikkoseura
10	2024-04-17	308.5119245027126	11	Kesan_Ampujaiset	Hammaspeikkoseura
10	2024-04-17	378.2443625452262	11	Talvi_Pistooli	Hammaspeikkoseura
10	2024-04-17	329.13030839488346	11	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
10	2024-04-17	312.6241340495411	11	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
10	2024-04-17	294.96074123571964	11	Polaris-ampumaharjoitus	Hammaspeikkoseura
10	2024-04-17	361.8593463068933	11	Aamunkoiton_tahtays	Hammaspeikkoseura
10	2024-04-17	338.80344220562034	11	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
10	2024-04-17	345.7452225685711	11	Taivaanranta-tulitus	Hammaspeikkoseura
10	2024-04-17	325.6141800524255	11	Lumivyory-ammunta	Hammaspeikkoseura
10	2024-04-17	288.54834599068863	12	Kesan_Ampujaiset	Hammaspeikkoseura
10	2024-04-17	355.39612471346373	12	Talvi_Pistooli	Hammaspeikkoseura
10	2024-04-17	317.4235536295613	12	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
10	2024-04-17	337.00400281236597	12	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
10	2024-04-17	317.3862940766818	12	Polaris-ampumaharjoitus	Hammaspeikkoseura
10	2024-04-17	325.0627225131233	12	Aamunkoiton_tahtays	Hammaspeikkoseura
10	2024-04-17	342.6128048010496	12	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
10	2024-04-17	345.5602768866606	12	Taivaanranta-tulitus	Hammaspeikkoseura
10	2024-04-17	307.9662825524356	12	Lumivyory-ammunta	Hammaspeikkoseura
10	2024-04-17	319.94651361298196	13	Kesan_Ampujaiset	Hammaspeikkoseura
10	2024-04-17	330.4870983161466	13	Talvi_Pistooli	Hammaspeikkoseura
10	2024-04-17	318.31389736875735	13	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
10	2024-04-17	335.4478648995377	13	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
10	2024-04-17	336.5988056283053	13	Polaris-ampumaharjoitus	Hammaspeikkoseura
10	2024-04-17	306.06552301497436	13	Aamunkoiton_tahtays	Hammaspeikkoseura
10	2024-04-17	365.2271173021851	13	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
10	2024-04-17	326.67975147041597	13	Taivaanranta-tulitus	Hammaspeikkoseura
10	2024-04-17	341.1534503966137	13	Lumivyory-ammunta	Hammaspeikkoseura
10	2024-04-17	344.83396863908723	14	Kesan_Ampujaiset	Hammaspeikkoseura
10	2024-04-17	335.15455670551205	14	Talvi_Pistooli	Hammaspeikkoseura
10	2024-04-17	343.7944037253564	14	Tarkkuuslaukaus-festivaali	Hammaspeikkoseura
10	2024-04-17	373.15821922419013	14	Kivaarikilpailujen_huipennus	Hammaspeikkoseura
10	2024-04-17	304.776793858451	14	Polaris-ampumaharjoitus	Hammaspeikkoseura
10	2024-04-17	304.91621962409243	14	Aamunkoiton_tahtays	Hammaspeikkoseura
10	2024-04-17	306.6010050450641	14	Nordic_Sharpshooters_Cup	Hammaspeikkoseura
10	2024-04-17	302.4501773539459	14	Taivaanranta-tulitus	Hammaspeikkoseura
10	2024-04-17	300.893401650181	14	Lumivyory-ammunta	Hammaspeikkoseura
10	2024-04-17	327.11658999243434	15	Kesan_Ampujaiset	dog
10	2024-04-17	334.52427170898903	15	Talvi_Pistooli	dog
10	2024-04-17	317.02510879563386	15	Tarkkuuslaukaus-festivaali	dog
10	2024-04-17	272.51079355561933	15	Kivaarikilpailujen_huipennus	dog
10	2024-04-17	348.36687472051216	15	Polaris-ampumaharjoitus	dog
10	2024-04-17	355.6001586032525	15	Aamunkoiton_tahtays	dog
10	2024-04-17	289.8504018967315	15	Nordic_Sharpshooters_Cup	dog
10	2024-04-17	323.3299821089846	15	Taivaanranta-tulitus	dog
10	2024-04-17	290.2973279712248	15	Lumivyory-ammunta	dog
10	2024-04-17	371.63482726033084	16	Kesan_Ampujaiset	dog
10	2024-04-17	315.85659328490834	16	Talvi_Pistooli	dog
10	2024-04-17	309.74300107473846	16	Tarkkuuslaukaus-festivaali	dog
10	2024-04-17	334.2282807326043	16	Kivaarikilpailujen_huipennus	dog
10	2024-04-17	362.34139996946675	16	Polaris-ampumaharjoitus	dog
10	2024-04-17	305.4324532558037	16	Aamunkoiton_tahtays	dog
10	2024-04-17	320.76494897949686	16	Nordic_Sharpshooters_Cup	dog
10	2024-04-17	357.8101126688881	16	Taivaanranta-tulitus	dog
10	2024-04-17	308.70654745519056	16	Lumivyory-ammunta	dog
10	2024-04-17	304.6869443085493	17	Kesan_Ampujaiset	dog
10	2024-04-17	288.96629726087406	17	Talvi_Pistooli	dog
10	2024-04-17	339.7058422716767	17	Tarkkuuslaukaus-festivaali	dog
10	2024-04-17	306.4948091021676	17	Kivaarikilpailujen_huipennus	dog
10	2024-04-17	335.86044114451397	17	Polaris-ampumaharjoitus	dog
10	2024-04-17	339.4474495124469	17	Aamunkoiton_tahtays	dog
10	2024-04-17	363.3929490713429	17	Nordic_Sharpshooters_Cup	dog
10	2024-04-17	310.4383336042967	17	Taivaanranta-tulitus	dog
10	2024-04-17	349.2649240068513	17	Lumivyory-ammunta	dog
10	2024-04-17	339.72842502787825	18	Kesan_Ampujaiset	dog
10	2024-04-17	323.3461309350558	18	Talvi_Pistooli	dog
10	2024-04-17	381.5685688778634	18	Tarkkuuslaukaus-festivaali	dog
10	2024-04-17	341.71471978139175	18	Kivaarikilpailujen_huipennus	dog
10	2024-04-17	326.4185242750633	18	Polaris-ampumaharjoitus	dog
10	2024-04-17	335.2761536461448	18	Aamunkoiton_tahtays	dog
10	2024-04-17	337.9367341713544	18	Nordic_Sharpshooters_Cup	dog
10	2024-04-17	330.4532087537328	18	Taivaanranta-tulitus	dog
10	2024-04-17	318.7844696207016	18	Lumivyory-ammunta	dog
10	2024-04-17	298.83246075019576	19	Kesan_Ampujaiset	Savu_Seura
10	2024-04-17	301.2299071349094	19	Talvi_Pistooli	Savu_Seura
10	2024-04-17	303.44382686327	19	Tarkkuuslaukaus-festivaali	Savu_Seura
10	2024-04-17	307.83604252281214	19	Kivaarikilpailujen_huipennus	Savu_Seura
10	2024-04-17	314.7546518232591	19	Polaris-ampumaharjoitus	Savu_Seura
10	2024-04-17	345.7272645134708	19	Aamunkoiton_tahtays	Savu_Seura
10	2024-04-17	398.54732159202024	19	Nordic_Sharpshooters_Cup	Savu_Seura
10	2024-04-17	346.30185948395024	19	Taivaanranta-tulitus	Savu_Seura
10	2024-04-17	315.78712534974113	19	Lumivyory-ammunta	Savu_Seura
10	2024-04-17	336.85554602403545	20	Kesan_Ampujaiset	Savu_Seura
10	2024-04-17	309.9342961238908	20	Talvi_Pistooli	Savu_Seura
10	2024-04-17	288.80319767433383	20	Tarkkuuslaukaus-festivaali	Savu_Seura
10	2024-04-17	320.1245045994209	20	Kivaarikilpailujen_huipennus	Savu_Seura
10	2024-04-17	296.49887518531256	20	Polaris-ampumaharjoitus	Savu_Seura
10	2024-04-17	360.8454994752681	20	Aamunkoiton_tahtays	Savu_Seura
10	2024-04-17	318.13643958228954	20	Nordic_Sharpshooters_Cup	Savu_Seura
10	2024-04-17	329.5871672557075	20	Taivaanranta-tulitus	Savu_Seura
10	2024-04-17	289.3882369764455	20	Lumivyory-ammunta	Savu_Seura
10	2024-04-17	289.90134233189195	21	Kesan_Ampujaiset	Savu_Seura
10	2024-04-17	277.3730131952957	21	Talvi_Pistooli	Savu_Seura
10	2024-04-17	333.54177588545815	21	Tarkkuuslaukaus-festivaali	Savu_Seura
10	2024-04-17	327.35382883654495	21	Kivaarikilpailujen_huipennus	Savu_Seura
10	2024-04-17	295.4758829472863	21	Polaris-ampumaharjoitus	Savu_Seura
10	2024-04-17	304.75187780635395	21	Aamunkoiton_tahtays	Savu_Seura
10	2024-04-17	263.0918499598748	21	Nordic_Sharpshooters_Cup	Savu_Seura
10	2024-04-17	357.68407858383245	21	Taivaanranta-tulitus	Savu_Seura
10	2024-04-17	342.1665318337829	21	Lumivyory-ammunta	Savu_Seura
10	2024-04-17	285.742939218397	22	Kesan_Ampujaiset	Savu_Seura
10	2024-04-17	334.2692658568988	22	Talvi_Pistooli	Savu_Seura
10	2024-04-17	323.2599257554676	22	Tarkkuuslaukaus-festivaali	Savu_Seura
10	2024-04-17	341.88937003455953	22	Kivaarikilpailujen_huipennus	Savu_Seura
10	2024-04-17	365.0387891622491	22	Polaris-ampumaharjoitus	Savu_Seura
10	2024-04-17	328.07801983748953	22	Aamunkoiton_tahtays	Savu_Seura
10	2024-04-17	325.48280235452427	22	Nordic_Sharpshooters_Cup	Savu_Seura
10	2024-04-17	346.8869834737444	22	Taivaanranta-tulitus	Savu_Seura
10	2024-04-17	358.26264230992905	22	Lumivyory-ammunta	Savu_Seura
10	2024-04-17	335.3409219457816	23	Kesan_Ampujaiset	Savu_Seura
10	2024-04-17	350.84154818673824	23	Talvi_Pistooli	Savu_Seura
10	2024-04-17	308.2925995930317	23	Tarkkuuslaukaus-festivaali	Savu_Seura
10	2024-04-17	301.92417428055705	23	Kivaarikilpailujen_huipennus	Savu_Seura
10	2024-04-17	332.0516107455071	23	Polaris-ampumaharjoitus	Savu_Seura
10	2024-04-17	325.74604608475744	23	Aamunkoiton_tahtays	Savu_Seura
10	2024-04-17	307.3728895797822	23	Nordic_Sharpshooters_Cup	Savu_Seura
10	2024-04-17	336.5646880566116	23	Taivaanranta-tulitus	Savu_Seura
10	2024-04-17	295.3868033736087	23	Lumivyory-ammunta	Savu_Seura
10	2024-04-17	288.47650858874135	24	Kesan_Ampujaiset	OMAS
10	2024-04-17	297.29891530039106	24	Talvi_Pistooli	OMAS
10	2024-04-17	287.3104070481814	24	Tarkkuuslaukaus-festivaali	OMAS
10	2024-04-17	344.01343796805736	24	Kivaarikilpailujen_huipennus	OMAS
10	2024-04-17	344.9187887887894	24	Polaris-ampumaharjoitus	OMAS
10	2024-04-17	306.80279447890047	24	Aamunkoiton_tahtays	OMAS
10	2024-04-17	306.80282028072196	24	Nordic_Sharpshooters_Cup	OMAS
10	2024-04-17	317.289327006545	24	Taivaanranta-tulitus	OMAS
10	2024-04-17	292.63594630414497	24	Lumivyory-ammunta	OMAS
10	2024-04-17	352.1669048489599	25	Kesan_Ampujaiset	OMAS
10	2024-04-17	291.85843073726835	25	Talvi_Pistooli	OMAS
10	2024-04-17	336.93002270019343	25	Tarkkuuslaukaus-festivaali	OMAS
10	2024-04-17	323.74747445271925	25	Kivaarikilpailujen_huipennus	OMAS
10	2024-04-17	337.2253542777264	25	Polaris-ampumaharjoitus	OMAS
10	2024-04-17	328.16797272340045	25	Aamunkoiton_tahtays	OMAS
10	2024-04-17	331.4620623506829	25	Nordic_Sharpshooters_Cup	OMAS
10	2024-04-17	284.52013394203425	25	Taivaanranta-tulitus	OMAS
10	2024-04-17	327.6219805284735	25	Lumivyory-ammunta	OMAS
10	2024-04-17	311.281837329469	26	Kesan_Ampujaiset	OMAS
10	2024-04-17	325.98593087513166	26	Talvi_Pistooli	OMAS
10	2024-04-17	332.9434456499061	26	Tarkkuuslaukaus-festivaali	OMAS
10	2024-04-17	300.54048963966517	26	Kivaarikilpailujen_huipennus	OMAS
10	2024-04-17	332.3219421326061	26	Polaris-ampumaharjoitus	OMAS
10	2024-04-17	311.19224563168103	26	Aamunkoiton_tahtays	OMAS
10	2024-04-17	256.20831550959076	26	Nordic_Sharpshooters_Cup	OMAS
10	2024-04-17	353.6120401446934	26	Taivaanranta-tulitus	OMAS
10	2024-04-17	312.44409734392053	26	Lumivyory-ammunta	OMAS
10	2024-04-17	328.04405217259074	27	Kesan_Ampujaiset	OMAS
10	2024-04-17	318.5396863143071	27	Talvi_Pistooli	OMAS
10	2024-04-17	353.84210963497657	27	Tarkkuuslaukaus-festivaali	OMAS
10	2024-04-17	345.65490537389707	27	Kivaarikilpailujen_huipennus	OMAS
10	2024-04-17	322.25350429683255	27	Polaris-ampumaharjoitus	OMAS
10	2024-04-17	311.8572292230332	27	Aamunkoiton_tahtays	OMAS
10	2024-04-17	329.0722220154888	27	Nordic_Sharpshooters_Cup	OMAS
10	2024-04-17	375.3783161293148	27	Taivaanranta-tulitus	OMAS
10	2024-04-17	335.8008786638202	27	Lumivyory-ammunta	OMAS
10	2024-04-17	322.49652524184756	28	Kesan_Ampujaiset	Pelleseura
10	2024-04-17	318.2255536281312	28	Talvi_Pistooli	Pelleseura
10	2024-04-17	341.0056357886814	28	Tarkkuuslaukaus-festivaali	Pelleseura
10	2024-04-17	283.279907553355	28	Kivaarikilpailujen_huipennus	Pelleseura
10	2024-04-17	332.4034588694634	28	Polaris-ampumaharjoitus	Pelleseura
10	2024-04-17	356.8067268561409	28	Aamunkoiton_tahtays	Pelleseura
10	2024-04-17	342.15533401516973	28	Nordic_Sharpshooters_Cup	Pelleseura
10	2024-04-17	312.93924229726076	28	Taivaanranta-tulitus	Pelleseura
10	2024-04-17	316.85623608159426	28	Lumivyory-ammunta	Pelleseura
10	2024-04-17	316.81561547829824	29	Kesan_Ampujaiset	Pelleseura
10	2024-04-17	309.8143133197787	29	Talvi_Pistooli	Pelleseura
10	2024-04-17	299.5994112620207	29	Tarkkuuslaukaus-festivaali	Pelleseura
10	2024-04-17	341.6167308407522	29	Kivaarikilpailujen_huipennus	Pelleseura
10	2024-04-17	324.13956105464604	29	Polaris-ampumaharjoitus	Pelleseura
10	2024-04-17	334.30679101955917	29	Aamunkoiton_tahtays	Pelleseura
10	2024-04-17	342.21006641159437	29	Nordic_Sharpshooters_Cup	Pelleseura
10	2024-04-17	336.97698129591294	29	Taivaanranta-tulitus	Pelleseura
10	2024-04-17	354.8160798302676	29	Lumivyory-ammunta	Pelleseura
10	2024-04-17	368.18931865678985	30	Kesan_Ampujaiset	Pelleseura
10	2024-04-17	334.06792677756596	30	Talvi_Pistooli	Pelleseura
10	2024-04-17	335.16598447484216	30	Tarkkuuslaukaus-festivaali	Pelleseura
10	2024-04-17	335.0964713360144	30	Kivaarikilpailujen_huipennus	Pelleseura
10	2024-04-17	288.9980448730872	30	Polaris-ampumaharjoitus	Pelleseura
10	2024-04-17	324.5785383263826	30	Aamunkoiton_tahtays	Pelleseura
10	2024-04-17	334.4843037875653	30	Nordic_Sharpshooters_Cup	Pelleseura
10	2024-04-17	317.7666149413173	30	Taivaanranta-tulitus	Pelleseura
10	2024-04-17	287.47944195686875	30	Lumivyory-ammunta	Pelleseura
10	2024-04-17	291.15679514987687	31	Kesan_Ampujaiset	Pelleseura
10	2024-04-17	283.3721138449615	31	Talvi_Pistooli	Pelleseura
10	2024-04-17	330.94989288108775	31	Tarkkuuslaukaus-festivaali	Pelleseura
10	2024-04-17	342.458825885691	31	Kivaarikilpailujen_huipennus	Pelleseura
10	2024-04-17	282.98490921176517	31	Polaris-ampumaharjoitus	Pelleseura
10	2024-04-17	348.6040175522305	31	Aamunkoiton_tahtays	Pelleseura
10	2024-04-17	294.3656855464487	31	Nordic_Sharpshooters_Cup	Pelleseura
10	2024-04-17	323.0112230713718	31	Taivaanranta-tulitus	Pelleseura
10	2024-04-17	312.55487692082517	31	Lumivyory-ammunta	Pelleseura
10	2024-04-17	334.552971725433	32	Kesan_Ampujaiset	Yung_Tallent
10	2024-04-17	359.11628720128107	32	Talvi_Pistooli	Yung_Tallent
10	2024-04-17	353.21604985889695	32	Tarkkuuslaukaus-festivaali	Yung_Tallent
10	2024-04-17	335.58966877985375	32	Kivaarikilpailujen_huipennus	Yung_Tallent
10	2024-04-17	334.7048794494384	32	Polaris-ampumaharjoitus	Yung_Tallent
10	2024-04-17	358.39504775747696	32	Aamunkoiton_tahtays	Yung_Tallent
10	2024-04-17	283.7857167350086	32	Nordic_Sharpshooters_Cup	Yung_Tallent
10	2024-04-17	331.3832229624755	32	Taivaanranta-tulitus	Yung_Tallent
10	2024-04-17	335.1942652558945	32	Lumivyory-ammunta	Yung_Tallent
10	2024-04-17	322.6299524924359	33	Kesan_Ampujaiset	Yung_Tallent
10	2024-04-17	373.2338050861884	33	Talvi_Pistooli	Yung_Tallent
10	2024-04-17	340.5115899962548	33	Tarkkuuslaukaus-festivaali	Yung_Tallent
10	2024-04-17	352.29322904647296	33	Kivaarikilpailujen_huipennus	Yung_Tallent
10	2024-04-17	295.41155928184395	33	Polaris-ampumaharjoitus	Yung_Tallent
10	2024-04-17	311.91213434005005	33	Aamunkoiton_tahtays	Yung_Tallent
10	2024-04-17	297.0307320759604	33	Nordic_Sharpshooters_Cup	Yung_Tallent
10	2024-04-17	355.7482948345826	33	Taivaanranta-tulitus	Yung_Tallent
10	2024-04-17	365.14357230543027	33	Lumivyory-ammunta	Yung_Tallent
10	2024-04-17	342.23580902866104	34	Kesan_Ampujaiset	Yung_Tallent
10	2024-04-17	358.67159687648484	34	Talvi_Pistooli	Yung_Tallent
10	2024-04-17	307.26239032909615	34	Tarkkuuslaukaus-festivaali	Yung_Tallent
10	2024-04-17	324.50771714261606	34	Kivaarikilpailujen_huipennus	Yung_Tallent
10	2024-04-17	285.55342923320234	34	Polaris-ampumaharjoitus	Yung_Tallent
10	2024-04-17	340.2186131039254	34	Aamunkoiton_tahtays	Yung_Tallent
10	2024-04-17	312.05954901252795	34	Nordic_Sharpshooters_Cup	Yung_Tallent
10	2024-04-17	279.9195180085483	34	Taivaanranta-tulitus	Yung_Tallent
10	2024-04-17	331.85029334513285	34	Lumivyory-ammunta	Yung_Tallent
10	2024-04-17	339.37063491575645	35	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
10	2024-04-17	349.6895873919562	35	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
10	2024-04-17	347.19015165494085	35	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
10	2024-04-17	347.40206820652077	35	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	321.7565991532797	35	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	284.0327609797016	35	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
10	2024-04-17	325.49031160227963	35	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	323.01880500715316	35	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	304.7978980832839	35	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
10	2024-04-17	305.95179802847247	36	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
10	2024-04-17	288.3833932146156	36	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
10	2024-04-17	352.4989909019311	36	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
10	2024-04-17	349.69232559281016	36	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	338.9075469396206	36	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	342.24585261203094	36	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
10	2024-04-17	335.16800962481636	36	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	331.38003645012304	36	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	301.85545454528267	36	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
10	2024-04-17	331.41944705137917	37	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
10	2024-04-17	296.30757499238894	37	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
10	2024-04-17	322.0492433017013	37	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
10	2024-04-17	336.02478207193053	37	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	355.1246274465679	37	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	341.2601680860488	37	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
10	2024-04-17	361.3312270727989	37	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	300.905312333733	37	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	311.5478810136252	37	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
10	2024-04-17	306.32588863853783	38	Kesan_Ampujaiset	Aseharrastajien_Yhtenaisyys
10	2024-04-17	281.2146769861045	38	Talvi_Pistooli	Aseharrastajien_Yhtenaisyys
10	2024-04-17	351.79035867042154	38	Tarkkuuslaukaus-festivaali	Aseharrastajien_Yhtenaisyys
10	2024-04-17	298.87645085028146	38	Kivaarikilpailujen_huipennus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	337.45239981296487	38	Polaris-ampumaharjoitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	329.79703618531255	38	Aamunkoiton_tahtays	Aseharrastajien_Yhtenaisyys
10	2024-04-17	317.88000664797767	38	Nordic_Sharpshooters_Cup	Aseharrastajien_Yhtenaisyys
10	2024-04-17	313.8777814921631	38	Taivaanranta-tulitus	Aseharrastajien_Yhtenaisyys
10	2024-04-17	318.80001005741644	38	Lumivyory-ammunta	Aseharrastajien_Yhtenaisyys
10	2024-04-17	345.5245693238083	39	Kesan_Ampujaiset	Tahtaysmestarit
10	2024-04-17	340.6754778240399	39	Talvi_Pistooli	Tahtaysmestarit
10	2024-04-17	306.91342223116453	39	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
10	2024-04-17	327.29710926471233	39	Kivaarikilpailujen_huipennus	Tahtaysmestarit
10	2024-04-17	353.30678586535566	39	Polaris-ampumaharjoitus	Tahtaysmestarit
10	2024-04-17	328.51813587715986	39	Aamunkoiton_tahtays	Tahtaysmestarit
10	2024-04-17	322.57587304672813	39	Nordic_Sharpshooters_Cup	Tahtaysmestarit
10	2024-04-17	359.3196235664269	39	Taivaanranta-tulitus	Tahtaysmestarit
10	2024-04-17	309.6445203891318	39	Lumivyory-ammunta	Tahtaysmestarit
10	2024-04-17	366.2011425763995	40	Kesan_Ampujaiset	Tahtaysmestarit
10	2024-04-17	386.96617676041063	40	Talvi_Pistooli	Tahtaysmestarit
10	2024-04-17	330.46320366628805	40	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
10	2024-04-17	323.86642626114906	40	Kivaarikilpailujen_huipennus	Tahtaysmestarit
10	2024-04-17	266.0606175073136	40	Polaris-ampumaharjoitus	Tahtaysmestarit
10	2024-04-17	341.35620610203574	40	Aamunkoiton_tahtays	Tahtaysmestarit
10	2024-04-17	310.0881473527445	40	Nordic_Sharpshooters_Cup	Tahtaysmestarit
10	2024-04-17	313.26782598198974	40	Taivaanranta-tulitus	Tahtaysmestarit
10	2024-04-17	352.0187451416986	40	Lumivyory-ammunta	Tahtaysmestarit
10	2024-04-17	353.7120478596295	41	Kesan_Ampujaiset	Tahtaysmestarit
10	2024-04-17	321.1140758765681	41	Talvi_Pistooli	Tahtaysmestarit
10	2024-04-17	314.43611915984224	41	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
10	2024-04-17	316.46537508071475	41	Kivaarikilpailujen_huipennus	Tahtaysmestarit
10	2024-04-17	304.3900240071608	41	Polaris-ampumaharjoitus	Tahtaysmestarit
10	2024-04-17	351.75491194887115	41	Aamunkoiton_tahtays	Tahtaysmestarit
10	2024-04-17	293.5806754759265	41	Nordic_Sharpshooters_Cup	Tahtaysmestarit
10	2024-04-17	333.65709879677405	41	Taivaanranta-tulitus	Tahtaysmestarit
10	2024-04-17	349.26417487040277	41	Lumivyory-ammunta	Tahtaysmestarit
10	2024-04-17	371.41103133730064	42	Kesan_Ampujaiset	Tahtaysmestarit
10	2024-04-17	356.77391976926003	42	Talvi_Pistooli	Tahtaysmestarit
10	2024-04-17	297.9515096110358	42	Tarkkuuslaukaus-festivaali	Tahtaysmestarit
10	2024-04-17	312.1058755705157	42	Kivaarikilpailujen_huipennus	Tahtaysmestarit
10	2024-04-17	335.00795964513003	42	Polaris-ampumaharjoitus	Tahtaysmestarit
10	2024-04-17	332.73131759781865	42	Aamunkoiton_tahtays	Tahtaysmestarit
10	2024-04-17	285.9855788790454	42	Nordic_Sharpshooters_Cup	Tahtaysmestarit
10	2024-04-17	345.0483969597163	42	Taivaanranta-tulitus	Tahtaysmestarit
10	2024-04-17	351.5304839710229	42	Lumivyory-ammunta	Tahtaysmestarit
10	2024-04-17	325.6088542890495	43	Kesan_Ampujaiset	Laukausryhma_Aurora
10	2024-04-17	301.1422468785277	43	Talvi_Pistooli	Laukausryhma_Aurora
10	2024-04-17	336.42693331067	43	Tarkkuuslaukaus-festivaali	Laukausryhma_Aurora
10	2024-04-17	333.51507762656973	43	Kivaarikilpailujen_huipennus	Laukausryhma_Aurora
10	2024-04-17	348.1249187212211	43	Polaris-ampumaharjoitus	Laukausryhma_Aurora
10	2024-04-17	361.84009900346547	43	Aamunkoiton_tahtays	Laukausryhma_Aurora
10	2024-04-17	313.9180326553294	43	Nordic_Sharpshooters_Cup	Laukausryhma_Aurora
10	2024-04-17	313.7952424663913	43	Taivaanranta-tulitus	Laukausryhma_Aurora
10	2024-04-17	363.0322342910642	43	Lumivyory-ammunta	Laukausryhma_Aurora
10	2024-04-17	334.1926247688266	44	Kesan_Ampujaiset	Laukausryhma_Aurora
10	2024-04-17	349.7499572738373	44	Talvi_Pistooli	Laukausryhma_Aurora
10	2024-04-17	328.2139969351892	44	Tarkkuuslaukaus-festivaali	Laukausryhma_Aurora
10	2024-04-17	316.0603980922042	44	Kivaarikilpailujen_huipennus	Laukausryhma_Aurora
10	2024-04-17	316.1511372068708	44	Polaris-ampumaharjoitus	Laukausryhma_Aurora
10	2024-04-17	270.5752643761162	44	Aamunkoiton_tahtays	Laukausryhma_Aurora
10	2024-04-17	324.34527677744535	44	Nordic_Sharpshooters_Cup	Laukausryhma_Aurora
10	2024-04-17	289.6156362933285	44	Taivaanranta-tulitus	Laukausryhma_Aurora
10	2024-04-17	382.9179416863557	44	Lumivyory-ammunta	Laukausryhma_Aurora
10	2024-04-17	354.05133941647875	45	Kesan_Ampujaiset	Laukausryhma_Aurora
10	2024-04-17	333.80967083344177	45	Talvi_Pistooli	Laukausryhma_Aurora
10	2024-04-17	280.3075093788192	45	Tarkkuuslaukaus-festivaali	Laukausryhma_Aurora
10	2024-04-17	334.03397266535063	45	Kivaarikilpailujen_huipennus	Laukausryhma_Aurora
10	2024-04-17	331.59224882487746	45	Polaris-ampumaharjoitus	Laukausryhma_Aurora
10	2024-04-17	308.4796553961465	45	Aamunkoiton_tahtays	Laukausryhma_Aurora
10	2024-04-17	311.4592121729367	45	Nordic_Sharpshooters_Cup	Laukausryhma_Aurora
10	2024-04-17	280.76610915029266	45	Taivaanranta-tulitus	Laukausryhma_Aurora
10	2024-04-17	322.12393504048526	45	Lumivyory-ammunta	Laukausryhma_Aurora
10	2024-04-17	320.14347683877736	46	Kesan_Ampujaiset	Ampumataito
10	2024-04-17	358.6545835395633	46	Talvi_Pistooli	Ampumataito
10	2024-04-17	348.77062402754535	46	Tarkkuuslaukaus-festivaali	Ampumataito
10	2024-04-17	300.8954651458632	46	Kivaarikilpailujen_huipennus	Ampumataito
10	2024-04-17	345.1702315896559	46	Polaris-ampumaharjoitus	Ampumataito
10	2024-04-17	346.261497525317	46	Aamunkoiton_tahtays	Ampumataito
10	2024-04-17	333.31713465271326	46	Nordic_Sharpshooters_Cup	Ampumataito
10	2024-04-17	345.7812902405958	46	Taivaanranta-tulitus	Ampumataito
10	2024-04-17	311.88257244034577	46	Lumivyory-ammunta	Ampumataito
10	2024-04-17	335.46397175478177	47	Kesan_Ampujaiset	Ampumataito
10	2024-04-17	348.11428960079627	47	Talvi_Pistooli	Ampumataito
10	2024-04-17	340.9665391377438	47	Tarkkuuslaukaus-festivaali	Ampumataito
10	2024-04-17	310.82481651844813	47	Kivaarikilpailujen_huipennus	Ampumataito
10	2024-04-17	339.14818166564663	47	Polaris-ampumaharjoitus	Ampumataito
10	2024-04-17	330.71128797610294	47	Aamunkoiton_tahtays	Ampumataito
10	2024-04-17	327.8794437950076	47	Nordic_Sharpshooters_Cup	Ampumataito
10	2024-04-17	319.57819025041925	47	Taivaanranta-tulitus	Ampumataito
10	2024-04-17	311.50272471025477	47	Lumivyory-ammunta	Ampumataito
10	2024-04-17	326.655513339101	48	Kesan_Ampujaiset	Ampumataito
10	2024-04-17	298.45488476531557	48	Talvi_Pistooli	Ampumataito
10	2024-04-17	344.1711756810937	48	Tarkkuuslaukaus-festivaali	Ampumataito
10	2024-04-17	310.7264293335216	48	Kivaarikilpailujen_huipennus	Ampumataito
10	2024-04-17	321.62511993498697	48	Polaris-ampumaharjoitus	Ampumataito
10	2024-04-17	321.17103414578264	48	Aamunkoiton_tahtays	Ampumataito
10	2024-04-17	320.97683446477714	48	Nordic_Sharpshooters_Cup	Ampumataito
10	2024-04-17	295.3218395280308	48	Taivaanranta-tulitus	Ampumataito
10	2024-04-17	342.8067717557058	48	Lumivyory-ammunta	Ampumataito
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_ (creation_date, last_login, id, email, legal_name, part_of_club, password, username) FROM stdin;
2024-04-17	\N	1	admin	admin	\N	$2a$10$FYZhjMFSckELXDf.n1ErZedqm8NVPVbyTS7iaLfzLj03CW6ejbW6y	admin
\N	\N	2	\N	Kaarina J├ñrvinen	Poliisiseura	\N	VTolT43RNt
\N	\N	3	\N	Matti J├ñrvinen	Poliisiseura	\N	scgO3brHEG
\N	\N	4	\N	Kaarina Virtanen	Poliisiseura	\N	3QS19YURUb
\N	\N	5	\N	Mikael H├ñm├ñl├ñinen	Koiraseura	\N	tShd6o3K44
\N	\N	6	\N	Antero Lehtinen	Koiraseura	\N	eAJqf67jkV
\N	\N	7	\N	Mikael Heikkinen	Koiraseura	\N	YI6vXEpjLJ
\N	\N	8	\N	Maria Ollakka	Koiraseura	\N	paDWRug7S3
\N	\N	9	\N	Juhani Kelanti	Koiraseura	\N	KoTqtDNWZI
\N	\N	10	\N	Marjatta Kelanti	Hammaspeikkoseura	\N	CgYv3vCbRS
\N	\N	11	\N	Tapani M├ñkel├ñ	Hammaspeikkoseura	\N	uFXl7WHD9U
\N	\N	12	\N	Anneli Heikkinen	Hammaspeikkoseura	\N	HqXJLsQIrA
\N	\N	13	\N	Maria Heikkinen	Hammaspeikkoseura	\N	Qdc7tILWvi
\N	\N	14	\N	Ilmari Koskinen	Hammaspeikkoseura	\N	pJYAkxgfYE
\N	\N	15	\N	Antero Heikkinen	dog	\N	ArGyACWHgV
\N	\N	16	\N	Anna Kelanti	dog	\N	H8R3OHavsA
\N	\N	17	\N	Tapani Koskinen	dog	\N	phV4JQTUzE
\N	\N	18	\N	Marjatta Juustila	dog	\N	mI8Oz3DQE7
\N	\N	19	\N	Anneli H├ñm├ñl├ñinen	Savu_Seura	\N	mtjPwSccSk
\N	\N	20	\N	Juhani Koskinen	Savu_Seura	\N	fltpQNbCKV
\N	\N	21	\N	Tapani Kelanti	Savu_Seura	\N	zuszKEfA4h
\N	\N	22	\N	Mikael Laine	Savu_Seura	\N	IAJNjaPnM2
\N	\N	23	\N	Johannes Holappa	Savu_Seura	\N	Cqk0ZHPrGC
\N	\N	24	\N	Juhani Laine	OMAS	\N	d7ANhVUzKX
\N	\N	25	\N	Matti M├ñkel├ñ	OMAS	\N	W1BP47bDk9
\N	\N	26	\N	Anneli Lehtinen	OMAS	\N	2fbp33VVNS
\N	\N	27	\N	Mikael Lehtinen	OMAS	\N	uFHcwyYDkE
\N	\N	28	\N	Anna Ollakka	Pelleseura	\N	aED5PApGSs
\N	\N	29	\N	Tapani Virtanen	Pelleseura	\N	2vnQibnXnU
\N	\N	30	\N	Juhani Heikkinen	Pelleseura	\N	f7DYcnDAhU
\N	\N	31	\N	Marjatta Virtanen	Pelleseura	\N	QoBUAKMdor
\N	\N	32	\N	Kaarina J├ñrvinen	Yung_Tallent	\N	3YuPLzYcJx
\N	\N	33	\N	Johannes Heikkinen	Yung_Tallent	\N	2CweGNxrFl
\N	\N	34	\N	Marjatta M├ñkinen	Yung_Tallent	\N	X750H6UYll
\N	\N	35	\N	Johannes Heikkinen	Aseharrastajien_Yhtenaisyys	\N	tiE2Rdnjw7
\N	\N	36	\N	Kaarina Kumpulainen	Aseharrastajien_Yhtenaisyys	\N	kjXkbSe0hi
\N	\N	37	\N	Tapani M├ñkinen	Aseharrastajien_Yhtenaisyys	\N	8Zhb1iRWHM
\N	\N	38	\N	Johanna Komulainen	Aseharrastajien_Yhtenaisyys	\N	aLfIupXYVb
\N	\N	39	\N	Matti Virtanen	Tahtaysmestarit	\N	cXV07gh4nr
\N	\N	40	\N	Tapio Laine	Tahtaysmestarit	\N	raFzQrHNxX
\N	\N	41	\N	Matti M├ñ├ñtt├ñ	Tahtaysmestarit	\N	JYm4uxHgl7
\N	\N	42	\N	Matti Kumpulainen	Tahtaysmestarit	\N	s5n4P4H9pQ
\N	\N	43	\N	Matti Kumpulainen	Laukausryhma_Aurora	\N	oCjITrZEt1
\N	\N	44	\N	Antero Nieminen	Laukausryhma_Aurora	\N	kPpqmBuCBy
\N	\N	45	\N	Anna H├ñm├ñl├ñinen	Laukausryhma_Aurora	\N	sOqSn3E1Ay
\N	\N	46	\N	Johannes Kumpulainen	Ampumataito	\N	x29TJR3TUL
\N	\N	47	\N	Tapani Kelanti	Ampumataito	\N	RjA9168YM6
\N	\N	48	\N	Kalevi Virtanen	Ampumataito	\N	DDUI3GCzHW
\.


--
-- Name: user__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user__id_seq', 48, true);


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
    ADD CONSTRAINT image_proof_pkey PRIMARY KEY (user_id, competition_id, file_name, team_name);


--
-- Name: password_reset_token password_reset_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT password_reset_token_pkey PRIMARY KEY (id);


--
-- Name: password_reset_token password_reset_token_reset_password_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT password_reset_token_reset_password_token_key UNIQUE (reset_password_token);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (user_id, role);


--
-- Name: team_member team_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (user_id, competition_id, team_name);


--
-- Name: team_member_score team_member_score_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member_score
    ADD CONSTRAINT team_member_score_pkey PRIMARY KEY (user_id, competition_id, team_name);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (competition_id, team_name);


--
-- Name: user_ user__email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__email_key UNIQUE (email);


--
-- Name: user_ user__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__pkey PRIMARY KEY (id);


--
-- Name: user_ user__username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__username_key UNIQUE (username);


--
-- Name: team_member fk3fi820e3nsm0yyd1pm6nf44ti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT fk3fi820e3nsm0yyd1pm6nf44ti FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: team_member_score fk40uj7cbxbqebqrbmdatolafvw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_member_score
    ADD CONSTRAINT fk40uj7cbxbqebqrbmdatolafvw FOREIGN KEY (user_id, competition_id, team_name) REFERENCES public.team_member(user_id, competition_id, team_name);


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
    ADD CONSTRAINT fknlenavcfp7tawq2c2fwr56f1 FOREIGN KEY (user_id, competition_id, team_name) REFERENCES public.team_member_score(user_id, competition_id, team_name);


--
-- Name: team fkqhhapgh63c9yjo4tc0uf6ynt1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT fkqhhapgh63c9yjo4tc0uf6ynt1 FOREIGN KEY (competition_id) REFERENCES public.competition(competition_id);


--
-- PostgreSQL database dump complete
--

