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
2024-04-18	0	poliisiseura	Poliisiseura	\N
2024-04-18	0	koiraseura	Koiraseura	\N
2024-04-18	0	hammaspeikkoseura	Hammaspeikkoseura	\N
2024-04-18	0	dog	dog	\N
2024-04-18	0	savu_seura	Savu Seura	\N
2024-04-18	0	omas	OMAS	\N
2024-04-18	0	pelleseura	Pelleseura	\N
2024-04-18	0	yung_tallent	Yung Tallent	\N
2024-04-18	0	aseharrastajien_yhtenaisyys	Aseharrastajien Yhtenäisyys	\N
2024-04-18	0	tahtaysmestarit	Tähtäysmestarit	\N
2024-04-18	0	laukausryhma_aurora	Laukausryhmä Aurora	\N
2024-04-18	0	ampumataito	Ampumataito	\N
\.


--
-- Data for Name: competition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition (creation_date, end_date, start_date, competition_id, display_name, type) FROM stdin;
2024-04-18	2024-06-17	2024-05-26	kesan_ampujaiset	Kesän Ampujaiset	rifle
2024-04-18	2024-05-27	2024-05-06	talvi_pistooli	Talvi Pistooli	rifle
2024-04-18	2024-04-22	2024-04-04	tarkkuuslaukaus-festivaali	Tarkkuuslaukaus-festivaali	rifle
2024-04-18	2024-04-15	2024-02-16	kivaarikilpailujen_huipennus	Kiväärikilpailujen huipennus	rifle
2024-04-18	2024-06-21	2024-05-23	polaris-ampumaharjoitus	Polaris-ampumaharjoitus	rifle
2024-04-18	2024-04-23	2024-03-05	aamunkoiton_tahtays	Aamunkoiton tähtäys	rifle
2024-04-18	2024-03-27	2024-03-10	nordic_sharpshooters_cup	Nordic Sharpshooters Cup	rifle
2024-04-18	2024-11-27	2024-01-06	taivaanranta-tulitus	Taivaanranta-tulitus	rifle
2024-04-18	2024-04-13	2024-04-03	lumivyory-ammunta	Lumivyöry-ammunta	rifle
2024-04-18	2022-07-04	2022-05-11	tarkka-ammunta_cup	Tarkka-ammunta Cup	pistol
2024-04-18	2026-04-25	2025-08-30	nopean_laukauksen_mestaruus	Nopean laukauksen mestaruus	pistol
2024-04-18	2024-06-12	2024-04-27	moniottelu	Moniottelu	pistol
2024-04-18	2024-01-25	2022-12-23	kansallinen_tahtayskilpailu	Kansallinen tähtäyskilpailu	pistol
2024-04-18	2024-05-12	2024-04-07	kaupunkiammunta-challenge	Kaupunkiammunta-challenge	pistol
2024-04-18	2027-03-19	2025-09-13	laukausmaraton	Laukausmaraton	pistol
2024-04-18	2024-04-14	2022-12-04	vapaa-asekilpailu	Vapaa-asekilpailu	pistol
2024-04-18	2024-05-31	2024-04-08	taitoluodikko-turnaus	Taitoluodikko-turnaus	pistol
2024-04-18	2024-05-27	2024-05-03	precision_pistol_cup	Precision Pistol Cup	pistol
2024-04-18	2024-07-28	2023-05-03	tulevaisuuden_ampuja	Tulevaisuuden Ampuja	pistol
2024-04-18	2023-01-06	2022-08-03	pikakivaari-klassikko	Pikakivääri-klassikko	pistol
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
\N	54	ROLE_USER
\N	54	ROLE_ADMIN
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (club_name, competition_id, team_display_name, team_name) FROM stdin;
poliisiseura	kesan_ampujaiset	Poliisiseura	poliisiseura
koiraseura	kesan_ampujaiset	Koiraseura	koiraseura
hammaspeikkoseura	kesan_ampujaiset	Hammaspeikkoseura	hammaspeikkoseura
dog	kesan_ampujaiset	dog	dog
savu_seura	kesan_ampujaiset	Savu Seura	savu_seura
omas	kesan_ampujaiset	OMAS	omas
pelleseura	kesan_ampujaiset	Pelleseura	pelleseura
yung_tallent	kesan_ampujaiset	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	kesan_ampujaiset	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	kesan_ampujaiset	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	kesan_ampujaiset	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	kesan_ampujaiset	Ampumataito	ampumataito
poliisiseura	talvi_pistooli	Poliisiseura	poliisiseura
koiraseura	talvi_pistooli	Koiraseura	koiraseura
hammaspeikkoseura	talvi_pistooli	Hammaspeikkoseura	hammaspeikkoseura
dog	talvi_pistooli	dog	dog
savu_seura	talvi_pistooli	Savu Seura	savu_seura
omas	talvi_pistooli	OMAS	omas
pelleseura	talvi_pistooli	Pelleseura	pelleseura
yung_tallent	talvi_pistooli	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	talvi_pistooli	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	talvi_pistooli	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	talvi_pistooli	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	talvi_pistooli	Ampumataito	ampumataito
poliisiseura	tarkkuuslaukaus-festivaali	Poliisiseura	poliisiseura
koiraseura	tarkkuuslaukaus-festivaali	Koiraseura	koiraseura
hammaspeikkoseura	tarkkuuslaukaus-festivaali	Hammaspeikkoseura	hammaspeikkoseura
dog	tarkkuuslaukaus-festivaali	dog	dog
savu_seura	tarkkuuslaukaus-festivaali	Savu Seura	savu_seura
omas	tarkkuuslaukaus-festivaali	OMAS	omas
pelleseura	tarkkuuslaukaus-festivaali	Pelleseura	pelleseura
yung_tallent	tarkkuuslaukaus-festivaali	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	tarkkuuslaukaus-festivaali	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	tarkkuuslaukaus-festivaali	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	tarkkuuslaukaus-festivaali	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	tarkkuuslaukaus-festivaali	Ampumataito	ampumataito
poliisiseura	kivaarikilpailujen_huipennus	Poliisiseura	poliisiseura
koiraseura	kivaarikilpailujen_huipennus	Koiraseura	koiraseura
hammaspeikkoseura	kivaarikilpailujen_huipennus	Hammaspeikkoseura	hammaspeikkoseura
dog	kivaarikilpailujen_huipennus	dog	dog
savu_seura	kivaarikilpailujen_huipennus	Savu Seura	savu_seura
omas	kivaarikilpailujen_huipennus	OMAS	omas
pelleseura	kivaarikilpailujen_huipennus	Pelleseura	pelleseura
yung_tallent	kivaarikilpailujen_huipennus	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	kivaarikilpailujen_huipennus	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	kivaarikilpailujen_huipennus	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	kivaarikilpailujen_huipennus	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	kivaarikilpailujen_huipennus	Ampumataito	ampumataito
poliisiseura	polaris-ampumaharjoitus	Poliisiseura	poliisiseura
koiraseura	polaris-ampumaharjoitus	Koiraseura	koiraseura
hammaspeikkoseura	polaris-ampumaharjoitus	Hammaspeikkoseura	hammaspeikkoseura
dog	polaris-ampumaharjoitus	dog	dog
savu_seura	polaris-ampumaharjoitus	Savu Seura	savu_seura
omas	polaris-ampumaharjoitus	OMAS	omas
pelleseura	polaris-ampumaharjoitus	Pelleseura	pelleseura
yung_tallent	polaris-ampumaharjoitus	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	polaris-ampumaharjoitus	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	polaris-ampumaharjoitus	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	polaris-ampumaharjoitus	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	polaris-ampumaharjoitus	Ampumataito	ampumataito
poliisiseura	aamunkoiton_tahtays	Poliisiseura	poliisiseura
koiraseura	aamunkoiton_tahtays	Koiraseura	koiraseura
hammaspeikkoseura	aamunkoiton_tahtays	Hammaspeikkoseura	hammaspeikkoseura
dog	aamunkoiton_tahtays	dog	dog
savu_seura	aamunkoiton_tahtays	Savu Seura	savu_seura
omas	aamunkoiton_tahtays	OMAS	omas
pelleseura	aamunkoiton_tahtays	Pelleseura	pelleseura
yung_tallent	aamunkoiton_tahtays	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	aamunkoiton_tahtays	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	aamunkoiton_tahtays	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	aamunkoiton_tahtays	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	aamunkoiton_tahtays	Ampumataito	ampumataito
poliisiseura	nordic_sharpshooters_cup	Poliisiseura	poliisiseura
koiraseura	nordic_sharpshooters_cup	Koiraseura	koiraseura
hammaspeikkoseura	nordic_sharpshooters_cup	Hammaspeikkoseura	hammaspeikkoseura
dog	nordic_sharpshooters_cup	dog	dog
savu_seura	nordic_sharpshooters_cup	Savu Seura	savu_seura
omas	nordic_sharpshooters_cup	OMAS	omas
pelleseura	nordic_sharpshooters_cup	Pelleseura	pelleseura
yung_tallent	nordic_sharpshooters_cup	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	nordic_sharpshooters_cup	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	nordic_sharpshooters_cup	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	nordic_sharpshooters_cup	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	nordic_sharpshooters_cup	Ampumataito	ampumataito
poliisiseura	taivaanranta-tulitus	Poliisiseura	poliisiseura
koiraseura	taivaanranta-tulitus	Koiraseura	koiraseura
hammaspeikkoseura	taivaanranta-tulitus	Hammaspeikkoseura	hammaspeikkoseura
dog	taivaanranta-tulitus	dog	dog
savu_seura	taivaanranta-tulitus	Savu Seura	savu_seura
omas	taivaanranta-tulitus	OMAS	omas
pelleseura	taivaanranta-tulitus	Pelleseura	pelleseura
yung_tallent	taivaanranta-tulitus	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	taivaanranta-tulitus	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	taivaanranta-tulitus	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	taivaanranta-tulitus	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	taivaanranta-tulitus	Ampumataito	ampumataito
poliisiseura	lumivyory-ammunta	Poliisiseura	poliisiseura
koiraseura	lumivyory-ammunta	Koiraseura	koiraseura
hammaspeikkoseura	lumivyory-ammunta	Hammaspeikkoseura	hammaspeikkoseura
dog	lumivyory-ammunta	dog	dog
savu_seura	lumivyory-ammunta	Savu Seura	savu_seura
omas	lumivyory-ammunta	OMAS	omas
pelleseura	lumivyory-ammunta	Pelleseura	pelleseura
yung_tallent	lumivyory-ammunta	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	lumivyory-ammunta	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	lumivyory-ammunta	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	lumivyory-ammunta	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	lumivyory-ammunta	Ampumataito	ampumataito
poliisiseura	tarkka-ammunta_cup	Poliisiseura	poliisiseura
koiraseura	tarkka-ammunta_cup	Koiraseura	koiraseura
hammaspeikkoseura	tarkka-ammunta_cup	Hammaspeikkoseura	hammaspeikkoseura
dog	tarkka-ammunta_cup	dog	dog
savu_seura	tarkka-ammunta_cup	Savu Seura	savu_seura
omas	tarkka-ammunta_cup	OMAS	omas
pelleseura	tarkka-ammunta_cup	Pelleseura	pelleseura
yung_tallent	tarkka-ammunta_cup	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	tarkka-ammunta_cup	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	tarkka-ammunta_cup	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	tarkka-ammunta_cup	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	tarkka-ammunta_cup	Ampumataito	ampumataito
poliisiseura	nopean_laukauksen_mestaruus	Poliisiseura	poliisiseura
koiraseura	nopean_laukauksen_mestaruus	Koiraseura	koiraseura
hammaspeikkoseura	nopean_laukauksen_mestaruus	Hammaspeikkoseura	hammaspeikkoseura
dog	nopean_laukauksen_mestaruus	dog	dog
savu_seura	nopean_laukauksen_mestaruus	Savu Seura	savu_seura
omas	nopean_laukauksen_mestaruus	OMAS	omas
pelleseura	nopean_laukauksen_mestaruus	Pelleseura	pelleseura
yung_tallent	nopean_laukauksen_mestaruus	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	nopean_laukauksen_mestaruus	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	nopean_laukauksen_mestaruus	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	nopean_laukauksen_mestaruus	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	nopean_laukauksen_mestaruus	Ampumataito	ampumataito
poliisiseura	moniottelu	Poliisiseura	poliisiseura
koiraseura	moniottelu	Koiraseura	koiraseura
hammaspeikkoseura	moniottelu	Hammaspeikkoseura	hammaspeikkoseura
dog	moniottelu	dog	dog
savu_seura	moniottelu	Savu Seura	savu_seura
omas	moniottelu	OMAS	omas
pelleseura	moniottelu	Pelleseura	pelleseura
yung_tallent	moniottelu	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	moniottelu	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	moniottelu	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	moniottelu	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	moniottelu	Ampumataito	ampumataito
poliisiseura	kansallinen_tahtayskilpailu	Poliisiseura	poliisiseura
koiraseura	kansallinen_tahtayskilpailu	Koiraseura	koiraseura
hammaspeikkoseura	kansallinen_tahtayskilpailu	Hammaspeikkoseura	hammaspeikkoseura
dog	kansallinen_tahtayskilpailu	dog	dog
savu_seura	kansallinen_tahtayskilpailu	Savu Seura	savu_seura
omas	kansallinen_tahtayskilpailu	OMAS	omas
pelleseura	kansallinen_tahtayskilpailu	Pelleseura	pelleseura
yung_tallent	kansallinen_tahtayskilpailu	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	kansallinen_tahtayskilpailu	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	kansallinen_tahtayskilpailu	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	kansallinen_tahtayskilpailu	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	kansallinen_tahtayskilpailu	Ampumataito	ampumataito
poliisiseura	kaupunkiammunta-challenge	Poliisiseura	poliisiseura
koiraseura	kaupunkiammunta-challenge	Koiraseura	koiraseura
hammaspeikkoseura	kaupunkiammunta-challenge	Hammaspeikkoseura	hammaspeikkoseura
dog	kaupunkiammunta-challenge	dog	dog
savu_seura	kaupunkiammunta-challenge	Savu Seura	savu_seura
omas	kaupunkiammunta-challenge	OMAS	omas
pelleseura	kaupunkiammunta-challenge	Pelleseura	pelleseura
yung_tallent	kaupunkiammunta-challenge	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	kaupunkiammunta-challenge	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	kaupunkiammunta-challenge	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	kaupunkiammunta-challenge	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	kaupunkiammunta-challenge	Ampumataito	ampumataito
poliisiseura	laukausmaraton	Poliisiseura	poliisiseura
koiraseura	laukausmaraton	Koiraseura	koiraseura
hammaspeikkoseura	laukausmaraton	Hammaspeikkoseura	hammaspeikkoseura
dog	laukausmaraton	dog	dog
savu_seura	laukausmaraton	Savu Seura	savu_seura
omas	laukausmaraton	OMAS	omas
pelleseura	laukausmaraton	Pelleseura	pelleseura
yung_tallent	laukausmaraton	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	laukausmaraton	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	laukausmaraton	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	laukausmaraton	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	laukausmaraton	Ampumataito	ampumataito
poliisiseura	vapaa-asekilpailu	Poliisiseura	poliisiseura
koiraseura	vapaa-asekilpailu	Koiraseura	koiraseura
hammaspeikkoseura	vapaa-asekilpailu	Hammaspeikkoseura	hammaspeikkoseura
dog	vapaa-asekilpailu	dog	dog
savu_seura	vapaa-asekilpailu	Savu Seura	savu_seura
omas	vapaa-asekilpailu	OMAS	omas
pelleseura	vapaa-asekilpailu	Pelleseura	pelleseura
yung_tallent	vapaa-asekilpailu	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	vapaa-asekilpailu	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	vapaa-asekilpailu	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	vapaa-asekilpailu	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	vapaa-asekilpailu	Ampumataito	ampumataito
poliisiseura	taitoluodikko-turnaus	Poliisiseura	poliisiseura
koiraseura	taitoluodikko-turnaus	Koiraseura	koiraseura
hammaspeikkoseura	taitoluodikko-turnaus	Hammaspeikkoseura	hammaspeikkoseura
dog	taitoluodikko-turnaus	dog	dog
savu_seura	taitoluodikko-turnaus	Savu Seura	savu_seura
omas	taitoluodikko-turnaus	OMAS	omas
pelleseura	taitoluodikko-turnaus	Pelleseura	pelleseura
yung_tallent	taitoluodikko-turnaus	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	taitoluodikko-turnaus	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	taitoluodikko-turnaus	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	taitoluodikko-turnaus	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	taitoluodikko-turnaus	Ampumataito	ampumataito
poliisiseura	precision_pistol_cup	Poliisiseura	poliisiseura
koiraseura	precision_pistol_cup	Koiraseura	koiraseura
hammaspeikkoseura	precision_pistol_cup	Hammaspeikkoseura	hammaspeikkoseura
dog	precision_pistol_cup	dog	dog
savu_seura	precision_pistol_cup	Savu Seura	savu_seura
omas	precision_pistol_cup	OMAS	omas
pelleseura	precision_pistol_cup	Pelleseura	pelleseura
yung_tallent	precision_pistol_cup	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	precision_pistol_cup	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	precision_pistol_cup	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	precision_pistol_cup	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	precision_pistol_cup	Ampumataito	ampumataito
poliisiseura	tulevaisuuden_ampuja	Poliisiseura	poliisiseura
koiraseura	tulevaisuuden_ampuja	Koiraseura	koiraseura
hammaspeikkoseura	tulevaisuuden_ampuja	Hammaspeikkoseura	hammaspeikkoseura
dog	tulevaisuuden_ampuja	dog	dog
savu_seura	tulevaisuuden_ampuja	Savu Seura	savu_seura
omas	tulevaisuuden_ampuja	OMAS	omas
pelleseura	tulevaisuuden_ampuja	Pelleseura	pelleseura
yung_tallent	tulevaisuuden_ampuja	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	tulevaisuuden_ampuja	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	tulevaisuuden_ampuja	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	tulevaisuuden_ampuja	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	tulevaisuuden_ampuja	Ampumataito	ampumataito
poliisiseura	pikakivaari-klassikko	Poliisiseura	poliisiseura
koiraseura	pikakivaari-klassikko	Koiraseura	koiraseura
hammaspeikkoseura	pikakivaari-klassikko	Hammaspeikkoseura	hammaspeikkoseura
dog	pikakivaari-klassikko	dog	dog
savu_seura	pikakivaari-klassikko	Savu Seura	savu_seura
omas	pikakivaari-klassikko	OMAS	omas
pelleseura	pikakivaari-klassikko	Pelleseura	pelleseura
yung_tallent	pikakivaari-klassikko	Yung Tallent	yung_tallent
aseharrastajien_yhtenaisyys	pikakivaari-klassikko	Aseharrastajien Yhtenäisyys	aseharrastajien_yhtenaisyys
tahtaysmestarit	pikakivaari-klassikko	Tähtäysmestarit	tahtaysmestarit
laukausryhma_aurora	pikakivaari-klassikko	Laukausryhmä Aurora	laukausryhma_aurora
ampumataito	pikakivaari-klassikko	Ampumataito	ampumataito
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member (user_id, competition_id, team_name) FROM stdin;
1	tarkka-ammunta_cup	poliisiseura
1	nopean_laukauksen_mestaruus	poliisiseura
1	moniottelu	poliisiseura
1	kansallinen_tahtayskilpailu	poliisiseura
1	kaupunkiammunta-challenge	poliisiseura
1	laukausmaraton	poliisiseura
1	vapaa-asekilpailu	poliisiseura
1	taitoluodikko-turnaus	poliisiseura
1	precision_pistol_cup	poliisiseura
1	tulevaisuuden_ampuja	poliisiseura
1	pikakivaari-klassikko	poliisiseura
2	tarkka-ammunta_cup	poliisiseura
2	nopean_laukauksen_mestaruus	poliisiseura
2	moniottelu	poliisiseura
2	kansallinen_tahtayskilpailu	poliisiseura
2	kaupunkiammunta-challenge	poliisiseura
2	laukausmaraton	poliisiseura
2	vapaa-asekilpailu	poliisiseura
2	taitoluodikko-turnaus	poliisiseura
2	precision_pistol_cup	poliisiseura
2	tulevaisuuden_ampuja	poliisiseura
2	pikakivaari-klassikko	poliisiseura
3	tarkka-ammunta_cup	poliisiseura
3	nopean_laukauksen_mestaruus	poliisiseura
3	moniottelu	poliisiseura
3	kansallinen_tahtayskilpailu	poliisiseura
3	kaupunkiammunta-challenge	poliisiseura
3	laukausmaraton	poliisiseura
3	vapaa-asekilpailu	poliisiseura
3	taitoluodikko-turnaus	poliisiseura
3	precision_pistol_cup	poliisiseura
3	tulevaisuuden_ampuja	poliisiseura
3	pikakivaari-klassikko	poliisiseura
4	tarkka-ammunta_cup	poliisiseura
4	nopean_laukauksen_mestaruus	poliisiseura
4	moniottelu	poliisiseura
4	kansallinen_tahtayskilpailu	poliisiseura
4	kaupunkiammunta-challenge	poliisiseura
4	laukausmaraton	poliisiseura
4	vapaa-asekilpailu	poliisiseura
4	taitoluodikko-turnaus	poliisiseura
4	precision_pistol_cup	poliisiseura
4	tulevaisuuden_ampuja	poliisiseura
4	pikakivaari-klassikko	poliisiseura
5	tarkka-ammunta_cup	koiraseura
5	nopean_laukauksen_mestaruus	koiraseura
5	moniottelu	koiraseura
5	kansallinen_tahtayskilpailu	koiraseura
5	kaupunkiammunta-challenge	koiraseura
5	laukausmaraton	koiraseura
5	vapaa-asekilpailu	koiraseura
5	taitoluodikko-turnaus	koiraseura
5	precision_pistol_cup	koiraseura
5	tulevaisuuden_ampuja	koiraseura
5	pikakivaari-klassikko	koiraseura
6	tarkka-ammunta_cup	koiraseura
6	nopean_laukauksen_mestaruus	koiraseura
6	moniottelu	koiraseura
6	kansallinen_tahtayskilpailu	koiraseura
6	kaupunkiammunta-challenge	koiraseura
6	laukausmaraton	koiraseura
6	vapaa-asekilpailu	koiraseura
6	taitoluodikko-turnaus	koiraseura
6	precision_pistol_cup	koiraseura
6	tulevaisuuden_ampuja	koiraseura
6	pikakivaari-klassikko	koiraseura
7	tarkka-ammunta_cup	koiraseura
7	nopean_laukauksen_mestaruus	koiraseura
7	moniottelu	koiraseura
7	kansallinen_tahtayskilpailu	koiraseura
7	kaupunkiammunta-challenge	koiraseura
7	laukausmaraton	koiraseura
7	vapaa-asekilpailu	koiraseura
7	taitoluodikko-turnaus	koiraseura
7	precision_pistol_cup	koiraseura
7	tulevaisuuden_ampuja	koiraseura
7	pikakivaari-klassikko	koiraseura
8	tarkka-ammunta_cup	koiraseura
8	nopean_laukauksen_mestaruus	koiraseura
8	moniottelu	koiraseura
8	kansallinen_tahtayskilpailu	koiraseura
8	kaupunkiammunta-challenge	koiraseura
8	laukausmaraton	koiraseura
8	vapaa-asekilpailu	koiraseura
8	taitoluodikko-turnaus	koiraseura
8	precision_pistol_cup	koiraseura
8	tulevaisuuden_ampuja	koiraseura
8	pikakivaari-klassikko	koiraseura
9	tarkka-ammunta_cup	hammaspeikkoseura
9	nopean_laukauksen_mestaruus	hammaspeikkoseura
9	moniottelu	hammaspeikkoseura
9	kansallinen_tahtayskilpailu	hammaspeikkoseura
9	kaupunkiammunta-challenge	hammaspeikkoseura
9	laukausmaraton	hammaspeikkoseura
9	vapaa-asekilpailu	hammaspeikkoseura
9	taitoluodikko-turnaus	hammaspeikkoseura
9	precision_pistol_cup	hammaspeikkoseura
9	tulevaisuuden_ampuja	hammaspeikkoseura
9	pikakivaari-klassikko	hammaspeikkoseura
10	tarkka-ammunta_cup	hammaspeikkoseura
10	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	moniottelu	hammaspeikkoseura
10	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	kaupunkiammunta-challenge	hammaspeikkoseura
10	laukausmaraton	hammaspeikkoseura
10	vapaa-asekilpailu	hammaspeikkoseura
10	taitoluodikko-turnaus	hammaspeikkoseura
10	precision_pistol_cup	hammaspeikkoseura
10	tulevaisuuden_ampuja	hammaspeikkoseura
10	pikakivaari-klassikko	hammaspeikkoseura
11	tarkka-ammunta_cup	hammaspeikkoseura
11	nopean_laukauksen_mestaruus	hammaspeikkoseura
11	moniottelu	hammaspeikkoseura
11	kansallinen_tahtayskilpailu	hammaspeikkoseura
11	kaupunkiammunta-challenge	hammaspeikkoseura
11	laukausmaraton	hammaspeikkoseura
11	vapaa-asekilpailu	hammaspeikkoseura
11	taitoluodikko-turnaus	hammaspeikkoseura
11	precision_pistol_cup	hammaspeikkoseura
11	tulevaisuuden_ampuja	hammaspeikkoseura
11	pikakivaari-klassikko	hammaspeikkoseura
12	tarkka-ammunta_cup	hammaspeikkoseura
12	nopean_laukauksen_mestaruus	hammaspeikkoseura
12	moniottelu	hammaspeikkoseura
12	kansallinen_tahtayskilpailu	hammaspeikkoseura
12	kaupunkiammunta-challenge	hammaspeikkoseura
12	laukausmaraton	hammaspeikkoseura
12	vapaa-asekilpailu	hammaspeikkoseura
12	taitoluodikko-turnaus	hammaspeikkoseura
12	precision_pistol_cup	hammaspeikkoseura
12	tulevaisuuden_ampuja	hammaspeikkoseura
12	pikakivaari-klassikko	hammaspeikkoseura
13	tarkka-ammunta_cup	dog
13	nopean_laukauksen_mestaruus	dog
13	moniottelu	dog
13	kansallinen_tahtayskilpailu	dog
13	kaupunkiammunta-challenge	dog
13	laukausmaraton	dog
13	vapaa-asekilpailu	dog
13	taitoluodikko-turnaus	dog
13	precision_pistol_cup	dog
13	tulevaisuuden_ampuja	dog
13	pikakivaari-klassikko	dog
14	tarkka-ammunta_cup	dog
14	nopean_laukauksen_mestaruus	dog
14	moniottelu	dog
14	kansallinen_tahtayskilpailu	dog
14	kaupunkiammunta-challenge	dog
14	laukausmaraton	dog
14	vapaa-asekilpailu	dog
14	taitoluodikko-turnaus	dog
14	precision_pistol_cup	dog
14	tulevaisuuden_ampuja	dog
14	pikakivaari-klassikko	dog
15	tarkka-ammunta_cup	dog
15	nopean_laukauksen_mestaruus	dog
15	moniottelu	dog
15	kansallinen_tahtayskilpailu	dog
15	kaupunkiammunta-challenge	dog
15	laukausmaraton	dog
15	vapaa-asekilpailu	dog
15	taitoluodikko-turnaus	dog
15	precision_pistol_cup	dog
15	tulevaisuuden_ampuja	dog
15	pikakivaari-klassikko	dog
16	tarkka-ammunta_cup	dog
16	nopean_laukauksen_mestaruus	dog
16	moniottelu	dog
16	kansallinen_tahtayskilpailu	dog
16	kaupunkiammunta-challenge	dog
16	laukausmaraton	dog
16	vapaa-asekilpailu	dog
16	taitoluodikko-turnaus	dog
16	precision_pistol_cup	dog
16	tulevaisuuden_ampuja	dog
16	pikakivaari-klassikko	dog
17	tarkka-ammunta_cup	dog
17	nopean_laukauksen_mestaruus	dog
17	moniottelu	dog
17	kansallinen_tahtayskilpailu	dog
17	kaupunkiammunta-challenge	dog
17	laukausmaraton	dog
17	vapaa-asekilpailu	dog
17	taitoluodikko-turnaus	dog
17	precision_pistol_cup	dog
17	tulevaisuuden_ampuja	dog
17	pikakivaari-klassikko	dog
18	tarkka-ammunta_cup	savu_seura
18	nopean_laukauksen_mestaruus	savu_seura
18	moniottelu	savu_seura
18	kansallinen_tahtayskilpailu	savu_seura
18	kaupunkiammunta-challenge	savu_seura
18	laukausmaraton	savu_seura
18	vapaa-asekilpailu	savu_seura
18	taitoluodikko-turnaus	savu_seura
18	precision_pistol_cup	savu_seura
18	tulevaisuuden_ampuja	savu_seura
18	pikakivaari-klassikko	savu_seura
19	tarkka-ammunta_cup	savu_seura
19	nopean_laukauksen_mestaruus	savu_seura
19	moniottelu	savu_seura
19	kansallinen_tahtayskilpailu	savu_seura
19	kaupunkiammunta-challenge	savu_seura
19	laukausmaraton	savu_seura
19	vapaa-asekilpailu	savu_seura
19	taitoluodikko-turnaus	savu_seura
19	precision_pistol_cup	savu_seura
19	tulevaisuuden_ampuja	savu_seura
19	pikakivaari-klassikko	savu_seura
20	tarkka-ammunta_cup	savu_seura
20	nopean_laukauksen_mestaruus	savu_seura
20	moniottelu	savu_seura
20	kansallinen_tahtayskilpailu	savu_seura
20	kaupunkiammunta-challenge	savu_seura
20	laukausmaraton	savu_seura
20	vapaa-asekilpailu	savu_seura
20	taitoluodikko-turnaus	savu_seura
20	precision_pistol_cup	savu_seura
20	tulevaisuuden_ampuja	savu_seura
20	pikakivaari-klassikko	savu_seura
21	tarkka-ammunta_cup	savu_seura
21	nopean_laukauksen_mestaruus	savu_seura
21	moniottelu	savu_seura
21	kansallinen_tahtayskilpailu	savu_seura
21	kaupunkiammunta-challenge	savu_seura
21	laukausmaraton	savu_seura
21	vapaa-asekilpailu	savu_seura
21	taitoluodikko-turnaus	savu_seura
21	precision_pistol_cup	savu_seura
21	tulevaisuuden_ampuja	savu_seura
21	pikakivaari-klassikko	savu_seura
22	tarkka-ammunta_cup	omas
22	nopean_laukauksen_mestaruus	omas
22	moniottelu	omas
22	kansallinen_tahtayskilpailu	omas
22	kaupunkiammunta-challenge	omas
22	laukausmaraton	omas
22	vapaa-asekilpailu	omas
22	taitoluodikko-turnaus	omas
22	precision_pistol_cup	omas
22	tulevaisuuden_ampuja	omas
22	pikakivaari-klassikko	omas
23	tarkka-ammunta_cup	omas
23	nopean_laukauksen_mestaruus	omas
23	moniottelu	omas
23	kansallinen_tahtayskilpailu	omas
23	kaupunkiammunta-challenge	omas
23	laukausmaraton	omas
23	vapaa-asekilpailu	omas
23	taitoluodikko-turnaus	omas
23	precision_pistol_cup	omas
23	tulevaisuuden_ampuja	omas
23	pikakivaari-klassikko	omas
24	tarkka-ammunta_cup	omas
24	nopean_laukauksen_mestaruus	omas
24	moniottelu	omas
24	kansallinen_tahtayskilpailu	omas
24	kaupunkiammunta-challenge	omas
24	laukausmaraton	omas
24	vapaa-asekilpailu	omas
24	taitoluodikko-turnaus	omas
24	precision_pistol_cup	omas
24	tulevaisuuden_ampuja	omas
24	pikakivaari-klassikko	omas
25	tarkka-ammunta_cup	omas
25	nopean_laukauksen_mestaruus	omas
25	moniottelu	omas
25	kansallinen_tahtayskilpailu	omas
25	kaupunkiammunta-challenge	omas
25	laukausmaraton	omas
25	vapaa-asekilpailu	omas
25	taitoluodikko-turnaus	omas
25	precision_pistol_cup	omas
25	tulevaisuuden_ampuja	omas
25	pikakivaari-klassikko	omas
26	tarkka-ammunta_cup	omas
26	nopean_laukauksen_mestaruus	omas
26	moniottelu	omas
26	kansallinen_tahtayskilpailu	omas
26	kaupunkiammunta-challenge	omas
26	laukausmaraton	omas
26	vapaa-asekilpailu	omas
26	taitoluodikko-turnaus	omas
26	precision_pistol_cup	omas
26	tulevaisuuden_ampuja	omas
26	pikakivaari-klassikko	omas
27	tarkka-ammunta_cup	pelleseura
27	nopean_laukauksen_mestaruus	pelleseura
27	moniottelu	pelleseura
27	kansallinen_tahtayskilpailu	pelleseura
27	kaupunkiammunta-challenge	pelleseura
27	laukausmaraton	pelleseura
27	vapaa-asekilpailu	pelleseura
27	taitoluodikko-turnaus	pelleseura
27	precision_pistol_cup	pelleseura
27	tulevaisuuden_ampuja	pelleseura
27	pikakivaari-klassikko	pelleseura
28	tarkka-ammunta_cup	pelleseura
28	nopean_laukauksen_mestaruus	pelleseura
28	moniottelu	pelleseura
28	kansallinen_tahtayskilpailu	pelleseura
28	kaupunkiammunta-challenge	pelleseura
28	laukausmaraton	pelleseura
28	vapaa-asekilpailu	pelleseura
28	taitoluodikko-turnaus	pelleseura
28	precision_pistol_cup	pelleseura
28	tulevaisuuden_ampuja	pelleseura
28	pikakivaari-klassikko	pelleseura
29	tarkka-ammunta_cup	pelleseura
29	nopean_laukauksen_mestaruus	pelleseura
29	moniottelu	pelleseura
29	kansallinen_tahtayskilpailu	pelleseura
29	kaupunkiammunta-challenge	pelleseura
29	laukausmaraton	pelleseura
29	vapaa-asekilpailu	pelleseura
29	taitoluodikko-turnaus	pelleseura
29	precision_pistol_cup	pelleseura
29	tulevaisuuden_ampuja	pelleseura
29	pikakivaari-klassikko	pelleseura
30	tarkka-ammunta_cup	pelleseura
30	nopean_laukauksen_mestaruus	pelleseura
30	moniottelu	pelleseura
30	kansallinen_tahtayskilpailu	pelleseura
30	kaupunkiammunta-challenge	pelleseura
30	laukausmaraton	pelleseura
30	vapaa-asekilpailu	pelleseura
30	taitoluodikko-turnaus	pelleseura
30	precision_pistol_cup	pelleseura
30	tulevaisuuden_ampuja	pelleseura
30	pikakivaari-klassikko	pelleseura
31	tarkka-ammunta_cup	pelleseura
31	nopean_laukauksen_mestaruus	pelleseura
31	moniottelu	pelleseura
31	kansallinen_tahtayskilpailu	pelleseura
31	kaupunkiammunta-challenge	pelleseura
31	laukausmaraton	pelleseura
31	vapaa-asekilpailu	pelleseura
31	taitoluodikko-turnaus	pelleseura
31	precision_pistol_cup	pelleseura
31	tulevaisuuden_ampuja	pelleseura
31	pikakivaari-klassikko	pelleseura
32	tarkka-ammunta_cup	yung_tallent
32	nopean_laukauksen_mestaruus	yung_tallent
32	moniottelu	yung_tallent
32	kansallinen_tahtayskilpailu	yung_tallent
32	kaupunkiammunta-challenge	yung_tallent
32	laukausmaraton	yung_tallent
32	vapaa-asekilpailu	yung_tallent
32	taitoluodikko-turnaus	yung_tallent
32	precision_pistol_cup	yung_tallent
32	tulevaisuuden_ampuja	yung_tallent
32	pikakivaari-klassikko	yung_tallent
33	tarkka-ammunta_cup	yung_tallent
33	nopean_laukauksen_mestaruus	yung_tallent
33	moniottelu	yung_tallent
33	kansallinen_tahtayskilpailu	yung_tallent
33	kaupunkiammunta-challenge	yung_tallent
33	laukausmaraton	yung_tallent
33	vapaa-asekilpailu	yung_tallent
33	taitoluodikko-turnaus	yung_tallent
33	precision_pistol_cup	yung_tallent
33	tulevaisuuden_ampuja	yung_tallent
33	pikakivaari-klassikko	yung_tallent
34	tarkka-ammunta_cup	yung_tallent
34	nopean_laukauksen_mestaruus	yung_tallent
34	moniottelu	yung_tallent
34	kansallinen_tahtayskilpailu	yung_tallent
34	kaupunkiammunta-challenge	yung_tallent
34	laukausmaraton	yung_tallent
34	vapaa-asekilpailu	yung_tallent
34	taitoluodikko-turnaus	yung_tallent
34	precision_pistol_cup	yung_tallent
34	tulevaisuuden_ampuja	yung_tallent
34	pikakivaari-klassikko	yung_tallent
35	tarkka-ammunta_cup	yung_tallent
35	nopean_laukauksen_mestaruus	yung_tallent
35	moniottelu	yung_tallent
35	kansallinen_tahtayskilpailu	yung_tallent
35	kaupunkiammunta-challenge	yung_tallent
35	laukausmaraton	yung_tallent
35	vapaa-asekilpailu	yung_tallent
35	taitoluodikko-turnaus	yung_tallent
35	precision_pistol_cup	yung_tallent
35	tulevaisuuden_ampuja	yung_tallent
35	pikakivaari-klassikko	yung_tallent
36	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
36	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
36	moniottelu	aseharrastajien_yhtenaisyys
36	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
36	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
36	laukausmaraton	aseharrastajien_yhtenaisyys
36	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
36	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
36	precision_pistol_cup	aseharrastajien_yhtenaisyys
36	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
36	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
37	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
37	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
37	moniottelu	aseharrastajien_yhtenaisyys
37	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
37	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
37	laukausmaraton	aseharrastajien_yhtenaisyys
37	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
37	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
37	precision_pistol_cup	aseharrastajien_yhtenaisyys
37	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
37	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
38	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
38	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
38	moniottelu	aseharrastajien_yhtenaisyys
38	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
38	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
38	laukausmaraton	aseharrastajien_yhtenaisyys
38	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
38	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
38	precision_pistol_cup	aseharrastajien_yhtenaisyys
38	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
38	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
39	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
39	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
39	moniottelu	aseharrastajien_yhtenaisyys
39	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
39	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
39	laukausmaraton	aseharrastajien_yhtenaisyys
39	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
39	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
39	precision_pistol_cup	aseharrastajien_yhtenaisyys
39	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
39	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
40	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
40	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
40	moniottelu	aseharrastajien_yhtenaisyys
40	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
40	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
40	laukausmaraton	aseharrastajien_yhtenaisyys
40	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
40	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
40	precision_pistol_cup	aseharrastajien_yhtenaisyys
40	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
40	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
41	tarkka-ammunta_cup	tahtaysmestarit
41	nopean_laukauksen_mestaruus	tahtaysmestarit
41	moniottelu	tahtaysmestarit
41	kansallinen_tahtayskilpailu	tahtaysmestarit
41	kaupunkiammunta-challenge	tahtaysmestarit
41	laukausmaraton	tahtaysmestarit
41	vapaa-asekilpailu	tahtaysmestarit
41	taitoluodikko-turnaus	tahtaysmestarit
41	precision_pistol_cup	tahtaysmestarit
41	tulevaisuuden_ampuja	tahtaysmestarit
41	pikakivaari-klassikko	tahtaysmestarit
42	tarkka-ammunta_cup	tahtaysmestarit
42	nopean_laukauksen_mestaruus	tahtaysmestarit
42	moniottelu	tahtaysmestarit
42	kansallinen_tahtayskilpailu	tahtaysmestarit
42	kaupunkiammunta-challenge	tahtaysmestarit
42	laukausmaraton	tahtaysmestarit
42	vapaa-asekilpailu	tahtaysmestarit
42	taitoluodikko-turnaus	tahtaysmestarit
42	precision_pistol_cup	tahtaysmestarit
42	tulevaisuuden_ampuja	tahtaysmestarit
42	pikakivaari-klassikko	tahtaysmestarit
43	tarkka-ammunta_cup	tahtaysmestarit
43	nopean_laukauksen_mestaruus	tahtaysmestarit
43	moniottelu	tahtaysmestarit
43	kansallinen_tahtayskilpailu	tahtaysmestarit
43	kaupunkiammunta-challenge	tahtaysmestarit
43	laukausmaraton	tahtaysmestarit
43	vapaa-asekilpailu	tahtaysmestarit
43	taitoluodikko-turnaus	tahtaysmestarit
43	precision_pistol_cup	tahtaysmestarit
43	tulevaisuuden_ampuja	tahtaysmestarit
43	pikakivaari-klassikko	tahtaysmestarit
44	tarkka-ammunta_cup	laukausryhma_aurora
44	nopean_laukauksen_mestaruus	laukausryhma_aurora
44	moniottelu	laukausryhma_aurora
44	kansallinen_tahtayskilpailu	laukausryhma_aurora
44	kaupunkiammunta-challenge	laukausryhma_aurora
44	laukausmaraton	laukausryhma_aurora
44	vapaa-asekilpailu	laukausryhma_aurora
44	taitoluodikko-turnaus	laukausryhma_aurora
44	precision_pistol_cup	laukausryhma_aurora
44	tulevaisuuden_ampuja	laukausryhma_aurora
44	pikakivaari-klassikko	laukausryhma_aurora
45	tarkka-ammunta_cup	laukausryhma_aurora
45	nopean_laukauksen_mestaruus	laukausryhma_aurora
45	moniottelu	laukausryhma_aurora
45	kansallinen_tahtayskilpailu	laukausryhma_aurora
45	kaupunkiammunta-challenge	laukausryhma_aurora
45	laukausmaraton	laukausryhma_aurora
45	vapaa-asekilpailu	laukausryhma_aurora
45	taitoluodikko-turnaus	laukausryhma_aurora
45	precision_pistol_cup	laukausryhma_aurora
45	tulevaisuuden_ampuja	laukausryhma_aurora
45	pikakivaari-klassikko	laukausryhma_aurora
46	tarkka-ammunta_cup	laukausryhma_aurora
46	nopean_laukauksen_mestaruus	laukausryhma_aurora
46	moniottelu	laukausryhma_aurora
46	kansallinen_tahtayskilpailu	laukausryhma_aurora
46	kaupunkiammunta-challenge	laukausryhma_aurora
46	laukausmaraton	laukausryhma_aurora
46	vapaa-asekilpailu	laukausryhma_aurora
46	taitoluodikko-turnaus	laukausryhma_aurora
46	precision_pistol_cup	laukausryhma_aurora
46	tulevaisuuden_ampuja	laukausryhma_aurora
46	pikakivaari-klassikko	laukausryhma_aurora
47	tarkka-ammunta_cup	laukausryhma_aurora
47	nopean_laukauksen_mestaruus	laukausryhma_aurora
47	moniottelu	laukausryhma_aurora
47	kansallinen_tahtayskilpailu	laukausryhma_aurora
47	kaupunkiammunta-challenge	laukausryhma_aurora
47	laukausmaraton	laukausryhma_aurora
47	vapaa-asekilpailu	laukausryhma_aurora
47	taitoluodikko-turnaus	laukausryhma_aurora
47	precision_pistol_cup	laukausryhma_aurora
47	tulevaisuuden_ampuja	laukausryhma_aurora
47	pikakivaari-klassikko	laukausryhma_aurora
48	tarkka-ammunta_cup	laukausryhma_aurora
48	nopean_laukauksen_mestaruus	laukausryhma_aurora
48	moniottelu	laukausryhma_aurora
48	kansallinen_tahtayskilpailu	laukausryhma_aurora
48	kaupunkiammunta-challenge	laukausryhma_aurora
48	laukausmaraton	laukausryhma_aurora
48	vapaa-asekilpailu	laukausryhma_aurora
48	taitoluodikko-turnaus	laukausryhma_aurora
48	precision_pistol_cup	laukausryhma_aurora
48	tulevaisuuden_ampuja	laukausryhma_aurora
48	pikakivaari-klassikko	laukausryhma_aurora
49	tarkka-ammunta_cup	ampumataito
49	nopean_laukauksen_mestaruus	ampumataito
49	moniottelu	ampumataito
49	kansallinen_tahtayskilpailu	ampumataito
49	kaupunkiammunta-challenge	ampumataito
49	laukausmaraton	ampumataito
49	vapaa-asekilpailu	ampumataito
49	taitoluodikko-turnaus	ampumataito
49	precision_pistol_cup	ampumataito
49	tulevaisuuden_ampuja	ampumataito
49	pikakivaari-klassikko	ampumataito
50	tarkka-ammunta_cup	ampumataito
50	nopean_laukauksen_mestaruus	ampumataito
50	moniottelu	ampumataito
50	kansallinen_tahtayskilpailu	ampumataito
50	kaupunkiammunta-challenge	ampumataito
50	laukausmaraton	ampumataito
50	vapaa-asekilpailu	ampumataito
50	taitoluodikko-turnaus	ampumataito
50	precision_pistol_cup	ampumataito
50	tulevaisuuden_ampuja	ampumataito
50	pikakivaari-klassikko	ampumataito
51	tarkka-ammunta_cup	ampumataito
51	nopean_laukauksen_mestaruus	ampumataito
51	moniottelu	ampumataito
51	kansallinen_tahtayskilpailu	ampumataito
51	kaupunkiammunta-challenge	ampumataito
51	laukausmaraton	ampumataito
51	vapaa-asekilpailu	ampumataito
51	taitoluodikko-turnaus	ampumataito
51	precision_pistol_cup	ampumataito
51	tulevaisuuden_ampuja	ampumataito
51	pikakivaari-klassikko	ampumataito
52	tarkka-ammunta_cup	ampumataito
52	nopean_laukauksen_mestaruus	ampumataito
52	moniottelu	ampumataito
52	kansallinen_tahtayskilpailu	ampumataito
52	kaupunkiammunta-challenge	ampumataito
52	laukausmaraton	ampumataito
52	vapaa-asekilpailu	ampumataito
52	taitoluodikko-turnaus	ampumataito
52	precision_pistol_cup	ampumataito
52	tulevaisuuden_ampuja	ampumataito
52	pikakivaari-klassikko	ampumataito
53	tarkka-ammunta_cup	ampumataito
53	nopean_laukauksen_mestaruus	ampumataito
53	moniottelu	ampumataito
53	kansallinen_tahtayskilpailu	ampumataito
53	kaupunkiammunta-challenge	ampumataito
53	laukausmaraton	ampumataito
53	vapaa-asekilpailu	ampumataito
53	taitoluodikko-turnaus	ampumataito
53	precision_pistol_cup	ampumataito
53	tulevaisuuden_ampuja	ampumataito
53	pikakivaari-klassikko	ampumataito
1	kesan_ampujaiset	poliisiseura
1	talvi_pistooli	poliisiseura
1	tarkkuuslaukaus-festivaali	poliisiseura
1	kivaarikilpailujen_huipennus	poliisiseura
1	polaris-ampumaharjoitus	poliisiseura
1	aamunkoiton_tahtays	poliisiseura
1	nordic_sharpshooters_cup	poliisiseura
1	taivaanranta-tulitus	poliisiseura
1	lumivyory-ammunta	poliisiseura
2	kesan_ampujaiset	poliisiseura
2	talvi_pistooli	poliisiseura
2	tarkkuuslaukaus-festivaali	poliisiseura
2	kivaarikilpailujen_huipennus	poliisiseura
2	polaris-ampumaharjoitus	poliisiseura
2	aamunkoiton_tahtays	poliisiseura
2	nordic_sharpshooters_cup	poliisiseura
2	taivaanranta-tulitus	poliisiseura
2	lumivyory-ammunta	poliisiseura
3	kesan_ampujaiset	poliisiseura
3	talvi_pistooli	poliisiseura
3	tarkkuuslaukaus-festivaali	poliisiseura
3	kivaarikilpailujen_huipennus	poliisiseura
3	polaris-ampumaharjoitus	poliisiseura
3	aamunkoiton_tahtays	poliisiseura
3	nordic_sharpshooters_cup	poliisiseura
3	taivaanranta-tulitus	poliisiseura
3	lumivyory-ammunta	poliisiseura
4	kesan_ampujaiset	poliisiseura
4	talvi_pistooli	poliisiseura
4	tarkkuuslaukaus-festivaali	poliisiseura
4	kivaarikilpailujen_huipennus	poliisiseura
4	polaris-ampumaharjoitus	poliisiseura
4	aamunkoiton_tahtays	poliisiseura
4	nordic_sharpshooters_cup	poliisiseura
4	taivaanranta-tulitus	poliisiseura
4	lumivyory-ammunta	poliisiseura
5	kesan_ampujaiset	koiraseura
5	talvi_pistooli	koiraseura
5	tarkkuuslaukaus-festivaali	koiraseura
5	kivaarikilpailujen_huipennus	koiraseura
5	polaris-ampumaharjoitus	koiraseura
5	aamunkoiton_tahtays	koiraseura
5	nordic_sharpshooters_cup	koiraseura
5	taivaanranta-tulitus	koiraseura
5	lumivyory-ammunta	koiraseura
6	kesan_ampujaiset	koiraseura
6	talvi_pistooli	koiraseura
6	tarkkuuslaukaus-festivaali	koiraseura
6	kivaarikilpailujen_huipennus	koiraseura
6	polaris-ampumaharjoitus	koiraseura
6	aamunkoiton_tahtays	koiraseura
6	nordic_sharpshooters_cup	koiraseura
6	taivaanranta-tulitus	koiraseura
6	lumivyory-ammunta	koiraseura
7	kesan_ampujaiset	koiraseura
7	talvi_pistooli	koiraseura
7	tarkkuuslaukaus-festivaali	koiraseura
7	kivaarikilpailujen_huipennus	koiraseura
7	polaris-ampumaharjoitus	koiraseura
7	aamunkoiton_tahtays	koiraseura
7	nordic_sharpshooters_cup	koiraseura
7	taivaanranta-tulitus	koiraseura
7	lumivyory-ammunta	koiraseura
8	kesan_ampujaiset	koiraseura
8	talvi_pistooli	koiraseura
8	tarkkuuslaukaus-festivaali	koiraseura
8	kivaarikilpailujen_huipennus	koiraseura
8	polaris-ampumaharjoitus	koiraseura
8	aamunkoiton_tahtays	koiraseura
8	nordic_sharpshooters_cup	koiraseura
8	taivaanranta-tulitus	koiraseura
8	lumivyory-ammunta	koiraseura
9	kesan_ampujaiset	hammaspeikkoseura
9	talvi_pistooli	hammaspeikkoseura
9	tarkkuuslaukaus-festivaali	hammaspeikkoseura
9	kivaarikilpailujen_huipennus	hammaspeikkoseura
9	polaris-ampumaharjoitus	hammaspeikkoseura
9	aamunkoiton_tahtays	hammaspeikkoseura
9	nordic_sharpshooters_cup	hammaspeikkoseura
9	taivaanranta-tulitus	hammaspeikkoseura
9	lumivyory-ammunta	hammaspeikkoseura
10	kesan_ampujaiset	hammaspeikkoseura
10	talvi_pistooli	hammaspeikkoseura
10	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	polaris-ampumaharjoitus	hammaspeikkoseura
10	aamunkoiton_tahtays	hammaspeikkoseura
10	nordic_sharpshooters_cup	hammaspeikkoseura
10	taivaanranta-tulitus	hammaspeikkoseura
10	lumivyory-ammunta	hammaspeikkoseura
11	kesan_ampujaiset	hammaspeikkoseura
11	talvi_pistooli	hammaspeikkoseura
11	tarkkuuslaukaus-festivaali	hammaspeikkoseura
11	kivaarikilpailujen_huipennus	hammaspeikkoseura
11	polaris-ampumaharjoitus	hammaspeikkoseura
11	aamunkoiton_tahtays	hammaspeikkoseura
11	nordic_sharpshooters_cup	hammaspeikkoseura
11	taivaanranta-tulitus	hammaspeikkoseura
11	lumivyory-ammunta	hammaspeikkoseura
12	kesan_ampujaiset	hammaspeikkoseura
12	talvi_pistooli	hammaspeikkoseura
12	tarkkuuslaukaus-festivaali	hammaspeikkoseura
12	kivaarikilpailujen_huipennus	hammaspeikkoseura
12	polaris-ampumaharjoitus	hammaspeikkoseura
12	aamunkoiton_tahtays	hammaspeikkoseura
12	nordic_sharpshooters_cup	hammaspeikkoseura
12	taivaanranta-tulitus	hammaspeikkoseura
12	lumivyory-ammunta	hammaspeikkoseura
13	kesan_ampujaiset	dog
13	talvi_pistooli	dog
13	tarkkuuslaukaus-festivaali	dog
13	kivaarikilpailujen_huipennus	dog
13	polaris-ampumaharjoitus	dog
13	aamunkoiton_tahtays	dog
13	nordic_sharpshooters_cup	dog
13	taivaanranta-tulitus	dog
13	lumivyory-ammunta	dog
14	kesan_ampujaiset	dog
14	talvi_pistooli	dog
14	tarkkuuslaukaus-festivaali	dog
14	kivaarikilpailujen_huipennus	dog
14	polaris-ampumaharjoitus	dog
14	aamunkoiton_tahtays	dog
14	nordic_sharpshooters_cup	dog
14	taivaanranta-tulitus	dog
14	lumivyory-ammunta	dog
15	kesan_ampujaiset	dog
15	talvi_pistooli	dog
15	tarkkuuslaukaus-festivaali	dog
15	kivaarikilpailujen_huipennus	dog
15	polaris-ampumaharjoitus	dog
15	aamunkoiton_tahtays	dog
15	nordic_sharpshooters_cup	dog
15	taivaanranta-tulitus	dog
15	lumivyory-ammunta	dog
16	kesan_ampujaiset	dog
16	talvi_pistooli	dog
16	tarkkuuslaukaus-festivaali	dog
16	kivaarikilpailujen_huipennus	dog
16	polaris-ampumaharjoitus	dog
16	aamunkoiton_tahtays	dog
16	nordic_sharpshooters_cup	dog
16	taivaanranta-tulitus	dog
16	lumivyory-ammunta	dog
17	kesan_ampujaiset	dog
17	talvi_pistooli	dog
17	tarkkuuslaukaus-festivaali	dog
17	kivaarikilpailujen_huipennus	dog
17	polaris-ampumaharjoitus	dog
17	aamunkoiton_tahtays	dog
17	nordic_sharpshooters_cup	dog
17	taivaanranta-tulitus	dog
17	lumivyory-ammunta	dog
18	kesan_ampujaiset	savu_seura
18	talvi_pistooli	savu_seura
18	tarkkuuslaukaus-festivaali	savu_seura
18	kivaarikilpailujen_huipennus	savu_seura
18	polaris-ampumaharjoitus	savu_seura
18	aamunkoiton_tahtays	savu_seura
18	nordic_sharpshooters_cup	savu_seura
18	taivaanranta-tulitus	savu_seura
18	lumivyory-ammunta	savu_seura
19	kesan_ampujaiset	savu_seura
19	talvi_pistooli	savu_seura
19	tarkkuuslaukaus-festivaali	savu_seura
19	kivaarikilpailujen_huipennus	savu_seura
19	polaris-ampumaharjoitus	savu_seura
19	aamunkoiton_tahtays	savu_seura
19	nordic_sharpshooters_cup	savu_seura
19	taivaanranta-tulitus	savu_seura
19	lumivyory-ammunta	savu_seura
20	kesan_ampujaiset	savu_seura
20	talvi_pistooli	savu_seura
20	tarkkuuslaukaus-festivaali	savu_seura
20	kivaarikilpailujen_huipennus	savu_seura
20	polaris-ampumaharjoitus	savu_seura
20	aamunkoiton_tahtays	savu_seura
20	nordic_sharpshooters_cup	savu_seura
20	taivaanranta-tulitus	savu_seura
20	lumivyory-ammunta	savu_seura
21	kesan_ampujaiset	savu_seura
21	talvi_pistooli	savu_seura
21	tarkkuuslaukaus-festivaali	savu_seura
21	kivaarikilpailujen_huipennus	savu_seura
21	polaris-ampumaharjoitus	savu_seura
21	aamunkoiton_tahtays	savu_seura
21	nordic_sharpshooters_cup	savu_seura
21	taivaanranta-tulitus	savu_seura
21	lumivyory-ammunta	savu_seura
22	kesan_ampujaiset	omas
22	talvi_pistooli	omas
22	tarkkuuslaukaus-festivaali	omas
22	kivaarikilpailujen_huipennus	omas
22	polaris-ampumaharjoitus	omas
22	aamunkoiton_tahtays	omas
22	nordic_sharpshooters_cup	omas
22	taivaanranta-tulitus	omas
22	lumivyory-ammunta	omas
23	kesan_ampujaiset	omas
23	talvi_pistooli	omas
23	tarkkuuslaukaus-festivaali	omas
23	kivaarikilpailujen_huipennus	omas
23	polaris-ampumaharjoitus	omas
23	aamunkoiton_tahtays	omas
23	nordic_sharpshooters_cup	omas
23	taivaanranta-tulitus	omas
23	lumivyory-ammunta	omas
24	kesan_ampujaiset	omas
24	talvi_pistooli	omas
24	tarkkuuslaukaus-festivaali	omas
24	kivaarikilpailujen_huipennus	omas
24	polaris-ampumaharjoitus	omas
24	aamunkoiton_tahtays	omas
24	nordic_sharpshooters_cup	omas
24	taivaanranta-tulitus	omas
24	lumivyory-ammunta	omas
25	kesan_ampujaiset	omas
25	talvi_pistooli	omas
25	tarkkuuslaukaus-festivaali	omas
25	kivaarikilpailujen_huipennus	omas
25	polaris-ampumaharjoitus	omas
25	aamunkoiton_tahtays	omas
25	nordic_sharpshooters_cup	omas
25	taivaanranta-tulitus	omas
25	lumivyory-ammunta	omas
26	kesan_ampujaiset	omas
26	talvi_pistooli	omas
26	tarkkuuslaukaus-festivaali	omas
26	kivaarikilpailujen_huipennus	omas
26	polaris-ampumaharjoitus	omas
26	aamunkoiton_tahtays	omas
26	nordic_sharpshooters_cup	omas
26	taivaanranta-tulitus	omas
26	lumivyory-ammunta	omas
27	kesan_ampujaiset	pelleseura
27	talvi_pistooli	pelleseura
27	tarkkuuslaukaus-festivaali	pelleseura
27	kivaarikilpailujen_huipennus	pelleseura
27	polaris-ampumaharjoitus	pelleseura
27	aamunkoiton_tahtays	pelleseura
27	nordic_sharpshooters_cup	pelleseura
27	taivaanranta-tulitus	pelleseura
27	lumivyory-ammunta	pelleseura
28	kesan_ampujaiset	pelleseura
28	talvi_pistooli	pelleseura
28	tarkkuuslaukaus-festivaali	pelleseura
28	kivaarikilpailujen_huipennus	pelleseura
28	polaris-ampumaharjoitus	pelleseura
28	aamunkoiton_tahtays	pelleseura
28	nordic_sharpshooters_cup	pelleseura
28	taivaanranta-tulitus	pelleseura
28	lumivyory-ammunta	pelleseura
29	kesan_ampujaiset	pelleseura
29	talvi_pistooli	pelleseura
29	tarkkuuslaukaus-festivaali	pelleseura
29	kivaarikilpailujen_huipennus	pelleseura
29	polaris-ampumaharjoitus	pelleseura
29	aamunkoiton_tahtays	pelleseura
29	nordic_sharpshooters_cup	pelleseura
29	taivaanranta-tulitus	pelleseura
29	lumivyory-ammunta	pelleseura
30	kesan_ampujaiset	pelleseura
30	talvi_pistooli	pelleseura
30	tarkkuuslaukaus-festivaali	pelleseura
30	kivaarikilpailujen_huipennus	pelleseura
30	polaris-ampumaharjoitus	pelleseura
30	aamunkoiton_tahtays	pelleseura
30	nordic_sharpshooters_cup	pelleseura
30	taivaanranta-tulitus	pelleseura
30	lumivyory-ammunta	pelleseura
31	kesan_ampujaiset	pelleseura
31	talvi_pistooli	pelleseura
31	tarkkuuslaukaus-festivaali	pelleseura
31	kivaarikilpailujen_huipennus	pelleseura
31	polaris-ampumaharjoitus	pelleseura
31	aamunkoiton_tahtays	pelleseura
31	nordic_sharpshooters_cup	pelleseura
31	taivaanranta-tulitus	pelleseura
31	lumivyory-ammunta	pelleseura
32	kesan_ampujaiset	yung_tallent
32	talvi_pistooli	yung_tallent
32	tarkkuuslaukaus-festivaali	yung_tallent
32	kivaarikilpailujen_huipennus	yung_tallent
32	polaris-ampumaharjoitus	yung_tallent
32	aamunkoiton_tahtays	yung_tallent
32	nordic_sharpshooters_cup	yung_tallent
32	taivaanranta-tulitus	yung_tallent
32	lumivyory-ammunta	yung_tallent
33	kesan_ampujaiset	yung_tallent
33	talvi_pistooli	yung_tallent
33	tarkkuuslaukaus-festivaali	yung_tallent
33	kivaarikilpailujen_huipennus	yung_tallent
33	polaris-ampumaharjoitus	yung_tallent
33	aamunkoiton_tahtays	yung_tallent
33	nordic_sharpshooters_cup	yung_tallent
33	taivaanranta-tulitus	yung_tallent
33	lumivyory-ammunta	yung_tallent
34	kesan_ampujaiset	yung_tallent
34	talvi_pistooli	yung_tallent
34	tarkkuuslaukaus-festivaali	yung_tallent
34	kivaarikilpailujen_huipennus	yung_tallent
34	polaris-ampumaharjoitus	yung_tallent
34	aamunkoiton_tahtays	yung_tallent
34	nordic_sharpshooters_cup	yung_tallent
34	taivaanranta-tulitus	yung_tallent
34	lumivyory-ammunta	yung_tallent
35	kesan_ampujaiset	yung_tallent
35	talvi_pistooli	yung_tallent
35	tarkkuuslaukaus-festivaali	yung_tallent
35	kivaarikilpailujen_huipennus	yung_tallent
35	polaris-ampumaharjoitus	yung_tallent
35	aamunkoiton_tahtays	yung_tallent
35	nordic_sharpshooters_cup	yung_tallent
35	taivaanranta-tulitus	yung_tallent
35	lumivyory-ammunta	yung_tallent
36	kesan_ampujaiset	aseharrastajien_yhtenaisyys
36	talvi_pistooli	aseharrastajien_yhtenaisyys
36	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
36	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
36	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
36	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
36	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
36	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
36	lumivyory-ammunta	aseharrastajien_yhtenaisyys
37	kesan_ampujaiset	aseharrastajien_yhtenaisyys
37	talvi_pistooli	aseharrastajien_yhtenaisyys
37	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
37	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
37	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
37	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
37	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
37	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
37	lumivyory-ammunta	aseharrastajien_yhtenaisyys
38	kesan_ampujaiset	aseharrastajien_yhtenaisyys
38	talvi_pistooli	aseharrastajien_yhtenaisyys
38	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
38	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
38	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
38	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
38	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
38	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
38	lumivyory-ammunta	aseharrastajien_yhtenaisyys
39	kesan_ampujaiset	aseharrastajien_yhtenaisyys
39	talvi_pistooli	aseharrastajien_yhtenaisyys
39	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
39	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
39	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
39	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
39	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
39	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
39	lumivyory-ammunta	aseharrastajien_yhtenaisyys
40	kesan_ampujaiset	aseharrastajien_yhtenaisyys
40	talvi_pistooli	aseharrastajien_yhtenaisyys
40	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
40	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
40	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
40	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
40	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
40	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
40	lumivyory-ammunta	aseharrastajien_yhtenaisyys
41	kesan_ampujaiset	tahtaysmestarit
41	talvi_pistooli	tahtaysmestarit
41	tarkkuuslaukaus-festivaali	tahtaysmestarit
41	kivaarikilpailujen_huipennus	tahtaysmestarit
41	polaris-ampumaharjoitus	tahtaysmestarit
41	aamunkoiton_tahtays	tahtaysmestarit
41	nordic_sharpshooters_cup	tahtaysmestarit
41	taivaanranta-tulitus	tahtaysmestarit
41	lumivyory-ammunta	tahtaysmestarit
42	kesan_ampujaiset	tahtaysmestarit
42	talvi_pistooli	tahtaysmestarit
42	tarkkuuslaukaus-festivaali	tahtaysmestarit
42	kivaarikilpailujen_huipennus	tahtaysmestarit
42	polaris-ampumaharjoitus	tahtaysmestarit
42	aamunkoiton_tahtays	tahtaysmestarit
42	nordic_sharpshooters_cup	tahtaysmestarit
42	taivaanranta-tulitus	tahtaysmestarit
42	lumivyory-ammunta	tahtaysmestarit
43	kesan_ampujaiset	tahtaysmestarit
43	talvi_pistooli	tahtaysmestarit
43	tarkkuuslaukaus-festivaali	tahtaysmestarit
43	kivaarikilpailujen_huipennus	tahtaysmestarit
43	polaris-ampumaharjoitus	tahtaysmestarit
43	aamunkoiton_tahtays	tahtaysmestarit
43	nordic_sharpshooters_cup	tahtaysmestarit
43	taivaanranta-tulitus	tahtaysmestarit
43	lumivyory-ammunta	tahtaysmestarit
44	kesan_ampujaiset	laukausryhma_aurora
44	talvi_pistooli	laukausryhma_aurora
44	tarkkuuslaukaus-festivaali	laukausryhma_aurora
44	kivaarikilpailujen_huipennus	laukausryhma_aurora
44	polaris-ampumaharjoitus	laukausryhma_aurora
44	aamunkoiton_tahtays	laukausryhma_aurora
44	nordic_sharpshooters_cup	laukausryhma_aurora
44	taivaanranta-tulitus	laukausryhma_aurora
44	lumivyory-ammunta	laukausryhma_aurora
45	kesan_ampujaiset	laukausryhma_aurora
45	talvi_pistooli	laukausryhma_aurora
45	tarkkuuslaukaus-festivaali	laukausryhma_aurora
45	kivaarikilpailujen_huipennus	laukausryhma_aurora
45	polaris-ampumaharjoitus	laukausryhma_aurora
45	aamunkoiton_tahtays	laukausryhma_aurora
45	nordic_sharpshooters_cup	laukausryhma_aurora
45	taivaanranta-tulitus	laukausryhma_aurora
45	lumivyory-ammunta	laukausryhma_aurora
46	kesan_ampujaiset	laukausryhma_aurora
46	talvi_pistooli	laukausryhma_aurora
46	tarkkuuslaukaus-festivaali	laukausryhma_aurora
46	kivaarikilpailujen_huipennus	laukausryhma_aurora
46	polaris-ampumaharjoitus	laukausryhma_aurora
46	aamunkoiton_tahtays	laukausryhma_aurora
46	nordic_sharpshooters_cup	laukausryhma_aurora
46	taivaanranta-tulitus	laukausryhma_aurora
46	lumivyory-ammunta	laukausryhma_aurora
47	kesan_ampujaiset	laukausryhma_aurora
47	talvi_pistooli	laukausryhma_aurora
47	tarkkuuslaukaus-festivaali	laukausryhma_aurora
47	kivaarikilpailujen_huipennus	laukausryhma_aurora
47	polaris-ampumaharjoitus	laukausryhma_aurora
47	aamunkoiton_tahtays	laukausryhma_aurora
47	nordic_sharpshooters_cup	laukausryhma_aurora
47	taivaanranta-tulitus	laukausryhma_aurora
47	lumivyory-ammunta	laukausryhma_aurora
48	kesan_ampujaiset	laukausryhma_aurora
48	talvi_pistooli	laukausryhma_aurora
48	tarkkuuslaukaus-festivaali	laukausryhma_aurora
48	kivaarikilpailujen_huipennus	laukausryhma_aurora
48	polaris-ampumaharjoitus	laukausryhma_aurora
48	aamunkoiton_tahtays	laukausryhma_aurora
48	nordic_sharpshooters_cup	laukausryhma_aurora
48	taivaanranta-tulitus	laukausryhma_aurora
48	lumivyory-ammunta	laukausryhma_aurora
49	kesan_ampujaiset	ampumataito
49	talvi_pistooli	ampumataito
49	tarkkuuslaukaus-festivaali	ampumataito
49	kivaarikilpailujen_huipennus	ampumataito
49	polaris-ampumaharjoitus	ampumataito
49	aamunkoiton_tahtays	ampumataito
49	nordic_sharpshooters_cup	ampumataito
49	taivaanranta-tulitus	ampumataito
49	lumivyory-ammunta	ampumataito
50	kesan_ampujaiset	ampumataito
50	talvi_pistooli	ampumataito
50	tarkkuuslaukaus-festivaali	ampumataito
50	kivaarikilpailujen_huipennus	ampumataito
50	polaris-ampumaharjoitus	ampumataito
50	aamunkoiton_tahtays	ampumataito
50	nordic_sharpshooters_cup	ampumataito
50	taivaanranta-tulitus	ampumataito
50	lumivyory-ammunta	ampumataito
51	kesan_ampujaiset	ampumataito
51	talvi_pistooli	ampumataito
51	tarkkuuslaukaus-festivaali	ampumataito
51	kivaarikilpailujen_huipennus	ampumataito
51	polaris-ampumaharjoitus	ampumataito
51	aamunkoiton_tahtays	ampumataito
51	nordic_sharpshooters_cup	ampumataito
51	taivaanranta-tulitus	ampumataito
51	lumivyory-ammunta	ampumataito
52	kesan_ampujaiset	ampumataito
52	talvi_pistooli	ampumataito
52	tarkkuuslaukaus-festivaali	ampumataito
52	kivaarikilpailujen_huipennus	ampumataito
52	polaris-ampumaharjoitus	ampumataito
52	aamunkoiton_tahtays	ampumataito
52	nordic_sharpshooters_cup	ampumataito
52	taivaanranta-tulitus	ampumataito
52	lumivyory-ammunta	ampumataito
53	kesan_ampujaiset	ampumataito
53	talvi_pistooli	ampumataito
53	tarkkuuslaukaus-festivaali	ampumataito
53	kivaarikilpailujen_huipennus	ampumataito
53	polaris-ampumaharjoitus	ampumataito
53	aamunkoiton_tahtays	ampumataito
53	nordic_sharpshooters_cup	ampumataito
53	taivaanranta-tulitus	ampumataito
53	lumivyory-ammunta	ampumataito
\.


