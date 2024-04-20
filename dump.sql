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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: club; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.club (
    creation_date timestamp(6) without time zone,
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
    creation_date timestamp(6) without time zone NOT NULL,
    end_date timestamp(6) without time zone,
    start_date timestamp(6) without time zone,
    competition_id character varying(255) NOT NULL,
    display_name character varying(255),
    type character varying(255)
);


ALTER TABLE public.competition OWNER TO postgres;

--
-- Name: image_proof; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image_proof (
    time_stamp timestamp(6) without time zone,
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
    sum double precision NOT NULL,
    creation_date timestamp(6) without time zone,
    user_id bigint NOT NULL,
    competition_id character varying(255) NOT NULL,
    team_name character varying(255) NOT NULL
);


ALTER TABLE public.team_member_score OWNER TO postgres;

--
-- Name: user_; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_ (
    creation_date timestamp(6) without time zone,
    id bigint NOT NULL,
    last_login timestamp(6) without time zone,
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
2024-04-20 19:24:24.873	0	poliisiseura	Poliisiseura	\N
2024-04-20 19:24:24.877	0	koiraseura	Koiraseura	\N
2024-04-20 19:24:24.88	0	hammaspeikkoseura	Hammaspeikkoseura	\N
2024-04-20 19:24:24.882	0	dog	dog	\N
2024-04-20 19:24:24.885	0	savu_seura	Savu Seura	\N
2024-04-20 19:24:24.887	0	omas	OMAS	\N
2024-04-20 19:24:24.89	0	pelleseura	Pelleseura	\N
2024-04-20 19:24:24.893	0	yung_tallent	Yung Tallent	\N
2024-04-20 19:24:24.895	0	aseharrastajien_yhtenaisyys	Aseharrastajien Yhtenäisyys	\N
2024-04-20 19:24:24.898	0	tahtaysmestarit	Tähtäysmestarit	\N
2024-04-20 19:24:24.901	0	laukausryhma_aurora	Laukausryhmä Aurora	\N
2024-04-20 19:24:24.903	0	ampumataito	Ampumataito	\N
\.


--
-- Data for Name: competition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition (creation_date, end_date, start_date, competition_id, display_name, type) FROM stdin;
2024-04-20 19:24:24.959	2024-08-26 19:24:24.959	2023-03-09 18:24:24.959	kesan_ampujaiset	Kesän Ampujaiset	rifle
2024-04-20 19:24:24.959	2027-01-10 18:24:24.959	2025-11-28 18:24:24.959	talvi_pistooli	Talvi Pistooli	rifle
2024-04-20 19:24:24.959	2025-10-11 19:24:24.959	2024-03-20 18:24:24.959	tarkkuuslaukaus-festivaali	Tarkkuuslaukaus-festivaali	rifle
2024-04-20 19:24:24.959	2024-07-27 19:24:24.959	2024-06-16 19:24:24.959	kivaarikilpailujen_huipennus	Kiväärikilpailujen huipennus	rifle
2024-04-20 19:24:24.959	2024-05-01 19:24:24.959	2024-04-16 19:24:24.959	polaris-ampumaharjoitus	Polaris-ampumaharjoitus	rifle
2024-04-20 19:24:24.959	2026-11-23 18:24:24.959	2026-03-29 19:24:24.959	aamunkoiton_tahtays	Aamunkoiton tähtäys	rifle
2024-04-20 19:24:24.959	2024-06-28 19:24:24.959	2024-06-01 19:24:24.959	nordic_sharpshooters_cup	Nordic Sharpshooters Cup	rifle
2024-04-20 19:24:24.959	2024-05-06 19:24:24.959	2024-03-25 18:24:24.959	taivaanranta-tulitus	Taivaanranta-tulitus	rifle
2024-04-20 19:24:24.959	2025-12-27 18:24:24.959	2024-10-30 18:24:24.959	lumivyory-ammunta	Lumivyöry-ammunta	rifle
2024-04-20 19:24:24.975	2024-01-21 18:24:24.975	2022-09-26 19:24:24.975	tarkka-ammunta_cup	Tarkka-ammunta Cup	pistol
2024-04-20 19:24:24.975	2024-06-30 19:24:24.975	2024-05-20 19:24:24.975	nopean_laukauksen_mestaruus	Nopean laukauksen mestaruus	pistol
2024-04-20 19:24:24.975	2027-02-04 18:24:24.975	2025-11-01 18:24:24.975	moniottelu	Moniottelu	pistol
2024-04-20 19:24:24.975	2024-03-21 18:24:24.975	2024-02-21 18:24:24.975	kansallinen_tahtayskilpailu	Kansallinen tähtäyskilpailu	pistol
2024-04-20 19:24:24.975	2025-06-20 19:24:24.975	2024-06-18 19:24:24.975	kaupunkiammunta-challenge	Kaupunkiammunta-challenge	pistol
2024-04-20 19:24:24.975	2024-11-14 18:24:24.975	2024-04-02 19:24:24.975	laukausmaraton	Laukausmaraton	pistol
2024-04-20 19:24:24.975	2024-07-10 19:24:24.975	2024-05-27 19:24:24.975	vapaa-asekilpailu	Vapaa-asekilpailu	pistol
2024-04-20 19:24:24.975	2025-11-08 18:24:24.975	2024-11-26 18:24:24.975	taitoluodikko-turnaus	Taitoluodikko-turnaus	pistol
2024-04-20 19:24:24.975	2024-09-14 19:24:24.975	2024-07-16 19:24:24.975	precision_pistol_cup	Precision Pistol Cup	pistol
2024-04-20 19:24:24.975	2026-04-09 19:24:24.975	2024-08-23 19:24:24.975	tulevaisuuden_ampuja	Tulevaisuuden Ampuja	pistol
2024-04-20 19:24:24.975	2024-06-22 19:24:24.975	2024-06-06 19:24:24.975	pikakivaari-klassikko	Pikakivääri-klassikko	pistol
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
8	tarkka-ammunta_cup	hammaspeikkoseura
8	nopean_laukauksen_mestaruus	hammaspeikkoseura
8	moniottelu	hammaspeikkoseura
8	kansallinen_tahtayskilpailu	hammaspeikkoseura
8	kaupunkiammunta-challenge	hammaspeikkoseura
8	laukausmaraton	hammaspeikkoseura
8	vapaa-asekilpailu	hammaspeikkoseura
8	taitoluodikko-turnaus	hammaspeikkoseura
8	precision_pistol_cup	hammaspeikkoseura
8	tulevaisuuden_ampuja	hammaspeikkoseura
8	pikakivaari-klassikko	hammaspeikkoseura
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
11	tarkka-ammunta_cup	dog
11	nopean_laukauksen_mestaruus	dog
11	moniottelu	dog
11	kansallinen_tahtayskilpailu	dog
11	kaupunkiammunta-challenge	dog
11	laukausmaraton	dog
11	vapaa-asekilpailu	dog
11	taitoluodikko-turnaus	dog
11	precision_pistol_cup	dog
11	tulevaisuuden_ampuja	dog
11	pikakivaari-klassikko	dog
12	tarkka-ammunta_cup	dog
12	nopean_laukauksen_mestaruus	dog
12	moniottelu	dog
12	kansallinen_tahtayskilpailu	dog
12	kaupunkiammunta-challenge	dog
12	laukausmaraton	dog
12	vapaa-asekilpailu	dog
12	taitoluodikko-turnaus	dog
12	precision_pistol_cup	dog
12	tulevaisuuden_ampuja	dog
12	pikakivaari-klassikko	dog
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
14	tarkka-ammunta_cup	savu_seura
14	nopean_laukauksen_mestaruus	savu_seura
14	moniottelu	savu_seura
14	kansallinen_tahtayskilpailu	savu_seura
14	kaupunkiammunta-challenge	savu_seura
14	laukausmaraton	savu_seura
14	vapaa-asekilpailu	savu_seura
14	taitoluodikko-turnaus	savu_seura
14	precision_pistol_cup	savu_seura
14	tulevaisuuden_ampuja	savu_seura
14	pikakivaari-klassikko	savu_seura
15	tarkka-ammunta_cup	savu_seura
15	nopean_laukauksen_mestaruus	savu_seura
15	moniottelu	savu_seura
15	kansallinen_tahtayskilpailu	savu_seura
15	kaupunkiammunta-challenge	savu_seura
15	laukausmaraton	savu_seura
15	vapaa-asekilpailu	savu_seura
15	taitoluodikko-turnaus	savu_seura
15	precision_pistol_cup	savu_seura
15	tulevaisuuden_ampuja	savu_seura
15	pikakivaari-klassikko	savu_seura
16	tarkka-ammunta_cup	savu_seura
16	nopean_laukauksen_mestaruus	savu_seura
16	moniottelu	savu_seura
16	kansallinen_tahtayskilpailu	savu_seura
16	kaupunkiammunta-challenge	savu_seura
16	laukausmaraton	savu_seura
16	vapaa-asekilpailu	savu_seura
16	taitoluodikko-turnaus	savu_seura
16	precision_pistol_cup	savu_seura
16	tulevaisuuden_ampuja	savu_seura
16	pikakivaari-klassikko	savu_seura
17	tarkka-ammunta_cup	savu_seura
17	nopean_laukauksen_mestaruus	savu_seura
17	moniottelu	savu_seura
17	kansallinen_tahtayskilpailu	savu_seura
17	kaupunkiammunta-challenge	savu_seura
17	laukausmaraton	savu_seura
17	vapaa-asekilpailu	savu_seura
17	taitoluodikko-turnaus	savu_seura
17	precision_pistol_cup	savu_seura
17	tulevaisuuden_ampuja	savu_seura
17	pikakivaari-klassikko	savu_seura
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
19	tarkka-ammunta_cup	omas
19	nopean_laukauksen_mestaruus	omas
19	moniottelu	omas
19	kansallinen_tahtayskilpailu	omas
19	kaupunkiammunta-challenge	omas
19	laukausmaraton	omas
19	vapaa-asekilpailu	omas
19	taitoluodikko-turnaus	omas
19	precision_pistol_cup	omas
19	tulevaisuuden_ampuja	omas
19	pikakivaari-klassikko	omas
20	tarkka-ammunta_cup	omas
20	nopean_laukauksen_mestaruus	omas
20	moniottelu	omas
20	kansallinen_tahtayskilpailu	omas
20	kaupunkiammunta-challenge	omas
20	laukausmaraton	omas
20	vapaa-asekilpailu	omas
20	taitoluodikko-turnaus	omas
20	precision_pistol_cup	omas
20	tulevaisuuden_ampuja	omas
20	pikakivaari-klassikko	omas
21	tarkka-ammunta_cup	omas
21	nopean_laukauksen_mestaruus	omas
21	moniottelu	omas
21	kansallinen_tahtayskilpailu	omas
21	kaupunkiammunta-challenge	omas
21	laukausmaraton	omas
21	vapaa-asekilpailu	omas
21	taitoluodikko-turnaus	omas
21	precision_pistol_cup	omas
21	tulevaisuuden_ampuja	omas
21	pikakivaari-klassikko	omas
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
23	tarkka-ammunta_cup	pelleseura
23	nopean_laukauksen_mestaruus	pelleseura
23	moniottelu	pelleseura
23	kansallinen_tahtayskilpailu	pelleseura
23	kaupunkiammunta-challenge	pelleseura
23	laukausmaraton	pelleseura
23	vapaa-asekilpailu	pelleseura
23	taitoluodikko-turnaus	pelleseura
23	precision_pistol_cup	pelleseura
23	tulevaisuuden_ampuja	pelleseura
23	pikakivaari-klassikko	pelleseura
24	tarkka-ammunta_cup	pelleseura
24	nopean_laukauksen_mestaruus	pelleseura
24	moniottelu	pelleseura
24	kansallinen_tahtayskilpailu	pelleseura
24	kaupunkiammunta-challenge	pelleseura
24	laukausmaraton	pelleseura
24	vapaa-asekilpailu	pelleseura
24	taitoluodikko-turnaus	pelleseura
24	precision_pistol_cup	pelleseura
24	tulevaisuuden_ampuja	pelleseura
24	pikakivaari-klassikko	pelleseura
25	tarkka-ammunta_cup	pelleseura
25	nopean_laukauksen_mestaruus	pelleseura
25	moniottelu	pelleseura
25	kansallinen_tahtayskilpailu	pelleseura
25	kaupunkiammunta-challenge	pelleseura
25	laukausmaraton	pelleseura
25	vapaa-asekilpailu	pelleseura
25	taitoluodikko-turnaus	pelleseura
25	precision_pistol_cup	pelleseura
25	tulevaisuuden_ampuja	pelleseura
25	pikakivaari-klassikko	pelleseura
26	tarkka-ammunta_cup	pelleseura
26	nopean_laukauksen_mestaruus	pelleseura
26	moniottelu	pelleseura
26	kansallinen_tahtayskilpailu	pelleseura
26	kaupunkiammunta-challenge	pelleseura
26	laukausmaraton	pelleseura
26	vapaa-asekilpailu	pelleseura
26	taitoluodikko-turnaus	pelleseura
26	precision_pistol_cup	pelleseura
26	tulevaisuuden_ampuja	pelleseura
26	pikakivaari-klassikko	pelleseura
27	tarkka-ammunta_cup	yung_tallent
27	nopean_laukauksen_mestaruus	yung_tallent
27	moniottelu	yung_tallent
27	kansallinen_tahtayskilpailu	yung_tallent
27	kaupunkiammunta-challenge	yung_tallent
27	laukausmaraton	yung_tallent
27	vapaa-asekilpailu	yung_tallent
27	taitoluodikko-turnaus	yung_tallent
27	precision_pistol_cup	yung_tallent
27	tulevaisuuden_ampuja	yung_tallent
27	pikakivaari-klassikko	yung_tallent
28	tarkka-ammunta_cup	yung_tallent
28	nopean_laukauksen_mestaruus	yung_tallent
28	moniottelu	yung_tallent
28	kansallinen_tahtayskilpailu	yung_tallent
28	kaupunkiammunta-challenge	yung_tallent
28	laukausmaraton	yung_tallent
28	vapaa-asekilpailu	yung_tallent
28	taitoluodikko-turnaus	yung_tallent
28	precision_pistol_cup	yung_tallent
28	tulevaisuuden_ampuja	yung_tallent
28	pikakivaari-klassikko	yung_tallent
29	tarkka-ammunta_cup	yung_tallent
29	nopean_laukauksen_mestaruus	yung_tallent
29	moniottelu	yung_tallent
29	kansallinen_tahtayskilpailu	yung_tallent
29	kaupunkiammunta-challenge	yung_tallent
29	laukausmaraton	yung_tallent
29	vapaa-asekilpailu	yung_tallent
29	taitoluodikko-turnaus	yung_tallent
29	precision_pistol_cup	yung_tallent
29	tulevaisuuden_ampuja	yung_tallent
29	pikakivaari-klassikko	yung_tallent
30	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
30	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
30	moniottelu	aseharrastajien_yhtenaisyys
30	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
30	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
30	laukausmaraton	aseharrastajien_yhtenaisyys
30	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
30	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
30	precision_pistol_cup	aseharrastajien_yhtenaisyys
30	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
30	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
31	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
31	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
31	moniottelu	aseharrastajien_yhtenaisyys
31	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
31	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
31	laukausmaraton	aseharrastajien_yhtenaisyys
31	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
31	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
31	precision_pistol_cup	aseharrastajien_yhtenaisyys
31	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
31	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
32	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
32	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
32	moniottelu	aseharrastajien_yhtenaisyys
32	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
32	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
32	laukausmaraton	aseharrastajien_yhtenaisyys
32	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
32	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
32	precision_pistol_cup	aseharrastajien_yhtenaisyys
32	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
32	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
33	tarkka-ammunta_cup	tahtaysmestarit
33	nopean_laukauksen_mestaruus	tahtaysmestarit
33	moniottelu	tahtaysmestarit
33	kansallinen_tahtayskilpailu	tahtaysmestarit
33	kaupunkiammunta-challenge	tahtaysmestarit
33	laukausmaraton	tahtaysmestarit
33	vapaa-asekilpailu	tahtaysmestarit
33	taitoluodikko-turnaus	tahtaysmestarit
33	precision_pistol_cup	tahtaysmestarit
33	tulevaisuuden_ampuja	tahtaysmestarit
33	pikakivaari-klassikko	tahtaysmestarit
34	tarkka-ammunta_cup	tahtaysmestarit
34	nopean_laukauksen_mestaruus	tahtaysmestarit
34	moniottelu	tahtaysmestarit
34	kansallinen_tahtayskilpailu	tahtaysmestarit
34	kaupunkiammunta-challenge	tahtaysmestarit
34	laukausmaraton	tahtaysmestarit
34	vapaa-asekilpailu	tahtaysmestarit
34	taitoluodikko-turnaus	tahtaysmestarit
34	precision_pistol_cup	tahtaysmestarit
34	tulevaisuuden_ampuja	tahtaysmestarit
34	pikakivaari-klassikko	tahtaysmestarit
35	tarkka-ammunta_cup	tahtaysmestarit
35	nopean_laukauksen_mestaruus	tahtaysmestarit
35	moniottelu	tahtaysmestarit
35	kansallinen_tahtayskilpailu	tahtaysmestarit
35	kaupunkiammunta-challenge	tahtaysmestarit
35	laukausmaraton	tahtaysmestarit
35	vapaa-asekilpailu	tahtaysmestarit
35	taitoluodikko-turnaus	tahtaysmestarit
35	precision_pistol_cup	tahtaysmestarit
35	tulevaisuuden_ampuja	tahtaysmestarit
35	pikakivaari-klassikko	tahtaysmestarit
36	tarkka-ammunta_cup	tahtaysmestarit
36	nopean_laukauksen_mestaruus	tahtaysmestarit
36	moniottelu	tahtaysmestarit
36	kansallinen_tahtayskilpailu	tahtaysmestarit
36	kaupunkiammunta-challenge	tahtaysmestarit
36	laukausmaraton	tahtaysmestarit
36	vapaa-asekilpailu	tahtaysmestarit
36	taitoluodikko-turnaus	tahtaysmestarit
36	precision_pistol_cup	tahtaysmestarit
36	tulevaisuuden_ampuja	tahtaysmestarit
36	pikakivaari-klassikko	tahtaysmestarit
37	tarkka-ammunta_cup	tahtaysmestarit
37	nopean_laukauksen_mestaruus	tahtaysmestarit
37	moniottelu	tahtaysmestarit
37	kansallinen_tahtayskilpailu	tahtaysmestarit
37	kaupunkiammunta-challenge	tahtaysmestarit
37	laukausmaraton	tahtaysmestarit
37	vapaa-asekilpailu	tahtaysmestarit
37	taitoluodikko-turnaus	tahtaysmestarit
37	precision_pistol_cup	tahtaysmestarit
37	tulevaisuuden_ampuja	tahtaysmestarit
37	pikakivaari-klassikko	tahtaysmestarit
38	tarkka-ammunta_cup	laukausryhma_aurora
38	nopean_laukauksen_mestaruus	laukausryhma_aurora
38	moniottelu	laukausryhma_aurora
38	kansallinen_tahtayskilpailu	laukausryhma_aurora
38	kaupunkiammunta-challenge	laukausryhma_aurora
38	laukausmaraton	laukausryhma_aurora
38	vapaa-asekilpailu	laukausryhma_aurora
38	taitoluodikko-turnaus	laukausryhma_aurora
38	precision_pistol_cup	laukausryhma_aurora
38	tulevaisuuden_ampuja	laukausryhma_aurora
38	pikakivaari-klassikko	laukausryhma_aurora
39	tarkka-ammunta_cup	laukausryhma_aurora
39	nopean_laukauksen_mestaruus	laukausryhma_aurora
39	moniottelu	laukausryhma_aurora
39	kansallinen_tahtayskilpailu	laukausryhma_aurora
39	kaupunkiammunta-challenge	laukausryhma_aurora
39	laukausmaraton	laukausryhma_aurora
39	vapaa-asekilpailu	laukausryhma_aurora
39	taitoluodikko-turnaus	laukausryhma_aurora
39	precision_pistol_cup	laukausryhma_aurora
39	tulevaisuuden_ampuja	laukausryhma_aurora
39	pikakivaari-klassikko	laukausryhma_aurora
40	tarkka-ammunta_cup	laukausryhma_aurora
40	nopean_laukauksen_mestaruus	laukausryhma_aurora
40	moniottelu	laukausryhma_aurora
40	kansallinen_tahtayskilpailu	laukausryhma_aurora
40	kaupunkiammunta-challenge	laukausryhma_aurora
40	laukausmaraton	laukausryhma_aurora
40	vapaa-asekilpailu	laukausryhma_aurora
40	taitoluodikko-turnaus	laukausryhma_aurora
40	precision_pistol_cup	laukausryhma_aurora
40	tulevaisuuden_ampuja	laukausryhma_aurora
40	pikakivaari-klassikko	laukausryhma_aurora
41	tarkka-ammunta_cup	ampumataito
41	nopean_laukauksen_mestaruus	ampumataito
41	moniottelu	ampumataito
41	kansallinen_tahtayskilpailu	ampumataito
41	kaupunkiammunta-challenge	ampumataito
41	laukausmaraton	ampumataito
41	vapaa-asekilpailu	ampumataito
41	taitoluodikko-turnaus	ampumataito
41	precision_pistol_cup	ampumataito
41	tulevaisuuden_ampuja	ampumataito
41	pikakivaari-klassikko	ampumataito
42	tarkka-ammunta_cup	ampumataito
42	nopean_laukauksen_mestaruus	ampumataito
42	moniottelu	ampumataito
42	kansallinen_tahtayskilpailu	ampumataito
42	kaupunkiammunta-challenge	ampumataito
42	laukausmaraton	ampumataito
42	vapaa-asekilpailu	ampumataito
42	taitoluodikko-turnaus	ampumataito
42	precision_pistol_cup	ampumataito
42	tulevaisuuden_ampuja	ampumataito
42	pikakivaari-klassikko	ampumataito
43	tarkka-ammunta_cup	ampumataito
43	nopean_laukauksen_mestaruus	ampumataito
43	moniottelu	ampumataito
43	kansallinen_tahtayskilpailu	ampumataito
43	kaupunkiammunta-challenge	ampumataito
43	laukausmaraton	ampumataito
43	vapaa-asekilpailu	ampumataito
43	taitoluodikko-turnaus	ampumataito
43	precision_pistol_cup	ampumataito
43	tulevaisuuden_ampuja	ampumataito
43	pikakivaari-klassikko	ampumataito
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
8	kesan_ampujaiset	hammaspeikkoseura
8	talvi_pistooli	hammaspeikkoseura
8	tarkkuuslaukaus-festivaali	hammaspeikkoseura
8	kivaarikilpailujen_huipennus	hammaspeikkoseura
8	polaris-ampumaharjoitus	hammaspeikkoseura
8	aamunkoiton_tahtays	hammaspeikkoseura
8	nordic_sharpshooters_cup	hammaspeikkoseura
8	taivaanranta-tulitus	hammaspeikkoseura
8	lumivyory-ammunta	hammaspeikkoseura
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
11	kesan_ampujaiset	dog
11	talvi_pistooli	dog
11	tarkkuuslaukaus-festivaali	dog
11	kivaarikilpailujen_huipennus	dog
11	polaris-ampumaharjoitus	dog
11	aamunkoiton_tahtays	dog
11	nordic_sharpshooters_cup	dog
11	taivaanranta-tulitus	dog
11	lumivyory-ammunta	dog
12	kesan_ampujaiset	dog
12	talvi_pistooli	dog
12	tarkkuuslaukaus-festivaali	dog
12	kivaarikilpailujen_huipennus	dog
12	polaris-ampumaharjoitus	dog
12	aamunkoiton_tahtays	dog
12	nordic_sharpshooters_cup	dog
12	taivaanranta-tulitus	dog
12	lumivyory-ammunta	dog
13	kesan_ampujaiset	dog
13	talvi_pistooli	dog
13	tarkkuuslaukaus-festivaali	dog
13	kivaarikilpailujen_huipennus	dog
13	polaris-ampumaharjoitus	dog
13	aamunkoiton_tahtays	dog
13	nordic_sharpshooters_cup	dog
13	taivaanranta-tulitus	dog
13	lumivyory-ammunta	dog
14	kesan_ampujaiset	savu_seura
14	talvi_pistooli	savu_seura
14	tarkkuuslaukaus-festivaali	savu_seura
14	kivaarikilpailujen_huipennus	savu_seura
14	polaris-ampumaharjoitus	savu_seura
14	aamunkoiton_tahtays	savu_seura
14	nordic_sharpshooters_cup	savu_seura
14	taivaanranta-tulitus	savu_seura
14	lumivyory-ammunta	savu_seura
15	kesan_ampujaiset	savu_seura
15	talvi_pistooli	savu_seura
15	tarkkuuslaukaus-festivaali	savu_seura
15	kivaarikilpailujen_huipennus	savu_seura
15	polaris-ampumaharjoitus	savu_seura
15	aamunkoiton_tahtays	savu_seura
15	nordic_sharpshooters_cup	savu_seura
15	taivaanranta-tulitus	savu_seura
15	lumivyory-ammunta	savu_seura
16	kesan_ampujaiset	savu_seura
16	talvi_pistooli	savu_seura
16	tarkkuuslaukaus-festivaali	savu_seura
16	kivaarikilpailujen_huipennus	savu_seura
16	polaris-ampumaharjoitus	savu_seura
16	aamunkoiton_tahtays	savu_seura
16	nordic_sharpshooters_cup	savu_seura
16	taivaanranta-tulitus	savu_seura
16	lumivyory-ammunta	savu_seura
17	kesan_ampujaiset	savu_seura
17	talvi_pistooli	savu_seura
17	tarkkuuslaukaus-festivaali	savu_seura
17	kivaarikilpailujen_huipennus	savu_seura
17	polaris-ampumaharjoitus	savu_seura
17	aamunkoiton_tahtays	savu_seura
17	nordic_sharpshooters_cup	savu_seura
17	taivaanranta-tulitus	savu_seura
17	lumivyory-ammunta	savu_seura
18	kesan_ampujaiset	savu_seura
18	talvi_pistooli	savu_seura
18	tarkkuuslaukaus-festivaali	savu_seura
18	kivaarikilpailujen_huipennus	savu_seura
18	polaris-ampumaharjoitus	savu_seura
18	aamunkoiton_tahtays	savu_seura
18	nordic_sharpshooters_cup	savu_seura
18	taivaanranta-tulitus	savu_seura
18	lumivyory-ammunta	savu_seura
19	kesan_ampujaiset	omas
19	talvi_pistooli	omas
19	tarkkuuslaukaus-festivaali	omas
19	kivaarikilpailujen_huipennus	omas
19	polaris-ampumaharjoitus	omas
19	aamunkoiton_tahtays	omas
19	nordic_sharpshooters_cup	omas
19	taivaanranta-tulitus	omas
19	lumivyory-ammunta	omas
20	kesan_ampujaiset	omas
20	talvi_pistooli	omas
20	tarkkuuslaukaus-festivaali	omas
20	kivaarikilpailujen_huipennus	omas
20	polaris-ampumaharjoitus	omas
20	aamunkoiton_tahtays	omas
20	nordic_sharpshooters_cup	omas
20	taivaanranta-tulitus	omas
20	lumivyory-ammunta	omas
21	kesan_ampujaiset	omas
21	talvi_pistooli	omas
21	tarkkuuslaukaus-festivaali	omas
21	kivaarikilpailujen_huipennus	omas
21	polaris-ampumaharjoitus	omas
21	aamunkoiton_tahtays	omas
21	nordic_sharpshooters_cup	omas
21	taivaanranta-tulitus	omas
21	lumivyory-ammunta	omas
22	kesan_ampujaiset	omas
22	talvi_pistooli	omas
22	tarkkuuslaukaus-festivaali	omas
22	kivaarikilpailujen_huipennus	omas
22	polaris-ampumaharjoitus	omas
22	aamunkoiton_tahtays	omas
22	nordic_sharpshooters_cup	omas
22	taivaanranta-tulitus	omas
22	lumivyory-ammunta	omas
23	kesan_ampujaiset	pelleseura
23	talvi_pistooli	pelleseura
23	tarkkuuslaukaus-festivaali	pelleseura
23	kivaarikilpailujen_huipennus	pelleseura
23	polaris-ampumaharjoitus	pelleseura
23	aamunkoiton_tahtays	pelleseura
23	nordic_sharpshooters_cup	pelleseura
23	taivaanranta-tulitus	pelleseura
23	lumivyory-ammunta	pelleseura
24	kesan_ampujaiset	pelleseura
24	talvi_pistooli	pelleseura
24	tarkkuuslaukaus-festivaali	pelleseura
24	kivaarikilpailujen_huipennus	pelleseura
24	polaris-ampumaharjoitus	pelleseura
24	aamunkoiton_tahtays	pelleseura
24	nordic_sharpshooters_cup	pelleseura
24	taivaanranta-tulitus	pelleseura
24	lumivyory-ammunta	pelleseura
25	kesan_ampujaiset	pelleseura
25	talvi_pistooli	pelleseura
25	tarkkuuslaukaus-festivaali	pelleseura
25	kivaarikilpailujen_huipennus	pelleseura
25	polaris-ampumaharjoitus	pelleseura
25	aamunkoiton_tahtays	pelleseura
25	nordic_sharpshooters_cup	pelleseura
25	taivaanranta-tulitus	pelleseura
25	lumivyory-ammunta	pelleseura
26	kesan_ampujaiset	pelleseura
26	talvi_pistooli	pelleseura
26	tarkkuuslaukaus-festivaali	pelleseura
26	kivaarikilpailujen_huipennus	pelleseura
26	polaris-ampumaharjoitus	pelleseura
26	aamunkoiton_tahtays	pelleseura
26	nordic_sharpshooters_cup	pelleseura
26	taivaanranta-tulitus	pelleseura
26	lumivyory-ammunta	pelleseura
27	kesan_ampujaiset	yung_tallent
27	talvi_pistooli	yung_tallent
27	tarkkuuslaukaus-festivaali	yung_tallent
27	kivaarikilpailujen_huipennus	yung_tallent
27	polaris-ampumaharjoitus	yung_tallent
27	aamunkoiton_tahtays	yung_tallent
27	nordic_sharpshooters_cup	yung_tallent
27	taivaanranta-tulitus	yung_tallent
27	lumivyory-ammunta	yung_tallent
28	kesan_ampujaiset	yung_tallent
28	talvi_pistooli	yung_tallent
28	tarkkuuslaukaus-festivaali	yung_tallent
28	kivaarikilpailujen_huipennus	yung_tallent
28	polaris-ampumaharjoitus	yung_tallent
28	aamunkoiton_tahtays	yung_tallent
28	nordic_sharpshooters_cup	yung_tallent
28	taivaanranta-tulitus	yung_tallent
28	lumivyory-ammunta	yung_tallent
29	kesan_ampujaiset	yung_tallent
29	talvi_pistooli	yung_tallent
29	tarkkuuslaukaus-festivaali	yung_tallent
29	kivaarikilpailujen_huipennus	yung_tallent
29	polaris-ampumaharjoitus	yung_tallent
29	aamunkoiton_tahtays	yung_tallent
29	nordic_sharpshooters_cup	yung_tallent
29	taivaanranta-tulitus	yung_tallent
29	lumivyory-ammunta	yung_tallent
30	kesan_ampujaiset	aseharrastajien_yhtenaisyys
30	talvi_pistooli	aseharrastajien_yhtenaisyys
30	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
30	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
30	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
30	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
30	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
30	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
30	lumivyory-ammunta	aseharrastajien_yhtenaisyys
31	kesan_ampujaiset	aseharrastajien_yhtenaisyys
31	talvi_pistooli	aseharrastajien_yhtenaisyys
31	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
31	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
31	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
31	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
31	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
31	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
31	lumivyory-ammunta	aseharrastajien_yhtenaisyys
32	kesan_ampujaiset	aseharrastajien_yhtenaisyys
32	talvi_pistooli	aseharrastajien_yhtenaisyys
32	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
32	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
32	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
32	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
32	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
32	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
32	lumivyory-ammunta	aseharrastajien_yhtenaisyys
33	kesan_ampujaiset	tahtaysmestarit
33	talvi_pistooli	tahtaysmestarit
33	tarkkuuslaukaus-festivaali	tahtaysmestarit
33	kivaarikilpailujen_huipennus	tahtaysmestarit
33	polaris-ampumaharjoitus	tahtaysmestarit
33	aamunkoiton_tahtays	tahtaysmestarit
33	nordic_sharpshooters_cup	tahtaysmestarit
33	taivaanranta-tulitus	tahtaysmestarit
33	lumivyory-ammunta	tahtaysmestarit
34	kesan_ampujaiset	tahtaysmestarit
34	talvi_pistooli	tahtaysmestarit
34	tarkkuuslaukaus-festivaali	tahtaysmestarit
34	kivaarikilpailujen_huipennus	tahtaysmestarit
34	polaris-ampumaharjoitus	tahtaysmestarit
34	aamunkoiton_tahtays	tahtaysmestarit
34	nordic_sharpshooters_cup	tahtaysmestarit
34	taivaanranta-tulitus	tahtaysmestarit
34	lumivyory-ammunta	tahtaysmestarit
35	kesan_ampujaiset	tahtaysmestarit
35	talvi_pistooli	tahtaysmestarit
35	tarkkuuslaukaus-festivaali	tahtaysmestarit
35	kivaarikilpailujen_huipennus	tahtaysmestarit
35	polaris-ampumaharjoitus	tahtaysmestarit
35	aamunkoiton_tahtays	tahtaysmestarit
35	nordic_sharpshooters_cup	tahtaysmestarit
35	taivaanranta-tulitus	tahtaysmestarit
35	lumivyory-ammunta	tahtaysmestarit
36	kesan_ampujaiset	tahtaysmestarit
36	talvi_pistooli	tahtaysmestarit
36	tarkkuuslaukaus-festivaali	tahtaysmestarit
36	kivaarikilpailujen_huipennus	tahtaysmestarit
36	polaris-ampumaharjoitus	tahtaysmestarit
36	aamunkoiton_tahtays	tahtaysmestarit
36	nordic_sharpshooters_cup	tahtaysmestarit
36	taivaanranta-tulitus	tahtaysmestarit
36	lumivyory-ammunta	tahtaysmestarit
37	kesan_ampujaiset	tahtaysmestarit
37	talvi_pistooli	tahtaysmestarit
37	tarkkuuslaukaus-festivaali	tahtaysmestarit
37	kivaarikilpailujen_huipennus	tahtaysmestarit
37	polaris-ampumaharjoitus	tahtaysmestarit
37	aamunkoiton_tahtays	tahtaysmestarit
37	nordic_sharpshooters_cup	tahtaysmestarit
37	taivaanranta-tulitus	tahtaysmestarit
37	lumivyory-ammunta	tahtaysmestarit
38	kesan_ampujaiset	laukausryhma_aurora
38	talvi_pistooli	laukausryhma_aurora
38	tarkkuuslaukaus-festivaali	laukausryhma_aurora
38	kivaarikilpailujen_huipennus	laukausryhma_aurora
38	polaris-ampumaharjoitus	laukausryhma_aurora
38	aamunkoiton_tahtays	laukausryhma_aurora
38	nordic_sharpshooters_cup	laukausryhma_aurora
38	taivaanranta-tulitus	laukausryhma_aurora
38	lumivyory-ammunta	laukausryhma_aurora
39	kesan_ampujaiset	laukausryhma_aurora
39	talvi_pistooli	laukausryhma_aurora
39	tarkkuuslaukaus-festivaali	laukausryhma_aurora
39	kivaarikilpailujen_huipennus	laukausryhma_aurora
39	polaris-ampumaharjoitus	laukausryhma_aurora
39	aamunkoiton_tahtays	laukausryhma_aurora
39	nordic_sharpshooters_cup	laukausryhma_aurora
39	taivaanranta-tulitus	laukausryhma_aurora
39	lumivyory-ammunta	laukausryhma_aurora
40	kesan_ampujaiset	laukausryhma_aurora
40	talvi_pistooli	laukausryhma_aurora
40	tarkkuuslaukaus-festivaali	laukausryhma_aurora
40	kivaarikilpailujen_huipennus	laukausryhma_aurora
40	polaris-ampumaharjoitus	laukausryhma_aurora
40	aamunkoiton_tahtays	laukausryhma_aurora
40	nordic_sharpshooters_cup	laukausryhma_aurora
40	taivaanranta-tulitus	laukausryhma_aurora
40	lumivyory-ammunta	laukausryhma_aurora
41	kesan_ampujaiset	ampumataito
41	talvi_pistooli	ampumataito
41	tarkkuuslaukaus-festivaali	ampumataito
41	kivaarikilpailujen_huipennus	ampumataito
41	polaris-ampumaharjoitus	ampumataito
41	aamunkoiton_tahtays	ampumataito
41	nordic_sharpshooters_cup	ampumataito
41	taivaanranta-tulitus	ampumataito
41	lumivyory-ammunta	ampumataito
42	kesan_ampujaiset	ampumataito
42	talvi_pistooli	ampumataito
42	tarkkuuslaukaus-festivaali	ampumataito
42	kivaarikilpailujen_huipennus	ampumataito
42	polaris-ampumaharjoitus	ampumataito
42	aamunkoiton_tahtays	ampumataito
42	nordic_sharpshooters_cup	ampumataito
42	taivaanranta-tulitus	ampumataito
42	lumivyory-ammunta	ampumataito
43	kesan_ampujaiset	ampumataito
43	talvi_pistooli	ampumataito
43	tarkkuuslaukaus-festivaali	ampumataito
43	kivaarikilpailujen_huipennus	ampumataito
43	polaris-ampumaharjoitus	ampumataito
43	aamunkoiton_tahtays	ampumataito
43	nordic_sharpshooters_cup	ampumataito
43	taivaanranta-tulitus	ampumataito
43	lumivyory-ammunta	ampumataito
\.


--
-- Data for Name: team_member_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member_score (bulls_eye_count, sum, creation_date, user_id, competition_id, team_name) FROM stdin;
10	305.1439660015581	2024-04-20 19:24:25.412	2	tarkka-ammunta_cup	poliisiseura
10	394.6330208627855	2024-04-20 19:24:25.423	2	nopean_laukauksen_mestaruus	poliisiseura
10	371.1465644784462	2024-04-20 19:24:25.431	2	moniottelu	poliisiseura
10	374.82364765889645	2024-04-20 19:24:25.438	2	kansallinen_tahtayskilpailu	poliisiseura
10	347.129677618784	2024-04-20 19:24:25.445	2	kaupunkiammunta-challenge	poliisiseura
10	335.8935165298542	2024-04-20 19:24:25.454	2	laukausmaraton	poliisiseura
10	295.5811660662815	2024-04-20 19:24:25.461	2	vapaa-asekilpailu	poliisiseura
10	357.4182372769358	2024-04-20 19:24:25.468	2	taitoluodikko-turnaus	poliisiseura
10	284.9498904234011	2024-04-20 19:24:25.475	2	precision_pistol_cup	poliisiseura
10	329.42105953850586	2024-04-20 19:24:25.483	2	tulevaisuuden_ampuja	poliisiseura
10	277.93329133002084	2024-04-20 19:24:25.489	2	pikakivaari-klassikko	poliisiseura
10	371.37313912322577	2024-04-20 19:24:25.495	3	tarkka-ammunta_cup	poliisiseura
10	353.244995228942	2024-04-20 19:24:25.501	3	nopean_laukauksen_mestaruus	poliisiseura
10	310.2653789246212	2024-04-20 19:24:25.507	3	moniottelu	poliisiseura
10	326.350488151524	2024-04-20 19:24:25.513	3	kansallinen_tahtayskilpailu	poliisiseura
10	293.84407763034255	2024-04-20 19:24:25.519	3	kaupunkiammunta-challenge	poliisiseura
10	338.3513369949688	2024-04-20 19:24:25.526	3	laukausmaraton	poliisiseura
10	328.73315697335113	2024-04-20 19:24:25.531	3	vapaa-asekilpailu	poliisiseura
10	354.69728355504554	2024-04-20 19:24:25.537	3	taitoluodikko-turnaus	poliisiseura
10	347.2765765193391	2024-04-20 19:24:25.542	3	precision_pistol_cup	poliisiseura
10	335.7591688278676	2024-04-20 19:24:25.548	3	tulevaisuuden_ampuja	poliisiseura
10	320.46662295716453	2024-04-20 19:24:25.554	3	pikakivaari-klassikko	poliisiseura
10	339.5746534647049	2024-04-20 19:24:25.56	4	tarkka-ammunta_cup	poliisiseura
10	331.2189179623914	2024-04-20 19:24:25.565	4	nopean_laukauksen_mestaruus	poliisiseura
10	333.8520517457376	2024-04-20 19:24:25.571	4	moniottelu	poliisiseura
10	330.315122658529	2024-04-20 19:24:25.576	4	kansallinen_tahtayskilpailu	poliisiseura
10	348.357687906388	2024-04-20 19:24:25.582	4	kaupunkiammunta-challenge	poliisiseura
10	338.10687011412455	2024-04-20 19:24:25.588	4	laukausmaraton	poliisiseura
10	320.07857177465917	2024-04-20 19:24:25.593	4	vapaa-asekilpailu	poliisiseura
10	317.03449100492946	2024-04-20 19:24:25.599	4	taitoluodikko-turnaus	poliisiseura
10	320.58975552948607	2024-04-20 19:24:25.605	4	precision_pistol_cup	poliisiseura
10	302.71191657721675	2024-04-20 19:24:25.611	4	tulevaisuuden_ampuja	poliisiseura
10	326.3083476631033	2024-04-20 19:24:25.616	4	pikakivaari-klassikko	poliisiseura
10	325.9543568059536	2024-04-20 19:24:25.622	5	tarkka-ammunta_cup	koiraseura
10	304.947408527949	2024-04-20 19:24:25.628	5	nopean_laukauksen_mestaruus	koiraseura
10	322.26169101605757	2024-04-20 19:24:25.633	5	moniottelu	koiraseura
10	311.0379666555604	2024-04-20 19:24:25.639	5	kansallinen_tahtayskilpailu	koiraseura
10	318.9692708775474	2024-04-20 19:24:25.644	5	kaupunkiammunta-challenge	koiraseura
10	324.89087410890517	2024-04-20 19:24:25.65	5	laukausmaraton	koiraseura
10	314.49749501436486	2024-04-20 19:24:25.655	5	vapaa-asekilpailu	koiraseura
10	363.6448968537964	2024-04-20 19:24:25.661	5	taitoluodikko-turnaus	koiraseura
10	327.34015436872517	2024-04-20 19:24:25.666	5	precision_pistol_cup	koiraseura
10	314.0285517458917	2024-04-20 19:24:25.673	5	tulevaisuuden_ampuja	koiraseura
10	323.52213145442175	2024-04-20 19:24:25.678	5	pikakivaari-klassikko	koiraseura
10	358.21792088071624	2024-04-20 19:24:25.685	6	tarkka-ammunta_cup	koiraseura
10	319.09793929089335	2024-04-20 19:24:25.69	6	nopean_laukauksen_mestaruus	koiraseura
10	335.822968143087	2024-04-20 19:24:25.697	6	moniottelu	koiraseura
10	344.0561488178475	2024-04-20 19:24:25.702	6	kansallinen_tahtayskilpailu	koiraseura
10	329.45352949542917	2024-04-20 19:24:25.708	6	kaupunkiammunta-challenge	koiraseura
10	359.93667329802133	2024-04-20 19:24:25.714	6	laukausmaraton	koiraseura
10	327.05617767144577	2024-04-20 19:24:25.719	6	vapaa-asekilpailu	koiraseura
10	322.2458818749867	2024-04-20 19:24:25.725	6	taitoluodikko-turnaus	koiraseura
10	292.1108183180983	2024-04-20 19:24:25.73	6	precision_pistol_cup	koiraseura
10	334.14979297981466	2024-04-20 19:24:25.736	6	tulevaisuuden_ampuja	koiraseura
10	346.7488145948392	2024-04-20 19:24:25.742	6	pikakivaari-klassikko	koiraseura
10	307.7410713000832	2024-04-20 19:24:25.747	7	tarkka-ammunta_cup	koiraseura
10	357.15791179788596	2024-04-20 19:24:25.753	7	nopean_laukauksen_mestaruus	koiraseura
10	317.66220452891315	2024-04-20 19:24:25.758	7	moniottelu	koiraseura
10	309.2870254437193	2024-04-20 19:24:25.764	7	kansallinen_tahtayskilpailu	koiraseura
10	268.0186773158158	2024-04-20 19:24:25.77	7	kaupunkiammunta-challenge	koiraseura
10	300.7623116949754	2024-04-20 19:24:25.775	7	laukausmaraton	koiraseura
10	297.0051920594274	2024-04-20 19:24:25.781	7	vapaa-asekilpailu	koiraseura
10	326.9218813692546	2024-04-20 19:24:25.786	7	taitoluodikko-turnaus	koiraseura
10	322.3196856644878	2024-04-20 19:24:25.792	7	precision_pistol_cup	koiraseura
10	341.68577369613917	2024-04-20 19:24:25.798	7	tulevaisuuden_ampuja	koiraseura
10	338.73028497330563	2024-04-20 19:24:25.811	7	pikakivaari-klassikko	koiraseura
10	313.2765427493659	2024-04-20 19:24:25.822	8	tarkka-ammunta_cup	hammaspeikkoseura
10	341.5626473306316	2024-04-20 19:24:25.831	8	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	363.0964451764659	2024-04-20 19:24:25.84	8	moniottelu	hammaspeikkoseura
10	318.1464817571022	2024-04-20 19:24:25.848	8	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	330.6145807537241	2024-04-20 19:24:25.854	8	kaupunkiammunta-challenge	hammaspeikkoseura
10	355.6237772652901	2024-04-20 19:24:25.867	8	laukausmaraton	hammaspeikkoseura
10	329.0319989010123	2024-04-20 19:24:25.875	8	vapaa-asekilpailu	hammaspeikkoseura
10	302.2265344470385	2024-04-20 19:24:25.881	8	taitoluodikko-turnaus	hammaspeikkoseura
10	318.2028375167612	2024-04-20 19:24:25.888	8	precision_pistol_cup	hammaspeikkoseura
10	314.6497901494836	2024-04-20 19:24:25.895	8	tulevaisuuden_ampuja	hammaspeikkoseura
10	338.22648981717845	2024-04-20 19:24:25.902	8	pikakivaari-klassikko	hammaspeikkoseura
10	348.5785162535317	2024-04-20 19:24:25.908	9	tarkka-ammunta_cup	hammaspeikkoseura
10	357.3790877840735	2024-04-20 19:24:25.914	9	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	368.8626928783346	2024-04-20 19:24:25.92	9	moniottelu	hammaspeikkoseura
10	317.5224099196535	2024-04-20 19:24:25.927	9	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	306.27038804301867	2024-04-20 19:24:25.933	9	kaupunkiammunta-challenge	hammaspeikkoseura
10	335.9086335938303	2024-04-20 19:24:25.939	9	laukausmaraton	hammaspeikkoseura
10	322.19701139166864	2024-04-20 19:24:25.946	9	vapaa-asekilpailu	hammaspeikkoseura
10	302.9502333459581	2024-04-20 19:24:25.952	9	taitoluodikko-turnaus	hammaspeikkoseura
10	277.33882282604725	2024-04-20 19:24:25.958	9	precision_pistol_cup	hammaspeikkoseura
10	375.6445718928867	2024-04-20 19:24:25.965	9	tulevaisuuden_ampuja	hammaspeikkoseura
10	334.5188251165321	2024-04-20 19:24:25.97	9	pikakivaari-klassikko	hammaspeikkoseura
10	378.5950922916041	2024-04-20 19:24:25.976	10	tarkka-ammunta_cup	hammaspeikkoseura
10	332.2843439762998	2024-04-20 19:24:25.981	10	nopean_laukauksen_mestaruus	hammaspeikkoseura
10	317.349058375527	2024-04-20 19:24:25.987	10	moniottelu	hammaspeikkoseura
10	286.4726847984165	2024-04-20 19:24:25.992	10	kansallinen_tahtayskilpailu	hammaspeikkoseura
10	343.6140211523124	2024-04-20 19:24:25.999	10	kaupunkiammunta-challenge	hammaspeikkoseura
10	311.30171502299254	2024-04-20 19:24:26.004	10	laukausmaraton	hammaspeikkoseura
10	307.6583481367167	2024-04-20 19:24:26.01	10	vapaa-asekilpailu	hammaspeikkoseura
10	306.5445759616975	2024-04-20 19:24:26.016	10	taitoluodikko-turnaus	hammaspeikkoseura
10	299.0899442562687	2024-04-20 19:24:26.022	10	precision_pistol_cup	hammaspeikkoseura
10	350.0099159736094	2024-04-20 19:24:26.028	10	tulevaisuuden_ampuja	hammaspeikkoseura
10	298.4486132874331	2024-04-20 19:24:26.034	10	pikakivaari-klassikko	hammaspeikkoseura
10	314.20691064855174	2024-04-20 19:24:26.041	11	tarkka-ammunta_cup	dog
10	318.38178258975637	2024-04-20 19:24:26.046	11	nopean_laukauksen_mestaruus	dog
10	295.5152399273524	2024-04-20 19:24:26.052	11	moniottelu	dog
10	304.4740113551032	2024-04-20 19:24:26.058	11	kansallinen_tahtayskilpailu	dog
10	329.10404076398015	2024-04-20 19:24:26.064	11	kaupunkiammunta-challenge	dog
10	315.40127231686756	2024-04-20 19:24:26.071	11	laukausmaraton	dog
10	361.52445008351197	2024-04-20 19:24:26.077	11	vapaa-asekilpailu	dog
10	342.4611567561704	2024-04-20 19:24:26.083	11	taitoluodikko-turnaus	dog
10	315.0686836991982	2024-04-20 19:24:26.088	11	precision_pistol_cup	dog
10	342.015512792426	2024-04-20 19:24:26.096	11	tulevaisuuden_ampuja	dog
10	304.5320502200911	2024-04-20 19:24:26.102	11	pikakivaari-klassikko	dog
10	299.28443361174453	2024-04-20 19:24:26.107	12	tarkka-ammunta_cup	dog
10	347.3962876186143	2024-04-20 19:24:26.113	12	nopean_laukauksen_mestaruus	dog
10	365.6070211626254	2024-04-20 19:24:26.119	12	moniottelu	dog
10	327.2958101924287	2024-04-20 19:24:26.125	12	kansallinen_tahtayskilpailu	dog
10	350.2402632185166	2024-04-20 19:24:26.131	12	kaupunkiammunta-challenge	dog
10	328.65901368112094	2024-04-20 19:24:26.136	12	laukausmaraton	dog
10	332.5536572390497	2024-04-20 19:24:26.142	12	vapaa-asekilpailu	dog
10	306.0740008814872	2024-04-20 19:24:26.148	12	taitoluodikko-turnaus	dog
10	326.8006187465486	2024-04-20 19:24:26.154	12	precision_pistol_cup	dog
10	365.91810634483284	2024-04-20 19:24:26.161	12	tulevaisuuden_ampuja	dog
10	375.7962463334198	2024-04-20 19:24:26.167	12	pikakivaari-klassikko	dog
10	307.96449862280645	2024-04-20 19:24:26.173	13	tarkka-ammunta_cup	dog
10	336.1395300186743	2024-04-20 19:24:26.178	13	nopean_laukauksen_mestaruus	dog
10	294.36077407598935	2024-04-20 19:24:26.183	13	moniottelu	dog
10	327.4189664457057	2024-04-20 19:24:26.189	13	kansallinen_tahtayskilpailu	dog
10	319.7411078939359	2024-04-20 19:24:26.194	13	kaupunkiammunta-challenge	dog
10	317.37464852456293	2024-04-20 19:24:26.2	13	laukausmaraton	dog
10	343.6666465461417	2024-04-20 19:24:26.206	13	vapaa-asekilpailu	dog
10	329.4094180934939	2024-04-20 19:24:26.213	13	taitoluodikko-turnaus	dog
10	321.0057596063205	2024-04-20 19:24:26.218	13	precision_pistol_cup	dog
10	320.0673033281877	2024-04-20 19:24:26.224	13	tulevaisuuden_ampuja	dog
10	335.7139137539637	2024-04-20 19:24:26.23	13	pikakivaari-klassikko	dog
10	370.95706925476793	2024-04-20 19:24:26.236	14	tarkka-ammunta_cup	savu_seura
10	325.8954607695782	2024-04-20 19:24:26.242	14	nopean_laukauksen_mestaruus	savu_seura
10	317.288373132898	2024-04-20 19:24:26.248	14	moniottelu	savu_seura
10	296.5132390145758	2024-04-20 19:24:26.254	14	kansallinen_tahtayskilpailu	savu_seura
10	345.8147695414925	2024-04-20 19:24:26.26	14	kaupunkiammunta-challenge	savu_seura
10	350.9826012584916	2024-04-20 19:24:26.266	14	laukausmaraton	savu_seura
10	345.76221310744756	2024-04-20 19:24:26.272	14	vapaa-asekilpailu	savu_seura
10	349.7241378339391	2024-04-20 19:24:26.278	14	taitoluodikko-turnaus	savu_seura
10	305.0123567484433	2024-04-20 19:24:26.284	14	precision_pistol_cup	savu_seura
10	341.12209184517394	2024-04-20 19:24:26.289	14	tulevaisuuden_ampuja	savu_seura
10	330.3043403709565	2024-04-20 19:24:26.295	14	pikakivaari-klassikko	savu_seura
10	334.4915306285567	2024-04-20 19:24:26.3	15	tarkka-ammunta_cup	savu_seura
10	318.08849318107093	2024-04-20 19:24:26.306	15	nopean_laukauksen_mestaruus	savu_seura
10	301.436370389208	2024-04-20 19:24:26.311	15	moniottelu	savu_seura
10	325.24282866650725	2024-04-20 19:24:26.317	15	kansallinen_tahtayskilpailu	savu_seura
10	338.2249622119627	2024-04-20 19:24:26.322	15	kaupunkiammunta-challenge	savu_seura
10	310.52791675083165	2024-04-20 19:24:26.327	15	laukausmaraton	savu_seura
10	331.5773630505554	2024-04-20 19:24:26.333	15	vapaa-asekilpailu	savu_seura
10	295.28597410021587	2024-04-20 19:24:26.339	15	taitoluodikko-turnaus	savu_seura
10	324.77100938509443	2024-04-20 19:24:26.344	15	precision_pistol_cup	savu_seura
10	330.86955694676755	2024-04-20 19:24:26.349	15	tulevaisuuden_ampuja	savu_seura
10	315.9712708785448	2024-04-20 19:24:26.355	15	pikakivaari-klassikko	savu_seura
10	311.6385574395325	2024-04-20 19:24:26.36	16	tarkka-ammunta_cup	savu_seura
10	380.09634113352837	2024-04-20 19:24:26.366	16	nopean_laukauksen_mestaruus	savu_seura
10	323.0113492872804	2024-04-20 19:24:26.372	16	moniottelu	savu_seura
10	342.6466502365531	2024-04-20 19:24:26.377	16	kansallinen_tahtayskilpailu	savu_seura
10	357.7325868507778	2024-04-20 19:24:26.383	16	kaupunkiammunta-challenge	savu_seura
10	347.95822739292726	2024-04-20 19:24:26.388	16	laukausmaraton	savu_seura
10	376.04930114378953	2024-04-20 19:24:26.394	16	vapaa-asekilpailu	savu_seura
10	316.82494834559014	2024-04-20 19:24:26.4	16	taitoluodikko-turnaus	savu_seura
10	308.91137746295453	2024-04-20 19:24:26.405	16	precision_pistol_cup	savu_seura
10	335.32353178218864	2024-04-20 19:24:26.411	16	tulevaisuuden_ampuja	savu_seura
10	327.01681091810474	2024-04-20 19:24:26.417	16	pikakivaari-klassikko	savu_seura
10	319.63356877271053	2024-04-20 19:24:26.422	17	tarkka-ammunta_cup	savu_seura
10	363.4484730460973	2024-04-20 19:24:26.428	17	nopean_laukauksen_mestaruus	savu_seura
10	338.9024330481515	2024-04-20 19:24:26.434	17	moniottelu	savu_seura
10	304.83836114976674	2024-04-20 19:24:26.439	17	kansallinen_tahtayskilpailu	savu_seura
10	325.75789366650076	2024-04-20 19:24:26.444	17	kaupunkiammunta-challenge	savu_seura
10	348.63898187290664	2024-04-20 19:24:26.45	17	laukausmaraton	savu_seura
10	322.24825232897126	2024-04-20 19:24:26.456	17	vapaa-asekilpailu	savu_seura
10	313.85389923186716	2024-04-20 19:24:26.461	17	taitoluodikko-turnaus	savu_seura
10	307.81038100280614	2024-04-20 19:24:26.467	17	precision_pistol_cup	savu_seura
10	318.6523585202678	2024-04-20 19:24:26.474	17	tulevaisuuden_ampuja	savu_seura
10	324.3309053123329	2024-04-20 19:24:26.479	17	pikakivaari-klassikko	savu_seura
10	354.36357624861444	2024-04-20 19:24:26.485	18	tarkka-ammunta_cup	savu_seura
10	376.13026175209103	2024-04-20 19:24:26.491	18	nopean_laukauksen_mestaruus	savu_seura
10	353.9505820809033	2024-04-20 19:24:26.496	18	moniottelu	savu_seura
10	321.75333404451067	2024-04-20 19:24:26.502	18	kansallinen_tahtayskilpailu	savu_seura
10	326.0400789001187	2024-04-20 19:24:26.507	18	kaupunkiammunta-challenge	savu_seura
10	317.05013521194746	2024-04-20 19:24:26.513	18	laukausmaraton	savu_seura
10	354.0022582054552	2024-04-20 19:24:26.518	18	vapaa-asekilpailu	savu_seura
10	346.58890907941617	2024-04-20 19:24:26.524	18	taitoluodikko-turnaus	savu_seura
10	290.4105406363426	2024-04-20 19:24:26.53	18	precision_pistol_cup	savu_seura
10	308.90408828220916	2024-04-20 19:24:26.535	18	tulevaisuuden_ampuja	savu_seura
10	330.20361279578407	2024-04-20 19:24:26.54	18	pikakivaari-klassikko	savu_seura
10	323.83407549980285	2024-04-20 19:24:26.546	19	tarkka-ammunta_cup	omas
10	336.10940986417665	2024-04-20 19:24:26.551	19	nopean_laukauksen_mestaruus	omas
10	278.31318695061344	2024-04-20 19:24:26.556	19	moniottelu	omas
10	308.05781928648696	2024-04-20 19:24:26.561	19	kansallinen_tahtayskilpailu	omas
10	302.8766321234272	2024-04-20 19:24:26.567	19	kaupunkiammunta-challenge	omas
10	320.0658017033851	2024-04-20 19:24:26.572	19	laukausmaraton	omas
10	354.1875878873757	2024-04-20 19:24:26.578	19	vapaa-asekilpailu	omas
10	332.00712763997086	2024-04-20 19:24:26.584	19	taitoluodikko-turnaus	omas
10	371.53602657342645	2024-04-20 19:24:26.589	19	precision_pistol_cup	omas
10	281.50309653445123	2024-04-20 19:24:26.595	19	tulevaisuuden_ampuja	omas
10	337.14447213027466	2024-04-20 19:24:26.6	19	pikakivaari-klassikko	omas
10	336.65316577318197	2024-04-20 19:24:26.606	20	tarkka-ammunta_cup	omas
10	336.19806161647693	2024-04-20 19:24:26.61	20	nopean_laukauksen_mestaruus	omas
10	327.88731381970246	2024-04-20 19:24:26.616	20	moniottelu	omas
10	337.95867739743244	2024-04-20 19:24:26.621	20	kansallinen_tahtayskilpailu	omas
10	318.74360322161834	2024-04-20 19:24:26.627	20	kaupunkiammunta-challenge	omas
10	338.2164414095181	2024-04-20 19:24:26.632	20	laukausmaraton	omas
10	352.1317485304594	2024-04-20 19:24:26.638	20	vapaa-asekilpailu	omas
10	344.2516044797318	2024-04-20 19:24:26.649	20	taitoluodikko-turnaus	omas
10	350.343122038003	2024-04-20 19:24:26.657	20	precision_pistol_cup	omas
10	305.33813474953513	2024-04-20 19:24:26.665	20	tulevaisuuden_ampuja	omas
10	356.81567493483817	2024-04-20 19:24:26.672	20	pikakivaari-klassikko	omas
10	315.63669333867637	2024-04-20 19:24:26.679	21	tarkka-ammunta_cup	omas
10	335.8819475696815	2024-04-20 19:24:26.685	21	nopean_laukauksen_mestaruus	omas
10	348.15190099626346	2024-04-20 19:24:26.691	21	moniottelu	omas
10	395.9749434620698	2024-04-20 19:24:26.698	21	kansallinen_tahtayskilpailu	omas
10	328.07191468687984	2024-04-20 19:24:26.703	21	kaupunkiammunta-challenge	omas
10	404.86648412364906	2024-04-20 19:24:26.709	21	laukausmaraton	omas
10	343.79816357565244	2024-04-20 19:24:26.714	21	vapaa-asekilpailu	omas
10	287.9908114350969	2024-04-20 19:24:26.72	21	taitoluodikko-turnaus	omas
10	340.2271223628774	2024-04-20 19:24:26.725	21	precision_pistol_cup	omas
10	296.79191254744967	2024-04-20 19:24:26.73	21	tulevaisuuden_ampuja	omas
10	288.236405579831	2024-04-20 19:24:26.736	21	pikakivaari-klassikko	omas
10	294.8325360440559	2024-04-20 19:24:26.741	22	tarkka-ammunta_cup	omas
10	371.44240002067437	2024-04-20 19:24:26.747	22	nopean_laukauksen_mestaruus	omas
10	357.41021368515624	2024-04-20 19:24:26.752	22	moniottelu	omas
10	290.65761072863313	2024-04-20 19:24:26.758	22	kansallinen_tahtayskilpailu	omas
10	364.6294525978505	2024-04-20 19:24:26.765	22	kaupunkiammunta-challenge	omas
10	333.82014766476806	2024-04-20 19:24:26.772	22	laukausmaraton	omas
10	308.3123263099224	2024-04-20 19:24:26.778	22	vapaa-asekilpailu	omas
10	333.30321373986254	2024-04-20 19:24:26.785	22	taitoluodikko-turnaus	omas
10	329.8374365600121	2024-04-20 19:24:26.791	22	precision_pistol_cup	omas
10	327.8626269248305	2024-04-20 19:24:26.797	22	tulevaisuuden_ampuja	omas
10	311.3358497251993	2024-04-20 19:24:26.803	22	pikakivaari-klassikko	omas
10	336.60020220841244	2024-04-20 19:24:26.809	23	tarkka-ammunta_cup	pelleseura
10	320.42669379450854	2024-04-20 19:24:26.815	23	nopean_laukauksen_mestaruus	pelleseura
10	310.4756711765611	2024-04-20 19:24:26.824	23	moniottelu	pelleseura
10	323.0125677361497	2024-04-20 19:24:26.831	23	kansallinen_tahtayskilpailu	pelleseura
10	290.04994934731025	2024-04-20 19:24:26.837	23	kaupunkiammunta-challenge	pelleseura
10	340.7054145216211	2024-04-20 19:24:26.843	23	laukausmaraton	pelleseura
10	320.9091662816443	2024-04-20 19:24:26.848	23	vapaa-asekilpailu	pelleseura
10	324.85749727174345	2024-04-20 19:24:26.854	23	taitoluodikko-turnaus	pelleseura
10	302.3951472661198	2024-04-20 19:24:26.859	23	precision_pistol_cup	pelleseura
10	339.9055001108562	2024-04-20 19:24:26.864	23	tulevaisuuden_ampuja	pelleseura
10	314.7999997363728	2024-04-20 19:24:26.869	23	pikakivaari-klassikko	pelleseura
10	320.74906228121245	2024-04-20 19:24:26.874	24	tarkka-ammunta_cup	pelleseura
10	329.35562486934236	2024-04-20 19:24:26.88	24	nopean_laukauksen_mestaruus	pelleseura
10	332.2189779598352	2024-04-20 19:24:26.885	24	moniottelu	pelleseura
10	317.8506572045214	2024-04-20 19:24:26.891	24	kansallinen_tahtayskilpailu	pelleseura
10	368.3941911755625	2024-04-20 19:24:26.896	24	kaupunkiammunta-challenge	pelleseura
10	322.1151782673156	2024-04-20 19:24:26.901	24	laukausmaraton	pelleseura
10	310.4047906303606	2024-04-20 19:24:26.906	24	vapaa-asekilpailu	pelleseura
10	380.6593057513525	2024-04-20 19:24:26.911	24	taitoluodikko-turnaus	pelleseura
10	337.7153813079353	2024-04-20 19:24:26.917	24	precision_pistol_cup	pelleseura
10	294.61675318003466	2024-04-20 19:24:26.922	24	tulevaisuuden_ampuja	pelleseura
10	317.63600507695645	2024-04-20 19:24:26.927	24	pikakivaari-klassikko	pelleseura
10	322.8335722119541	2024-04-20 19:24:26.932	25	tarkka-ammunta_cup	pelleseura
10	318.41691908193224	2024-04-20 19:24:26.937	25	nopean_laukauksen_mestaruus	pelleseura
10	337.48110972676244	2024-04-20 19:24:26.943	25	moniottelu	pelleseura
10	338.6842514884644	2024-04-20 19:24:26.948	25	kansallinen_tahtayskilpailu	pelleseura
10	320.9347140364762	2024-04-20 19:24:26.953	25	kaupunkiammunta-challenge	pelleseura
10	306.0601837623179	2024-04-20 19:24:26.959	25	laukausmaraton	pelleseura
10	326.95599837184153	2024-04-20 19:24:26.964	25	vapaa-asekilpailu	pelleseura
10	341.28796301013836	2024-04-20 19:24:26.969	25	taitoluodikko-turnaus	pelleseura
10	370.6672032978528	2024-04-20 19:24:26.974	25	precision_pistol_cup	pelleseura
10	305.30443289189776	2024-04-20 19:24:26.979	25	tulevaisuuden_ampuja	pelleseura
10	304.92095177180914	2024-04-20 19:24:26.984	25	pikakivaari-klassikko	pelleseura
10	314.87685671076156	2024-04-20 19:24:26.99	26	tarkka-ammunta_cup	pelleseura
10	333.00380897880973	2024-04-20 19:24:26.996	26	nopean_laukauksen_mestaruus	pelleseura
10	327.61933934462684	2024-04-20 19:24:27.002	26	moniottelu	pelleseura
10	319.93169621529813	2024-04-20 19:24:27.007	26	kansallinen_tahtayskilpailu	pelleseura
10	319.29014313681733	2024-04-20 19:24:27.012	26	kaupunkiammunta-challenge	pelleseura
10	389.0795131599457	2024-04-20 19:24:27.017	26	laukausmaraton	pelleseura
10	344.23180844945307	2024-04-20 19:24:27.023	26	vapaa-asekilpailu	pelleseura
10	375.8854843232225	2024-04-20 19:24:27.027	26	taitoluodikko-turnaus	pelleseura
10	303.47837054674613	2024-04-20 19:24:27.033	26	precision_pistol_cup	pelleseura
10	303.19071683472424	2024-04-20 19:24:27.038	26	tulevaisuuden_ampuja	pelleseura
10	337.0946960388522	2024-04-20 19:24:27.043	26	pikakivaari-klassikko	pelleseura
10	322.3902740118977	2024-04-20 19:24:27.048	27	tarkka-ammunta_cup	yung_tallent
10	300.0172740142823	2024-04-20 19:24:27.053	27	nopean_laukauksen_mestaruus	yung_tallent
10	350.46850528998743	2024-04-20 19:24:27.058	27	moniottelu	yung_tallent
10	323.5148273689977	2024-04-20 19:24:27.063	27	kansallinen_tahtayskilpailu	yung_tallent
10	291.0787933959386	2024-04-20 19:24:27.068	27	kaupunkiammunta-challenge	yung_tallent
10	300.16607692020375	2024-04-20 19:24:27.073	27	laukausmaraton	yung_tallent
10	303.11615267055055	2024-04-20 19:24:27.079	27	vapaa-asekilpailu	yung_tallent
10	329.16540513732184	2024-04-20 19:24:27.084	27	taitoluodikko-turnaus	yung_tallent
10	315.1061665861441	2024-04-20 19:24:27.089	27	precision_pistol_cup	yung_tallent
10	327.17111097824767	2024-04-20 19:24:27.094	27	tulevaisuuden_ampuja	yung_tallent
10	323.40325897896065	2024-04-20 19:24:27.099	27	pikakivaari-klassikko	yung_tallent
10	345.2931905822598	2024-04-20 19:24:27.105	28	tarkka-ammunta_cup	yung_tallent
10	305.6289474602351	2024-04-20 19:24:27.109	28	nopean_laukauksen_mestaruus	yung_tallent
10	332.7447699598597	2024-04-20 19:24:27.114	28	moniottelu	yung_tallent
10	331.9735891504341	2024-04-20 19:24:27.12	28	kansallinen_tahtayskilpailu	yung_tallent
10	308.82904656565455	2024-04-20 19:24:27.125	28	kaupunkiammunta-challenge	yung_tallent
10	336.7733578595872	2024-04-20 19:24:27.13	28	laukausmaraton	yung_tallent
10	307.75708768732204	2024-04-20 19:24:27.135	28	vapaa-asekilpailu	yung_tallent
10	351.80488136996433	2024-04-20 19:24:27.141	28	taitoluodikko-turnaus	yung_tallent
10	312.97580297903994	2024-04-20 19:24:27.146	28	precision_pistol_cup	yung_tallent
10	346.2955826622604	2024-04-20 19:24:27.151	28	tulevaisuuden_ampuja	yung_tallent
10	302.81096343315323	2024-04-20 19:24:27.156	28	pikakivaari-klassikko	yung_tallent
10	360.1721367076522	2024-04-20 19:24:27.162	29	tarkka-ammunta_cup	yung_tallent
10	370.23051037029353	2024-04-20 19:24:27.167	29	nopean_laukauksen_mestaruus	yung_tallent
10	326.2830080074703	2024-04-20 19:24:27.172	29	moniottelu	yung_tallent
10	374.2013348332636	2024-04-20 19:24:27.178	29	kansallinen_tahtayskilpailu	yung_tallent
10	296.84123820046665	2024-04-20 19:24:27.183	29	kaupunkiammunta-challenge	yung_tallent
10	352.73315454819254	2024-04-20 19:24:27.188	29	laukausmaraton	yung_tallent
10	315.5082727980796	2024-04-20 19:24:27.193	29	vapaa-asekilpailu	yung_tallent
10	321.17767875765065	2024-04-20 19:24:27.198	29	taitoluodikko-turnaus	yung_tallent
10	309.66467978247204	2024-04-20 19:24:27.204	29	precision_pistol_cup	yung_tallent
10	326.75450212309386	2024-04-20 19:24:27.209	29	tulevaisuuden_ampuja	yung_tallent
10	328.75656534302476	2024-04-20 19:24:27.214	29	pikakivaari-klassikko	yung_tallent
10	393.6619573436878	2024-04-20 19:24:27.219	30	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	344.910474856668	2024-04-20 19:24:27.225	30	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	319.95168980832017	2024-04-20 19:24:27.23	30	moniottelu	aseharrastajien_yhtenaisyys
10	334.5494444090563	2024-04-20 19:24:27.236	30	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	342.44257629858544	2024-04-20 19:24:27.241	30	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	333.81926063491943	2024-04-20 19:24:27.247	30	laukausmaraton	aseharrastajien_yhtenaisyys
10	362.4022689411805	2024-04-20 19:24:27.252	30	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	315.49554949176377	2024-04-20 19:24:27.258	30	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	334.7177944337623	2024-04-20 19:24:27.263	30	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	333.46796632830575	2024-04-20 19:24:27.269	30	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	370.73073193828884	2024-04-20 19:24:27.274	30	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	322.2148086039126	2024-04-20 19:24:27.278	31	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	382.29823299431683	2024-04-20 19:24:27.284	31	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	338.3712928360258	2024-04-20 19:24:27.29	31	moniottelu	aseharrastajien_yhtenaisyys
10	310.5320564644947	2024-04-20 19:24:27.295	31	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	303.18518542328826	2024-04-20 19:24:27.3	31	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	357.8385253606986	2024-04-20 19:24:27.305	31	laukausmaraton	aseharrastajien_yhtenaisyys
10	328.184580121155	2024-04-20 19:24:27.31	31	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	346.3918966417708	2024-04-20 19:24:27.315	31	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	326.50269909484	2024-04-20 19:24:27.321	31	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	238.70671664143657	2024-04-20 19:24:27.326	31	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	348.61960591817245	2024-04-20 19:24:27.332	31	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	274.4176111905951	2024-04-20 19:24:27.338	32	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys
10	330.04866560950455	2024-04-20 19:24:27.343	32	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys
10	355.78947260383416	2024-04-20 19:24:27.348	32	moniottelu	aseharrastajien_yhtenaisyys
10	337.83939891371915	2024-04-20 19:24:27.353	32	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys
10	385.1031183537757	2024-04-20 19:24:27.359	32	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys
10	356.03122667128696	2024-04-20 19:24:27.364	32	laukausmaraton	aseharrastajien_yhtenaisyys
10	300.46676485593963	2024-04-20 19:24:27.369	32	vapaa-asekilpailu	aseharrastajien_yhtenaisyys
10	356.2461345543289	2024-04-20 19:24:27.375	32	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys
10	312.11501502927985	2024-04-20 19:24:27.381	32	precision_pistol_cup	aseharrastajien_yhtenaisyys
10	347.2861435313891	2024-04-20 19:24:27.386	32	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys
10	321.90919151612997	2024-04-20 19:24:27.391	32	pikakivaari-klassikko	aseharrastajien_yhtenaisyys
10	304.13895401385383	2024-04-20 19:24:27.397	33	tarkka-ammunta_cup	tahtaysmestarit
10	338.11703762141354	2024-04-20 19:24:27.402	33	nopean_laukauksen_mestaruus	tahtaysmestarit
10	360.4457571301604	2024-04-20 19:24:27.407	33	moniottelu	tahtaysmestarit
10	323.0584474137522	2024-04-20 19:24:27.412	33	kansallinen_tahtayskilpailu	tahtaysmestarit
10	313.85064934067253	2024-04-20 19:24:27.417	33	kaupunkiammunta-challenge	tahtaysmestarit
10	309.45205835581163	2024-04-20 19:24:27.423	33	laukausmaraton	tahtaysmestarit
10	335.6421735479848	2024-04-20 19:24:27.435	33	vapaa-asekilpailu	tahtaysmestarit
10	349.1910067878689	2024-04-20 19:24:27.442	33	taitoluodikko-turnaus	tahtaysmestarit
10	306.9731709291416	2024-04-20 19:24:27.449	33	precision_pistol_cup	tahtaysmestarit
10	319.8895165646485	2024-04-20 19:24:27.455	33	tulevaisuuden_ampuja	tahtaysmestarit
10	333.2483900244765	2024-04-20 19:24:27.462	33	pikakivaari-klassikko	tahtaysmestarit
10	329.85317386352654	2024-04-20 19:24:27.468	34	tarkka-ammunta_cup	tahtaysmestarit
10	305.55836610423427	2024-04-20 19:24:27.473	34	nopean_laukauksen_mestaruus	tahtaysmestarit
10	316.96398284519944	2024-04-20 19:24:27.479	34	moniottelu	tahtaysmestarit
10	283.29844716771004	2024-04-20 19:24:27.487	34	kansallinen_tahtayskilpailu	tahtaysmestarit
10	330.3608364284977	2024-04-20 19:24:27.492	34	kaupunkiammunta-challenge	tahtaysmestarit
10	379.0509015569891	2024-04-20 19:24:27.497	34	laukausmaraton	tahtaysmestarit
10	316.6819160984474	2024-04-20 19:24:27.502	34	vapaa-asekilpailu	tahtaysmestarit
10	323.16054191808547	2024-04-20 19:24:27.507	34	taitoluodikko-turnaus	tahtaysmestarit
10	329.738932258847	2024-04-20 19:24:27.512	34	precision_pistol_cup	tahtaysmestarit
10	296.5505657385206	2024-04-20 19:24:27.517	34	tulevaisuuden_ampuja	tahtaysmestarit
10	322.71645008344245	2024-04-20 19:24:27.522	34	pikakivaari-klassikko	tahtaysmestarit
10	359.16573596348906	2024-04-20 19:24:27.527	35	tarkka-ammunta_cup	tahtaysmestarit
10	317.97611455841763	2024-04-20 19:24:27.534	35	nopean_laukauksen_mestaruus	tahtaysmestarit
10	316.1018831600554	2024-04-20 19:24:27.539	35	moniottelu	tahtaysmestarit
10	307.9308358047069	2024-04-20 19:24:27.544	35	kansallinen_tahtayskilpailu	tahtaysmestarit
10	379.0963739297713	2024-04-20 19:24:27.55	35	kaupunkiammunta-challenge	tahtaysmestarit
10	270.3423339002464	2024-04-20 19:24:27.555	35	laukausmaraton	tahtaysmestarit
10	340.0880896532216	2024-04-20 19:24:27.561	35	vapaa-asekilpailu	tahtaysmestarit
10	348.7454883313844	2024-04-20 19:24:27.566	35	taitoluodikko-turnaus	tahtaysmestarit
10	327.4145215240522	2024-04-20 19:24:27.572	35	precision_pistol_cup	tahtaysmestarit
10	341.7346905403305	2024-04-20 19:24:27.577	35	tulevaisuuden_ampuja	tahtaysmestarit
10	370.9207166233132	2024-04-20 19:24:27.582	35	pikakivaari-klassikko	tahtaysmestarit
10	323.11135468942217	2024-04-20 19:24:27.588	36	tarkka-ammunta_cup	tahtaysmestarit
10	307.1552289760451	2024-04-20 19:24:27.593	36	nopean_laukauksen_mestaruus	tahtaysmestarit
10	317.7273946735788	2024-04-20 19:24:27.598	36	moniottelu	tahtaysmestarit
10	320.2812202507117	2024-04-20 19:24:27.604	36	kansallinen_tahtayskilpailu	tahtaysmestarit
10	288.4686606547713	2024-04-20 19:24:27.608	36	kaupunkiammunta-challenge	tahtaysmestarit
10	334.10260818194064	2024-04-20 19:24:27.614	36	laukausmaraton	tahtaysmestarit
10	328.54591980241355	2024-04-20 19:24:27.618	36	vapaa-asekilpailu	tahtaysmestarit
10	299.68529360431353	2024-04-20 19:24:27.623	36	taitoluodikko-turnaus	tahtaysmestarit
10	315.55736278267176	2024-04-20 19:24:27.629	36	precision_pistol_cup	tahtaysmestarit
10	303.62090983983705	2024-04-20 19:24:27.634	36	tulevaisuuden_ampuja	tahtaysmestarit
10	349.7844262892278	2024-04-20 19:24:27.64	36	pikakivaari-klassikko	tahtaysmestarit
10	331.79375839788287	2024-04-20 19:24:27.645	37	tarkka-ammunta_cup	tahtaysmestarit
10	299.49000246232146	2024-04-20 19:24:27.65	37	nopean_laukauksen_mestaruus	tahtaysmestarit
10	316.01385511187925	2024-04-20 19:24:27.655	37	moniottelu	tahtaysmestarit
10	293.099318296662	2024-04-20 19:24:27.661	37	kansallinen_tahtayskilpailu	tahtaysmestarit
10	344.4594125502461	2024-04-20 19:24:27.666	37	kaupunkiammunta-challenge	tahtaysmestarit
10	326.9672169784756	2024-04-20 19:24:27.672	37	laukausmaraton	tahtaysmestarit
10	279.79469064838065	2024-04-20 19:24:27.677	37	vapaa-asekilpailu	tahtaysmestarit
10	324.56957571281424	2024-04-20 19:24:27.682	37	taitoluodikko-turnaus	tahtaysmestarit
10	325.7178511945702	2024-04-20 19:24:27.688	37	precision_pistol_cup	tahtaysmestarit
10	308.8839540522167	2024-04-20 19:24:27.692	37	tulevaisuuden_ampuja	tahtaysmestarit
10	336.552659726689	2024-04-20 19:24:27.698	37	pikakivaari-klassikko	tahtaysmestarit
10	337.9607135001016	2024-04-20 19:24:27.703	38	tarkka-ammunta_cup	laukausryhma_aurora
10	336.0970520726615	2024-04-20 19:24:27.708	38	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	339.826165490353	2024-04-20 19:24:27.714	38	moniottelu	laukausryhma_aurora
10	324.7392908021666	2024-04-20 19:24:27.72	38	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	324.0445667811856	2024-04-20 19:24:27.725	38	kaupunkiammunta-challenge	laukausryhma_aurora
10	330.0658942626469	2024-04-20 19:24:27.731	38	laukausmaraton	laukausryhma_aurora
10	320.67232456767584	2024-04-20 19:24:27.735	38	vapaa-asekilpailu	laukausryhma_aurora
10	347.6146461578854	2024-04-20 19:24:27.74	38	taitoluodikko-turnaus	laukausryhma_aurora
10	339.72590631312386	2024-04-20 19:24:27.745	38	precision_pistol_cup	laukausryhma_aurora
10	318.19142187193773	2024-04-20 19:24:27.75	38	tulevaisuuden_ampuja	laukausryhma_aurora
10	321.9445326926405	2024-04-20 19:24:27.756	38	pikakivaari-klassikko	laukausryhma_aurora
10	346.11031780692	2024-04-20 19:24:27.761	39	tarkka-ammunta_cup	laukausryhma_aurora
10	310.6637407751961	2024-04-20 19:24:27.766	39	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	367.71623692880934	2024-04-20 19:24:27.771	39	moniottelu	laukausryhma_aurora
10	352.8828120055925	2024-04-20 19:24:27.776	39	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	296.8025742613138	2024-04-20 19:24:27.782	39	kaupunkiammunta-challenge	laukausryhma_aurora
10	318.99665108222547	2024-04-20 19:24:27.786	39	laukausmaraton	laukausryhma_aurora
10	311.5638559356794	2024-04-20 19:24:27.791	39	vapaa-asekilpailu	laukausryhma_aurora
10	319.0838228322834	2024-04-20 19:24:27.796	39	taitoluodikko-turnaus	laukausryhma_aurora
10	292.94042435188015	2024-04-20 19:24:27.801	39	precision_pistol_cup	laukausryhma_aurora
10	323.46746463332073	2024-04-20 19:24:27.806	39	tulevaisuuden_ampuja	laukausryhma_aurora
10	292.1804027425892	2024-04-20 19:24:27.811	39	pikakivaari-klassikko	laukausryhma_aurora
10	311.2575154832074	2024-04-20 19:24:27.816	40	tarkka-ammunta_cup	laukausryhma_aurora
10	337.87923154747466	2024-04-20 19:24:27.821	40	nopean_laukauksen_mestaruus	laukausryhma_aurora
10	321.4047487105868	2024-04-20 19:24:27.826	40	moniottelu	laukausryhma_aurora
10	295.9090648312433	2024-04-20 19:24:27.83	40	kansallinen_tahtayskilpailu	laukausryhma_aurora
10	342.4962137317437	2024-04-20 19:24:27.835	40	kaupunkiammunta-challenge	laukausryhma_aurora
10	274.96563477624085	2024-04-20 19:24:27.84	40	laukausmaraton	laukausryhma_aurora
10	335.99766477516783	2024-04-20 19:24:27.845	40	vapaa-asekilpailu	laukausryhma_aurora
10	334.32562348361284	2024-04-20 19:24:27.85	40	taitoluodikko-turnaus	laukausryhma_aurora
10	291.56627161952076	2024-04-20 19:24:27.855	40	precision_pistol_cup	laukausryhma_aurora
10	355.63251587086876	2024-04-20 19:24:27.86	40	tulevaisuuden_ampuja	laukausryhma_aurora
10	301.50846352893683	2024-04-20 19:24:27.865	40	pikakivaari-klassikko	laukausryhma_aurora
10	321.29492420736244	2024-04-20 19:24:27.87	41	tarkka-ammunta_cup	ampumataito
10	367.64905813366124	2024-04-20 19:24:27.875	41	nopean_laukauksen_mestaruus	ampumataito
10	318.4361881737153	2024-04-20 19:24:27.88	41	moniottelu	ampumataito
10	279.34371444103107	2024-04-20 19:24:27.885	41	kansallinen_tahtayskilpailu	ampumataito
10	319.25619427703344	2024-04-20 19:24:27.89	41	kaupunkiammunta-challenge	ampumataito
10	353.5372730275953	2024-04-20 19:24:27.894	41	laukausmaraton	ampumataito
10	337.2027839118363	2024-04-20 19:24:27.899	41	vapaa-asekilpailu	ampumataito
10	349.3371807884143	2024-04-20 19:24:27.904	41	taitoluodikko-turnaus	ampumataito
10	313.342717664256	2024-04-20 19:24:27.908	41	precision_pistol_cup	ampumataito
10	320.32835519886595	2024-04-20 19:24:27.914	41	tulevaisuuden_ampuja	ampumataito
10	344.6525253145562	2024-04-20 19:24:27.918	41	pikakivaari-klassikko	ampumataito
10	323.97585411596594	2024-04-20 19:24:27.923	42	tarkka-ammunta_cup	ampumataito
10	286.94532705452974	2024-04-20 19:24:27.928	42	nopean_laukauksen_mestaruus	ampumataito
10	275.7586613766522	2024-04-20 19:24:27.933	42	moniottelu	ampumataito
10	309.1734131712459	2024-04-20 19:24:27.938	42	kansallinen_tahtayskilpailu	ampumataito
10	344.58606223384356	2024-04-20 19:24:27.943	42	kaupunkiammunta-challenge	ampumataito
10	298.6183935958754	2024-04-20 19:24:27.948	42	laukausmaraton	ampumataito
10	282.92496055605636	2024-04-20 19:24:27.952	42	vapaa-asekilpailu	ampumataito
10	316.0209631812558	2024-04-20 19:24:27.957	42	taitoluodikko-turnaus	ampumataito
10	336.69084972612546	2024-04-20 19:24:27.963	42	precision_pistol_cup	ampumataito
10	343.4427886438018	2024-04-20 19:24:27.968	42	tulevaisuuden_ampuja	ampumataito
10	272.4061208787037	2024-04-20 19:24:27.972	42	pikakivaari-klassikko	ampumataito
10	348.59376453463443	2024-04-20 19:24:27.977	43	tarkka-ammunta_cup	ampumataito
10	319.004506181112	2024-04-20 19:24:27.983	43	nopean_laukauksen_mestaruus	ampumataito
10	341.0738340958722	2024-04-20 19:24:27.988	43	moniottelu	ampumataito
10	259.93018118114526	2024-04-20 19:24:27.994	43	kansallinen_tahtayskilpailu	ampumataito
10	295.0749081686002	2024-04-20 19:24:28	43	kaupunkiammunta-challenge	ampumataito
10	362.4065682589161	2024-04-20 19:24:28.006	43	laukausmaraton	ampumataito
10	327.87659690547196	2024-04-20 19:24:28.012	43	vapaa-asekilpailu	ampumataito
10	346.3944535512698	2024-04-20 19:24:28.018	43	taitoluodikko-turnaus	ampumataito
10	323.99859409912494	2024-04-20 19:24:28.023	43	precision_pistol_cup	ampumataito
10	340.9802774696605	2024-04-20 19:24:28.029	43	tulevaisuuden_ampuja	ampumataito
10	317.54181839101454	2024-04-20 19:24:28.035	43	pikakivaari-klassikko	ampumataito
10	334.7869710731384	2024-04-20 19:24:28.041	2	kesan_ampujaiset	poliisiseura
10	301.25794516367307	2024-04-20 19:24:28.047	2	talvi_pistooli	poliisiseura
10	324.2741639341313	2024-04-20 19:24:28.052	2	tarkkuuslaukaus-festivaali	poliisiseura
10	326.4632180265409	2024-04-20 19:24:28.058	2	kivaarikilpailujen_huipennus	poliisiseura
10	349.27037778933635	2024-04-20 19:24:28.064	2	polaris-ampumaharjoitus	poliisiseura
10	294.9664857822296	2024-04-20 19:24:28.07	2	aamunkoiton_tahtays	poliisiseura
10	325.76338013411936	2024-04-20 19:24:28.075	2	nordic_sharpshooters_cup	poliisiseura
10	317.70109130938425	2024-04-20 19:24:28.081	2	taivaanranta-tulitus	poliisiseura
10	344.2932837721072	2024-04-20 19:24:28.087	2	lumivyory-ammunta	poliisiseura
10	354.4767405631945	2024-04-20 19:24:28.092	3	kesan_ampujaiset	poliisiseura
10	365.1399044917851	2024-04-20 19:24:28.097	3	talvi_pistooli	poliisiseura
10	363.2634899571622	2024-04-20 19:24:28.103	3	tarkkuuslaukaus-festivaali	poliisiseura
10	355.21784241801004	2024-04-20 19:24:28.107	3	kivaarikilpailujen_huipennus	poliisiseura
10	290.0409065170873	2024-04-20 19:24:28.113	3	polaris-ampumaharjoitus	poliisiseura
10	289.8840179157142	2024-04-20 19:24:28.117	3	aamunkoiton_tahtays	poliisiseura
10	354.6472219210996	2024-04-20 19:24:28.122	3	nordic_sharpshooters_cup	poliisiseura
10	308.8407721305093	2024-04-20 19:24:28.126	3	taivaanranta-tulitus	poliisiseura
10	362.94631913790687	2024-04-20 19:24:28.132	3	lumivyory-ammunta	poliisiseura
10	351.25355140679403	2024-04-20 19:24:28.136	4	kesan_ampujaiset	poliisiseura
10	315.83186195943364	2024-04-20 19:24:28.141	4	talvi_pistooli	poliisiseura
10	310.34063887045215	2024-04-20 19:24:28.146	4	tarkkuuslaukaus-festivaali	poliisiseura
10	319.7432299509167	2024-04-20 19:24:28.15	4	kivaarikilpailujen_huipennus	poliisiseura
10	383.9025357372063	2024-04-20 19:24:28.155	4	polaris-ampumaharjoitus	poliisiseura
10	312.20544457361297	2024-04-20 19:24:28.159	4	aamunkoiton_tahtays	poliisiseura
10	304.4682797994988	2024-04-20 19:24:28.164	4	nordic_sharpshooters_cup	poliisiseura
10	321.4689845980492	2024-04-20 19:24:28.169	4	taivaanranta-tulitus	poliisiseura
10	304.47776808563356	2024-04-20 19:24:28.174	4	lumivyory-ammunta	poliisiseura
10	344.45758966881294	2024-04-20 19:24:28.178	5	kesan_ampujaiset	koiraseura
10	304.4129963488417	2024-04-20 19:24:28.183	5	talvi_pistooli	koiraseura
10	361.63173640827875	2024-04-20 19:24:28.188	5	tarkkuuslaukaus-festivaali	koiraseura
10	314.5577280162845	2024-04-20 19:24:28.192	5	kivaarikilpailujen_huipennus	koiraseura
10	333.3499989404425	2024-04-20 19:24:28.197	5	polaris-ampumaharjoitus	koiraseura
10	335.0552072155024	2024-04-20 19:24:28.202	5	aamunkoiton_tahtays	koiraseura
10	333.86005745632383	2024-04-20 19:24:28.207	5	nordic_sharpshooters_cup	koiraseura
10	309.64317506138275	2024-04-20 19:24:28.211	5	taivaanranta-tulitus	koiraseura
10	341.5710453425091	2024-04-20 19:24:28.216	5	lumivyory-ammunta	koiraseura
10	317.3351150173404	2024-04-20 19:24:28.221	6	kesan_ampujaiset	koiraseura
10	335.66703357708434	2024-04-20 19:24:28.225	6	talvi_pistooli	koiraseura
10	317.8351044497178	2024-04-20 19:24:28.23	6	tarkkuuslaukaus-festivaali	koiraseura
10	291.00072996830585	2024-04-20 19:24:28.234	6	kivaarikilpailujen_huipennus	koiraseura
10	343.86748323521675	2024-04-20 19:24:28.239	6	polaris-ampumaharjoitus	koiraseura
10	332.25860176800643	2024-04-20 19:24:28.244	6	aamunkoiton_tahtays	koiraseura
10	343.36725973364224	2024-04-20 19:24:28.259	6	nordic_sharpshooters_cup	koiraseura
10	329.04449541132936	2024-04-20 19:24:28.266	6	taivaanranta-tulitus	koiraseura
10	310.7551865556844	2024-04-20 19:24:28.274	6	lumivyory-ammunta	koiraseura
10	345.43483123702055	2024-04-20 19:24:28.28	7	kesan_ampujaiset	koiraseura
10	314.13727296490316	2024-04-20 19:24:28.285	7	talvi_pistooli	koiraseura
10	340.9758607278317	2024-04-20 19:24:28.292	7	tarkkuuslaukaus-festivaali	koiraseura
10	324.91742828443245	2024-04-20 19:24:28.298	7	kivaarikilpailujen_huipennus	koiraseura
10	350.7106416946115	2024-04-20 19:24:28.302	7	polaris-ampumaharjoitus	koiraseura
10	333.1479272251734	2024-04-20 19:24:28.307	7	aamunkoiton_tahtays	koiraseura
10	337.17042344350546	2024-04-20 19:24:28.312	7	nordic_sharpshooters_cup	koiraseura
10	351.95673937492	2024-04-20 19:24:28.317	7	taivaanranta-tulitus	koiraseura
10	293.9921591995151	2024-04-20 19:24:28.322	7	lumivyory-ammunta	koiraseura
10	327.99746645563187	2024-04-20 19:24:28.326	8	kesan_ampujaiset	hammaspeikkoseura
10	314.11441131601543	2024-04-20 19:24:28.332	8	talvi_pistooli	hammaspeikkoseura
10	319.82684202226494	2024-04-20 19:24:28.336	8	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	312.642915401484	2024-04-20 19:24:28.341	8	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	312.2716204715367	2024-04-20 19:24:28.346	8	polaris-ampumaharjoitus	hammaspeikkoseura
10	307.7779408299169	2024-04-20 19:24:28.351	8	aamunkoiton_tahtays	hammaspeikkoseura
10	330.25659945795337	2024-04-20 19:24:28.355	8	nordic_sharpshooters_cup	hammaspeikkoseura
10	323.8714899359426	2024-04-20 19:24:28.36	8	taivaanranta-tulitus	hammaspeikkoseura
10	314.438285147747	2024-04-20 19:24:28.365	8	lumivyory-ammunta	hammaspeikkoseura
10	372.7914374701743	2024-04-20 19:24:28.369	9	kesan_ampujaiset	hammaspeikkoseura
10	311.16795735019963	2024-04-20 19:24:28.373	9	talvi_pistooli	hammaspeikkoseura
10	298.1846150642504	2024-04-20 19:24:28.378	9	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	312.1224515655328	2024-04-20 19:24:28.382	9	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	317.4397124226365	2024-04-20 19:24:28.387	9	polaris-ampumaharjoitus	hammaspeikkoseura
10	388.99023229584486	2024-04-20 19:24:28.392	9	aamunkoiton_tahtays	hammaspeikkoseura
10	340.5845609208068	2024-04-20 19:24:28.397	9	nordic_sharpshooters_cup	hammaspeikkoseura
10	343.38643075935505	2024-04-20 19:24:28.401	9	taivaanranta-tulitus	hammaspeikkoseura
10	351.5457400546892	2024-04-20 19:24:28.406	9	lumivyory-ammunta	hammaspeikkoseura
10	332.19968377940233	2024-04-20 19:24:28.41	10	kesan_ampujaiset	hammaspeikkoseura
10	309.6384723782652	2024-04-20 19:24:28.415	10	talvi_pistooli	hammaspeikkoseura
10	364.16934977812195	2024-04-20 19:24:28.42	10	tarkkuuslaukaus-festivaali	hammaspeikkoseura
10	317.46168913602827	2024-04-20 19:24:28.424	10	kivaarikilpailujen_huipennus	hammaspeikkoseura
10	294.7932035629588	2024-04-20 19:24:28.429	10	polaris-ampumaharjoitus	hammaspeikkoseura
10	305.6728158992972	2024-04-20 19:24:28.433	10	aamunkoiton_tahtays	hammaspeikkoseura
10	276.65524725428935	2024-04-20 19:24:28.438	10	nordic_sharpshooters_cup	hammaspeikkoseura
10	336.5258424711973	2024-04-20 19:24:28.442	10	taivaanranta-tulitus	hammaspeikkoseura
10	326.6441727252201	2024-04-20 19:24:28.447	10	lumivyory-ammunta	hammaspeikkoseura
10	315.13049728157483	2024-04-20 19:24:28.452	11	kesan_ampujaiset	dog
10	354.8100479027091	2024-04-20 19:24:28.456	11	talvi_pistooli	dog
10	314.96377999513163	2024-04-20 19:24:28.46	11	tarkkuuslaukaus-festivaali	dog
10	318.89385122363126	2024-04-20 19:24:28.465	11	kivaarikilpailujen_huipennus	dog
10	310.35306841272654	2024-04-20 19:24:28.469	11	polaris-ampumaharjoitus	dog
10	333.6744474069966	2024-04-20 19:24:28.474	11	aamunkoiton_tahtays	dog
10	320.9264594270217	2024-04-20 19:24:28.479	11	nordic_sharpshooters_cup	dog
10	314.27729745975023	2024-04-20 19:24:28.484	11	taivaanranta-tulitus	dog
10	352.58310819258793	2024-04-20 19:24:28.488	11	lumivyory-ammunta	dog
10	328.0639473195304	2024-04-20 19:24:28.493	12	kesan_ampujaiset	dog
10	342.8753180781095	2024-04-20 19:24:28.498	12	talvi_pistooli	dog
10	327.70165234651836	2024-04-20 19:24:28.502	12	tarkkuuslaukaus-festivaali	dog
10	318.158907943861	2024-04-20 19:24:28.507	12	kivaarikilpailujen_huipennus	dog
10	330.0086843801766	2024-04-20 19:24:28.511	12	polaris-ampumaharjoitus	dog
10	364.8635707901637	2024-04-20 19:24:28.516	12	aamunkoiton_tahtays	dog
10	357.89670381600143	2024-04-20 19:24:28.521	12	nordic_sharpshooters_cup	dog
10	322.78223570749276	2024-04-20 19:24:28.525	12	taivaanranta-tulitus	dog
10	330.2090007505598	2024-04-20 19:24:28.53	12	lumivyory-ammunta	dog
10	348.1699595742513	2024-04-20 19:24:28.534	13	kesan_ampujaiset	dog
10	285.8622125554527	2024-04-20 19:24:28.538	13	talvi_pistooli	dog
10	311.55865176173705	2024-04-20 19:24:28.543	13	tarkkuuslaukaus-festivaali	dog
10	314.66191740253714	2024-04-20 19:24:28.548	13	kivaarikilpailujen_huipennus	dog
10	349.65572576320335	2024-04-20 19:24:28.552	13	polaris-ampumaharjoitus	dog
10	287.9488469828621	2024-04-20 19:24:28.557	13	aamunkoiton_tahtays	dog
10	330.18167236771455	2024-04-20 19:24:28.561	13	nordic_sharpshooters_cup	dog
10	289.9712875513056	2024-04-20 19:24:28.566	13	taivaanranta-tulitus	dog
10	285.49749511339127	2024-04-20 19:24:28.571	13	lumivyory-ammunta	dog
10	341.4734415702429	2024-04-20 19:24:28.575	14	kesan_ampujaiset	savu_seura
10	301.4217870629345	2024-04-20 19:24:28.58	14	talvi_pistooli	savu_seura
10	314.59490777893024	2024-04-20 19:24:28.584	14	tarkkuuslaukaus-festivaali	savu_seura
10	317.9973901654284	2024-04-20 19:24:28.59	14	kivaarikilpailujen_huipennus	savu_seura
10	310.96297396566234	2024-04-20 19:24:28.594	14	polaris-ampumaharjoitus	savu_seura
10	350.5663773269964	2024-04-20 19:24:28.599	14	aamunkoiton_tahtays	savu_seura
10	366.25173056771513	2024-04-20 19:24:28.604	14	nordic_sharpshooters_cup	savu_seura
10	325.98518298848654	2024-04-20 19:24:28.609	14	taivaanranta-tulitus	savu_seura
10	306.96394838940694	2024-04-20 19:24:28.613	14	lumivyory-ammunta	savu_seura
10	283.5283468258002	2024-04-20 19:24:28.618	15	kesan_ampujaiset	savu_seura
10	280.029300108907	2024-04-20 19:24:28.622	15	talvi_pistooli	savu_seura
10	301.17560577240107	2024-04-20 19:24:28.627	15	tarkkuuslaukaus-festivaali	savu_seura
10	322.25217649146373	2024-04-20 19:24:28.632	15	kivaarikilpailujen_huipennus	savu_seura
10	338.9145937208709	2024-04-20 19:24:28.636	15	polaris-ampumaharjoitus	savu_seura
10	300.8781469340863	2024-04-20 19:24:28.641	15	aamunkoiton_tahtays	savu_seura
10	299.3669886858732	2024-04-20 19:24:28.645	15	nordic_sharpshooters_cup	savu_seura
10	329.2506058807325	2024-04-20 19:24:28.65	15	taivaanranta-tulitus	savu_seura
10	319.3445117254275	2024-04-20 19:24:28.654	15	lumivyory-ammunta	savu_seura
10	337.67753995928643	2024-04-20 19:24:28.659	16	kesan_ampujaiset	savu_seura
10	349.52181653344877	2024-04-20 19:24:28.664	16	talvi_pistooli	savu_seura
10	323.3605679104063	2024-04-20 19:24:28.668	16	tarkkuuslaukaus-festivaali	savu_seura
10	302.26153034316457	2024-04-20 19:24:28.673	16	kivaarikilpailujen_huipennus	savu_seura
10	320.5149200404347	2024-04-20 19:24:28.677	16	polaris-ampumaharjoitus	savu_seura
10	353.51232461368494	2024-04-20 19:24:28.682	16	aamunkoiton_tahtays	savu_seura
10	300.95274724213664	2024-04-20 19:24:28.687	16	nordic_sharpshooters_cup	savu_seura
10	377.48123020605766	2024-04-20 19:24:28.691	16	taivaanranta-tulitus	savu_seura
10	295.265086769211	2024-04-20 19:24:28.696	16	lumivyory-ammunta	savu_seura
10	334.1343133958347	2024-04-20 19:24:28.701	17	kesan_ampujaiset	savu_seura
10	309.2448739914523	2024-04-20 19:24:28.706	17	talvi_pistooli	savu_seura
10	357.08017303499395	2024-04-20 19:24:28.71	17	tarkkuuslaukaus-festivaali	savu_seura
10	337.7491604131489	2024-04-20 19:24:28.715	17	kivaarikilpailujen_huipennus	savu_seura
10	334.55975158874315	2024-04-20 19:24:28.72	17	polaris-ampumaharjoitus	savu_seura
10	327.1144613703247	2024-04-20 19:24:28.725	17	aamunkoiton_tahtays	savu_seura
10	344.5564941855309	2024-04-20 19:24:28.73	17	nordic_sharpshooters_cup	savu_seura
10	377.4746464193842	2024-04-20 19:24:28.734	17	taivaanranta-tulitus	savu_seura
10	352.01508237397496	2024-04-20 19:24:28.739	17	lumivyory-ammunta	savu_seura
10	294.3858205154915	2024-04-20 19:24:28.744	18	kesan_ampujaiset	savu_seura
10	343.11660092417236	2024-04-20 19:24:28.749	18	talvi_pistooli	savu_seura
10	385.6659918728512	2024-04-20 19:24:28.754	18	tarkkuuslaukaus-festivaali	savu_seura
10	303.1830543714703	2024-04-20 19:24:28.759	18	kivaarikilpailujen_huipennus	savu_seura
10	325.44774336192893	2024-04-20 19:24:28.763	18	polaris-ampumaharjoitus	savu_seura
10	333.59737354932093	2024-04-20 19:24:28.768	18	aamunkoiton_tahtays	savu_seura
10	293.28667924745184	2024-04-20 19:24:28.773	18	nordic_sharpshooters_cup	savu_seura
10	399.14313472636746	2024-04-20 19:24:28.778	18	taivaanranta-tulitus	savu_seura
10	309.33025881332935	2024-04-20 19:24:28.782	18	lumivyory-ammunta	savu_seura
10	307.9286335307446	2024-04-20 19:24:28.788	19	kesan_ampujaiset	omas
10	334.42990136501686	2024-04-20 19:24:28.792	19	talvi_pistooli	omas
10	354.67936079573593	2024-04-20 19:24:28.797	19	tarkkuuslaukaus-festivaali	omas
10	272.51449639722375	2024-04-20 19:24:28.802	19	kivaarikilpailujen_huipennus	omas
10	323.5770005610661	2024-04-20 19:24:28.806	19	polaris-ampumaharjoitus	omas
10	319.4672321029779	2024-04-20 19:24:28.811	19	aamunkoiton_tahtays	omas
10	317.97548757494144	2024-04-20 19:24:28.815	19	nordic_sharpshooters_cup	omas
10	323.02496024404644	2024-04-20 19:24:28.82	19	taivaanranta-tulitus	omas
10	300.89233643832455	2024-04-20 19:24:28.825	19	lumivyory-ammunta	omas
10	289.29980675327937	2024-04-20 19:24:28.83	20	kesan_ampujaiset	omas
10	308.9962111187857	2024-04-20 19:24:28.834	20	talvi_pistooli	omas
10	350.38745912198453	2024-04-20 19:24:28.84	20	tarkkuuslaukaus-festivaali	omas
10	324.53186256481206	2024-04-20 19:24:28.845	20	kivaarikilpailujen_huipennus	omas
10	341.6629496640498	2024-04-20 19:24:28.85	20	polaris-ampumaharjoitus	omas
10	321.0327887258033	2024-04-20 19:24:28.854	20	aamunkoiton_tahtays	omas
10	323.53318979611316	2024-04-20 19:24:28.858	20	nordic_sharpshooters_cup	omas
10	312.47913774724935	2024-04-20 19:24:28.864	20	taivaanranta-tulitus	omas
10	352.84861642406065	2024-04-20 19:24:28.868	20	lumivyory-ammunta	omas
10	298.16536551089786	2024-04-20 19:24:28.873	21	kesan_ampujaiset	omas
10	368.9308497031234	2024-04-20 19:24:28.877	21	talvi_pistooli	omas
10	289.2283192135231	2024-04-20 19:24:28.882	21	tarkkuuslaukaus-festivaali	omas
10	334.01358383714086	2024-04-20 19:24:28.886	21	kivaarikilpailujen_huipennus	omas
10	320.4788861533796	2024-04-20 19:24:28.89	21	polaris-ampumaharjoitus	omas
10	343.14403524067046	2024-04-20 19:24:28.895	21	aamunkoiton_tahtays	omas
10	320.7450550231496	2024-04-20 19:24:28.899	21	nordic_sharpshooters_cup	omas
10	360.3732408223678	2024-04-20 19:24:28.904	21	taivaanranta-tulitus	omas
10	333.0145577520658	2024-04-20 19:24:28.909	21	lumivyory-ammunta	omas
10	341.72589063060065	2024-04-20 19:24:28.914	22	kesan_ampujaiset	omas
10	324.03293688621255	2024-04-20 19:24:28.919	22	talvi_pistooli	omas
10	346.2766591517411	2024-04-20 19:24:28.924	22	tarkkuuslaukaus-festivaali	omas
10	370.51224728042456	2024-04-20 19:24:28.928	22	kivaarikilpailujen_huipennus	omas
10	326.007717552666	2024-04-20 19:24:28.933	22	polaris-ampumaharjoitus	omas
10	338.0921642867153	2024-04-20 19:24:28.938	22	aamunkoiton_tahtays	omas
10	341.73340186013996	2024-04-20 19:24:28.943	22	nordic_sharpshooters_cup	omas
10	299.4147842895574	2024-04-20 19:24:28.947	22	taivaanranta-tulitus	omas
10	292.18913766649104	2024-04-20 19:24:28.952	22	lumivyory-ammunta	omas
10	299.5314325766049	2024-04-20 19:24:28.957	23	kesan_ampujaiset	pelleseura
10	325.01045937160796	2024-04-20 19:24:28.962	23	talvi_pistooli	pelleseura
10	337.32027236182915	2024-04-20 19:24:28.967	23	tarkkuuslaukaus-festivaali	pelleseura
10	326.80413342489226	2024-04-20 19:24:28.972	23	kivaarikilpailujen_huipennus	pelleseura
10	340.0488602762288	2024-04-20 19:24:28.976	23	polaris-ampumaharjoitus	pelleseura
10	272.6021121211791	2024-04-20 19:24:28.981	23	aamunkoiton_tahtays	pelleseura
10	310.6762115246039	2024-04-20 19:24:28.985	23	nordic_sharpshooters_cup	pelleseura
10	347.1831334335801	2024-04-20 19:24:28.99	23	taivaanranta-tulitus	pelleseura
10	338.58866249037754	2024-04-20 19:24:28.995	23	lumivyory-ammunta	pelleseura
10	346.3516474294756	2024-04-20 19:24:29	24	kesan_ampujaiset	pelleseura
10	295.4262651526615	2024-04-20 19:24:29.005	24	talvi_pistooli	pelleseura
10	305.0338718924017	2024-04-20 19:24:29.009	24	tarkkuuslaukaus-festivaali	pelleseura
10	299.00846204513556	2024-04-20 19:24:29.014	24	kivaarikilpailujen_huipennus	pelleseura
10	362.20266933914115	2024-04-20 19:24:29.019	24	polaris-ampumaharjoitus	pelleseura
10	301.1518031525648	2024-04-20 19:24:29.023	24	aamunkoiton_tahtays	pelleseura
10	266.2369129535683	2024-04-20 19:24:29.028	24	nordic_sharpshooters_cup	pelleseura
10	320.0812571184392	2024-04-20 19:24:29.033	24	taivaanranta-tulitus	pelleseura
10	317.56118088236116	2024-04-20 19:24:29.038	24	lumivyory-ammunta	pelleseura
10	326.4680984780913	2024-04-20 19:24:29.042	25	kesan_ampujaiset	pelleseura
10	324.462634761753	2024-04-20 19:24:29.047	25	talvi_pistooli	pelleseura
10	305.64700105998156	2024-04-20 19:24:29.052	25	tarkkuuslaukaus-festivaali	pelleseura
10	299.8413351157274	2024-04-20 19:24:29.057	25	kivaarikilpailujen_huipennus	pelleseura
10	352.26188378327987	2024-04-20 19:24:29.061	25	polaris-ampumaharjoitus	pelleseura
10	315.32178215862285	2024-04-20 19:24:29.066	25	aamunkoiton_tahtays	pelleseura
10	334.9988952448942	2024-04-20 19:24:29.07	25	nordic_sharpshooters_cup	pelleseura
10	326.4238316624004	2024-04-20 19:24:29.075	25	taivaanranta-tulitus	pelleseura
10	319.3714813862443	2024-04-20 19:24:29.079	25	lumivyory-ammunta	pelleseura
10	340.15057155895255	2024-04-20 19:24:29.084	26	kesan_ampujaiset	pelleseura
10	304.6442487119547	2024-04-20 19:24:29.097	26	talvi_pistooli	pelleseura
10	352.4217813788275	2024-04-20 19:24:29.104	26	tarkkuuslaukaus-festivaali	pelleseura
10	355.2154387920659	2024-04-20 19:24:29.111	26	kivaarikilpailujen_huipennus	pelleseura
10	317.1084668265133	2024-04-20 19:24:29.118	26	polaris-ampumaharjoitus	pelleseura
10	318.6698326196015	2024-04-20 19:24:29.124	26	aamunkoiton_tahtays	pelleseura
10	345.81775605399974	2024-04-20 19:24:29.129	26	nordic_sharpshooters_cup	pelleseura
10	314.7839605332182	2024-04-20 19:24:29.136	26	taivaanranta-tulitus	pelleseura
10	365.94012063631976	2024-04-20 19:24:29.142	26	lumivyory-ammunta	pelleseura
10	306.59414124581997	2024-04-20 19:24:29.146	27	kesan_ampujaiset	yung_tallent
10	347.5934659805329	2024-04-20 19:24:29.151	27	talvi_pistooli	yung_tallent
10	312.8019898448172	2024-04-20 19:24:29.156	27	tarkkuuslaukaus-festivaali	yung_tallent
10	326.2370866341133	2024-04-20 19:24:29.161	27	kivaarikilpailujen_huipennus	yung_tallent
10	315.503262528491	2024-04-20 19:24:29.165	27	polaris-ampumaharjoitus	yung_tallent
10	344.6881909571483	2024-04-20 19:24:29.17	27	aamunkoiton_tahtays	yung_tallent
10	315.9861339971864	2024-04-20 19:24:29.174	27	nordic_sharpshooters_cup	yung_tallent
10	378.2215773117889	2024-04-20 19:24:29.179	27	taivaanranta-tulitus	yung_tallent
10	293.62886108671836	2024-04-20 19:24:29.183	27	lumivyory-ammunta	yung_tallent
10	342.3772141947215	2024-04-20 19:24:29.188	28	kesan_ampujaiset	yung_tallent
10	338.4236659427803	2024-04-20 19:24:29.192	28	talvi_pistooli	yung_tallent
10	320.7275203961445	2024-04-20 19:24:29.197	28	tarkkuuslaukaus-festivaali	yung_tallent
10	355.35763792286707	2024-04-20 19:24:29.201	28	kivaarikilpailujen_huipennus	yung_tallent
10	314.1606602676454	2024-04-20 19:24:29.206	28	polaris-ampumaharjoitus	yung_tallent
10	321.1911127778531	2024-04-20 19:24:29.21	28	aamunkoiton_tahtays	yung_tallent
10	303.46256926196907	2024-04-20 19:24:29.215	28	nordic_sharpshooters_cup	yung_tallent
10	309.2497883810242	2024-04-20 19:24:29.219	28	taivaanranta-tulitus	yung_tallent
10	318.84406312743874	2024-04-20 19:24:29.223	28	lumivyory-ammunta	yung_tallent
10	308.6832409389126	2024-04-20 19:24:29.228	29	kesan_ampujaiset	yung_tallent
10	309.0356742508679	2024-04-20 19:24:29.233	29	talvi_pistooli	yung_tallent
10	328.2914840135671	2024-04-20 19:24:29.238	29	tarkkuuslaukaus-festivaali	yung_tallent
10	336.7950261204097	2024-04-20 19:24:29.243	29	kivaarikilpailujen_huipennus	yung_tallent
10	339.29338109984303	2024-04-20 19:24:29.248	29	polaris-ampumaharjoitus	yung_tallent
10	344.6379608118046	2024-04-20 19:24:29.253	29	aamunkoiton_tahtays	yung_tallent
10	337.12289500334333	2024-04-20 19:24:29.258	29	nordic_sharpshooters_cup	yung_tallent
10	370.80699064950215	2024-04-20 19:24:29.264	29	taivaanranta-tulitus	yung_tallent
10	336.03177535829394	2024-04-20 19:24:29.269	29	lumivyory-ammunta	yung_tallent
10	293.52134498145244	2024-04-20 19:24:29.274	30	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	318.68385329775765	2024-04-20 19:24:29.278	30	talvi_pistooli	aseharrastajien_yhtenaisyys
10	344.71958161551834	2024-04-20 19:24:29.283	30	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	349.01834401384764	2024-04-20 19:24:29.288	30	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	349.6744997030415	2024-04-20 19:24:29.292	30	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	333.6642703637322	2024-04-20 19:24:29.297	30	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	349.56911806481395	2024-04-20 19:24:29.303	30	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	341.66432662248343	2024-04-20 19:24:29.307	30	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	359.51797594534236	2024-04-20 19:24:29.313	30	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	311.9406998393121	2024-04-20 19:24:29.318	31	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	309.7929196784854	2024-04-20 19:24:29.323	31	talvi_pistooli	aseharrastajien_yhtenaisyys
10	327.84149243383087	2024-04-20 19:24:29.328	31	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	318.6275739656909	2024-04-20 19:24:29.333	31	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	341.3802355020901	2024-04-20 19:24:29.339	31	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	313.1297326686617	2024-04-20 19:24:29.343	31	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	339.22941951652285	2024-04-20 19:24:29.348	31	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	366.7910898546245	2024-04-20 19:24:29.353	31	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	347.27054293169925	2024-04-20 19:24:29.358	31	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	319.5113718843534	2024-04-20 19:24:29.363	32	kesan_ampujaiset	aseharrastajien_yhtenaisyys
10	295.1427984323933	2024-04-20 19:24:29.368	32	talvi_pistooli	aseharrastajien_yhtenaisyys
10	318.2196788903675	2024-04-20 19:24:29.372	32	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys
10	360.88586624465495	2024-04-20 19:24:29.377	32	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys
10	343.28020787963726	2024-04-20 19:24:29.382	32	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys
10	281.64301544632787	2024-04-20 19:24:29.386	32	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys
10	333.6988735225231	2024-04-20 19:24:29.392	32	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys
10	367.3892219714437	2024-04-20 19:24:29.398	32	taivaanranta-tulitus	aseharrastajien_yhtenaisyys
10	340.3750196064814	2024-04-20 19:24:29.403	32	lumivyory-ammunta	aseharrastajien_yhtenaisyys
10	373.0200353523454	2024-04-20 19:24:29.408	33	kesan_ampujaiset	tahtaysmestarit
10	336.14878524500887	2024-04-20 19:24:29.413	33	talvi_pistooli	tahtaysmestarit
10	366.235747797008	2024-04-20 19:24:29.418	33	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	357.9911359264103	2024-04-20 19:24:29.423	33	kivaarikilpailujen_huipennus	tahtaysmestarit
10	317.09587304344046	2024-04-20 19:24:29.428	33	polaris-ampumaharjoitus	tahtaysmestarit
10	272.7704525507753	2024-04-20 19:24:29.434	33	aamunkoiton_tahtays	tahtaysmestarit
10	337.807570011138	2024-04-20 19:24:29.439	33	nordic_sharpshooters_cup	tahtaysmestarit
10	309.34670205923953	2024-04-20 19:24:29.444	33	taivaanranta-tulitus	tahtaysmestarit
10	321.44068735006937	2024-04-20 19:24:29.449	33	lumivyory-ammunta	tahtaysmestarit
10	325.50944284626553	2024-04-20 19:24:29.455	34	kesan_ampujaiset	tahtaysmestarit
10	328.5498983154552	2024-04-20 19:24:29.461	34	talvi_pistooli	tahtaysmestarit
10	342.93728776378356	2024-04-20 19:24:29.467	34	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	325.9589924623501	2024-04-20 19:24:29.473	34	kivaarikilpailujen_huipennus	tahtaysmestarit
10	314.30990736547903	2024-04-20 19:24:29.479	34	polaris-ampumaharjoitus	tahtaysmestarit
10	374.20056032525247	2024-04-20 19:24:29.484	34	aamunkoiton_tahtays	tahtaysmestarit
10	313.3982314074632	2024-04-20 19:24:29.489	34	nordic_sharpshooters_cup	tahtaysmestarit
10	364.5808275510519	2024-04-20 19:24:29.493	34	taivaanranta-tulitus	tahtaysmestarit
10	331.09563142756645	2024-04-20 19:24:29.499	34	lumivyory-ammunta	tahtaysmestarit
10	316.3601481187169	2024-04-20 19:24:29.504	35	kesan_ampujaiset	tahtaysmestarit
10	318.47418123158394	2024-04-20 19:24:29.509	35	talvi_pistooli	tahtaysmestarit
10	332.1337967259003	2024-04-20 19:24:29.514	35	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	368.203239222347	2024-04-20 19:24:29.519	35	kivaarikilpailujen_huipennus	tahtaysmestarit
10	322.8668736676684	2024-04-20 19:24:29.523	35	polaris-ampumaharjoitus	tahtaysmestarit
10	349.6484090877656	2024-04-20 19:24:29.529	35	aamunkoiton_tahtays	tahtaysmestarit
10	311.63201534897064	2024-04-20 19:24:29.533	35	nordic_sharpshooters_cup	tahtaysmestarit
10	327.3542010365992	2024-04-20 19:24:29.537	35	taivaanranta-tulitus	tahtaysmestarit
10	321.2322778289417	2024-04-20 19:24:29.542	35	lumivyory-ammunta	tahtaysmestarit
10	343.5417703275475	2024-04-20 19:24:29.547	36	kesan_ampujaiset	tahtaysmestarit
10	309.6963451013536	2024-04-20 19:24:29.552	36	talvi_pistooli	tahtaysmestarit
10	374.2447432569761	2024-04-20 19:24:29.557	36	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	307.10010360241466	2024-04-20 19:24:29.562	36	kivaarikilpailujen_huipennus	tahtaysmestarit
10	341.96212222885913	2024-04-20 19:24:29.567	36	polaris-ampumaharjoitus	tahtaysmestarit
10	331.9166317143628	2024-04-20 19:24:29.572	36	aamunkoiton_tahtays	tahtaysmestarit
10	313.43418177561136	2024-04-20 19:24:29.577	36	nordic_sharpshooters_cup	tahtaysmestarit
10	316.5097018942128	2024-04-20 19:24:29.582	36	taivaanranta-tulitus	tahtaysmestarit
10	340.59438971669414	2024-04-20 19:24:29.587	36	lumivyory-ammunta	tahtaysmestarit
10	321.0282062385181	2024-04-20 19:24:29.592	37	kesan_ampujaiset	tahtaysmestarit
10	333.8116682128458	2024-04-20 19:24:29.598	37	talvi_pistooli	tahtaysmestarit
10	344.78435142647015	2024-04-20 19:24:29.603	37	tarkkuuslaukaus-festivaali	tahtaysmestarit
10	349.3535422996039	2024-04-20 19:24:29.609	37	kivaarikilpailujen_huipennus	tahtaysmestarit
10	318.3936968780255	2024-04-20 19:24:29.613	37	polaris-ampumaharjoitus	tahtaysmestarit
10	339.1875376640193	2024-04-20 19:24:29.618	37	aamunkoiton_tahtays	tahtaysmestarit
10	274.66955187033307	2024-04-20 19:24:29.623	37	nordic_sharpshooters_cup	tahtaysmestarit
10	307.6863913669289	2024-04-20 19:24:29.627	37	taivaanranta-tulitus	tahtaysmestarit
10	363.6879398592055	2024-04-20 19:24:29.633	37	lumivyory-ammunta	tahtaysmestarit
10	320.9941313881271	2024-04-20 19:24:29.638	38	kesan_ampujaiset	laukausryhma_aurora
10	354.2355239536102	2024-04-20 19:24:29.642	38	talvi_pistooli	laukausryhma_aurora
10	388.0283428316962	2024-04-20 19:24:29.647	38	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	344.16456508779163	2024-04-20 19:24:29.652	38	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	370.4172380278628	2024-04-20 19:24:29.657	38	polaris-ampumaharjoitus	laukausryhma_aurora
10	338.0190377870792	2024-04-20 19:24:29.661	38	aamunkoiton_tahtays	laukausryhma_aurora
10	297.37602786625445	2024-04-20 19:24:29.666	38	nordic_sharpshooters_cup	laukausryhma_aurora
10	311.55901086844517	2024-04-20 19:24:29.67	38	taivaanranta-tulitus	laukausryhma_aurora
10	327.95922319712093	2024-04-20 19:24:29.675	38	lumivyory-ammunta	laukausryhma_aurora
10	388.76665568781925	2024-04-20 19:24:29.68	39	kesan_ampujaiset	laukausryhma_aurora
10	341.5791025515528	2024-04-20 19:24:29.684	39	talvi_pistooli	laukausryhma_aurora
10	334.860566291424	2024-04-20 19:24:29.689	39	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	356.31792573597323	2024-04-20 19:24:29.694	39	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	314.2819242995935	2024-04-20 19:24:29.699	39	polaris-ampumaharjoitus	laukausryhma_aurora
10	303.9362675310663	2024-04-20 19:24:29.704	39	aamunkoiton_tahtays	laukausryhma_aurora
10	301.73979675373744	2024-04-20 19:24:29.709	39	nordic_sharpshooters_cup	laukausryhma_aurora
10	344.5191978224516	2024-04-20 19:24:29.713	39	taivaanranta-tulitus	laukausryhma_aurora
10	301.55681981165907	2024-04-20 19:24:29.718	39	lumivyory-ammunta	laukausryhma_aurora
10	322.30690777430027	2024-04-20 19:24:29.722	40	kesan_ampujaiset	laukausryhma_aurora
10	315.52869124720496	2024-04-20 19:24:29.727	40	talvi_pistooli	laukausryhma_aurora
10	338.0439247511266	2024-04-20 19:24:29.732	40	tarkkuuslaukaus-festivaali	laukausryhma_aurora
10	302.40932234150864	2024-04-20 19:24:29.736	40	kivaarikilpailujen_huipennus	laukausryhma_aurora
10	342.0356688566405	2024-04-20 19:24:29.741	40	polaris-ampumaharjoitus	laukausryhma_aurora
10	289.0803418814161	2024-04-20 19:24:29.745	40	aamunkoiton_tahtays	laukausryhma_aurora
10	317.61701598790364	2024-04-20 19:24:29.75	40	nordic_sharpshooters_cup	laukausryhma_aurora
10	322.24080485054765	2024-04-20 19:24:29.754	40	taivaanranta-tulitus	laukausryhma_aurora
10	315.055064982323	2024-04-20 19:24:29.758	40	lumivyory-ammunta	laukausryhma_aurora
10	320.21086105223003	2024-04-20 19:24:29.763	41	kesan_ampujaiset	ampumataito
10	346.88467154824286	2024-04-20 19:24:29.768	41	talvi_pistooli	ampumataito
10	346.3314639190947	2024-04-20 19:24:29.773	41	tarkkuuslaukaus-festivaali	ampumataito
10	356.9818743495862	2024-04-20 19:24:29.778	41	kivaarikilpailujen_huipennus	ampumataito
10	311.9464793737423	2024-04-20 19:24:29.783	41	polaris-ampumaharjoitus	ampumataito
10	341.00859135302414	2024-04-20 19:24:29.788	41	aamunkoiton_tahtays	ampumataito
10	318.9416707168685	2024-04-20 19:24:29.793	41	nordic_sharpshooters_cup	ampumataito
10	315.8359787134589	2024-04-20 19:24:29.799	41	taivaanranta-tulitus	ampumataito
10	347.63990386548807	2024-04-20 19:24:29.805	41	lumivyory-ammunta	ampumataito
10	340.7018645117531	2024-04-20 19:24:29.81	42	kesan_ampujaiset	ampumataito
10	323.2289713743412	2024-04-20 19:24:29.814	42	talvi_pistooli	ampumataito
10	322.056319664608	2024-04-20 19:24:29.82	42	tarkkuuslaukaus-festivaali	ampumataito
10	374.5145781273659	2024-04-20 19:24:29.824	42	kivaarikilpailujen_huipennus	ampumataito
10	312.6925305292618	2024-04-20 19:24:29.83	42	polaris-ampumaharjoitus	ampumataito
10	363.74303954444053	2024-04-20 19:24:29.834	42	aamunkoiton_tahtays	ampumataito
10	286.9672020059896	2024-04-20 19:24:29.839	42	nordic_sharpshooters_cup	ampumataito
10	338.4050939778118	2024-04-20 19:24:29.844	42	taivaanranta-tulitus	ampumataito
10	341.2242725039228	2024-04-20 19:24:29.85	42	lumivyory-ammunta	ampumataito
10	302.6136563242448	2024-04-20 19:24:29.854	43	kesan_ampujaiset	ampumataito
10	320.3723058971782	2024-04-20 19:24:29.86	43	talvi_pistooli	ampumataito
10	323.19657972659707	2024-04-20 19:24:29.865	43	tarkkuuslaukaus-festivaali	ampumataito
10	310.98219171095906	2024-04-20 19:24:29.871	43	kivaarikilpailujen_huipennus	ampumataito
10	309.32760069326474	2024-04-20 19:24:29.875	43	polaris-ampumaharjoitus	ampumataito
10	317.9119986877269	2024-04-20 19:24:29.88	43	aamunkoiton_tahtays	ampumataito
10	340.824873467439	2024-04-20 19:24:29.893	43	nordic_sharpshooters_cup	ampumataito
10	325.36970712141635	2024-04-20 19:24:29.9	43	taivaanranta-tulitus	ampumataito
10	334.7659615840639	2024-04-20 19:24:29.907	43	lumivyory-ammunta	ampumataito
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_ (creation_date, id, last_login, email, legal_name, part_of_club, password, username) FROM stdin;
2024-04-20 19:24:24.626	1	\N	adminin sähköposti	adminin nimi	\N	$2a$10$qwD6DdPGM.UWw7Z101z88.AQvU01GDp8FnbVgmvCOMTW8Dytd1wCC	admin
2024-04-20 19:24:24.877	2	\N	\N	Anna Komulainen	poliisiseura	\N	ahQqxEVXqt
2024-04-20 19:24:24.877	3	\N	\N	Helena Kelanti	poliisiseura	\N	6YS7IaIEJ6
2024-04-20 19:24:24.877	4	\N	\N	Tapani Kumpulainen	poliisiseura	\N	ELWK37IysO
2024-04-20 19:24:24.88	5	\N	\N	Ilmari Ollakka	koiraseura	\N	EdBg4UQSNN
2024-04-20 19:24:24.88	6	\N	\N	Olavi Hämäläinen	koiraseura	\N	MqYe0HMSUV
2024-04-20 19:24:24.88	7	\N	\N	Tapio Kumpulainen	koiraseura	\N	Dfpu4vsUwi
2024-04-20 19:24:24.882	8	\N	\N	Marjatta Holappa	hammaspeikkoseura	\N	HMDsA4I3qv
2024-04-20 19:24:24.882	9	\N	\N	Anneli Korhonen	hammaspeikkoseura	\N	H6GegrQSyl
2024-04-20 19:24:24.882	10	\N	\N	Anna Virtanen	hammaspeikkoseura	\N	OHlzN3JpJP
2024-04-20 19:24:24.885	11	\N	\N	Liisa Nieminen	dog	\N	fgYdxdp3gX
2024-04-20 19:24:24.885	12	\N	\N	Liisa Lehtinen	dog	\N	w1wx6PdXUa
2024-04-20 19:24:24.885	13	\N	\N	Juhani Mäkinen	dog	\N	Zp19eXOk8U
2024-04-20 19:24:24.887	14	\N	\N	Helena Mäkinen	savu_seura	\N	06T84OlFYd
2024-04-20 19:24:24.887	15	\N	\N	Matti Heikkinen	savu_seura	\N	o3TLIZIwfQ
2024-04-20 19:24:24.887	16	\N	\N	Helena Korhonen	savu_seura	\N	PnLZbkWr9w
2024-04-20 19:24:24.887	17	\N	\N	Matti Holappa	savu_seura	\N	rLZeNBXEJB
2024-04-20 19:24:24.887	18	\N	\N	Juhani Komulainen	savu_seura	\N	A3DItBee5g
2024-04-20 19:24:24.89	19	\N	\N	Olavi Korhonen	omas	\N	7wO9mK3yI2
2024-04-20 19:24:24.89	20	\N	\N	Maria Lehtinen	omas	\N	HeOmV7zdan
2024-04-20 19:24:24.89	21	\N	\N	Olavi Mäkinen	omas	\N	UdPqJxxgpw
2024-04-20 19:24:24.89	22	\N	\N	Marjatta Lehtinen	omas	\N	uhHSzhRhAo
2024-04-20 19:24:24.893	23	\N	\N	Anna Laine	pelleseura	\N	yWSwcU2VN9
2024-04-20 19:24:24.893	24	\N	\N	Johannes Holappa	pelleseura	\N	bUgxjwxeuy
2024-04-20 19:24:24.893	25	\N	\N	Marjatta Laine	pelleseura	\N	wHlHKFi9b9
2024-04-20 19:24:24.893	26	\N	\N	Anna Korhonen	pelleseura	\N	3WmWwZsS5q
2024-04-20 19:24:24.895	27	\N	\N	Mikael Nieminen	yung_tallent	\N	HpICvWhB1n
2024-04-20 19:24:24.895	28	\N	\N	Juhani Nieminen	yung_tallent	\N	kzxPMaeoH0
2024-04-20 19:24:24.895	29	\N	\N	Mikael Kumpulainen	yung_tallent	\N	unC7aGD9bF
2024-04-20 19:24:24.898	30	\N	\N	Tapio Koskinen	aseharrastajien_yhtenaisyys	\N	AiyvpOAmnx
2024-04-20 19:24:24.898	31	\N	\N	Kaarina Ollakka	aseharrastajien_yhtenaisyys	\N	vl3VujEz1K
2024-04-20 19:24:24.898	32	\N	\N	Helena Ollakka	aseharrastajien_yhtenaisyys	\N	CKUPwuepYj
2024-04-20 19:24:24.9	33	\N	\N	Kaarina Määttä	tahtaysmestarit	\N	gBWb8bF1EL
2024-04-20 19:24:24.9	34	\N	\N	Johannes Kumpulainen	tahtaysmestarit	\N	KJ9nCg8lmZ
2024-04-20 19:24:24.9	35	\N	\N	Anna Juustila	tahtaysmestarit	\N	u2AXGfm31R
2024-04-20 19:24:24.9	36	\N	\N	Kaarina Järvinen	tahtaysmestarit	\N	t4atHtKbUv
2024-04-20 19:24:24.901	37	\N	\N	Helena Ollakka	tahtaysmestarit	\N	6HP431raLH
2024-04-20 19:24:24.903	38	\N	\N	Johanna Laine	laukausryhma_aurora	\N	ahsinMhEhB
2024-04-20 19:24:24.903	39	\N	\N	Anneli Laine	laukausryhma_aurora	\N	De3GNs0UJ5
2024-04-20 19:24:24.903	40	\N	\N	Antero Määttä	laukausryhma_aurora	\N	7iU0iO9Oe6
2024-04-20 19:24:24.905	41	\N	\N	Mikael Ollakka	ampumataito	\N	TWMt2LlWhg
2024-04-20 19:24:24.905	42	\N	\N	Helena Määttä	ampumataito	\N	C4Lcqjw3A2
2024-04-20 19:24:24.905	43	\N	\N	Ilmari Virtanen	ampumataito	\N	Jl2mF5TnZp
\.


--
-- Name: user__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user__id_seq', 43, true);


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