--
-- Data for Name: team_member_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member_score (bulls_eye_count, creation_date, sum, user_id, competition_id, team_name) FROM stdin;
10	2024-04-18	318.1124343264495	1	tarkka-ammunta_cup	poliisiseura
10	2024-04-18	312.38453285297976	1	nopean_laukauksen_mestaruus	poliisiseura
10	2024-04-18	339.43203192009395	1	moniottelu	poliisiseura
10	2024-04-18	318.1702633835078	1	kansallinen_tahtayskilpailu	poliisiseura
10	2024-04-18	285.7144259695028	1	kaupunkiammunta-challenge	poliisiseura
10	2024-04-18	343.6021345276503	1	laukausmaraton	poliisiseura
10	2024-04-18	385.1142340897386	1	vapaa-asekilpailu	poliisiseura
10	2024-04-18	344.8985723392819	1	taitoluodikko-turnaus	poliisiseura
10	2024-04-18	341.8026044769152	1	precision_pistol_cup	poliisiseura
10	2024-04-18	331.57675927261624	1	tulevaisuuden_ampuja	poliisiseura
10	2024-04-18	342.3321307074183	1	pikakivaari-klassikko	poliisiseura
10	2024-04-18	357.14980744546966	2	tarkka-ammunta_cup	poliisiseura
10	2024-04-18	340.71049001393106	2	nopean_laukauksen_mestaruus	poliisiseura
10	2024-04-18	346.91142250028145	2	moniottelu	poliisiseura
10	2024-04-18	243.77561239839304	2	kansallinen_tahtayskilpailu	poliisiseura
10	2024-04-18	357.1148868814402	2	kaupunkiammunta-challenge	poliisiseura
10	2024-04-18	340.451322237918	2	laukausmaraton	poliisiseura
10	2024-04-18	326.60661516912216	2	vapaa-asekilpailu	poliisiseura
10	2024-04-18	357.11325858323	2	taitoluodikko-turnaus	poliisiseura
10	2024-04-18	357.00361511658167	2	precision_pistol_cup	poliisiseura
10	2024-04-18	274.0263076330695	2	tulevaisuuden_ampuja	poliisiseura
10	2024-04-18	353.2004255363694	2	pikakivaari-klassikko	poliisiseura
10	2024-04-18	378.7307968655954	3	tarkka-ammunta_cup	poliisiseura
10	2024-04-18	282.97713130416395	3	nopean_laukauksen_mestaruus	poliisiseura
10	2024-04-18	328.5124323129334	3	moniottelu	poliisiseura
10	2024-04-18	290.69552974578215	3	kansallinen_tahtayskilpailu	poliisiseura
10	2024-04-18	327.86834486331526	3	kaupunkiammunta-challenge	poliisiseura
10	2024-04-18	304.8725127589751	3	laukausmaraton	poliisiseura
10	2024-04-18	357.09455101895134	3	vapaa-asekilpailu	poliisiseura
10	2024-04-18	297.0036373370178	3	taitoluodikko-turnaus	poliisiseura
10	2024-04-18	339.4557873657607	3	precision_pistol_cup	poliisiseura
10	2024-04-18	279.6813237688256	3	tulevaisuuden_ampuja	poliisiseura
10	2024-04-18	305.65100456288684	3	pikakivaari-klassikko	poliisiseura
10	2024-04-18	305.97061471152625	4	tarkka-ammunta_cup	poliisiseura
10	2024-04-18	277.2819064533737	4	nopean_laukauksen_mestaruus	poliisiseura
10	2024-04-18	334.1147906422769	4	moniottelu	poliisiseura
10	2024-04-18	333.54158068984805	4	kansallinen_tahtayskilpailu	poliisiseura
10	2024-04-18	335.7785027896503	4	kaupunkiammunta-challenge	poliisiseura
10	2024-04-18	335.63259357783136	4	laukausmaraton	poliisiseura
10	2024-04-18	333.483189335613	4	vapaa-asekilpailu	poliisiseura
10	2024-04-18	301.71158035399503	4	taitoluodikko-turnaus	poliisiseura
10	2024-04-18	311.10072603100633	4	precision_pistol_cup	poliisiseura
10	2024-04-18	352.985905933777	4	tulevaisuuden_ampuja	poliisiseura
10	2024-04-18	306.18881869255	4	pikakivaari-klassikko	poliisiseura
10	2024-04-18	318.28933626817536	5	tarkka-ammunta_cup	koiraseura
10	2024-04-18	347.9600380490043	5	nopean_laukauksen_mestaruus	koiraseura
10	2024-04-18	307.04962133922237	5	moniottelu	koiraseura
10	2024-04-18	356.18487815037474	5	kansallinen_tahtayskilpailu	koiraseura
10	2024-04-18	294.52823090175673	5	kaupunkiammunta-challenge	koiraseura
10	2024-04-18	332.7050305454848	5	laukausmaraton	koiraseura
10	2024-04-18	322.19169270947646	5	vapaa-asekilpailu	koiraseura
10	2024-04-18	341.3379760634625	5	taitoluodikko-turnaus	koiraseura
10	2024-04-18	293.6176774567798	5	precision_pistol_cup	koiraseura
10	2024-04-18	344.1368713505295	5	tulevaisuuden_ampuja	koiraseura
10	2024-04-18	319.09252980367575	5	pikakivaari-klassikko	koiraseura
10	2024-04-18	353.55898527609844	6	tarkka-ammunta_cup	koiraseura
10	2024-04-18	342.871325030912	6	nopean_laukauksen_mestaruus	koiraseura
10	2024-04-18	347.10557061433417	6	moniottelu	koiraseura
10	2024-04-18	345.0488584214399	6	kansallinen_tahtayskilpailu	koiraseura
10	2024-04-18	309.47055462468154	6	kaupunkiammunta-challenge	koiraseura
10	2024-04-18	325.5553697632613	6	laukausmaraton	koiraseura
10	2024-04-18	293.9519437845464	6	vapaa-asekilpailu	koiraseura
10	2024-04-18	347.41000129636865	6	taitoluodikko-turnaus	koiraseura
10	2024-04-18	299.5872437074633	6	precision_pistol_cup	koiraseura
10	2024-04-18	326.80582559667147	6	tulevaisuuden_ampuja	koiraseura
10	2024-04-18	290.59254737307816	6	pikakivaari-klassikko	koiraseura
10	2024-04-18	309.6357233006032	7	tarkka-ammunta_cup	koiraseura
10	2024-04-18	312.02167397842777	7	nopean_laukauksen_mestaruus	koiraseura
10	2024-04-18	305.9158482400131	7	moniottelu	koiraseura
10	2024-04-18	326.5818094442283	7	kansallinen_tahtayskilpailu	koiraseura
10	2024-04-18	284.00706727304424	7	kaupunkiammunta-challenge	koiraseura
10	2024-04-18	322.8777968441317	7	laukausmaraton	koiraseura
10	2024-04-18	318.0325996413421	7	vapaa-asekilpailu	koiraseura
10	2024-04-18	345.57693312157437	7	taitoluodikko-turnaus	koiraseura
10	2024-04-18	344.1067914458278	7	precision_pistol_cup	koiraseura
10	2024-04-18	293.2646508274115	7	tulevaisuuden_ampuja	koiraseura
10	2024-04-18	325.57846822888985	7	pikakivaari-klassikko	koiraseura
10	2024-04-18	292.7380877974648	8	tarkka-ammunta_cup	koiraseura
10	2024-04-18	331.29763321838874	8	nopean_laukauksen_mestaruus	koiraseura
10	2024-04-18	376.1293599561456	8	moniottelu	koiraseura
10	2024-04-18	345.25331371699406	8	kansallinen_tahtayskilpailu	koiraseura
10	2024-04-18	375.90011121407946	8	kaupunkiammunta-challenge	koiraseura
10	2024-04-18	368.16423782924284	8	laukausmaraton	koiraseura
10	2024-04-18	346.303769648501	8	vapaa-asekilpailu	koiraseura
10	2024-04-18	320.7969953052614	8	taitoluodikko-turnaus	koiraseura
10	2024-04-18	345.57726183973176	8	precision_pistol_cup	koiraseura
10	2024-04-18	347.8913317198439	8	tulevaisuuden_ampuja	koiraseura
10	2024-04-18	372.05949304282615	8	pikakivaari-klassikko	koiraseura
10	2024-04-18	314.8295516023372	9	tarkka-ammunta_cup	hammaspeikkoseura
10	2024-04-18	326.6855042426319	9	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	2024-04-18	346.80663166789725	9	moniottelu	hammaspeikkoseura
10	2024-04-18	329.67278580131654	9	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	2024-04-18	331.59151264571466	9	kaupunkiammunta-challenge	hammaspeikkoseura
10	2024-04-18	321.2161867000196	9	laukausmaraton	hammaspeikkoseura
10	2024-04-18	318.12006452902267	9	vapaa-asekilpailu	hammaspeikkoseura
10	2024-04-18	305.7990019822921	9	taitoluodikko-turnaus	hammaspeikkoseura
10	2024-04-18	304.05761514407016	9	precision_pistol_cup	hammaspeikkoseura
10	2024-04-18	304.79249496734053	9	tulevaisuuden_ampuja	hammaspeikkoseura
10	2024-04-18	334.9514152723787	9	pikakivaari-klassikko	hammaspeikkoseura
10	2024-04-18	309.23066011537856	10	tarkka-ammunta_cup	hammaspeikkoseura
10	2024-04-18	333.49747524055755	10	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	2024-04-18	316.7496810514992	10	moniottelu	hammaspeikkoseura
10	2024-04-18	311.88827965158004	10	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	2024-04-18	363.64534060687663	10	kaupunkiammunta-challenge	hammaspeikkoseura
10	2024-04-18	327.2789840144448	10	laukausmaraton	hammaspeikkoseura
10	2024-04-18	318.4092492423311	10	vapaa-asekilpailu	hammaspeikkoseura
10	2024-04-18	339.9472742888642	10	taitoluodikko-turnaus	hammaspeikkoseura
10	2024-04-18	270.1346143555209	10	precision_pistol_cup	hammaspeikkoseura
10	2024-04-18	342.47344514511127	10	tulevaisuuden_ampuja	hammaspeikkoseura
10	2024-04-18	323.4932131828384	10	pikakivaari-klassikko	hammaspeikkoseura
10	2024-04-18	348.76313757650723	11	tarkka-ammunta_cup	hammaspeikkoseura
10	2024-04-18	317.75175799934686	11	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	2024-04-18	318.02639742289466	11	moniottelu	hammaspeikkoseura
10	2024-04-18	325.51378073827664	11	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	2024-04-18	335.31966439904016	11	kaupunkiammunta-challenge	hammaspeikkoseura
10	2024-04-18	328.33863705255374	11	laukausmaraton	hammaspeikkoseura
10	2024-04-18	323.07788624385455	11	vapaa-asekilpailu	hammaspeikkoseura
10	2024-04-18	282.6327968088348	11	taitoluodikko-turnaus	hammaspeikkoseura
10	2024-04-18	345.40598166702284	11	precision_pistol_cup	hammaspeikkoseura
10	2024-04-18	359.82425393908505	11	tulevaisuuden_ampuja	hammaspeikkoseura
10	2024-04-18	311.0239163844211	11	pikakivaari-klassikko	hammaspeikkoseura
10	2024-04-18	359.21156886410387	12	tarkka-ammunta_cup	hammaspeikkoseura
10	2024-04-18	328.9218080496732	12	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	2024-04-18	308.99577908066294	12	moniottelu	hammaspeikkoseura
10	2024-04-18	304.54040418813844	12	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	2024-04-18	358.3835968771475	12	kaupunkiammunta-challenge	hammaspeikkoseura
10	2024-04-18	320.3369467800736	12	laukausmaraton	hammaspeikkoseura
10	2024-04-18	305.84780539471404	12	vapaa-asekilpailu	hammaspeikkoseura
10	2024-04-18	303.8075945507501	12	taitoluodikko-turnaus	hammaspeikkoseura
10	2024-04-18	306.94690563121827	12	precision_pistol_cup	hammaspeikkoseura
10	2024-04-18	352.6096940642042	12	tulevaisuuden_ampuja	hammaspeikkoseura
10	2024-04-18	303.62120593694647	12	pikakivaari-klassikko	hammaspeikkoseura
10	2024-04-18	263.84412273545814	13	tarkka-ammunta_cup	dog
10	2024-04-18	318.86849081760295	13	nopean_laukauksen_mestaruus	dog
10	2024-04-18	254.52364538254952	13	moniottelu	dog
10	2024-04-18	380.19001606114034	13	kansallinen_tahtayskilpailu	dog
10	2024-04-18	279.36109186576016	13	kaupunkiammunta-challenge	dog
10	2024-04-18	326.7938632075419	13	laukausmaraton	dog
10	2024-04-18	318.7950754944407	13	vapaa-asekilpailu	dog
10	2024-04-18	317.97354735693784	13	taitoluodikko-turnaus	dog
10	2024-04-18	312.70329451356895	13	precision_pistol_cup	dog
10	2024-04-18	301.7841960607069	13	tulevaisuuden_ampuja	dog
10	2024-04-18	326.1339142210797	13	pikakivaari-klassikko	dog
10	2024-04-18	314.30566118929505	14	tarkka-ammunta_cup	dog
10	2024-04-18	312.3314780365041	14	nopean_laukauksen_mestaruus	dog
10	2024-04-18	308.1030429439829	14	moniottelu	dog
10	2024-04-18	348.4869530561322	14	kansallinen_tahtayskilpailu	dog
10	2024-04-18	339.24174496805165	14	kaupunkiammunta-challenge	dog
10	2024-04-18	300.8406196016196	14	laukausmaraton	dog
10	2024-04-18	316.07768809012487	14	vapaa-asekilpailu	dog
10	2024-04-18	325.05743177934335	14	taitoluodikko-turnaus	dog
10	2024-04-18	292.5388055431615	14	precision_pistol_cup	dog
10	2024-04-18	323.4507546737532	14	tulevaisuuden_ampuja	dog
10	2024-04-18	344.30350374226686	14	pikakivaari-klassikko	dog
10	2024-04-18	341.8009444040856	15	tarkka-ammunta_cup	dog
10	2024-04-18	378.8164832217628	15	nopean_laukauksen_mestaruus	dog
10	2024-04-18	311.1581494236106	15	moniottelu	dog
10	2024-04-18	307.8819290586109	15	kansallinen_tahtayskilpailu	dog
10	2024-04-18	343.1252731068876	15	kaupunkiammunta-challenge	dog
10	2024-04-18	321.30122378626646	15	laukausmaraton	dog
10	2024-04-18	335.75788997902725	15	vapaa-asekilpailu	dog
10	2024-04-18	325.1590028333634	15	taitoluodikko-turnaus	dog
10	2024-04-18	290.85278407782	15	precision_pistol_cup	dog
10	2024-04-18	346.1311082137	15	tulevaisuuden_ampuja	dog
10	2024-04-18	279.1561140313009	15	pikakivaari-klassikko	dog
10	2024-04-18	297.1948387362642	16	tarkka-ammunta_cup	dog
10	2024-04-18	308.0897860672031	16	nopean_laukauksen_mestaruus	dog
10	2024-04-18	322.5410384663758	16	moniottelu	dog
10	2024-04-18	388.3835773679231	16	kansallinen_tahtayskilpailu	dog
10	2024-04-18	293.5072980589105	16	kaupunkiammunta-challenge	dog
10	2024-04-18	348.2223920015625	16	laukausmaraton	dog
10	2024-04-18	348.9435368937752	16	vapaa-asekilpailu	dog
10	2024-04-18	336.53084137379693	16	taitoluodikko-turnaus	dog
10	2024-04-18	303.335615675631	16	precision_pistol_cup	dog
10	2024-04-18	322.45072376511575	16	tulevaisuuden_ampuja	dog
10	2024-04-18	319.84472045374656	16	pikakivaari-klassikko	dog
10	2024-04-18	330.8969960964486	17	tarkka-ammunta_cup	dog
10	2024-04-18	303.24619867716416	17	nopean_laukauksen_mestaruus	dog
10	2024-04-18	303.40130080717057	17	moniottelu	dog
10	2024-04-18	306.6292424330158	17	kansallinen_tahtayskilpailu	dog
10	2024-04-18	347.7260312925966	17	kaupunkiammunta-challenge	dog
10	2024-04-18	328.70366458502593	17	laukausmaraton	dog
10	2024-04-18	332.0045847203284	17	vapaa-asekilpailu	dog
10	2024-04-18	315.0289021128068	17	taitoluodikko-turnaus	dog
10	2024-04-18	330.47296222470015	17	precision_pistol_cup	dog
10	2024-04-18	317.1547527048627	17	tulevaisuuden_ampuja	dog
10	2024-04-18	319.6677050236834	17	pikakivaari-klassikko	dog
10	2024-04-18	356.0755130753119	18	tarkka-ammunta_cup	savu_seura
10	2024-04-18	330.90625483393893	18	nopean_laukauksen_mestaruus	savu_seura
10	2024-04-18	313.5036434787486	18	moniottelu	savu_seura
10	2024-04-18	317.2325715843738	18	kansallinen_tahtayskilpailu	savu_seura
10	2024-04-18	314.6749408633669	18	kaupunkiammunta-challenge	savu_seura
10	2024-04-18	324.79333121155844	18	laukausmaraton	savu_seura
10	2024-04-18	349.00207495704484	18	vapaa-asekilpailu	savu_seura
10	2024-04-18	315.3539044440648	18	taitoluodikko-turnaus	savu_seura
10	2024-04-18	319.212405748214	18	precision_pistol_cup	savu_seura
10	2024-04-18	369.8177248513465	18	tulevaisuuden_ampuja	savu_seura
10	2024-04-18	318.00525030493816	18	pikakivaari-klassikko	savu_seura
10	2024-04-18	353.4256646974881	19	tarkka-ammunta_cup	savu_seura
10	2024-04-18	350.73264440869633	19	nopean_laukauksen_mestaruus	savu_seura
10	2024-04-18	302.7920979535063	19	moniottelu	savu_seura
10	2024-04-18	340.7126290904441	19	kansallinen_tahtayskilpailu	savu_seura
10	2024-04-18	335.3944271074598	19	kaupunkiammunta-challenge	savu_seura
10	2024-04-18	296.66483910316646	19	laukausmaraton	savu_seura
10	2024-04-18	357.79716063317915	19	vapaa-asekilpailu	savu_seura
10	2024-04-18	336.8999686053981	19	taitoluodikko-turnaus	savu_seura
10	2024-04-18	334.7407738481664	19	precision_pistol_cup	savu_seura
10	2024-04-18	318.139477035085	19	tulevaisuuden_ampuja	savu_seura
10	2024-04-18	323.6283839387288	19	pikakivaari-klassikko	savu_seura
10	2024-04-18	338.3362784007965	20	tarkka-ammunta_cup	savu_seura
10	2024-04-18	314.88681223338574	20	nopean_laukauksen_mestaruus	savu_seura
10	2024-04-18	331.9298935983173	20	moniottelu	savu_seura
10	2024-04-18	316.5866938195598	20	kansallinen_tahtayskilpailu	savu_seura
10	2024-04-18	369.25650329719855	20	kaupunkiammunta-challenge	savu_seura
10	2024-04-18	339.74941426907606	20	laukausmaraton	savu_seura
10	2024-04-18	335.2224812299506	20	vapaa-asekilpailu	savu_seura
10	2024-04-18	319.29531484913605	20	taitoluodikko-turnaus	savu_seura
10	2024-04-18	366.8596156625696	20	precision_pistol_cup	savu_seura
10	2024-04-18	344.11937068297607	20	tulevaisuuden_ampuja	savu_seura
10	2024-04-18	343.87486050532686	20	pikakivaari-klassikko	savu_seura
10	2024-04-18	278.7436417444522	21	tarkka-ammunta_cup	savu_seura
10	2024-04-18	334.55474599583425	21	nopean_laukauksen_mestaruus	savu_seura
10	2024-04-18	319.2077401784991	21	moniottelu	savu_seura
10	2024-04-18	341.92861248629976	21	kansallinen_tahtayskilpailu	savu_seura
10	2024-04-18	326.7136287854871	21	kaupunkiammunta-challenge	savu_seura
10	2024-04-18	359.31289209479235	21	laukausmaraton	savu_seura
10	2024-04-18	358.8650535372879	21	vapaa-asekilpailu	savu_seura
10	2024-04-18	349.75428955721793	21	taitoluodikko-turnaus	savu_seura
10	2024-04-18	347.9115097400335	21	precision_pistol_cup	savu_seura
10	2024-04-18	326.67926126727303	21	tulevaisuuden_ampuja	savu_seura
10	2024-04-18	361.554932046637	21	pikakivaari-klassikko	savu_seura
10	2024-04-18	383.29652270157874	22	tarkka-ammunta_cup	omas
10	2024-04-18	297.55877600386765	22	nopean_laukauksen_mestaruus	omas
10	2024-04-18	299.6772973266503	22	moniottelu	omas
10	2024-04-18	326.201524827742	22	kansallinen_tahtayskilpailu	omas
10	2024-04-18	325.83968780843026	22	kaupunkiammunta-challenge	omas
10	2024-04-18	330.87544710178804	22	laukausmaraton	omas
10	2024-04-18	316.47791623322195	22	vapaa-asekilpailu	omas
10	2024-04-18	339.99408210304597	22	taitoluodikko-turnaus	omas
10	2024-04-18	358.3261853668935	22	precision_pistol_cup	omas
10	2024-04-18	340.12044592621265	22	tulevaisuuden_ampuja	omas
10	2024-04-18	357.48575120606125	22	pikakivaari-klassikko	omas
10	2024-04-18	291.99231921810883	23	tarkka-ammunta_cup	omas
10	2024-04-18	284.22612003935757	23	nopean_laukauksen_mestaruus	omas
10	2024-04-18	342.7428284814245	23	moniottelu	omas
10	2024-04-18	308.6726643910317	23	kansallinen_tahtayskilpailu	omas
10	2024-04-18	339.0152711758178	23	kaupunkiammunta-challenge	omas
10	2024-04-18	317.72813339761393	23	laukausmaraton	omas
10	2024-04-18	305.120027325405	23	vapaa-asekilpailu	omas
10	2024-04-18	345.82557040010676	23	taitoluodikko-turnaus	omas
10	2024-04-18	298.084914986633	23	precision_pistol_cup	omas
10	2024-04-18	275.15231024892915	23	tulevaisuuden_ampuja	omas
10	2024-04-18	312.8893172292467	23	pikakivaari-klassikko	omas
10	2024-04-18	297.9757281896113	24	tarkka-ammunta_cup	omas
10	2024-04-18	272.71156472232616	24	nopean_laukauksen_mestaruus	omas
10	2024-04-18	297.4792822591069	24	moniottelu	omas
10	2024-04-18	300.8798115075707	24	kansallinen_tahtayskilpailu	omas
10	2024-04-18	314.60782131596517	24	kaupunkiammunta-challenge	omas
10	2024-04-18	353.0843852137363	24	laukausmaraton	omas
10	2024-04-18	290.3720349150323	24	vapaa-asekilpailu	omas
10	2024-04-18	347.1355903271441	24	taitoluodikko-turnaus	omas
10	2024-04-18	332.69677704743924	24	precision_pistol_cup	omas
10	2024-04-18	323.17395231056594	24	tulevaisuuden_ampuja	omas
10	2024-04-18	300.74276507270525	24	pikakivaari-klassikko	omas
10	2024-04-18	295.22663687556746	25	tarkka-ammunta_cup	omas
10	2024-04-18	287.5072325573534	25	nopean_laukauksen_mestaruus	omas
10	2024-04-18	303.908470892167	25	moniottelu	omas
10	2024-04-18	312.47113203095773	25	kansallinen_tahtayskilpailu	omas
10	2024-04-18	320.008606460481	25	kaupunkiammunta-challenge	omas
10	2024-04-18	302.0416007573923	25	laukausmaraton	omas
10	2024-04-18	332.8156729037891	25	vapaa-asekilpailu	omas
10	2024-04-18	341.13663364322656	25	taitoluodikko-turnaus	omas
10	2024-04-18	339.08421708010496	25	precision_pistol_cup	omas
10	2024-04-18	338.26837545096936	25	tulevaisuuden_ampuja	omas
10	2024-04-18	316.29484684624555	25	pikakivaari-klassikko	omas
10	2024-04-18	322.1418896743027	26	tarkka-ammunta_cup	omas
10	2024-04-18	315.3649501153655	26	nopean_laukauksen_mestaruus	omas
10	2024-04-18	358.80189857984	26	moniottelu	omas
10	2024-04-18	304.8528734238908	26	kansallinen_tahtayskilpailu	omas
10	2024-04-18	339.49109502440325	26	kaupunkiammunta-challenge	omas
10	2024-04-18	360.3662967346578	26	laukausmaraton	omas
10	2024-04-18	312.94329959482394	26	vapaa-asekilpailu	omas
10	2024-04-18	316.1142430295574	26	taitoluodikko-turnaus	omas
10	2024-04-18	326.58194767574963	26	precision_pistol_cup	omas
10	2024-04-18	338.1545673071072	26	tulevaisuuden_ampuja	omas
10	2024-04-18	290.1138019519212	26	pikakivaari-klassikko	omas
10	2024-04-18	359.0375526008234	27	tarkka-ammunta_cup	pelleseura
10	2024-04-18	362.25979562391075	27	nopean_laukauksen_mestaruus	pelleseura
10	2024-04-18	358.6866153191909	27	moniottelu	pelleseura
10	2024-04-18	374.21000605553155	27	kansallinen_tahtayskilpailu	pelleseura
10	2024-04-18	296.2083871788591	27	kaupunkiammunta-challenge	pelleseura
10	2024-04-18	336.66055992451123	27	laukausmaraton	pelleseura
10	2024-04-18	323.00963752238897	27	vapaa-asekilpailu	pelleseura
10	2024-04-18	316.01847154446443	27	taitoluodikko-turnaus	pelleseura
10	2024-04-18	317.6981286860731	27	precision_pistol_cup	pelleseura
10	2024-04-18	337.4787892144234	27	tulevaisuuden_ampuja	pelleseura
10	2024-04-18	325.1222898519005	27	pikakivaari-klassikko	pelleseura
10	2024-04-18	317.57387084009474	28	tarkka-ammunta_cup	pelleseura
10	2024-04-18	329.6843843106059	28	nopean_laukauksen_mestaruus	pelleseura
10	2024-04-18	314.46126096807853	28	moniottelu	pelleseura
10	2024-04-18	304.83784872990947	28	kansallinen_tahtayskilpailu	pelleseura
10	2024-04-18	339.90775461154874	28	kaupunkiammunta-challenge	pelleseura
10	2024-04-18	355.73155157723977	28	laukausmaraton	pelleseura
10	2024-04-18	341.00499000472684	28	vapaa-asekilpailu	pelleseura
10	2024-04-18	358.84529138883136	28	taitoluodikko-turnaus	pelleseura
10	2024-04-18	308.3773271366766	28	precision_pistol_cup	pelleseura
10	2024-04-18	345.9014379664608	28	tulevaisuuden_ampuja	pelleseura
10	2024-04-18	336.1743321382744	28	pikakivaari-klassikko	pelleseura
10	2024-04-18	334.6513966098311	29	tarkka-ammunta_cup	pelleseura
10	2024-04-18	361.6177825165724	29	nopean_laukauksen_mestaruus	pelleseura
10	2024-04-18	318.19447101643794	29	moniottelu	pelleseura
10	2024-04-18	319.6177716271109	29	kansallinen_tahtayskilpailu	pelleseura
10	2024-04-18	340.17454658327836	29	kaupunkiammunta-challenge	pelleseura
10	2024-04-18	322.4722563510094	29	laukausmaraton	pelleseura
10	2024-04-18	345.8016951632518	29	vapaa-asekilpailu	pelleseura
10	2024-04-18	370.4880393880543	29	taitoluodikko-turnaus	pelleseura
10	2024-04-18	330.72226846835616	29	precision_pistol_cup	pelleseura
10	2024-04-18	331.75151546166387	29	tulevaisuuden_ampuja	pelleseura
10	2024-04-18	333.9445692531638	29	pikakivaari-klassikko	pelleseura
10	2024-04-18	277.6025007248259	30	tarkka-ammunta_cup	pelleseura
10	2024-04-18	328.17931167348524	30	nopean_laukauksen_mestaruus	pelleseura
10	2024-04-18	326.49867525985513	30	moniottelu	pelleseura
10	2024-04-18	339.2425385428414	30	kansallinen_tahtayskilpailu	pelleseura
10	2024-04-18	372.3292331556348	30	kaupunkiammunta-challenge	pelleseura
10	2024-04-18	272.1404531911269	30	laukausmaraton	pelleseura
10	2024-04-18	327.8818843591427	30	vapaa-asekilpailu	pelleseura
10	2024-04-18	328.16799220806257	30	taitoluodikko-turnaus	pelleseura
10	2024-04-18	296.20000037513256	30	precision_pistol_cup	pelleseura
10	2024-04-18	317.00490533290355	30	tulevaisuuden_ampuja	pelleseura
10	2024-04-18	360.7095131272314	30	pikakivaari-klassikko	pelleseura
10	2024-04-18	311.1052819291744	31	tarkka-ammunta_cup	pelleseura
10	2024-04-18	316.10662000411827	31	nopean_laukauksen_mestaruus	pelleseura
10	2024-04-18	365.25950972644785	31	moniottelu	pelleseura
10	2024-04-18	293.7492456989576	31	kansallinen_tahtayskilpailu	pelleseura
10	2024-04-18	341.54524521261027	31	kaupunkiammunta-challenge	pelleseura
10	2024-04-18	337.74326507695133	31	laukausmaraton	pelleseura
10	2024-04-18	303.1912641514881	31	vapaa-asekilpailu	pelleseura
10	2024-04-18	318.6548262268065	31	taitoluodikko-turnaus	pelleseura
10	2024-04-18	335.1645206794173	31	precision_pistol_cup	pelleseura
10	2024-04-18	338.30807652330327	31	tulevaisuuden_ampuja	pelleseura
10	2024-04-18	291.8738514789612	31	pikakivaari-klassikko	pelleseura
10	2024-04-18	363.0941397332666	32	tarkka-ammunta_cup	yung_tallent
10	2024-04-18	354.4844470447293	32	nopean_laukauksen_mestaruus	yung_tallent
10	2024-04-18	338.93721263241093	32	moniottelu	yung_tallent
10	2024-04-18	347.2791802833539	32	kansallinen_tahtayskilpailu	yung_tallent
10	2024-04-18	354.032306634568	32	kaupunkiammunta-challenge	yung_tallent
10	2024-04-18	317.24365860943885	32	laukausmaraton	yung_tallent
10	2024-04-18	279.68066003087665	32	vapaa-asekilpailu	yung_tallent
10	2024-04-18	346.1342983652968	32	taitoluodikko-turnaus	yung_tallent
10	2024-04-18	335.33133412253505	32	precision_pistol_cup	yung_tallent
10	2024-04-18	302.2147717319179	32	tulevaisuuden_ampuja	yung_tallent
10	2024-04-18	339.49885217188205	32	pikakivaari-klassikko	yung_tallent
10	2024-04-18	335.7099956603932	33	tarkka-ammunta_cup	yung_tallent
10	2024-04-18	350.7962352198829	33	nopean_laukauksen_mestaruus	yung_tallent
10	2024-04-18	296.16607939295653	33	moniottelu	yung_tallent
10	2024-04-18	306.6254805349389	33	kansallinen_tahtayskilpailu	yung_tallent
10	2024-04-18	321.45873469953983	33	kaupunkiammunta-challenge	yung_tallent
10	2024-04-18	306.8277252632749	33	laukausmaraton	yung_tallent
10	2024-04-18	368.5668475376711	33	vapaa-asekilpailu	yung_tallent
10	2024-04-18	310.4422276747374	33	taitoluodikko-turnaus	yung_tallent
10	2024-04-18	339.0079965415838	33	precision_pistol_cup	yung_tallent
10	2024-04-18	319.5830307388551	33	tulevaisuuden_ampuja	yung_tallent
10	2024-04-18	304.28302239782704	33	pikakivaari-klassikko	yung_tallent
10	2024-04-18	333.17244346447626	34	tarkka-ammunta_cup	yung_tallent
10	2024-04-18	335.9904983966416	34	nopean_laukauksen_mestaruus	yung_tallent
10	2024-04-18	356.7788062608952	34	moniottelu	yung_tallent
10	2024-04-18	297.4965858022692	34	kansallinen_tahtayskilpailu	yung_tallent
10	2024-04-18	303.947474944607	34	kaupunkiammunta-challenge	yung_tallent
10	2024-04-18	332.25420960740524	34	laukausmaraton	yung_tallent
10	2024-04-18	348.5616371537121	34	vapaa-asekilpailu	yung_tallent
10	2024-04-18	322.36345321144074	34	taitoluodikko-turnaus	yung_tallent
10	2024-04-18	326.4752830299494	34	precision_pistol_cup	yung_tallent
10	2024-04-18	312.73826199734486	34	tulevaisuuden_ampuja	yung_tallent
10	2024-04-18	324.24482107606497	34	pikakivaari-klassikko	yung_tallent
10	2024-04-18	325.8457772405003	35	tarkka-ammunta_cup	yung_tallent
10	2024-04-18	277.0343444706397	35	nopean_laukauksen_mestaruus	yung_tallent
10	2024-04-18	307.53276757648433	35	moniottelu	yung_tallent
10	2024-04-18	307.81392565822176	35	kansallinen_tahtayskilpailu	yung_tallent
10	2024-04-18	319.8381837945506	35	kaupunkiammunta-challenge	yung_tallent
10	2024-04-18	349.55764289976895	35	laukausmaraton	yung_tallent
10	2024-04-18	272.87559094534	35	vapaa-asekilpailu	yung_tallent
10	2024-04-18	307.08620417010883	35	taitoluodikko-turnaus	yung_tallent
10	2024-04-18	324.4817654054099	35	precision_pistol_cup	yung_tallent
10	2024-04-18	341.6044461023373	35	tulevaisuuden_ampuja	yung_tallent
10	2024-04-18	346.28860336941324	35	pikakivaari-klassikko	yung_tallent
10	2024-04-18	383.84223718008155	36	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	328.45952490827756	36	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	2024-04-18	316.52527032566695	36	moniottelu	aseharrastajien_yhtenaisyys
10	2024-04-18	323.81919204131844	36	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	360.3119584703363	36	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	2024-04-18	309.1346317329455	36	laukausmaraton	aseharrastajien_yhtenaisyys
10	2024-04-18	345.38220617520835	36	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	284.6740845664574	36	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	2024-04-18	336.0644003873601	36	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	366.2472838665648	36	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	2024-04-18	278.30668453733864	36	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	2024-04-18	304.16919400813117	37	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	342.39287014577104	37	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	2024-04-18	318.5887447391096	37	moniottelu	aseharrastajien_yhtenaisyys
10	2024-04-18	303.29830450344303	37	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	327.0350472069928	37	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	2024-04-18	317.7744229819711	37	laukausmaraton	aseharrastajien_yhtenaisyys
10	2024-04-18	315.2111223638597	37	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	305.42795633110404	37	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	2024-04-18	335.3448762136901	37	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	341.17885147378877	37	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	2024-04-18	335.5468248997782	37	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	2024-04-18	328.93319657020965	38	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	341.37242496652533	38	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	2024-04-18	292.69209784892007	38	moniottelu	aseharrastajien_yhtenaisyys
10	2024-04-18	314.7442465450874	38	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	336.6943934871896	38	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	2024-04-18	326.1833027612233	38	laukausmaraton	aseharrastajien_yhtenaisyys
10	2024-04-18	294.1201127623261	38	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	309.6541392080916	38	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	2024-04-18	316.5750887725373	38	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	387.0326494328242	38	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	2024-04-18	325.4092966309546	38	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	2024-04-18	332.25235399436355	39	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	322.92963498592593	39	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	2024-04-18	278.66143218365573	39	moniottelu	aseharrastajien_yhtenaisyys
10	2024-04-18	320.2675353879	39	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	329.46636075199905	39	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	2024-04-18	300.421948643468	39	laukausmaraton	aseharrastajien_yhtenaisyys
10	2024-04-18	288.9694602601053	39	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	342.71874551170356	39	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	2024-04-18	356.97769532225425	39	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	297.6135917506972	39	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	2024-04-18	317.10051018005413	39	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	2024-04-18	315.3841323046379	40	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	320.50766416732523	40	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	2024-04-18	338.56740438911	40	moniottelu	aseharrastajien_yhtenaisyys
10	2024-04-18	316.3467282340384	40	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	342.77288823451727	40	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	2024-04-18	329.48191616203417	40	laukausmaraton	aseharrastajien_yhtenaisyys
10	2024-04-18	345.9326918465212	40	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	2024-04-18	319.88869664702577	40	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	2024-04-18	289.6695062946215	40	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	376.169940505303	40	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	2024-04-18	334.53321228196154	40	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	2024-04-18	305.0256422674162	41	tarkka-ammunta_cup	tahtaysmestarit
10	2024-04-18	309.06277733636944	41	nopean_laukauksen_mestaruus	tahtaysmestarit
10	2024-04-18	324.2350952804787	41	moniottelu	tahtaysmestarit
10	2024-04-18	340.8287030793748	41	kansallinen_tahtayskilpailu	tahtaysmestarit
10	2024-04-18	283.2505712363891	41	kaupunkiammunta-challenge	tahtaysmestarit
10	2024-04-18	332.1788549224631	41	laukausmaraton	tahtaysmestarit
10	2024-04-18	328.427470686371	41	vapaa-asekilpailu	tahtaysmestarit
10	2024-04-18	362.4844556558888	41	taitoluodikko-turnaus	tahtaysmestarit
10	2024-04-18	321.15287144802545	41	precision_pistol_cup	tahtaysmestarit
10	2024-04-18	333.81218697652713	41	tulevaisuuden_ampuja	tahtaysmestarit
10	2024-04-18	313.92264884564537	41	pikakivaari-klassikko	tahtaysmestarit
10	2024-04-18	345.7821243185575	42	tarkka-ammunta_cup	tahtaysmestarit
10	2024-04-18	310.8681625999857	42	nopean_laukauksen_mestaruus	tahtaysmestarit
10	2024-04-18	302.36123073339934	42	moniottelu	tahtaysmestarit
10	2024-04-18	295.0996848456885	42	kansallinen_tahtayskilpailu	tahtaysmestarit
10	2024-04-18	331.1252273468421	42	kaupunkiammunta-challenge	tahtaysmestarit
10	2024-04-18	371.1491474610798	42	laukausmaraton	tahtaysmestarit
10	2024-04-18	336.9259622455216	42	vapaa-asekilpailu	tahtaysmestarit
10	2024-04-18	342.68332944291205	42	taitoluodikko-turnaus	tahtaysmestarit
10	2024-04-18	292.020130819257	42	precision_pistol_cup	tahtaysmestarit
10	2024-04-18	341.2801165320637	42	tulevaisuuden_ampuja	tahtaysmestarit
10	2024-04-18	297.39799913692497	42	pikakivaari-klassikko	tahtaysmestarit
10	2024-04-18	373.22983559806215	43	tarkka-ammunta_cup	tahtaysmestarit
10	2024-04-18	305.53651181095086	43	nopean_laukauksen_mestaruus	tahtaysmestarit
10	2024-04-18	330.3179689159646	43	moniottelu	tahtaysmestarit
10	2024-04-18	309.17728665175207	43	kansallinen_tahtayskilpailu	tahtaysmestarit
10	2024-04-18	325.0877546359223	43	kaupunkiammunta-challenge	tahtaysmestarit
10	2024-04-18	348.54108308446155	43	laukausmaraton	tahtaysmestarit
10	2024-04-18	325.90286582862717	43	vapaa-asekilpailu	tahtaysmestarit
10	2024-04-18	341.63566395256873	43	taitoluodikko-turnaus	tahtaysmestarit
10	2024-04-18	306.8456154890471	43	precision_pistol_cup	tahtaysmestarit
10	2024-04-18	340.7362503071588	43	tulevaisuuden_ampuja	tahtaysmestarit
10	2024-04-18	345.690300408339	43	pikakivaari-klassikko	tahtaysmestarit
10	2024-04-18	308.389527923622	44	tarkka-ammunta_cup	laukausryhma_aurora
10	2024-04-18	369.7159820563546	44	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	2024-04-18	320.191787845396	44	moniottelu	laukausryhma_aurora
10	2024-04-18	347.69808076878377	44	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	2024-04-18	358.62206665627014	44	kaupunkiammunta-challenge	laukausryhma_aurora
10	2024-04-18	341.88477184436204	44	laukausmaraton	laukausryhma_aurora
10	2024-04-18	318.70144702145956	44	vapaa-asekilpailu	laukausryhma_aurora
10	2024-04-18	309.98875026733646	44	taitoluodikko-turnaus	laukausryhma_aurora
10	2024-04-18	317.81943574820673	44	precision_pistol_cup	laukausryhma_aurora
10	2024-04-18	297.22112748187465	44	tulevaisuuden_ampuja	laukausryhma_aurora
10	2024-04-18	334.42510330860887	44	pikakivaari-klassikko	laukausryhma_aurora
10	2024-04-18	334.7618363832763	45	tarkka-ammunta_cup	laukausryhma_aurora
10	2024-04-18	330.70169474375604	45	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	2024-04-18	323.3133396844601	45	moniottelu	laukausryhma_aurora
10	2024-04-18	340.1850934772266	45	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	2024-04-18	372.62190760558934	45	kaupunkiammunta-challenge	laukausryhma_aurora
10	2024-04-18	337.1986353254211	45	laukausmaraton	laukausryhma_aurora
10	2024-04-18	315.75130791925915	45	vapaa-asekilpailu	laukausryhma_aurora
10	2024-04-18	346.4912444423433	45	taitoluodikko-turnaus	laukausryhma_aurora
10	2024-04-18	376.26854166194363	45	precision_pistol_cup	laukausryhma_aurora
10	2024-04-18	391.8039146515153	45	tulevaisuuden_ampuja	laukausryhma_aurora
10	2024-04-18	337.3384815220164	45	pikakivaari-klassikko	laukausryhma_aurora
10	2024-04-18	309.60777012534163	46	tarkka-ammunta_cup	laukausryhma_aurora
10	2024-04-18	352.1427801243778	46	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	2024-04-18	255.51838722711224	46	moniottelu	laukausryhma_aurora
10	2024-04-18	326.82654489630306	46	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	2024-04-18	342.6492946589538	46	kaupunkiammunta-challenge	laukausryhma_aurora
10	2024-04-18	330.35586173909417	46	laukausmaraton	laukausryhma_aurora
10	2024-04-18	290.0417643987704	46	vapaa-asekilpailu	laukausryhma_aurora
10	2024-04-18	342.55507536893083	46	taitoluodikko-turnaus	laukausryhma_aurora
10	2024-04-18	322.0656079679119	46	precision_pistol_cup	laukausryhma_aurora
10	2024-04-18	335.6636237136577	46	tulevaisuuden_ampuja	laukausryhma_aurora
10	2024-04-18	326.2343816702751	46	pikakivaari-klassikko	laukausryhma_aurora
10	2024-04-18	310.206070035202	47	tarkka-ammunta_cup	laukausryhma_aurora
10	2024-04-18	325.99209535113397	47	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	2024-04-18	314.87291504892323	47	moniottelu	laukausryhma_aurora
10	2024-04-18	321.8198079126461	47	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	2024-04-18	316.3368083063388	47	kaupunkiammunta-challenge	laukausryhma_aurora
10	2024-04-18	331.97772429755815	47	laukausmaraton	laukausryhma_aurora
10	2024-04-18	358.83669334030884	47	vapaa-asekilpailu	laukausryhma_aurora
10	2024-04-18	310.35615070887565	47	taitoluodikko-turnaus	laukausryhma_aurora
10	2024-04-18	337.0273877701931	47	precision_pistol_cup	laukausryhma_aurora
10	2024-04-18	307.30102944019177	47	tulevaisuuden_ampuja	laukausryhma_aurora
10	2024-04-18	321.8492094818013	47	pikakivaari-klassikko	laukausryhma_aurora
10	2024-04-18	367.0133439393476	48	tarkka-ammunta_cup	laukausryhma_aurora
10	2024-04-18	302.9968817865512	48	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	2024-04-18	322.08377861742196	48	moniottelu	laukausryhma_aurora
10	2024-04-18	349.67654428950266	48	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	2024-04-18	318.94849866159393	48	kaupunkiammunta-challenge	laukausryhma_aurora
10	2024-04-18	312.3567650308151	48	laukausmaraton	laukausryhma_aurora
10	2024-04-18	363.40174639200416	48	vapaa-asekilpailu	laukausryhma_aurora
10	2024-04-18	338.69646971924897	48	taitoluodikko-turnaus	laukausryhma_aurora
10	2024-04-18	303.2477096291442	48	precision_pistol_cup	laukausryhma_aurora
10	2024-04-18	337.8681233191739	48	tulevaisuuden_ampuja	laukausryhma_aurora
10	2024-04-18	332.5395035158742	48	pikakivaari-klassikko	laukausryhma_aurora
10	2024-04-18	308.90163102864597	49	tarkka-ammunta_cup	ampumataito
10	2024-04-18	337.07768507232004	49	nopean_laukauksen_mestaruus	ampumataito
10	2024-04-18	372.4397078245586	49	moniottelu	ampumataito
10	2024-04-18	353.76531509181405	49	kansallinen_tahtayskilpailu	ampumataito
10	2024-04-18	312.94541130059827	49	kaupunkiammunta-challenge	ampumataito
10	2024-04-18	299.3986443406931	49	laukausmaraton	ampumataito
10	2024-04-18	292.4498666438154	49	vapaa-asekilpailu	ampumataito
10	2024-04-18	341.7218733659606	49	taitoluodikko-turnaus	ampumataito
10	2024-04-18	289.8399134074015	49	precision_pistol_cup	ampumataito
10	2024-04-18	346.8717185849539	49	tulevaisuuden_ampuja	ampumataito
10	2024-04-18	351.4421737950161	49	pikakivaari-klassikko	ampumataito
10	2024-04-18	360.7497415064387	50	tarkka-ammunta_cup	ampumataito
10	2024-04-18	351.651935282613	50	nopean_laukauksen_mestaruus	ampumataito
10	2024-04-18	311.3978581754201	50	moniottelu	ampumataito
10	2024-04-18	340.4707717887013	50	kansallinen_tahtayskilpailu	ampumataito
10	2024-04-18	355.8755449165576	50	kaupunkiammunta-challenge	ampumataito
10	2024-04-18	356.6487425445116	50	laukausmaraton	ampumataito
10	2024-04-18	350.8331075668448	50	vapaa-asekilpailu	ampumataito
10	2024-04-18	331.7486008809356	50	taitoluodikko-turnaus	ampumataito
10	2024-04-18	303.9162401210384	50	precision_pistol_cup	ampumataito
10	2024-04-18	323.1328183992044	50	tulevaisuuden_ampuja	ampumataito
10	2024-04-18	300.48300624429254	50	pikakivaari-klassikko	ampumataito
10	2024-04-18	342.7432887078597	51	tarkka-ammunta_cup	ampumataito
10	2024-04-18	318.9213651123898	51	nopean_laukauksen_mestaruus	ampumataito
10	2024-04-18	381.96685758374866	51	moniottelu	ampumataito
10	2024-04-18	343.89939683020225	51	kansallinen_tahtayskilpailu	ampumataito
10	2024-04-18	345.82957804584686	51	kaupunkiammunta-challenge	ampumataito
10	2024-04-18	317.80195786125756	51	laukausmaraton	ampumataito
10	2024-04-18	314.8780763196001	51	vapaa-asekilpailu	ampumataito
10	2024-04-18	295.7159488445589	51	taitoluodikko-turnaus	ampumataito
10	2024-04-18	349.53312585659063	51	precision_pistol_cup	ampumataito
10	2024-04-18	279.397051569204	51	tulevaisuuden_ampuja	ampumataito
10	2024-04-18	312.3091374050496	51	pikakivaari-klassikko	ampumataito
10	2024-04-18	353.0827369543076	52	tarkka-ammunta_cup	ampumataito
10	2024-04-18	347.1783664546927	52	nopean_laukauksen_mestaruus	ampumataito
10	2024-04-18	347.3039442720983	52	moniottelu	ampumataito
10	2024-04-18	285.27195056295665	52	kansallinen_tahtayskilpailu	ampumataito
10	2024-04-18	306.87083398197194	52	kaupunkiammunta-challenge	ampumataito
10	2024-04-18	340.1610619279626	52	laukausmaraton	ampumataito
10	2024-04-18	320.77049830910823	52	vapaa-asekilpailu	ampumataito
10	2024-04-18	335.8160127890848	52	taitoluodikko-turnaus	ampumataito
10	2024-04-18	348.7167421491587	52	precision_pistol_cup	ampumataito
10	2024-04-18	298.1375540393996	52	tulevaisuuden_ampuja	ampumataito
10	2024-04-18	328.73705781082134	52	pikakivaari-klassikko	ampumataito
10	2024-04-18	331.8142390181686	53	tarkka-ammunta_cup	ampumataito
10	2024-04-18	337.78280961633226	53	nopean_laukauksen_mestaruus	ampumataito
10	2024-04-18	349.6586543665383	53	moniottelu	ampumataito
10	2024-04-18	325.2606272564407	53	kansallinen_tahtayskilpailu	ampumataito
10	2024-04-18	331.5861830925566	53	kaupunkiammunta-challenge	ampumataito
10	2024-04-18	312.5885932912855	53	laukausmaraton	ampumataito
10	2024-04-18	326.87163459933555	53	vapaa-asekilpailu	ampumataito
10	2024-04-18	325.3153601494629	53	taitoluodikko-turnaus	ampumataito
10	2024-04-18	343.51274021188857	53	precision_pistol_cup	ampumataito
10	2024-04-18	324.8003951862315	53	tulevaisuuden_ampuja	ampumataito
10	2024-04-18	321.045922542201	53	pikakivaari-klassikko	ampumataito
10	2024-04-18	330.7800420362629	1	kesan_ampujaiset	poliisiseura
10	2024-04-18	356.131495959556	1	talvi_pistooli	poliisiseura
10	2024-04-18	338.894133545959	1	tarkkuuslaukaus-festivaali	poliisiseura
10	2024-04-18	348.9265524910181	1	kivaarikilpailujen_huipennus	poliisiseura
10	2024-04-18	348.52468094811474	1	polaris-ampumaharjoitus	poliisiseura
10	2024-04-18	343.5773221371344	1	aamunkoiton_tahtays	poliisiseura
10	2024-04-18	360.8572515280426	1	nordic_sharpshooters_cup	poliisiseura
10	2024-04-18	297.84004607042954	1	taivaanranta-tulitus	poliisiseura
10	2024-04-18	332.24346739843816	1	lumivyory-ammunta	poliisiseura
10	2024-04-18	317.2899813147512	2	kesan_ampujaiset	poliisiseura
10	2024-04-18	321.0617012040026	2	talvi_pistooli	poliisiseura
10	2024-04-18	324.70744756547634	2	tarkkuuslaukaus-festivaali	poliisiseura
10	2024-04-18	324.4971522876403	2	kivaarikilpailujen_huipennus	poliisiseura
10	2024-04-18	340.6342997671091	2	polaris-ampumaharjoitus	poliisiseura
10	2024-04-18	344.4554468058748	2	aamunkoiton_tahtays	poliisiseura
10	2024-04-18	341.5753597835377	2	nordic_sharpshooters_cup	poliisiseura
10	2024-04-18	338.2963892771394	2	taivaanranta-tulitus	poliisiseura
10	2024-04-18	346.15177914445394	2	lumivyory-ammunta	poliisiseura
10	2024-04-18	292.78834132005545	3	kesan_ampujaiset	poliisiseura
10	2024-04-18	361.2031700248423	3	talvi_pistooli	poliisiseura
10	2024-04-18	323.68267280398805	3	tarkkuuslaukaus-festivaali	poliisiseura
10	2024-04-18	329.6613031845489	3	kivaarikilpailujen_huipennus	poliisiseura
10	2024-04-18	355.8335826344663	3	polaris-ampumaharjoitus	poliisiseura
10	2024-04-18	352.6250961502126	3	aamunkoiton_tahtays	poliisiseura
10	2024-04-18	342.6216864183013	3	nordic_sharpshooters_cup	poliisiseura
10	2024-04-18	321.66297280400613	3	taivaanranta-tulitus	poliisiseura
10	2024-04-18	342.58899526354793	3	lumivyory-ammunta	poliisiseura
10	2024-04-18	323.6328017934769	4	kesan_ampujaiset	poliisiseura
10	2024-04-18	333.0435245506162	4	talvi_pistooli	poliisiseura
10	2024-04-18	321.34127814972805	4	tarkkuuslaukaus-festivaali	poliisiseura
10	2024-04-18	307.3368774513918	4	kivaarikilpailujen_huipennus	poliisiseura
10	2024-04-18	295.70638464317983	4	polaris-ampumaharjoitus	poliisiseura
10	2024-04-18	352.96417256387184	4	aamunkoiton_tahtays	poliisiseura
10	2024-04-18	337.2706472194832	4	nordic_sharpshooters_cup	poliisiseura
10	2024-04-18	310.80194104931445	4	taivaanranta-tulitus	poliisiseura
10	2024-04-18	330.0105198329372	4	lumivyory-ammunta	poliisiseura
10	2024-04-18	312.8409377046837	5	kesan_ampujaiset	koiraseura
10	2024-04-18	311.6671681585522	5	talvi_pistooli	koiraseura
10	2024-04-18	339.4009844238755	5	tarkkuuslaukaus-festivaali	koiraseura
10	2024-04-18	299.37608435856737	5	kivaarikilpailujen_huipennus	koiraseura
10	2024-04-18	355.8552774899499	5	polaris-ampumaharjoitus	koiraseura
10	2024-04-18	348.17892829111105	5	aamunkoiton_tahtays	koiraseura
10	2024-04-18	325.0944022520556	5	nordic_sharpshooters_cup	koiraseura
10	2024-04-18	304.8678913084754	5	taivaanranta-tulitus	koiraseura
10	2024-04-18	328.71307288839176	5	lumivyory-ammunta	koiraseura
10	2024-04-18	328.1927507753312	6	kesan_ampujaiset	koiraseura
10	2024-04-18	300.69376449287955	6	talvi_pistooli	koiraseura
10	2024-04-18	319.5571859478812	6	tarkkuuslaukaus-festivaali	koiraseura
10	2024-04-18	329.78623361642303	6	kivaarikilpailujen_huipennus	koiraseura
10	2024-04-18	325.527061364573	6	polaris-ampumaharjoitus	koiraseura
10	2024-04-18	322.69637918652495	6	aamunkoiton_tahtays	koiraseura
10	2024-04-18	331.0595777755461	6	nordic_sharpshooters_cup	koiraseura
10	2024-04-18	352.9376250896207	6	taivaanranta-tulitus	koiraseura
10	2024-04-18	371.6637407777462	6	lumivyory-ammunta	koiraseura
10	2024-04-18	316.61259602880017	7	kesan_ampujaiset	koiraseura
10	2024-04-18	345.0723302975713	7	talvi_pistooli	koiraseura
10	2024-04-18	275.91594404218546	7	tarkkuuslaukaus-festivaali	koiraseura
10	2024-04-18	364.7241979119447	7	kivaarikilpailujen_huipennus	koiraseura
10	2024-04-18	336.03300322276795	7	polaris-ampumaharjoitus	koiraseura
10	2024-04-18	315.91018572286634	7	aamunkoiton_tahtays	koiraseura
10	2024-04-18	318.6675588638083	7	nordic_sharpshooters_cup	koiraseura
10	2024-04-18	388.8467948944962	7	taivaanranta-tulitus	koiraseura
10	2024-04-18	330.34691086155624	7	lumivyory-ammunta	koiraseura
10	2024-04-18	359.38288017238324	8	kesan_ampujaiset	koiraseura
10	2024-04-18	311.72627008774197	8	talvi_pistooli	koiraseura
10	2024-04-18	322.99259723809087	8	tarkkuuslaukaus-festivaali	koiraseura
10	2024-04-18	332.69607330556653	8	kivaarikilpailujen_huipennus	koiraseura
10	2024-04-18	344.9612838528597	8	polaris-ampumaharjoitus	koiraseura
10	2024-04-18	336.9170959357534	8	aamunkoiton_tahtays	koiraseura
10	2024-04-18	325.2927699501766	8	nordic_sharpshooters_cup	koiraseura
10	2024-04-18	302.82730868232414	8	taivaanranta-tulitus	koiraseura
10	2024-04-18	298.40699360258475	8	lumivyory-ammunta	koiraseura
10	2024-04-18	297.35681575690154	9	kesan_ampujaiset	hammaspeikkoseura
10	2024-04-18	318.8713817644582	9	talvi_pistooli	hammaspeikkoseura
10	2024-04-18	295.7913964516822	9	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	2024-04-18	312.70159946440424	9	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	2024-04-18	342.7191011995697	9	polaris-ampumaharjoitus	hammaspeikkoseura
10	2024-04-18	345.34595576510947	9	aamunkoiton_tahtays	hammaspeikkoseura
10	2024-04-18	302.89579022304326	9	nordic_sharpshooters_cup	hammaspeikkoseura
10	2024-04-18	294.8932992387678	9	taivaanranta-tulitus	hammaspeikkoseura
10	2024-04-18	333.85204704474285	9	lumivyory-ammunta	hammaspeikkoseura
10	2024-04-18	365.81600728685873	10	kesan_ampujaiset	hammaspeikkoseura
10	2024-04-18	300.23091054736517	10	talvi_pistooli	hammaspeikkoseura
10	2024-04-18	355.1629505960259	10	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	2024-04-18	334.166299034753	10	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	2024-04-18	311.69085836581206	10	polaris-ampumaharjoitus	hammaspeikkoseura
10	2024-04-18	285.3363249463929	10	aamunkoiton_tahtays	hammaspeikkoseura
10	2024-04-18	322.97999342047905	10	nordic_sharpshooters_cup	hammaspeikkoseura
10	2024-04-18	336.4626386660529	10	taivaanranta-tulitus	hammaspeikkoseura
10	2024-04-18	355.97918087689203	10	lumivyory-ammunta	hammaspeikkoseura
10	2024-04-18	336.9042946073487	11	kesan_ampujaiset	hammaspeikkoseura
10	2024-04-18	330.83174461997044	11	talvi_pistooli	hammaspeikkoseura
10	2024-04-18	304.0368629141241	11	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	2024-04-18	292.8570993381602	11	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	2024-04-18	341.9164332467983	11	polaris-ampumaharjoitus	hammaspeikkoseura
10	2024-04-18	360.53170735517307	11	aamunkoiton_tahtays	hammaspeikkoseura
10	2024-04-18	371.5898646497142	11	nordic_sharpshooters_cup	hammaspeikkoseura
10	2024-04-18	316.2270156647153	11	taivaanranta-tulitus	hammaspeikkoseura
10	2024-04-18	267.6382205875648	11	lumivyory-ammunta	hammaspeikkoseura
10	2024-04-18	315.8496174837011	12	kesan_ampujaiset	hammaspeikkoseura
10	2024-04-18	301.11962528442433	12	talvi_pistooli	hammaspeikkoseura
10	2024-04-18	301.6421715146291	12	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	2024-04-18	331.33289613320346	12	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	2024-04-18	353.28715362559865	12	polaris-ampumaharjoitus	hammaspeikkoseura
10	2024-04-18	324.17092161675424	12	aamunkoiton_tahtays	hammaspeikkoseura
10	2024-04-18	298.72455461933004	12	nordic_sharpshooters_cup	hammaspeikkoseura
10	2024-04-18	331.3326835384792	12	taivaanranta-tulitus	hammaspeikkoseura
10	2024-04-18	335.3697003178109	12	lumivyory-ammunta	hammaspeikkoseura
10	2024-04-18	320.3189639262547	13	kesan_ampujaiset	dog
10	2024-04-18	331.5472715722803	13	talvi_pistooli	dog
10	2024-04-18	316.7615845215625	13	tarkkuuslaukaus-festivaali	dog
10	2024-04-18	345.67462851169415	13	kivaarikilpailujen_huipennus	dog
10	2024-04-18	324.6590703276254	13	polaris-ampumaharjoitus	dog
10	2024-04-18	368.5972878831045	13	aamunkoiton_tahtays	dog
10	2024-04-18	298.1456250342691	13	nordic_sharpshooters_cup	dog
10	2024-04-18	343.02929263515085	13	taivaanranta-tulitus	dog
10	2024-04-18	321.61409765044533	13	lumivyory-ammunta	dog
10	2024-04-18	306.9498699425091	14	kesan_ampujaiset	dog
10	2024-04-18	308.20439622743754	14	talvi_pistooli	dog
10	2024-04-18	323.51060076337734	14	tarkkuuslaukaus-festivaali	dog
10	2024-04-18	315.85372067805764	14	kivaarikilpailujen_huipennus	dog
10	2024-04-18	335.6074047232431	14	polaris-ampumaharjoitus	dog
10	2024-04-18	273.5054149430055	14	aamunkoiton_tahtays	dog
10	2024-04-18	317.916463262787	14	nordic_sharpshooters_cup	dog
10	2024-04-18	289.215662456572	14	taivaanranta-tulitus	dog
10	2024-04-18	333.46985676233027	14	lumivyory-ammunta	dog
10	2024-04-18	338.8143684046971	15	kesan_ampujaiset	dog
10	2024-04-18	328.07086578564446	15	talvi_pistooli	dog
10	2024-04-18	323.53195917112674	15	tarkkuuslaukaus-festivaali	dog
10	2024-04-18	329.1525497679597	15	kivaarikilpailujen_huipennus	dog
10	2024-04-18	346.28019075188587	15	polaris-ampumaharjoitus	dog
10	2024-04-18	317.82627120343653	15	aamunkoiton_tahtays	dog
10	2024-04-18	305.0299413099035	15	nordic_sharpshooters_cup	dog
10	2024-04-18	319.836473612231	15	taivaanranta-tulitus	dog
10	2024-04-18	336.72987209272117	15	lumivyory-ammunta	dog
10	2024-04-18	284.6267960453784	16	kesan_ampujaiset	dog
10	2024-04-18	329.0549374485895	16	talvi_pistooli	dog
10	2024-04-18	345.04595746605554	16	tarkkuuslaukaus-festivaali	dog
10	2024-04-18	344.21075954671795	16	kivaarikilpailujen_huipennus	dog
10	2024-04-18	324.78277218851423	16	polaris-ampumaharjoitus	dog
10	2024-04-18	296.3093345940386	16	aamunkoiton_tahtays	dog
10	2024-04-18	363.6611453503762	16	nordic_sharpshooters_cup	dog
10	2024-04-18	312.01624743308616	16	taivaanranta-tulitus	dog
10	2024-04-18	303.07679609889453	16	lumivyory-ammunta	dog
10	2024-04-18	280.95723440252516	17	kesan_ampujaiset	dog
10	2024-04-18	312.11768348861773	17	talvi_pistooli	dog
10	2024-04-18	303.7236733566067	17	tarkkuuslaukaus-festivaali	dog
10	2024-04-18	358.0700047948154	17	kivaarikilpailujen_huipennus	dog
10	2024-04-18	328.1060483294608	17	polaris-ampumaharjoitus	dog
10	2024-04-18	360.1450284031164	17	aamunkoiton_tahtays	dog
10	2024-04-18	332.07911228309797	17	nordic_sharpshooters_cup	dog
10	2024-04-18	257.2080005066478	17	taivaanranta-tulitus	dog
10	2024-04-18	344.7615694927076	17	lumivyory-ammunta	dog
10	2024-04-18	339.47829266474366	18	kesan_ampujaiset	savu_seura
10	2024-04-18	338.36999907367016	18	talvi_pistooli	savu_seura
10	2024-04-18	379.869918904209	18	tarkkuuslaukaus-festivaali	savu_seura
10	2024-04-18	332.83966554930237	18	kivaarikilpailujen_huipennus	savu_seura
10	2024-04-18	334.72632424098043	18	polaris-ampumaharjoitus	savu_seura
10	2024-04-18	313.14548721372	18	aamunkoiton_tahtays	savu_seura
10	2024-04-18	294.93034933242285	18	nordic_sharpshooters_cup	savu_seura
10	2024-04-18	342.85912326078034	18	taivaanranta-tulitus	savu_seura
10	2024-04-18	292.6244508490376	18	lumivyory-ammunta	savu_seura
10	2024-04-18	317.38095214287233	19	kesan_ampujaiset	savu_seura
10	2024-04-18	346.3861882428417	19	talvi_pistooli	savu_seura
10	2024-04-18	295.3230025469913	19	tarkkuuslaukaus-festivaali	savu_seura
10	2024-04-18	330.731550949343	19	kivaarikilpailujen_huipennus	savu_seura
10	2024-04-18	361.11199500463835	19	polaris-ampumaharjoitus	savu_seura
10	2024-04-18	343.78079626371937	19	aamunkoiton_tahtays	savu_seura
10	2024-04-18	285.50927337459615	19	nordic_sharpshooters_cup	savu_seura
10	2024-04-18	299.19824416940503	19	taivaanranta-tulitus	savu_seura
10	2024-04-18	363.2547078112648	19	lumivyory-ammunta	savu_seura
10	2024-04-18	356.76286593420616	20	kesan_ampujaiset	savu_seura
10	2024-04-18	388.53966982383423	20	talvi_pistooli	savu_seura
10	2024-04-18	310.6402042103334	20	tarkkuuslaukaus-festivaali	savu_seura
10	2024-04-18	332.5714273722957	20	kivaarikilpailujen_huipennus	savu_seura
10	2024-04-18	316.18646607112237	20	polaris-ampumaharjoitus	savu_seura
10	2024-04-18	335.806350272774	20	aamunkoiton_tahtays	savu_seura
10	2024-04-18	322.61102809464614	20	nordic_sharpshooters_cup	savu_seura
10	2024-04-18	329.67843726236896	20	taivaanranta-tulitus	savu_seura
10	2024-04-18	305.0605876821861	20	lumivyory-ammunta	savu_seura
10	2024-04-18	322.74054975352306	21	kesan_ampujaiset	savu_seura
10	2024-04-18	318.6574952163895	21	talvi_pistooli	savu_seura
10	2024-04-18	342.83992906058256	21	tarkkuuslaukaus-festivaali	savu_seura
10	2024-04-18	329.85261639487453	21	kivaarikilpailujen_huipennus	savu_seura
10	2024-04-18	316.58066922177204	21	polaris-ampumaharjoitus	savu_seura
10	2024-04-18	304.32034011912833	21	aamunkoiton_tahtays	savu_seura
10	2024-04-18	346.8712651650071	21	nordic_sharpshooters_cup	savu_seura
10	2024-04-18	316.4820510256241	21	taivaanranta-tulitus	savu_seura
10	2024-04-18	330.3099685892564	21	lumivyory-ammunta	savu_seura
10	2024-04-18	381.91526750374175	22	kesan_ampujaiset	omas
10	2024-04-18	308.1738334172082	22	talvi_pistooli	omas
10	2024-04-18	263.48223012107206	22	tarkkuuslaukaus-festivaali	omas
10	2024-04-18	321.7884401014364	22	kivaarikilpailujen_huipennus	omas
10	2024-04-18	342.65234088968054	22	polaris-ampumaharjoitus	omas
10	2024-04-18	261.6154442138746	22	aamunkoiton_tahtays	omas
10	2024-04-18	302.35453982518874	22	nordic_sharpshooters_cup	omas
10	2024-04-18	312.5843617174378	22	taivaanranta-tulitus	omas
10	2024-04-18	321.833975361434	22	lumivyory-ammunta	omas
10	2024-04-18	283.6038444545268	23	kesan_ampujaiset	omas
10	2024-04-18	312.71003322595027	23	talvi_pistooli	omas
10	2024-04-18	345.11061841059797	23	tarkkuuslaukaus-festivaali	omas
10	2024-04-18	286.9916915618371	23	kivaarikilpailujen_huipennus	omas
10	2024-04-18	338.4513005495775	23	polaris-ampumaharjoitus	omas
10	2024-04-18	308.32745986036326	23	aamunkoiton_tahtays	omas
10	2024-04-18	295.53284093159647	23	nordic_sharpshooters_cup	omas
10	2024-04-18	323.0786419744801	23	taivaanranta-tulitus	omas
10	2024-04-18	350.7264050405643	23	lumivyory-ammunta	omas
10	2024-04-18	292.68505564818537	24	kesan_ampujaiset	omas
10	2024-04-18	316.17977518688866	24	talvi_pistooli	omas
10	2024-04-18	307.2485575115133	24	tarkkuuslaukaus-festivaali	omas
10	2024-04-18	339.5493936185789	24	kivaarikilpailujen_huipennus	omas
10	2024-04-18	354.05410939187175	24	polaris-ampumaharjoitus	omas
10	2024-04-18	349.8612788502343	24	aamunkoiton_tahtays	omas
10	2024-04-18	334.9819244490169	24	nordic_sharpshooters_cup	omas
10	2024-04-18	295.40972163745687	24	taivaanranta-tulitus	omas
10	2024-04-18	338.5493085751231	24	lumivyory-ammunta	omas
10	2024-04-18	309.35233313298926	25	kesan_ampujaiset	omas
10	2024-04-18	340.183059052197	25	talvi_pistooli	omas
10	2024-04-18	333.7047520808151	25	tarkkuuslaukaus-festivaali	omas
10	2024-04-18	343.875083348764	25	kivaarikilpailujen_huipennus	omas
10	2024-04-18	341.1987817489606	25	polaris-ampumaharjoitus	omas
10	2024-04-18	324.54239721652385	25	aamunkoiton_tahtays	omas
10	2024-04-18	341.2315280051763	25	nordic_sharpshooters_cup	omas
10	2024-04-18	307.7357983400002	25	taivaanranta-tulitus	omas
10	2024-04-18	334.2640809227897	25	lumivyory-ammunta	omas
10	2024-04-18	294.3632610037098	26	kesan_ampujaiset	omas
10	2024-04-18	301.0425757859083	26	talvi_pistooli	omas
10	2024-04-18	300.4361531747164	26	tarkkuuslaukaus-festivaali	omas
10	2024-04-18	318.51051016712796	26	kivaarikilpailujen_huipennus	omas
10	2024-04-18	404.9194541195713	26	polaris-ampumaharjoitus	omas
10	2024-04-18	305.507728403037	26	aamunkoiton_tahtays	omas
10	2024-04-18	353.49413707674677	26	nordic_sharpshooters_cup	omas
10	2024-04-18	325.8813543438005	26	taivaanranta-tulitus	omas
10	2024-04-18	321.06121467453033	26	lumivyory-ammunta	omas
10	2024-04-18	298.37213806646224	27	kesan_ampujaiset	pelleseura
10	2024-04-18	327.23985039318273	27	talvi_pistooli	pelleseura
10	2024-04-18	317.58007117473346	27	tarkkuuslaukaus-festivaali	pelleseura
10	2024-04-18	340.2020824833035	27	kivaarikilpailujen_huipennus	pelleseura
10	2024-04-18	373.6081062178368	27	polaris-ampumaharjoitus	pelleseura
10	2024-04-18	339.7161529823522	27	aamunkoiton_tahtays	pelleseura
10	2024-04-18	336.2598629675477	27	nordic_sharpshooters_cup	pelleseura
10	2024-04-18	361.4965698009104	27	taivaanranta-tulitus	pelleseura
10	2024-04-18	370.73198213497415	27	lumivyory-ammunta	pelleseura
10	2024-04-18	311.2285438506591	28	kesan_ampujaiset	pelleseura
10	2024-04-18	367.06989239111834	28	talvi_pistooli	pelleseura
10	2024-04-18	310.6797155024939	28	tarkkuuslaukaus-festivaali	pelleseura
10	2024-04-18	344.568006497582	28	kivaarikilpailujen_huipennus	pelleseura
10	2024-04-18	319.37065364628353	28	polaris-ampumaharjoitus	pelleseura
10	2024-04-18	326.5458247365254	28	aamunkoiton_tahtays	pelleseura
10	2024-04-18	327.7903198495257	28	nordic_sharpshooters_cup	pelleseura
10	2024-04-18	358.6759394589443	28	taivaanranta-tulitus	pelleseura
10	2024-04-18	339.198534594367	28	lumivyory-ammunta	pelleseura
10	2024-04-18	333.51920710437923	29	kesan_ampujaiset	pelleseura
10	2024-04-18	299.91686962562227	29	talvi_pistooli	pelleseura
10	2024-04-18	279.3870903253238	29	tarkkuuslaukaus-festivaali	pelleseura
10	2024-04-18	331.1552157629951	29	kivaarikilpailujen_huipennus	pelleseura
10	2024-04-18	293.97318702334906	29	polaris-ampumaharjoitus	pelleseura
10	2024-04-18	321.45999022853016	29	aamunkoiton_tahtays	pelleseura
10	2024-04-18	282.1102542427509	29	nordic_sharpshooters_cup	pelleseura
10	2024-04-18	326.973752545454	29	taivaanranta-tulitus	pelleseura
10	2024-04-18	347.3804599895278	29	lumivyory-ammunta	pelleseura
10	2024-04-18	346.977963367853	30	kesan_ampujaiset	pelleseura
10	2024-04-18	324.7472988816446	30	talvi_pistooli	pelleseura
10	2024-04-18	338.96890310801314	30	tarkkuuslaukaus-festivaali	pelleseura
10	2024-04-18	292.63247994289077	30	kivaarikilpailujen_huipennus	pelleseura
10	2024-04-18	319.5347096220951	30	polaris-ampumaharjoitus	pelleseura
10	2024-04-18	294.2287371702841	30	aamunkoiton_tahtays	pelleseura
10	2024-04-18	331.4327752568754	30	nordic_sharpshooters_cup	pelleseura
10	2024-04-18	312.18738027093065	30	taivaanranta-tulitus	pelleseura
10	2024-04-18	307.0962060754416	30	lumivyory-ammunta	pelleseura
10	2024-04-18	370.7867159393624	31	kesan_ampujaiset	pelleseura
10	2024-04-18	314.43894466430106	31	talvi_pistooli	pelleseura
10	2024-04-18	329.7070463993672	31	tarkkuuslaukaus-festivaali	pelleseura
10	2024-04-18	338.9632410636325	31	kivaarikilpailujen_huipennus	pelleseura
10	2024-04-18	337.6365206262317	31	polaris-ampumaharjoitus	pelleseura
10	2024-04-18	345.3951869441175	31	aamunkoiton_tahtays	pelleseura
10	2024-04-18	347.0756026103174	31	nordic_sharpshooters_cup	pelleseura
10	2024-04-18	306.11593605375003	31	taivaanranta-tulitus	pelleseura
10	2024-04-18	306.26647629031487	31	lumivyory-ammunta	pelleseura
10	2024-04-18	355.5464638793469	32	kesan_ampujaiset	yung_tallent
10	2024-04-18	367.16312670577395	32	talvi_pistooli	yung_tallent
10	2024-04-18	294.0456210870965	32	tarkkuuslaukaus-festivaali	yung_tallent
10	2024-04-18	303.8410909503804	32	kivaarikilpailujen_huipennus	yung_tallent
10	2024-04-18	333.3439378288583	32	polaris-ampumaharjoitus	yung_tallent
10	2024-04-18	330.227829717751	32	aamunkoiton_tahtays	yung_tallent
10	2024-04-18	372.9694535062705	32	nordic_sharpshooters_cup	yung_tallent
10	2024-04-18	338.4008906243608	32	taivaanranta-tulitus	yung_tallent
10	2024-04-18	352.86163701034803	32	lumivyory-ammunta	yung_tallent
10	2024-04-18	366.00175410075525	33	kesan_ampujaiset	yung_tallent
10	2024-04-18	359.29234406264163	33	talvi_pistooli	yung_tallent
10	2024-04-18	321.63516560175725	33	tarkkuuslaukaus-festivaali	yung_tallent
10	2024-04-18	330.7794001913789	33	kivaarikilpailujen_huipennus	yung_tallent
10	2024-04-18	278.5812784014412	33	polaris-ampumaharjoitus	yung_tallent
10	2024-04-18	341.8020356330877	33	aamunkoiton_tahtays	yung_tallent
10	2024-04-18	310.0522045759946	33	nordic_sharpshooters_cup	yung_tallent
10	2024-04-18	320.03913513700485	33	taivaanranta-tulitus	yung_tallent
10	2024-04-18	357.5960050233404	33	lumivyory-ammunta	yung_tallent
10	2024-04-18	306.37527879823114	34	kesan_ampujaiset	yung_tallent
10	2024-04-18	300.9673927640252	34	talvi_pistooli	yung_tallent
10	2024-04-18	319.85467676218826	34	tarkkuuslaukaus-festivaali	yung_tallent
10	2024-04-18	313.0930633751889	34	kivaarikilpailujen_huipennus	yung_tallent
10	2024-04-18	343.119888603173	34	polaris-ampumaharjoitus	yung_tallent
10	2024-04-18	324.36344626926996	34	aamunkoiton_tahtays	yung_tallent
10	2024-04-18	319.94592030540974	34	nordic_sharpshooters_cup	yung_tallent
10	2024-04-18	346.59524106887176	34	taivaanranta-tulitus	yung_tallent
10	2024-04-18	288.13254864032723	34	lumivyory-ammunta	yung_tallent
10	2024-04-18	299.4089343158896	35	kesan_ampujaiset	yung_tallent
10	2024-04-18	363.9433991523501	35	talvi_pistooli	yung_tallent
10	2024-04-18	355.14328405230634	35	tarkkuuslaukaus-festivaali	yung_tallent
10	2024-04-18	310.30742590334023	35	kivaarikilpailujen_huipennus	yung_tallent
10	2024-04-18	337.4077060035736	35	polaris-ampumaharjoitus	yung_tallent
10	2024-04-18	335.9872380125134	35	aamunkoiton_tahtays	yung_tallent
10	2024-04-18	342.20476395716844	35	nordic_sharpshooters_cup	yung_tallent
10	2024-04-18	319.2669143349731	35	taivaanranta-tulitus	yung_tallent
10	2024-04-18	319.5985608190523	35	lumivyory-ammunta	yung_tallent
10	2024-04-18	333.2281563139964	36	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	2024-04-18	338.0411199306557	36	talvi_pistooli	aseharrastajien_yhtenaisyys
10	2024-04-18	364.76090645162486	36	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	2024-04-18	324.58422340241907	36	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	2024-04-18	327.31735041796645	36	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	2024-04-18	341.36169363990416	36	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	2024-04-18	289.2344139907632	36	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	348.32093148816466	36	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	2024-04-18	327.5660372970477	36	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	2024-04-18	367.4274390045582	37	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	2024-04-18	346.5764865268934	37	talvi_pistooli	aseharrastajien_yhtenaisyys
10	2024-04-18	330.27163415720634	37	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	2024-04-18	324.42663911863855	37	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	2024-04-18	344.8603842556872	37	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	2024-04-18	347.2386197565089	37	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	2024-04-18	353.06017154554127	37	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	313.99516140627554	37	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	2024-04-18	292.1998865952649	37	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	2024-04-18	296.3574936391575	38	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	2024-04-18	347.70865938020717	38	talvi_pistooli	aseharrastajien_yhtenaisyys
10	2024-04-18	286.3842256035451	38	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	2024-04-18	331.9939861629092	38	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	2024-04-18	295.17412605979354	38	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	2024-04-18	329.1268416598079	38	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	2024-04-18	348.23938947716067	38	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	330.28948766884895	38	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	2024-04-18	336.7705577094099	38	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	2024-04-18	326.31301086452817	39	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	2024-04-18	316.85410696320247	39	talvi_pistooli	aseharrastajien_yhtenaisyys
10	2024-04-18	350.89907135246506	39	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	2024-04-18	325.90345669817447	39	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	2024-04-18	377.8612883985268	39	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	2024-04-18	383.85074019562626	39	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	2024-04-18	338.8679161073647	39	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	327.36456332028484	39	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	2024-04-18	344.0129919795426	39	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	2024-04-18	318.72570010189736	40	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	2024-04-18	326.80434818690594	40	talvi_pistooli	aseharrastajien_yhtenaisyys
10	2024-04-18	331.12695223856076	40	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	2024-04-18	312.221657045959	40	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	2024-04-18	342.35258767725526	40	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	2024-04-18	327.2957667801873	40	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	2024-04-18	312.2182088816874	40	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	2024-04-18	342.76592370817843	40	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	2024-04-18	351.4999441580702	40	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	2024-04-18	350.3831835141327	41	kesan_ampujaiset	tahtaysmestarit
10	2024-04-18	336.2074483766998	41	talvi_pistooli	tahtaysmestarit
10	2024-04-18	353.61152328932474	41	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	2024-04-18	320.1906600285888	41	kivaarikilpailujen_huipennus	tahtaysmestarit
10	2024-04-18	337.42443612245614	41	polaris-ampumaharjoitus	tahtaysmestarit
10	2024-04-18	295.1127484360337	41	aamunkoiton_tahtays	tahtaysmestarit
10	2024-04-18	359.30129589783496	41	nordic_sharpshooters_cup	tahtaysmestarit
10	2024-04-18	324.871537173589	41	taivaanranta-tulitus	tahtaysmestarit
10	2024-04-18	301.04388936332305	41	lumivyory-ammunta	tahtaysmestarit
10	2024-04-18	279.2487619047095	42	kesan_ampujaiset	tahtaysmestarit
10	2024-04-18	321.90625865103965	42	talvi_pistooli	tahtaysmestarit
10	2024-04-18	307.2779475259328	42	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	2024-04-18	377.38601422218136	42	kivaarikilpailujen_huipennus	tahtaysmestarit
10	2024-04-18	279.4938014091805	42	polaris-ampumaharjoitus	tahtaysmestarit
10	2024-04-18	333.41417548078493	42	aamunkoiton_tahtays	tahtaysmestarit
10	2024-04-18	362.7049233279548	42	nordic_sharpshooters_cup	tahtaysmestarit
10	2024-04-18	273.75297868683884	42	taivaanranta-tulitus	tahtaysmestarit
10	2024-04-18	357.7205877303412	42	lumivyory-ammunta	tahtaysmestarit
10	2024-04-18	356.12155859659447	43	kesan_ampujaiset	tahtaysmestarit
10	2024-04-18	284.04001017971217	43	talvi_pistooli	tahtaysmestarit
10	2024-04-18	301.1783442847389	43	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	2024-04-18	310.7994873298569	43	kivaarikilpailujen_huipennus	tahtaysmestarit
10	2024-04-18	323.05747656886757	43	polaris-ampumaharjoitus	tahtaysmestarit
10	2024-04-18	353.8495972748545	43	aamunkoiton_tahtays	tahtaysmestarit
10	2024-04-18	294.0266758378232	43	nordic_sharpshooters_cup	tahtaysmestarit
10	2024-04-18	366.6525407856632	43	taivaanranta-tulitus	tahtaysmestarit
10	2024-04-18	300.18628580775464	43	lumivyory-ammunta	tahtaysmestarit
10	2024-04-18	328.03994354775006	44	kesan_ampujaiset	laukausryhma_aurora
10	2024-04-18	300.52184282535563	44	talvi_pistooli	laukausryhma_aurora
10	2024-04-18	323.8462617550712	44	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	2024-04-18	345.1131982071324	44	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	2024-04-18	321.551322130746	44	polaris-ampumaharjoitus	laukausryhma_aurora
10	2024-04-18	329.18997687517776	44	aamunkoiton_tahtays	laukausryhma_aurora
10	2024-04-18	332.62910935478124	44	nordic_sharpshooters_cup	laukausryhma_aurora
10	2024-04-18	295.7827617577595	44	taivaanranta-tulitus	laukausryhma_aurora
10	2024-04-18	369.91261293900493	44	lumivyory-ammunta	laukausryhma_aurora
10	2024-04-18	345.9204112970337	45	kesan_ampujaiset	laukausryhma_aurora
10	2024-04-18	304.8491792897302	45	talvi_pistooli	laukausryhma_aurora
10	2024-04-18	304.4902766962173	45	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	2024-04-18	301.5131715298177	45	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	2024-04-18	290.53421112706394	45	polaris-ampumaharjoitus	laukausryhma_aurora
10	2024-04-18	322.4013748660297	45	aamunkoiton_tahtays	laukausryhma_aurora
10	2024-04-18	334.0027325680173	45	nordic_sharpshooters_cup	laukausryhma_aurora
10	2024-04-18	302.1202267306041	45	taivaanranta-tulitus	laukausryhma_aurora
10	2024-04-18	281.4558652312502	45	lumivyory-ammunta	laukausryhma_aurora
10	2024-04-18	351.52183191655683	46	kesan_ampujaiset	laukausryhma_aurora
10	2024-04-18	375.56691386025335	46	talvi_pistooli	laukausryhma_aurora
10	2024-04-18	334.33085409290356	46	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	2024-04-18	347.14474991941	46	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	2024-04-18	288.8181402819204	46	polaris-ampumaharjoitus	laukausryhma_aurora
10	2024-04-18	332.575430742163	46	aamunkoiton_tahtays	laukausryhma_aurora
10	2024-04-18	309.81547524372166	46	nordic_sharpshooters_cup	laukausryhma_aurora
10	2024-04-18	331.0531711095786	46	taivaanranta-tulitus	laukausryhma_aurora
10	2024-04-18	293.4210586729314	46	lumivyory-ammunta	laukausryhma_aurora
10	2024-04-18	313.6046400485534	47	kesan_ampujaiset	laukausryhma_aurora
10	2024-04-18	337.74975070888223	47	talvi_pistooli	laukausryhma_aurora
10	2024-04-18	312.1999962149573	47	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	2024-04-18	368.07245978561804	47	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	2024-04-18	365.50946488724884	47	polaris-ampumaharjoitus	laukausryhma_aurora
10	2024-04-18	318.0189477203188	47	aamunkoiton_tahtays	laukausryhma_aurora
10	2024-04-18	325.60499955108094	47	nordic_sharpshooters_cup	laukausryhma_aurora
10	2024-04-18	339.6841535130693	47	taivaanranta-tulitus	laukausryhma_aurora
10	2024-04-18	361.0802554765697	47	lumivyory-ammunta	laukausryhma_aurora
10	2024-04-18	349.2610931814139	48	kesan_ampujaiset	laukausryhma_aurora
10	2024-04-18	336.88416153472394	48	talvi_pistooli	laukausryhma_aurora
10	2024-04-18	305.0346190489689	48	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	2024-04-18	331.7739186112768	48	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	2024-04-18	298.2739836619417	48	polaris-ampumaharjoitus	laukausryhma_aurora
10	2024-04-18	331.8846200866048	48	aamunkoiton_tahtays	laukausryhma_aurora
10	2024-04-18	300.49558258887566	48	nordic_sharpshooters_cup	laukausryhma_aurora
10	2024-04-18	366.4650919297365	48	taivaanranta-tulitus	laukausryhma_aurora
10	2024-04-18	307.0432427594755	48	lumivyory-ammunta	laukausryhma_aurora
10	2024-04-18	306.67331146125343	49	kesan_ampujaiset	ampumataito
10	2024-04-18	314.1511072632387	49	talvi_pistooli	ampumataito
10	2024-04-18	336.13890267394464	49	tarkkuuslaukaus-festivaali	ampumataito
10	2024-04-18	335.34775958168774	49	kivaarikilpailujen_huipennus	ampumataito
10	2024-04-18	334.526724723208	49	polaris-ampumaharjoitus	ampumataito
10	2024-04-18	339.1753666993203	49	aamunkoiton_tahtays	ampumataito
10	2024-04-18	368.46627393833217	49	nordic_sharpshooters_cup	ampumataito
10	2024-04-18	336.6841787497408	49	taivaanranta-tulitus	ampumataito
10	2024-04-18	333.5582697096925	49	lumivyory-ammunta	ampumataito
10	2024-04-18	355.99899300560884	50	kesan_ampujaiset	ampumataito
10	2024-04-18	306.5175347898856	50	talvi_pistooli	ampumataito
10	2024-04-18	344.3711964661057	50	tarkkuuslaukaus-festivaali	ampumataito
10	2024-04-18	335.6032201672096	50	kivaarikilpailujen_huipennus	ampumataito
10	2024-04-18	324.3276128318471	50	polaris-ampumaharjoitus	ampumataito
10	2024-04-18	323.37565901896386	50	aamunkoiton_tahtays	ampumataito
10	2024-04-18	354.0623998915159	50	nordic_sharpshooters_cup	ampumataito
10	2024-04-18	322.2657179806114	50	taivaanranta-tulitus	ampumataito
10	2024-04-18	340.6006021691947	50	lumivyory-ammunta	ampumataito
10	2024-04-18	323.5732861495169	51	kesan_ampujaiset	ampumataito
10	2024-04-18	358.3494856991682	51	talvi_pistooli	ampumataito
10	2024-04-18	345.1590089661159	51	tarkkuuslaukaus-festivaali	ampumataito
10	2024-04-18	316.48104684083785	51	kivaarikilpailujen_huipennus	ampumataito
10	2024-04-18	327.44202944733917	51	polaris-ampumaharjoitus	ampumataito
10	2024-04-18	329.769652702398	51	aamunkoiton_tahtays	ampumataito
10	2024-04-18	368.43384338508656	51	nordic_sharpshooters_cup	ampumataito
10	2024-04-18	355.1575934503937	51	taivaanranta-tulitus	ampumataito
10	2024-04-18	349.96905315192765	51	lumivyory-ammunta	ampumataito
10	2024-04-18	277.7019326133766	52	kesan_ampujaiset	ampumataito
10	2024-04-18	346.0094809925728	52	talvi_pistooli	ampumataito
10	2024-04-18	337.55738519677266	52	tarkkuuslaukaus-festivaali	ampumataito
10	2024-04-18	341.80565372455635	52	kivaarikilpailujen_huipennus	ampumataito
10	2024-04-18	290.656770629848	52	polaris-ampumaharjoitus	ampumataito
10	2024-04-18	310.15814213686633	52	aamunkoiton_tahtays	ampumataito
10	2024-04-18	328.61105777870847	52	nordic_sharpshooters_cup	ampumataito
10	2024-04-18	335.01728346405633	52	taivaanranta-tulitus	ampumataito
10	2024-04-18	349.5127511995553	52	lumivyory-ammunta	ampumataito
10	2024-04-18	300.83005058669625	53	kesan_ampujaiset	ampumataito
10	2024-04-18	288.063240087149	53	talvi_pistooli	ampumataito
10	2024-04-18	357.25305318171945	53	tarkkuuslaukaus-festivaali	ampumataito
10	2024-04-18	299.77901815209447	53	kivaarikilpailujen_huipennus	ampumataito
10	2024-04-18	303.8690280527188	53	polaris-ampumaharjoitus	ampumataito
10	2024-04-18	359.1412379637511	53	aamunkoiton_tahtays	ampumataito
10	2024-04-18	331.55285005607925	53	nordic_sharpshooters_cup	ampumataito
10	2024-04-18	324.30869917858786	53	taivaanranta-tulitus	ampumataito
10	2024-04-18	341.0660594978294	53	lumivyory-ammunta	ampumataito
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_ (creation_date, last_login, id, email, legal_name, part_of_club, password, username) FROM stdin;
\N	\N	1	\N	Helena Lehtinen	poliisiseura	\N	gONVRFDkIK
\N	\N	2	\N	Liisa Laine	poliisiseura	\N	H4Ec1ugOjn
\N	\N	3	\N	Maria Kumpulainen	poliisiseura	\N	vK5DREvyff
\N	\N	4	\N	Kaarina Mäkinen	poliisiseura	\N	eAdvBlFl0C
\N	\N	5	\N	Matti Korhonen	koiraseura	\N	kc6HsQwoa2
\N	\N	6	\N	Ilmari Nieminen	koiraseura	\N	GG7tau1eQy
\N	\N	7	\N	Kalevi Heikkinen	koiraseura	\N	CLRRcxk4j8
\N	\N	8	\N	Tapani Heikkinen	koiraseura	\N	g7ot23Af5g
\N	\N	9	\N	Maria Laine	hammaspeikkoseura	\N	Q3ypX6ofXo
\N	\N	10	\N	Mikael Mäkelä	hammaspeikkoseura	\N	xcWVrXvJLa
\N	\N	11	\N	Johannes Juustila	hammaspeikkoseura	\N	Bd8sg3tMnQ
\N	\N	12	\N	Kaarina Juustila	hammaspeikkoseura	\N	FWRX5Uq0aD
\N	\N	13	\N	Helena Kelanti	dog	\N	94YruEQ6NT
\N	\N	14	\N	Marjatta Mäkinen	dog	\N	eGtDpt0bjh
\N	\N	15	\N	Olavi Korhonen	dog	\N	10AG1UJcDe
\N	\N	16	\N	Kaarina Heikkinen	dog	\N	7xM5loIcub
\N	\N	17	\N	Matti Laine	dog	\N	eQQX6BBx9w
\N	\N	18	\N	Kalevi Nieminen	savu_seura	\N	VdIQOD3f1W
\N	\N	19	\N	Helena Juustila	savu_seura	\N	GjBsgRlXNv
\N	\N	20	\N	Olavi Korhonen	savu_seura	\N	jWJNPNvHh6
\N	\N	21	\N	Antero Holappa	savu_seura	\N	jDgj5oWbDR
\N	\N	22	\N	Anneli Juustila	omas	\N	sobvArfL9g
\N	\N	23	\N	Marjatta Komulainen	omas	\N	3nNL1Y04uJ
\N	\N	24	\N	Maria Korhonen	omas	\N	0V7uvQGrcu
\N	\N	25	\N	Anneli Lehtinen	omas	\N	ydluXV9mf1
\N	\N	26	\N	Kalevi Virtanen	omas	\N	lELHlg8KrI
\N	\N	27	\N	Anna Hämäläinen	pelleseura	\N	k4In2x501R
\N	\N	28	\N	Johannes Holappa	pelleseura	\N	pnjp3V5b7h
\N	\N	29	\N	Mikael Mäkelä	pelleseura	\N	WVmcbjQ47n
\N	\N	30	\N	Maria Mäkinen	pelleseura	\N	kdilVNc4wK
\N	\N	31	\N	Olavi Komulainen	pelleseura	\N	fm0dnJCcFI
\N	\N	32	\N	Mikael Laine	yung_tallent	\N	yrKnkxAcw1
\N	\N	33	\N	Helena Holappa	yung_tallent	\N	5cKi29IV8D
\N	\N	34	\N	Helena Ollakka	yung_tallent	\N	kahrYd5ZjP
\N	\N	35	\N	Helena Mäkelä	yung_tallent	\N	XeZHVoZwZU
\N	\N	36	\N	Liisa Juustila	aseharrastajien_yhtenaisyys	\N	KtQSKwOafN
\N	\N	37	\N	Liisa Juustila	aseharrastajien_yhtenaisyys	\N	oppksNcKeI
\N	\N	38	\N	Anna Juustila	aseharrastajien_yhtenaisyys	\N	C2iSo1dClM
\N	\N	39	\N	Liisa Komulainen	aseharrastajien_yhtenaisyys	\N	pRyaHgZOog
\N	\N	40	\N	Tapio Juustila	aseharrastajien_yhtenaisyys	\N	khLvDEw2cR
\N	\N	41	\N	Marjatta Komulainen	tahtaysmestarit	\N	lDea3iY3Ti
\N	\N	42	\N	Helena Hämäläinen	tahtaysmestarit	\N	r2zPl0e8Xp
\N	\N	43	\N	Tapani Ollakka	tahtaysmestarit	\N	D0mSIyT79f
\N	\N	44	\N	Tapio Koskinen	laukausryhma_aurora	\N	acOb2Gli8y
\N	\N	45	\N	Johannes Mäkinen	laukausryhma_aurora	\N	0c8pSiiOGk
\N	\N	46	\N	Matti Hämäläinen	laukausryhma_aurora	\N	fPCO7sjrH4
\N	\N	47	\N	Marjatta Mäkelä	laukausryhma_aurora	\N	GP8RfZ9V3O
\N	\N	48	\N	Kaarina Holappa	laukausryhma_aurora	\N	7BTL5lCBG2
\N	\N	49	\N	Matti Hämäläinen	ampumataito	\N	kdrE4g4YX6
\N	\N	50	\N	Ilmari Korhonen	ampumataito	\N	DFUj9baigI
\N	\N	51	\N	Kaarina Koskinen	ampumataito	\N	NJpmiAwk3Q
\N	\N	52	\N	Juhani Laine	ampumataito	\N	xh0BcpN8xR
\N	\N	53	\N	Johanna Nieminen	ampumataito	\N	03Yj6vE7Ic
2024-04-18	\N	54	admin	admin	\N	$2a$10$AW0Nuh116JUJlJ/1VGenjubOsOJFH8rW27B0FSXds5j5brY3HkY9a	admin
\.


--
-- Name: user__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user__id_seq', 54, true);


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

