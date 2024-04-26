--
-- PostgreSQL database dump
-- 26.v2

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
    round integer NOT NULL,
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
2024-04-26 13:36:58.009	0	poliisiseura	Poliisiseura	\N
2024-04-26 13:36:58.018	0	koiraseura	Koiraseura	\N
2024-04-26 13:36:58.024	0	hammaspeikkoseura	Hammaspeikkoseura	\N
2024-04-26 13:36:58.03	0	dog	dog	\N
2024-04-26 13:36:58.035	0	savu_seura	Savu Seura	\N
2024-04-26 13:36:58.042	0	omas	OMAS	\N
2024-04-26 13:36:58.048	0	pelleseura	Pelleseura	\N
2024-04-26 13:36:58.055	0	yung_tallent	Yung Tallent	\N
2024-04-26 13:36:58.06	0	aseharrastajien_yhtenaisyys	Aseharrastajien Yhtenäisyys	\N
2024-04-26 13:36:58.066	0	tahtaysmestarit	Tähtäysmestarit	\N
2024-04-26 13:36:58.071	0	laukausryhma_aurora	Laukausryhmä Aurora	\N
2024-04-26 13:36:58.078	0	ampumataito	Ampumataito	\N
\.


--
-- Data for Name: competition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition (creation_date, end_date, start_date, competition_id, display_name, type) FROM stdin;
2024-04-26 13:36:58.086	2024-06-01 13:36:58.086	2024-04-15 13:36:58.086	kesan_ampujaiset	Kesän Ampujaiset	rifle
2024-04-26 13:36:58.086	2024-06-19 13:36:58.086	2024-05-24 13:36:58.086	talvi_pistooli	Talvi Pistooli	rifle
2024-04-26 13:36:58.087	2024-04-30 13:36:58.087	2024-03-11 12:36:58.087	tarkkuuslaukaus-festivaali	Tarkkuuslaukaus-festivaali	rifle
2024-04-26 13:36:58.087	2024-04-14 13:36:58.087	2024-04-02 13:36:58.087	kivaarikilpailujen_huipennus	Kiväärikilpailujen huipennus	rifle
2024-04-26 13:36:58.087	2025-05-27 13:36:58.087	2024-11-28 12:36:58.087	polaris-ampumaharjoitus	Polaris-ampumaharjoitus	rifle
2024-04-26 13:36:58.087	2027-05-21 13:36:58.087	2025-08-23 13:36:58.087	aamunkoiton_tahtays	Aamunkoiton tähtäys	rifle
2024-04-26 13:36:58.088	2025-12-10 12:36:58.088	2025-02-08 12:36:58.088	nordic_sharpshooters_cup	Nordic Sharpshooters Cup	rifle
2024-04-26 13:36:58.088	2025-06-10 13:36:58.088	2025-04-29 13:36:58.088	taivaanranta-tulitus	Taivaanranta-tulitus	rifle
2024-04-26 13:36:58.088	2025-12-05 12:36:58.088	2024-12-30 12:36:58.088	lumivyory-ammunta	Lumivyöry-ammunta	rifle
2024-04-26 13:36:58.123	2024-02-17 12:36:58.123	2022-08-26 13:36:58.123	tarkka-ammunta_cup	Tarkka-ammunta Cup	pistol
2024-04-26 13:36:58.123	2024-03-20 12:36:58.123	2024-03-09 12:36:58.123	nopean_laukauksen_mestaruus	Nopean laukauksen mestaruus	pistol
2024-04-26 13:36:58.123	2024-04-20 13:36:58.123	2024-02-27 12:36:58.123	moniottelu	Moniottelu	pistol
2024-04-26 13:36:58.124	2027-02-05 12:36:58.124	2025-07-09 13:36:58.124	kansallinen_tahtayskilpailu	Kansallinen tähtäyskilpailu	pistol
2024-04-26 13:36:58.124	2024-05-15 13:36:58.124	2024-04-03 13:36:58.124	kaupunkiammunta-challenge	Kaupunkiammunta-challenge	pistol
2024-04-26 13:36:58.124	2024-07-25 13:36:58.124	2023-10-21 13:36:58.124	laukausmaraton	Laukausmaraton	pistol
2024-04-26 13:36:58.124	2023-08-14 13:36:58.124	2023-08-01 13:36:58.124	vapaa-asekilpailu	Vapaa-asekilpailu	pistol
2024-04-26 13:36:58.125	2027-07-10 13:36:58.125	2025-09-25 13:36:58.125	taitoluodikko-turnaus	Taitoluodikko-turnaus	pistol
2024-04-26 13:36:58.125	2026-07-14 13:36:58.125	2025-05-15 13:36:58.125	precision_pistol_cup	Precision Pistol Cup	pistol
2024-04-26 13:36:58.125	2024-07-19 13:36:58.125	2024-06-17 13:36:58.125	tulevaisuuden_ampuja	Tulevaisuuden Ampuja	pistol
2024-04-26 13:36:58.125	2024-05-19 13:36:58.125	2024-05-11 13:36:58.125	pikakivaari-klassikko	Pikakivääri-klassikko	pistol
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
poliisiseura	kesan_ampujaiset	Poliisiseura 1	poliisiseura_1
poliisiseura	kesan_ampujaiset	Poliisiseura 2	poliisiseura_2
poliisiseura	kesan_ampujaiset	Poliisiseura 3	poliisiseura_3
koiraseura	kesan_ampujaiset	Koiraseura 1	koiraseura_1
hammaspeikkoseura	kesan_ampujaiset	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	kesan_ampujaiset	Hammaspeikkoseura 2	hammaspeikkoseura_2
dog	kesan_ampujaiset	dog 1	dog_1
savu_seura	kesan_ampujaiset	Savu Seura 1	savu_seura_1
savu_seura	kesan_ampujaiset	Savu Seura 2	savu_seura_2
savu_seura	kesan_ampujaiset	Savu Seura 3	savu_seura_3
omas	kesan_ampujaiset	OMAS 1	omas_1
pelleseura	kesan_ampujaiset	Pelleseura 1	pelleseura_1
yung_tallent	kesan_ampujaiset	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	kesan_ampujaiset	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	kesan_ampujaiset	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	kesan_ampujaiset	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	kesan_ampujaiset	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	kesan_ampujaiset	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	kesan_ampujaiset	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	kesan_ampujaiset	Laukausryhmä Aurora 1	laukausryhma_aurora_1
ampumataito	kesan_ampujaiset	Ampumataito 1	ampumataito_1
ampumataito	kesan_ampujaiset	Ampumataito 2	ampumataito_2
ampumataito	kesan_ampujaiset	Ampumataito 3	ampumataito_3
poliisiseura	talvi_pistooli	Poliisiseura 1	poliisiseura_1
poliisiseura	talvi_pistooli	Poliisiseura 2	poliisiseura_2
koiraseura	talvi_pistooli	Koiraseura 1	koiraseura_1
hammaspeikkoseura	talvi_pistooli	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	talvi_pistooli	Hammaspeikkoseura 2	hammaspeikkoseura_2
dog	talvi_pistooli	dog 1	dog_1
dog	talvi_pistooli	dog 2	dog_2
savu_seura	talvi_pistooli	Savu Seura 1	savu_seura_1
savu_seura	talvi_pistooli	Savu Seura 2	savu_seura_2
omas	talvi_pistooli	OMAS 1	omas_1
omas	talvi_pistooli	OMAS 2	omas_2
omas	talvi_pistooli	OMAS 3	omas_3
pelleseura	talvi_pistooli	Pelleseura 1	pelleseura_1
pelleseura	talvi_pistooli	Pelleseura 2	pelleseura_2
pelleseura	talvi_pistooli	Pelleseura 3	pelleseura_3
yung_tallent	talvi_pistooli	Yung Tallent 1	yung_tallent_1
yung_tallent	talvi_pistooli	Yung Tallent 2	yung_tallent_2
yung_tallent	talvi_pistooli	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	talvi_pistooli	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
tahtaysmestarit	talvi_pistooli	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	talvi_pistooli	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	talvi_pistooli	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	talvi_pistooli	Laukausryhmä Aurora 1	laukausryhma_aurora_1
ampumataito	talvi_pistooli	Ampumataito 1	ampumataito_1
ampumataito	talvi_pistooli	Ampumataito 2	ampumataito_2
poliisiseura	tarkkuuslaukaus-festivaali	Poliisiseura 1	poliisiseura_1
poliisiseura	tarkkuuslaukaus-festivaali	Poliisiseura 2	poliisiseura_2
poliisiseura	tarkkuuslaukaus-festivaali	Poliisiseura 3	poliisiseura_3
koiraseura	tarkkuuslaukaus-festivaali	Koiraseura 1	koiraseura_1
hammaspeikkoseura	tarkkuuslaukaus-festivaali	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	tarkkuuslaukaus-festivaali	dog 1	dog_1
savu_seura	tarkkuuslaukaus-festivaali	Savu Seura 1	savu_seura_1
omas	tarkkuuslaukaus-festivaali	OMAS 1	omas_1
omas	tarkkuuslaukaus-festivaali	OMAS 2	omas_2
omas	tarkkuuslaukaus-festivaali	OMAS 3	omas_3
pelleseura	tarkkuuslaukaus-festivaali	Pelleseura 1	pelleseura_1
pelleseura	tarkkuuslaukaus-festivaali	Pelleseura 2	pelleseura_2
pelleseura	tarkkuuslaukaus-festivaali	Pelleseura 3	pelleseura_3
yung_tallent	tarkkuuslaukaus-festivaali	Yung Tallent 1	yung_tallent_1
yung_tallent	tarkkuuslaukaus-festivaali	Yung Tallent 2	yung_tallent_2
yung_tallent	tarkkuuslaukaus-festivaali	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	tarkkuuslaukaus-festivaali	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	tarkkuuslaukaus-festivaali	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	tarkkuuslaukaus-festivaali	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	tarkkuuslaukaus-festivaali	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	tarkkuuslaukaus-festivaali	Tähtäysmestarit 2	tahtaysmestarit_2
laukausryhma_aurora	tarkkuuslaukaus-festivaali	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	tarkkuuslaukaus-festivaali	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	tarkkuuslaukaus-festivaali	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	tarkkuuslaukaus-festivaali	Ampumataito 1	ampumataito_1
ampumataito	tarkkuuslaukaus-festivaali	Ampumataito 2	ampumataito_2
ampumataito	tarkkuuslaukaus-festivaali	Ampumataito 3	ampumataito_3
poliisiseura	kivaarikilpailujen_huipennus	Poliisiseura 1	poliisiseura_1
poliisiseura	kivaarikilpailujen_huipennus	Poliisiseura 2	poliisiseura_2
poliisiseura	kivaarikilpailujen_huipennus	Poliisiseura 3	poliisiseura_3
koiraseura	kivaarikilpailujen_huipennus	Koiraseura 1	koiraseura_1
koiraseura	kivaarikilpailujen_huipennus	Koiraseura 2	koiraseura_2
koiraseura	kivaarikilpailujen_huipennus	Koiraseura 3	koiraseura_3
hammaspeikkoseura	kivaarikilpailujen_huipennus	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	kivaarikilpailujen_huipennus	dog 1	dog_1
dog	kivaarikilpailujen_huipennus	dog 2	dog_2
dog	kivaarikilpailujen_huipennus	dog 3	dog_3
savu_seura	kivaarikilpailujen_huipennus	Savu Seura 1	savu_seura_1
savu_seura	kivaarikilpailujen_huipennus	Savu Seura 2	savu_seura_2
omas	kivaarikilpailujen_huipennus	OMAS 1	omas_1
omas	kivaarikilpailujen_huipennus	OMAS 2	omas_2
pelleseura	kivaarikilpailujen_huipennus	Pelleseura 1	pelleseura_1
pelleseura	kivaarikilpailujen_huipennus	Pelleseura 2	pelleseura_2
pelleseura	kivaarikilpailujen_huipennus	Pelleseura 3	pelleseura_3
yung_tallent	kivaarikilpailujen_huipennus	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	kivaarikilpailujen_huipennus	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	kivaarikilpailujen_huipennus	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
tahtaysmestarit	kivaarikilpailujen_huipennus	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	kivaarikilpailujen_huipennus	Tähtäysmestarit 2	tahtaysmestarit_2
laukausryhma_aurora	kivaarikilpailujen_huipennus	Laukausryhmä Aurora 1	laukausryhma_aurora_1
ampumataito	kivaarikilpailujen_huipennus	Ampumataito 1	ampumataito_1
ampumataito	kivaarikilpailujen_huipennus	Ampumataito 2	ampumataito_2
ampumataito	kivaarikilpailujen_huipennus	Ampumataito 3	ampumataito_3
poliisiseura	polaris-ampumaharjoitus	Poliisiseura 1	poliisiseura_1
koiraseura	polaris-ampumaharjoitus	Koiraseura 1	koiraseura_1
koiraseura	polaris-ampumaharjoitus	Koiraseura 2	koiraseura_2
hammaspeikkoseura	polaris-ampumaharjoitus	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	polaris-ampumaharjoitus	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	polaris-ampumaharjoitus	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	polaris-ampumaharjoitus	dog 1	dog_1
dog	polaris-ampumaharjoitus	dog 2	dog_2
dog	polaris-ampumaharjoitus	dog 3	dog_3
savu_seura	polaris-ampumaharjoitus	Savu Seura 1	savu_seura_1
savu_seura	polaris-ampumaharjoitus	Savu Seura 2	savu_seura_2
savu_seura	polaris-ampumaharjoitus	Savu Seura 3	savu_seura_3
omas	polaris-ampumaharjoitus	OMAS 1	omas_1
omas	polaris-ampumaharjoitus	OMAS 2	omas_2
omas	polaris-ampumaharjoitus	OMAS 3	omas_3
pelleseura	polaris-ampumaharjoitus	Pelleseura 1	pelleseura_1
pelleseura	polaris-ampumaharjoitus	Pelleseura 2	pelleseura_2
pelleseura	polaris-ampumaharjoitus	Pelleseura 3	pelleseura_3
yung_tallent	polaris-ampumaharjoitus	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	polaris-ampumaharjoitus	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	polaris-ampumaharjoitus	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
tahtaysmestarit	polaris-ampumaharjoitus	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	polaris-ampumaharjoitus	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	polaris-ampumaharjoitus	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	polaris-ampumaharjoitus	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	polaris-ampumaharjoitus	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	polaris-ampumaharjoitus	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	polaris-ampumaharjoitus	Ampumataito 1	ampumataito_1
poliisiseura	aamunkoiton_tahtays	Poliisiseura 1	poliisiseura_1
poliisiseura	aamunkoiton_tahtays	Poliisiseura 2	poliisiseura_2
koiraseura	aamunkoiton_tahtays	Koiraseura 1	koiraseura_1
koiraseura	aamunkoiton_tahtays	Koiraseura 2	koiraseura_2
hammaspeikkoseura	aamunkoiton_tahtays	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	aamunkoiton_tahtays	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	aamunkoiton_tahtays	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	aamunkoiton_tahtays	dog 1	dog_1
savu_seura	aamunkoiton_tahtays	Savu Seura 1	savu_seura_1
savu_seura	aamunkoiton_tahtays	Savu Seura 2	savu_seura_2
savu_seura	aamunkoiton_tahtays	Savu Seura 3	savu_seura_3
omas	aamunkoiton_tahtays	OMAS 1	omas_1
omas	aamunkoiton_tahtays	OMAS 2	omas_2
pelleseura	aamunkoiton_tahtays	Pelleseura 1	pelleseura_1
pelleseura	aamunkoiton_tahtays	Pelleseura 2	pelleseura_2
yung_tallent	aamunkoiton_tahtays	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	aamunkoiton_tahtays	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	aamunkoiton_tahtays	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	aamunkoiton_tahtays	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	aamunkoiton_tahtays	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	aamunkoiton_tahtays	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	aamunkoiton_tahtays	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	aamunkoiton_tahtays	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	aamunkoiton_tahtays	Ampumataito 1	ampumataito_1
ampumataito	aamunkoiton_tahtays	Ampumataito 2	ampumataito_2
poliisiseura	nordic_sharpshooters_cup	Poliisiseura 1	poliisiseura_1
koiraseura	nordic_sharpshooters_cup	Koiraseura 1	koiraseura_1
koiraseura	nordic_sharpshooters_cup	Koiraseura 2	koiraseura_2
hammaspeikkoseura	nordic_sharpshooters_cup	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	nordic_sharpshooters_cup	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	nordic_sharpshooters_cup	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	nordic_sharpshooters_cup	dog 1	dog_1
dog	nordic_sharpshooters_cup	dog 2	dog_2
savu_seura	nordic_sharpshooters_cup	Savu Seura 1	savu_seura_1
omas	nordic_sharpshooters_cup	OMAS 1	omas_1
pelleseura	nordic_sharpshooters_cup	Pelleseura 1	pelleseura_1
pelleseura	nordic_sharpshooters_cup	Pelleseura 2	pelleseura_2
yung_tallent	nordic_sharpshooters_cup	Yung Tallent 1	yung_tallent_1
yung_tallent	nordic_sharpshooters_cup	Yung Tallent 2	yung_tallent_2
yung_tallent	nordic_sharpshooters_cup	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	nordic_sharpshooters_cup	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
tahtaysmestarit	nordic_sharpshooters_cup	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	nordic_sharpshooters_cup	Tähtäysmestarit 2	tahtaysmestarit_2
laukausryhma_aurora	nordic_sharpshooters_cup	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	nordic_sharpshooters_cup	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	nordic_sharpshooters_cup	Ampumataito 1	ampumataito_1
ampumataito	nordic_sharpshooters_cup	Ampumataito 2	ampumataito_2
ampumataito	nordic_sharpshooters_cup	Ampumataito 3	ampumataito_3
poliisiseura	taivaanranta-tulitus	Poliisiseura 1	poliisiseura_1
poliisiseura	taivaanranta-tulitus	Poliisiseura 2	poliisiseura_2
koiraseura	taivaanranta-tulitus	Koiraseura 1	koiraseura_1
koiraseura	taivaanranta-tulitus	Koiraseura 2	koiraseura_2
koiraseura	taivaanranta-tulitus	Koiraseura 3	koiraseura_3
hammaspeikkoseura	taivaanranta-tulitus	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	taivaanranta-tulitus	dog 1	dog_1
dog	taivaanranta-tulitus	dog 2	dog_2
savu_seura	taivaanranta-tulitus	Savu Seura 1	savu_seura_1
savu_seura	taivaanranta-tulitus	Savu Seura 2	savu_seura_2
savu_seura	taivaanranta-tulitus	Savu Seura 3	savu_seura_3
omas	taivaanranta-tulitus	OMAS 1	omas_1
pelleseura	taivaanranta-tulitus	Pelleseura 1	pelleseura_1
pelleseura	taivaanranta-tulitus	Pelleseura 2	pelleseura_2
yung_tallent	taivaanranta-tulitus	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	taivaanranta-tulitus	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	taivaanranta-tulitus	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
tahtaysmestarit	taivaanranta-tulitus	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	taivaanranta-tulitus	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	taivaanranta-tulitus	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	taivaanranta-tulitus	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	taivaanranta-tulitus	Ampumataito 1	ampumataito_1
poliisiseura	lumivyory-ammunta	Poliisiseura 1	poliisiseura_1
koiraseura	lumivyory-ammunta	Koiraseura 1	koiraseura_1
koiraseura	lumivyory-ammunta	Koiraseura 2	koiraseura_2
koiraseura	lumivyory-ammunta	Koiraseura 3	koiraseura_3
hammaspeikkoseura	lumivyory-ammunta	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	lumivyory-ammunta	Hammaspeikkoseura 2	hammaspeikkoseura_2
dog	lumivyory-ammunta	dog 1	dog_1
dog	lumivyory-ammunta	dog 2	dog_2
dog	lumivyory-ammunta	dog 3	dog_3
savu_seura	lumivyory-ammunta	Savu Seura 1	savu_seura_1
omas	lumivyory-ammunta	OMAS 1	omas_1
omas	lumivyory-ammunta	OMAS 2	omas_2
omas	lumivyory-ammunta	OMAS 3	omas_3
pelleseura	lumivyory-ammunta	Pelleseura 1	pelleseura_1
pelleseura	lumivyory-ammunta	Pelleseura 2	pelleseura_2
yung_tallent	lumivyory-ammunta	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	lumivyory-ammunta	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
tahtaysmestarit	lumivyory-ammunta	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	lumivyory-ammunta	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	lumivyory-ammunta	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	lumivyory-ammunta	Laukausryhmä Aurora 1	laukausryhma_aurora_1
ampumataito	lumivyory-ammunta	Ampumataito 1	ampumataito_1
ampumataito	lumivyory-ammunta	Ampumataito 2	ampumataito_2
poliisiseura	tarkka-ammunta_cup	Poliisiseura 1	poliisiseura_1
poliisiseura	tarkka-ammunta_cup	Poliisiseura 2	poliisiseura_2
koiraseura	tarkka-ammunta_cup	Koiraseura 1	koiraseura_1
koiraseura	tarkka-ammunta_cup	Koiraseura 2	koiraseura_2
koiraseura	tarkka-ammunta_cup	Koiraseura 3	koiraseura_3
hammaspeikkoseura	tarkka-ammunta_cup	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	tarkka-ammunta_cup	dog 1	dog_1
dog	tarkka-ammunta_cup	dog 2	dog_2
savu_seura	tarkka-ammunta_cup	Savu Seura 1	savu_seura_1
savu_seura	tarkka-ammunta_cup	Savu Seura 2	savu_seura_2
omas	tarkka-ammunta_cup	OMAS 1	omas_1
omas	tarkka-ammunta_cup	OMAS 2	omas_2
pelleseura	tarkka-ammunta_cup	Pelleseura 1	pelleseura_1
pelleseura	tarkka-ammunta_cup	Pelleseura 2	pelleseura_2
yung_tallent	tarkka-ammunta_cup	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	tarkka-ammunta_cup	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	tarkka-ammunta_cup	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	tarkka-ammunta_cup	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	tarkka-ammunta_cup	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	tarkka-ammunta_cup	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	tarkka-ammunta_cup	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	tarkka-ammunta_cup	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	tarkka-ammunta_cup	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	tarkka-ammunta_cup	Ampumataito 1	ampumataito_1
poliisiseura	nopean_laukauksen_mestaruus	Poliisiseura 1	poliisiseura_1
poliisiseura	nopean_laukauksen_mestaruus	Poliisiseura 2	poliisiseura_2
koiraseura	nopean_laukauksen_mestaruus	Koiraseura 1	koiraseura_1
koiraseura	nopean_laukauksen_mestaruus	Koiraseura 2	koiraseura_2
hammaspeikkoseura	nopean_laukauksen_mestaruus	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	nopean_laukauksen_mestaruus	Hammaspeikkoseura 2	hammaspeikkoseura_2
dog	nopean_laukauksen_mestaruus	dog 1	dog_1
dog	nopean_laukauksen_mestaruus	dog 2	dog_2
dog	nopean_laukauksen_mestaruus	dog 3	dog_3
savu_seura	nopean_laukauksen_mestaruus	Savu Seura 1	savu_seura_1
savu_seura	nopean_laukauksen_mestaruus	Savu Seura 2	savu_seura_2
omas	nopean_laukauksen_mestaruus	OMAS 1	omas_1
pelleseura	nopean_laukauksen_mestaruus	Pelleseura 1	pelleseura_1
pelleseura	nopean_laukauksen_mestaruus	Pelleseura 2	pelleseura_2
pelleseura	nopean_laukauksen_mestaruus	Pelleseura 3	pelleseura_3
yung_tallent	nopean_laukauksen_mestaruus	Yung Tallent 1	yung_tallent_1
aseharrastajien_yhtenaisyys	nopean_laukauksen_mestaruus	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	nopean_laukauksen_mestaruus	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
tahtaysmestarit	nopean_laukauksen_mestaruus	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	nopean_laukauksen_mestaruus	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	nopean_laukauksen_mestaruus	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	nopean_laukauksen_mestaruus	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	nopean_laukauksen_mestaruus	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	nopean_laukauksen_mestaruus	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	nopean_laukauksen_mestaruus	Ampumataito 1	ampumataito_1
ampumataito	nopean_laukauksen_mestaruus	Ampumataito 2	ampumataito_2
poliisiseura	moniottelu	Poliisiseura 1	poliisiseura_1
poliisiseura	moniottelu	Poliisiseura 2	poliisiseura_2
poliisiseura	moniottelu	Poliisiseura 3	poliisiseura_3
koiraseura	moniottelu	Koiraseura 1	koiraseura_1
koiraseura	moniottelu	Koiraseura 2	koiraseura_2
koiraseura	moniottelu	Koiraseura 3	koiraseura_3
hammaspeikkoseura	moniottelu	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	moniottelu	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	moniottelu	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	moniottelu	dog 1	dog_1
dog	moniottelu	dog 2	dog_2
savu_seura	moniottelu	Savu Seura 1	savu_seura_1
savu_seura	moniottelu	Savu Seura 2	savu_seura_2
savu_seura	moniottelu	Savu Seura 3	savu_seura_3
omas	moniottelu	OMAS 1	omas_1
pelleseura	moniottelu	Pelleseura 1	pelleseura_1
yung_tallent	moniottelu	Yung Tallent 1	yung_tallent_1
yung_tallent	moniottelu	Yung Tallent 2	yung_tallent_2
yung_tallent	moniottelu	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	moniottelu	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	moniottelu	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	moniottelu	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	moniottelu	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	moniottelu	Laukausryhmä Aurora 1	laukausryhma_aurora_1
ampumataito	moniottelu	Ampumataito 1	ampumataito_1
poliisiseura	kansallinen_tahtayskilpailu	Poliisiseura 1	poliisiseura_1
poliisiseura	kansallinen_tahtayskilpailu	Poliisiseura 2	poliisiseura_2
poliisiseura	kansallinen_tahtayskilpailu	Poliisiseura 3	poliisiseura_3
koiraseura	kansallinen_tahtayskilpailu	Koiraseura 1	koiraseura_1
koiraseura	kansallinen_tahtayskilpailu	Koiraseura 2	koiraseura_2
koiraseura	kansallinen_tahtayskilpailu	Koiraseura 3	koiraseura_3
hammaspeikkoseura	kansallinen_tahtayskilpailu	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	kansallinen_tahtayskilpailu	dog 1	dog_1
savu_seura	kansallinen_tahtayskilpailu	Savu Seura 1	savu_seura_1
savu_seura	kansallinen_tahtayskilpailu	Savu Seura 2	savu_seura_2
savu_seura	kansallinen_tahtayskilpailu	Savu Seura 3	savu_seura_3
omas	kansallinen_tahtayskilpailu	OMAS 1	omas_1
pelleseura	kansallinen_tahtayskilpailu	Pelleseura 1	pelleseura_1
pelleseura	kansallinen_tahtayskilpailu	Pelleseura 2	pelleseura_2
yung_tallent	kansallinen_tahtayskilpailu	Yung Tallent 1	yung_tallent_1
yung_tallent	kansallinen_tahtayskilpailu	Yung Tallent 2	yung_tallent_2
aseharrastajien_yhtenaisyys	kansallinen_tahtayskilpailu	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	kansallinen_tahtayskilpailu	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	kansallinen_tahtayskilpailu	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	kansallinen_tahtayskilpailu	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	kansallinen_tahtayskilpailu	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	kansallinen_tahtayskilpailu	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	kansallinen_tahtayskilpailu	Ampumataito 1	ampumataito_1
ampumataito	kansallinen_tahtayskilpailu	Ampumataito 2	ampumataito_2
ampumataito	kansallinen_tahtayskilpailu	Ampumataito 3	ampumataito_3
poliisiseura	kaupunkiammunta-challenge	Poliisiseura 1	poliisiseura_1
poliisiseura	kaupunkiammunta-challenge	Poliisiseura 2	poliisiseura_2
poliisiseura	kaupunkiammunta-challenge	Poliisiseura 3	poliisiseura_3
koiraseura	kaupunkiammunta-challenge	Koiraseura 1	koiraseura_1
koiraseura	kaupunkiammunta-challenge	Koiraseura 2	koiraseura_2
koiraseura	kaupunkiammunta-challenge	Koiraseura 3	koiraseura_3
hammaspeikkoseura	kaupunkiammunta-challenge	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	kaupunkiammunta-challenge	dog 1	dog_1
savu_seura	kaupunkiammunta-challenge	Savu Seura 1	savu_seura_1
omas	kaupunkiammunta-challenge	OMAS 1	omas_1
pelleseura	kaupunkiammunta-challenge	Pelleseura 1	pelleseura_1
yung_tallent	kaupunkiammunta-challenge	Yung Tallent 1	yung_tallent_1
yung_tallent	kaupunkiammunta-challenge	Yung Tallent 2	yung_tallent_2
aseharrastajien_yhtenaisyys	kaupunkiammunta-challenge	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
tahtaysmestarit	kaupunkiammunta-challenge	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	kaupunkiammunta-challenge	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	kaupunkiammunta-challenge	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	kaupunkiammunta-challenge	Ampumataito 1	ampumataito_1
ampumataito	kaupunkiammunta-challenge	Ampumataito 2	ampumataito_2
poliisiseura	laukausmaraton	Poliisiseura 1	poliisiseura_1
poliisiseura	laukausmaraton	Poliisiseura 2	poliisiseura_2
poliisiseura	laukausmaraton	Poliisiseura 3	poliisiseura_3
koiraseura	laukausmaraton	Koiraseura 1	koiraseura_1
koiraseura	laukausmaraton	Koiraseura 2	koiraseura_2
hammaspeikkoseura	laukausmaraton	Hammaspeikkoseura 1	hammaspeikkoseura_1
dog	laukausmaraton	dog 1	dog_1
dog	laukausmaraton	dog 2	dog_2
savu_seura	laukausmaraton	Savu Seura 1	savu_seura_1
savu_seura	laukausmaraton	Savu Seura 2	savu_seura_2
omas	laukausmaraton	OMAS 1	omas_1
omas	laukausmaraton	OMAS 2	omas_2
omas	laukausmaraton	OMAS 3	omas_3
pelleseura	laukausmaraton	Pelleseura 1	pelleseura_1
pelleseura	laukausmaraton	Pelleseura 2	pelleseura_2
yung_tallent	laukausmaraton	Yung Tallent 1	yung_tallent_1
yung_tallent	laukausmaraton	Yung Tallent 2	yung_tallent_2
yung_tallent	laukausmaraton	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	laukausmaraton	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
tahtaysmestarit	laukausmaraton	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	laukausmaraton	Tähtäysmestarit 2	tahtaysmestarit_2
laukausryhma_aurora	laukausmaraton	Laukausryhmä Aurora 1	laukausryhma_aurora_1
ampumataito	laukausmaraton	Ampumataito 1	ampumataito_1
ampumataito	laukausmaraton	Ampumataito 2	ampumataito_2
poliisiseura	vapaa-asekilpailu	Poliisiseura 1	poliisiseura_1
poliisiseura	vapaa-asekilpailu	Poliisiseura 2	poliisiseura_2
poliisiseura	vapaa-asekilpailu	Poliisiseura 3	poliisiseura_3
koiraseura	vapaa-asekilpailu	Koiraseura 1	koiraseura_1
koiraseura	vapaa-asekilpailu	Koiraseura 2	koiraseura_2
hammaspeikkoseura	vapaa-asekilpailu	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	vapaa-asekilpailu	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	vapaa-asekilpailu	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	vapaa-asekilpailu	dog 1	dog_1
dog	vapaa-asekilpailu	dog 2	dog_2
savu_seura	vapaa-asekilpailu	Savu Seura 1	savu_seura_1
omas	vapaa-asekilpailu	OMAS 1	omas_1
omas	vapaa-asekilpailu	OMAS 2	omas_2
omas	vapaa-asekilpailu	OMAS 3	omas_3
pelleseura	vapaa-asekilpailu	Pelleseura 1	pelleseura_1
yung_tallent	vapaa-asekilpailu	Yung Tallent 1	yung_tallent_1
yung_tallent	vapaa-asekilpailu	Yung Tallent 2	yung_tallent_2
aseharrastajien_yhtenaisyys	vapaa-asekilpailu	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	vapaa-asekilpailu	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	vapaa-asekilpailu	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	vapaa-asekilpailu	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	vapaa-asekilpailu	Tähtäysmestarit 2	tahtaysmestarit_2
laukausryhma_aurora	vapaa-asekilpailu	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	vapaa-asekilpailu	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	vapaa-asekilpailu	Ampumataito 1	ampumataito_1
ampumataito	vapaa-asekilpailu	Ampumataito 2	ampumataito_2
ampumataito	vapaa-asekilpailu	Ampumataito 3	ampumataito_3
poliisiseura	taitoluodikko-turnaus	Poliisiseura 1	poliisiseura_1
koiraseura	taitoluodikko-turnaus	Koiraseura 1	koiraseura_1
koiraseura	taitoluodikko-turnaus	Koiraseura 2	koiraseura_2
hammaspeikkoseura	taitoluodikko-turnaus	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	taitoluodikko-turnaus	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	taitoluodikko-turnaus	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	taitoluodikko-turnaus	dog 1	dog_1
dog	taitoluodikko-turnaus	dog 2	dog_2
dog	taitoluodikko-turnaus	dog 3	dog_3
savu_seura	taitoluodikko-turnaus	Savu Seura 1	savu_seura_1
savu_seura	taitoluodikko-turnaus	Savu Seura 2	savu_seura_2
omas	taitoluodikko-turnaus	OMAS 1	omas_1
omas	taitoluodikko-turnaus	OMAS 2	omas_2
pelleseura	taitoluodikko-turnaus	Pelleseura 1	pelleseura_1
pelleseura	taitoluodikko-turnaus	Pelleseura 2	pelleseura_2
pelleseura	taitoluodikko-turnaus	Pelleseura 3	pelleseura_3
yung_tallent	taitoluodikko-turnaus	Yung Tallent 1	yung_tallent_1
yung_tallent	taitoluodikko-turnaus	Yung Tallent 2	yung_tallent_2
aseharrastajien_yhtenaisyys	taitoluodikko-turnaus	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	taitoluodikko-turnaus	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
tahtaysmestarit	taitoluodikko-turnaus	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	taitoluodikko-turnaus	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	taitoluodikko-turnaus	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	taitoluodikko-turnaus	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	taitoluodikko-turnaus	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	taitoluodikko-turnaus	Ampumataito 1	ampumataito_1
ampumataito	taitoluodikko-turnaus	Ampumataito 2	ampumataito_2
poliisiseura	precision_pistol_cup	Poliisiseura 1	poliisiseura_1
poliisiseura	precision_pistol_cup	Poliisiseura 2	poliisiseura_2
koiraseura	precision_pistol_cup	Koiraseura 1	koiraseura_1
koiraseura	precision_pistol_cup	Koiraseura 2	koiraseura_2
hammaspeikkoseura	precision_pistol_cup	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	precision_pistol_cup	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	precision_pistol_cup	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	precision_pistol_cup	dog 1	dog_1
dog	precision_pistol_cup	dog 2	dog_2
savu_seura	precision_pistol_cup	Savu Seura 1	savu_seura_1
savu_seura	precision_pistol_cup	Savu Seura 2	savu_seura_2
savu_seura	precision_pistol_cup	Savu Seura 3	savu_seura_3
omas	precision_pistol_cup	OMAS 1	omas_1
pelleseura	precision_pistol_cup	Pelleseura 1	pelleseura_1
pelleseura	precision_pistol_cup	Pelleseura 2	pelleseura_2
yung_tallent	precision_pistol_cup	Yung Tallent 1	yung_tallent_1
yung_tallent	precision_pistol_cup	Yung Tallent 2	yung_tallent_2
yung_tallent	precision_pistol_cup	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	precision_pistol_cup	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	precision_pistol_cup	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
aseharrastajien_yhtenaisyys	precision_pistol_cup	Aseharrastajien Yhtenäisyys 3	aseharrastajien_yhtenaisyys_3
tahtaysmestarit	precision_pistol_cup	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	precision_pistol_cup	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	precision_pistol_cup	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	precision_pistol_cup	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	precision_pistol_cup	Ampumataito 1	ampumataito_1
poliisiseura	tulevaisuuden_ampuja	Poliisiseura 1	poliisiseura_1
koiraseura	tulevaisuuden_ampuja	Koiraseura 1	koiraseura_1
hammaspeikkoseura	tulevaisuuden_ampuja	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	tulevaisuuden_ampuja	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	tulevaisuuden_ampuja	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	tulevaisuuden_ampuja	dog 1	dog_1
savu_seura	tulevaisuuden_ampuja	Savu Seura 1	savu_seura_1
savu_seura	tulevaisuuden_ampuja	Savu Seura 2	savu_seura_2
savu_seura	tulevaisuuden_ampuja	Savu Seura 3	savu_seura_3
omas	tulevaisuuden_ampuja	OMAS 1	omas_1
pelleseura	tulevaisuuden_ampuja	Pelleseura 1	pelleseura_1
pelleseura	tulevaisuuden_ampuja	Pelleseura 2	pelleseura_2
yung_tallent	tulevaisuuden_ampuja	Yung Tallent 1	yung_tallent_1
yung_tallent	tulevaisuuden_ampuja	Yung Tallent 2	yung_tallent_2
aseharrastajien_yhtenaisyys	tulevaisuuden_ampuja	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
aseharrastajien_yhtenaisyys	tulevaisuuden_ampuja	Aseharrastajien Yhtenäisyys 2	aseharrastajien_yhtenaisyys_2
tahtaysmestarit	tulevaisuuden_ampuja	Tähtäysmestarit 1	tahtaysmestarit_1
tahtaysmestarit	tulevaisuuden_ampuja	Tähtäysmestarit 2	tahtaysmestarit_2
tahtaysmestarit	tulevaisuuden_ampuja	Tähtäysmestarit 3	tahtaysmestarit_3
laukausryhma_aurora	tulevaisuuden_ampuja	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	tulevaisuuden_ampuja	Laukausryhmä Aurora 2	laukausryhma_aurora_2
laukausryhma_aurora	tulevaisuuden_ampuja	Laukausryhmä Aurora 3	laukausryhma_aurora_3
ampumataito	tulevaisuuden_ampuja	Ampumataito 1	ampumataito_1
poliisiseura	pikakivaari-klassikko	Poliisiseura 1	poliisiseura_1
poliisiseura	pikakivaari-klassikko	Poliisiseura 2	poliisiseura_2
koiraseura	pikakivaari-klassikko	Koiraseura 1	koiraseura_1
koiraseura	pikakivaari-klassikko	Koiraseura 2	koiraseura_2
koiraseura	pikakivaari-klassikko	Koiraseura 3	koiraseura_3
hammaspeikkoseura	pikakivaari-klassikko	Hammaspeikkoseura 1	hammaspeikkoseura_1
hammaspeikkoseura	pikakivaari-klassikko	Hammaspeikkoseura 2	hammaspeikkoseura_2
hammaspeikkoseura	pikakivaari-klassikko	Hammaspeikkoseura 3	hammaspeikkoseura_3
dog	pikakivaari-klassikko	dog 1	dog_1
savu_seura	pikakivaari-klassikko	Savu Seura 1	savu_seura_1
savu_seura	pikakivaari-klassikko	Savu Seura 2	savu_seura_2
savu_seura	pikakivaari-klassikko	Savu Seura 3	savu_seura_3
omas	pikakivaari-klassikko	OMAS 1	omas_1
omas	pikakivaari-klassikko	OMAS 2	omas_2
pelleseura	pikakivaari-klassikko	Pelleseura 1	pelleseura_1
yung_tallent	pikakivaari-klassikko	Yung Tallent 1	yung_tallent_1
yung_tallent	pikakivaari-klassikko	Yung Tallent 2	yung_tallent_2
yung_tallent	pikakivaari-klassikko	Yung Tallent 3	yung_tallent_3
aseharrastajien_yhtenaisyys	pikakivaari-klassikko	Aseharrastajien Yhtenäisyys 1	aseharrastajien_yhtenaisyys_1
tahtaysmestarit	pikakivaari-klassikko	Tähtäysmestarit 1	tahtaysmestarit_1
laukausryhma_aurora	pikakivaari-klassikko	Laukausryhmä Aurora 1	laukausryhma_aurora_1
laukausryhma_aurora	pikakivaari-klassikko	Laukausryhmä Aurora 2	laukausryhma_aurora_2
ampumataito	pikakivaari-klassikko	Ampumataito 1	ampumataito_1
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member (user_id, competition_id, team_name) FROM stdin;
2	kesan_ampujaiset	poliisiseura_1
3	kesan_ampujaiset	poliisiseura_1
4	kesan_ampujaiset	poliisiseura_1
5	kesan_ampujaiset	poliisiseura_1
6	kesan_ampujaiset	poliisiseura_2
7	kesan_ampujaiset	poliisiseura_2
8	kesan_ampujaiset	poliisiseura_2
9	kesan_ampujaiset	poliisiseura_2
10	kesan_ampujaiset	poliisiseura_3
11	kesan_ampujaiset	poliisiseura_3
12	kesan_ampujaiset	poliisiseura_3
13	kesan_ampujaiset	koiraseura_1
14	kesan_ampujaiset	koiraseura_1
15	kesan_ampujaiset	koiraseura_1
16	kesan_ampujaiset	koiraseura_1
17	kesan_ampujaiset	koiraseura_1
18	kesan_ampujaiset	hammaspeikkoseura_1
19	kesan_ampujaiset	hammaspeikkoseura_1
20	kesan_ampujaiset	hammaspeikkoseura_1
21	kesan_ampujaiset	hammaspeikkoseura_1
22	kesan_ampujaiset	hammaspeikkoseura_2
23	kesan_ampujaiset	hammaspeikkoseura_2
24	kesan_ampujaiset	hammaspeikkoseura_2
25	kesan_ampujaiset	dog_1
26	kesan_ampujaiset	dog_1
27	kesan_ampujaiset	dog_1
28	kesan_ampujaiset	dog_1
29	kesan_ampujaiset	savu_seura_1
30	kesan_ampujaiset	savu_seura_1
31	kesan_ampujaiset	savu_seura_1
32	kesan_ampujaiset	savu_seura_1
33	kesan_ampujaiset	savu_seura_1
34	kesan_ampujaiset	savu_seura_2
35	kesan_ampujaiset	savu_seura_2
36	kesan_ampujaiset	savu_seura_2
37	kesan_ampujaiset	savu_seura_3
38	kesan_ampujaiset	savu_seura_3
39	kesan_ampujaiset	savu_seura_3
40	kesan_ampujaiset	savu_seura_3
41	kesan_ampujaiset	savu_seura_3
42	kesan_ampujaiset	omas_1
43	kesan_ampujaiset	omas_1
44	kesan_ampujaiset	omas_1
45	kesan_ampujaiset	omas_1
46	kesan_ampujaiset	pelleseura_1
47	kesan_ampujaiset	pelleseura_1
48	kesan_ampujaiset	pelleseura_1
49	kesan_ampujaiset	yung_tallent_1
50	kesan_ampujaiset	yung_tallent_1
51	kesan_ampujaiset	yung_tallent_1
52	kesan_ampujaiset	aseharrastajien_yhtenaisyys_1
53	kesan_ampujaiset	aseharrastajien_yhtenaisyys_1
54	kesan_ampujaiset	aseharrastajien_yhtenaisyys_1
55	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
56	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
57	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
58	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
59	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
60	kesan_ampujaiset	aseharrastajien_yhtenaisyys_3
61	kesan_ampujaiset	aseharrastajien_yhtenaisyys_3
62	kesan_ampujaiset	aseharrastajien_yhtenaisyys_3
63	kesan_ampujaiset	tahtaysmestarit_1
64	kesan_ampujaiset	tahtaysmestarit_1
65	kesan_ampujaiset	tahtaysmestarit_1
66	kesan_ampujaiset	tahtaysmestarit_1
67	kesan_ampujaiset	tahtaysmestarit_2
68	kesan_ampujaiset	tahtaysmestarit_2
69	kesan_ampujaiset	tahtaysmestarit_2
70	kesan_ampujaiset	tahtaysmestarit_2
71	kesan_ampujaiset	tahtaysmestarit_3
72	kesan_ampujaiset	tahtaysmestarit_3
73	kesan_ampujaiset	tahtaysmestarit_3
74	kesan_ampujaiset	tahtaysmestarit_3
75	kesan_ampujaiset	laukausryhma_aurora_1
76	kesan_ampujaiset	laukausryhma_aurora_1
77	kesan_ampujaiset	laukausryhma_aurora_1
78	kesan_ampujaiset	ampumataito_1
79	kesan_ampujaiset	ampumataito_1
80	kesan_ampujaiset	ampumataito_1
81	kesan_ampujaiset	ampumataito_1
82	kesan_ampujaiset	ampumataito_1
83	kesan_ampujaiset	ampumataito_2
84	kesan_ampujaiset	ampumataito_2
85	kesan_ampujaiset	ampumataito_2
86	kesan_ampujaiset	ampumataito_2
87	kesan_ampujaiset	ampumataito_2
88	kesan_ampujaiset	ampumataito_3
89	kesan_ampujaiset	ampumataito_3
90	kesan_ampujaiset	ampumataito_3
91	kesan_ampujaiset	ampumataito_3
92	kesan_ampujaiset	ampumataito_3
93	talvi_pistooli	poliisiseura_1
94	talvi_pistooli	poliisiseura_1
95	talvi_pistooli	poliisiseura_1
96	talvi_pistooli	poliisiseura_1
97	talvi_pistooli	poliisiseura_1
98	talvi_pistooli	poliisiseura_2
99	talvi_pistooli	poliisiseura_2
100	talvi_pistooli	poliisiseura_2
101	talvi_pistooli	poliisiseura_2
102	talvi_pistooli	koiraseura_1
103	talvi_pistooli	koiraseura_1
104	talvi_pistooli	koiraseura_1
105	talvi_pistooli	koiraseura_1
106	talvi_pistooli	hammaspeikkoseura_1
107	talvi_pistooli	hammaspeikkoseura_1
108	talvi_pistooli	hammaspeikkoseura_1
109	talvi_pistooli	hammaspeikkoseura_2
110	talvi_pistooli	hammaspeikkoseura_2
111	talvi_pistooli	hammaspeikkoseura_2
112	talvi_pistooli	hammaspeikkoseura_2
113	talvi_pistooli	dog_1
114	talvi_pistooli	dog_1
115	talvi_pistooli	dog_1
116	talvi_pistooli	dog_1
117	talvi_pistooli	dog_2
118	talvi_pistooli	dog_2
119	talvi_pistooli	dog_2
120	talvi_pistooli	dog_2
121	talvi_pistooli	dog_2
122	talvi_pistooli	savu_seura_1
123	talvi_pistooli	savu_seura_1
124	talvi_pistooli	savu_seura_1
125	talvi_pistooli	savu_seura_1
126	talvi_pistooli	savu_seura_1
127	talvi_pistooli	savu_seura_2
128	talvi_pistooli	savu_seura_2
129	talvi_pistooli	savu_seura_2
130	talvi_pistooli	omas_1
131	talvi_pistooli	omas_1
132	talvi_pistooli	omas_1
133	talvi_pistooli	omas_1
134	talvi_pistooli	omas_1
135	talvi_pistooli	omas_2
136	talvi_pistooli	omas_2
137	talvi_pistooli	omas_2
138	talvi_pistooli	omas_2
139	talvi_pistooli	omas_2
140	talvi_pistooli	omas_3
141	talvi_pistooli	omas_3
142	talvi_pistooli	omas_3
143	talvi_pistooli	omas_3
144	talvi_pistooli	omas_3
145	talvi_pistooli	pelleseura_1
146	talvi_pistooli	pelleseura_1
147	talvi_pistooli	pelleseura_1
148	talvi_pistooli	pelleseura_1
149	talvi_pistooli	pelleseura_2
150	talvi_pistooli	pelleseura_2
151	talvi_pistooli	pelleseura_2
152	talvi_pistooli	pelleseura_2
153	talvi_pistooli	pelleseura_3
154	talvi_pistooli	pelleseura_3
155	talvi_pistooli	pelleseura_3
156	talvi_pistooli	pelleseura_3
157	talvi_pistooli	yung_tallent_1
158	talvi_pistooli	yung_tallent_1
159	talvi_pistooli	yung_tallent_1
160	talvi_pistooli	yung_tallent_1
161	talvi_pistooli	yung_tallent_2
162	talvi_pistooli	yung_tallent_2
163	talvi_pistooli	yung_tallent_2
164	talvi_pistooli	yung_tallent_2
165	talvi_pistooli	yung_tallent_2
166	talvi_pistooli	yung_tallent_3
167	talvi_pistooli	yung_tallent_3
168	talvi_pistooli	yung_tallent_3
169	talvi_pistooli	yung_tallent_3
170	talvi_pistooli	aseharrastajien_yhtenaisyys_1
171	talvi_pistooli	aseharrastajien_yhtenaisyys_1
172	talvi_pistooli	aseharrastajien_yhtenaisyys_1
173	talvi_pistooli	aseharrastajien_yhtenaisyys_1
174	talvi_pistooli	tahtaysmestarit_1
175	talvi_pistooli	tahtaysmestarit_1
176	talvi_pistooli	tahtaysmestarit_1
177	talvi_pistooli	tahtaysmestarit_1
178	talvi_pistooli	tahtaysmestarit_1
179	talvi_pistooli	tahtaysmestarit_2
180	talvi_pistooli	tahtaysmestarit_2
181	talvi_pistooli	tahtaysmestarit_2
182	talvi_pistooli	tahtaysmestarit_3
183	talvi_pistooli	tahtaysmestarit_3
184	talvi_pistooli	tahtaysmestarit_3
185	talvi_pistooli	tahtaysmestarit_3
186	talvi_pistooli	tahtaysmestarit_3
187	talvi_pistooli	laukausryhma_aurora_1
188	talvi_pistooli	laukausryhma_aurora_1
189	talvi_pistooli	laukausryhma_aurora_1
190	talvi_pistooli	ampumataito_1
191	talvi_pistooli	ampumataito_1
192	talvi_pistooli	ampumataito_1
193	talvi_pistooli	ampumataito_1
194	talvi_pistooli	ampumataito_2
195	talvi_pistooli	ampumataito_2
196	talvi_pistooli	ampumataito_2
197	tarkkuuslaukaus-festivaali	poliisiseura_1
198	tarkkuuslaukaus-festivaali	poliisiseura_1
199	tarkkuuslaukaus-festivaali	poliisiseura_1
200	tarkkuuslaukaus-festivaali	poliisiseura_1
201	tarkkuuslaukaus-festivaali	poliisiseura_2
202	tarkkuuslaukaus-festivaali	poliisiseura_2
203	tarkkuuslaukaus-festivaali	poliisiseura_2
204	tarkkuuslaukaus-festivaali	poliisiseura_3
205	tarkkuuslaukaus-festivaali	poliisiseura_3
206	tarkkuuslaukaus-festivaali	poliisiseura_3
207	tarkkuuslaukaus-festivaali	poliisiseura_3
208	tarkkuuslaukaus-festivaali	poliisiseura_3
209	tarkkuuslaukaus-festivaali	koiraseura_1
210	tarkkuuslaukaus-festivaali	koiraseura_1
211	tarkkuuslaukaus-festivaali	koiraseura_1
212	tarkkuuslaukaus-festivaali	koiraseura_1
213	tarkkuuslaukaus-festivaali	koiraseura_1
214	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
215	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
216	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
217	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
218	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
219	tarkkuuslaukaus-festivaali	dog_1
220	tarkkuuslaukaus-festivaali	dog_1
221	tarkkuuslaukaus-festivaali	dog_1
222	tarkkuuslaukaus-festivaali	savu_seura_1
223	tarkkuuslaukaus-festivaali	savu_seura_1
224	tarkkuuslaukaus-festivaali	savu_seura_1
225	tarkkuuslaukaus-festivaali	savu_seura_1
226	tarkkuuslaukaus-festivaali	savu_seura_1
227	tarkkuuslaukaus-festivaali	omas_1
228	tarkkuuslaukaus-festivaali	omas_1
229	tarkkuuslaukaus-festivaali	omas_1
230	tarkkuuslaukaus-festivaali	omas_1
231	tarkkuuslaukaus-festivaali	omas_2
232	tarkkuuslaukaus-festivaali	omas_2
233	tarkkuuslaukaus-festivaali	omas_2
234	tarkkuuslaukaus-festivaali	omas_3
235	tarkkuuslaukaus-festivaali	omas_3
236	tarkkuuslaukaus-festivaali	omas_3
237	tarkkuuslaukaus-festivaali	omas_3
238	tarkkuuslaukaus-festivaali	pelleseura_1
239	tarkkuuslaukaus-festivaali	pelleseura_1
240	tarkkuuslaukaus-festivaali	pelleseura_1
241	tarkkuuslaukaus-festivaali	pelleseura_1
242	tarkkuuslaukaus-festivaali	pelleseura_2
243	tarkkuuslaukaus-festivaali	pelleseura_2
244	tarkkuuslaukaus-festivaali	pelleseura_2
245	tarkkuuslaukaus-festivaali	pelleseura_2
246	tarkkuuslaukaus-festivaali	pelleseura_2
247	tarkkuuslaukaus-festivaali	pelleseura_3
248	tarkkuuslaukaus-festivaali	pelleseura_3
249	tarkkuuslaukaus-festivaali	pelleseura_3
250	tarkkuuslaukaus-festivaali	pelleseura_3
251	tarkkuuslaukaus-festivaali	pelleseura_3
252	tarkkuuslaukaus-festivaali	yung_tallent_1
253	tarkkuuslaukaus-festivaali	yung_tallent_1
254	tarkkuuslaukaus-festivaali	yung_tallent_1
255	tarkkuuslaukaus-festivaali	yung_tallent_2
256	tarkkuuslaukaus-festivaali	yung_tallent_2
257	tarkkuuslaukaus-festivaali	yung_tallent_2
258	tarkkuuslaukaus-festivaali	yung_tallent_2
259	tarkkuuslaukaus-festivaali	yung_tallent_2
260	tarkkuuslaukaus-festivaali	yung_tallent_3
261	tarkkuuslaukaus-festivaali	yung_tallent_3
262	tarkkuuslaukaus-festivaali	yung_tallent_3
263	tarkkuuslaukaus-festivaali	yung_tallent_3
264	tarkkuuslaukaus-festivaali	yung_tallent_3
265	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_1
266	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_1
267	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_1
268	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
269	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
270	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
271	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
272	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
273	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
274	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
275	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
276	tarkkuuslaukaus-festivaali	tahtaysmestarit_1
277	tarkkuuslaukaus-festivaali	tahtaysmestarit_1
278	tarkkuuslaukaus-festivaali	tahtaysmestarit_1
279	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
280	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
281	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
282	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
283	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
284	tarkkuuslaukaus-festivaali	laukausryhma_aurora_1
285	tarkkuuslaukaus-festivaali	laukausryhma_aurora_1
286	tarkkuuslaukaus-festivaali	laukausryhma_aurora_1
287	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
288	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
289	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
290	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
291	tarkkuuslaukaus-festivaali	laukausryhma_aurora_3
292	tarkkuuslaukaus-festivaali	laukausryhma_aurora_3
293	tarkkuuslaukaus-festivaali	laukausryhma_aurora_3
294	tarkkuuslaukaus-festivaali	ampumataito_1
295	tarkkuuslaukaus-festivaali	ampumataito_1
296	tarkkuuslaukaus-festivaali	ampumataito_1
297	tarkkuuslaukaus-festivaali	ampumataito_1
298	tarkkuuslaukaus-festivaali	ampumataito_1
299	tarkkuuslaukaus-festivaali	ampumataito_2
300	tarkkuuslaukaus-festivaali	ampumataito_2
301	tarkkuuslaukaus-festivaali	ampumataito_2
302	tarkkuuslaukaus-festivaali	ampumataito_2
303	tarkkuuslaukaus-festivaali	ampumataito_3
304	tarkkuuslaukaus-festivaali	ampumataito_3
305	tarkkuuslaukaus-festivaali	ampumataito_3
306	tarkkuuslaukaus-festivaali	ampumataito_3
307	tarkkuuslaukaus-festivaali	ampumataito_3
308	kivaarikilpailujen_huipennus	poliisiseura_1
309	kivaarikilpailujen_huipennus	poliisiseura_1
310	kivaarikilpailujen_huipennus	poliisiseura_1
311	kivaarikilpailujen_huipennus	poliisiseura_1
312	kivaarikilpailujen_huipennus	poliisiseura_1
313	kivaarikilpailujen_huipennus	poliisiseura_2
314	kivaarikilpailujen_huipennus	poliisiseura_2
315	kivaarikilpailujen_huipennus	poliisiseura_2
316	kivaarikilpailujen_huipennus	poliisiseura_3
317	kivaarikilpailujen_huipennus	poliisiseura_3
318	kivaarikilpailujen_huipennus	poliisiseura_3
319	kivaarikilpailujen_huipennus	poliisiseura_3
320	kivaarikilpailujen_huipennus	poliisiseura_3
321	kivaarikilpailujen_huipennus	koiraseura_1
322	kivaarikilpailujen_huipennus	koiraseura_1
323	kivaarikilpailujen_huipennus	koiraseura_1
324	kivaarikilpailujen_huipennus	koiraseura_1
325	kivaarikilpailujen_huipennus	koiraseura_2
326	kivaarikilpailujen_huipennus	koiraseura_2
327	kivaarikilpailujen_huipennus	koiraseura_2
328	kivaarikilpailujen_huipennus	koiraseura_2
329	kivaarikilpailujen_huipennus	koiraseura_2
330	kivaarikilpailujen_huipennus	koiraseura_3
331	kivaarikilpailujen_huipennus	koiraseura_3
332	kivaarikilpailujen_huipennus	koiraseura_3
333	kivaarikilpailujen_huipennus	koiraseura_3
334	kivaarikilpailujen_huipennus	koiraseura_3
335	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
336	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
337	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
338	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
339	kivaarikilpailujen_huipennus	dog_1
340	kivaarikilpailujen_huipennus	dog_1
341	kivaarikilpailujen_huipennus	dog_1
342	kivaarikilpailujen_huipennus	dog_1
343	kivaarikilpailujen_huipennus	dog_2
344	kivaarikilpailujen_huipennus	dog_2
345	kivaarikilpailujen_huipennus	dog_2
346	kivaarikilpailujen_huipennus	dog_2
347	kivaarikilpailujen_huipennus	dog_2
348	kivaarikilpailujen_huipennus	dog_3
349	kivaarikilpailujen_huipennus	dog_3
350	kivaarikilpailujen_huipennus	dog_3
351	kivaarikilpailujen_huipennus	savu_seura_1
352	kivaarikilpailujen_huipennus	savu_seura_1
353	kivaarikilpailujen_huipennus	savu_seura_1
354	kivaarikilpailujen_huipennus	savu_seura_1
355	kivaarikilpailujen_huipennus	savu_seura_2
356	kivaarikilpailujen_huipennus	savu_seura_2
357	kivaarikilpailujen_huipennus	savu_seura_2
358	kivaarikilpailujen_huipennus	savu_seura_2
359	kivaarikilpailujen_huipennus	omas_1
360	kivaarikilpailujen_huipennus	omas_1
361	kivaarikilpailujen_huipennus	omas_1
362	kivaarikilpailujen_huipennus	omas_1
363	kivaarikilpailujen_huipennus	omas_1
364	kivaarikilpailujen_huipennus	omas_2
365	kivaarikilpailujen_huipennus	omas_2
366	kivaarikilpailujen_huipennus	omas_2
367	kivaarikilpailujen_huipennus	omas_2
368	kivaarikilpailujen_huipennus	pelleseura_1
369	kivaarikilpailujen_huipennus	pelleseura_1
370	kivaarikilpailujen_huipennus	pelleseura_1
371	kivaarikilpailujen_huipennus	pelleseura_2
372	kivaarikilpailujen_huipennus	pelleseura_2
373	kivaarikilpailujen_huipennus	pelleseura_2
374	kivaarikilpailujen_huipennus	pelleseura_3
375	kivaarikilpailujen_huipennus	pelleseura_3
376	kivaarikilpailujen_huipennus	pelleseura_3
377	kivaarikilpailujen_huipennus	pelleseura_3
378	kivaarikilpailujen_huipennus	pelleseura_3
379	kivaarikilpailujen_huipennus	yung_tallent_1
380	kivaarikilpailujen_huipennus	yung_tallent_1
381	kivaarikilpailujen_huipennus	yung_tallent_1
382	kivaarikilpailujen_huipennus	yung_tallent_1
383	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
384	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
385	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
386	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
387	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_2
388	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_2
389	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_2
390	kivaarikilpailujen_huipennus	tahtaysmestarit_1
391	kivaarikilpailujen_huipennus	tahtaysmestarit_1
392	kivaarikilpailujen_huipennus	tahtaysmestarit_1
393	kivaarikilpailujen_huipennus	tahtaysmestarit_2
394	kivaarikilpailujen_huipennus	tahtaysmestarit_2
395	kivaarikilpailujen_huipennus	tahtaysmestarit_2
396	kivaarikilpailujen_huipennus	tahtaysmestarit_2
397	kivaarikilpailujen_huipennus	laukausryhma_aurora_1
398	kivaarikilpailujen_huipennus	laukausryhma_aurora_1
399	kivaarikilpailujen_huipennus	laukausryhma_aurora_1
400	kivaarikilpailujen_huipennus	ampumataito_1
401	kivaarikilpailujen_huipennus	ampumataito_1
402	kivaarikilpailujen_huipennus	ampumataito_1
403	kivaarikilpailujen_huipennus	ampumataito_2
404	kivaarikilpailujen_huipennus	ampumataito_2
405	kivaarikilpailujen_huipennus	ampumataito_2
406	kivaarikilpailujen_huipennus	ampumataito_2
407	kivaarikilpailujen_huipennus	ampumataito_3
408	kivaarikilpailujen_huipennus	ampumataito_3
409	kivaarikilpailujen_huipennus	ampumataito_3
410	kivaarikilpailujen_huipennus	ampumataito_3
411	kivaarikilpailujen_huipennus	ampumataito_3
412	polaris-ampumaharjoitus	poliisiseura_1
413	polaris-ampumaharjoitus	poliisiseura_1
414	polaris-ampumaharjoitus	poliisiseura_1
415	polaris-ampumaharjoitus	poliisiseura_1
416	polaris-ampumaharjoitus	poliisiseura_1
417	polaris-ampumaharjoitus	koiraseura_1
418	polaris-ampumaharjoitus	koiraseura_1
419	polaris-ampumaharjoitus	koiraseura_1
420	polaris-ampumaharjoitus	koiraseura_2
421	polaris-ampumaharjoitus	koiraseura_2
422	polaris-ampumaharjoitus	koiraseura_2
423	polaris-ampumaharjoitus	koiraseura_2
424	polaris-ampumaharjoitus	hammaspeikkoseura_1
425	polaris-ampumaharjoitus	hammaspeikkoseura_1
426	polaris-ampumaharjoitus	hammaspeikkoseura_1
427	polaris-ampumaharjoitus	hammaspeikkoseura_2
428	polaris-ampumaharjoitus	hammaspeikkoseura_2
429	polaris-ampumaharjoitus	hammaspeikkoseura_2
430	polaris-ampumaharjoitus	hammaspeikkoseura_3
431	polaris-ampumaharjoitus	hammaspeikkoseura_3
432	polaris-ampumaharjoitus	hammaspeikkoseura_3
433	polaris-ampumaharjoitus	dog_1
434	polaris-ampumaharjoitus	dog_1
435	polaris-ampumaharjoitus	dog_1
436	polaris-ampumaharjoitus	dog_1
437	polaris-ampumaharjoitus	dog_2
438	polaris-ampumaharjoitus	dog_2
439	polaris-ampumaharjoitus	dog_2
440	polaris-ampumaharjoitus	dog_2
441	polaris-ampumaharjoitus	dog_3
442	polaris-ampumaharjoitus	dog_3
443	polaris-ampumaharjoitus	dog_3
444	polaris-ampumaharjoitus	savu_seura_1
445	polaris-ampumaharjoitus	savu_seura_1
446	polaris-ampumaharjoitus	savu_seura_1
447	polaris-ampumaharjoitus	savu_seura_1
448	polaris-ampumaharjoitus	savu_seura_1
449	polaris-ampumaharjoitus	savu_seura_2
450	polaris-ampumaharjoitus	savu_seura_2
451	polaris-ampumaharjoitus	savu_seura_2
452	polaris-ampumaharjoitus	savu_seura_3
453	polaris-ampumaharjoitus	savu_seura_3
454	polaris-ampumaharjoitus	savu_seura_3
455	polaris-ampumaharjoitus	omas_1
456	polaris-ampumaharjoitus	omas_1
457	polaris-ampumaharjoitus	omas_1
458	polaris-ampumaharjoitus	omas_1
459	polaris-ampumaharjoitus	omas_1
460	polaris-ampumaharjoitus	omas_2
461	polaris-ampumaharjoitus	omas_2
462	polaris-ampumaharjoitus	omas_2
463	polaris-ampumaharjoitus	omas_2
464	polaris-ampumaharjoitus	omas_2
465	polaris-ampumaharjoitus	omas_3
466	polaris-ampumaharjoitus	omas_3
467	polaris-ampumaharjoitus	omas_3
468	polaris-ampumaharjoitus	omas_3
469	polaris-ampumaharjoitus	pelleseura_1
470	polaris-ampumaharjoitus	pelleseura_1
471	polaris-ampumaharjoitus	pelleseura_1
472	polaris-ampumaharjoitus	pelleseura_1
473	polaris-ampumaharjoitus	pelleseura_2
474	polaris-ampumaharjoitus	pelleseura_2
475	polaris-ampumaharjoitus	pelleseura_2
476	polaris-ampumaharjoitus	pelleseura_3
477	polaris-ampumaharjoitus	pelleseura_3
478	polaris-ampumaharjoitus	pelleseura_3
479	polaris-ampumaharjoitus	pelleseura_3
480	polaris-ampumaharjoitus	yung_tallent_1
481	polaris-ampumaharjoitus	yung_tallent_1
482	polaris-ampumaharjoitus	yung_tallent_1
483	polaris-ampumaharjoitus	yung_tallent_1
484	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
485	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
486	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
487	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
488	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
489	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
490	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
491	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
492	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
493	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
494	polaris-ampumaharjoitus	tahtaysmestarit_1
495	polaris-ampumaharjoitus	tahtaysmestarit_1
496	polaris-ampumaharjoitus	tahtaysmestarit_1
497	polaris-ampumaharjoitus	tahtaysmestarit_1
498	polaris-ampumaharjoitus	tahtaysmestarit_2
499	polaris-ampumaharjoitus	tahtaysmestarit_2
500	polaris-ampumaharjoitus	tahtaysmestarit_2
501	polaris-ampumaharjoitus	tahtaysmestarit_2
502	polaris-ampumaharjoitus	tahtaysmestarit_2
503	polaris-ampumaharjoitus	tahtaysmestarit_3
504	polaris-ampumaharjoitus	tahtaysmestarit_3
505	polaris-ampumaharjoitus	tahtaysmestarit_3
506	polaris-ampumaharjoitus	laukausryhma_aurora_1
507	polaris-ampumaharjoitus	laukausryhma_aurora_1
508	polaris-ampumaharjoitus	laukausryhma_aurora_1
509	polaris-ampumaharjoitus	laukausryhma_aurora_1
510	polaris-ampumaharjoitus	laukausryhma_aurora_2
511	polaris-ampumaharjoitus	laukausryhma_aurora_2
512	polaris-ampumaharjoitus	laukausryhma_aurora_2
513	polaris-ampumaharjoitus	laukausryhma_aurora_2
514	polaris-ampumaharjoitus	laukausryhma_aurora_2
515	polaris-ampumaharjoitus	laukausryhma_aurora_3
516	polaris-ampumaharjoitus	laukausryhma_aurora_3
517	polaris-ampumaharjoitus	laukausryhma_aurora_3
518	polaris-ampumaharjoitus	laukausryhma_aurora_3
519	polaris-ampumaharjoitus	laukausryhma_aurora_3
520	polaris-ampumaharjoitus	ampumataito_1
521	polaris-ampumaharjoitus	ampumataito_1
522	polaris-ampumaharjoitus	ampumataito_1
523	aamunkoiton_tahtays	poliisiseura_1
524	aamunkoiton_tahtays	poliisiseura_1
525	aamunkoiton_tahtays	poliisiseura_1
526	aamunkoiton_tahtays	poliisiseura_1
527	aamunkoiton_tahtays	poliisiseura_2
528	aamunkoiton_tahtays	poliisiseura_2
529	aamunkoiton_tahtays	poliisiseura_2
530	aamunkoiton_tahtays	poliisiseura_2
531	aamunkoiton_tahtays	poliisiseura_2
532	aamunkoiton_tahtays	koiraseura_1
533	aamunkoiton_tahtays	koiraseura_1
534	aamunkoiton_tahtays	koiraseura_1
535	aamunkoiton_tahtays	koiraseura_1
536	aamunkoiton_tahtays	koiraseura_1
537	aamunkoiton_tahtays	koiraseura_2
538	aamunkoiton_tahtays	koiraseura_2
539	aamunkoiton_tahtays	koiraseura_2
540	aamunkoiton_tahtays	hammaspeikkoseura_1
541	aamunkoiton_tahtays	hammaspeikkoseura_1
542	aamunkoiton_tahtays	hammaspeikkoseura_1
543	aamunkoiton_tahtays	hammaspeikkoseura_2
544	aamunkoiton_tahtays	hammaspeikkoseura_2
545	aamunkoiton_tahtays	hammaspeikkoseura_2
546	aamunkoiton_tahtays	hammaspeikkoseura_2
547	aamunkoiton_tahtays	hammaspeikkoseura_3
548	aamunkoiton_tahtays	hammaspeikkoseura_3
549	aamunkoiton_tahtays	hammaspeikkoseura_3
550	aamunkoiton_tahtays	hammaspeikkoseura_3
551	aamunkoiton_tahtays	dog_1
552	aamunkoiton_tahtays	dog_1
553	aamunkoiton_tahtays	dog_1
554	aamunkoiton_tahtays	dog_1
555	aamunkoiton_tahtays	savu_seura_1
556	aamunkoiton_tahtays	savu_seura_1
557	aamunkoiton_tahtays	savu_seura_1
558	aamunkoiton_tahtays	savu_seura_2
559	aamunkoiton_tahtays	savu_seura_2
560	aamunkoiton_tahtays	savu_seura_2
561	aamunkoiton_tahtays	savu_seura_2
562	aamunkoiton_tahtays	savu_seura_3
563	aamunkoiton_tahtays	savu_seura_3
564	aamunkoiton_tahtays	savu_seura_3
565	aamunkoiton_tahtays	savu_seura_3
566	aamunkoiton_tahtays	savu_seura_3
567	aamunkoiton_tahtays	omas_1
568	aamunkoiton_tahtays	omas_1
569	aamunkoiton_tahtays	omas_1
570	aamunkoiton_tahtays	omas_1
571	aamunkoiton_tahtays	omas_1
572	aamunkoiton_tahtays	omas_2
573	aamunkoiton_tahtays	omas_2
574	aamunkoiton_tahtays	omas_2
575	aamunkoiton_tahtays	omas_2
576	aamunkoiton_tahtays	pelleseura_1
577	aamunkoiton_tahtays	pelleseura_1
578	aamunkoiton_tahtays	pelleseura_1
579	aamunkoiton_tahtays	pelleseura_1
580	aamunkoiton_tahtays	pelleseura_2
581	aamunkoiton_tahtays	pelleseura_2
582	aamunkoiton_tahtays	pelleseura_2
583	aamunkoiton_tahtays	yung_tallent_1
584	aamunkoiton_tahtays	yung_tallent_1
585	aamunkoiton_tahtays	yung_tallent_1
586	aamunkoiton_tahtays	yung_tallent_1
587	aamunkoiton_tahtays	yung_tallent_1
588	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_1
589	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_1
590	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_1
591	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
592	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
593	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
594	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
595	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
596	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_3
597	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_3
598	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_3
599	aamunkoiton_tahtays	tahtaysmestarit_1
600	aamunkoiton_tahtays	tahtaysmestarit_1
601	aamunkoiton_tahtays	tahtaysmestarit_1
602	aamunkoiton_tahtays	tahtaysmestarit_1
603	aamunkoiton_tahtays	laukausryhma_aurora_1
604	aamunkoiton_tahtays	laukausryhma_aurora_1
605	aamunkoiton_tahtays	laukausryhma_aurora_1
606	aamunkoiton_tahtays	laukausryhma_aurora_1
607	aamunkoiton_tahtays	laukausryhma_aurora_2
608	aamunkoiton_tahtays	laukausryhma_aurora_2
609	aamunkoiton_tahtays	laukausryhma_aurora_2
610	aamunkoiton_tahtays	laukausryhma_aurora_3
611	aamunkoiton_tahtays	laukausryhma_aurora_3
612	aamunkoiton_tahtays	laukausryhma_aurora_3
613	aamunkoiton_tahtays	laukausryhma_aurora_3
614	aamunkoiton_tahtays	ampumataito_1
615	aamunkoiton_tahtays	ampumataito_1
616	aamunkoiton_tahtays	ampumataito_1
617	aamunkoiton_tahtays	ampumataito_2
618	aamunkoiton_tahtays	ampumataito_2
619	aamunkoiton_tahtays	ampumataito_2
620	aamunkoiton_tahtays	ampumataito_2
621	nordic_sharpshooters_cup	poliisiseura_1
622	nordic_sharpshooters_cup	poliisiseura_1
623	nordic_sharpshooters_cup	poliisiseura_1
624	nordic_sharpshooters_cup	poliisiseura_1
625	nordic_sharpshooters_cup	koiraseura_1
626	nordic_sharpshooters_cup	koiraseura_1
627	nordic_sharpshooters_cup	koiraseura_1
628	nordic_sharpshooters_cup	koiraseura_2
629	nordic_sharpshooters_cup	koiraseura_2
630	nordic_sharpshooters_cup	koiraseura_2
631	nordic_sharpshooters_cup	koiraseura_2
632	nordic_sharpshooters_cup	hammaspeikkoseura_1
633	nordic_sharpshooters_cup	hammaspeikkoseura_1
634	nordic_sharpshooters_cup	hammaspeikkoseura_1
635	nordic_sharpshooters_cup	hammaspeikkoseura_1
636	nordic_sharpshooters_cup	hammaspeikkoseura_1
637	nordic_sharpshooters_cup	hammaspeikkoseura_2
638	nordic_sharpshooters_cup	hammaspeikkoseura_2
639	nordic_sharpshooters_cup	hammaspeikkoseura_2
640	nordic_sharpshooters_cup	hammaspeikkoseura_3
641	nordic_sharpshooters_cup	hammaspeikkoseura_3
642	nordic_sharpshooters_cup	hammaspeikkoseura_3
643	nordic_sharpshooters_cup	hammaspeikkoseura_3
644	nordic_sharpshooters_cup	hammaspeikkoseura_3
645	nordic_sharpshooters_cup	dog_1
646	nordic_sharpshooters_cup	dog_1
647	nordic_sharpshooters_cup	dog_1
648	nordic_sharpshooters_cup	dog_1
649	nordic_sharpshooters_cup	dog_1
650	nordic_sharpshooters_cup	dog_2
651	nordic_sharpshooters_cup	dog_2
652	nordic_sharpshooters_cup	dog_2
653	nordic_sharpshooters_cup	dog_2
654	nordic_sharpshooters_cup	savu_seura_1
655	nordic_sharpshooters_cup	savu_seura_1
656	nordic_sharpshooters_cup	savu_seura_1
657	nordic_sharpshooters_cup	savu_seura_1
658	nordic_sharpshooters_cup	omas_1
659	nordic_sharpshooters_cup	omas_1
660	nordic_sharpshooters_cup	omas_1
661	nordic_sharpshooters_cup	pelleseura_1
662	nordic_sharpshooters_cup	pelleseura_1
663	nordic_sharpshooters_cup	pelleseura_1
664	nordic_sharpshooters_cup	pelleseura_1
665	nordic_sharpshooters_cup	pelleseura_2
666	nordic_sharpshooters_cup	pelleseura_2
667	nordic_sharpshooters_cup	pelleseura_2
668	nordic_sharpshooters_cup	yung_tallent_1
669	nordic_sharpshooters_cup	yung_tallent_1
670	nordic_sharpshooters_cup	yung_tallent_1
671	nordic_sharpshooters_cup	yung_tallent_2
672	nordic_sharpshooters_cup	yung_tallent_2
673	nordic_sharpshooters_cup	yung_tallent_2
674	nordic_sharpshooters_cup	yung_tallent_2
675	nordic_sharpshooters_cup	yung_tallent_3
676	nordic_sharpshooters_cup	yung_tallent_3
677	nordic_sharpshooters_cup	yung_tallent_3
678	nordic_sharpshooters_cup	yung_tallent_3
679	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
680	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
681	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
682	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
683	nordic_sharpshooters_cup	tahtaysmestarit_1
684	nordic_sharpshooters_cup	tahtaysmestarit_1
685	nordic_sharpshooters_cup	tahtaysmestarit_1
686	nordic_sharpshooters_cup	tahtaysmestarit_2
687	nordic_sharpshooters_cup	tahtaysmestarit_2
688	nordic_sharpshooters_cup	tahtaysmestarit_2
689	nordic_sharpshooters_cup	tahtaysmestarit_2
690	nordic_sharpshooters_cup	laukausryhma_aurora_1
691	nordic_sharpshooters_cup	laukausryhma_aurora_1
692	nordic_sharpshooters_cup	laukausryhma_aurora_1
693	nordic_sharpshooters_cup	laukausryhma_aurora_1
694	nordic_sharpshooters_cup	laukausryhma_aurora_2
695	nordic_sharpshooters_cup	laukausryhma_aurora_2
696	nordic_sharpshooters_cup	laukausryhma_aurora_2
697	nordic_sharpshooters_cup	laukausryhma_aurora_2
698	nordic_sharpshooters_cup	laukausryhma_aurora_2
699	nordic_sharpshooters_cup	ampumataito_1
700	nordic_sharpshooters_cup	ampumataito_1
701	nordic_sharpshooters_cup	ampumataito_1
702	nordic_sharpshooters_cup	ampumataito_1
703	nordic_sharpshooters_cup	ampumataito_2
704	nordic_sharpshooters_cup	ampumataito_2
705	nordic_sharpshooters_cup	ampumataito_2
706	nordic_sharpshooters_cup	ampumataito_2
707	nordic_sharpshooters_cup	ampumataito_2
708	nordic_sharpshooters_cup	ampumataito_3
709	nordic_sharpshooters_cup	ampumataito_3
710	nordic_sharpshooters_cup	ampumataito_3
711	nordic_sharpshooters_cup	ampumataito_3
712	nordic_sharpshooters_cup	ampumataito_3
713	taivaanranta-tulitus	poliisiseura_1
714	taivaanranta-tulitus	poliisiseura_1
715	taivaanranta-tulitus	poliisiseura_1
716	taivaanranta-tulitus	poliisiseura_2
717	taivaanranta-tulitus	poliisiseura_2
718	taivaanranta-tulitus	poliisiseura_2
719	taivaanranta-tulitus	poliisiseura_2
720	taivaanranta-tulitus	poliisiseura_2
721	taivaanranta-tulitus	koiraseura_1
722	taivaanranta-tulitus	koiraseura_1
723	taivaanranta-tulitus	koiraseura_1
724	taivaanranta-tulitus	koiraseura_1
725	taivaanranta-tulitus	koiraseura_2
726	taivaanranta-tulitus	koiraseura_2
727	taivaanranta-tulitus	koiraseura_2
728	taivaanranta-tulitus	koiraseura_3
729	taivaanranta-tulitus	koiraseura_3
730	taivaanranta-tulitus	koiraseura_3
731	taivaanranta-tulitus	koiraseura_3
732	taivaanranta-tulitus	hammaspeikkoseura_1
733	taivaanranta-tulitus	hammaspeikkoseura_1
734	taivaanranta-tulitus	hammaspeikkoseura_1
735	taivaanranta-tulitus	hammaspeikkoseura_1
736	taivaanranta-tulitus	dog_1
737	taivaanranta-tulitus	dog_1
738	taivaanranta-tulitus	dog_1
739	taivaanranta-tulitus	dog_2
740	taivaanranta-tulitus	dog_2
741	taivaanranta-tulitus	dog_2
742	taivaanranta-tulitus	dog_2
743	taivaanranta-tulitus	dog_2
744	taivaanranta-tulitus	savu_seura_1
745	taivaanranta-tulitus	savu_seura_1
746	taivaanranta-tulitus	savu_seura_1
747	taivaanranta-tulitus	savu_seura_1
748	taivaanranta-tulitus	savu_seura_2
749	taivaanranta-tulitus	savu_seura_2
750	taivaanranta-tulitus	savu_seura_2
751	taivaanranta-tulitus	savu_seura_2
752	taivaanranta-tulitus	savu_seura_2
753	taivaanranta-tulitus	savu_seura_3
754	taivaanranta-tulitus	savu_seura_3
755	taivaanranta-tulitus	savu_seura_3
756	taivaanranta-tulitus	omas_1
757	taivaanranta-tulitus	omas_1
758	taivaanranta-tulitus	omas_1
759	taivaanranta-tulitus	omas_1
760	taivaanranta-tulitus	pelleseura_1
761	taivaanranta-tulitus	pelleseura_1
762	taivaanranta-tulitus	pelleseura_1
763	taivaanranta-tulitus	pelleseura_1
764	taivaanranta-tulitus	pelleseura_1
765	taivaanranta-tulitus	pelleseura_2
766	taivaanranta-tulitus	pelleseura_2
767	taivaanranta-tulitus	pelleseura_2
768	taivaanranta-tulitus	pelleseura_2
769	taivaanranta-tulitus	pelleseura_2
770	taivaanranta-tulitus	yung_tallent_1
771	taivaanranta-tulitus	yung_tallent_1
772	taivaanranta-tulitus	yung_tallent_1
773	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
774	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
775	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
776	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
777	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
778	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
779	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
780	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
781	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
782	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
783	taivaanranta-tulitus	tahtaysmestarit_1
784	taivaanranta-tulitus	tahtaysmestarit_1
785	taivaanranta-tulitus	tahtaysmestarit_1
786	taivaanranta-tulitus	tahtaysmestarit_1
787	taivaanranta-tulitus	tahtaysmestarit_1
788	taivaanranta-tulitus	laukausryhma_aurora_1
789	taivaanranta-tulitus	laukausryhma_aurora_1
790	taivaanranta-tulitus	laukausryhma_aurora_1
791	taivaanranta-tulitus	laukausryhma_aurora_2
792	taivaanranta-tulitus	laukausryhma_aurora_2
793	taivaanranta-tulitus	laukausryhma_aurora_2
794	taivaanranta-tulitus	laukausryhma_aurora_2
795	taivaanranta-tulitus	laukausryhma_aurora_3
796	taivaanranta-tulitus	laukausryhma_aurora_3
797	taivaanranta-tulitus	laukausryhma_aurora_3
798	taivaanranta-tulitus	ampumataito_1
799	taivaanranta-tulitus	ampumataito_1
800	taivaanranta-tulitus	ampumataito_1
801	taivaanranta-tulitus	ampumataito_1
802	lumivyory-ammunta	poliisiseura_1
803	lumivyory-ammunta	poliisiseura_1
804	lumivyory-ammunta	poliisiseura_1
805	lumivyory-ammunta	poliisiseura_1
806	lumivyory-ammunta	koiraseura_1
807	lumivyory-ammunta	koiraseura_1
808	lumivyory-ammunta	koiraseura_1
809	lumivyory-ammunta	koiraseura_2
810	lumivyory-ammunta	koiraseura_2
811	lumivyory-ammunta	koiraseura_2
812	lumivyory-ammunta	koiraseura_2
813	lumivyory-ammunta	koiraseura_2
814	lumivyory-ammunta	koiraseura_3
815	lumivyory-ammunta	koiraseura_3
816	lumivyory-ammunta	koiraseura_3
817	lumivyory-ammunta	koiraseura_3
818	lumivyory-ammunta	hammaspeikkoseura_1
819	lumivyory-ammunta	hammaspeikkoseura_1
820	lumivyory-ammunta	hammaspeikkoseura_1
821	lumivyory-ammunta	hammaspeikkoseura_2
822	lumivyory-ammunta	hammaspeikkoseura_2
823	lumivyory-ammunta	hammaspeikkoseura_2
824	lumivyory-ammunta	dog_1
825	lumivyory-ammunta	dog_1
826	lumivyory-ammunta	dog_1
827	lumivyory-ammunta	dog_1
828	lumivyory-ammunta	dog_1
829	lumivyory-ammunta	dog_2
830	lumivyory-ammunta	dog_2
831	lumivyory-ammunta	dog_2
832	lumivyory-ammunta	dog_2
833	lumivyory-ammunta	dog_3
834	lumivyory-ammunta	dog_3
835	lumivyory-ammunta	dog_3
836	lumivyory-ammunta	dog_3
837	lumivyory-ammunta	savu_seura_1
838	lumivyory-ammunta	savu_seura_1
839	lumivyory-ammunta	savu_seura_1
840	lumivyory-ammunta	savu_seura_1
841	lumivyory-ammunta	omas_1
842	lumivyory-ammunta	omas_1
843	lumivyory-ammunta	omas_1
844	lumivyory-ammunta	omas_1
845	lumivyory-ammunta	omas_1
846	lumivyory-ammunta	omas_2
847	lumivyory-ammunta	omas_2
848	lumivyory-ammunta	omas_2
849	lumivyory-ammunta	omas_2
850	lumivyory-ammunta	omas_3
851	lumivyory-ammunta	omas_3
852	lumivyory-ammunta	omas_3
853	lumivyory-ammunta	omas_3
854	lumivyory-ammunta	pelleseura_1
855	lumivyory-ammunta	pelleseura_1
856	lumivyory-ammunta	pelleseura_1
857	lumivyory-ammunta	pelleseura_2
858	lumivyory-ammunta	pelleseura_2
859	lumivyory-ammunta	pelleseura_2
860	lumivyory-ammunta	pelleseura_2
861	lumivyory-ammunta	pelleseura_2
862	lumivyory-ammunta	yung_tallent_1
863	lumivyory-ammunta	yung_tallent_1
864	lumivyory-ammunta	yung_tallent_1
865	lumivyory-ammunta	yung_tallent_1
866	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
867	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
868	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
869	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
870	lumivyory-ammunta	tahtaysmestarit_1
871	lumivyory-ammunta	tahtaysmestarit_1
872	lumivyory-ammunta	tahtaysmestarit_1
873	lumivyory-ammunta	tahtaysmestarit_1
874	lumivyory-ammunta	tahtaysmestarit_1
875	lumivyory-ammunta	tahtaysmestarit_2
876	lumivyory-ammunta	tahtaysmestarit_2
877	lumivyory-ammunta	tahtaysmestarit_2
878	lumivyory-ammunta	tahtaysmestarit_2
879	lumivyory-ammunta	tahtaysmestarit_2
880	lumivyory-ammunta	tahtaysmestarit_3
881	lumivyory-ammunta	tahtaysmestarit_3
882	lumivyory-ammunta	tahtaysmestarit_3
883	lumivyory-ammunta	tahtaysmestarit_3
884	lumivyory-ammunta	laukausryhma_aurora_1
885	lumivyory-ammunta	laukausryhma_aurora_1
886	lumivyory-ammunta	laukausryhma_aurora_1
887	lumivyory-ammunta	ampumataito_1
888	lumivyory-ammunta	ampumataito_1
889	lumivyory-ammunta	ampumataito_1
890	lumivyory-ammunta	ampumataito_2
891	lumivyory-ammunta	ampumataito_2
892	lumivyory-ammunta	ampumataito_2
893	lumivyory-ammunta	ampumataito_2
894	lumivyory-ammunta	ampumataito_2
895	tarkka-ammunta_cup	poliisiseura_1
896	tarkka-ammunta_cup	poliisiseura_1
897	tarkka-ammunta_cup	poliisiseura_1
898	tarkka-ammunta_cup	poliisiseura_1
899	tarkka-ammunta_cup	poliisiseura_2
900	tarkka-ammunta_cup	poliisiseura_2
901	tarkka-ammunta_cup	poliisiseura_2
902	tarkka-ammunta_cup	poliisiseura_2
903	tarkka-ammunta_cup	koiraseura_1
904	tarkka-ammunta_cup	koiraseura_1
905	tarkka-ammunta_cup	koiraseura_1
906	tarkka-ammunta_cup	koiraseura_2
907	tarkka-ammunta_cup	koiraseura_2
908	tarkka-ammunta_cup	koiraseura_2
909	tarkka-ammunta_cup	koiraseura_3
910	tarkka-ammunta_cup	koiraseura_3
911	tarkka-ammunta_cup	koiraseura_3
912	tarkka-ammunta_cup	koiraseura_3
913	tarkka-ammunta_cup	koiraseura_3
914	tarkka-ammunta_cup	hammaspeikkoseura_1
915	tarkka-ammunta_cup	hammaspeikkoseura_1
916	tarkka-ammunta_cup	hammaspeikkoseura_1
917	tarkka-ammunta_cup	hammaspeikkoseura_1
918	tarkka-ammunta_cup	hammaspeikkoseura_1
919	tarkka-ammunta_cup	dog_1
920	tarkka-ammunta_cup	dog_1
921	tarkka-ammunta_cup	dog_1
922	tarkka-ammunta_cup	dog_1
923	tarkka-ammunta_cup	dog_2
924	tarkka-ammunta_cup	dog_2
925	tarkka-ammunta_cup	dog_2
926	tarkka-ammunta_cup	dog_2
927	tarkka-ammunta_cup	dog_2
928	tarkka-ammunta_cup	savu_seura_1
929	tarkka-ammunta_cup	savu_seura_1
930	tarkka-ammunta_cup	savu_seura_1
931	tarkka-ammunta_cup	savu_seura_1
932	tarkka-ammunta_cup	savu_seura_2
933	tarkka-ammunta_cup	savu_seura_2
934	tarkka-ammunta_cup	savu_seura_2
935	tarkka-ammunta_cup	savu_seura_2
936	tarkka-ammunta_cup	omas_1
937	tarkka-ammunta_cup	omas_1
938	tarkka-ammunta_cup	omas_1
939	tarkka-ammunta_cup	omas_1
940	tarkka-ammunta_cup	omas_1
941	tarkka-ammunta_cup	omas_2
942	tarkka-ammunta_cup	omas_2
943	tarkka-ammunta_cup	omas_2
944	tarkka-ammunta_cup	omas_2
945	tarkka-ammunta_cup	pelleseura_1
946	tarkka-ammunta_cup	pelleseura_1
947	tarkka-ammunta_cup	pelleseura_1
948	tarkka-ammunta_cup	pelleseura_1
949	tarkka-ammunta_cup	pelleseura_2
950	tarkka-ammunta_cup	pelleseura_2
951	tarkka-ammunta_cup	pelleseura_2
952	tarkka-ammunta_cup	pelleseura_2
953	tarkka-ammunta_cup	yung_tallent_1
954	tarkka-ammunta_cup	yung_tallent_1
955	tarkka-ammunta_cup	yung_tallent_1
956	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
957	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
958	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
959	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
960	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
961	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
962	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
963	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
964	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
965	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
966	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
967	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
968	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
969	tarkka-ammunta_cup	tahtaysmestarit_1
970	tarkka-ammunta_cup	tahtaysmestarit_1
971	tarkka-ammunta_cup	tahtaysmestarit_1
972	tarkka-ammunta_cup	tahtaysmestarit_2
973	tarkka-ammunta_cup	tahtaysmestarit_2
974	tarkka-ammunta_cup	tahtaysmestarit_2
975	tarkka-ammunta_cup	tahtaysmestarit_2
976	tarkka-ammunta_cup	tahtaysmestarit_2
977	tarkka-ammunta_cup	tahtaysmestarit_3
978	tarkka-ammunta_cup	tahtaysmestarit_3
979	tarkka-ammunta_cup	tahtaysmestarit_3
980	tarkka-ammunta_cup	tahtaysmestarit_3
981	tarkka-ammunta_cup	laukausryhma_aurora_1
982	tarkka-ammunta_cup	laukausryhma_aurora_1
983	tarkka-ammunta_cup	laukausryhma_aurora_1
984	tarkka-ammunta_cup	laukausryhma_aurora_2
985	tarkka-ammunta_cup	laukausryhma_aurora_2
986	tarkka-ammunta_cup	laukausryhma_aurora_2
987	tarkka-ammunta_cup	laukausryhma_aurora_2
988	tarkka-ammunta_cup	laukausryhma_aurora_2
989	tarkka-ammunta_cup	ampumataito_1
990	tarkka-ammunta_cup	ampumataito_1
991	tarkka-ammunta_cup	ampumataito_1
992	nopean_laukauksen_mestaruus	poliisiseura_1
993	nopean_laukauksen_mestaruus	poliisiseura_1
994	nopean_laukauksen_mestaruus	poliisiseura_1
995	nopean_laukauksen_mestaruus	poliisiseura_1
996	nopean_laukauksen_mestaruus	poliisiseura_1
997	nopean_laukauksen_mestaruus	poliisiseura_2
998	nopean_laukauksen_mestaruus	poliisiseura_2
999	nopean_laukauksen_mestaruus	poliisiseura_2
1000	nopean_laukauksen_mestaruus	poliisiseura_2
1001	nopean_laukauksen_mestaruus	koiraseura_1
1002	nopean_laukauksen_mestaruus	koiraseura_1
1003	nopean_laukauksen_mestaruus	koiraseura_1
1004	nopean_laukauksen_mestaruus	koiraseura_2
1005	nopean_laukauksen_mestaruus	koiraseura_2
1006	nopean_laukauksen_mestaruus	koiraseura_2
1007	nopean_laukauksen_mestaruus	koiraseura_2
1008	nopean_laukauksen_mestaruus	koiraseura_2
1009	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
1010	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
1011	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
1012	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
1013	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
1014	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
1015	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
1016	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
1017	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
1018	nopean_laukauksen_mestaruus	dog_1
1019	nopean_laukauksen_mestaruus	dog_1
1020	nopean_laukauksen_mestaruus	dog_1
1021	nopean_laukauksen_mestaruus	dog_1
1022	nopean_laukauksen_mestaruus	dog_1
1023	nopean_laukauksen_mestaruus	dog_2
1024	nopean_laukauksen_mestaruus	dog_2
1025	nopean_laukauksen_mestaruus	dog_2
1026	nopean_laukauksen_mestaruus	dog_3
1027	nopean_laukauksen_mestaruus	dog_3
1028	nopean_laukauksen_mestaruus	dog_3
1029	nopean_laukauksen_mestaruus	dog_3
1030	nopean_laukauksen_mestaruus	dog_3
1031	nopean_laukauksen_mestaruus	savu_seura_1
1032	nopean_laukauksen_mestaruus	savu_seura_1
1033	nopean_laukauksen_mestaruus	savu_seura_1
1034	nopean_laukauksen_mestaruus	savu_seura_1
1035	nopean_laukauksen_mestaruus	savu_seura_2
1036	nopean_laukauksen_mestaruus	savu_seura_2
1037	nopean_laukauksen_mestaruus	savu_seura_2
1038	nopean_laukauksen_mestaruus	savu_seura_2
1039	nopean_laukauksen_mestaruus	savu_seura_2
1040	nopean_laukauksen_mestaruus	omas_1
1041	nopean_laukauksen_mestaruus	omas_1
1042	nopean_laukauksen_mestaruus	omas_1
1043	nopean_laukauksen_mestaruus	omas_1
1044	nopean_laukauksen_mestaruus	omas_1
1045	nopean_laukauksen_mestaruus	pelleseura_1
1046	nopean_laukauksen_mestaruus	pelleseura_1
1047	nopean_laukauksen_mestaruus	pelleseura_1
1048	nopean_laukauksen_mestaruus	pelleseura_1
1049	nopean_laukauksen_mestaruus	pelleseura_1
1050	nopean_laukauksen_mestaruus	pelleseura_2
1051	nopean_laukauksen_mestaruus	pelleseura_2
1052	nopean_laukauksen_mestaruus	pelleseura_2
1053	nopean_laukauksen_mestaruus	pelleseura_2
1054	nopean_laukauksen_mestaruus	pelleseura_2
1055	nopean_laukauksen_mestaruus	pelleseura_3
1056	nopean_laukauksen_mestaruus	pelleseura_3
1057	nopean_laukauksen_mestaruus	pelleseura_3
1058	nopean_laukauksen_mestaruus	pelleseura_3
1059	nopean_laukauksen_mestaruus	pelleseura_3
1060	nopean_laukauksen_mestaruus	yung_tallent_1
1061	nopean_laukauksen_mestaruus	yung_tallent_1
1062	nopean_laukauksen_mestaruus	yung_tallent_1
1063	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
1064	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
1065	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
1066	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
1067	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_2
1068	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_2
1069	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_2
1070	nopean_laukauksen_mestaruus	tahtaysmestarit_1
1071	nopean_laukauksen_mestaruus	tahtaysmestarit_1
1072	nopean_laukauksen_mestaruus	tahtaysmestarit_1
1073	nopean_laukauksen_mestaruus	tahtaysmestarit_2
1074	nopean_laukauksen_mestaruus	tahtaysmestarit_2
1075	nopean_laukauksen_mestaruus	tahtaysmestarit_2
1076	nopean_laukauksen_mestaruus	tahtaysmestarit_2
1077	nopean_laukauksen_mestaruus	tahtaysmestarit_3
1078	nopean_laukauksen_mestaruus	tahtaysmestarit_3
1079	nopean_laukauksen_mestaruus	tahtaysmestarit_3
1080	nopean_laukauksen_mestaruus	tahtaysmestarit_3
1081	nopean_laukauksen_mestaruus	tahtaysmestarit_3
1082	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
1083	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
1084	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
1085	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
1086	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
1087	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
1088	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
1089	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
1090	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
1091	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
1092	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
1093	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
1094	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
1095	nopean_laukauksen_mestaruus	ampumataito_1
1096	nopean_laukauksen_mestaruus	ampumataito_1
1097	nopean_laukauksen_mestaruus	ampumataito_1
1098	nopean_laukauksen_mestaruus	ampumataito_1
1099	nopean_laukauksen_mestaruus	ampumataito_1
1100	nopean_laukauksen_mestaruus	ampumataito_2
1101	nopean_laukauksen_mestaruus	ampumataito_2
1102	nopean_laukauksen_mestaruus	ampumataito_2
1103	moniottelu	poliisiseura_1
1104	moniottelu	poliisiseura_1
1105	moniottelu	poliisiseura_1
1106	moniottelu	poliisiseura_1
1107	moniottelu	poliisiseura_2
1108	moniottelu	poliisiseura_2
1109	moniottelu	poliisiseura_2
1110	moniottelu	poliisiseura_2
1111	moniottelu	poliisiseura_3
1112	moniottelu	poliisiseura_3
1113	moniottelu	poliisiseura_3
1114	moniottelu	poliisiseura_3
1115	moniottelu	koiraseura_1
1116	moniottelu	koiraseura_1
1117	moniottelu	koiraseura_1
1118	moniottelu	koiraseura_2
1119	moniottelu	koiraseura_2
1120	moniottelu	koiraseura_2
1121	moniottelu	koiraseura_3
1122	moniottelu	koiraseura_3
1123	moniottelu	koiraseura_3
1124	moniottelu	koiraseura_3
1125	moniottelu	hammaspeikkoseura_1
1126	moniottelu	hammaspeikkoseura_1
1127	moniottelu	hammaspeikkoseura_1
1128	moniottelu	hammaspeikkoseura_1
1129	moniottelu	hammaspeikkoseura_2
1130	moniottelu	hammaspeikkoseura_2
1131	moniottelu	hammaspeikkoseura_2
1132	moniottelu	hammaspeikkoseura_2
1133	moniottelu	hammaspeikkoseura_2
1134	moniottelu	hammaspeikkoseura_3
1135	moniottelu	hammaspeikkoseura_3
1136	moniottelu	hammaspeikkoseura_3
1137	moniottelu	hammaspeikkoseura_3
1138	moniottelu	dog_1
1139	moniottelu	dog_1
1140	moniottelu	dog_1
1141	moniottelu	dog_2
1142	moniottelu	dog_2
1143	moniottelu	dog_2
1144	moniottelu	dog_2
1145	moniottelu	savu_seura_1
1146	moniottelu	savu_seura_1
1147	moniottelu	savu_seura_1
1148	moniottelu	savu_seura_1
1149	moniottelu	savu_seura_1
1150	moniottelu	savu_seura_2
1151	moniottelu	savu_seura_2
1152	moniottelu	savu_seura_2
1153	moniottelu	savu_seura_2
1154	moniottelu	savu_seura_3
1155	moniottelu	savu_seura_3
1156	moniottelu	savu_seura_3
1157	moniottelu	omas_1
1158	moniottelu	omas_1
1159	moniottelu	omas_1
1160	moniottelu	pelleseura_1
1161	moniottelu	pelleseura_1
1162	moniottelu	pelleseura_1
1163	moniottelu	yung_tallent_1
1164	moniottelu	yung_tallent_1
1165	moniottelu	yung_tallent_1
1166	moniottelu	yung_tallent_2
1167	moniottelu	yung_tallent_2
1168	moniottelu	yung_tallent_2
1169	moniottelu	yung_tallent_2
1170	moniottelu	yung_tallent_3
1171	moniottelu	yung_tallent_3
1172	moniottelu	yung_tallent_3
1173	moniottelu	yung_tallent_3
1174	moniottelu	yung_tallent_3
1175	moniottelu	aseharrastajien_yhtenaisyys_1
1176	moniottelu	aseharrastajien_yhtenaisyys_1
1177	moniottelu	aseharrastajien_yhtenaisyys_1
1178	moniottelu	aseharrastajien_yhtenaisyys_1
1179	moniottelu	aseharrastajien_yhtenaisyys_1
1180	moniottelu	aseharrastajien_yhtenaisyys_2
1181	moniottelu	aseharrastajien_yhtenaisyys_2
1182	moniottelu	aseharrastajien_yhtenaisyys_2
1183	moniottelu	aseharrastajien_yhtenaisyys_3
1184	moniottelu	aseharrastajien_yhtenaisyys_3
1185	moniottelu	aseharrastajien_yhtenaisyys_3
1186	moniottelu	tahtaysmestarit_1
1187	moniottelu	tahtaysmestarit_1
1188	moniottelu	tahtaysmestarit_1
1189	moniottelu	laukausryhma_aurora_1
1190	moniottelu	laukausryhma_aurora_1
1191	moniottelu	laukausryhma_aurora_1
1192	moniottelu	ampumataito_1
1193	moniottelu	ampumataito_1
1194	moniottelu	ampumataito_1
1195	moniottelu	ampumataito_1
1196	kansallinen_tahtayskilpailu	poliisiseura_1
1197	kansallinen_tahtayskilpailu	poliisiseura_1
1198	kansallinen_tahtayskilpailu	poliisiseura_1
1199	kansallinen_tahtayskilpailu	poliisiseura_2
1200	kansallinen_tahtayskilpailu	poliisiseura_2
1201	kansallinen_tahtayskilpailu	poliisiseura_2
1202	kansallinen_tahtayskilpailu	poliisiseura_2
1203	kansallinen_tahtayskilpailu	poliisiseura_3
1204	kansallinen_tahtayskilpailu	poliisiseura_3
1205	kansallinen_tahtayskilpailu	poliisiseura_3
1206	kansallinen_tahtayskilpailu	poliisiseura_3
1207	kansallinen_tahtayskilpailu	koiraseura_1
1208	kansallinen_tahtayskilpailu	koiraseura_1
1209	kansallinen_tahtayskilpailu	koiraseura_1
1210	kansallinen_tahtayskilpailu	koiraseura_1
1211	kansallinen_tahtayskilpailu	koiraseura_1
1212	kansallinen_tahtayskilpailu	koiraseura_2
1213	kansallinen_tahtayskilpailu	koiraseura_2
1214	kansallinen_tahtayskilpailu	koiraseura_2
1215	kansallinen_tahtayskilpailu	koiraseura_3
1216	kansallinen_tahtayskilpailu	koiraseura_3
1217	kansallinen_tahtayskilpailu	koiraseura_3
1218	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
1219	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
1220	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
1221	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
1222	kansallinen_tahtayskilpailu	dog_1
1223	kansallinen_tahtayskilpailu	dog_1
1224	kansallinen_tahtayskilpailu	dog_1
1225	kansallinen_tahtayskilpailu	dog_1
1226	kansallinen_tahtayskilpailu	dog_1
1227	kansallinen_tahtayskilpailu	savu_seura_1
1228	kansallinen_tahtayskilpailu	savu_seura_1
1229	kansallinen_tahtayskilpailu	savu_seura_1
1230	kansallinen_tahtayskilpailu	savu_seura_1
1231	kansallinen_tahtayskilpailu	savu_seura_2
1232	kansallinen_tahtayskilpailu	savu_seura_2
1233	kansallinen_tahtayskilpailu	savu_seura_2
1234	kansallinen_tahtayskilpailu	savu_seura_2
1235	kansallinen_tahtayskilpailu	savu_seura_3
1236	kansallinen_tahtayskilpailu	savu_seura_3
1237	kansallinen_tahtayskilpailu	savu_seura_3
1238	kansallinen_tahtayskilpailu	omas_1
1239	kansallinen_tahtayskilpailu	omas_1
1240	kansallinen_tahtayskilpailu	omas_1
1241	kansallinen_tahtayskilpailu	omas_1
1242	kansallinen_tahtayskilpailu	pelleseura_1
1243	kansallinen_tahtayskilpailu	pelleseura_1
1244	kansallinen_tahtayskilpailu	pelleseura_1
1245	kansallinen_tahtayskilpailu	pelleseura_2
1246	kansallinen_tahtayskilpailu	pelleseura_2
1247	kansallinen_tahtayskilpailu	pelleseura_2
1248	kansallinen_tahtayskilpailu	pelleseura_2
1249	kansallinen_tahtayskilpailu	pelleseura_2
1250	kansallinen_tahtayskilpailu	yung_tallent_1
1251	kansallinen_tahtayskilpailu	yung_tallent_1
1252	kansallinen_tahtayskilpailu	yung_tallent_1
1253	kansallinen_tahtayskilpailu	yung_tallent_1
1254	kansallinen_tahtayskilpailu	yung_tallent_2
1255	kansallinen_tahtayskilpailu	yung_tallent_2
1256	kansallinen_tahtayskilpailu	yung_tallent_2
1257	kansallinen_tahtayskilpailu	yung_tallent_2
1258	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_1
1259	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_1
1260	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_1
1261	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_2
1262	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_2
1263	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_2
1264	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
1265	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
1266	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
1482	vapaa-asekilpailu	koiraseura_1
1267	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
1268	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
1269	kansallinen_tahtayskilpailu	tahtaysmestarit_1
1270	kansallinen_tahtayskilpailu	tahtaysmestarit_1
1271	kansallinen_tahtayskilpailu	tahtaysmestarit_1
1272	kansallinen_tahtayskilpailu	tahtaysmestarit_1
1273	kansallinen_tahtayskilpailu	laukausryhma_aurora_1
1274	kansallinen_tahtayskilpailu	laukausryhma_aurora_1
1275	kansallinen_tahtayskilpailu	laukausryhma_aurora_1
1276	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
1277	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
1278	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
1279	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
1280	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
1281	kansallinen_tahtayskilpailu	ampumataito_1
1282	kansallinen_tahtayskilpailu	ampumataito_1
1283	kansallinen_tahtayskilpailu	ampumataito_1
1284	kansallinen_tahtayskilpailu	ampumataito_2
1285	kansallinen_tahtayskilpailu	ampumataito_2
1286	kansallinen_tahtayskilpailu	ampumataito_2
1287	kansallinen_tahtayskilpailu	ampumataito_2
1288	kansallinen_tahtayskilpailu	ampumataito_3
1289	kansallinen_tahtayskilpailu	ampumataito_3
1290	kansallinen_tahtayskilpailu	ampumataito_3
1291	kansallinen_tahtayskilpailu	ampumataito_3
1292	kansallinen_tahtayskilpailu	ampumataito_3
1293	kaupunkiammunta-challenge	poliisiseura_1
1294	kaupunkiammunta-challenge	poliisiseura_1
1295	kaupunkiammunta-challenge	poliisiseura_1
1296	kaupunkiammunta-challenge	poliisiseura_1
1297	kaupunkiammunta-challenge	poliisiseura_2
1298	kaupunkiammunta-challenge	poliisiseura_2
1299	kaupunkiammunta-challenge	poliisiseura_2
1300	kaupunkiammunta-challenge	poliisiseura_3
1301	kaupunkiammunta-challenge	poliisiseura_3
1302	kaupunkiammunta-challenge	poliisiseura_3
1303	kaupunkiammunta-challenge	koiraseura_1
1304	kaupunkiammunta-challenge	koiraseura_1
1305	kaupunkiammunta-challenge	koiraseura_1
1306	kaupunkiammunta-challenge	koiraseura_2
1307	kaupunkiammunta-challenge	koiraseura_2
1308	kaupunkiammunta-challenge	koiraseura_2
1309	kaupunkiammunta-challenge	koiraseura_2
1310	kaupunkiammunta-challenge	koiraseura_2
1311	kaupunkiammunta-challenge	koiraseura_3
1312	kaupunkiammunta-challenge	koiraseura_3
1313	kaupunkiammunta-challenge	koiraseura_3
1314	kaupunkiammunta-challenge	koiraseura_3
1315	kaupunkiammunta-challenge	koiraseura_3
1316	kaupunkiammunta-challenge	hammaspeikkoseura_1
1317	kaupunkiammunta-challenge	hammaspeikkoseura_1
1318	kaupunkiammunta-challenge	hammaspeikkoseura_1
1319	kaupunkiammunta-challenge	dog_1
1320	kaupunkiammunta-challenge	dog_1
1321	kaupunkiammunta-challenge	dog_1
1322	kaupunkiammunta-challenge	savu_seura_1
1323	kaupunkiammunta-challenge	savu_seura_1
1324	kaupunkiammunta-challenge	savu_seura_1
1325	kaupunkiammunta-challenge	omas_1
1326	kaupunkiammunta-challenge	omas_1
1327	kaupunkiammunta-challenge	omas_1
1328	kaupunkiammunta-challenge	omas_1
1329	kaupunkiammunta-challenge	omas_1
1330	kaupunkiammunta-challenge	pelleseura_1
1331	kaupunkiammunta-challenge	pelleseura_1
1332	kaupunkiammunta-challenge	pelleseura_1
1333	kaupunkiammunta-challenge	yung_tallent_1
1334	kaupunkiammunta-challenge	yung_tallent_1
1335	kaupunkiammunta-challenge	yung_tallent_1
1336	kaupunkiammunta-challenge	yung_tallent_1
1337	kaupunkiammunta-challenge	yung_tallent_2
1338	kaupunkiammunta-challenge	yung_tallent_2
1339	kaupunkiammunta-challenge	yung_tallent_2
1340	kaupunkiammunta-challenge	yung_tallent_2
1341	kaupunkiammunta-challenge	yung_tallent_2
1342	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
1343	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
1344	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
1345	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
1346	kaupunkiammunta-challenge	tahtaysmestarit_1
1347	kaupunkiammunta-challenge	tahtaysmestarit_1
1348	kaupunkiammunta-challenge	tahtaysmestarit_1
1349	kaupunkiammunta-challenge	tahtaysmestarit_1
1350	kaupunkiammunta-challenge	tahtaysmestarit_1
1351	kaupunkiammunta-challenge	laukausryhma_aurora_1
1352	kaupunkiammunta-challenge	laukausryhma_aurora_1
1353	kaupunkiammunta-challenge	laukausryhma_aurora_1
1354	kaupunkiammunta-challenge	laukausryhma_aurora_1
1355	kaupunkiammunta-challenge	laukausryhma_aurora_1
1356	kaupunkiammunta-challenge	laukausryhma_aurora_2
1357	kaupunkiammunta-challenge	laukausryhma_aurora_2
1358	kaupunkiammunta-challenge	laukausryhma_aurora_2
1359	kaupunkiammunta-challenge	laukausryhma_aurora_2
1360	kaupunkiammunta-challenge	laukausryhma_aurora_2
1361	kaupunkiammunta-challenge	ampumataito_1
1362	kaupunkiammunta-challenge	ampumataito_1
1363	kaupunkiammunta-challenge	ampumataito_1
1364	kaupunkiammunta-challenge	ampumataito_1
1365	kaupunkiammunta-challenge	ampumataito_1
1366	kaupunkiammunta-challenge	ampumataito_2
1367	kaupunkiammunta-challenge	ampumataito_2
1368	kaupunkiammunta-challenge	ampumataito_2
1369	kaupunkiammunta-challenge	ampumataito_2
1370	kaupunkiammunta-challenge	ampumataito_2
1371	laukausmaraton	poliisiseura_1
1372	laukausmaraton	poliisiseura_1
1373	laukausmaraton	poliisiseura_1
1374	laukausmaraton	poliisiseura_1
1375	laukausmaraton	poliisiseura_1
1376	laukausmaraton	poliisiseura_2
1377	laukausmaraton	poliisiseura_2
1378	laukausmaraton	poliisiseura_2
1379	laukausmaraton	poliisiseura_2
1380	laukausmaraton	poliisiseura_2
1381	laukausmaraton	poliisiseura_3
1382	laukausmaraton	poliisiseura_3
1383	laukausmaraton	poliisiseura_3
1384	laukausmaraton	koiraseura_1
1385	laukausmaraton	koiraseura_1
1386	laukausmaraton	koiraseura_1
1387	laukausmaraton	koiraseura_2
1388	laukausmaraton	koiraseura_2
1389	laukausmaraton	koiraseura_2
1390	laukausmaraton	koiraseura_2
1391	laukausmaraton	hammaspeikkoseura_1
1392	laukausmaraton	hammaspeikkoseura_1
1393	laukausmaraton	hammaspeikkoseura_1
1394	laukausmaraton	hammaspeikkoseura_1
1395	laukausmaraton	dog_1
1396	laukausmaraton	dog_1
1397	laukausmaraton	dog_1
1398	laukausmaraton	dog_1
1399	laukausmaraton	dog_2
1400	laukausmaraton	dog_2
1401	laukausmaraton	dog_2
1402	laukausmaraton	dog_2
1403	laukausmaraton	savu_seura_1
1404	laukausmaraton	savu_seura_1
1405	laukausmaraton	savu_seura_1
1406	laukausmaraton	savu_seura_1
1407	laukausmaraton	savu_seura_1
1408	laukausmaraton	savu_seura_2
1409	laukausmaraton	savu_seura_2
1410	laukausmaraton	savu_seura_2
1411	laukausmaraton	savu_seura_2
1412	laukausmaraton	savu_seura_2
1413	laukausmaraton	omas_1
1414	laukausmaraton	omas_1
1415	laukausmaraton	omas_1
1416	laukausmaraton	omas_2
1417	laukausmaraton	omas_2
1418	laukausmaraton	omas_2
1419	laukausmaraton	omas_3
1420	laukausmaraton	omas_3
1421	laukausmaraton	omas_3
1422	laukausmaraton	omas_3
1423	laukausmaraton	pelleseura_1
1424	laukausmaraton	pelleseura_1
1425	laukausmaraton	pelleseura_1
1426	laukausmaraton	pelleseura_1
1427	laukausmaraton	pelleseura_2
1428	laukausmaraton	pelleseura_2
1429	laukausmaraton	pelleseura_2
1430	laukausmaraton	yung_tallent_1
1431	laukausmaraton	yung_tallent_1
1432	laukausmaraton	yung_tallent_1
1433	laukausmaraton	yung_tallent_2
1434	laukausmaraton	yung_tallent_2
1435	laukausmaraton	yung_tallent_2
1436	laukausmaraton	yung_tallent_2
1437	laukausmaraton	yung_tallent_3
1438	laukausmaraton	yung_tallent_3
1439	laukausmaraton	yung_tallent_3
1440	laukausmaraton	aseharrastajien_yhtenaisyys_1
1441	laukausmaraton	aseharrastajien_yhtenaisyys_1
1442	laukausmaraton	aseharrastajien_yhtenaisyys_1
1443	laukausmaraton	aseharrastajien_yhtenaisyys_1
1444	laukausmaraton	tahtaysmestarit_1
1445	laukausmaraton	tahtaysmestarit_1
1446	laukausmaraton	tahtaysmestarit_1
1447	laukausmaraton	tahtaysmestarit_1
1448	laukausmaraton	tahtaysmestarit_1
1449	laukausmaraton	tahtaysmestarit_2
1450	laukausmaraton	tahtaysmestarit_2
1451	laukausmaraton	tahtaysmestarit_2
1452	laukausmaraton	tahtaysmestarit_2
1453	laukausmaraton	laukausryhma_aurora_1
1454	laukausmaraton	laukausryhma_aurora_1
1455	laukausmaraton	laukausryhma_aurora_1
1456	laukausmaraton	laukausryhma_aurora_1
1457	laukausmaraton	laukausryhma_aurora_1
1458	laukausmaraton	ampumataito_1
1459	laukausmaraton	ampumataito_1
1460	laukausmaraton	ampumataito_1
1461	laukausmaraton	ampumataito_1
1462	laukausmaraton	ampumataito_1
1463	laukausmaraton	ampumataito_2
1464	laukausmaraton	ampumataito_2
1465	laukausmaraton	ampumataito_2
1466	laukausmaraton	ampumataito_2
1467	vapaa-asekilpailu	poliisiseura_1
1468	vapaa-asekilpailu	poliisiseura_1
1469	vapaa-asekilpailu	poliisiseura_1
1470	vapaa-asekilpailu	poliisiseura_1
1471	vapaa-asekilpailu	poliisiseura_1
1472	vapaa-asekilpailu	poliisiseura_2
1473	vapaa-asekilpailu	poliisiseura_2
1474	vapaa-asekilpailu	poliisiseura_2
1475	vapaa-asekilpailu	poliisiseura_2
1476	vapaa-asekilpailu	poliisiseura_2
1477	vapaa-asekilpailu	poliisiseura_3
1478	vapaa-asekilpailu	poliisiseura_3
1479	vapaa-asekilpailu	poliisiseura_3
1480	vapaa-asekilpailu	poliisiseura_3
1481	vapaa-asekilpailu	koiraseura_1
1483	vapaa-asekilpailu	koiraseura_1
1484	vapaa-asekilpailu	koiraseura_1
1485	vapaa-asekilpailu	koiraseura_1
1486	vapaa-asekilpailu	koiraseura_2
1487	vapaa-asekilpailu	koiraseura_2
1488	vapaa-asekilpailu	koiraseura_2
1489	vapaa-asekilpailu	koiraseura_2
1490	vapaa-asekilpailu	hammaspeikkoseura_1
1491	vapaa-asekilpailu	hammaspeikkoseura_1
1492	vapaa-asekilpailu	hammaspeikkoseura_1
1493	vapaa-asekilpailu	hammaspeikkoseura_2
1494	vapaa-asekilpailu	hammaspeikkoseura_2
1495	vapaa-asekilpailu	hammaspeikkoseura_2
1496	vapaa-asekilpailu	hammaspeikkoseura_3
1497	vapaa-asekilpailu	hammaspeikkoseura_3
1498	vapaa-asekilpailu	hammaspeikkoseura_3
1499	vapaa-asekilpailu	dog_1
1500	vapaa-asekilpailu	dog_1
1501	vapaa-asekilpailu	dog_1
1502	vapaa-asekilpailu	dog_1
1503	vapaa-asekilpailu	dog_2
1504	vapaa-asekilpailu	dog_2
1505	vapaa-asekilpailu	dog_2
1506	vapaa-asekilpailu	dog_2
1507	vapaa-asekilpailu	dog_2
1508	vapaa-asekilpailu	savu_seura_1
1509	vapaa-asekilpailu	savu_seura_1
1510	vapaa-asekilpailu	savu_seura_1
1511	vapaa-asekilpailu	omas_1
1512	vapaa-asekilpailu	omas_1
1513	vapaa-asekilpailu	omas_1
1514	vapaa-asekilpailu	omas_1
1515	vapaa-asekilpailu	omas_1
1516	vapaa-asekilpailu	omas_2
1517	vapaa-asekilpailu	omas_2
1518	vapaa-asekilpailu	omas_2
1519	vapaa-asekilpailu	omas_3
1520	vapaa-asekilpailu	omas_3
1521	vapaa-asekilpailu	omas_3
1522	vapaa-asekilpailu	pelleseura_1
1523	vapaa-asekilpailu	pelleseura_1
1524	vapaa-asekilpailu	pelleseura_1
1525	vapaa-asekilpailu	pelleseura_1
1526	vapaa-asekilpailu	pelleseura_1
1527	vapaa-asekilpailu	yung_tallent_1
1528	vapaa-asekilpailu	yung_tallent_1
1529	vapaa-asekilpailu	yung_tallent_1
1530	vapaa-asekilpailu	yung_tallent_2
1531	vapaa-asekilpailu	yung_tallent_2
1532	vapaa-asekilpailu	yung_tallent_2
1533	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
1534	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
1535	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
1536	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
1537	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
1538	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
1539	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
1540	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
1541	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
1542	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_3
1543	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_3
1544	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_3
1545	vapaa-asekilpailu	tahtaysmestarit_1
1546	vapaa-asekilpailu	tahtaysmestarit_1
1547	vapaa-asekilpailu	tahtaysmestarit_1
1548	vapaa-asekilpailu	tahtaysmestarit_2
1549	vapaa-asekilpailu	tahtaysmestarit_2
1550	vapaa-asekilpailu	tahtaysmestarit_2
1551	vapaa-asekilpailu	laukausryhma_aurora_1
1552	vapaa-asekilpailu	laukausryhma_aurora_1
1553	vapaa-asekilpailu	laukausryhma_aurora_1
1554	vapaa-asekilpailu	laukausryhma_aurora_2
1555	vapaa-asekilpailu	laukausryhma_aurora_2
1556	vapaa-asekilpailu	laukausryhma_aurora_2
1557	vapaa-asekilpailu	laukausryhma_aurora_2
1558	vapaa-asekilpailu	ampumataito_1
1559	vapaa-asekilpailu	ampumataito_1
1560	vapaa-asekilpailu	ampumataito_1
1561	vapaa-asekilpailu	ampumataito_2
1562	vapaa-asekilpailu	ampumataito_2
1563	vapaa-asekilpailu	ampumataito_2
1564	vapaa-asekilpailu	ampumataito_2
1565	vapaa-asekilpailu	ampumataito_2
1566	vapaa-asekilpailu	ampumataito_3
1567	vapaa-asekilpailu	ampumataito_3
1568	vapaa-asekilpailu	ampumataito_3
1569	taitoluodikko-turnaus	poliisiseura_1
1570	taitoluodikko-turnaus	poliisiseura_1
1571	taitoluodikko-turnaus	poliisiseura_1
1572	taitoluodikko-turnaus	koiraseura_1
1573	taitoluodikko-turnaus	koiraseura_1
1574	taitoluodikko-turnaus	koiraseura_1
1575	taitoluodikko-turnaus	koiraseura_1
1576	taitoluodikko-turnaus	koiraseura_2
1577	taitoluodikko-turnaus	koiraseura_2
1578	taitoluodikko-turnaus	koiraseura_2
1579	taitoluodikko-turnaus	hammaspeikkoseura_1
1580	taitoluodikko-turnaus	hammaspeikkoseura_1
1581	taitoluodikko-turnaus	hammaspeikkoseura_1
1582	taitoluodikko-turnaus	hammaspeikkoseura_1
1583	taitoluodikko-turnaus	hammaspeikkoseura_1
1584	taitoluodikko-turnaus	hammaspeikkoseura_2
1585	taitoluodikko-turnaus	hammaspeikkoseura_2
1586	taitoluodikko-turnaus	hammaspeikkoseura_2
1587	taitoluodikko-turnaus	hammaspeikkoseura_2
1588	taitoluodikko-turnaus	hammaspeikkoseura_2
1589	taitoluodikko-turnaus	hammaspeikkoseura_3
1590	taitoluodikko-turnaus	hammaspeikkoseura_3
1591	taitoluodikko-turnaus	hammaspeikkoseura_3
1592	taitoluodikko-turnaus	hammaspeikkoseura_3
1593	taitoluodikko-turnaus	hammaspeikkoseura_3
1594	taitoluodikko-turnaus	dog_1
1595	taitoluodikko-turnaus	dog_1
1596	taitoluodikko-turnaus	dog_1
1597	taitoluodikko-turnaus	dog_1
1598	taitoluodikko-turnaus	dog_1
1599	taitoluodikko-turnaus	dog_2
1600	taitoluodikko-turnaus	dog_2
1601	taitoluodikko-turnaus	dog_2
1602	taitoluodikko-turnaus	dog_2
1603	taitoluodikko-turnaus	dog_2
1604	taitoluodikko-turnaus	dog_3
1605	taitoluodikko-turnaus	dog_3
1606	taitoluodikko-turnaus	dog_3
1607	taitoluodikko-turnaus	savu_seura_1
1608	taitoluodikko-turnaus	savu_seura_1
1609	taitoluodikko-turnaus	savu_seura_1
1610	taitoluodikko-turnaus	savu_seura_2
1611	taitoluodikko-turnaus	savu_seura_2
1612	taitoluodikko-turnaus	savu_seura_2
1613	taitoluodikko-turnaus	savu_seura_2
1614	taitoluodikko-turnaus	omas_1
1615	taitoluodikko-turnaus	omas_1
1616	taitoluodikko-turnaus	omas_1
1617	taitoluodikko-turnaus	omas_2
1618	taitoluodikko-turnaus	omas_2
1619	taitoluodikko-turnaus	omas_2
1620	taitoluodikko-turnaus	omas_2
1621	taitoluodikko-turnaus	pelleseura_1
1622	taitoluodikko-turnaus	pelleseura_1
1623	taitoluodikko-turnaus	pelleseura_1
1624	taitoluodikko-turnaus	pelleseura_1
1625	taitoluodikko-turnaus	pelleseura_2
1626	taitoluodikko-turnaus	pelleseura_2
1627	taitoluodikko-turnaus	pelleseura_2
1628	taitoluodikko-turnaus	pelleseura_2
1629	taitoluodikko-turnaus	pelleseura_3
1630	taitoluodikko-turnaus	pelleseura_3
1631	taitoluodikko-turnaus	pelleseura_3
1632	taitoluodikko-turnaus	pelleseura_3
1633	taitoluodikko-turnaus	pelleseura_3
1634	taitoluodikko-turnaus	yung_tallent_1
1635	taitoluodikko-turnaus	yung_tallent_1
1636	taitoluodikko-turnaus	yung_tallent_1
1637	taitoluodikko-turnaus	yung_tallent_1
1638	taitoluodikko-turnaus	yung_tallent_2
1639	taitoluodikko-turnaus	yung_tallent_2
1640	taitoluodikko-turnaus	yung_tallent_2
1641	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
1642	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
1643	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
1644	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
1645	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
1646	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
1647	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
1648	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
1649	taitoluodikko-turnaus	tahtaysmestarit_1
1650	taitoluodikko-turnaus	tahtaysmestarit_1
1651	taitoluodikko-turnaus	tahtaysmestarit_1
1652	taitoluodikko-turnaus	tahtaysmestarit_1
1653	taitoluodikko-turnaus	tahtaysmestarit_2
1654	taitoluodikko-turnaus	tahtaysmestarit_2
1655	taitoluodikko-turnaus	tahtaysmestarit_2
1656	taitoluodikko-turnaus	tahtaysmestarit_2
1657	taitoluodikko-turnaus	tahtaysmestarit_3
1658	taitoluodikko-turnaus	tahtaysmestarit_3
1659	taitoluodikko-turnaus	tahtaysmestarit_3
1660	taitoluodikko-turnaus	tahtaysmestarit_3
1661	taitoluodikko-turnaus	tahtaysmestarit_3
1662	taitoluodikko-turnaus	laukausryhma_aurora_1
1663	taitoluodikko-turnaus	laukausryhma_aurora_1
1664	taitoluodikko-turnaus	laukausryhma_aurora_1
1665	taitoluodikko-turnaus	laukausryhma_aurora_1
1666	taitoluodikko-turnaus	laukausryhma_aurora_2
1667	taitoluodikko-turnaus	laukausryhma_aurora_2
1668	taitoluodikko-turnaus	laukausryhma_aurora_2
1669	taitoluodikko-turnaus	ampumataito_1
1670	taitoluodikko-turnaus	ampumataito_1
1671	taitoluodikko-turnaus	ampumataito_1
1672	taitoluodikko-turnaus	ampumataito_1
1673	taitoluodikko-turnaus	ampumataito_2
1674	taitoluodikko-turnaus	ampumataito_2
1675	taitoluodikko-turnaus	ampumataito_2
1676	taitoluodikko-turnaus	ampumataito_2
1677	taitoluodikko-turnaus	ampumataito_2
1678	precision_pistol_cup	poliisiseura_1
1679	precision_pistol_cup	poliisiseura_1
1680	precision_pistol_cup	poliisiseura_1
1681	precision_pistol_cup	poliisiseura_1
1682	precision_pistol_cup	poliisiseura_2
1683	precision_pistol_cup	poliisiseura_2
1684	precision_pistol_cup	poliisiseura_2
1685	precision_pistol_cup	poliisiseura_2
1686	precision_pistol_cup	koiraseura_1
1687	precision_pistol_cup	koiraseura_1
1688	precision_pistol_cup	koiraseura_1
1689	precision_pistol_cup	koiraseura_1
1690	precision_pistol_cup	koiraseura_2
1691	precision_pistol_cup	koiraseura_2
1692	precision_pistol_cup	koiraseura_2
1693	precision_pistol_cup	hammaspeikkoseura_1
1694	precision_pistol_cup	hammaspeikkoseura_1
1695	precision_pistol_cup	hammaspeikkoseura_1
1696	precision_pistol_cup	hammaspeikkoseura_1
1697	precision_pistol_cup	hammaspeikkoseura_1
1698	precision_pistol_cup	hammaspeikkoseura_2
1699	precision_pistol_cup	hammaspeikkoseura_2
1700	precision_pistol_cup	hammaspeikkoseura_2
1701	precision_pistol_cup	hammaspeikkoseura_3
1702	precision_pistol_cup	hammaspeikkoseura_3
1703	precision_pistol_cup	hammaspeikkoseura_3
1704	precision_pistol_cup	dog_1
1705	precision_pistol_cup	dog_1
1706	precision_pistol_cup	dog_1
1707	precision_pistol_cup	dog_1
1708	precision_pistol_cup	dog_2
1709	precision_pistol_cup	dog_2
1710	precision_pistol_cup	dog_2
1711	precision_pistol_cup	dog_2
1712	precision_pistol_cup	savu_seura_1
1713	precision_pistol_cup	savu_seura_1
1714	precision_pistol_cup	savu_seura_1
1715	precision_pistol_cup	savu_seura_1
1716	precision_pistol_cup	savu_seura_1
1717	precision_pistol_cup	savu_seura_2
1718	precision_pistol_cup	savu_seura_2
1719	precision_pistol_cup	savu_seura_2
1720	precision_pistol_cup	savu_seura_2
1721	precision_pistol_cup	savu_seura_2
1722	precision_pistol_cup	savu_seura_3
1723	precision_pistol_cup	savu_seura_3
1724	precision_pistol_cup	savu_seura_3
1725	precision_pistol_cup	savu_seura_3
1726	precision_pistol_cup	savu_seura_3
1727	precision_pistol_cup	omas_1
1728	precision_pistol_cup	omas_1
1729	precision_pistol_cup	omas_1
1730	precision_pistol_cup	pelleseura_1
1731	precision_pistol_cup	pelleseura_1
1732	precision_pistol_cup	pelleseura_1
1733	precision_pistol_cup	pelleseura_2
1734	precision_pistol_cup	pelleseura_2
1735	precision_pistol_cup	pelleseura_2
1736	precision_pistol_cup	pelleseura_2
1737	precision_pistol_cup	pelleseura_2
1738	precision_pistol_cup	yung_tallent_1
1739	precision_pistol_cup	yung_tallent_1
1740	precision_pistol_cup	yung_tallent_1
1741	precision_pistol_cup	yung_tallent_2
1742	precision_pistol_cup	yung_tallent_2
1743	precision_pistol_cup	yung_tallent_2
1744	precision_pistol_cup	yung_tallent_3
1745	precision_pistol_cup	yung_tallent_3
1746	precision_pistol_cup	yung_tallent_3
1747	precision_pistol_cup	yung_tallent_3
1748	precision_pistol_cup	yung_tallent_3
1749	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
1750	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
1751	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
1752	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
1753	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
1754	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
1755	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
1756	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
1757	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
1758	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
1759	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
1760	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
1761	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
1762	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
1763	precision_pistol_cup	tahtaysmestarit_1
1764	precision_pistol_cup	tahtaysmestarit_1
1765	precision_pistol_cup	tahtaysmestarit_1
1766	precision_pistol_cup	tahtaysmestarit_1
1767	precision_pistol_cup	tahtaysmestarit_1
1768	precision_pistol_cup	laukausryhma_aurora_1
1769	precision_pistol_cup	laukausryhma_aurora_1
1770	precision_pistol_cup	laukausryhma_aurora_1
1771	precision_pistol_cup	laukausryhma_aurora_1
1772	precision_pistol_cup	laukausryhma_aurora_2
1773	precision_pistol_cup	laukausryhma_aurora_2
1774	precision_pistol_cup	laukausryhma_aurora_2
1775	precision_pistol_cup	laukausryhma_aurora_2
1776	precision_pistol_cup	laukausryhma_aurora_2
1777	precision_pistol_cup	laukausryhma_aurora_3
1778	precision_pistol_cup	laukausryhma_aurora_3
1779	precision_pistol_cup	laukausryhma_aurora_3
1780	precision_pistol_cup	laukausryhma_aurora_3
1781	precision_pistol_cup	laukausryhma_aurora_3
1782	precision_pistol_cup	ampumataito_1
1783	precision_pistol_cup	ampumataito_1
1784	precision_pistol_cup	ampumataito_1
1785	precision_pistol_cup	ampumataito_1
1786	precision_pistol_cup	ampumataito_1
1787	tulevaisuuden_ampuja	poliisiseura_1
1788	tulevaisuuden_ampuja	poliisiseura_1
1789	tulevaisuuden_ampuja	poliisiseura_1
1790	tulevaisuuden_ampuja	koiraseura_1
1791	tulevaisuuden_ampuja	koiraseura_1
1792	tulevaisuuden_ampuja	koiraseura_1
1793	tulevaisuuden_ampuja	koiraseura_1
1794	tulevaisuuden_ampuja	koiraseura_1
1795	tulevaisuuden_ampuja	hammaspeikkoseura_1
1796	tulevaisuuden_ampuja	hammaspeikkoseura_1
1797	tulevaisuuden_ampuja	hammaspeikkoseura_1
1798	tulevaisuuden_ampuja	hammaspeikkoseura_1
1799	tulevaisuuden_ampuja	hammaspeikkoseura_2
1800	tulevaisuuden_ampuja	hammaspeikkoseura_2
1801	tulevaisuuden_ampuja	hammaspeikkoseura_2
1802	tulevaisuuden_ampuja	hammaspeikkoseura_2
1803	tulevaisuuden_ampuja	hammaspeikkoseura_3
1804	tulevaisuuden_ampuja	hammaspeikkoseura_3
1805	tulevaisuuden_ampuja	hammaspeikkoseura_3
1806	tulevaisuuden_ampuja	dog_1
1807	tulevaisuuden_ampuja	dog_1
1808	tulevaisuuden_ampuja	dog_1
1809	tulevaisuuden_ampuja	dog_1
1810	tulevaisuuden_ampuja	savu_seura_1
1811	tulevaisuuden_ampuja	savu_seura_1
1812	tulevaisuuden_ampuja	savu_seura_1
1813	tulevaisuuden_ampuja	savu_seura_1
1814	tulevaisuuden_ampuja	savu_seura_2
1815	tulevaisuuden_ampuja	savu_seura_2
1816	tulevaisuuden_ampuja	savu_seura_2
1817	tulevaisuuden_ampuja	savu_seura_2
1818	tulevaisuuden_ampuja	savu_seura_2
1819	tulevaisuuden_ampuja	savu_seura_3
1820	tulevaisuuden_ampuja	savu_seura_3
1821	tulevaisuuden_ampuja	savu_seura_3
1822	tulevaisuuden_ampuja	omas_1
1823	tulevaisuuden_ampuja	omas_1
1824	tulevaisuuden_ampuja	omas_1
1825	tulevaisuuden_ampuja	omas_1
1826	tulevaisuuden_ampuja	omas_1
1827	tulevaisuuden_ampuja	pelleseura_1
1828	tulevaisuuden_ampuja	pelleseura_1
1829	tulevaisuuden_ampuja	pelleseura_1
1830	tulevaisuuden_ampuja	pelleseura_1
1831	tulevaisuuden_ampuja	pelleseura_1
1832	tulevaisuuden_ampuja	pelleseura_2
1833	tulevaisuuden_ampuja	pelleseura_2
1834	tulevaisuuden_ampuja	pelleseura_2
1835	tulevaisuuden_ampuja	yung_tallent_1
1836	tulevaisuuden_ampuja	yung_tallent_1
1837	tulevaisuuden_ampuja	yung_tallent_1
1838	tulevaisuuden_ampuja	yung_tallent_1
1839	tulevaisuuden_ampuja	yung_tallent_1
1840	tulevaisuuden_ampuja	yung_tallent_2
1841	tulevaisuuden_ampuja	yung_tallent_2
1842	tulevaisuuden_ampuja	yung_tallent_2
1843	tulevaisuuden_ampuja	yung_tallent_2
1844	tulevaisuuden_ampuja	yung_tallent_2
1845	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_1
1846	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_1
1847	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_1
1848	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
1849	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
1850	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
1851	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
1852	tulevaisuuden_ampuja	tahtaysmestarit_1
1853	tulevaisuuden_ampuja	tahtaysmestarit_1
1854	tulevaisuuden_ampuja	tahtaysmestarit_1
1855	tulevaisuuden_ampuja	tahtaysmestarit_2
1856	tulevaisuuden_ampuja	tahtaysmestarit_2
1857	tulevaisuuden_ampuja	tahtaysmestarit_2
1858	tulevaisuuden_ampuja	tahtaysmestarit_2
1859	tulevaisuuden_ampuja	tahtaysmestarit_3
1860	tulevaisuuden_ampuja	tahtaysmestarit_3
1861	tulevaisuuden_ampuja	tahtaysmestarit_3
1862	tulevaisuuden_ampuja	tahtaysmestarit_3
1863	tulevaisuuden_ampuja	laukausryhma_aurora_1
1864	tulevaisuuden_ampuja	laukausryhma_aurora_1
1865	tulevaisuuden_ampuja	laukausryhma_aurora_1
1866	tulevaisuuden_ampuja	laukausryhma_aurora_1
1867	tulevaisuuden_ampuja	laukausryhma_aurora_2
1868	tulevaisuuden_ampuja	laukausryhma_aurora_2
1869	tulevaisuuden_ampuja	laukausryhma_aurora_2
1870	tulevaisuuden_ampuja	laukausryhma_aurora_3
1871	tulevaisuuden_ampuja	laukausryhma_aurora_3
1872	tulevaisuuden_ampuja	laukausryhma_aurora_3
1873	tulevaisuuden_ampuja	ampumataito_1
1874	tulevaisuuden_ampuja	ampumataito_1
1875	tulevaisuuden_ampuja	ampumataito_1
1876	tulevaisuuden_ampuja	ampumataito_1
1877	pikakivaari-klassikko	poliisiseura_1
1878	pikakivaari-klassikko	poliisiseura_1
1879	pikakivaari-klassikko	poliisiseura_1
1880	pikakivaari-klassikko	poliisiseura_1
1881	pikakivaari-klassikko	poliisiseura_1
1882	pikakivaari-klassikko	poliisiseura_2
1883	pikakivaari-klassikko	poliisiseura_2
1884	pikakivaari-klassikko	poliisiseura_2
1885	pikakivaari-klassikko	poliisiseura_2
1886	pikakivaari-klassikko	poliisiseura_2
1887	pikakivaari-klassikko	koiraseura_1
1888	pikakivaari-klassikko	koiraseura_1
1889	pikakivaari-klassikko	koiraseura_1
1890	pikakivaari-klassikko	koiraseura_2
1891	pikakivaari-klassikko	koiraseura_2
1892	pikakivaari-klassikko	koiraseura_2
1893	pikakivaari-klassikko	koiraseura_3
1894	pikakivaari-klassikko	koiraseura_3
1895	pikakivaari-klassikko	koiraseura_3
1896	pikakivaari-klassikko	hammaspeikkoseura_1
1897	pikakivaari-klassikko	hammaspeikkoseura_1
1898	pikakivaari-klassikko	hammaspeikkoseura_1
1899	pikakivaari-klassikko	hammaspeikkoseura_1
1900	pikakivaari-klassikko	hammaspeikkoseura_2
1901	pikakivaari-klassikko	hammaspeikkoseura_2
1902	pikakivaari-klassikko	hammaspeikkoseura_2
1903	pikakivaari-klassikko	hammaspeikkoseura_2
1904	pikakivaari-klassikko	hammaspeikkoseura_2
1905	pikakivaari-klassikko	hammaspeikkoseura_3
1906	pikakivaari-klassikko	hammaspeikkoseura_3
1907	pikakivaari-klassikko	hammaspeikkoseura_3
1908	pikakivaari-klassikko	dog_1
1909	pikakivaari-klassikko	dog_1
1910	pikakivaari-klassikko	dog_1
1911	pikakivaari-klassikko	dog_1
1912	pikakivaari-klassikko	savu_seura_1
1913	pikakivaari-klassikko	savu_seura_1
1914	pikakivaari-klassikko	savu_seura_1
1915	pikakivaari-klassikko	savu_seura_1
1916	pikakivaari-klassikko	savu_seura_1
1917	pikakivaari-klassikko	savu_seura_2
1918	pikakivaari-klassikko	savu_seura_2
1919	pikakivaari-klassikko	savu_seura_2
1920	pikakivaari-klassikko	savu_seura_3
1921	pikakivaari-klassikko	savu_seura_3
1922	pikakivaari-klassikko	savu_seura_3
1923	pikakivaari-klassikko	omas_1
1924	pikakivaari-klassikko	omas_1
1925	pikakivaari-klassikko	omas_1
1926	pikakivaari-klassikko	omas_2
1927	pikakivaari-klassikko	omas_2
1928	pikakivaari-klassikko	omas_2
1929	pikakivaari-klassikko	omas_2
1930	pikakivaari-klassikko	omas_2
1931	pikakivaari-klassikko	pelleseura_1
1932	pikakivaari-klassikko	pelleseura_1
1933	pikakivaari-klassikko	pelleseura_1
1934	pikakivaari-klassikko	yung_tallent_1
1935	pikakivaari-klassikko	yung_tallent_1
1936	pikakivaari-klassikko	yung_tallent_1
1937	pikakivaari-klassikko	yung_tallent_2
1938	pikakivaari-klassikko	yung_tallent_2
1939	pikakivaari-klassikko	yung_tallent_2
1940	pikakivaari-klassikko	yung_tallent_2
1941	pikakivaari-klassikko	yung_tallent_2
1942	pikakivaari-klassikko	yung_tallent_3
1943	pikakivaari-klassikko	yung_tallent_3
1944	pikakivaari-klassikko	yung_tallent_3
1945	pikakivaari-klassikko	yung_tallent_3
1946	pikakivaari-klassikko	yung_tallent_3
1947	pikakivaari-klassikko	aseharrastajien_yhtenaisyys_1
1948	pikakivaari-klassikko	aseharrastajien_yhtenaisyys_1
1949	pikakivaari-klassikko	aseharrastajien_yhtenaisyys_1
1950	pikakivaari-klassikko	tahtaysmestarit_1
1951	pikakivaari-klassikko	tahtaysmestarit_1
1952	pikakivaari-klassikko	tahtaysmestarit_1
1953	pikakivaari-klassikko	tahtaysmestarit_1
1954	pikakivaari-klassikko	laukausryhma_aurora_1
1955	pikakivaari-klassikko	laukausryhma_aurora_1
1956	pikakivaari-klassikko	laukausryhma_aurora_1
1957	pikakivaari-klassikko	laukausryhma_aurora_2
1958	pikakivaari-klassikko	laukausryhma_aurora_2
1959	pikakivaari-klassikko	laukausryhma_aurora_2
1960	pikakivaari-klassikko	ampumataito_1
1961	pikakivaari-klassikko	ampumataito_1
1962	pikakivaari-klassikko	ampumataito_1
1963	pikakivaari-klassikko	ampumataito_1
1964	pikakivaari-klassikko	ampumataito_1
\.


--
-- Data for Name: team_member_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_member_score (bulls_eye_count, round, sum, creation_date, user_id, competition_id, team_name) FROM stdin;
10	10	306	2024-04-26 13:36:59.726	2	kesan_ampujaiset	poliisiseura_1
10	10	294.9	2024-04-26 13:36:59.75	3	kesan_ampujaiset	poliisiseura_1
10	10	269.7	2024-04-26 13:36:59.766	4	kesan_ampujaiset	poliisiseura_1
10	10	304.5	2024-04-26 13:36:59.781	5	kesan_ampujaiset	poliisiseura_1
10	10	242.3	2024-04-26 13:36:59.799	6	kesan_ampujaiset	poliisiseura_2
10	10	346.5	2024-04-26 13:36:59.818	7	kesan_ampujaiset	poliisiseura_2
10	10	362.2	2024-04-26 13:36:59.835	8	kesan_ampujaiset	poliisiseura_2
10	10	330.8	2024-04-26 13:36:59.85	9	kesan_ampujaiset	poliisiseura_2
10	10	312.7	2024-04-26 13:36:59.869	10	kesan_ampujaiset	poliisiseura_3
10	10	305.9	2024-04-26 13:36:59.885	11	kesan_ampujaiset	poliisiseura_3
10	10	334.4	2024-04-26 13:36:59.9	12	kesan_ampujaiset	poliisiseura_3
10	10	315.8	2024-04-26 13:36:59.914	13	kesan_ampujaiset	koiraseura_1
10	10	342.3	2024-04-26 13:36:59.929	14	kesan_ampujaiset	koiraseura_1
10	10	280	2024-04-26 13:36:59.944	15	kesan_ampujaiset	koiraseura_1
10	10	323.1	2024-04-26 13:36:59.959	16	kesan_ampujaiset	koiraseura_1
10	10	307.9	2024-04-26 13:36:59.973	17	kesan_ampujaiset	koiraseura_1
10	10	313.8	2024-04-26 13:36:59.991	18	kesan_ampujaiset	hammaspeikkoseura_1
10	10	374.5	2024-04-26 13:37:00.007	19	kesan_ampujaiset	hammaspeikkoseura_1
10	10	313.7	2024-04-26 13:37:00.024	20	kesan_ampujaiset	hammaspeikkoseura_1
10	10	359.2	2024-04-26 13:37:00.04	21	kesan_ampujaiset	hammaspeikkoseura_1
10	10	314.8	2024-04-26 13:37:00.055	22	kesan_ampujaiset	hammaspeikkoseura_2
10	10	320.8	2024-04-26 13:37:00.069	23	kesan_ampujaiset	hammaspeikkoseura_2
10	10	316.7	2024-04-26 13:37:00.083	24	kesan_ampujaiset	hammaspeikkoseura_2
10	10	371.2	2024-04-26 13:37:00.096	25	kesan_ampujaiset	dog_1
10	10	302.6	2024-04-26 13:37:00.113	26	kesan_ampujaiset	dog_1
10	10	342.9	2024-04-26 13:37:00.127	27	kesan_ampujaiset	dog_1
10	10	319.2	2024-04-26 13:37:00.143	28	kesan_ampujaiset	dog_1
10	10	302.4	2024-04-26 13:37:00.157	29	kesan_ampujaiset	savu_seura_1
10	10	305	2024-04-26 13:37:00.177	30	kesan_ampujaiset	savu_seura_1
10	10	253.7	2024-04-26 13:37:00.193	31	kesan_ampujaiset	savu_seura_1
10	10	325.3	2024-04-26 13:37:00.209	32	kesan_ampujaiset	savu_seura_1
10	10	339.8	2024-04-26 13:37:00.224	33	kesan_ampujaiset	savu_seura_1
10	10	312	2024-04-26 13:37:00.241	34	kesan_ampujaiset	savu_seura_2
10	10	334.4	2024-04-26 13:37:00.254	35	kesan_ampujaiset	savu_seura_2
10	10	286.3	2024-04-26 13:37:00.269	36	kesan_ampujaiset	savu_seura_2
10	10	345.6	2024-04-26 13:37:00.283	37	kesan_ampujaiset	savu_seura_3
10	10	324.9	2024-04-26 13:37:00.3	38	kesan_ampujaiset	savu_seura_3
10	10	309.4	2024-04-26 13:37:00.317	39	kesan_ampujaiset	savu_seura_3
10	10	269.1	2024-04-26 13:37:00.332	40	kesan_ampujaiset	savu_seura_3
10	10	315.3	2024-04-26 13:37:00.346	41	kesan_ampujaiset	savu_seura_3
10	10	350.9	2024-04-26 13:37:00.362	42	kesan_ampujaiset	omas_1
10	10	343.2	2024-04-26 13:37:00.379	43	kesan_ampujaiset	omas_1
10	10	283	2024-04-26 13:37:00.393	44	kesan_ampujaiset	omas_1
10	10	334.9	2024-04-26 13:37:00.407	45	kesan_ampujaiset	omas_1
10	10	334.4	2024-04-26 13:37:00.425	46	kesan_ampujaiset	pelleseura_1
10	10	331.1	2024-04-26 13:37:00.44	47	kesan_ampujaiset	pelleseura_1
10	10	349.9	2024-04-26 13:37:00.454	48	kesan_ampujaiset	pelleseura_1
10	10	304.8	2024-04-26 13:37:00.468	49	kesan_ampujaiset	yung_tallent_1
10	10	316.7	2024-04-26 13:37:00.483	50	kesan_ampujaiset	yung_tallent_1
10	10	365.9	2024-04-26 13:37:00.497	51	kesan_ampujaiset	yung_tallent_1
10	10	298.6	2024-04-26 13:37:00.512	52	kesan_ampujaiset	aseharrastajien_yhtenaisyys_1
10	10	369.3	2024-04-26 13:37:00.526	53	kesan_ampujaiset	aseharrastajien_yhtenaisyys_1
10	10	267.5	2024-04-26 13:37:00.54	54	kesan_ampujaiset	aseharrastajien_yhtenaisyys_1
10	10	319.1	2024-04-26 13:37:00.556	55	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
10	10	346.9	2024-04-26 13:37:00.57	56	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
10	10	335.5	2024-04-26 13:37:00.586	57	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
10	10	315.9	2024-04-26 13:37:00.602	58	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
10	10	301.2	2024-04-26 13:37:00.618	59	kesan_ampujaiset	aseharrastajien_yhtenaisyys_2
10	10	305.5	2024-04-26 13:37:00.634	60	kesan_ampujaiset	aseharrastajien_yhtenaisyys_3
10	10	301.5	2024-04-26 13:37:00.651	61	kesan_ampujaiset	aseharrastajien_yhtenaisyys_3
10	10	340.8	2024-04-26 13:37:00.667	62	kesan_ampujaiset	aseharrastajien_yhtenaisyys_3
10	10	318.8	2024-04-26 13:37:00.682	63	kesan_ampujaiset	tahtaysmestarit_1
10	10	322.4	2024-04-26 13:37:00.697	64	kesan_ampujaiset	tahtaysmestarit_1
10	10	363.1	2024-04-26 13:37:00.713	65	kesan_ampujaiset	tahtaysmestarit_1
10	10	352.6	2024-04-26 13:37:00.728	66	kesan_ampujaiset	tahtaysmestarit_1
10	10	350.7	2024-04-26 13:37:00.742	67	kesan_ampujaiset	tahtaysmestarit_2
10	10	316.4	2024-04-26 13:37:00.755	68	kesan_ampujaiset	tahtaysmestarit_2
10	10	347.9	2024-04-26 13:37:00.77	69	kesan_ampujaiset	tahtaysmestarit_2
10	10	275.8	2024-04-26 13:37:00.786	70	kesan_ampujaiset	tahtaysmestarit_2
10	10	311	2024-04-26 13:37:00.801	71	kesan_ampujaiset	tahtaysmestarit_3
10	10	318.2	2024-04-26 13:37:00.815	72	kesan_ampujaiset	tahtaysmestarit_3
10	10	310.9	2024-04-26 13:37:00.833	73	kesan_ampujaiset	tahtaysmestarit_3
10	10	301.1	2024-04-26 13:37:00.849	74	kesan_ampujaiset	tahtaysmestarit_3
10	10	339.1	2024-04-26 13:37:00.864	75	kesan_ampujaiset	laukausryhma_aurora_1
10	10	317.4	2024-04-26 13:37:00.88	76	kesan_ampujaiset	laukausryhma_aurora_1
10	10	350.8	2024-04-26 13:37:00.897	77	kesan_ampujaiset	laukausryhma_aurora_1
10	10	338.8	2024-04-26 13:37:00.909	78	kesan_ampujaiset	ampumataito_1
10	10	330.9	2024-04-26 13:37:00.924	79	kesan_ampujaiset	ampumataito_1
10	10	279.9	2024-04-26 13:37:00.938	80	kesan_ampujaiset	ampumataito_1
10	10	314.9	2024-04-26 13:37:00.953	81	kesan_ampujaiset	ampumataito_1
10	10	343.1	2024-04-26 13:37:00.968	82	kesan_ampujaiset	ampumataito_1
10	10	292.9	2024-04-26 13:37:00.983	83	kesan_ampujaiset	ampumataito_2
10	10	337	2024-04-26 13:37:00.999	84	kesan_ampujaiset	ampumataito_2
10	10	294.9	2024-04-26 13:37:01.016	85	kesan_ampujaiset	ampumataito_2
10	10	326	2024-04-26 13:37:01.032	86	kesan_ampujaiset	ampumataito_2
10	10	280	2024-04-26 13:37:01.049	87	kesan_ampujaiset	ampumataito_2
10	10	318.3	2024-04-26 13:37:01.065	88	kesan_ampujaiset	ampumataito_3
10	10	322.9	2024-04-26 13:37:01.084	89	kesan_ampujaiset	ampumataito_3
10	10	259.7	2024-04-26 13:37:01.099	90	kesan_ampujaiset	ampumataito_3
10	10	330.4	2024-04-26 13:37:01.114	91	kesan_ampujaiset	ampumataito_3
10	10	317.6	2024-04-26 13:37:01.13	92	kesan_ampujaiset	ampumataito_3
10	10	328.9	2024-04-26 13:37:01.147	93	talvi_pistooli	poliisiseura_1
10	10	290.8	2024-04-26 13:37:01.163	94	talvi_pistooli	poliisiseura_1
10	10	305.6	2024-04-26 13:37:01.178	95	talvi_pistooli	poliisiseura_1
10	10	307.1	2024-04-26 13:37:01.192	96	talvi_pistooli	poliisiseura_1
10	10	236.7	2024-04-26 13:37:01.208	97	talvi_pistooli	poliisiseura_1
10	10	342	2024-04-26 13:37:01.223	98	talvi_pistooli	poliisiseura_2
10	10	367.3	2024-04-26 13:37:01.238	99	talvi_pistooli	poliisiseura_2
10	10	362.7	2024-04-26 13:37:01.256	100	talvi_pistooli	poliisiseura_2
10	10	359.4	2024-04-26 13:37:01.273	101	talvi_pistooli	poliisiseura_2
10	10	319.8	2024-04-26 13:37:01.29	102	talvi_pistooli	koiraseura_1
10	10	343.7	2024-04-26 13:37:01.307	103	talvi_pistooli	koiraseura_1
10	10	334	2024-04-26 13:37:01.327	104	talvi_pistooli	koiraseura_1
10	10	346.6	2024-04-26 13:37:01.343	105	talvi_pistooli	koiraseura_1
10	10	316.9	2024-04-26 13:37:01.36	106	talvi_pistooli	hammaspeikkoseura_1
10	10	338.9	2024-04-26 13:37:01.376	107	talvi_pistooli	hammaspeikkoseura_1
10	10	352.3	2024-04-26 13:37:01.394	108	talvi_pistooli	hammaspeikkoseura_1
10	10	344.3	2024-04-26 13:37:01.408	109	talvi_pistooli	hammaspeikkoseura_2
10	10	352.3	2024-04-26 13:37:01.422	110	talvi_pistooli	hammaspeikkoseura_2
10	10	317.4	2024-04-26 13:37:01.446	111	talvi_pistooli	hammaspeikkoseura_2
10	10	332.7	2024-04-26 13:37:01.472	112	talvi_pistooli	hammaspeikkoseura_2
10	10	279.8	2024-04-26 13:37:01.495	113	talvi_pistooli	dog_1
10	10	361.3	2024-04-26 13:37:01.516	114	talvi_pistooli	dog_1
10	10	319.2	2024-04-26 13:37:01.531	115	talvi_pistooli	dog_1
10	10	264.1	2024-04-26 13:37:01.546	116	talvi_pistooli	dog_1
10	10	341.6	2024-04-26 13:37:01.561	117	talvi_pistooli	dog_2
10	10	350.6	2024-04-26 13:37:01.577	118	talvi_pistooli	dog_2
10	10	326.2	2024-04-26 13:37:01.592	119	talvi_pistooli	dog_2
10	10	281.5	2024-04-26 13:37:01.607	120	talvi_pistooli	dog_2
10	10	331.9	2024-04-26 13:37:01.621	121	talvi_pistooli	dog_2
10	10	345.1	2024-04-26 13:37:01.636	122	talvi_pistooli	savu_seura_1
10	10	317.6	2024-04-26 13:37:01.65	123	talvi_pistooli	savu_seura_1
10	10	366.2	2024-04-26 13:37:01.663	124	talvi_pistooli	savu_seura_1
10	10	297	2024-04-26 13:37:01.676	125	talvi_pistooli	savu_seura_1
10	10	376.5	2024-04-26 13:37:01.692	126	talvi_pistooli	savu_seura_1
10	10	308.5	2024-04-26 13:37:01.708	127	talvi_pistooli	savu_seura_2
10	10	312.5	2024-04-26 13:37:01.722	128	talvi_pistooli	savu_seura_2
10	10	247.3	2024-04-26 13:37:01.735	129	talvi_pistooli	savu_seura_2
10	10	347.6	2024-04-26 13:37:01.751	130	talvi_pistooli	omas_1
10	10	376.5	2024-04-26 13:37:01.765	131	talvi_pistooli	omas_1
10	10	343.5	2024-04-26 13:37:01.778	132	talvi_pistooli	omas_1
10	10	274.7	2024-04-26 13:37:01.791	133	talvi_pistooli	omas_1
10	10	335.1	2024-04-26 13:37:01.806	134	talvi_pistooli	omas_1
10	10	309.8	2024-04-26 13:37:01.821	135	talvi_pistooli	omas_2
10	10	323.9	2024-04-26 13:37:01.835	136	talvi_pistooli	omas_2
10	10	317.6	2024-04-26 13:37:01.848	137	talvi_pistooli	omas_2
10	10	320.2	2024-04-26 13:37:01.862	138	talvi_pistooli	omas_2
10	10	333.9	2024-04-26 13:37:01.878	139	talvi_pistooli	omas_2
10	10	312.6	2024-04-26 13:37:01.891	140	talvi_pistooli	omas_3
10	10	290.1	2024-04-26 13:37:01.905	141	talvi_pistooli	omas_3
10	10	332.1	2024-04-26 13:37:01.917	142	talvi_pistooli	omas_3
10	10	288.3	2024-04-26 13:37:01.932	143	talvi_pistooli	omas_3
10	10	346.4	2024-04-26 13:37:01.947	144	talvi_pistooli	omas_3
10	10	376.1	2024-04-26 13:37:01.961	145	talvi_pistooli	pelleseura_1
10	10	301.2	2024-04-26 13:37:01.975	146	talvi_pistooli	pelleseura_1
10	10	293.8	2024-04-26 13:37:01.99	147	talvi_pistooli	pelleseura_1
10	10	281.1	2024-04-26 13:37:02.005	148	talvi_pistooli	pelleseura_1
10	10	316.6	2024-04-26 13:37:02.019	149	talvi_pistooli	pelleseura_2
10	10	304.1	2024-04-26 13:37:02.032	150	talvi_pistooli	pelleseura_2
10	10	338.9	2024-04-26 13:37:02.045	151	talvi_pistooli	pelleseura_2
10	10	363.7	2024-04-26 13:37:02.06	152	talvi_pistooli	pelleseura_2
10	10	297.6	2024-04-26 13:37:02.073	153	talvi_pistooli	pelleseura_3
10	10	355.8	2024-04-26 13:37:02.086	154	talvi_pistooli	pelleseura_3
10	10	331.2	2024-04-26 13:37:02.1	155	talvi_pistooli	pelleseura_3
10	10	320.2	2024-04-26 13:37:02.112	156	talvi_pistooli	pelleseura_3
10	10	300.6	2024-04-26 13:37:02.127	157	talvi_pistooli	yung_tallent_1
10	10	288.3	2024-04-26 13:37:02.14	158	talvi_pistooli	yung_tallent_1
10	10	378.5	2024-04-26 13:37:02.153	159	talvi_pistooli	yung_tallent_1
10	10	324.2	2024-04-26 13:37:02.168	160	talvi_pistooli	yung_tallent_1
10	10	309.6	2024-04-26 13:37:02.182	161	talvi_pistooli	yung_tallent_2
10	10	319.4	2024-04-26 13:37:02.195	162	talvi_pistooli	yung_tallent_2
10	10	309.7	2024-04-26 13:37:02.21	163	talvi_pistooli	yung_tallent_2
10	10	365.8	2024-04-26 13:37:02.223	164	talvi_pistooli	yung_tallent_2
10	10	316	2024-04-26 13:37:02.235	165	talvi_pistooli	yung_tallent_2
10	10	292.8	2024-04-26 13:37:02.251	166	talvi_pistooli	yung_tallent_3
10	10	326.4	2024-04-26 13:37:02.264	167	talvi_pistooli	yung_tallent_3
10	10	323.6	2024-04-26 13:37:02.277	168	talvi_pistooli	yung_tallent_3
10	10	356.8	2024-04-26 13:37:02.291	169	talvi_pistooli	yung_tallent_3
10	10	366	2024-04-26 13:37:02.307	170	talvi_pistooli	aseharrastajien_yhtenaisyys_1
10	10	300.1	2024-04-26 13:37:02.321	171	talvi_pistooli	aseharrastajien_yhtenaisyys_1
10	10	335.6	2024-04-26 13:37:02.334	172	talvi_pistooli	aseharrastajien_yhtenaisyys_1
10	10	302.8	2024-04-26 13:37:02.347	173	talvi_pistooli	aseharrastajien_yhtenaisyys_1
10	10	323.9	2024-04-26 13:37:02.361	174	talvi_pistooli	tahtaysmestarit_1
10	10	276.7	2024-04-26 13:37:02.375	175	talvi_pistooli	tahtaysmestarit_1
10	10	319.2	2024-04-26 13:37:02.388	176	talvi_pistooli	tahtaysmestarit_1
10	10	350.7	2024-04-26 13:37:02.401	177	talvi_pistooli	tahtaysmestarit_1
10	10	321.8	2024-04-26 13:37:02.416	178	talvi_pistooli	tahtaysmestarit_1
10	10	308.4	2024-04-26 13:37:02.432	179	talvi_pistooli	tahtaysmestarit_2
10	10	365.2	2024-04-26 13:37:02.447	180	talvi_pistooli	tahtaysmestarit_2
10	10	321.3	2024-04-26 13:37:02.461	181	talvi_pistooli	tahtaysmestarit_2
10	10	347	2024-04-26 13:37:02.475	182	talvi_pistooli	tahtaysmestarit_3
10	10	363	2024-04-26 13:37:02.491	183	talvi_pistooli	tahtaysmestarit_3
10	10	351.9	2024-04-26 13:37:02.504	184	talvi_pistooli	tahtaysmestarit_3
10	10	336.2	2024-04-26 13:37:02.517	185	talvi_pistooli	tahtaysmestarit_3
10	10	326.1	2024-04-26 13:37:02.529	186	talvi_pistooli	tahtaysmestarit_3
10	10	324.4	2024-04-26 13:37:02.543	187	talvi_pistooli	laukausryhma_aurora_1
10	10	346.4	2024-04-26 13:37:02.557	188	talvi_pistooli	laukausryhma_aurora_1
10	10	296.6	2024-04-26 13:37:02.57	189	talvi_pistooli	laukausryhma_aurora_1
10	10	296.2	2024-04-26 13:37:02.583	190	talvi_pistooli	ampumataito_1
10	10	328.3	2024-04-26 13:37:02.597	191	talvi_pistooli	ampumataito_1
10	10	341.2	2024-04-26 13:37:02.613	192	talvi_pistooli	ampumataito_1
10	10	322.9	2024-04-26 13:37:02.626	193	talvi_pistooli	ampumataito_1
10	10	320.6	2024-04-26 13:37:02.639	194	talvi_pistooli	ampumataito_2
10	10	316	2024-04-26 13:37:02.651	195	talvi_pistooli	ampumataito_2
10	10	339.2	2024-04-26 13:37:02.665	196	talvi_pistooli	ampumataito_2
10	10	315.8	2024-04-26 13:37:02.679	197	tarkkuuslaukaus-festivaali	poliisiseura_1
10	10	348	2024-04-26 13:37:02.692	198	tarkkuuslaukaus-festivaali	poliisiseura_1
10	10	364.4	2024-04-26 13:37:02.705	199	tarkkuuslaukaus-festivaali	poliisiseura_1
10	10	387	2024-04-26 13:37:02.718	200	tarkkuuslaukaus-festivaali	poliisiseura_1
10	10	332.9	2024-04-26 13:37:02.733	201	tarkkuuslaukaus-festivaali	poliisiseura_2
10	10	326.3	2024-04-26 13:37:02.746	202	tarkkuuslaukaus-festivaali	poliisiseura_2
10	10	312.6	2024-04-26 13:37:02.758	203	tarkkuuslaukaus-festivaali	poliisiseura_2
10	10	351.1	2024-04-26 13:37:02.77	204	tarkkuuslaukaus-festivaali	poliisiseura_3
10	10	337.3	2024-04-26 13:37:02.783	205	tarkkuuslaukaus-festivaali	poliisiseura_3
10	10	308.6	2024-04-26 13:37:02.797	206	tarkkuuslaukaus-festivaali	poliisiseura_3
10	10	313.2	2024-04-26 13:37:02.811	207	tarkkuuslaukaus-festivaali	poliisiseura_3
10	10	295	2024-04-26 13:37:02.823	208	tarkkuuslaukaus-festivaali	poliisiseura_3
10	10	314.8	2024-04-26 13:37:02.836	209	tarkkuuslaukaus-festivaali	koiraseura_1
10	10	306.9	2024-04-26 13:37:02.851	210	tarkkuuslaukaus-festivaali	koiraseura_1
10	10	265.1	2024-04-26 13:37:02.865	211	tarkkuuslaukaus-festivaali	koiraseura_1
10	10	330.9	2024-04-26 13:37:02.879	212	tarkkuuslaukaus-festivaali	koiraseura_1
10	10	281	2024-04-26 13:37:02.891	213	tarkkuuslaukaus-festivaali	koiraseura_1
10	10	372.3	2024-04-26 13:37:02.904	214	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
10	10	383.9	2024-04-26 13:37:02.918	215	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
10	10	350.2	2024-04-26 13:37:02.931	216	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
10	10	348.1	2024-04-26 13:37:02.942	217	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
10	10	257.8	2024-04-26 13:37:02.955	218	tarkkuuslaukaus-festivaali	hammaspeikkoseura_1
10	10	281.8	2024-04-26 13:37:02.967	219	tarkkuuslaukaus-festivaali	dog_1
10	10	340.1	2024-04-26 13:37:02.981	220	tarkkuuslaukaus-festivaali	dog_1
10	10	292.2	2024-04-26 13:37:02.994	221	tarkkuuslaukaus-festivaali	dog_1
10	10	322.8	2024-04-26 13:37:03.006	222	tarkkuuslaukaus-festivaali	savu_seura_1
10	10	324.1	2024-04-26 13:37:03.019	223	tarkkuuslaukaus-festivaali	savu_seura_1
10	10	331	2024-04-26 13:37:03.033	224	tarkkuuslaukaus-festivaali	savu_seura_1
10	10	282.5	2024-04-26 13:37:03.048	225	tarkkuuslaukaus-festivaali	savu_seura_1
10	10	337.5	2024-04-26 13:37:03.06	226	tarkkuuslaukaus-festivaali	savu_seura_1
10	10	289.4	2024-04-26 13:37:03.073	227	tarkkuuslaukaus-festivaali	omas_1
10	10	327.7	2024-04-26 13:37:03.085	228	tarkkuuslaukaus-festivaali	omas_1
10	10	306.5	2024-04-26 13:37:03.098	229	tarkkuuslaukaus-festivaali	omas_1
10	10	265.6	2024-04-26 13:37:03.112	230	tarkkuuslaukaus-festivaali	omas_1
10	10	324.5	2024-04-26 13:37:03.124	231	tarkkuuslaukaus-festivaali	omas_2
10	10	351.3	2024-04-26 13:37:03.135	232	tarkkuuslaukaus-festivaali	omas_2
10	10	302.8	2024-04-26 13:37:03.15	233	tarkkuuslaukaus-festivaali	omas_2
10	10	334.3	2024-04-26 13:37:03.164	234	tarkkuuslaukaus-festivaali	omas_3
10	10	334.6	2024-04-26 13:37:03.177	235	tarkkuuslaukaus-festivaali	omas_3
10	10	338.6	2024-04-26 13:37:03.189	236	tarkkuuslaukaus-festivaali	omas_3
10	10	341.4	2024-04-26 13:37:03.201	237	tarkkuuslaukaus-festivaali	omas_3
10	10	308.4	2024-04-26 13:37:03.213	238	tarkkuuslaukaus-festivaali	pelleseura_1
10	10	296.9	2024-04-26 13:37:03.228	239	tarkkuuslaukaus-festivaali	pelleseura_1
10	10	349.6	2024-04-26 13:37:03.24	240	tarkkuuslaukaus-festivaali	pelleseura_1
10	10	323.4	2024-04-26 13:37:03.253	241	tarkkuuslaukaus-festivaali	pelleseura_1
10	10	347.7	2024-04-26 13:37:03.266	242	tarkkuuslaukaus-festivaali	pelleseura_2
10	10	331.4	2024-04-26 13:37:03.288	243	tarkkuuslaukaus-festivaali	pelleseura_2
10	10	388.9	2024-04-26 13:37:03.304	244	tarkkuuslaukaus-festivaali	pelleseura_2
10	10	304.9	2024-04-26 13:37:03.323	245	tarkkuuslaukaus-festivaali	pelleseura_2
10	10	352.2	2024-04-26 13:37:03.339	246	tarkkuuslaukaus-festivaali	pelleseura_2
10	10	326.9	2024-04-26 13:37:03.355	247	tarkkuuslaukaus-festivaali	pelleseura_3
10	10	304.4	2024-04-26 13:37:03.367	248	tarkkuuslaukaus-festivaali	pelleseura_3
10	10	364.5	2024-04-26 13:37:03.38	249	tarkkuuslaukaus-festivaali	pelleseura_3
10	10	313.1	2024-04-26 13:37:03.392	250	tarkkuuslaukaus-festivaali	pelleseura_3
10	10	335.8	2024-04-26 13:37:03.405	251	tarkkuuslaukaus-festivaali	pelleseura_3
10	10	336.2	2024-04-26 13:37:03.419	252	tarkkuuslaukaus-festivaali	yung_tallent_1
10	10	374.3	2024-04-26 13:37:03.431	253	tarkkuuslaukaus-festivaali	yung_tallent_1
10	10	350.9	2024-04-26 13:37:03.443	254	tarkkuuslaukaus-festivaali	yung_tallent_1
10	10	339.7	2024-04-26 13:37:03.456	255	tarkkuuslaukaus-festivaali	yung_tallent_2
10	10	287	2024-04-26 13:37:03.469	256	tarkkuuslaukaus-festivaali	yung_tallent_2
10	10	333.4	2024-04-26 13:37:03.483	257	tarkkuuslaukaus-festivaali	yung_tallent_2
10	10	343.3	2024-04-26 13:37:03.497	258	tarkkuuslaukaus-festivaali	yung_tallent_2
10	10	333.6	2024-04-26 13:37:03.511	259	tarkkuuslaukaus-festivaali	yung_tallent_2
10	10	326.9	2024-04-26 13:37:03.525	260	tarkkuuslaukaus-festivaali	yung_tallent_3
10	10	361.7	2024-04-26 13:37:03.539	261	tarkkuuslaukaus-festivaali	yung_tallent_3
10	10	334.2	2024-04-26 13:37:03.552	262	tarkkuuslaukaus-festivaali	yung_tallent_3
10	10	353.9	2024-04-26 13:37:03.566	263	tarkkuuslaukaus-festivaali	yung_tallent_3
10	10	392.9	2024-04-26 13:37:03.58	264	tarkkuuslaukaus-festivaali	yung_tallent_3
10	10	288.2	2024-04-26 13:37:03.595	265	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_1
10	10	355.6	2024-04-26 13:37:03.61	266	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_1
10	10	308.8	2024-04-26 13:37:03.623	267	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_1
10	10	345.7	2024-04-26 13:37:03.635	268	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
10	10	333.2	2024-04-26 13:37:03.648	269	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
10	10	333.9	2024-04-26 13:37:03.662	270	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
10	10	355.5	2024-04-26 13:37:03.675	271	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_2
10	10	315.5	2024-04-26 13:37:03.689	272	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
10	10	306.9	2024-04-26 13:37:03.703	273	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
10	10	325.3	2024-04-26 13:37:03.719	274	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
10	10	303	2024-04-26 13:37:03.732	275	tarkkuuslaukaus-festivaali	aseharrastajien_yhtenaisyys_3
10	10	310.3	2024-04-26 13:37:03.746	276	tarkkuuslaukaus-festivaali	tahtaysmestarit_1
10	10	338.7	2024-04-26 13:37:03.759	277	tarkkuuslaukaus-festivaali	tahtaysmestarit_1
10	10	308	2024-04-26 13:37:03.773	278	tarkkuuslaukaus-festivaali	tahtaysmestarit_1
10	10	323.5	2024-04-26 13:37:03.786	279	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
10	10	346.5	2024-04-26 13:37:03.8	280	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
10	10	292.1	2024-04-26 13:37:03.812	281	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
10	10	343.4	2024-04-26 13:37:03.825	282	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
10	10	346.6	2024-04-26 13:37:03.839	283	tarkkuuslaukaus-festivaali	tahtaysmestarit_2
10	10	328	2024-04-26 13:37:03.851	284	tarkkuuslaukaus-festivaali	laukausryhma_aurora_1
10	10	326.1	2024-04-26 13:37:03.864	285	tarkkuuslaukaus-festivaali	laukausryhma_aurora_1
10	10	285.3	2024-04-26 13:37:03.877	286	tarkkuuslaukaus-festivaali	laukausryhma_aurora_1
10	10	334.2	2024-04-26 13:37:03.889	287	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
10	10	320.3	2024-04-26 13:37:03.903	288	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
10	10	323.3	2024-04-26 13:37:03.915	289	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
10	10	301.1	2024-04-26 13:37:03.927	290	tarkkuuslaukaus-festivaali	laukausryhma_aurora_2
10	10	349	2024-04-26 13:37:03.939	291	tarkkuuslaukaus-festivaali	laukausryhma_aurora_3
10	10	371.3	2024-04-26 13:37:03.951	292	tarkkuuslaukaus-festivaali	laukausryhma_aurora_3
10	10	301.5	2024-04-26 13:37:03.966	293	tarkkuuslaukaus-festivaali	laukausryhma_aurora_3
10	10	329.5	2024-04-26 13:37:03.979	294	tarkkuuslaukaus-festivaali	ampumataito_1
10	10	329.6	2024-04-26 13:37:03.991	295	tarkkuuslaukaus-festivaali	ampumataito_1
10	10	364.9	2024-04-26 13:37:04.004	296	tarkkuuslaukaus-festivaali	ampumataito_1
10	10	334.7	2024-04-26 13:37:04.017	297	tarkkuuslaukaus-festivaali	ampumataito_1
10	10	313.2	2024-04-26 13:37:04.033	298	tarkkuuslaukaus-festivaali	ampumataito_1
10	10	313.1	2024-04-26 13:37:04.045	299	tarkkuuslaukaus-festivaali	ampumataito_2
10	10	335.1	2024-04-26 13:37:04.058	300	tarkkuuslaukaus-festivaali	ampumataito_2
10	10	306	2024-04-26 13:37:04.071	301	tarkkuuslaukaus-festivaali	ampumataito_2
10	10	334.8	2024-04-26 13:37:04.085	302	tarkkuuslaukaus-festivaali	ampumataito_2
10	10	335.8	2024-04-26 13:37:04.1	303	tarkkuuslaukaus-festivaali	ampumataito_3
10	10	347.2	2024-04-26 13:37:04.112	304	tarkkuuslaukaus-festivaali	ampumataito_3
10	10	362.6	2024-04-26 13:37:04.124	305	tarkkuuslaukaus-festivaali	ampumataito_3
10	10	344.6	2024-04-26 13:37:04.137	306	tarkkuuslaukaus-festivaali	ampumataito_3
10	10	344.3	2024-04-26 13:37:04.153	307	tarkkuuslaukaus-festivaali	ampumataito_3
10	10	328.5	2024-04-26 13:37:04.165	308	kivaarikilpailujen_huipennus	poliisiseura_1
10	10	298.4	2024-04-26 13:37:04.177	309	kivaarikilpailujen_huipennus	poliisiseura_1
10	10	300.5	2024-04-26 13:37:04.191	310	kivaarikilpailujen_huipennus	poliisiseura_1
10	10	339.8	2024-04-26 13:37:04.207	311	kivaarikilpailujen_huipennus	poliisiseura_1
10	10	365	2024-04-26 13:37:04.221	312	kivaarikilpailujen_huipennus	poliisiseura_1
10	10	355.6	2024-04-26 13:37:04.236	313	kivaarikilpailujen_huipennus	poliisiseura_2
10	10	312.4	2024-04-26 13:37:04.257	314	kivaarikilpailujen_huipennus	poliisiseura_2
10	10	293.6	2024-04-26 13:37:04.277	315	kivaarikilpailujen_huipennus	poliisiseura_2
10	10	315.5	2024-04-26 13:37:04.29	316	kivaarikilpailujen_huipennus	poliisiseura_3
10	10	342.7	2024-04-26 13:37:04.303	317	kivaarikilpailujen_huipennus	poliisiseura_3
10	10	319.4	2024-04-26 13:37:04.316	318	kivaarikilpailujen_huipennus	poliisiseura_3
10	10	302.3	2024-04-26 13:37:04.329	319	kivaarikilpailujen_huipennus	poliisiseura_3
10	10	347.2	2024-04-26 13:37:04.342	320	kivaarikilpailujen_huipennus	poliisiseura_3
10	10	303.4	2024-04-26 13:37:04.354	321	kivaarikilpailujen_huipennus	koiraseura_1
10	10	337	2024-04-26 13:37:04.366	322	kivaarikilpailujen_huipennus	koiraseura_1
10	10	339.5	2024-04-26 13:37:04.378	323	kivaarikilpailujen_huipennus	koiraseura_1
10	10	324.8	2024-04-26 13:37:04.391	324	kivaarikilpailujen_huipennus	koiraseura_1
10	10	353	2024-04-26 13:37:04.404	325	kivaarikilpailujen_huipennus	koiraseura_2
10	10	313.1	2024-04-26 13:37:04.415	326	kivaarikilpailujen_huipennus	koiraseura_2
10	10	305	2024-04-26 13:37:04.428	327	kivaarikilpailujen_huipennus	koiraseura_2
10	10	349.2	2024-04-26 13:37:04.439	328	kivaarikilpailujen_huipennus	koiraseura_2
10	10	376.1	2024-04-26 13:37:04.453	329	kivaarikilpailujen_huipennus	koiraseura_2
10	10	342.3	2024-04-26 13:37:04.466	330	kivaarikilpailujen_huipennus	koiraseura_3
10	10	284.9	2024-04-26 13:37:04.478	331	kivaarikilpailujen_huipennus	koiraseura_3
10	10	326.4	2024-04-26 13:37:04.489	332	kivaarikilpailujen_huipennus	koiraseura_3
10	10	310	2024-04-26 13:37:04.501	333	kivaarikilpailujen_huipennus	koiraseura_3
10	10	316.8	2024-04-26 13:37:04.514	334	kivaarikilpailujen_huipennus	koiraseura_3
10	10	288.3	2024-04-26 13:37:04.527	335	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
10	10	291.5	2024-04-26 13:37:04.539	336	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
10	10	371.6	2024-04-26 13:37:04.551	337	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
10	10	377.8	2024-04-26 13:37:04.564	338	kivaarikilpailujen_huipennus	hammaspeikkoseura_1
10	10	333.8	2024-04-26 13:37:04.579	339	kivaarikilpailujen_huipennus	dog_1
10	10	317.4	2024-04-26 13:37:04.592	340	kivaarikilpailujen_huipennus	dog_1
10	10	362.8	2024-04-26 13:37:04.604	341	kivaarikilpailujen_huipennus	dog_1
10	10	297.3	2024-04-26 13:37:04.615	342	kivaarikilpailujen_huipennus	dog_1
10	10	297.4	2024-04-26 13:37:04.628	343	kivaarikilpailujen_huipennus	dog_2
10	10	318	2024-04-26 13:37:04.643	344	kivaarikilpailujen_huipennus	dog_2
10	10	352	2024-04-26 13:37:04.655	345	kivaarikilpailujen_huipennus	dog_2
10	10	254.7	2024-04-26 13:37:04.667	346	kivaarikilpailujen_huipennus	dog_2
10	10	275.7	2024-04-26 13:37:04.679	347	kivaarikilpailujen_huipennus	dog_2
10	10	285	2024-04-26 13:37:04.691	348	kivaarikilpailujen_huipennus	dog_3
10	10	324.3	2024-04-26 13:37:04.706	349	kivaarikilpailujen_huipennus	dog_3
10	10	329.9	2024-04-26 13:37:04.718	350	kivaarikilpailujen_huipennus	dog_3
10	10	293.6	2024-04-26 13:37:04.731	351	kivaarikilpailujen_huipennus	savu_seura_1
10	10	280.5	2024-04-26 13:37:04.745	352	kivaarikilpailujen_huipennus	savu_seura_1
10	10	295.2	2024-04-26 13:37:04.759	353	kivaarikilpailujen_huipennus	savu_seura_1
10	10	329.8	2024-04-26 13:37:04.773	354	kivaarikilpailujen_huipennus	savu_seura_1
10	10	312.4	2024-04-26 13:37:04.786	355	kivaarikilpailujen_huipennus	savu_seura_2
10	10	347.8	2024-04-26 13:37:04.8	356	kivaarikilpailujen_huipennus	savu_seura_2
10	10	315	2024-04-26 13:37:04.814	357	kivaarikilpailujen_huipennus	savu_seura_2
10	10	351.8	2024-04-26 13:37:04.828	358	kivaarikilpailujen_huipennus	savu_seura_2
10	10	331.6	2024-04-26 13:37:04.841	359	kivaarikilpailujen_huipennus	omas_1
10	10	303.7	2024-04-26 13:37:04.854	360	kivaarikilpailujen_huipennus	omas_1
10	10	319.7	2024-04-26 13:37:04.867	361	kivaarikilpailujen_huipennus	omas_1
10	10	321.2	2024-04-26 13:37:04.882	362	kivaarikilpailujen_huipennus	omas_1
10	10	305.5	2024-04-26 13:37:04.895	363	kivaarikilpailujen_huipennus	omas_1
10	10	305.8	2024-04-26 13:37:04.909	364	kivaarikilpailujen_huipennus	omas_2
10	10	298.8	2024-04-26 13:37:04.923	365	kivaarikilpailujen_huipennus	omas_2
10	10	369.4	2024-04-26 13:37:04.938	366	kivaarikilpailujen_huipennus	omas_2
10	10	320.6	2024-04-26 13:37:04.951	367	kivaarikilpailujen_huipennus	omas_2
10	10	336.3	2024-04-26 13:37:04.966	368	kivaarikilpailujen_huipennus	pelleseura_1
10	10	301.9	2024-04-26 13:37:04.979	369	kivaarikilpailujen_huipennus	pelleseura_1
10	10	322.7	2024-04-26 13:37:04.992	370	kivaarikilpailujen_huipennus	pelleseura_1
10	10	382.1	2024-04-26 13:37:05.007	371	kivaarikilpailujen_huipennus	pelleseura_2
10	10	323.9	2024-04-26 13:37:05.022	372	kivaarikilpailujen_huipennus	pelleseura_2
10	10	316.6	2024-04-26 13:37:05.035	373	kivaarikilpailujen_huipennus	pelleseura_2
10	10	319.9	2024-04-26 13:37:05.047	374	kivaarikilpailujen_huipennus	pelleseura_3
10	10	329.7	2024-04-26 13:37:05.06	375	kivaarikilpailujen_huipennus	pelleseura_3
10	10	356.2	2024-04-26 13:37:05.073	376	kivaarikilpailujen_huipennus	pelleseura_3
10	10	299.5	2024-04-26 13:37:05.085	377	kivaarikilpailujen_huipennus	pelleseura_3
10	10	332.2	2024-04-26 13:37:05.097	378	kivaarikilpailujen_huipennus	pelleseura_3
10	10	322.2	2024-04-26 13:37:05.11	379	kivaarikilpailujen_huipennus	yung_tallent_1
10	10	321.8	2024-04-26 13:37:05.123	380	kivaarikilpailujen_huipennus	yung_tallent_1
10	10	320	2024-04-26 13:37:05.136	381	kivaarikilpailujen_huipennus	yung_tallent_1
10	10	339.7	2024-04-26 13:37:05.148	382	kivaarikilpailujen_huipennus	yung_tallent_1
10	10	338	2024-04-26 13:37:05.164	383	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
10	10	317.9	2024-04-26 13:37:05.183	384	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
10	10	347.8	2024-04-26 13:37:05.201	385	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
10	10	317.7	2024-04-26 13:37:05.217	386	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_1
10	10	327.5	2024-04-26 13:37:05.231	387	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_2
10	10	361.6	2024-04-26 13:37:05.245	388	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_2
10	10	353.6	2024-04-26 13:37:05.258	389	kivaarikilpailujen_huipennus	aseharrastajien_yhtenaisyys_2
10	10	342.5	2024-04-26 13:37:05.269	390	kivaarikilpailujen_huipennus	tahtaysmestarit_1
10	10	335.6	2024-04-26 13:37:05.281	391	kivaarikilpailujen_huipennus	tahtaysmestarit_1
10	10	344.6	2024-04-26 13:37:05.293	392	kivaarikilpailujen_huipennus	tahtaysmestarit_1
10	10	288.4	2024-04-26 13:37:05.308	393	kivaarikilpailujen_huipennus	tahtaysmestarit_2
10	10	352.5	2024-04-26 13:37:05.321	394	kivaarikilpailujen_huipennus	tahtaysmestarit_2
10	10	322.6	2024-04-26 13:37:05.333	395	kivaarikilpailujen_huipennus	tahtaysmestarit_2
10	10	335.3	2024-04-26 13:37:05.345	396	kivaarikilpailujen_huipennus	tahtaysmestarit_2
10	10	375.4	2024-04-26 13:37:05.357	397	kivaarikilpailujen_huipennus	laukausryhma_aurora_1
10	10	354.8	2024-04-26 13:37:05.37	398	kivaarikilpailujen_huipennus	laukausryhma_aurora_1
10	10	358.3	2024-04-26 13:37:05.382	399	kivaarikilpailujen_huipennus	laukausryhma_aurora_1
10	10	300.7	2024-04-26 13:37:05.393	400	kivaarikilpailujen_huipennus	ampumataito_1
10	10	313.3	2024-04-26 13:37:05.405	401	kivaarikilpailujen_huipennus	ampumataito_1
10	10	302.8	2024-04-26 13:37:05.417	402	kivaarikilpailujen_huipennus	ampumataito_1
10	10	368.9	2024-04-26 13:37:05.431	403	kivaarikilpailujen_huipennus	ampumataito_2
10	10	346.5	2024-04-26 13:37:05.443	404	kivaarikilpailujen_huipennus	ampumataito_2
10	10	336.6	2024-04-26 13:37:05.454	405	kivaarikilpailujen_huipennus	ampumataito_2
10	10	364.5	2024-04-26 13:37:05.466	406	kivaarikilpailujen_huipennus	ampumataito_2
10	10	352	2024-04-26 13:37:05.478	407	kivaarikilpailujen_huipennus	ampumataito_3
10	10	373	2024-04-26 13:37:05.491	408	kivaarikilpailujen_huipennus	ampumataito_3
10	10	309.7	2024-04-26 13:37:05.504	409	kivaarikilpailujen_huipennus	ampumataito_3
10	10	291	2024-04-26 13:37:05.515	410	kivaarikilpailujen_huipennus	ampumataito_3
10	10	363	2024-04-26 13:37:05.527	411	kivaarikilpailujen_huipennus	ampumataito_3
10	10	301.3	2024-04-26 13:37:05.54	412	polaris-ampumaharjoitus	poliisiseura_1
10	10	267.9	2024-04-26 13:37:05.551	413	polaris-ampumaharjoitus	poliisiseura_1
10	10	344.1	2024-04-26 13:37:05.565	414	polaris-ampumaharjoitus	poliisiseura_1
10	10	306.1	2024-04-26 13:37:05.577	415	polaris-ampumaharjoitus	poliisiseura_1
10	10	375.6	2024-04-26 13:37:05.591	416	polaris-ampumaharjoitus	poliisiseura_1
10	10	324.3	2024-04-26 13:37:05.605	417	polaris-ampumaharjoitus	koiraseura_1
10	10	304.8	2024-04-26 13:37:05.619	418	polaris-ampumaharjoitus	koiraseura_1
10	10	291.5	2024-04-26 13:37:05.632	419	polaris-ampumaharjoitus	koiraseura_1
10	10	339.7	2024-04-26 13:37:05.647	420	polaris-ampumaharjoitus	koiraseura_2
10	10	330.7	2024-04-26 13:37:05.662	421	polaris-ampumaharjoitus	koiraseura_2
10	10	338.3	2024-04-26 13:37:05.678	422	polaris-ampumaharjoitus	koiraseura_2
10	10	319	2024-04-26 13:37:05.694	423	polaris-ampumaharjoitus	koiraseura_2
10	10	311.4	2024-04-26 13:37:05.709	424	polaris-ampumaharjoitus	hammaspeikkoseura_1
10	10	294.3	2024-04-26 13:37:05.723	425	polaris-ampumaharjoitus	hammaspeikkoseura_1
10	10	335.4	2024-04-26 13:37:05.74	426	polaris-ampumaharjoitus	hammaspeikkoseura_1
10	10	341.4	2024-04-26 13:37:05.755	427	polaris-ampumaharjoitus	hammaspeikkoseura_2
10	10	313.8	2024-04-26 13:37:05.769	428	polaris-ampumaharjoitus	hammaspeikkoseura_2
10	10	298.4	2024-04-26 13:37:05.784	429	polaris-ampumaharjoitus	hammaspeikkoseura_2
10	10	315.3	2024-04-26 13:37:05.799	430	polaris-ampumaharjoitus	hammaspeikkoseura_3
10	10	322.4	2024-04-26 13:37:05.814	431	polaris-ampumaharjoitus	hammaspeikkoseura_3
10	10	308.6	2024-04-26 13:37:05.829	432	polaris-ampumaharjoitus	hammaspeikkoseura_3
10	10	392.8	2024-04-26 13:37:05.848	433	polaris-ampumaharjoitus	dog_1
10	10	357.8	2024-04-26 13:37:05.869	434	polaris-ampumaharjoitus	dog_1
10	10	341.6	2024-04-26 13:37:05.888	435	polaris-ampumaharjoitus	dog_1
10	10	300.1	2024-04-26 13:37:05.906	436	polaris-ampumaharjoitus	dog_1
10	10	357.7	2024-04-26 13:37:05.924	437	polaris-ampumaharjoitus	dog_2
10	10	276.8	2024-04-26 13:37:05.939	438	polaris-ampumaharjoitus	dog_2
10	10	305.7	2024-04-26 13:37:05.955	439	polaris-ampumaharjoitus	dog_2
10	10	334.9	2024-04-26 13:37:05.968	440	polaris-ampumaharjoitus	dog_2
10	10	375.7	2024-04-26 13:37:05.985	441	polaris-ampumaharjoitus	dog_3
10	10	343.8	2024-04-26 13:37:06.003	442	polaris-ampumaharjoitus	dog_3
10	10	306	2024-04-26 13:37:06.021	443	polaris-ampumaharjoitus	dog_3
10	10	368.3	2024-04-26 13:37:06.037	444	polaris-ampumaharjoitus	savu_seura_1
10	10	323.8	2024-04-26 13:37:06.055	445	polaris-ampumaharjoitus	savu_seura_1
10	10	344.2	2024-04-26 13:37:06.07	446	polaris-ampumaharjoitus	savu_seura_1
10	10	374.5	2024-04-26 13:37:06.084	447	polaris-ampumaharjoitus	savu_seura_1
10	10	302.4	2024-04-26 13:37:06.099	448	polaris-ampumaharjoitus	savu_seura_1
10	10	313	2024-04-26 13:37:06.115	449	polaris-ampumaharjoitus	savu_seura_2
10	10	313	2024-04-26 13:37:06.131	450	polaris-ampumaharjoitus	savu_seura_2
10	10	313	2024-04-26 13:37:06.146	451	polaris-ampumaharjoitus	savu_seura_2
10	10	359.3	2024-04-26 13:37:06.161	452	polaris-ampumaharjoitus	savu_seura_3
10	10	336.1	2024-04-26 13:37:06.177	453	polaris-ampumaharjoitus	savu_seura_3
10	10	324.6	2024-04-26 13:37:06.193	454	polaris-ampumaharjoitus	savu_seura_3
10	10	314.1	2024-04-26 13:37:06.207	455	polaris-ampumaharjoitus	omas_1
10	10	315.3	2024-04-26 13:37:06.219	456	polaris-ampumaharjoitus	omas_1
10	10	317.6	2024-04-26 13:37:06.234	457	polaris-ampumaharjoitus	omas_1
10	10	329.6	2024-04-26 13:37:06.247	458	polaris-ampumaharjoitus	omas_1
10	10	337.7	2024-04-26 13:37:06.259	459	polaris-ampumaharjoitus	omas_1
10	10	331.2	2024-04-26 13:37:06.272	460	polaris-ampumaharjoitus	omas_2
10	10	387	2024-04-26 13:37:06.285	461	polaris-ampumaharjoitus	omas_2
10	10	354.9	2024-04-26 13:37:06.299	462	polaris-ampumaharjoitus	omas_2
10	10	334.6	2024-04-26 13:37:06.314	463	polaris-ampumaharjoitus	omas_2
10	10	352.7	2024-04-26 13:37:06.326	464	polaris-ampumaharjoitus	omas_2
10	10	332.1	2024-04-26 13:37:06.337	465	polaris-ampumaharjoitus	omas_3
10	10	335.7	2024-04-26 13:37:06.35	466	polaris-ampumaharjoitus	omas_3
10	10	331.9	2024-04-26 13:37:06.362	467	polaris-ampumaharjoitus	omas_3
10	10	361.2	2024-04-26 13:37:06.373	468	polaris-ampumaharjoitus	omas_3
10	10	345.8	2024-04-26 13:37:06.384	469	polaris-ampumaharjoitus	pelleseura_1
10	10	315.9	2024-04-26 13:37:06.397	470	polaris-ampumaharjoitus	pelleseura_1
10	10	317.4	2024-04-26 13:37:06.41	471	polaris-ampumaharjoitus	pelleseura_1
10	10	303.2	2024-04-26 13:37:06.423	472	polaris-ampumaharjoitus	pelleseura_1
10	10	302.6	2024-04-26 13:37:06.436	473	polaris-ampumaharjoitus	pelleseura_2
10	10	311.7	2024-04-26 13:37:06.447	474	polaris-ampumaharjoitus	pelleseura_2
10	10	333	2024-04-26 13:37:06.459	475	polaris-ampumaharjoitus	pelleseura_2
10	10	325.4	2024-04-26 13:37:06.471	476	polaris-ampumaharjoitus	pelleseura_3
10	10	316.4	2024-04-26 13:37:06.486	477	polaris-ampumaharjoitus	pelleseura_3
10	10	337.9	2024-04-26 13:37:06.498	478	polaris-ampumaharjoitus	pelleseura_3
10	10	304.9	2024-04-26 13:37:06.509	479	polaris-ampumaharjoitus	pelleseura_3
10	10	330.8	2024-04-26 13:37:06.522	480	polaris-ampumaharjoitus	yung_tallent_1
10	10	280	2024-04-26 13:37:06.534	481	polaris-ampumaharjoitus	yung_tallent_1
10	10	293.8	2024-04-26 13:37:06.547	482	polaris-ampumaharjoitus	yung_tallent_1
10	10	302.7	2024-04-26 13:37:06.558	483	polaris-ampumaharjoitus	yung_tallent_1
10	10	305.6	2024-04-26 13:37:06.57	484	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
10	10	309.6	2024-04-26 13:37:06.582	485	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
10	10	330.4	2024-04-26 13:37:06.595	486	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
10	10	319.7	2024-04-26 13:37:06.609	487	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
10	10	321.5	2024-04-26 13:37:06.621	488	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_1
10	10	305.8	2024-04-26 13:37:06.633	489	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
10	10	344.1	2024-04-26 13:37:06.645	490	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
10	10	303.6	2024-04-26 13:37:06.659	491	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
10	10	326	2024-04-26 13:37:06.672	492	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
10	10	317.4	2024-04-26 13:37:06.683	493	polaris-ampumaharjoitus	aseharrastajien_yhtenaisyys_2
10	10	294.8	2024-04-26 13:37:06.696	494	polaris-ampumaharjoitus	tahtaysmestarit_1
10	10	342.8	2024-04-26 13:37:06.709	495	polaris-ampumaharjoitus	tahtaysmestarit_1
10	10	321.5	2024-04-26 13:37:06.723	496	polaris-ampumaharjoitus	tahtaysmestarit_1
10	10	318.6	2024-04-26 13:37:06.735	497	polaris-ampumaharjoitus	tahtaysmestarit_1
10	10	302.3	2024-04-26 13:37:06.747	498	polaris-ampumaharjoitus	tahtaysmestarit_2
10	10	359	2024-04-26 13:37:06.76	499	polaris-ampumaharjoitus	tahtaysmestarit_2
10	10	333.3	2024-04-26 13:37:06.772	500	polaris-ampumaharjoitus	tahtaysmestarit_2
10	10	317.3	2024-04-26 13:37:06.788	501	polaris-ampumaharjoitus	tahtaysmestarit_2
10	10	310.6	2024-04-26 13:37:06.8	502	polaris-ampumaharjoitus	tahtaysmestarit_2
10	10	366.4	2024-04-26 13:37:06.815	503	polaris-ampumaharjoitus	tahtaysmestarit_3
10	10	329.2	2024-04-26 13:37:06.826	504	polaris-ampumaharjoitus	tahtaysmestarit_3
10	10	294	2024-04-26 13:37:06.838	505	polaris-ampumaharjoitus	tahtaysmestarit_3
10	10	311.6	2024-04-26 13:37:06.853	506	polaris-ampumaharjoitus	laukausryhma_aurora_1
10	10	334.1	2024-04-26 13:37:06.865	507	polaris-ampumaharjoitus	laukausryhma_aurora_1
10	10	318.1	2024-04-26 13:37:06.878	508	polaris-ampumaharjoitus	laukausryhma_aurora_1
10	10	330.2	2024-04-26 13:37:06.891	509	polaris-ampumaharjoitus	laukausryhma_aurora_1
10	10	319	2024-04-26 13:37:06.906	510	polaris-ampumaharjoitus	laukausryhma_aurora_2
10	10	305.6	2024-04-26 13:37:06.92	511	polaris-ampumaharjoitus	laukausryhma_aurora_2
10	10	363.6	2024-04-26 13:37:06.932	512	polaris-ampumaharjoitus	laukausryhma_aurora_2
10	10	334.2	2024-04-26 13:37:06.944	513	polaris-ampumaharjoitus	laukausryhma_aurora_2
10	10	339.2	2024-04-26 13:37:06.955	514	polaris-ampumaharjoitus	laukausryhma_aurora_2
10	10	308.1	2024-04-26 13:37:06.969	515	polaris-ampumaharjoitus	laukausryhma_aurora_3
10	10	327.9	2024-04-26 13:37:06.981	516	polaris-ampumaharjoitus	laukausryhma_aurora_3
10	10	288.6	2024-04-26 13:37:06.999	517	polaris-ampumaharjoitus	laukausryhma_aurora_3
10	10	347.7	2024-04-26 13:37:07.016	518	polaris-ampumaharjoitus	laukausryhma_aurora_3
10	10	313.1	2024-04-26 13:37:07.037	519	polaris-ampumaharjoitus	laukausryhma_aurora_3
10	10	317.9	2024-04-26 13:37:07.05	520	polaris-ampumaharjoitus	ampumataito_1
10	10	330	2024-04-26 13:37:07.067	521	polaris-ampumaharjoitus	ampumataito_1
10	10	345.5	2024-04-26 13:37:07.079	522	polaris-ampumaharjoitus	ampumataito_1
10	10	284.9	2024-04-26 13:37:07.093	523	aamunkoiton_tahtays	poliisiseura_1
10	10	312.6	2024-04-26 13:37:07.107	524	aamunkoiton_tahtays	poliisiseura_1
10	10	355.6	2024-04-26 13:37:07.121	525	aamunkoiton_tahtays	poliisiseura_1
10	10	377.4	2024-04-26 13:37:07.134	526	aamunkoiton_tahtays	poliisiseura_1
10	10	332.1	2024-04-26 13:37:07.148	527	aamunkoiton_tahtays	poliisiseura_2
10	10	333.3	2024-04-26 13:37:07.163	528	aamunkoiton_tahtays	poliisiseura_2
10	10	349.5	2024-04-26 13:37:07.176	529	aamunkoiton_tahtays	poliisiseura_2
10	10	312	2024-04-26 13:37:07.19	530	aamunkoiton_tahtays	poliisiseura_2
10	10	352.4	2024-04-26 13:37:07.203	531	aamunkoiton_tahtays	poliisiseura_2
10	10	369.5	2024-04-26 13:37:07.218	532	aamunkoiton_tahtays	koiraseura_1
10	10	304.5	2024-04-26 13:37:07.232	533	aamunkoiton_tahtays	koiraseura_1
10	10	301.4	2024-04-26 13:37:07.245	534	aamunkoiton_tahtays	koiraseura_1
10	10	343.7	2024-04-26 13:37:07.258	535	aamunkoiton_tahtays	koiraseura_1
10	10	297.6	2024-04-26 13:37:07.269	536	aamunkoiton_tahtays	koiraseura_1
10	10	326.5	2024-04-26 13:37:07.282	537	aamunkoiton_tahtays	koiraseura_2
10	10	291	2024-04-26 13:37:07.293	538	aamunkoiton_tahtays	koiraseura_2
10	10	329.6	2024-04-26 13:37:07.306	539	aamunkoiton_tahtays	koiraseura_2
10	10	364.5	2024-04-26 13:37:07.317	540	aamunkoiton_tahtays	hammaspeikkoseura_1
10	10	350.9	2024-04-26 13:37:07.329	541	aamunkoiton_tahtays	hammaspeikkoseura_1
10	10	336	2024-04-26 13:37:07.342	542	aamunkoiton_tahtays	hammaspeikkoseura_1
10	10	339.4	2024-04-26 13:37:07.353	543	aamunkoiton_tahtays	hammaspeikkoseura_2
10	10	336.6	2024-04-26 13:37:07.366	544	aamunkoiton_tahtays	hammaspeikkoseura_2
10	10	335.5	2024-04-26 13:37:07.378	545	aamunkoiton_tahtays	hammaspeikkoseura_2
10	10	318.2	2024-04-26 13:37:07.39	546	aamunkoiton_tahtays	hammaspeikkoseura_2
10	10	360.7	2024-04-26 13:37:07.404	547	aamunkoiton_tahtays	hammaspeikkoseura_3
10	10	324.5	2024-04-26 13:37:07.414	548	aamunkoiton_tahtays	hammaspeikkoseura_3
10	10	369.8	2024-04-26 13:37:07.426	549	aamunkoiton_tahtays	hammaspeikkoseura_3
10	10	348.3	2024-04-26 13:37:07.439	550	aamunkoiton_tahtays	hammaspeikkoseura_3
10	10	370.8	2024-04-26 13:37:07.449	551	aamunkoiton_tahtays	dog_1
10	10	352.4	2024-04-26 13:37:07.462	552	aamunkoiton_tahtays	dog_1
10	10	318	2024-04-26 13:37:07.475	553	aamunkoiton_tahtays	dog_1
10	10	310.9	2024-04-26 13:37:07.487	554	aamunkoiton_tahtays	dog_1
10	10	302.7	2024-04-26 13:37:07.501	555	aamunkoiton_tahtays	savu_seura_1
10	10	317.1	2024-04-26 13:37:07.513	556	aamunkoiton_tahtays	savu_seura_1
10	10	342.9	2024-04-26 13:37:07.526	557	aamunkoiton_tahtays	savu_seura_1
10	10	328.3	2024-04-26 13:37:07.538	558	aamunkoiton_tahtays	savu_seura_2
10	10	339.5	2024-04-26 13:37:07.551	559	aamunkoiton_tahtays	savu_seura_2
10	10	338.6	2024-04-26 13:37:07.563	560	aamunkoiton_tahtays	savu_seura_2
10	10	342.1	2024-04-26 13:37:07.575	561	aamunkoiton_tahtays	savu_seura_2
10	10	367.3	2024-04-26 13:37:07.589	562	aamunkoiton_tahtays	savu_seura_3
10	10	321.6	2024-04-26 13:37:07.6	563	aamunkoiton_tahtays	savu_seura_3
10	10	296.3	2024-04-26 13:37:07.613	564	aamunkoiton_tahtays	savu_seura_3
10	10	335	2024-04-26 13:37:07.627	565	aamunkoiton_tahtays	savu_seura_3
10	10	359.5	2024-04-26 13:37:07.639	566	aamunkoiton_tahtays	savu_seura_3
10	10	330.5	2024-04-26 13:37:07.651	567	aamunkoiton_tahtays	omas_1
10	10	300.8	2024-04-26 13:37:07.662	568	aamunkoiton_tahtays	omas_1
10	10	311.8	2024-04-26 13:37:07.674	569	aamunkoiton_tahtays	omas_1
10	10	294	2024-04-26 13:37:07.686	570	aamunkoiton_tahtays	omas_1
10	10	344.8	2024-04-26 13:37:07.698	571	aamunkoiton_tahtays	omas_1
10	10	354	2024-04-26 13:37:07.712	572	aamunkoiton_tahtays	omas_2
10	10	333.5	2024-04-26 13:37:07.723	573	aamunkoiton_tahtays	omas_2
10	10	307.8	2024-04-26 13:37:07.735	574	aamunkoiton_tahtays	omas_2
10	10	327.1	2024-04-26 13:37:07.747	575	aamunkoiton_tahtays	omas_2
10	10	312.8	2024-04-26 13:37:07.759	576	aamunkoiton_tahtays	pelleseura_1
10	10	286.3	2024-04-26 13:37:07.773	577	aamunkoiton_tahtays	pelleseura_1
10	10	321	2024-04-26 13:37:07.786	578	aamunkoiton_tahtays	pelleseura_1
10	10	318.6	2024-04-26 13:37:07.798	579	aamunkoiton_tahtays	pelleseura_1
10	10	322.6	2024-04-26 13:37:07.809	580	aamunkoiton_tahtays	pelleseura_2
10	10	344	2024-04-26 13:37:07.822	581	aamunkoiton_tahtays	pelleseura_2
10	10	308	2024-04-26 13:37:07.837	582	aamunkoiton_tahtays	pelleseura_2
10	10	306.5	2024-04-26 13:37:07.849	583	aamunkoiton_tahtays	yung_tallent_1
10	10	316.8	2024-04-26 13:37:07.862	584	aamunkoiton_tahtays	yung_tallent_1
10	10	361.5	2024-04-26 13:37:07.875	585	aamunkoiton_tahtays	yung_tallent_1
10	10	313.7	2024-04-26 13:37:07.89	586	aamunkoiton_tahtays	yung_tallent_1
10	10	325.1	2024-04-26 13:37:07.903	587	aamunkoiton_tahtays	yung_tallent_1
10	10	327.3	2024-04-26 13:37:07.917	588	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_1
10	10	317	2024-04-26 13:37:07.928	589	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_1
10	10	274.5	2024-04-26 13:37:07.941	590	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_1
10	10	339.6	2024-04-26 13:37:07.954	591	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
10	10	296.8	2024-04-26 13:37:07.969	592	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
10	10	339.4	2024-04-26 13:37:07.981	593	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
10	10	309.9	2024-04-26 13:37:07.993	594	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
10	10	311.1	2024-04-26 13:37:08.007	595	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_2
10	10	348.5	2024-04-26 13:37:08.021	596	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_3
10	10	344.9	2024-04-26 13:37:08.034	597	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_3
10	10	304.8	2024-04-26 13:37:08.046	598	aamunkoiton_tahtays	aseharrastajien_yhtenaisyys_3
10	10	337.3	2024-04-26 13:37:08.059	599	aamunkoiton_tahtays	tahtaysmestarit_1
10	10	340.4	2024-04-26 13:37:08.072	600	aamunkoiton_tahtays	tahtaysmestarit_1
10	10	326.7	2024-04-26 13:37:08.085	601	aamunkoiton_tahtays	tahtaysmestarit_1
10	10	346.6	2024-04-26 13:37:08.097	602	aamunkoiton_tahtays	tahtaysmestarit_1
10	10	332.7	2024-04-26 13:37:08.11	603	aamunkoiton_tahtays	laukausryhma_aurora_1
10	10	313.8	2024-04-26 13:37:08.123	604	aamunkoiton_tahtays	laukausryhma_aurora_1
10	10	337.7	2024-04-26 13:37:08.137	605	aamunkoiton_tahtays	laukausryhma_aurora_1
10	10	333.7	2024-04-26 13:37:08.15	606	aamunkoiton_tahtays	laukausryhma_aurora_1
10	10	348.4	2024-04-26 13:37:08.163	607	aamunkoiton_tahtays	laukausryhma_aurora_2
10	10	343.6	2024-04-26 13:37:08.176	608	aamunkoiton_tahtays	laukausryhma_aurora_2
10	10	284.9	2024-04-26 13:37:08.189	609	aamunkoiton_tahtays	laukausryhma_aurora_2
10	10	340.1	2024-04-26 13:37:08.203	610	aamunkoiton_tahtays	laukausryhma_aurora_3
10	10	351.1	2024-04-26 13:37:08.215	611	aamunkoiton_tahtays	laukausryhma_aurora_3
10	10	351.7	2024-04-26 13:37:08.229	612	aamunkoiton_tahtays	laukausryhma_aurora_3
10	10	325.3	2024-04-26 13:37:08.243	613	aamunkoiton_tahtays	laukausryhma_aurora_3
10	10	307.9	2024-04-26 13:37:08.257	614	aamunkoiton_tahtays	ampumataito_1
10	10	303.8	2024-04-26 13:37:08.269	615	aamunkoiton_tahtays	ampumataito_1
10	10	347.7	2024-04-26 13:37:08.281	616	aamunkoiton_tahtays	ampumataito_1
10	10	323.4	2024-04-26 13:37:08.293	617	aamunkoiton_tahtays	ampumataito_2
10	10	364.2	2024-04-26 13:37:08.306	618	aamunkoiton_tahtays	ampumataito_2
10	10	314.3	2024-04-26 13:37:08.319	619	aamunkoiton_tahtays	ampumataito_2
10	10	308.2	2024-04-26 13:37:08.331	620	aamunkoiton_tahtays	ampumataito_2
10	10	284.7	2024-04-26 13:37:08.343	621	nordic_sharpshooters_cup	poliisiseura_1
10	10	347.4	2024-04-26 13:37:08.354	622	nordic_sharpshooters_cup	poliisiseura_1
10	10	322.1	2024-04-26 13:37:08.366	623	nordic_sharpshooters_cup	poliisiseura_1
10	10	313.4	2024-04-26 13:37:08.379	624	nordic_sharpshooters_cup	poliisiseura_1
10	10	344.3	2024-04-26 13:37:08.392	625	nordic_sharpshooters_cup	koiraseura_1
10	10	272.3	2024-04-26 13:37:08.404	626	nordic_sharpshooters_cup	koiraseura_1
10	10	315.6	2024-04-26 13:37:08.417	627	nordic_sharpshooters_cup	koiraseura_1
10	10	344.6	2024-04-26 13:37:08.429	628	nordic_sharpshooters_cup	koiraseura_2
10	10	299.2	2024-04-26 13:37:08.442	629	nordic_sharpshooters_cup	koiraseura_2
10	10	319.4	2024-04-26 13:37:08.454	630	nordic_sharpshooters_cup	koiraseura_2
10	10	340.2	2024-04-26 13:37:08.466	631	nordic_sharpshooters_cup	koiraseura_2
10	10	335.9	2024-04-26 13:37:08.478	632	nordic_sharpshooters_cup	hammaspeikkoseura_1
10	10	337.5	2024-04-26 13:37:08.491	633	nordic_sharpshooters_cup	hammaspeikkoseura_1
10	10	331.5	2024-04-26 13:37:08.504	634	nordic_sharpshooters_cup	hammaspeikkoseura_1
10	10	292.3	2024-04-26 13:37:08.516	635	nordic_sharpshooters_cup	hammaspeikkoseura_1
10	10	325.3	2024-04-26 13:37:08.529	636	nordic_sharpshooters_cup	hammaspeikkoseura_1
10	10	340.1	2024-04-26 13:37:08.541	637	nordic_sharpshooters_cup	hammaspeikkoseura_2
10	10	370.6	2024-04-26 13:37:08.553	638	nordic_sharpshooters_cup	hammaspeikkoseura_2
10	10	335.7	2024-04-26 13:37:08.566	639	nordic_sharpshooters_cup	hammaspeikkoseura_2
10	10	335.7	2024-04-26 13:37:08.578	640	nordic_sharpshooters_cup	hammaspeikkoseura_3
10	10	324.9	2024-04-26 13:37:08.591	641	nordic_sharpshooters_cup	hammaspeikkoseura_3
10	10	324	2024-04-26 13:37:08.603	642	nordic_sharpshooters_cup	hammaspeikkoseura_3
10	10	336.8	2024-04-26 13:37:08.614	643	nordic_sharpshooters_cup	hammaspeikkoseura_3
10	10	296.9	2024-04-26 13:37:08.628	644	nordic_sharpshooters_cup	hammaspeikkoseura_3
10	10	346.1	2024-04-26 13:37:08.64	645	nordic_sharpshooters_cup	dog_1
10	10	322.1	2024-04-26 13:37:08.652	646	nordic_sharpshooters_cup	dog_1
10	10	302.1	2024-04-26 13:37:08.662	647	nordic_sharpshooters_cup	dog_1
10	10	322.9	2024-04-26 13:37:08.675	648	nordic_sharpshooters_cup	dog_1
10	10	360.1	2024-04-26 13:37:08.688	649	nordic_sharpshooters_cup	dog_1
10	10	320.6	2024-04-26 13:37:08.701	650	nordic_sharpshooters_cup	dog_2
10	10	313.1	2024-04-26 13:37:08.713	651	nordic_sharpshooters_cup	dog_2
10	10	299.1	2024-04-26 13:37:08.725	652	nordic_sharpshooters_cup	dog_2
10	10	323.9	2024-04-26 13:37:08.737	653	nordic_sharpshooters_cup	dog_2
10	10	314.9	2024-04-26 13:37:08.751	654	nordic_sharpshooters_cup	savu_seura_1
10	10	347.3	2024-04-26 13:37:08.764	655	nordic_sharpshooters_cup	savu_seura_1
10	10	355.8	2024-04-26 13:37:08.777	656	nordic_sharpshooters_cup	savu_seura_1
10	10	382.9	2024-04-26 13:37:08.798	657	nordic_sharpshooters_cup	savu_seura_1
10	10	320.7	2024-04-26 13:37:08.818	658	nordic_sharpshooters_cup	omas_1
10	10	304.1	2024-04-26 13:37:08.835	659	nordic_sharpshooters_cup	omas_1
10	10	346.2	2024-04-26 13:37:08.849	660	nordic_sharpshooters_cup	omas_1
10	10	327.9	2024-04-26 13:37:08.865	661	nordic_sharpshooters_cup	pelleseura_1
10	10	339.4	2024-04-26 13:37:08.88	662	nordic_sharpshooters_cup	pelleseura_1
10	10	313.2	2024-04-26 13:37:08.891	663	nordic_sharpshooters_cup	pelleseura_1
10	10	332.6	2024-04-26 13:37:08.903	664	nordic_sharpshooters_cup	pelleseura_1
10	10	320.4	2024-04-26 13:37:08.915	665	nordic_sharpshooters_cup	pelleseura_2
10	10	317.9	2024-04-26 13:37:08.927	666	nordic_sharpshooters_cup	pelleseura_2
10	10	264.8	2024-04-26 13:37:08.94	667	nordic_sharpshooters_cup	pelleseura_2
10	10	351.1	2024-04-26 13:37:08.952	668	nordic_sharpshooters_cup	yung_tallent_1
10	10	302.4	2024-04-26 13:37:08.964	669	nordic_sharpshooters_cup	yung_tallent_1
10	10	313.8	2024-04-26 13:37:08.976	670	nordic_sharpshooters_cup	yung_tallent_1
10	10	339.6	2024-04-26 13:37:08.987	671	nordic_sharpshooters_cup	yung_tallent_2
10	10	348.5	2024-04-26 13:37:09.002	672	nordic_sharpshooters_cup	yung_tallent_2
10	10	351.2	2024-04-26 13:37:09.013	673	nordic_sharpshooters_cup	yung_tallent_2
10	10	358.7	2024-04-26 13:37:09.025	674	nordic_sharpshooters_cup	yung_tallent_2
10	10	310.9	2024-04-26 13:37:09.036	675	nordic_sharpshooters_cup	yung_tallent_3
10	10	325.7	2024-04-26 13:37:09.047	676	nordic_sharpshooters_cup	yung_tallent_3
10	10	338.7	2024-04-26 13:37:09.061	677	nordic_sharpshooters_cup	yung_tallent_3
10	10	313.3	2024-04-26 13:37:09.074	678	nordic_sharpshooters_cup	yung_tallent_3
10	10	352.2	2024-04-26 13:37:09.085	679	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
10	10	301.6	2024-04-26 13:37:09.098	680	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
10	10	305.3	2024-04-26 13:37:09.111	681	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
10	10	338.1	2024-04-26 13:37:09.124	682	nordic_sharpshooters_cup	aseharrastajien_yhtenaisyys_1
10	10	304.6	2024-04-26 13:37:09.135	683	nordic_sharpshooters_cup	tahtaysmestarit_1
10	10	344.3	2024-04-26 13:37:09.148	684	nordic_sharpshooters_cup	tahtaysmestarit_1
10	10	319.4	2024-04-26 13:37:09.16	685	nordic_sharpshooters_cup	tahtaysmestarit_1
10	10	301.1	2024-04-26 13:37:09.171	686	nordic_sharpshooters_cup	tahtaysmestarit_2
10	10	342.3	2024-04-26 13:37:09.185	687	nordic_sharpshooters_cup	tahtaysmestarit_2
10	10	268.5	2024-04-26 13:37:09.197	688	nordic_sharpshooters_cup	tahtaysmestarit_2
10	10	287.6	2024-04-26 13:37:09.208	689	nordic_sharpshooters_cup	tahtaysmestarit_2
10	10	299.4	2024-04-26 13:37:09.22	690	nordic_sharpshooters_cup	laukausryhma_aurora_1
10	10	324	2024-04-26 13:37:09.232	691	nordic_sharpshooters_cup	laukausryhma_aurora_1
10	10	340.2	2024-04-26 13:37:09.246	692	nordic_sharpshooters_cup	laukausryhma_aurora_1
10	10	372.8	2024-04-26 13:37:09.258	693	nordic_sharpshooters_cup	laukausryhma_aurora_1
10	10	356	2024-04-26 13:37:09.27	694	nordic_sharpshooters_cup	laukausryhma_aurora_2
10	10	284.6	2024-04-26 13:37:09.283	695	nordic_sharpshooters_cup	laukausryhma_aurora_2
10	10	341.2	2024-04-26 13:37:09.295	696	nordic_sharpshooters_cup	laukausryhma_aurora_2
10	10	327.2	2024-04-26 13:37:09.309	697	nordic_sharpshooters_cup	laukausryhma_aurora_2
10	10	373.3	2024-04-26 13:37:09.321	698	nordic_sharpshooters_cup	laukausryhma_aurora_2
10	10	330.4	2024-04-26 13:37:09.332	699	nordic_sharpshooters_cup	ampumataito_1
10	10	288.5	2024-04-26 13:37:09.344	700	nordic_sharpshooters_cup	ampumataito_1
10	10	367.2	2024-04-26 13:37:09.355	701	nordic_sharpshooters_cup	ampumataito_1
10	10	325.3	2024-04-26 13:37:09.368	702	nordic_sharpshooters_cup	ampumataito_1
10	10	282.3	2024-04-26 13:37:09.38	703	nordic_sharpshooters_cup	ampumataito_2
10	10	313.8	2024-04-26 13:37:09.392	704	nordic_sharpshooters_cup	ampumataito_2
10	10	371.3	2024-04-26 13:37:09.404	705	nordic_sharpshooters_cup	ampumataito_2
10	10	321.9	2024-04-26 13:37:09.416	706	nordic_sharpshooters_cup	ampumataito_2
10	10	362.5	2024-04-26 13:37:09.43	707	nordic_sharpshooters_cup	ampumataito_2
10	10	325.5	2024-04-26 13:37:09.442	708	nordic_sharpshooters_cup	ampumataito_3
10	10	331.7	2024-04-26 13:37:09.453	709	nordic_sharpshooters_cup	ampumataito_3
10	10	299.5	2024-04-26 13:37:09.465	710	nordic_sharpshooters_cup	ampumataito_3
10	10	323.4	2024-04-26 13:37:09.477	711	nordic_sharpshooters_cup	ampumataito_3
10	10	281.6	2024-04-26 13:37:09.491	712	nordic_sharpshooters_cup	ampumataito_3
10	10	341.6	2024-04-26 13:37:09.503	713	taivaanranta-tulitus	poliisiseura_1
10	10	327.9	2024-04-26 13:37:09.516	714	taivaanranta-tulitus	poliisiseura_1
10	10	312.5	2024-04-26 13:37:09.529	715	taivaanranta-tulitus	poliisiseura_1
10	10	301.1	2024-04-26 13:37:09.54	716	taivaanranta-tulitus	poliisiseura_2
10	10	290.1	2024-04-26 13:37:09.553	717	taivaanranta-tulitus	poliisiseura_2
10	10	287.3	2024-04-26 13:37:09.566	718	taivaanranta-tulitus	poliisiseura_2
10	10	322	2024-04-26 13:37:09.579	719	taivaanranta-tulitus	poliisiseura_2
10	10	371.9	2024-04-26 13:37:09.59	720	taivaanranta-tulitus	poliisiseura_2
10	10	310.8	2024-04-26 13:37:09.603	721	taivaanranta-tulitus	koiraseura_1
10	10	359.7	2024-04-26 13:37:09.616	722	taivaanranta-tulitus	koiraseura_1
10	10	309.7	2024-04-26 13:37:09.629	723	taivaanranta-tulitus	koiraseura_1
10	10	289.9	2024-04-26 13:37:09.64	724	taivaanranta-tulitus	koiraseura_1
10	10	269	2024-04-26 13:37:09.653	725	taivaanranta-tulitus	koiraseura_2
10	10	326.6	2024-04-26 13:37:09.665	726	taivaanranta-tulitus	koiraseura_2
10	10	341.1	2024-04-26 13:37:09.678	727	taivaanranta-tulitus	koiraseura_2
10	10	342.9	2024-04-26 13:37:09.69	728	taivaanranta-tulitus	koiraseura_3
10	10	343.2	2024-04-26 13:37:09.701	729	taivaanranta-tulitus	koiraseura_3
10	10	359.3	2024-04-26 13:37:09.713	730	taivaanranta-tulitus	koiraseura_3
10	10	299.3	2024-04-26 13:37:09.724	731	taivaanranta-tulitus	koiraseura_3
10	10	323.9	2024-04-26 13:37:09.738	732	taivaanranta-tulitus	hammaspeikkoseura_1
10	10	336.2	2024-04-26 13:37:09.75	733	taivaanranta-tulitus	hammaspeikkoseura_1
10	10	337.3	2024-04-26 13:37:09.762	734	taivaanranta-tulitus	hammaspeikkoseura_1
10	10	304.3	2024-04-26 13:37:09.775	735	taivaanranta-tulitus	hammaspeikkoseura_1
10	10	285.5	2024-04-26 13:37:09.787	736	taivaanranta-tulitus	dog_1
10	10	330	2024-04-26 13:37:09.801	737	taivaanranta-tulitus	dog_1
10	10	328.2	2024-04-26 13:37:09.813	738	taivaanranta-tulitus	dog_1
10	10	296.6	2024-04-26 13:37:09.824	739	taivaanranta-tulitus	dog_2
10	10	311	2024-04-26 13:37:09.835	740	taivaanranta-tulitus	dog_2
10	10	320.6	2024-04-26 13:37:09.847	741	taivaanranta-tulitus	dog_2
10	10	320.8	2024-04-26 13:37:09.861	742	taivaanranta-tulitus	dog_2
10	10	330.5	2024-04-26 13:37:09.872	743	taivaanranta-tulitus	dog_2
10	10	310.2	2024-04-26 13:37:09.885	744	taivaanranta-tulitus	savu_seura_1
10	10	265.8	2024-04-26 13:37:09.897	745	taivaanranta-tulitus	savu_seura_1
10	10	329.8	2024-04-26 13:37:09.909	746	taivaanranta-tulitus	savu_seura_1
10	10	300.8	2024-04-26 13:37:09.924	747	taivaanranta-tulitus	savu_seura_1
10	10	339.9	2024-04-26 13:37:09.937	748	taivaanranta-tulitus	savu_seura_2
10	10	299.3	2024-04-26 13:37:09.95	749	taivaanranta-tulitus	savu_seura_2
10	10	317.4	2024-04-26 13:37:09.962	750	taivaanranta-tulitus	savu_seura_2
10	10	336.5	2024-04-26 13:37:09.974	751	taivaanranta-tulitus	savu_seura_2
10	10	332.3	2024-04-26 13:37:09.987	752	taivaanranta-tulitus	savu_seura_2
10	10	292.8	2024-04-26 13:37:09.998	753	taivaanranta-tulitus	savu_seura_3
10	10	315.7	2024-04-26 13:37:10.011	754	taivaanranta-tulitus	savu_seura_3
10	10	319	2024-04-26 13:37:10.023	755	taivaanranta-tulitus	savu_seura_3
10	10	337.6	2024-04-26 13:37:10.043	756	taivaanranta-tulitus	omas_1
10	10	309.7	2024-04-26 13:37:10.06	757	taivaanranta-tulitus	omas_1
10	10	373.5	2024-04-26 13:37:10.075	758	taivaanranta-tulitus	omas_1
10	10	298.3	2024-04-26 13:37:10.093	759	taivaanranta-tulitus	omas_1
10	10	293.6	2024-04-26 13:37:10.107	760	taivaanranta-tulitus	pelleseura_1
10	10	328.7	2024-04-26 13:37:10.119	761	taivaanranta-tulitus	pelleseura_1
10	10	311.6	2024-04-26 13:37:10.132	762	taivaanranta-tulitus	pelleseura_1
10	10	324	2024-04-26 13:37:10.144	763	taivaanranta-tulitus	pelleseura_1
10	10	328.6	2024-04-26 13:37:10.157	764	taivaanranta-tulitus	pelleseura_1
10	10	353.8	2024-04-26 13:37:10.171	765	taivaanranta-tulitus	pelleseura_2
10	10	344.2	2024-04-26 13:37:10.184	766	taivaanranta-tulitus	pelleseura_2
10	10	330.5	2024-04-26 13:37:10.198	767	taivaanranta-tulitus	pelleseura_2
10	10	364	2024-04-26 13:37:10.21	768	taivaanranta-tulitus	pelleseura_2
10	10	295.3	2024-04-26 13:37:10.226	769	taivaanranta-tulitus	pelleseura_2
10	10	354.6	2024-04-26 13:37:10.238	770	taivaanranta-tulitus	yung_tallent_1
10	10	334.3	2024-04-26 13:37:10.25	771	taivaanranta-tulitus	yung_tallent_1
10	10	281.3	2024-04-26 13:37:10.261	772	taivaanranta-tulitus	yung_tallent_1
10	10	316	2024-04-26 13:37:10.273	773	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
10	10	328.4	2024-04-26 13:37:10.285	774	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
10	10	348.1	2024-04-26 13:37:10.298	775	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
10	10	342.3	2024-04-26 13:37:10.311	776	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
10	10	319.7	2024-04-26 13:37:10.323	777	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_1
10	10	355.7	2024-04-26 13:37:10.336	778	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
10	10	348.1	2024-04-26 13:37:10.349	779	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
10	10	336	2024-04-26 13:37:10.362	780	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
10	10	368.5	2024-04-26 13:37:10.375	781	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
10	10	337.8	2024-04-26 13:37:10.387	782	taivaanranta-tulitus	aseharrastajien_yhtenaisyys_2
10	10	324.8	2024-04-26 13:37:10.402	783	taivaanranta-tulitus	tahtaysmestarit_1
10	10	349.3	2024-04-26 13:37:10.416	784	taivaanranta-tulitus	tahtaysmestarit_1
10	10	309.7	2024-04-26 13:37:10.431	785	taivaanranta-tulitus	tahtaysmestarit_1
10	10	346.4	2024-04-26 13:37:10.446	786	taivaanranta-tulitus	tahtaysmestarit_1
10	10	323.3	2024-04-26 13:37:10.459	787	taivaanranta-tulitus	tahtaysmestarit_1
10	10	321.1	2024-04-26 13:37:10.474	788	taivaanranta-tulitus	laukausryhma_aurora_1
10	10	353.8	2024-04-26 13:37:10.488	789	taivaanranta-tulitus	laukausryhma_aurora_1
10	10	339.4	2024-04-26 13:37:10.501	790	taivaanranta-tulitus	laukausryhma_aurora_1
10	10	327.2	2024-04-26 13:37:10.513	791	taivaanranta-tulitus	laukausryhma_aurora_2
10	10	327.7	2024-04-26 13:37:10.526	792	taivaanranta-tulitus	laukausryhma_aurora_2
10	10	310.3	2024-04-26 13:37:10.538	793	taivaanranta-tulitus	laukausryhma_aurora_2
10	10	305.2	2024-04-26 13:37:10.551	794	taivaanranta-tulitus	laukausryhma_aurora_2
10	10	323.3	2024-04-26 13:37:10.566	795	taivaanranta-tulitus	laukausryhma_aurora_3
10	10	328.3	2024-04-26 13:37:10.579	796	taivaanranta-tulitus	laukausryhma_aurora_3
10	10	308.3	2024-04-26 13:37:10.593	797	taivaanranta-tulitus	laukausryhma_aurora_3
10	10	298	2024-04-26 13:37:10.604	798	taivaanranta-tulitus	ampumataito_1
10	10	384.9	2024-04-26 13:37:10.623	799	taivaanranta-tulitus	ampumataito_1
10	10	331.2	2024-04-26 13:37:10.641	800	taivaanranta-tulitus	ampumataito_1
10	10	334.3	2024-04-26 13:37:10.661	801	taivaanranta-tulitus	ampumataito_1
10	10	319.5	2024-04-26 13:37:10.676	802	lumivyory-ammunta	poliisiseura_1
10	10	333.5	2024-04-26 13:37:10.691	803	lumivyory-ammunta	poliisiseura_1
10	10	335.2	2024-04-26 13:37:10.703	804	lumivyory-ammunta	poliisiseura_1
10	10	325.7	2024-04-26 13:37:10.716	805	lumivyory-ammunta	poliisiseura_1
10	10	375.7	2024-04-26 13:37:10.729	806	lumivyory-ammunta	koiraseura_1
10	10	346.2	2024-04-26 13:37:10.742	807	lumivyory-ammunta	koiraseura_1
10	10	297	2024-04-26 13:37:10.754	808	lumivyory-ammunta	koiraseura_1
10	10	326.6	2024-04-26 13:37:10.765	809	lumivyory-ammunta	koiraseura_2
10	10	339.5	2024-04-26 13:37:10.779	810	lumivyory-ammunta	koiraseura_2
10	10	328.4	2024-04-26 13:37:10.792	811	lumivyory-ammunta	koiraseura_2
10	10	364.3	2024-04-26 13:37:10.803	812	lumivyory-ammunta	koiraseura_2
10	10	317.6	2024-04-26 13:37:10.815	813	lumivyory-ammunta	koiraseura_2
10	10	321.7	2024-04-26 13:37:10.827	814	lumivyory-ammunta	koiraseura_3
10	10	332.2	2024-04-26 13:37:10.841	815	lumivyory-ammunta	koiraseura_3
10	10	347.2	2024-04-26 13:37:10.854	816	lumivyory-ammunta	koiraseura_3
10	10	316.7	2024-04-26 13:37:10.865	817	lumivyory-ammunta	koiraseura_3
10	10	351.4	2024-04-26 13:37:10.877	818	lumivyory-ammunta	hammaspeikkoseura_1
10	10	309.7	2024-04-26 13:37:10.889	819	lumivyory-ammunta	hammaspeikkoseura_1
10	10	313.7	2024-04-26 13:37:10.907	820	lumivyory-ammunta	hammaspeikkoseura_1
10	10	312.4	2024-04-26 13:37:10.919	821	lumivyory-ammunta	hammaspeikkoseura_2
10	10	349.4	2024-04-26 13:37:10.932	822	lumivyory-ammunta	hammaspeikkoseura_2
10	10	339	2024-04-26 13:37:10.945	823	lumivyory-ammunta	hammaspeikkoseura_2
10	10	282.7	2024-04-26 13:37:10.959	824	lumivyory-ammunta	dog_1
10	10	330.4	2024-04-26 13:37:10.974	825	lumivyory-ammunta	dog_1
10	10	355.3	2024-04-26 13:37:10.988	826	lumivyory-ammunta	dog_1
10	10	332.7	2024-04-26 13:37:11.004	827	lumivyory-ammunta	dog_1
10	10	343.1	2024-04-26 13:37:11.02	828	lumivyory-ammunta	dog_1
10	10	319.2	2024-04-26 13:37:11.036	829	lumivyory-ammunta	dog_2
10	10	270.7	2024-04-26 13:37:11.05	830	lumivyory-ammunta	dog_2
10	10	288.8	2024-04-26 13:37:11.065	831	lumivyory-ammunta	dog_2
10	10	356.7	2024-04-26 13:37:11.08	832	lumivyory-ammunta	dog_2
10	10	331.1	2024-04-26 13:37:11.097	833	lumivyory-ammunta	dog_3
10	10	347.2	2024-04-26 13:37:11.112	834	lumivyory-ammunta	dog_3
10	10	312.7	2024-04-26 13:37:11.127	835	lumivyory-ammunta	dog_3
10	10	336.5	2024-04-26 13:37:11.144	836	lumivyory-ammunta	dog_3
10	10	334.2	2024-04-26 13:37:11.16	837	lumivyory-ammunta	savu_seura_1
10	10	348.8	2024-04-26 13:37:11.176	838	lumivyory-ammunta	savu_seura_1
10	10	322.3	2024-04-26 13:37:11.193	839	lumivyory-ammunta	savu_seura_1
10	10	321.3	2024-04-26 13:37:11.212	840	lumivyory-ammunta	savu_seura_1
10	10	326.9	2024-04-26 13:37:11.227	841	lumivyory-ammunta	omas_1
10	10	321.5	2024-04-26 13:37:11.242	842	lumivyory-ammunta	omas_1
10	10	301	2024-04-26 13:37:11.261	843	lumivyory-ammunta	omas_1
10	10	313	2024-04-26 13:37:11.276	844	lumivyory-ammunta	omas_1
10	10	268.4	2024-04-26 13:37:11.289	845	lumivyory-ammunta	omas_1
10	10	303	2024-04-26 13:37:11.302	846	lumivyory-ammunta	omas_2
10	10	335.2	2024-04-26 13:37:11.315	847	lumivyory-ammunta	omas_2
10	10	311.4	2024-04-26 13:37:11.328	848	lumivyory-ammunta	omas_2
10	10	332.6	2024-04-26 13:37:11.344	849	lumivyory-ammunta	omas_2
10	10	333.1	2024-04-26 13:37:11.358	850	lumivyory-ammunta	omas_3
10	10	371.4	2024-04-26 13:37:11.37	851	lumivyory-ammunta	omas_3
10	10	315.3	2024-04-26 13:37:11.382	852	lumivyory-ammunta	omas_3
10	10	329.3	2024-04-26 13:37:11.397	853	lumivyory-ammunta	omas_3
10	10	362.1	2024-04-26 13:37:11.41	854	lumivyory-ammunta	pelleseura_1
10	10	343.7	2024-04-26 13:37:11.424	855	lumivyory-ammunta	pelleseura_1
10	10	342.5	2024-04-26 13:37:11.437	856	lumivyory-ammunta	pelleseura_1
10	10	318.9	2024-04-26 13:37:11.45	857	lumivyory-ammunta	pelleseura_2
10	10	345.5	2024-04-26 13:37:11.465	858	lumivyory-ammunta	pelleseura_2
10	10	362.5	2024-04-26 13:37:11.478	859	lumivyory-ammunta	pelleseura_2
10	10	282.7	2024-04-26 13:37:11.492	860	lumivyory-ammunta	pelleseura_2
10	10	317.6	2024-04-26 13:37:11.505	861	lumivyory-ammunta	pelleseura_2
10	10	277.5	2024-04-26 13:37:11.523	862	lumivyory-ammunta	yung_tallent_1
10	10	291.5	2024-04-26 13:37:11.536	863	lumivyory-ammunta	yung_tallent_1
10	10	286.7	2024-04-26 13:37:11.549	864	lumivyory-ammunta	yung_tallent_1
10	10	321.8	2024-04-26 13:37:11.562	865	lumivyory-ammunta	yung_tallent_1
10	10	341.7	2024-04-26 13:37:11.575	866	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
10	10	314.4	2024-04-26 13:37:11.589	867	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
10	10	339.7	2024-04-26 13:37:11.601	868	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
10	10	327.1	2024-04-26 13:37:11.615	869	lumivyory-ammunta	aseharrastajien_yhtenaisyys_1
10	10	369.7	2024-04-26 13:37:11.627	870	lumivyory-ammunta	tahtaysmestarit_1
10	10	353.3	2024-04-26 13:37:11.643	871	lumivyory-ammunta	tahtaysmestarit_1
10	10	292.8	2024-04-26 13:37:11.657	872	lumivyory-ammunta	tahtaysmestarit_1
10	10	347	2024-04-26 13:37:11.67	873	lumivyory-ammunta	tahtaysmestarit_1
10	10	346	2024-04-26 13:37:11.684	874	lumivyory-ammunta	tahtaysmestarit_1
10	10	319.2	2024-04-26 13:37:11.699	875	lumivyory-ammunta	tahtaysmestarit_2
10	10	352.4	2024-04-26 13:37:11.714	876	lumivyory-ammunta	tahtaysmestarit_2
10	10	325.8	2024-04-26 13:37:11.727	877	lumivyory-ammunta	tahtaysmestarit_2
10	10	329.9	2024-04-26 13:37:11.741	878	lumivyory-ammunta	tahtaysmestarit_2
10	10	371.2	2024-04-26 13:37:11.754	879	lumivyory-ammunta	tahtaysmestarit_2
10	10	316.9	2024-04-26 13:37:11.769	880	lumivyory-ammunta	tahtaysmestarit_3
10	10	340.9	2024-04-26 13:37:11.781	881	lumivyory-ammunta	tahtaysmestarit_3
10	10	349.5	2024-04-26 13:37:11.795	882	lumivyory-ammunta	tahtaysmestarit_3
10	10	307.2	2024-04-26 13:37:11.809	883	lumivyory-ammunta	tahtaysmestarit_3
10	10	346.6	2024-04-26 13:37:11.825	884	lumivyory-ammunta	laukausryhma_aurora_1
10	10	319.1	2024-04-26 13:37:11.84	885	lumivyory-ammunta	laukausryhma_aurora_1
10	10	351.4	2024-04-26 13:37:11.853	886	lumivyory-ammunta	laukausryhma_aurora_1
10	10	347.2	2024-04-26 13:37:11.866	887	lumivyory-ammunta	ampumataito_1
10	10	337.9	2024-04-26 13:37:11.879	888	lumivyory-ammunta	ampumataito_1
10	10	335.3	2024-04-26 13:37:11.892	889	lumivyory-ammunta	ampumataito_1
10	10	315.2	2024-04-26 13:37:11.905	890	lumivyory-ammunta	ampumataito_2
10	10	342.3	2024-04-26 13:37:11.919	891	lumivyory-ammunta	ampumataito_2
10	10	276.2	2024-04-26 13:37:11.933	892	lumivyory-ammunta	ampumataito_2
10	10	327.1	2024-04-26 13:37:11.947	893	lumivyory-ammunta	ampumataito_2
10	10	342.7	2024-04-26 13:37:11.961	894	lumivyory-ammunta	ampumataito_2
10	10	349.1	2024-04-26 13:37:11.974	895	tarkka-ammunta_cup	poliisiseura_1
10	10	322.6	2024-04-26 13:37:11.988	896	tarkka-ammunta_cup	poliisiseura_1
10	10	315.7	2024-04-26 13:37:12.002	897	tarkka-ammunta_cup	poliisiseura_1
10	10	324.3	2024-04-26 13:37:12.017	898	tarkka-ammunta_cup	poliisiseura_1
10	10	299.8	2024-04-26 13:37:12.03	899	tarkka-ammunta_cup	poliisiseura_2
10	10	370.7	2024-04-26 13:37:12.043	900	tarkka-ammunta_cup	poliisiseura_2
10	10	322.5	2024-04-26 13:37:12.055	901	tarkka-ammunta_cup	poliisiseura_2
10	10	301.5	2024-04-26 13:37:12.069	902	tarkka-ammunta_cup	poliisiseura_2
10	10	345	2024-04-26 13:37:12.082	903	tarkka-ammunta_cup	koiraseura_1
10	10	330.4	2024-04-26 13:37:12.095	904	tarkka-ammunta_cup	koiraseura_1
10	10	308.7	2024-04-26 13:37:12.108	905	tarkka-ammunta_cup	koiraseura_1
10	10	303.5	2024-04-26 13:37:12.122	906	tarkka-ammunta_cup	koiraseura_2
10	10	359.9	2024-04-26 13:37:12.136	907	tarkka-ammunta_cup	koiraseura_2
10	10	325.9	2024-04-26 13:37:12.148	908	tarkka-ammunta_cup	koiraseura_2
10	10	293	2024-04-26 13:37:12.162	909	tarkka-ammunta_cup	koiraseura_3
10	10	301.5	2024-04-26 13:37:12.174	910	tarkka-ammunta_cup	koiraseura_3
10	10	278.1	2024-04-26 13:37:12.187	911	tarkka-ammunta_cup	koiraseura_3
10	10	283.1	2024-04-26 13:37:12.2	912	tarkka-ammunta_cup	koiraseura_3
10	10	278.3	2024-04-26 13:37:12.212	913	tarkka-ammunta_cup	koiraseura_3
10	10	307.3	2024-04-26 13:37:12.224	914	tarkka-ammunta_cup	hammaspeikkoseura_1
10	10	327.1	2024-04-26 13:37:12.236	915	tarkka-ammunta_cup	hammaspeikkoseura_1
10	10	287.3	2024-04-26 13:37:12.249	916	tarkka-ammunta_cup	hammaspeikkoseura_1
10	10	336.8	2024-04-26 13:37:12.261	917	tarkka-ammunta_cup	hammaspeikkoseura_1
10	10	356.3	2024-04-26 13:37:12.275	918	tarkka-ammunta_cup	hammaspeikkoseura_1
10	10	317.1	2024-04-26 13:37:12.289	919	tarkka-ammunta_cup	dog_1
10	10	353.6	2024-04-26 13:37:12.303	920	tarkka-ammunta_cup	dog_1
10	10	334.7	2024-04-26 13:37:12.317	921	tarkka-ammunta_cup	dog_1
10	10	309.1	2024-04-26 13:37:12.331	922	tarkka-ammunta_cup	dog_1
10	10	379.6	2024-04-26 13:37:12.343	923	tarkka-ammunta_cup	dog_2
10	10	321.6	2024-04-26 13:37:12.357	924	tarkka-ammunta_cup	dog_2
10	10	345.5	2024-04-26 13:37:12.371	925	tarkka-ammunta_cup	dog_2
10	10	322.7	2024-04-26 13:37:12.385	926	tarkka-ammunta_cup	dog_2
10	10	327.4	2024-04-26 13:37:12.398	927	tarkka-ammunta_cup	dog_2
10	10	332	2024-04-26 13:37:12.411	928	tarkka-ammunta_cup	savu_seura_1
10	10	318.1	2024-04-26 13:37:12.422	929	tarkka-ammunta_cup	savu_seura_1
10	10	279	2024-04-26 13:37:12.436	930	tarkka-ammunta_cup	savu_seura_1
10	10	298.4	2024-04-26 13:37:12.449	931	tarkka-ammunta_cup	savu_seura_1
10	10	378.4	2024-04-26 13:37:12.471	932	tarkka-ammunta_cup	savu_seura_2
10	10	332.1	2024-04-26 13:37:12.501	933	tarkka-ammunta_cup	savu_seura_2
10	10	291.3	2024-04-26 13:37:12.52	934	tarkka-ammunta_cup	savu_seura_2
10	10	315.9	2024-04-26 13:37:12.535	935	tarkka-ammunta_cup	savu_seura_2
10	10	328.8	2024-04-26 13:37:12.547	936	tarkka-ammunta_cup	omas_1
10	10	315.2	2024-04-26 13:37:12.561	937	tarkka-ammunta_cup	omas_1
10	10	349.8	2024-04-26 13:37:12.574	938	tarkka-ammunta_cup	omas_1
10	10	322.1	2024-04-26 13:37:12.587	939	tarkka-ammunta_cup	omas_1
10	10	320.4	2024-04-26 13:37:12.602	940	tarkka-ammunta_cup	omas_1
10	10	324.2	2024-04-26 13:37:12.614	941	tarkka-ammunta_cup	omas_2
10	10	328.3	2024-04-26 13:37:12.627	942	tarkka-ammunta_cup	omas_2
10	10	314.7	2024-04-26 13:37:12.639	943	tarkka-ammunta_cup	omas_2
10	10	330.7	2024-04-26 13:37:12.654	944	tarkka-ammunta_cup	omas_2
10	10	351.2	2024-04-26 13:37:12.667	945	tarkka-ammunta_cup	pelleseura_1
10	10	376.7	2024-04-26 13:37:12.68	946	tarkka-ammunta_cup	pelleseura_1
10	10	336.8	2024-04-26 13:37:12.691	947	tarkka-ammunta_cup	pelleseura_1
10	10	342	2024-04-26 13:37:12.703	948	tarkka-ammunta_cup	pelleseura_1
10	10	363.1	2024-04-26 13:37:12.714	949	tarkka-ammunta_cup	pelleseura_2
10	10	306.1	2024-04-26 13:37:12.727	950	tarkka-ammunta_cup	pelleseura_2
10	10	292.1	2024-04-26 13:37:12.74	951	tarkka-ammunta_cup	pelleseura_2
10	10	345.9	2024-04-26 13:37:12.751	952	tarkka-ammunta_cup	pelleseura_2
10	10	318.7	2024-04-26 13:37:12.764	953	tarkka-ammunta_cup	yung_tallent_1
10	10	295.5	2024-04-26 13:37:12.775	954	tarkka-ammunta_cup	yung_tallent_1
10	10	322	2024-04-26 13:37:12.789	955	tarkka-ammunta_cup	yung_tallent_1
10	10	315.8	2024-04-26 13:37:12.802	956	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
10	10	347.3	2024-04-26 13:37:12.814	957	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
10	10	314.7	2024-04-26 13:37:12.826	958	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
10	10	313.8	2024-04-26 13:37:12.838	959	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
10	10	299.1	2024-04-26 13:37:12.852	960	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_1
10	10	339	2024-04-26 13:37:12.863	961	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
10	10	287.4	2024-04-26 13:37:12.874	962	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
10	10	340.7	2024-04-26 13:37:12.886	963	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
10	10	322.4	2024-04-26 13:37:12.899	964	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_2
10	10	309.1	2024-04-26 13:37:12.914	965	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
10	10	304.8	2024-04-26 13:37:12.926	966	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
10	10	302.1	2024-04-26 13:37:12.938	967	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
10	10	278.6	2024-04-26 13:37:12.951	968	tarkka-ammunta_cup	aseharrastajien_yhtenaisyys_3
10	10	320.8	2024-04-26 13:37:12.963	969	tarkka-ammunta_cup	tahtaysmestarit_1
10	10	320.1	2024-04-26 13:37:12.977	970	tarkka-ammunta_cup	tahtaysmestarit_1
10	10	348.3	2024-04-26 13:37:12.988	971	tarkka-ammunta_cup	tahtaysmestarit_1
10	10	331.2	2024-04-26 13:37:13.001	972	tarkka-ammunta_cup	tahtaysmestarit_2
10	10	329.3	2024-04-26 13:37:13.013	973	tarkka-ammunta_cup	tahtaysmestarit_2
10	10	309.5	2024-04-26 13:37:13.025	974	tarkka-ammunta_cup	tahtaysmestarit_2
10	10	301.4	2024-04-26 13:37:13.038	975	tarkka-ammunta_cup	tahtaysmestarit_2
10	10	329.2	2024-04-26 13:37:13.05	976	tarkka-ammunta_cup	tahtaysmestarit_2
10	10	314.9	2024-04-26 13:37:13.063	977	tarkka-ammunta_cup	tahtaysmestarit_3
10	10	335.2	2024-04-26 13:37:13.076	978	tarkka-ammunta_cup	tahtaysmestarit_3
10	10	276.2	2024-04-26 13:37:13.089	979	tarkka-ammunta_cup	tahtaysmestarit_3
10	10	346	2024-04-26 13:37:13.101	980	tarkka-ammunta_cup	tahtaysmestarit_3
10	10	315	2024-04-26 13:37:13.113	981	tarkka-ammunta_cup	laukausryhma_aurora_1
10	10	312.7	2024-04-26 13:37:13.126	982	tarkka-ammunta_cup	laukausryhma_aurora_1
10	10	287	2024-04-26 13:37:13.138	983	tarkka-ammunta_cup	laukausryhma_aurora_1
10	10	309	2024-04-26 13:37:13.15	984	tarkka-ammunta_cup	laukausryhma_aurora_2
10	10	329.5	2024-04-26 13:37:13.164	985	tarkka-ammunta_cup	laukausryhma_aurora_2
10	10	344.7	2024-04-26 13:37:13.175	986	tarkka-ammunta_cup	laukausryhma_aurora_2
10	10	281.5	2024-04-26 13:37:13.186	987	tarkka-ammunta_cup	laukausryhma_aurora_2
10	10	323.7	2024-04-26 13:37:13.198	988	tarkka-ammunta_cup	laukausryhma_aurora_2
10	10	299.8	2024-04-26 13:37:13.211	989	tarkka-ammunta_cup	ampumataito_1
10	10	321.9	2024-04-26 13:37:13.224	990	tarkka-ammunta_cup	ampumataito_1
10	10	363.8	2024-04-26 13:37:13.235	991	tarkka-ammunta_cup	ampumataito_1
10	10	318.4	2024-04-26 13:37:13.247	992	nopean_laukauksen_mestaruus	poliisiseura_1
10	10	334.2	2024-04-26 13:37:13.259	993	nopean_laukauksen_mestaruus	poliisiseura_1
10	10	310.1	2024-04-26 13:37:13.269	994	nopean_laukauksen_mestaruus	poliisiseura_1
10	10	310.9	2024-04-26 13:37:13.283	995	nopean_laukauksen_mestaruus	poliisiseura_1
10	10	386.5	2024-04-26 13:37:13.295	996	nopean_laukauksen_mestaruus	poliisiseura_1
10	10	309.6	2024-04-26 13:37:13.307	997	nopean_laukauksen_mestaruus	poliisiseura_2
10	10	321.4	2024-04-26 13:37:13.319	998	nopean_laukauksen_mestaruus	poliisiseura_2
10	10	350.2	2024-04-26 13:37:13.331	999	nopean_laukauksen_mestaruus	poliisiseura_2
10	10	316.8	2024-04-26 13:37:13.345	1000	nopean_laukauksen_mestaruus	poliisiseura_2
10	10	324	2024-04-26 13:37:13.357	1001	nopean_laukauksen_mestaruus	koiraseura_1
10	10	333.7	2024-04-26 13:37:13.369	1002	nopean_laukauksen_mestaruus	koiraseura_1
10	10	316	2024-04-26 13:37:13.381	1003	nopean_laukauksen_mestaruus	koiraseura_1
10	10	311.5	2024-04-26 13:37:13.393	1004	nopean_laukauksen_mestaruus	koiraseura_2
10	10	350.6	2024-04-26 13:37:13.406	1005	nopean_laukauksen_mestaruus	koiraseura_2
10	10	314	2024-04-26 13:37:13.418	1006	nopean_laukauksen_mestaruus	koiraseura_2
10	10	361.1	2024-04-26 13:37:13.43	1007	nopean_laukauksen_mestaruus	koiraseura_2
10	10	331.4	2024-04-26 13:37:13.442	1008	nopean_laukauksen_mestaruus	koiraseura_2
10	10	324.3	2024-04-26 13:37:13.454	1009	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
10	10	345	2024-04-26 13:37:13.467	1010	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
10	10	311.3	2024-04-26 13:37:13.479	1011	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
10	10	322.5	2024-04-26 13:37:13.492	1012	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
10	10	325	2024-04-26 13:37:13.504	1013	nopean_laukauksen_mestaruus	hammaspeikkoseura_1
10	10	315.2	2024-04-26 13:37:13.516	1014	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
10	10	336.7	2024-04-26 13:37:13.53	1015	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
10	10	289.1	2024-04-26 13:37:13.542	1016	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
10	10	298.5	2024-04-26 13:37:13.553	1017	nopean_laukauksen_mestaruus	hammaspeikkoseura_2
10	10	330.5	2024-04-26 13:37:13.565	1018	nopean_laukauksen_mestaruus	dog_1
10	10	321.9	2024-04-26 13:37:13.577	1019	nopean_laukauksen_mestaruus	dog_1
10	10	312.8	2024-04-26 13:37:13.59	1020	nopean_laukauksen_mestaruus	dog_1
10	10	320.2	2024-04-26 13:37:13.602	1021	nopean_laukauksen_mestaruus	dog_1
10	10	325.6	2024-04-26 13:37:13.614	1022	nopean_laukauksen_mestaruus	dog_1
10	10	331.6	2024-04-26 13:37:13.626	1023	nopean_laukauksen_mestaruus	dog_2
10	10	328.2	2024-04-26 13:37:13.639	1024	nopean_laukauksen_mestaruus	dog_2
10	10	354.1	2024-04-26 13:37:13.652	1025	nopean_laukauksen_mestaruus	dog_2
10	10	341.6	2024-04-26 13:37:13.664	1026	nopean_laukauksen_mestaruus	dog_3
10	10	297.3	2024-04-26 13:37:13.675	1027	nopean_laukauksen_mestaruus	dog_3
10	10	325.7	2024-04-26 13:37:13.687	1028	nopean_laukauksen_mestaruus	dog_3
10	10	296.1	2024-04-26 13:37:13.699	1029	nopean_laukauksen_mestaruus	dog_3
10	10	378.2	2024-04-26 13:37:13.712	1030	nopean_laukauksen_mestaruus	dog_3
10	10	378.6	2024-04-26 13:37:13.724	1031	nopean_laukauksen_mestaruus	savu_seura_1
10	10	321.1	2024-04-26 13:37:13.745	1032	nopean_laukauksen_mestaruus	savu_seura_1
10	10	289.8	2024-04-26 13:37:13.758	1033	nopean_laukauksen_mestaruus	savu_seura_1
10	10	292.3	2024-04-26 13:37:13.77	1034	nopean_laukauksen_mestaruus	savu_seura_1
10	10	357.8	2024-04-26 13:37:13.782	1035	nopean_laukauksen_mestaruus	savu_seura_2
10	10	328.4	2024-04-26 13:37:13.794	1036	nopean_laukauksen_mestaruus	savu_seura_2
10	10	262	2024-04-26 13:37:13.806	1037	nopean_laukauksen_mestaruus	savu_seura_2
10	10	310.8	2024-04-26 13:37:13.817	1038	nopean_laukauksen_mestaruus	savu_seura_2
10	10	330.7	2024-04-26 13:37:13.83	1039	nopean_laukauksen_mestaruus	savu_seura_2
10	10	276.2	2024-04-26 13:37:13.843	1040	nopean_laukauksen_mestaruus	omas_1
10	10	250.8	2024-04-26 13:37:13.854	1041	nopean_laukauksen_mestaruus	omas_1
10	10	366.2	2024-04-26 13:37:13.866	1042	nopean_laukauksen_mestaruus	omas_1
10	10	381.7	2024-04-26 13:37:13.878	1043	nopean_laukauksen_mestaruus	omas_1
10	10	338.6	2024-04-26 13:37:13.893	1044	nopean_laukauksen_mestaruus	omas_1
10	10	381.2	2024-04-26 13:37:13.905	1045	nopean_laukauksen_mestaruus	pelleseura_1
10	10	326.3	2024-04-26 13:37:13.916	1046	nopean_laukauksen_mestaruus	pelleseura_1
10	10	290.9	2024-04-26 13:37:13.928	1047	nopean_laukauksen_mestaruus	pelleseura_1
10	10	318.2	2024-04-26 13:37:13.94	1048	nopean_laukauksen_mestaruus	pelleseura_1
10	10	320.4	2024-04-26 13:37:13.955	1049	nopean_laukauksen_mestaruus	pelleseura_1
10	10	309.6	2024-04-26 13:37:13.967	1050	nopean_laukauksen_mestaruus	pelleseura_2
10	10	345.3	2024-04-26 13:37:13.979	1051	nopean_laukauksen_mestaruus	pelleseura_2
10	10	355.2	2024-04-26 13:37:13.991	1052	nopean_laukauksen_mestaruus	pelleseura_2
10	10	324.7	2024-04-26 13:37:14.004	1053	nopean_laukauksen_mestaruus	pelleseura_2
10	10	336.6	2024-04-26 13:37:14.018	1054	nopean_laukauksen_mestaruus	pelleseura_2
10	10	329	2024-04-26 13:37:14.032	1055	nopean_laukauksen_mestaruus	pelleseura_3
10	10	299.8	2024-04-26 13:37:14.044	1056	nopean_laukauksen_mestaruus	pelleseura_3
10	10	295.4	2024-04-26 13:37:14.057	1057	nopean_laukauksen_mestaruus	pelleseura_3
10	10	327	2024-04-26 13:37:14.069	1058	nopean_laukauksen_mestaruus	pelleseura_3
10	10	326.4	2024-04-26 13:37:14.081	1059	nopean_laukauksen_mestaruus	pelleseura_3
10	10	344.9	2024-04-26 13:37:14.093	1060	nopean_laukauksen_mestaruus	yung_tallent_1
10	10	261	2024-04-26 13:37:14.105	1061	nopean_laukauksen_mestaruus	yung_tallent_1
10	10	321.5	2024-04-26 13:37:14.116	1062	nopean_laukauksen_mestaruus	yung_tallent_1
10	10	332.4	2024-04-26 13:37:14.127	1063	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
10	10	346.6	2024-04-26 13:37:14.14	1064	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
10	10	361.7	2024-04-26 13:37:14.152	1065	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
10	10	350.6	2024-04-26 13:37:14.163	1066	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_1
10	10	290	2024-04-26 13:37:14.175	1067	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_2
10	10	322.1	2024-04-26 13:37:14.186	1068	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_2
10	10	329	2024-04-26 13:37:14.199	1069	nopean_laukauksen_mestaruus	aseharrastajien_yhtenaisyys_2
10	10	339.3	2024-04-26 13:37:14.211	1070	nopean_laukauksen_mestaruus	tahtaysmestarit_1
10	10	307.5	2024-04-26 13:37:14.223	1071	nopean_laukauksen_mestaruus	tahtaysmestarit_1
10	10	310.6	2024-04-26 13:37:14.235	1072	nopean_laukauksen_mestaruus	tahtaysmestarit_1
10	10	331	2024-04-26 13:37:14.257	1073	nopean_laukauksen_mestaruus	tahtaysmestarit_2
10	10	315	2024-04-26 13:37:14.275	1074	nopean_laukauksen_mestaruus	tahtaysmestarit_2
10	10	358	2024-04-26 13:37:14.291	1075	nopean_laukauksen_mestaruus	tahtaysmestarit_2
10	10	338.7	2024-04-26 13:37:14.305	1076	nopean_laukauksen_mestaruus	tahtaysmestarit_2
10	10	342.6	2024-04-26 13:37:14.321	1077	nopean_laukauksen_mestaruus	tahtaysmestarit_3
10	10	334.7	2024-04-26 13:37:14.334	1078	nopean_laukauksen_mestaruus	tahtaysmestarit_3
10	10	321.2	2024-04-26 13:37:14.345	1079	nopean_laukauksen_mestaruus	tahtaysmestarit_3
10	10	297.5	2024-04-26 13:37:14.357	1080	nopean_laukauksen_mestaruus	tahtaysmestarit_3
10	10	334.7	2024-04-26 13:37:14.369	1081	nopean_laukauksen_mestaruus	tahtaysmestarit_3
10	10	319.6	2024-04-26 13:37:14.383	1082	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
10	10	327.9	2024-04-26 13:37:14.395	1083	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
10	10	321.2	2024-04-26 13:37:14.408	1084	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
10	10	356.8	2024-04-26 13:37:14.419	1085	nopean_laukauksen_mestaruus	laukausryhma_aurora_1
10	10	361.7	2024-04-26 13:37:14.433	1086	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
10	10	293.4	2024-04-26 13:37:14.447	1087	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
10	10	318.8	2024-04-26 13:37:14.461	1088	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
10	10	355.5	2024-04-26 13:37:14.474	1089	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
10	10	344.7	2024-04-26 13:37:14.488	1090	nopean_laukauksen_mestaruus	laukausryhma_aurora_2
10	10	342.5	2024-04-26 13:37:14.501	1091	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
10	10	318.9	2024-04-26 13:37:14.515	1092	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
10	10	332.9	2024-04-26 13:37:14.527	1093	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
10	10	331.8	2024-04-26 13:37:14.54	1094	nopean_laukauksen_mestaruus	laukausryhma_aurora_3
10	10	345.4	2024-04-26 13:37:14.552	1095	nopean_laukauksen_mestaruus	ampumataito_1
10	10	327.2	2024-04-26 13:37:14.567	1096	nopean_laukauksen_mestaruus	ampumataito_1
10	10	296.2	2024-04-26 13:37:14.58	1097	nopean_laukauksen_mestaruus	ampumataito_1
10	10	316	2024-04-26 13:37:14.592	1098	nopean_laukauksen_mestaruus	ampumataito_1
10	10	300.4	2024-04-26 13:37:14.605	1099	nopean_laukauksen_mestaruus	ampumataito_1
10	10	303.2	2024-04-26 13:37:14.616	1100	nopean_laukauksen_mestaruus	ampumataito_2
10	10	328.4	2024-04-26 13:37:14.629	1101	nopean_laukauksen_mestaruus	ampumataito_2
10	10	328.7	2024-04-26 13:37:14.641	1102	nopean_laukauksen_mestaruus	ampumataito_2
10	10	283.6	2024-04-26 13:37:14.655	1103	moniottelu	poliisiseura_1
10	10	340.3	2024-04-26 13:37:14.667	1104	moniottelu	poliisiseura_1
10	10	351.1	2024-04-26 13:37:14.679	1105	moniottelu	poliisiseura_1
10	10	337.8	2024-04-26 13:37:14.694	1106	moniottelu	poliisiseura_1
10	10	320.1	2024-04-26 13:37:14.708	1107	moniottelu	poliisiseura_2
10	10	341.8	2024-04-26 13:37:14.721	1108	moniottelu	poliisiseura_2
10	10	343.5	2024-04-26 13:37:14.733	1109	moniottelu	poliisiseura_2
10	10	324.2	2024-04-26 13:37:14.746	1110	moniottelu	poliisiseura_2
10	10	324.2	2024-04-26 13:37:14.76	1111	moniottelu	poliisiseura_3
10	10	335.8	2024-04-26 13:37:14.772	1112	moniottelu	poliisiseura_3
10	10	298.5	2024-04-26 13:37:14.784	1113	moniottelu	poliisiseura_3
10	10	305.9	2024-04-26 13:37:14.798	1114	moniottelu	poliisiseura_3
10	10	328.7	2024-04-26 13:37:14.812	1115	moniottelu	koiraseura_1
10	10	303.6	2024-04-26 13:37:14.825	1116	moniottelu	koiraseura_1
10	10	335.7	2024-04-26 13:37:14.837	1117	moniottelu	koiraseura_1
10	10	323.6	2024-04-26 13:37:14.848	1118	moniottelu	koiraseura_2
10	10	320.6	2024-04-26 13:37:14.86	1119	moniottelu	koiraseura_2
10	10	333.1	2024-04-26 13:37:14.872	1120	moniottelu	koiraseura_2
10	10	334.2	2024-04-26 13:37:14.886	1121	moniottelu	koiraseura_3
10	10	352.8	2024-04-26 13:37:14.899	1122	moniottelu	koiraseura_3
10	10	342.4	2024-04-26 13:37:14.91	1123	moniottelu	koiraseura_3
10	10	307.6	2024-04-26 13:37:14.922	1124	moniottelu	koiraseura_3
10	10	317.4	2024-04-26 13:37:14.935	1125	moniottelu	hammaspeikkoseura_1
10	10	361.8	2024-04-26 13:37:14.947	1126	moniottelu	hammaspeikkoseura_1
10	10	343.2	2024-04-26 13:37:14.958	1127	moniottelu	hammaspeikkoseura_1
10	10	321.4	2024-04-26 13:37:14.969	1128	moniottelu	hammaspeikkoseura_1
10	10	338.1	2024-04-26 13:37:14.98	1129	moniottelu	hammaspeikkoseura_2
10	10	364.4	2024-04-26 13:37:14.993	1130	moniottelu	hammaspeikkoseura_2
10	10	316.5	2024-04-26 13:37:15.005	1131	moniottelu	hammaspeikkoseura_2
10	10	339.9	2024-04-26 13:37:15.018	1132	moniottelu	hammaspeikkoseura_2
10	10	314	2024-04-26 13:37:15.029	1133	moniottelu	hammaspeikkoseura_2
10	10	314.6	2024-04-26 13:37:15.041	1134	moniottelu	hammaspeikkoseura_3
10	10	339.8	2024-04-26 13:37:15.054	1135	moniottelu	hammaspeikkoseura_3
10	10	350.9	2024-04-26 13:37:15.068	1136	moniottelu	hammaspeikkoseura_3
10	10	264	2024-04-26 13:37:15.079	1137	moniottelu	hammaspeikkoseura_3
10	10	338.9	2024-04-26 13:37:15.09	1138	moniottelu	dog_1
10	10	334.5	2024-04-26 13:37:15.101	1139	moniottelu	dog_1
10	10	321.3	2024-04-26 13:37:15.113	1140	moniottelu	dog_1
10	10	305.8	2024-04-26 13:37:15.126	1141	moniottelu	dog_2
10	10	324.8	2024-04-26 13:37:15.137	1142	moniottelu	dog_2
10	10	335.7	2024-04-26 13:37:15.148	1143	moniottelu	dog_2
10	10	298.2	2024-04-26 13:37:15.159	1144	moniottelu	dog_2
10	10	290.5	2024-04-26 13:37:15.17	1145	moniottelu	savu_seura_1
10	10	342	2024-04-26 13:37:15.183	1146	moniottelu	savu_seura_1
10	10	333.3	2024-04-26 13:37:15.195	1147	moniottelu	savu_seura_1
10	10	359	2024-04-26 13:37:15.207	1148	moniottelu	savu_seura_1
10	10	368.7	2024-04-26 13:37:15.218	1149	moniottelu	savu_seura_1
10	10	272.8	2024-04-26 13:37:15.229	1150	moniottelu	savu_seura_2
10	10	251.1	2024-04-26 13:37:15.243	1151	moniottelu	savu_seura_2
10	10	329.3	2024-04-26 13:37:15.255	1152	moniottelu	savu_seura_2
10	10	308.2	2024-04-26 13:37:15.265	1153	moniottelu	savu_seura_2
10	10	385.6	2024-04-26 13:37:15.277	1154	moniottelu	savu_seura_3
10	10	342	2024-04-26 13:37:15.289	1155	moniottelu	savu_seura_3
10	10	357.1	2024-04-26 13:37:15.302	1156	moniottelu	savu_seura_3
10	10	303.1	2024-04-26 13:37:15.315	1157	moniottelu	omas_1
10	10	309	2024-04-26 13:37:15.326	1158	moniottelu	omas_1
10	10	293.7	2024-04-26 13:37:15.338	1159	moniottelu	omas_1
10	10	347.1	2024-04-26 13:37:15.35	1160	moniottelu	pelleseura_1
10	10	343.9	2024-04-26 13:37:15.364	1161	moniottelu	pelleseura_1
10	10	339.4	2024-04-26 13:37:15.376	1162	moniottelu	pelleseura_1
10	10	317.2	2024-04-26 13:37:15.387	1163	moniottelu	yung_tallent_1
10	10	315.6	2024-04-26 13:37:15.398	1164	moniottelu	yung_tallent_1
10	10	336.7	2024-04-26 13:37:15.41	1165	moniottelu	yung_tallent_1
10	10	310.1	2024-04-26 13:37:15.426	1166	moniottelu	yung_tallent_2
10	10	380.8	2024-04-26 13:37:15.44	1167	moniottelu	yung_tallent_2
10	10	361	2024-04-26 13:37:15.453	1168	moniottelu	yung_tallent_2
10	10	288.8	2024-04-26 13:37:15.465	1169	moniottelu	yung_tallent_2
10	10	365.7	2024-04-26 13:37:15.478	1170	moniottelu	yung_tallent_3
10	10	284.4	2024-04-26 13:37:15.491	1171	moniottelu	yung_tallent_3
10	10	288.8	2024-04-26 13:37:15.507	1172	moniottelu	yung_tallent_3
10	10	311.9	2024-04-26 13:37:15.521	1173	moniottelu	yung_tallent_3
10	10	314	2024-04-26 13:37:15.534	1174	moniottelu	yung_tallent_3
10	10	336.2	2024-04-26 13:37:15.547	1175	moniottelu	aseharrastajien_yhtenaisyys_1
10	10	322.1	2024-04-26 13:37:15.56	1176	moniottelu	aseharrastajien_yhtenaisyys_1
10	10	293.2	2024-04-26 13:37:15.571	1177	moniottelu	aseharrastajien_yhtenaisyys_1
10	10	275.6	2024-04-26 13:37:15.583	1178	moniottelu	aseharrastajien_yhtenaisyys_1
10	10	319	2024-04-26 13:37:15.595	1179	moniottelu	aseharrastajien_yhtenaisyys_1
10	10	367.8	2024-04-26 13:37:15.608	1180	moniottelu	aseharrastajien_yhtenaisyys_2
10	10	308	2024-04-26 13:37:15.621	1181	moniottelu	aseharrastajien_yhtenaisyys_2
10	10	331.3	2024-04-26 13:37:15.633	1182	moniottelu	aseharrastajien_yhtenaisyys_2
10	10	342	2024-04-26 13:37:15.645	1183	moniottelu	aseharrastajien_yhtenaisyys_3
10	10	273.9	2024-04-26 13:37:15.656	1184	moniottelu	aseharrastajien_yhtenaisyys_3
10	10	326.3	2024-04-26 13:37:15.671	1185	moniottelu	aseharrastajien_yhtenaisyys_3
10	10	317	2024-04-26 13:37:15.683	1186	moniottelu	tahtaysmestarit_1
10	10	321.9	2024-04-26 13:37:15.699	1187	moniottelu	tahtaysmestarit_1
10	10	357.3	2024-04-26 13:37:15.722	1188	moniottelu	tahtaysmestarit_1
10	10	334.7	2024-04-26 13:37:15.739	1189	moniottelu	laukausryhma_aurora_1
10	10	302.1	2024-04-26 13:37:15.754	1190	moniottelu	laukausryhma_aurora_1
10	10	333.8	2024-04-26 13:37:15.766	1191	moniottelu	laukausryhma_aurora_1
10	10	293.3	2024-04-26 13:37:15.779	1192	moniottelu	ampumataito_1
10	10	346.1	2024-04-26 13:37:15.791	1193	moniottelu	ampumataito_1
10	10	345.5	2024-04-26 13:37:15.804	1194	moniottelu	ampumataito_1
10	10	340.4	2024-04-26 13:37:15.817	1195	moniottelu	ampumataito_1
10	10	336.9	2024-04-26 13:37:15.829	1196	kansallinen_tahtayskilpailu	poliisiseura_1
10	10	396.5	2024-04-26 13:37:15.841	1197	kansallinen_tahtayskilpailu	poliisiseura_1
10	10	300.6	2024-04-26 13:37:15.854	1198	kansallinen_tahtayskilpailu	poliisiseura_1
10	10	353.8	2024-04-26 13:37:15.868	1199	kansallinen_tahtayskilpailu	poliisiseura_2
10	10	311.7	2024-04-26 13:37:15.879	1200	kansallinen_tahtayskilpailu	poliisiseura_2
10	10	318.3	2024-04-26 13:37:15.891	1201	kansallinen_tahtayskilpailu	poliisiseura_2
10	10	340	2024-04-26 13:37:15.901	1202	kansallinen_tahtayskilpailu	poliisiseura_2
10	10	343.1	2024-04-26 13:37:15.912	1203	kansallinen_tahtayskilpailu	poliisiseura_3
10	10	328.4	2024-04-26 13:37:15.925	1204	kansallinen_tahtayskilpailu	poliisiseura_3
10	10	297.6	2024-04-26 13:37:15.939	1205	kansallinen_tahtayskilpailu	poliisiseura_3
10	10	281.2	2024-04-26 13:37:15.951	1206	kansallinen_tahtayskilpailu	poliisiseura_3
10	10	323.4	2024-04-26 13:37:15.963	1207	kansallinen_tahtayskilpailu	koiraseura_1
10	10	344	2024-04-26 13:37:15.979	1208	kansallinen_tahtayskilpailu	koiraseura_1
10	10	310.5	2024-04-26 13:37:15.993	1209	kansallinen_tahtayskilpailu	koiraseura_1
10	10	317.1	2024-04-26 13:37:16.007	1210	kansallinen_tahtayskilpailu	koiraseura_1
10	10	322.3	2024-04-26 13:37:16.021	1211	kansallinen_tahtayskilpailu	koiraseura_1
10	10	324	2024-04-26 13:37:16.034	1212	kansallinen_tahtayskilpailu	koiraseura_2
10	10	339.4	2024-04-26 13:37:16.048	1213	kansallinen_tahtayskilpailu	koiraseura_2
10	10	300.3	2024-04-26 13:37:16.062	1214	kansallinen_tahtayskilpailu	koiraseura_2
10	10	273.3	2024-04-26 13:37:16.076	1215	kansallinen_tahtayskilpailu	koiraseura_3
10	10	323.1	2024-04-26 13:37:16.09	1216	kansallinen_tahtayskilpailu	koiraseura_3
10	10	354.6	2024-04-26 13:37:16.119	1217	kansallinen_tahtayskilpailu	koiraseura_3
10	10	324	2024-04-26 13:37:16.157	1218	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
10	10	407.9	2024-04-26 13:37:16.178	1219	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
10	10	361.7	2024-04-26 13:37:16.192	1220	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
10	10	369.3	2024-04-26 13:37:16.205	1221	kansallinen_tahtayskilpailu	hammaspeikkoseura_1
10	10	348.3	2024-04-26 13:37:16.217	1222	kansallinen_tahtayskilpailu	dog_1
10	10	342.9	2024-04-26 13:37:16.23	1223	kansallinen_tahtayskilpailu	dog_1
10	10	324.4	2024-04-26 13:37:16.243	1224	kansallinen_tahtayskilpailu	dog_1
10	10	316.4	2024-04-26 13:37:16.255	1225	kansallinen_tahtayskilpailu	dog_1
10	10	292.6	2024-04-26 13:37:16.269	1226	kansallinen_tahtayskilpailu	dog_1
10	10	296.9	2024-04-26 13:37:16.283	1227	kansallinen_tahtayskilpailu	savu_seura_1
10	10	313.9	2024-04-26 13:37:16.296	1228	kansallinen_tahtayskilpailu	savu_seura_1
10	10	341.1	2024-04-26 13:37:16.308	1229	kansallinen_tahtayskilpailu	savu_seura_1
10	10	303.5	2024-04-26 13:37:16.32	1230	kansallinen_tahtayskilpailu	savu_seura_1
10	10	353.2	2024-04-26 13:37:16.333	1231	kansallinen_tahtayskilpailu	savu_seura_2
10	10	393.6	2024-04-26 13:37:16.346	1232	kansallinen_tahtayskilpailu	savu_seura_2
10	10	328.4	2024-04-26 13:37:16.359	1233	kansallinen_tahtayskilpailu	savu_seura_2
10	10	282.3	2024-04-26 13:37:16.372	1234	kansallinen_tahtayskilpailu	savu_seura_2
10	10	307.1	2024-04-26 13:37:16.383	1235	kansallinen_tahtayskilpailu	savu_seura_3
10	10	326	2024-04-26 13:37:16.396	1236	kansallinen_tahtayskilpailu	savu_seura_3
10	10	307.6	2024-04-26 13:37:16.409	1237	kansallinen_tahtayskilpailu	savu_seura_3
10	10	343.3	2024-04-26 13:37:16.421	1238	kansallinen_tahtayskilpailu	omas_1
10	10	341	2024-04-26 13:37:16.435	1239	kansallinen_tahtayskilpailu	omas_1
10	10	326.4	2024-04-26 13:37:16.447	1240	kansallinen_tahtayskilpailu	omas_1
10	10	309.4	2024-04-26 13:37:16.459	1241	kansallinen_tahtayskilpailu	omas_1
10	10	301.8	2024-04-26 13:37:16.474	1242	kansallinen_tahtayskilpailu	pelleseura_1
10	10	362.4	2024-04-26 13:37:16.487	1243	kansallinen_tahtayskilpailu	pelleseura_1
10	10	337.2	2024-04-26 13:37:16.5	1244	kansallinen_tahtayskilpailu	pelleseura_1
10	10	323	2024-04-26 13:37:16.514	1245	kansallinen_tahtayskilpailu	pelleseura_2
10	10	312.5	2024-04-26 13:37:16.527	1246	kansallinen_tahtayskilpailu	pelleseura_2
10	10	303.7	2024-04-26 13:37:16.543	1247	kansallinen_tahtayskilpailu	pelleseura_2
10	10	319.6	2024-04-26 13:37:16.555	1248	kansallinen_tahtayskilpailu	pelleseura_2
10	10	334	2024-04-26 13:37:16.566	1249	kansallinen_tahtayskilpailu	pelleseura_2
10	10	342.8	2024-04-26 13:37:16.577	1250	kansallinen_tahtayskilpailu	yung_tallent_1
10	10	327.8	2024-04-26 13:37:16.589	1251	kansallinen_tahtayskilpailu	yung_tallent_1
10	10	299.2	2024-04-26 13:37:16.602	1252	kansallinen_tahtayskilpailu	yung_tallent_1
10	10	320.3	2024-04-26 13:37:16.615	1253	kansallinen_tahtayskilpailu	yung_tallent_1
10	10	310.1	2024-04-26 13:37:16.628	1254	kansallinen_tahtayskilpailu	yung_tallent_2
10	10	289.9	2024-04-26 13:37:16.64	1255	kansallinen_tahtayskilpailu	yung_tallent_2
10	10	318.3	2024-04-26 13:37:16.655	1256	kansallinen_tahtayskilpailu	yung_tallent_2
10	10	316.7	2024-04-26 13:37:16.668	1257	kansallinen_tahtayskilpailu	yung_tallent_2
10	10	380.8	2024-04-26 13:37:16.681	1258	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_1
10	10	313.4	2024-04-26 13:37:16.693	1259	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_1
10	10	315.7	2024-04-26 13:37:16.706	1260	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_1
10	10	329	2024-04-26 13:37:16.719	1261	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_2
10	10	377.6	2024-04-26 13:37:16.731	1262	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_2
10	10	302.9	2024-04-26 13:37:16.743	1263	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_2
10	10	306.7	2024-04-26 13:37:16.757	1264	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
10	10	287.4	2024-04-26 13:37:16.768	1265	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
10	10	297.9	2024-04-26 13:37:16.781	1266	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
10	10	306.5	2024-04-26 13:37:16.793	1267	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
10	10	287.6	2024-04-26 13:37:16.806	1268	kansallinen_tahtayskilpailu	aseharrastajien_yhtenaisyys_3
10	10	304.6	2024-04-26 13:37:16.818	1269	kansallinen_tahtayskilpailu	tahtaysmestarit_1
10	10	289.7	2024-04-26 13:37:16.829	1270	kansallinen_tahtayskilpailu	tahtaysmestarit_1
10	10	340.7	2024-04-26 13:37:16.843	1271	kansallinen_tahtayskilpailu	tahtaysmestarit_1
10	10	348.1	2024-04-26 13:37:16.854	1272	kansallinen_tahtayskilpailu	tahtaysmestarit_1
10	10	320.9	2024-04-26 13:37:16.867	1273	kansallinen_tahtayskilpailu	laukausryhma_aurora_1
10	10	312.2	2024-04-26 13:37:16.878	1274	kansallinen_tahtayskilpailu	laukausryhma_aurora_1
10	10	338.9	2024-04-26 13:37:16.89	1275	kansallinen_tahtayskilpailu	laukausryhma_aurora_1
10	10	327.8	2024-04-26 13:37:16.904	1276	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
10	10	326.1	2024-04-26 13:37:16.916	1277	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
10	10	282.7	2024-04-26 13:37:16.928	1278	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
10	10	310.8	2024-04-26 13:37:16.941	1279	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
10	10	324.8	2024-04-26 13:37:16.953	1280	kansallinen_tahtayskilpailu	laukausryhma_aurora_2
10	10	343.2	2024-04-26 13:37:16.967	1281	kansallinen_tahtayskilpailu	ampumataito_1
10	10	331.9	2024-04-26 13:37:16.98	1282	kansallinen_tahtayskilpailu	ampumataito_1
10	10	338.4	2024-04-26 13:37:16.992	1283	kansallinen_tahtayskilpailu	ampumataito_1
10	10	313.2	2024-04-26 13:37:17.005	1284	kansallinen_tahtayskilpailu	ampumataito_2
10	10	315.7	2024-04-26 13:37:17.017	1285	kansallinen_tahtayskilpailu	ampumataito_2
10	10	336.7	2024-04-26 13:37:17.029	1286	kansallinen_tahtayskilpailu	ampumataito_2
10	10	292.6	2024-04-26 13:37:17.041	1287	kansallinen_tahtayskilpailu	ampumataito_2
10	10	349.2	2024-04-26 13:37:17.053	1288	kansallinen_tahtayskilpailu	ampumataito_3
10	10	344.4	2024-04-26 13:37:17.064	1289	kansallinen_tahtayskilpailu	ampumataito_3
10	10	359.5	2024-04-26 13:37:17.076	1290	kansallinen_tahtayskilpailu	ampumataito_3
10	10	326.2	2024-04-26 13:37:17.089	1291	kansallinen_tahtayskilpailu	ampumataito_3
10	10	360	2024-04-26 13:37:17.101	1292	kansallinen_tahtayskilpailu	ampumataito_3
10	10	322	2024-04-26 13:37:17.114	1293	kaupunkiammunta-challenge	poliisiseura_1
10	10	315.8	2024-04-26 13:37:17.127	1294	kaupunkiammunta-challenge	poliisiseura_1
10	10	338.5	2024-04-26 13:37:17.141	1295	kaupunkiammunta-challenge	poliisiseura_1
10	10	341.4	2024-04-26 13:37:17.154	1296	kaupunkiammunta-challenge	poliisiseura_1
10	10	321.1	2024-04-26 13:37:17.167	1297	kaupunkiammunta-challenge	poliisiseura_2
10	10	299.3	2024-04-26 13:37:17.18	1298	kaupunkiammunta-challenge	poliisiseura_2
10	10	340.4	2024-04-26 13:37:17.193	1299	kaupunkiammunta-challenge	poliisiseura_2
10	10	325.8	2024-04-26 13:37:17.208	1300	kaupunkiammunta-challenge	poliisiseura_3
10	10	331.2	2024-04-26 13:37:17.221	1301	kaupunkiammunta-challenge	poliisiseura_3
10	10	329.9	2024-04-26 13:37:17.234	1302	kaupunkiammunta-challenge	poliisiseura_3
10	10	285.9	2024-04-26 13:37:17.248	1303	kaupunkiammunta-challenge	koiraseura_1
10	10	318.9	2024-04-26 13:37:17.261	1304	kaupunkiammunta-challenge	koiraseura_1
10	10	365.4	2024-04-26 13:37:17.274	1305	kaupunkiammunta-challenge	koiraseura_1
10	10	392.4	2024-04-26 13:37:17.287	1306	kaupunkiammunta-challenge	koiraseura_2
10	10	317.1	2024-04-26 13:37:17.299	1307	kaupunkiammunta-challenge	koiraseura_2
10	10	353.5	2024-04-26 13:37:17.31	1308	kaupunkiammunta-challenge	koiraseura_2
10	10	328	2024-04-26 13:37:17.322	1309	kaupunkiammunta-challenge	koiraseura_2
10	10	351.8	2024-04-26 13:37:17.336	1310	kaupunkiammunta-challenge	koiraseura_2
10	10	352.8	2024-04-26 13:37:17.349	1311	kaupunkiammunta-challenge	koiraseura_3
10	10	339.9	2024-04-26 13:37:17.361	1312	kaupunkiammunta-challenge	koiraseura_3
10	10	307.7	2024-04-26 13:37:17.372	1313	kaupunkiammunta-challenge	koiraseura_3
10	10	343.9	2024-04-26 13:37:17.384	1314	kaupunkiammunta-challenge	koiraseura_3
10	10	346.9	2024-04-26 13:37:17.397	1315	kaupunkiammunta-challenge	koiraseura_3
10	10	330.5	2024-04-26 13:37:17.409	1316	kaupunkiammunta-challenge	hammaspeikkoseura_1
10	10	305.5	2024-04-26 13:37:17.421	1317	kaupunkiammunta-challenge	hammaspeikkoseura_1
10	10	319.8	2024-04-26 13:37:17.434	1318	kaupunkiammunta-challenge	hammaspeikkoseura_1
10	10	328	2024-04-26 13:37:17.446	1319	kaupunkiammunta-challenge	dog_1
10	10	307.1	2024-04-26 13:37:17.459	1320	kaupunkiammunta-challenge	dog_1
10	10	331.3	2024-04-26 13:37:17.471	1321	kaupunkiammunta-challenge	dog_1
10	10	309.6	2024-04-26 13:37:17.482	1322	kaupunkiammunta-challenge	savu_seura_1
10	10	337	2024-04-26 13:37:17.495	1323	kaupunkiammunta-challenge	savu_seura_1
10	10	349.5	2024-04-26 13:37:17.507	1324	kaupunkiammunta-challenge	savu_seura_1
10	10	367.9	2024-04-26 13:37:17.519	1325	kaupunkiammunta-challenge	omas_1
10	10	340.7	2024-04-26 13:37:17.531	1326	kaupunkiammunta-challenge	omas_1
10	10	305.8	2024-04-26 13:37:17.543	1327	kaupunkiammunta-challenge	omas_1
10	10	312	2024-04-26 13:37:17.554	1328	kaupunkiammunta-challenge	omas_1
10	10	347.7	2024-04-26 13:37:17.566	1329	kaupunkiammunta-challenge	omas_1
10	10	307.6	2024-04-26 13:37:17.579	1330	kaupunkiammunta-challenge	pelleseura_1
10	10	318.9	2024-04-26 13:37:17.591	1331	kaupunkiammunta-challenge	pelleseura_1
10	10	359	2024-04-26 13:37:17.604	1332	kaupunkiammunta-challenge	pelleseura_1
10	10	374.7	2024-04-26 13:37:17.616	1333	kaupunkiammunta-challenge	yung_tallent_1
10	10	343.6	2024-04-26 13:37:17.628	1334	kaupunkiammunta-challenge	yung_tallent_1
10	10	370.3	2024-04-26 13:37:17.641	1335	kaupunkiammunta-challenge	yung_tallent_1
10	10	334.9	2024-04-26 13:37:17.653	1336	kaupunkiammunta-challenge	yung_tallent_1
10	10	356.6	2024-04-26 13:37:17.665	1337	kaupunkiammunta-challenge	yung_tallent_2
10	10	325.3	2024-04-26 13:37:17.676	1338	kaupunkiammunta-challenge	yung_tallent_2
10	10	321	2024-04-26 13:37:17.687	1339	kaupunkiammunta-challenge	yung_tallent_2
10	10	318	2024-04-26 13:37:17.701	1340	kaupunkiammunta-challenge	yung_tallent_2
10	10	304.4	2024-04-26 13:37:17.714	1341	kaupunkiammunta-challenge	yung_tallent_2
10	10	281.3	2024-04-26 13:37:17.727	1342	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
10	10	305.1	2024-04-26 13:37:17.738	1343	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
10	10	343.4	2024-04-26 13:37:17.75	1344	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
10	10	319.1	2024-04-26 13:37:17.764	1345	kaupunkiammunta-challenge	aseharrastajien_yhtenaisyys_1
10	10	269.8	2024-04-26 13:37:17.776	1346	kaupunkiammunta-challenge	tahtaysmestarit_1
10	10	343.3	2024-04-26 13:37:17.787	1347	kaupunkiammunta-challenge	tahtaysmestarit_1
10	10	355.6	2024-04-26 13:37:17.799	1348	kaupunkiammunta-challenge	tahtaysmestarit_1
10	10	315.5	2024-04-26 13:37:17.826	1349	kaupunkiammunta-challenge	tahtaysmestarit_1
10	10	306	2024-04-26 13:37:17.839	1350	kaupunkiammunta-challenge	tahtaysmestarit_1
10	10	346.5	2024-04-26 13:37:17.851	1351	kaupunkiammunta-challenge	laukausryhma_aurora_1
10	10	291.5	2024-04-26 13:37:17.862	1352	kaupunkiammunta-challenge	laukausryhma_aurora_1
10	10	330	2024-04-26 13:37:17.874	1353	kaupunkiammunta-challenge	laukausryhma_aurora_1
10	10	301	2024-04-26 13:37:17.887	1354	kaupunkiammunta-challenge	laukausryhma_aurora_1
10	10	314.1	2024-04-26 13:37:17.898	1355	kaupunkiammunta-challenge	laukausryhma_aurora_1
10	10	335.3	2024-04-26 13:37:17.91	1356	kaupunkiammunta-challenge	laukausryhma_aurora_2
10	10	344.7	2024-04-26 13:37:17.921	1357	kaupunkiammunta-challenge	laukausryhma_aurora_2
10	10	330	2024-04-26 13:37:17.932	1358	kaupunkiammunta-challenge	laukausryhma_aurora_2
10	10	327.6	2024-04-26 13:37:17.946	1359	kaupunkiammunta-challenge	laukausryhma_aurora_2
10	10	303.6	2024-04-26 13:37:17.966	1360	kaupunkiammunta-challenge	laukausryhma_aurora_2
10	10	331.4	2024-04-26 13:37:17.981	1361	kaupunkiammunta-challenge	ampumataito_1
10	10	328	2024-04-26 13:37:18	1362	kaupunkiammunta-challenge	ampumataito_1
10	10	293	2024-04-26 13:37:18.015	1363	kaupunkiammunta-challenge	ampumataito_1
10	10	356.7	2024-04-26 13:37:18.03	1364	kaupunkiammunta-challenge	ampumataito_1
10	10	307.6	2024-04-26 13:37:18.043	1365	kaupunkiammunta-challenge	ampumataito_1
10	10	340.6	2024-04-26 13:37:18.054	1366	kaupunkiammunta-challenge	ampumataito_2
10	10	333.7	2024-04-26 13:37:18.067	1367	kaupunkiammunta-challenge	ampumataito_2
10	10	329.4	2024-04-26 13:37:18.081	1368	kaupunkiammunta-challenge	ampumataito_2
10	10	291.1	2024-04-26 13:37:18.093	1369	kaupunkiammunta-challenge	ampumataito_2
10	10	329.5	2024-04-26 13:37:18.105	1370	kaupunkiammunta-challenge	ampumataito_2
10	10	333.4	2024-04-26 13:37:18.117	1371	laukausmaraton	poliisiseura_1
10	10	344.8	2024-04-26 13:37:18.13	1372	laukausmaraton	poliisiseura_1
10	10	332.3	2024-04-26 13:37:18.143	1373	laukausmaraton	poliisiseura_1
10	10	276	2024-04-26 13:37:18.154	1374	laukausmaraton	poliisiseura_1
10	10	313.5	2024-04-26 13:37:18.167	1375	laukausmaraton	poliisiseura_1
10	10	328.2	2024-04-26 13:37:18.178	1376	laukausmaraton	poliisiseura_2
10	10	351.9	2024-04-26 13:37:18.192	1377	laukausmaraton	poliisiseura_2
10	10	355.3	2024-04-26 13:37:18.204	1378	laukausmaraton	poliisiseura_2
10	10	331.9	2024-04-26 13:37:18.215	1379	laukausmaraton	poliisiseura_2
10	10	343.5	2024-04-26 13:37:18.228	1380	laukausmaraton	poliisiseura_2
10	10	303.6	2024-04-26 13:37:18.238	1381	laukausmaraton	poliisiseura_3
10	10	319.8	2024-04-26 13:37:18.254	1382	laukausmaraton	poliisiseura_3
10	10	354.5	2024-04-26 13:37:18.266	1383	laukausmaraton	poliisiseura_3
10	10	331.6	2024-04-26 13:37:18.278	1384	laukausmaraton	koiraseura_1
10	10	298.6	2024-04-26 13:37:18.29	1385	laukausmaraton	koiraseura_1
10	10	332.4	2024-04-26 13:37:18.302	1386	laukausmaraton	koiraseura_1
10	10	357.3	2024-04-26 13:37:18.315	1387	laukausmaraton	koiraseura_2
10	10	333.9	2024-04-26 13:37:18.329	1388	laukausmaraton	koiraseura_2
10	10	324.5	2024-04-26 13:37:18.343	1389	laukausmaraton	koiraseura_2
10	10	334.3	2024-04-26 13:37:18.354	1390	laukausmaraton	koiraseura_2
10	10	317.8	2024-04-26 13:37:18.366	1391	laukausmaraton	hammaspeikkoseura_1
10	10	389.2	2024-04-26 13:37:18.379	1392	laukausmaraton	hammaspeikkoseura_1
10	10	344.6	2024-04-26 13:37:18.394	1393	laukausmaraton	hammaspeikkoseura_1
10	10	367.7	2024-04-26 13:37:18.408	1394	laukausmaraton	hammaspeikkoseura_1
10	10	307.9	2024-04-26 13:37:18.421	1395	laukausmaraton	dog_1
10	10	347.8	2024-04-26 13:37:18.434	1396	laukausmaraton	dog_1
10	10	306.5	2024-04-26 13:37:18.447	1397	laukausmaraton	dog_1
10	10	366.3	2024-04-26 13:37:18.46	1398	laukausmaraton	dog_1
10	10	336.2	2024-04-26 13:37:18.474	1399	laukausmaraton	dog_2
10	10	304.2	2024-04-26 13:37:18.486	1400	laukausmaraton	dog_2
10	10	296	2024-04-26 13:37:18.501	1401	laukausmaraton	dog_2
10	10	324.1	2024-04-26 13:37:18.514	1402	laukausmaraton	dog_2
10	10	299.7	2024-04-26 13:37:18.527	1403	laukausmaraton	savu_seura_1
10	10	319	2024-04-26 13:37:18.541	1404	laukausmaraton	savu_seura_1
10	10	273.6	2024-04-26 13:37:18.553	1405	laukausmaraton	savu_seura_1
10	10	349.4	2024-04-26 13:37:18.567	1406	laukausmaraton	savu_seura_1
10	10	352.5	2024-04-26 13:37:18.579	1407	laukausmaraton	savu_seura_1
10	10	343.8	2024-04-26 13:37:18.591	1408	laukausmaraton	savu_seura_2
10	10	320.9	2024-04-26 13:37:18.602	1409	laukausmaraton	savu_seura_2
10	10	324.3	2024-04-26 13:37:18.616	1410	laukausmaraton	savu_seura_2
10	10	337.2	2024-04-26 13:37:18.628	1411	laukausmaraton	savu_seura_2
10	10	312.4	2024-04-26 13:37:18.641	1412	laukausmaraton	savu_seura_2
10	10	315.5	2024-04-26 13:37:18.653	1413	laukausmaraton	omas_1
10	10	317.6	2024-04-26 13:37:18.665	1414	laukausmaraton	omas_1
10	10	317.5	2024-04-26 13:37:18.678	1415	laukausmaraton	omas_1
10	10	332.7	2024-04-26 13:37:18.691	1416	laukausmaraton	omas_2
10	10	349.3	2024-04-26 13:37:18.703	1417	laukausmaraton	omas_2
10	10	374.8	2024-04-26 13:37:18.714	1418	laukausmaraton	omas_2
10	10	323.5	2024-04-26 13:37:18.726	1419	laukausmaraton	omas_3
10	10	290.6	2024-04-26 13:37:18.738	1420	laukausmaraton	omas_3
10	10	331.3	2024-04-26 13:37:18.751	1421	laukausmaraton	omas_3
10	10	299.6	2024-04-26 13:37:18.762	1422	laukausmaraton	omas_3
10	10	324	2024-04-26 13:37:18.775	1423	laukausmaraton	pelleseura_1
10	10	347.6	2024-04-26 13:37:18.789	1424	laukausmaraton	pelleseura_1
10	10	317.9	2024-04-26 13:37:18.806	1425	laukausmaraton	pelleseura_1
10	10	331.8	2024-04-26 13:37:18.819	1426	laukausmaraton	pelleseura_1
10	10	305.7	2024-04-26 13:37:18.833	1427	laukausmaraton	pelleseura_2
10	10	318.6	2024-04-26 13:37:18.847	1428	laukausmaraton	pelleseura_2
10	10	350.2	2024-04-26 13:37:18.864	1429	laukausmaraton	pelleseura_2
10	10	335.8	2024-04-26 13:37:18.878	1430	laukausmaraton	yung_tallent_1
10	10	372.3	2024-04-26 13:37:18.892	1431	laukausmaraton	yung_tallent_1
10	10	327	2024-04-26 13:37:18.904	1432	laukausmaraton	yung_tallent_1
10	10	366.1	2024-04-26 13:37:18.915	1433	laukausmaraton	yung_tallent_2
10	10	321.4	2024-04-26 13:37:18.929	1434	laukausmaraton	yung_tallent_2
10	10	352.8	2024-04-26 13:37:18.942	1435	laukausmaraton	yung_tallent_2
10	10	300.6	2024-04-26 13:37:18.955	1436	laukausmaraton	yung_tallent_2
10	10	314.8	2024-04-26 13:37:18.966	1437	laukausmaraton	yung_tallent_3
10	10	362.4	2024-04-26 13:37:18.979	1438	laukausmaraton	yung_tallent_3
10	10	326.2	2024-04-26 13:37:18.993	1439	laukausmaraton	yung_tallent_3
10	10	298.3	2024-04-26 13:37:19.005	1440	laukausmaraton	aseharrastajien_yhtenaisyys_1
10	10	329.5	2024-04-26 13:37:19.017	1441	laukausmaraton	aseharrastajien_yhtenaisyys_1
10	10	292.5	2024-04-26 13:37:19.03	1442	laukausmaraton	aseharrastajien_yhtenaisyys_1
10	10	309.7	2024-04-26 13:37:19.042	1443	laukausmaraton	aseharrastajien_yhtenaisyys_1
10	10	330.1	2024-04-26 13:37:19.055	1444	laukausmaraton	tahtaysmestarit_1
10	10	335.1	2024-04-26 13:37:19.068	1445	laukausmaraton	tahtaysmestarit_1
10	10	359.7	2024-04-26 13:37:19.082	1446	laukausmaraton	tahtaysmestarit_1
10	10	295.9	2024-04-26 13:37:19.093	1447	laukausmaraton	tahtaysmestarit_1
10	10	314.2	2024-04-26 13:37:19.107	1448	laukausmaraton	tahtaysmestarit_1
10	10	350.1	2024-04-26 13:37:19.121	1449	laukausmaraton	tahtaysmestarit_2
10	10	347.5	2024-04-26 13:37:19.133	1450	laukausmaraton	tahtaysmestarit_2
10	10	321.3	2024-04-26 13:37:19.146	1451	laukausmaraton	tahtaysmestarit_2
10	10	331.3	2024-04-26 13:37:19.158	1452	laukausmaraton	tahtaysmestarit_2
10	10	329.2	2024-04-26 13:37:19.172	1453	laukausmaraton	laukausryhma_aurora_1
10	10	327.8	2024-04-26 13:37:19.184	1454	laukausmaraton	laukausryhma_aurora_1
10	10	298.2	2024-04-26 13:37:19.197	1455	laukausmaraton	laukausryhma_aurora_1
10	10	267.5	2024-04-26 13:37:19.208	1456	laukausmaraton	laukausryhma_aurora_1
10	10	331.7	2024-04-26 13:37:19.221	1457	laukausmaraton	laukausryhma_aurora_1
10	10	352.6	2024-04-26 13:37:19.235	1458	laukausmaraton	ampumataito_1
10	10	327.6	2024-04-26 13:37:19.246	1459	laukausmaraton	ampumataito_1
10	10	316.9	2024-04-26 13:37:19.257	1460	laukausmaraton	ampumataito_1
10	10	298.6	2024-04-26 13:37:19.269	1461	laukausmaraton	ampumataito_1
10	10	316.1	2024-04-26 13:37:19.281	1462	laukausmaraton	ampumataito_1
10	10	340.9	2024-04-26 13:37:19.295	1463	laukausmaraton	ampumataito_2
10	10	304.3	2024-04-26 13:37:19.306	1464	laukausmaraton	ampumataito_2
10	10	282.3	2024-04-26 13:37:19.317	1465	laukausmaraton	ampumataito_2
10	10	358.7	2024-04-26 13:37:19.329	1466	laukausmaraton	ampumataito_2
10	10	376.1	2024-04-26 13:37:19.341	1467	vapaa-asekilpailu	poliisiseura_1
10	10	328.2	2024-04-26 13:37:19.354	1468	vapaa-asekilpailu	poliisiseura_1
10	10	323.8	2024-04-26 13:37:19.365	1469	vapaa-asekilpailu	poliisiseura_1
10	10	301.3	2024-04-26 13:37:19.377	1470	vapaa-asekilpailu	poliisiseura_1
10	10	361.8	2024-04-26 13:37:19.387	1471	vapaa-asekilpailu	poliisiseura_1
10	10	319	2024-04-26 13:37:19.399	1472	vapaa-asekilpailu	poliisiseura_2
10	10	338.5	2024-04-26 13:37:19.412	1473	vapaa-asekilpailu	poliisiseura_2
10	10	351.2	2024-04-26 13:37:19.424	1474	vapaa-asekilpailu	poliisiseura_2
10	10	297.3	2024-04-26 13:37:19.435	1475	vapaa-asekilpailu	poliisiseura_2
10	10	315.2	2024-04-26 13:37:19.446	1476	vapaa-asekilpailu	poliisiseura_2
10	10	327.5	2024-04-26 13:37:19.457	1477	vapaa-asekilpailu	poliisiseura_3
10	10	340.1	2024-04-26 13:37:19.469	1478	vapaa-asekilpailu	poliisiseura_3
10	10	311.4	2024-04-26 13:37:19.482	1479	vapaa-asekilpailu	poliisiseura_3
10	10	309.7	2024-04-26 13:37:19.493	1480	vapaa-asekilpailu	poliisiseura_3
10	10	295.5	2024-04-26 13:37:19.504	1481	vapaa-asekilpailu	koiraseura_1
10	10	357.8	2024-04-26 13:37:19.516	1482	vapaa-asekilpailu	koiraseura_1
10	10	359.4	2024-04-26 13:37:19.528	1483	vapaa-asekilpailu	koiraseura_1
10	10	269.2	2024-04-26 13:37:19.54	1484	vapaa-asekilpailu	koiraseura_1
10	10	361.1	2024-04-26 13:37:19.552	1485	vapaa-asekilpailu	koiraseura_1
10	10	354.8	2024-04-26 13:37:19.563	1486	vapaa-asekilpailu	koiraseura_2
10	10	348.9	2024-04-26 13:37:19.574	1487	vapaa-asekilpailu	koiraseura_2
10	10	293.8	2024-04-26 13:37:19.585	1488	vapaa-asekilpailu	koiraseura_2
10	10	364.3	2024-04-26 13:37:19.599	1489	vapaa-asekilpailu	koiraseura_2
10	10	343.1	2024-04-26 13:37:19.612	1490	vapaa-asekilpailu	hammaspeikkoseura_1
10	10	333.8	2024-04-26 13:37:19.623	1491	vapaa-asekilpailu	hammaspeikkoseura_1
10	10	287.1	2024-04-26 13:37:19.634	1492	vapaa-asekilpailu	hammaspeikkoseura_1
10	10	329.5	2024-04-26 13:37:19.646	1493	vapaa-asekilpailu	hammaspeikkoseura_2
10	10	342	2024-04-26 13:37:19.659	1494	vapaa-asekilpailu	hammaspeikkoseura_2
10	10	337.9	2024-04-26 13:37:19.672	1495	vapaa-asekilpailu	hammaspeikkoseura_2
10	10	310	2024-04-26 13:37:19.683	1496	vapaa-asekilpailu	hammaspeikkoseura_3
10	10	364.4	2024-04-26 13:37:19.693	1497	vapaa-asekilpailu	hammaspeikkoseura_3
10	10	305.9	2024-04-26 13:37:19.705	1498	vapaa-asekilpailu	hammaspeikkoseura_3
10	10	330.8	2024-04-26 13:37:19.717	1499	vapaa-asekilpailu	dog_1
10	10	311.2	2024-04-26 13:37:19.73	1500	vapaa-asekilpailu	dog_1
10	10	374.6	2024-04-26 13:37:19.741	1501	vapaa-asekilpailu	dog_1
10	10	339.7	2024-04-26 13:37:19.753	1502	vapaa-asekilpailu	dog_1
10	10	345.7	2024-04-26 13:37:19.765	1503	vapaa-asekilpailu	dog_2
10	10	326.9	2024-04-26 13:37:19.776	1504	vapaa-asekilpailu	dog_2
10	10	320.4	2024-04-26 13:37:19.793	1505	vapaa-asekilpailu	dog_2
10	10	330.9	2024-04-26 13:37:19.808	1506	vapaa-asekilpailu	dog_2
10	10	316.8	2024-04-26 13:37:19.824	1507	vapaa-asekilpailu	dog_2
10	10	292.4	2024-04-26 13:37:19.841	1508	vapaa-asekilpailu	savu_seura_1
10	10	340.1	2024-04-26 13:37:19.857	1509	vapaa-asekilpailu	savu_seura_1
10	10	342.9	2024-04-26 13:37:19.869	1510	vapaa-asekilpailu	savu_seura_1
10	10	299.7	2024-04-26 13:37:19.881	1511	vapaa-asekilpailu	omas_1
10	10	320	2024-04-26 13:37:19.892	1512	vapaa-asekilpailu	omas_1
10	10	290.5	2024-04-26 13:37:19.904	1513	vapaa-asekilpailu	omas_1
10	10	270.8	2024-04-26 13:37:19.917	1514	vapaa-asekilpailu	omas_1
10	10	300.6	2024-04-26 13:37:19.928	1515	vapaa-asekilpailu	omas_1
10	10	341.6	2024-04-26 13:37:19.939	1516	vapaa-asekilpailu	omas_2
10	10	337.1	2024-04-26 13:37:19.951	1517	vapaa-asekilpailu	omas_2
10	10	301.2	2024-04-26 13:37:19.963	1518	vapaa-asekilpailu	omas_2
10	10	352.5	2024-04-26 13:37:19.977	1519	vapaa-asekilpailu	omas_3
10	10	319.7	2024-04-26 13:37:19.987	1520	vapaa-asekilpailu	omas_3
10	10	366.2	2024-04-26 13:37:19.999	1521	vapaa-asekilpailu	omas_3
10	10	342.6	2024-04-26 13:37:20.011	1522	vapaa-asekilpailu	pelleseura_1
10	10	291.2	2024-04-26 13:37:20.024	1523	vapaa-asekilpailu	pelleseura_1
10	10	312.8	2024-04-26 13:37:20.037	1524	vapaa-asekilpailu	pelleseura_1
10	10	363.7	2024-04-26 13:37:20.048	1525	vapaa-asekilpailu	pelleseura_1
10	10	334.4	2024-04-26 13:37:20.061	1526	vapaa-asekilpailu	pelleseura_1
10	10	308.3	2024-04-26 13:37:20.072	1527	vapaa-asekilpailu	yung_tallent_1
10	10	370.2	2024-04-26 13:37:20.084	1528	vapaa-asekilpailu	yung_tallent_1
10	10	338.6	2024-04-26 13:37:20.096	1529	vapaa-asekilpailu	yung_tallent_1
10	10	345.9	2024-04-26 13:37:20.107	1530	vapaa-asekilpailu	yung_tallent_2
10	10	352.9	2024-04-26 13:37:20.118	1531	vapaa-asekilpailu	yung_tallent_2
10	10	383.7	2024-04-26 13:37:20.129	1532	vapaa-asekilpailu	yung_tallent_2
10	10	316.9	2024-04-26 13:37:20.141	1533	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
10	10	337.3	2024-04-26 13:37:20.159	1534	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
10	10	340	2024-04-26 13:37:20.175	1535	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
10	10	316.6	2024-04-26 13:37:20.188	1536	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_1
10	10	340.8	2024-04-26 13:37:20.202	1537	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
10	10	318.6	2024-04-26 13:37:20.22	1538	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
10	10	328.4	2024-04-26 13:37:20.238	1539	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
10	10	341	2024-04-26 13:37:20.251	1540	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
10	10	321	2024-04-26 13:37:20.262	1541	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_2
10	10	320	2024-04-26 13:37:20.276	1542	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_3
10	10	317.5	2024-04-26 13:37:20.288	1543	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_3
10	10	355.8	2024-04-26 13:37:20.3	1544	vapaa-asekilpailu	aseharrastajien_yhtenaisyys_3
10	10	324.4	2024-04-26 13:37:20.311	1545	vapaa-asekilpailu	tahtaysmestarit_1
10	10	334.6	2024-04-26 13:37:20.323	1546	vapaa-asekilpailu	tahtaysmestarit_1
10	10	351.7	2024-04-26 13:37:20.336	1547	vapaa-asekilpailu	tahtaysmestarit_1
10	10	313.3	2024-04-26 13:37:20.347	1548	vapaa-asekilpailu	tahtaysmestarit_2
10	10	305.4	2024-04-26 13:37:20.359	1549	vapaa-asekilpailu	tahtaysmestarit_2
10	10	391.4	2024-04-26 13:37:20.37	1550	vapaa-asekilpailu	tahtaysmestarit_2
10	10	313	2024-04-26 13:37:20.381	1551	vapaa-asekilpailu	laukausryhma_aurora_1
10	10	358.4	2024-04-26 13:37:20.393	1552	vapaa-asekilpailu	laukausryhma_aurora_1
10	10	338.7	2024-04-26 13:37:20.407	1553	vapaa-asekilpailu	laukausryhma_aurora_1
10	10	289.4	2024-04-26 13:37:20.418	1554	vapaa-asekilpailu	laukausryhma_aurora_2
10	10	289.7	2024-04-26 13:37:20.429	1555	vapaa-asekilpailu	laukausryhma_aurora_2
10	10	325	2024-04-26 13:37:20.441	1556	vapaa-asekilpailu	laukausryhma_aurora_2
10	10	334.9	2024-04-26 13:37:20.452	1557	vapaa-asekilpailu	laukausryhma_aurora_2
10	10	358.9	2024-04-26 13:37:20.465	1558	vapaa-asekilpailu	ampumataito_1
10	10	306.4	2024-04-26 13:37:20.476	1559	vapaa-asekilpailu	ampumataito_1
10	10	345.7	2024-04-26 13:37:20.489	1560	vapaa-asekilpailu	ampumataito_1
10	10	350.7	2024-04-26 13:37:20.5	1561	vapaa-asekilpailu	ampumataito_2
10	10	388.7	2024-04-26 13:37:20.51	1562	vapaa-asekilpailu	ampumataito_2
10	10	341.3	2024-04-26 13:37:20.524	1563	vapaa-asekilpailu	ampumataito_2
10	10	288.3	2024-04-26 13:37:20.536	1564	vapaa-asekilpailu	ampumataito_2
10	10	353.2	2024-04-26 13:37:20.549	1565	vapaa-asekilpailu	ampumataito_2
10	10	330.2	2024-04-26 13:37:20.56	1566	vapaa-asekilpailu	ampumataito_3
10	10	350.4	2024-04-26 13:37:20.571	1567	vapaa-asekilpailu	ampumataito_3
10	10	319.5	2024-04-26 13:37:20.584	1568	vapaa-asekilpailu	ampumataito_3
10	10	313.1	2024-04-26 13:37:20.595	1569	taitoluodikko-turnaus	poliisiseura_1
10	10	300.8	2024-04-26 13:37:20.608	1570	taitoluodikko-turnaus	poliisiseura_1
10	10	311.9	2024-04-26 13:37:20.619	1571	taitoluodikko-turnaus	poliisiseura_1
10	10	311.9	2024-04-26 13:37:20.631	1572	taitoluodikko-turnaus	koiraseura_1
10	10	336.4	2024-04-26 13:37:20.643	1573	taitoluodikko-turnaus	koiraseura_1
10	10	332.5	2024-04-26 13:37:20.655	1574	taitoluodikko-turnaus	koiraseura_1
10	10	360.8	2024-04-26 13:37:20.667	1575	taitoluodikko-turnaus	koiraseura_1
10	10	312.5	2024-04-26 13:37:20.678	1576	taitoluodikko-turnaus	koiraseura_2
10	10	276.8	2024-04-26 13:37:20.689	1577	taitoluodikko-turnaus	koiraseura_2
10	10	332.4	2024-04-26 13:37:20.701	1578	taitoluodikko-turnaus	koiraseura_2
10	10	328.8	2024-04-26 13:37:20.714	1579	taitoluodikko-turnaus	hammaspeikkoseura_1
10	10	333.5	2024-04-26 13:37:20.725	1580	taitoluodikko-turnaus	hammaspeikkoseura_1
10	10	342.9	2024-04-26 13:37:20.737	1581	taitoluodikko-turnaus	hammaspeikkoseura_1
10	10	328.1	2024-04-26 13:37:20.749	1582	taitoluodikko-turnaus	hammaspeikkoseura_1
10	10	269.3	2024-04-26 13:37:20.76	1583	taitoluodikko-turnaus	hammaspeikkoseura_1
10	10	324.5	2024-04-26 13:37:20.774	1584	taitoluodikko-turnaus	hammaspeikkoseura_2
10	10	351.1	2024-04-26 13:37:20.785	1585	taitoluodikko-turnaus	hammaspeikkoseura_2
10	10	339	2024-04-26 13:37:20.797	1586	taitoluodikko-turnaus	hammaspeikkoseura_2
10	10	330.8	2024-04-26 13:37:20.809	1587	taitoluodikko-turnaus	hammaspeikkoseura_2
10	10	305.8	2024-04-26 13:37:20.821	1588	taitoluodikko-turnaus	hammaspeikkoseura_2
10	10	345.4	2024-04-26 13:37:20.833	1589	taitoluodikko-turnaus	hammaspeikkoseura_3
10	10	340.1	2024-04-26 13:37:20.844	1590	taitoluodikko-turnaus	hammaspeikkoseura_3
10	10	339.1	2024-04-26 13:37:20.857	1591	taitoluodikko-turnaus	hammaspeikkoseura_3
10	10	299.7	2024-04-26 13:37:20.87	1592	taitoluodikko-turnaus	hammaspeikkoseura_3
10	10	324.4	2024-04-26 13:37:20.881	1593	taitoluodikko-turnaus	hammaspeikkoseura_3
10	10	293.7	2024-04-26 13:37:20.894	1594	taitoluodikko-turnaus	dog_1
10	10	302.3	2024-04-26 13:37:20.907	1595	taitoluodikko-turnaus	dog_1
10	10	363.9	2024-04-26 13:37:20.919	1596	taitoluodikko-turnaus	dog_1
10	10	320.5	2024-04-26 13:37:20.931	1597	taitoluodikko-turnaus	dog_1
10	10	332.6	2024-04-26 13:37:20.943	1598	taitoluodikko-turnaus	dog_1
10	10	347.9	2024-04-26 13:37:20.956	1599	taitoluodikko-turnaus	dog_2
10	10	305.5	2024-04-26 13:37:20.967	1600	taitoluodikko-turnaus	dog_2
10	10	344.7	2024-04-26 13:37:20.98	1601	taitoluodikko-turnaus	dog_2
10	10	333.5	2024-04-26 13:37:20.992	1602	taitoluodikko-turnaus	dog_2
10	10	351	2024-04-26 13:37:21.005	1603	taitoluodikko-turnaus	dog_2
10	10	299.9	2024-04-26 13:37:21.019	1604	taitoluodikko-turnaus	dog_3
10	10	329.2	2024-04-26 13:37:21.032	1605	taitoluodikko-turnaus	dog_3
10	10	310	2024-04-26 13:37:21.046	1606	taitoluodikko-turnaus	dog_3
10	10	334.9	2024-04-26 13:37:21.061	1607	taitoluodikko-turnaus	savu_seura_1
10	10	333.2	2024-04-26 13:37:21.077	1608	taitoluodikko-turnaus	savu_seura_1
10	10	327.8	2024-04-26 13:37:21.091	1609	taitoluodikko-turnaus	savu_seura_1
10	10	311.5	2024-04-26 13:37:21.104	1610	taitoluodikko-turnaus	savu_seura_2
10	10	370.1	2024-04-26 13:37:21.117	1611	taitoluodikko-turnaus	savu_seura_2
10	10	303.5	2024-04-26 13:37:21.129	1612	taitoluodikko-turnaus	savu_seura_2
10	10	341	2024-04-26 13:37:21.144	1613	taitoluodikko-turnaus	savu_seura_2
10	10	343.3	2024-04-26 13:37:21.158	1614	taitoluodikko-turnaus	omas_1
10	10	290.2	2024-04-26 13:37:21.172	1615	taitoluodikko-turnaus	omas_1
10	10	366.7	2024-04-26 13:37:21.185	1616	taitoluodikko-turnaus	omas_1
10	10	353.8	2024-04-26 13:37:21.2	1617	taitoluodikko-turnaus	omas_2
10	10	293.8	2024-04-26 13:37:21.213	1618	taitoluodikko-turnaus	omas_2
10	10	353.7	2024-04-26 13:37:21.227	1619	taitoluodikko-turnaus	omas_2
10	10	359.1	2024-04-26 13:37:21.241	1620	taitoluodikko-turnaus	omas_2
10	10	300.6	2024-04-26 13:37:21.256	1621	taitoluodikko-turnaus	pelleseura_1
10	10	357.3	2024-04-26 13:37:21.271	1622	taitoluodikko-turnaus	pelleseura_1
10	10	333.4	2024-04-26 13:37:21.284	1623	taitoluodikko-turnaus	pelleseura_1
10	10	315.9	2024-04-26 13:37:21.298	1624	taitoluodikko-turnaus	pelleseura_1
10	10	313.5	2024-04-26 13:37:21.312	1625	taitoluodikko-turnaus	pelleseura_2
10	10	351.2	2024-04-26 13:37:21.327	1626	taitoluodikko-turnaus	pelleseura_2
10	10	349	2024-04-26 13:37:21.341	1627	taitoluodikko-turnaus	pelleseura_2
10	10	328.2	2024-04-26 13:37:21.355	1628	taitoluodikko-turnaus	pelleseura_2
10	10	316.6	2024-04-26 13:37:21.367	1629	taitoluodikko-turnaus	pelleseura_3
10	10	327.7	2024-04-26 13:37:21.384	1630	taitoluodikko-turnaus	pelleseura_3
10	10	322.7	2024-04-26 13:37:21.398	1631	taitoluodikko-turnaus	pelleseura_3
10	10	299.7	2024-04-26 13:37:21.412	1632	taitoluodikko-turnaus	pelleseura_3
10	10	313.9	2024-04-26 13:37:21.426	1633	taitoluodikko-turnaus	pelleseura_3
10	10	344.8	2024-04-26 13:37:21.44	1634	taitoluodikko-turnaus	yung_tallent_1
10	10	335.3	2024-04-26 13:37:21.454	1635	taitoluodikko-turnaus	yung_tallent_1
10	10	318.1	2024-04-26 13:37:21.467	1636	taitoluodikko-turnaus	yung_tallent_1
10	10	324.1	2024-04-26 13:37:21.481	1637	taitoluodikko-turnaus	yung_tallent_1
10	10	342.9	2024-04-26 13:37:21.494	1638	taitoluodikko-turnaus	yung_tallent_2
10	10	314.9	2024-04-26 13:37:21.509	1639	taitoluodikko-turnaus	yung_tallent_2
10	10	342	2024-04-26 13:37:21.521	1640	taitoluodikko-turnaus	yung_tallent_2
10	10	305.4	2024-04-26 13:37:21.535	1641	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
10	10	327.2	2024-04-26 13:37:21.549	1642	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
10	10	299.2	2024-04-26 13:37:21.562	1643	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
10	10	288.5	2024-04-26 13:37:21.576	1644	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_1
10	10	360.2	2024-04-26 13:37:21.588	1645	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
10	10	289.1	2024-04-26 13:37:21.605	1646	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
10	10	321.6	2024-04-26 13:37:21.621	1647	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
10	10	363.5	2024-04-26 13:37:21.636	1648	taitoluodikko-turnaus	aseharrastajien_yhtenaisyys_2
10	10	329.6	2024-04-26 13:37:21.652	1649	taitoluodikko-turnaus	tahtaysmestarit_1
10	10	338.5	2024-04-26 13:37:21.665	1650	taitoluodikko-turnaus	tahtaysmestarit_1
10	10	334.1	2024-04-26 13:37:21.677	1651	taitoluodikko-turnaus	tahtaysmestarit_1
10	10	291.2	2024-04-26 13:37:21.69	1652	taitoluodikko-turnaus	tahtaysmestarit_1
10	10	360	2024-04-26 13:37:21.705	1653	taitoluodikko-turnaus	tahtaysmestarit_2
10	10	304.6	2024-04-26 13:37:21.721	1654	taitoluodikko-turnaus	tahtaysmestarit_2
10	10	347.3	2024-04-26 13:37:21.739	1655	taitoluodikko-turnaus	tahtaysmestarit_2
10	10	311.5	2024-04-26 13:37:21.754	1656	taitoluodikko-turnaus	tahtaysmestarit_2
10	10	330.3	2024-04-26 13:37:21.766	1657	taitoluodikko-turnaus	tahtaysmestarit_3
10	10	342	2024-04-26 13:37:21.779	1658	taitoluodikko-turnaus	tahtaysmestarit_3
10	10	345.5	2024-04-26 13:37:21.79	1659	taitoluodikko-turnaus	tahtaysmestarit_3
10	10	308.4	2024-04-26 13:37:21.803	1660	taitoluodikko-turnaus	tahtaysmestarit_3
10	10	384.3	2024-04-26 13:37:21.816	1661	taitoluodikko-turnaus	tahtaysmestarit_3
10	10	341	2024-04-26 13:37:21.827	1662	taitoluodikko-turnaus	laukausryhma_aurora_1
10	10	331.8	2024-04-26 13:37:21.839	1663	taitoluodikko-turnaus	laukausryhma_aurora_1
10	10	339.7	2024-04-26 13:37:21.852	1664	taitoluodikko-turnaus	laukausryhma_aurora_1
10	10	342.8	2024-04-26 13:37:21.863	1665	taitoluodikko-turnaus	laukausryhma_aurora_1
10	10	299.9	2024-04-26 13:37:21.876	1666	taitoluodikko-turnaus	laukausryhma_aurora_2
10	10	327.3	2024-04-26 13:37:21.889	1667	taitoluodikko-turnaus	laukausryhma_aurora_2
10	10	318.7	2024-04-26 13:37:21.902	1668	taitoluodikko-turnaus	laukausryhma_aurora_2
10	10	333.3	2024-04-26 13:37:21.914	1669	taitoluodikko-turnaus	ampumataito_1
10	10	322.7	2024-04-26 13:37:21.927	1670	taitoluodikko-turnaus	ampumataito_1
10	10	339.3	2024-04-26 13:37:21.94	1671	taitoluodikko-turnaus	ampumataito_1
10	10	326.3	2024-04-26 13:37:21.951	1672	taitoluodikko-turnaus	ampumataito_1
10	10	352.1	2024-04-26 13:37:21.962	1673	taitoluodikko-turnaus	ampumataito_2
10	10	320.6	2024-04-26 13:37:21.974	1674	taitoluodikko-turnaus	ampumataito_2
10	10	318.1	2024-04-26 13:37:21.985	1675	taitoluodikko-turnaus	ampumataito_2
10	10	321.8	2024-04-26 13:37:21.998	1676	taitoluodikko-turnaus	ampumataito_2
10	10	342.1	2024-04-26 13:37:22.008	1677	taitoluodikko-turnaus	ampumataito_2
10	10	353.2	2024-04-26 13:37:22.021	1678	precision_pistol_cup	poliisiseura_1
10	10	318	2024-04-26 13:37:22.033	1679	precision_pistol_cup	poliisiseura_1
10	10	352.2	2024-04-26 13:37:22.043	1680	precision_pistol_cup	poliisiseura_1
10	10	326.2	2024-04-26 13:37:22.058	1681	precision_pistol_cup	poliisiseura_1
10	10	338.8	2024-04-26 13:37:22.071	1682	precision_pistol_cup	poliisiseura_2
10	10	374.7	2024-04-26 13:37:22.083	1683	precision_pistol_cup	poliisiseura_2
10	10	348.1	2024-04-26 13:37:22.095	1684	precision_pistol_cup	poliisiseura_2
10	10	287.5	2024-04-26 13:37:22.106	1685	precision_pistol_cup	poliisiseura_2
10	10	321	2024-04-26 13:37:22.119	1686	precision_pistol_cup	koiraseura_1
10	10	314.1	2024-04-26 13:37:22.13	1687	precision_pistol_cup	koiraseura_1
10	10	378	2024-04-26 13:37:22.142	1688	precision_pistol_cup	koiraseura_1
10	10	350.8	2024-04-26 13:37:22.153	1689	precision_pistol_cup	koiraseura_1
10	10	353.3	2024-04-26 13:37:22.164	1690	precision_pistol_cup	koiraseura_2
10	10	333.4	2024-04-26 13:37:22.177	1691	precision_pistol_cup	koiraseura_2
10	10	378.5	2024-04-26 13:37:22.189	1692	precision_pistol_cup	koiraseura_2
10	10	326.9	2024-04-26 13:37:22.199	1693	precision_pistol_cup	hammaspeikkoseura_1
10	10	289.6	2024-04-26 13:37:22.211	1694	precision_pistol_cup	hammaspeikkoseura_1
10	10	320.9	2024-04-26 13:37:22.223	1695	precision_pistol_cup	hammaspeikkoseura_1
10	10	323.6	2024-04-26 13:37:22.238	1696	precision_pistol_cup	hammaspeikkoseura_1
10	10	328.3	2024-04-26 13:37:22.251	1697	precision_pistol_cup	hammaspeikkoseura_1
10	10	301	2024-04-26 13:37:22.262	1698	precision_pistol_cup	hammaspeikkoseura_2
10	10	372.8	2024-04-26 13:37:22.274	1699	precision_pistol_cup	hammaspeikkoseura_2
10	10	308.9	2024-04-26 13:37:22.285	1700	precision_pistol_cup	hammaspeikkoseura_2
10	10	320.1	2024-04-26 13:37:22.298	1701	precision_pistol_cup	hammaspeikkoseura_3
10	10	290.2	2024-04-26 13:37:22.309	1702	precision_pistol_cup	hammaspeikkoseura_3
10	10	333.3	2024-04-26 13:37:22.32	1703	precision_pistol_cup	hammaspeikkoseura_3
10	10	325.2	2024-04-26 13:37:22.332	1704	precision_pistol_cup	dog_1
10	10	260.2	2024-04-26 13:37:22.344	1705	precision_pistol_cup	dog_1
10	10	311.3	2024-04-26 13:37:22.358	1706	precision_pistol_cup	dog_1
10	10	282.5	2024-04-26 13:37:22.371	1707	precision_pistol_cup	dog_1
10	10	337.1	2024-04-26 13:37:22.383	1708	precision_pistol_cup	dog_2
10	10	363.8	2024-04-26 13:37:22.394	1709	precision_pistol_cup	dog_2
10	10	338.3	2024-04-26 13:37:22.405	1710	precision_pistol_cup	dog_2
10	10	315.8	2024-04-26 13:37:22.417	1711	precision_pistol_cup	dog_2
10	10	343.6	2024-04-26 13:37:22.429	1712	precision_pistol_cup	savu_seura_1
10	10	313	2024-04-26 13:37:22.442	1713	precision_pistol_cup	savu_seura_1
10	10	328.1	2024-04-26 13:37:22.453	1714	precision_pistol_cup	savu_seura_1
10	10	295.5	2024-04-26 13:37:22.465	1715	precision_pistol_cup	savu_seura_1
10	10	303.2	2024-04-26 13:37:22.476	1716	precision_pistol_cup	savu_seura_1
10	10	310.2	2024-04-26 13:37:22.489	1717	precision_pistol_cup	savu_seura_2
10	10	355.8	2024-04-26 13:37:22.499	1718	precision_pistol_cup	savu_seura_2
10	10	337.8	2024-04-26 13:37:22.51	1719	precision_pistol_cup	savu_seura_2
10	10	337.8	2024-04-26 13:37:22.521	1720	precision_pistol_cup	savu_seura_2
10	10	307	2024-04-26 13:37:22.533	1721	precision_pistol_cup	savu_seura_2
10	10	347.3	2024-04-26 13:37:22.547	1722	precision_pistol_cup	savu_seura_3
10	10	326.8	2024-04-26 13:37:22.558	1723	precision_pistol_cup	savu_seura_3
10	10	295.2	2024-04-26 13:37:22.57	1724	precision_pistol_cup	savu_seura_3
10	10	343.2	2024-04-26 13:37:22.58	1725	precision_pistol_cup	savu_seura_3
10	10	319.6	2024-04-26 13:37:22.592	1726	precision_pistol_cup	savu_seura_3
10	10	335.8	2024-04-26 13:37:22.604	1727	precision_pistol_cup	omas_1
10	10	328.7	2024-04-26 13:37:22.616	1728	precision_pistol_cup	omas_1
10	10	315.2	2024-04-26 13:37:22.627	1729	precision_pistol_cup	omas_1
10	10	367.5	2024-04-26 13:37:22.638	1730	precision_pistol_cup	pelleseura_1
10	10	303.6	2024-04-26 13:37:22.649	1731	precision_pistol_cup	pelleseura_1
10	10	358	2024-04-26 13:37:22.659	1732	precision_pistol_cup	pelleseura_1
10	10	340.8	2024-04-26 13:37:22.671	1733	precision_pistol_cup	pelleseura_2
10	10	301.6	2024-04-26 13:37:22.683	1734	precision_pistol_cup	pelleseura_2
10	10	316.9	2024-04-26 13:37:22.694	1735	precision_pistol_cup	pelleseura_2
10	10	381.9	2024-04-26 13:37:22.705	1736	precision_pistol_cup	pelleseura_2
10	10	324.6	2024-04-26 13:37:22.715	1737	precision_pistol_cup	pelleseura_2
10	10	324.7	2024-04-26 13:37:22.728	1738	precision_pistol_cup	yung_tallent_1
10	10	333.3	2024-04-26 13:37:22.739	1739	precision_pistol_cup	yung_tallent_1
10	10	328.3	2024-04-26 13:37:22.75	1740	precision_pistol_cup	yung_tallent_1
10	10	338.6	2024-04-26 13:37:22.761	1741	precision_pistol_cup	yung_tallent_2
10	10	363.5	2024-04-26 13:37:22.773	1742	precision_pistol_cup	yung_tallent_2
10	10	342	2024-04-26 13:37:22.784	1743	precision_pistol_cup	yung_tallent_2
10	10	335.6	2024-04-26 13:37:22.798	1744	precision_pistol_cup	yung_tallent_3
10	10	357.1	2024-04-26 13:37:22.808	1745	precision_pistol_cup	yung_tallent_3
10	10	352	2024-04-26 13:37:22.819	1746	precision_pistol_cup	yung_tallent_3
10	10	360.3	2024-04-26 13:37:22.831	1747	precision_pistol_cup	yung_tallent_3
10	10	372.1	2024-04-26 13:37:22.843	1748	precision_pistol_cup	yung_tallent_3
10	10	341.5	2024-04-26 13:37:22.857	1749	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
10	10	318.9	2024-04-26 13:37:22.868	1750	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
10	10	298.5	2024-04-26 13:37:22.879	1751	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
10	10	350.7	2024-04-26 13:37:22.891	1752	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
10	10	286.2	2024-04-26 13:37:22.903	1753	precision_pistol_cup	aseharrastajien_yhtenaisyys_1
10	10	309	2024-04-26 13:37:22.918	1754	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
10	10	280.7	2024-04-26 13:37:22.929	1755	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
10	10	349	2024-04-26 13:37:22.941	1756	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
10	10	329.4	2024-04-26 13:37:22.952	1757	precision_pistol_cup	aseharrastajien_yhtenaisyys_2
10	10	328	2024-04-26 13:37:22.964	1758	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
10	10	333.1	2024-04-26 13:37:22.978	1759	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
10	10	335.6	2024-04-26 13:37:22.989	1760	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
10	10	331.1	2024-04-26 13:37:23.002	1761	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
10	10	300.9	2024-04-26 13:37:23.013	1762	precision_pistol_cup	aseharrastajien_yhtenaisyys_3
10	10	361.3	2024-04-26 13:37:23.025	1763	precision_pistol_cup	tahtaysmestarit_1
10	10	327.6	2024-04-26 13:37:23.039	1764	precision_pistol_cup	tahtaysmestarit_1
10	10	371.8	2024-04-26 13:37:23.051	1765	precision_pistol_cup	tahtaysmestarit_1
10	10	364.3	2024-04-26 13:37:23.062	1766	precision_pistol_cup	tahtaysmestarit_1
10	10	271.3	2024-04-26 13:37:23.073	1767	precision_pistol_cup	tahtaysmestarit_1
10	10	314.5	2024-04-26 13:37:23.087	1768	precision_pistol_cup	laukausryhma_aurora_1
10	10	334.4	2024-04-26 13:37:23.103	1769	precision_pistol_cup	laukausryhma_aurora_1
10	10	325	2024-04-26 13:37:23.115	1770	precision_pistol_cup	laukausryhma_aurora_1
10	10	354.9	2024-04-26 13:37:23.126	1771	precision_pistol_cup	laukausryhma_aurora_1
10	10	353.3	2024-04-26 13:37:23.138	1772	precision_pistol_cup	laukausryhma_aurora_2
10	10	337	2024-04-26 13:37:23.15	1773	precision_pistol_cup	laukausryhma_aurora_2
10	10	305.6	2024-04-26 13:37:23.164	1774	precision_pistol_cup	laukausryhma_aurora_2
10	10	337.4	2024-04-26 13:37:23.176	1775	precision_pistol_cup	laukausryhma_aurora_2
10	10	375.7	2024-04-26 13:37:23.189	1776	precision_pistol_cup	laukausryhma_aurora_2
10	10	377	2024-04-26 13:37:23.2	1777	precision_pistol_cup	laukausryhma_aurora_3
10	10	315.2	2024-04-26 13:37:23.214	1778	precision_pistol_cup	laukausryhma_aurora_3
10	10	312.2	2024-04-26 13:37:23.228	1779	precision_pistol_cup	laukausryhma_aurora_3
10	10	337	2024-04-26 13:37:23.241	1780	precision_pistol_cup	laukausryhma_aurora_3
10	10	321.4	2024-04-26 13:37:23.253	1781	precision_pistol_cup	laukausryhma_aurora_3
10	10	374.7	2024-04-26 13:37:23.265	1782	precision_pistol_cup	ampumataito_1
10	10	357.7	2024-04-26 13:37:23.278	1783	precision_pistol_cup	ampumataito_1
10	10	333.8	2024-04-26 13:37:23.291	1784	precision_pistol_cup	ampumataito_1
10	10	351.8	2024-04-26 13:37:23.302	1785	precision_pistol_cup	ampumataito_1
10	10	325.6	2024-04-26 13:37:23.315	1786	precision_pistol_cup	ampumataito_1
10	10	304.1	2024-04-26 13:37:23.326	1787	tulevaisuuden_ampuja	poliisiseura_1
10	10	363.3	2024-04-26 13:37:23.338	1788	tulevaisuuden_ampuja	poliisiseura_1
10	10	353.9	2024-04-26 13:37:23.351	1789	tulevaisuuden_ampuja	poliisiseura_1
10	10	324.2	2024-04-26 13:37:23.365	1790	tulevaisuuden_ampuja	koiraseura_1
10	10	369	2024-04-26 13:37:23.377	1791	tulevaisuuden_ampuja	koiraseura_1
10	10	341.1	2024-04-26 13:37:23.391	1792	tulevaisuuden_ampuja	koiraseura_1
10	10	329.1	2024-04-26 13:37:23.418	1793	tulevaisuuden_ampuja	koiraseura_1
10	10	327.2	2024-04-26 13:37:23.436	1794	tulevaisuuden_ampuja	koiraseura_1
10	10	288.8	2024-04-26 13:37:23.454	1795	tulevaisuuden_ampuja	hammaspeikkoseura_1
10	10	304.2	2024-04-26 13:37:23.47	1796	tulevaisuuden_ampuja	hammaspeikkoseura_1
10	10	283.3	2024-04-26 13:37:23.486	1797	tulevaisuuden_ampuja	hammaspeikkoseura_1
10	10	254.3	2024-04-26 13:37:23.501	1798	tulevaisuuden_ampuja	hammaspeikkoseura_1
10	10	329.9	2024-04-26 13:37:23.514	1799	tulevaisuuden_ampuja	hammaspeikkoseura_2
10	10	293.9	2024-04-26 13:37:23.53	1800	tulevaisuuden_ampuja	hammaspeikkoseura_2
10	10	356.1	2024-04-26 13:37:23.543	1801	tulevaisuuden_ampuja	hammaspeikkoseura_2
10	10	296.8	2024-04-26 13:37:23.555	1802	tulevaisuuden_ampuja	hammaspeikkoseura_2
10	10	361.1	2024-04-26 13:37:23.567	1803	tulevaisuuden_ampuja	hammaspeikkoseura_3
10	10	328.5	2024-04-26 13:37:23.58	1804	tulevaisuuden_ampuja	hammaspeikkoseura_3
10	10	317.3	2024-04-26 13:37:23.594	1805	tulevaisuuden_ampuja	hammaspeikkoseura_3
10	10	352	2024-04-26 13:37:23.606	1806	tulevaisuuden_ampuja	dog_1
10	10	350.4	2024-04-26 13:37:23.618	1807	tulevaisuuden_ampuja	dog_1
10	10	311	2024-04-26 13:37:23.63	1808	tulevaisuuden_ampuja	dog_1
10	10	337.5	2024-04-26 13:37:23.643	1809	tulevaisuuden_ampuja	dog_1
10	10	307.3	2024-04-26 13:37:23.658	1810	tulevaisuuden_ampuja	savu_seura_1
10	10	340.4	2024-04-26 13:37:23.668	1811	tulevaisuuden_ampuja	savu_seura_1
10	10	347.4	2024-04-26 13:37:23.681	1812	tulevaisuuden_ampuja	savu_seura_1
10	10	280.8	2024-04-26 13:37:23.692	1813	tulevaisuuden_ampuja	savu_seura_1
10	10	291.8	2024-04-26 13:37:23.704	1814	tulevaisuuden_ampuja	savu_seura_2
10	10	362.9	2024-04-26 13:37:23.718	1815	tulevaisuuden_ampuja	savu_seura_2
10	10	333.9	2024-04-26 13:37:23.73	1816	tulevaisuuden_ampuja	savu_seura_2
10	10	315.8	2024-04-26 13:37:23.742	1817	tulevaisuuden_ampuja	savu_seura_2
10	10	314.8	2024-04-26 13:37:23.753	1818	tulevaisuuden_ampuja	savu_seura_2
10	10	356	2024-04-26 13:37:23.765	1819	tulevaisuuden_ampuja	savu_seura_3
10	10	356.6	2024-04-26 13:37:23.779	1820	tulevaisuuden_ampuja	savu_seura_3
10	10	305.8	2024-04-26 13:37:23.791	1821	tulevaisuuden_ampuja	savu_seura_3
10	10	298.8	2024-04-26 13:37:23.802	1822	tulevaisuuden_ampuja	omas_1
10	10	322.2	2024-04-26 13:37:23.814	1823	tulevaisuuden_ampuja	omas_1
10	10	337	2024-04-26 13:37:23.827	1824	tulevaisuuden_ampuja	omas_1
10	10	307.7	2024-04-26 13:37:23.84	1825	tulevaisuuden_ampuja	omas_1
10	10	311.9	2024-04-26 13:37:23.852	1826	tulevaisuuden_ampuja	omas_1
10	10	322.5	2024-04-26 13:37:23.865	1827	tulevaisuuden_ampuja	pelleseura_1
10	10	326.5	2024-04-26 13:37:23.876	1828	tulevaisuuden_ampuja	pelleseura_1
10	10	322.3	2024-04-26 13:37:23.889	1829	tulevaisuuden_ampuja	pelleseura_1
10	10	298.8	2024-04-26 13:37:23.903	1830	tulevaisuuden_ampuja	pelleseura_1
10	10	322.8	2024-04-26 13:37:23.914	1831	tulevaisuuden_ampuja	pelleseura_1
10	10	326.6	2024-04-26 13:37:23.925	1832	tulevaisuuden_ampuja	pelleseura_2
10	10	324.5	2024-04-26 13:37:23.937	1833	tulevaisuuden_ampuja	pelleseura_2
10	10	329.7	2024-04-26 13:37:23.95	1834	tulevaisuuden_ampuja	pelleseura_2
10	10	373.1	2024-04-26 13:37:23.963	1835	tulevaisuuden_ampuja	yung_tallent_1
10	10	341.8	2024-04-26 13:37:23.975	1836	tulevaisuuden_ampuja	yung_tallent_1
10	10	316.7	2024-04-26 13:37:23.987	1837	tulevaisuuden_ampuja	yung_tallent_1
10	10	350.7	2024-04-26 13:37:24	1838	tulevaisuuden_ampuja	yung_tallent_1
10	10	329	2024-04-26 13:37:24.012	1839	tulevaisuuden_ampuja	yung_tallent_1
10	10	354.7	2024-04-26 13:37:24.024	1840	tulevaisuuden_ampuja	yung_tallent_2
10	10	295.7	2024-04-26 13:37:24.035	1841	tulevaisuuden_ampuja	yung_tallent_2
10	10	249	2024-04-26 13:37:24.046	1842	tulevaisuuden_ampuja	yung_tallent_2
10	10	344.9	2024-04-26 13:37:24.058	1843	tulevaisuuden_ampuja	yung_tallent_2
10	10	332.2	2024-04-26 13:37:24.07	1844	tulevaisuuden_ampuja	yung_tallent_2
10	10	317.3	2024-04-26 13:37:24.082	1845	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_1
10	10	329.2	2024-04-26 13:37:24.094	1846	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_1
10	10	314.3	2024-04-26 13:37:24.106	1847	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_1
10	10	318.4	2024-04-26 13:37:24.118	1848	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
10	10	352.8	2024-04-26 13:37:24.128	1849	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
10	10	320.3	2024-04-26 13:37:24.14	1850	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
10	10	288.4	2024-04-26 13:37:24.152	1851	tulevaisuuden_ampuja	aseharrastajien_yhtenaisyys_2
10	10	337.7	2024-04-26 13:37:24.163	1852	tulevaisuuden_ampuja	tahtaysmestarit_1
10	10	312.4	2024-04-26 13:37:24.175	1853	tulevaisuuden_ampuja	tahtaysmestarit_1
10	10	335.8	2024-04-26 13:37:24.187	1854	tulevaisuuden_ampuja	tahtaysmestarit_1
10	10	334	2024-04-26 13:37:24.2	1855	tulevaisuuden_ampuja	tahtaysmestarit_2
10	10	323.4	2024-04-26 13:37:24.212	1856	tulevaisuuden_ampuja	tahtaysmestarit_2
10	10	334.5	2024-04-26 13:37:24.223	1857	tulevaisuuden_ampuja	tahtaysmestarit_2
10	10	330.7	2024-04-26 13:37:24.235	1858	tulevaisuuden_ampuja	tahtaysmestarit_2
10	10	324.8	2024-04-26 13:37:24.246	1859	tulevaisuuden_ampuja	tahtaysmestarit_3
10	10	324	2024-04-26 13:37:24.258	1860	tulevaisuuden_ampuja	tahtaysmestarit_3
10	10	292.7	2024-04-26 13:37:24.272	1861	tulevaisuuden_ampuja	tahtaysmestarit_3
10	10	348.5	2024-04-26 13:37:24.284	1862	tulevaisuuden_ampuja	tahtaysmestarit_3
10	10	324.1	2024-04-26 13:37:24.295	1863	tulevaisuuden_ampuja	laukausryhma_aurora_1
10	10	379	2024-04-26 13:37:24.306	1864	tulevaisuuden_ampuja	laukausryhma_aurora_1
10	10	308.3	2024-04-26 13:37:24.318	1865	tulevaisuuden_ampuja	laukausryhma_aurora_1
10	10	336.3	2024-04-26 13:37:24.331	1866	tulevaisuuden_ampuja	laukausryhma_aurora_1
10	10	362.3	2024-04-26 13:37:24.342	1867	tulevaisuuden_ampuja	laukausryhma_aurora_2
10	10	353.2	2024-04-26 13:37:24.353	1868	tulevaisuuden_ampuja	laukausryhma_aurora_2
10	10	341.3	2024-04-26 13:37:24.364	1869	tulevaisuuden_ampuja	laukausryhma_aurora_2
10	10	305.4	2024-04-26 13:37:24.376	1870	tulevaisuuden_ampuja	laukausryhma_aurora_3
10	10	296.8	2024-04-26 13:37:24.389	1871	tulevaisuuden_ampuja	laukausryhma_aurora_3
10	10	376.7	2024-04-26 13:37:24.401	1872	tulevaisuuden_ampuja	laukausryhma_aurora_3
10	10	342	2024-04-26 13:37:24.413	1873	tulevaisuuden_ampuja	ampumataito_1
10	10	342.2	2024-04-26 13:37:24.425	1874	tulevaisuuden_ampuja	ampumataito_1
10	10	366.6	2024-04-26 13:37:24.436	1875	tulevaisuuden_ampuja	ampumataito_1
10	10	319.4	2024-04-26 13:37:24.449	1876	tulevaisuuden_ampuja	ampumataito_1
10	10	347.5	2024-04-26 13:37:24.461	1877	pikakivaari-klassikko	poliisiseura_1
10	10	351.5	2024-04-26 13:37:24.473	1878	pikakivaari-klassikko	poliisiseura_1
10	10	385.8	2024-04-26 13:37:24.484	1879	pikakivaari-klassikko	poliisiseura_1
10	10	330.1	2024-04-26 13:37:24.495	1880	pikakivaari-klassikko	poliisiseura_1
10	10	282.6	2024-04-26 13:37:24.507	1881	pikakivaari-klassikko	poliisiseura_1
10	10	326	2024-04-26 13:37:24.52	1882	pikakivaari-klassikko	poliisiseura_2
10	10	337.2	2024-04-26 13:37:24.531	1883	pikakivaari-klassikko	poliisiseura_2
10	10	308.8	2024-04-26 13:37:24.542	1884	pikakivaari-klassikko	poliisiseura_2
10	10	320.7	2024-04-26 13:37:24.554	1885	pikakivaari-klassikko	poliisiseura_2
10	10	290.3	2024-04-26 13:37:24.565	1886	pikakivaari-klassikko	poliisiseura_2
10	10	337.1	2024-04-26 13:37:24.577	1887	pikakivaari-klassikko	koiraseura_1
10	10	327.8	2024-04-26 13:37:24.589	1888	pikakivaari-klassikko	koiraseura_1
10	10	308.2	2024-04-26 13:37:24.6	1889	pikakivaari-klassikko	koiraseura_1
10	10	291.3	2024-04-26 13:37:24.612	1890	pikakivaari-klassikko	koiraseura_2
10	10	325.5	2024-04-26 13:37:24.622	1891	pikakivaari-klassikko	koiraseura_2
10	10	324.2	2024-04-26 13:37:24.632	1892	pikakivaari-klassikko	koiraseura_2
10	10	297.9	2024-04-26 13:37:24.643	1893	pikakivaari-klassikko	koiraseura_3
10	10	329.9	2024-04-26 13:37:24.654	1894	pikakivaari-klassikko	koiraseura_3
10	10	306.2	2024-04-26 13:37:24.664	1895	pikakivaari-klassikko	koiraseura_3
10	10	339.2	2024-04-26 13:37:24.676	1896	pikakivaari-klassikko	hammaspeikkoseura_1
10	10	284.8	2024-04-26 13:37:24.688	1897	pikakivaari-klassikko	hammaspeikkoseura_1
10	10	343.3	2024-04-26 13:37:24.699	1898	pikakivaari-klassikko	hammaspeikkoseura_1
10	10	310.5	2024-04-26 13:37:24.71	1899	pikakivaari-klassikko	hammaspeikkoseura_1
10	10	314	2024-04-26 13:37:24.721	1900	pikakivaari-klassikko	hammaspeikkoseura_2
10	10	317.3	2024-04-26 13:37:24.733	1901	pikakivaari-klassikko	hammaspeikkoseura_2
10	10	361.3	2024-04-26 13:37:24.746	1902	pikakivaari-klassikko	hammaspeikkoseura_2
10	10	326.2	2024-04-26 13:37:24.758	1903	pikakivaari-klassikko	hammaspeikkoseura_2
10	10	335.4	2024-04-26 13:37:24.769	1904	pikakivaari-klassikko	hammaspeikkoseura_2
10	10	341.4	2024-04-26 13:37:24.78	1905	pikakivaari-klassikko	hammaspeikkoseura_3
10	10	336.8	2024-04-26 13:37:24.791	1906	pikakivaari-klassikko	hammaspeikkoseura_3
10	10	343.2	2024-04-26 13:37:24.805	1907	pikakivaari-klassikko	hammaspeikkoseura_3
10	10	338	2024-04-26 13:37:24.817	1908	pikakivaari-klassikko	dog_1
10	10	322.1	2024-04-26 13:37:24.829	1909	pikakivaari-klassikko	dog_1
10	10	360.3	2024-04-26 13:37:24.839	1910	pikakivaari-klassikko	dog_1
10	10	296.7	2024-04-26 13:37:24.85	1911	pikakivaari-klassikko	dog_1
10	10	331.5	2024-04-26 13:37:24.863	1912	pikakivaari-klassikko	savu_seura_1
10	10	350.3	2024-04-26 13:37:24.874	1913	pikakivaari-klassikko	savu_seura_1
10	10	366.4	2024-04-26 13:37:24.886	1914	pikakivaari-klassikko	savu_seura_1
10	10	292.6	2024-04-26 13:37:24.897	1915	pikakivaari-klassikko	savu_seura_1
10	10	335.2	2024-04-26 13:37:24.918	1916	pikakivaari-klassikko	savu_seura_1
10	10	307.9	2024-04-26 13:37:24.932	1917	pikakivaari-klassikko	savu_seura_2
10	10	359.1	2024-04-26 13:37:24.942	1918	pikakivaari-klassikko	savu_seura_2
10	10	335.6	2024-04-26 13:37:24.953	1919	pikakivaari-klassikko	savu_seura_2
10	10	334.9	2024-04-26 13:37:24.963	1920	pikakivaari-klassikko	savu_seura_3
10	10	350.2	2024-04-26 13:37:24.974	1921	pikakivaari-klassikko	savu_seura_3
10	10	295	2024-04-26 13:37:24.986	1922	pikakivaari-klassikko	savu_seura_3
10	10	329.8	2024-04-26 13:37:24.998	1923	pikakivaari-klassikko	omas_1
10	10	360	2024-04-26 13:37:25.008	1924	pikakivaari-klassikko	omas_1
10	10	293.1	2024-04-26 13:37:25.019	1925	pikakivaari-klassikko	omas_1
10	10	325.1	2024-04-26 13:37:25.03	1926	pikakivaari-klassikko	omas_2
10	10	310.2	2024-04-26 13:37:25.041	1927	pikakivaari-klassikko	omas_2
10	10	337.4	2024-04-26 13:37:25.054	1928	pikakivaari-klassikko	omas_2
10	10	377.1	2024-04-26 13:37:25.065	1929	pikakivaari-klassikko	omas_2
10	10	322	2024-04-26 13:37:25.075	1930	pikakivaari-klassikko	omas_2
10	10	315.9	2024-04-26 13:37:25.087	1931	pikakivaari-klassikko	pelleseura_1
10	10	310.9	2024-04-26 13:37:25.098	1932	pikakivaari-klassikko	pelleseura_1
10	10	316.8	2024-04-26 13:37:25.111	1933	pikakivaari-klassikko	pelleseura_1
10	10	327	2024-04-26 13:37:25.123	1934	pikakivaari-klassikko	yung_tallent_1
10	10	312.6	2024-04-26 13:37:25.135	1935	pikakivaari-klassikko	yung_tallent_1
10	10	363.6	2024-04-26 13:37:25.153	1936	pikakivaari-klassikko	yung_tallent_1
10	10	308.8	2024-04-26 13:37:25.168	1937	pikakivaari-klassikko	yung_tallent_2
10	10	365.1	2024-04-26 13:37:25.184	1938	pikakivaari-klassikko	yung_tallent_2
10	10	286.4	2024-04-26 13:37:25.197	1939	pikakivaari-klassikko	yung_tallent_2
10	10	293.7	2024-04-26 13:37:25.212	1940	pikakivaari-klassikko	yung_tallent_2
10	10	317.7	2024-04-26 13:37:25.223	1941	pikakivaari-klassikko	yung_tallent_2
10	10	342.7	2024-04-26 13:37:25.236	1942	pikakivaari-klassikko	yung_tallent_3
10	10	336.3	2024-04-26 13:37:25.247	1943	pikakivaari-klassikko	yung_tallent_3
10	10	357.9	2024-04-26 13:37:25.258	1944	pikakivaari-klassikko	yung_tallent_3
10	10	325	2024-04-26 13:37:25.269	1945	pikakivaari-klassikko	yung_tallent_3
10	10	314.3	2024-04-26 13:37:25.281	1946	pikakivaari-klassikko	yung_tallent_3
10	10	355.1	2024-04-26 13:37:25.294	1947	pikakivaari-klassikko	aseharrastajien_yhtenaisyys_1
10	10	324.4	2024-04-26 13:37:25.306	1948	pikakivaari-klassikko	aseharrastajien_yhtenaisyys_1
10	10	298.8	2024-04-26 13:37:25.319	1949	pikakivaari-klassikko	aseharrastajien_yhtenaisyys_1
10	10	360.8	2024-04-26 13:37:25.33	1950	pikakivaari-klassikko	tahtaysmestarit_1
10	10	285.9	2024-04-26 13:37:25.341	1951	pikakivaari-klassikko	tahtaysmestarit_1
10	10	311	2024-04-26 13:37:25.354	1952	pikakivaari-klassikko	tahtaysmestarit_1
10	10	328.6	2024-04-26 13:37:25.366	1953	pikakivaari-klassikko	tahtaysmestarit_1
10	10	336.8	2024-04-26 13:37:25.377	1954	pikakivaari-klassikko	laukausryhma_aurora_1
10	10	356.2	2024-04-26 13:37:25.388	1955	pikakivaari-klassikko	laukausryhma_aurora_1
10	10	309.3	2024-04-26 13:37:25.401	1956	pikakivaari-klassikko	laukausryhma_aurora_1
10	10	331.9	2024-04-26 13:37:25.415	1957	pikakivaari-klassikko	laukausryhma_aurora_2
10	10	326.1	2024-04-26 13:37:25.428	1958	pikakivaari-klassikko	laukausryhma_aurora_2
10	10	308.4	2024-04-26 13:37:25.44	1959	pikakivaari-klassikko	laukausryhma_aurora_2
10	10	335.4	2024-04-26 13:37:25.452	1960	pikakivaari-klassikko	ampumataito_1
10	10	317	2024-04-26 13:37:25.466	1961	pikakivaari-klassikko	ampumataito_1
10	10	334.4	2024-04-26 13:37:25.481	1962	pikakivaari-klassikko	ampumataito_1
10	10	321.4	2024-04-26 13:37:25.495	1963	pikakivaari-klassikko	ampumataito_1
10	10	309	2024-04-26 13:37:25.507	1964	pikakivaari-klassikko	ampumataito_1
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_ (creation_date, id, last_login, email, legal_name, part_of_club, password, username) FROM stdin;
2024-04-26 13:36:57.707	1	\N	adminin sähköposti	adminin nimi	\N	$2a$10$epSEi3SNaUxzAsd2xrzk2OZxOgV5ZsEbXhOd7igBFwl2Cysvolbmm	admin
2024-04-26 13:36:59.713	2	\N	\N	Johannes Nieminen	poliisiseura	\N	wc5EVlQTHH
2024-04-26 13:36:59.74	3	\N	\N	Johannes Koskinen	poliisiseura	\N	bgkGv2AhrZ
2024-04-26 13:36:59.756	4	\N	\N	Matti Komulainen	poliisiseura	\N	AJ2Jp6xGMc
2024-04-26 13:36:59.772	5	\N	\N	Liisa Virtanen	poliisiseura	\N	xKzQzXBwuU
2024-04-26 13:36:59.787	6	\N	\N	Anna Määttä	poliisiseura	\N	GrlGbY7Cw3
2024-04-26 13:36:59.808	7	\N	\N	Juhani Lehtinen	poliisiseura	\N	e82O1s06BM
2024-04-26 13:36:59.824	8	\N	\N	Maria Mäkinen	poliisiseura	\N	WeDKLHP7iO
2024-04-26 13:36:59.841	9	\N	\N	Tapio Järvinen	poliisiseura	\N	tVwSJugkqH
2024-04-26 13:36:59.858	10	\N	\N	Helena Virtanen	poliisiseura	\N	dvrwyCFwae
2024-04-26 13:36:59.874	11	\N	\N	Tapio Komulainen	poliisiseura	\N	Wod2nOu5NT
2024-04-26 13:36:59.89	12	\N	\N	Olavi Korhonen	poliisiseura	\N	lquSJLsRrI
2024-04-26 13:36:59.905	13	\N	\N	Tapio Laine	koiraseura	\N	Uy4ksGiju1
2024-04-26 13:36:59.92	14	\N	\N	Antero Koskinen	koiraseura	\N	dXQvqAauvt
2024-04-26 13:36:59.933	15	\N	\N	Helena Ollakka	koiraseura	\N	1MVOuktMUg
2024-04-26 13:36:59.95	16	\N	\N	Tapani Virtanen	koiraseura	\N	mY2OUt6VTM
2024-04-26 13:36:59.963	17	\N	\N	Marjatta Ollakka	koiraseura	\N	E12wALBVZT
2024-04-26 13:36:59.979	18	\N	\N	Tapani Kumpulainen	hammaspeikkoseura	\N	rLtr1EaChL
2024-04-26 13:36:59.997	19	\N	\N	Marjatta Koskinen	hammaspeikkoseura	\N	lBhaCBQx8Y
2024-04-26 13:37:00.013	20	\N	\N	Marjatta Mäkinen	hammaspeikkoseura	\N	kOZBYgBTWJ
2024-04-26 13:37:00.029	21	\N	\N	Helena Mäkinen	hammaspeikkoseura	\N	kzMvpUfCb2
2024-04-26 13:37:00.046	22	\N	\N	Tapani Kumpulainen	hammaspeikkoseura	\N	8LeAp8ezNK
2024-04-26 13:37:00.06	23	\N	\N	Antero Juustila	hammaspeikkoseura	\N	RUHOejzJJW
2024-04-26 13:37:00.073	24	\N	\N	Johannes Kumpulainen	hammaspeikkoseura	\N	AAOwj48Mg2
2024-04-26 13:37:00.087	25	\N	\N	Matti Lehtinen	dog	\N	wJVuFVQJJA
2024-04-26 13:37:00.102	26	\N	\N	Marjatta Nieminen	dog	\N	iMn6hsOwEv
2024-04-26 13:37:00.118	27	\N	\N	Matti Korhonen	dog	\N	hW3grzwpAu
2024-04-26 13:37:00.132	28	\N	\N	Kaarina Holappa	dog	\N	8CteULkZ4U
2024-04-26 13:37:00.147	29	\N	\N	Anneli Koskinen	savu_seura	\N	UL58iqvJHH
2024-04-26 13:37:00.163	30	\N	\N	Johanna Juustila	savu_seura	\N	wSz5fmiLk3
2024-04-26 13:37:00.182	31	\N	\N	Maria Koskinen	savu_seura	\N	PFeFsk2Kv2
2024-04-26 13:37:00.198	32	\N	\N	Matti Määttä	savu_seura	\N	Adj5Jz77Ge
2024-04-26 13:37:00.213	33	\N	\N	Kalevi Juustila	savu_seura	\N	giwaX6qirS
2024-04-26 13:37:00.23	34	\N	\N	Kalevi Mäkelä	savu_seura	\N	0cWrZVdxrI
2024-04-26 13:37:00.245	35	\N	\N	Juhani Määttä	savu_seura	\N	pMWi6QBiuZ
2024-04-26 13:37:00.26	36	\N	\N	Helena Ollakka	savu_seura	\N	JMcgvB0lJG
2024-04-26 13:37:00.274	37	\N	\N	Ilmari Korhonen	savu_seura	\N	3I1a2PfQIl
2024-04-26 13:37:00.289	38	\N	\N	Liisa Mäkelä	savu_seura	\N	41TMxvIYf4
2024-04-26 13:37:00.307	39	\N	\N	Olavi Mäkinen	savu_seura	\N	3wovn8PVUu
2024-04-26 13:37:00.321	40	\N	\N	Kaarina Juustila	savu_seura	\N	RA4xLN12RX
2024-04-26 13:37:00.336	41	\N	\N	Anna Kumpulainen	savu_seura	\N	U5uwZE1GUW
2024-04-26 13:37:00.352	42	\N	\N	Helena Komulainen	omas	\N	FBkRVTBMqb
2024-04-26 13:37:00.368	43	\N	\N	Johannes Kumpulainen	omas	\N	Ghw7LmFDAq
2024-04-26 13:37:00.384	44	\N	\N	Johanna Mäkinen	omas	\N	cYepTeS0fK
2024-04-26 13:37:00.397	45	\N	\N	Anneli Laine	omas	\N	EiUjqvn7Af
2024-04-26 13:37:00.415	46	\N	\N	Tapio Mäkelä	pelleseura	\N	OFloJJtnvk
2024-04-26 13:37:00.43	47	\N	\N	Ilmari Ollakka	pelleseura	\N	Ilb5GnPDa5
2024-04-26 13:37:00.445	48	\N	\N	Johanna Juustila	pelleseura	\N	Aw57RHokuG
2024-04-26 13:37:00.459	49	\N	\N	Matti Kelanti	yung_tallent	\N	AvzFZoq61h
2024-04-26 13:37:00.473	50	\N	\N	Olavi Mäkelä	yung_tallent	\N	2aMqr0zzlM
2024-04-26 13:37:00.488	51	\N	\N	Tapio Mäkelä	yung_tallent	\N	ibUQei9Uly
2024-04-26 13:37:00.502	52	\N	\N	Anna Kumpulainen	aseharrastajien_yhtenaisyys	\N	gw6xV9sBx5
2024-04-26 13:37:00.517	53	\N	\N	Marjatta Kelanti	aseharrastajien_yhtenaisyys	\N	hM7RDfP9bW
2024-04-26 13:37:00.531	54	\N	\N	Anna Mäkinen	aseharrastajien_yhtenaisyys	\N	hn7yrmmxlw
2024-04-26 13:37:00.546	55	\N	\N	Kaarina Ollakka	aseharrastajien_yhtenaisyys	\N	gVluriJ9gs
2024-04-26 13:37:00.561	56	\N	\N	Kaarina Mäkelä	aseharrastajien_yhtenaisyys	\N	LhEAu4Yahg
2024-04-26 13:37:00.575	57	\N	\N	Marjatta Heikkinen	aseharrastajien_yhtenaisyys	\N	gd1WH0GLbw
2024-04-26 13:37:00.591	58	\N	\N	Olavi Nieminen	aseharrastajien_yhtenaisyys	\N	HOvfONIBnK
2024-04-26 13:37:00.607	59	\N	\N	Matti Ollakka	aseharrastajien_yhtenaisyys	\N	eAdoG2qDRD
2024-04-26 13:37:00.623	60	\N	\N	Mikael Kumpulainen	aseharrastajien_yhtenaisyys	\N	xukkHAXxcJ
2024-04-26 13:37:00.64	61	\N	\N	Liisa Hämäläinen	aseharrastajien_yhtenaisyys	\N	fIV217OxqP
2024-04-26 13:37:00.656	62	\N	\N	Ilmari Mäkinen	aseharrastajien_yhtenaisyys	\N	JIsim95muZ
2024-04-26 13:37:00.671	63	\N	\N	Ilmari Kumpulainen	tahtaysmestarit	\N	OHguvXwOS6
2024-04-26 13:37:00.687	64	\N	\N	Liisa Määttä	tahtaysmestarit	\N	V0sL3Zpo6h
2024-04-26 13:37:00.703	65	\N	\N	Liisa Laine	tahtaysmestarit	\N	s6XGEbjStw
2024-04-26 13:37:00.718	66	\N	\N	Kaarina Määttä	tahtaysmestarit	\N	GZPAdKqUWd
2024-04-26 13:37:00.733	67	\N	\N	Mikael Koskinen	tahtaysmestarit	\N	23y8391S0D
2024-04-26 13:37:00.747	68	\N	\N	Tapio Lehtinen	tahtaysmestarit	\N	SdSIf7iOum
2024-04-26 13:37:00.761	69	\N	\N	Liisa Nieminen	tahtaysmestarit	\N	y63pYVXCiX
2024-04-26 13:37:00.776	70	\N	\N	Helena Mäkelä	tahtaysmestarit	\N	UZH8sLTqAe
2024-04-26 13:37:00.792	71	\N	\N	Liisa Määttä	tahtaysmestarit	\N	gxjqqZu92o
2024-04-26 13:37:00.806	72	\N	\N	Juhani Juustila	tahtaysmestarit	\N	j6Zn06qVDM
2024-04-26 13:37:00.821	73	\N	\N	Kaarina Kelanti	tahtaysmestarit	\N	mqjbHhCSLT
2024-04-26 13:37:00.838	74	\N	\N	Matti Virtanen	tahtaysmestarit	\N	zMtve7ndWV
2024-04-26 13:37:00.854	75	\N	\N	Tapani Heikkinen	laukausryhma_aurora	\N	Or4tuxXPSx
2024-04-26 13:37:00.869	76	\N	\N	Maria Lehtinen	laukausryhma_aurora	\N	9TZ0NEvjtU
2024-04-26 13:37:00.885	77	\N	\N	Kalevi Laine	laukausryhma_aurora	\N	NfYks4lqL8
2024-04-26 13:37:00.901	78	\N	\N	Helena Järvinen	ampumataito	\N	3JCNhkv1Z7
2024-04-26 13:37:00.914	79	\N	\N	Helena Juustila	ampumataito	\N	Mv5PtXoeza
2024-04-26 13:37:00.929	80	\N	\N	Tapani Mäkinen	ampumataito	\N	ZIIOxqdOEJ
2024-04-26 13:37:00.942	81	\N	\N	Kalevi Kumpulainen	ampumataito	\N	KBmtsnfJWv
2024-04-26 13:37:00.958	82	\N	\N	Liisa Virtanen	ampumataito	\N	FsjxNGsLsT
2024-04-26 13:37:00.973	83	\N	\N	Matti Ollakka	ampumataito	\N	oaO9vgL2sm
2024-04-26 13:37:00.989	84	\N	\N	Mikael Virtanen	ampumataito	\N	1EMKoj8Att
2024-04-26 13:37:01.004	85	\N	\N	Tapani Järvinen	ampumataito	\N	dS6Sbkq8lN
2024-04-26 13:37:01.021	86	\N	\N	Kalevi Nieminen	ampumataito	\N	RTybp33bGk
2024-04-26 13:37:01.038	87	\N	\N	Helena Laine	ampumataito	\N	7jETAduaT6
2024-04-26 13:37:01.054	88	\N	\N	Kaarina Laine	ampumataito	\N	e1bPOu9Xje
2024-04-26 13:37:01.071	89	\N	\N	Mikael Holappa	ampumataito	\N	WDuCQLmmhm
2024-04-26 13:37:01.089	90	\N	\N	Marjatta Hämäläinen	ampumataito	\N	B1z21z3Ga6
2024-04-26 13:37:01.103	91	\N	\N	Tapio Hämäläinen	ampumataito	\N	pebZXRZcpB
2024-04-26 13:37:01.12	92	\N	\N	Antero Mäkinen	ampumataito	\N	EnHYWPLIRQ
2024-04-26 13:37:01.136	93	\N	\N	Liisa Koskinen	poliisiseura	\N	RKTn5EQDFt
2024-04-26 13:37:01.152	94	\N	\N	Anneli Koskinen	poliisiseura	\N	T4Qt0h0NUX
2024-04-26 13:37:01.168	95	\N	\N	Anna Lehtinen	poliisiseura	\N	Hr8IiZJu0u
2024-04-26 13:37:01.183	96	\N	\N	Tapani Kumpulainen	poliisiseura	\N	cqObTYu89r
2024-04-26 13:37:01.198	97	\N	\N	Kaarina Mäkinen	poliisiseura	\N	0TR9RLgEDl
2024-04-26 13:37:01.213	98	\N	\N	Antero Heikkinen	poliisiseura	\N	urZdamH0Bu
2024-04-26 13:37:01.228	99	\N	\N	Johannes Laine	poliisiseura	\N	cujc5FEa2X
2024-04-26 13:37:01.244	100	\N	\N	Matti Mäkelä	poliisiseura	\N	8ncP3ApHkM
2024-04-26 13:37:01.263	101	\N	\N	Tapio Nieminen	poliisiseura	\N	RV4LfQij0d
2024-04-26 13:37:01.278	102	\N	\N	Johanna Kelanti	koiraseura	\N	XOfjiUl4aG
2024-04-26 13:37:01.296	103	\N	\N	Olavi Holappa	koiraseura	\N	zgLh6MQT0m
2024-04-26 13:37:01.315	104	\N	\N	Maria Komulainen	koiraseura	\N	EflTT8aS41
2024-04-26 13:37:01.333	105	\N	\N	Matti Nieminen	koiraseura	\N	8CueMll9ZW
2024-04-26 13:37:01.348	106	\N	\N	Johanna Kelanti	hammaspeikkoseura	\N	swVeDNOOw3
2024-04-26 13:37:01.365	107	\N	\N	Antero Lehtinen	hammaspeikkoseura	\N	1iYu8xXoOX
2024-04-26 13:37:01.383	108	\N	\N	Tapio Virtanen	hammaspeikkoseura	\N	i8nPNJcDet
2024-04-26 13:37:01.399	109	\N	\N	Mikael Nieminen	hammaspeikkoseura	\N	rx7MXHKejj
2024-04-26 13:37:01.412	110	\N	\N	Anna Korhonen	hammaspeikkoseura	\N	EnSPz1GrVs
2024-04-26 13:37:01.427	111	\N	\N	Johannes Komulainen	hammaspeikkoseura	\N	WTE2TYkKfv
2024-04-26 13:37:01.455	112	\N	\N	Anneli Virtanen	hammaspeikkoseura	\N	i5Dr025GVf
2024-04-26 13:37:01.48	113	\N	\N	Olavi Korhonen	dog	\N	4xVfEyCp18
2024-04-26 13:37:01.505	114	\N	\N	Mikael Mäkinen	dog	\N	ljVvinZSX8
2024-04-26 13:37:01.521	115	\N	\N	Antero Kumpulainen	dog	\N	7DrmA2g1gv
2024-04-26 13:37:01.536	116	\N	\N	Kaarina Järvinen	dog	\N	UWfIQcuTo0
2024-04-26 13:37:01.552	117	\N	\N	Olavi Juustila	dog	\N	VfU3wCbLex
2024-04-26 13:37:01.567	118	\N	\N	Johannes Juustila	dog	\N	mbJM8lUotW
2024-04-26 13:37:01.583	119	\N	\N	Kaarina Korhonen	dog	\N	7tcEkVUXgC
2024-04-26 13:37:01.597	120	\N	\N	Tapani Määttä	dog	\N	osd7SA12Rt
2024-04-26 13:37:01.611	121	\N	\N	Kalevi Järvinen	dog	\N	bPg8U3Hn3G
2024-04-26 13:37:01.627	122	\N	\N	Helena Korhonen	savu_seura	\N	HCPOrBpFIY
2024-04-26 13:37:01.64	123	\N	\N	Tapio Järvinen	savu_seura	\N	Y0vUhDnH6j
2024-04-26 13:37:01.655	124	\N	\N	Mikael Holappa	savu_seura	\N	sTrjkJXcIJ
2024-04-26 13:37:01.668	125	\N	\N	Olavi Kelanti	savu_seura	\N	5UbGMs0vkF
2024-04-26 13:37:01.681	126	\N	\N	Juhani Määttä	savu_seura	\N	ce5YeqTXPe
2024-04-26 13:37:01.697	127	\N	\N	Liisa Kelanti	savu_seura	\N	F038m0uJYD
2024-04-26 13:37:01.712	128	\N	\N	Maria Kelanti	savu_seura	\N	sskR5jeMhI
2024-04-26 13:37:01.725	129	\N	\N	Tapio Virtanen	savu_seura	\N	BZzlX26fYc
2024-04-26 13:37:01.74	130	\N	\N	Tapio Heikkinen	omas	\N	eAQLtdeBiF
2024-04-26 13:37:01.756	131	\N	\N	Antero Lehtinen	omas	\N	UHEq9M4lGv
2024-04-26 13:37:01.77	132	\N	\N	Antero Virtanen	omas	\N	TirHwTtoxU
2024-04-26 13:37:01.783	133	\N	\N	Johannes Mäkinen	omas	\N	b69qRT0mXh
2024-04-26 13:37:01.795	134	\N	\N	Helena Juustila	omas	\N	oJE66PANBt
2024-04-26 13:37:01.812	135	\N	\N	Liisa Virtanen	omas	\N	8ryIVPsHnT
2024-04-26 13:37:01.824	136	\N	\N	Maria Holappa	omas	\N	s5o7XvXaLe
2024-04-26 13:37:01.84	137	\N	\N	Maria Järvinen	omas	\N	loqNwWvmF2
2024-04-26 13:37:01.853	138	\N	\N	Kalevi Holappa	omas	\N	BrtUdOMy43
2024-04-26 13:37:01.868	139	\N	\N	Tapio Mäkinen	omas	\N	YsTKUIMcql
2024-04-26 13:37:01.882	140	\N	\N	Juhani Nieminen	omas	\N	ar9TQ5xqsS
2024-04-26 13:37:01.896	141	\N	\N	Johannes Komulainen	omas	\N	s1a6930nmI
2024-04-26 13:37:01.909	142	\N	\N	Mikael Koskinen	omas	\N	mux6v30Nh4
2024-04-26 13:37:01.923	143	\N	\N	Matti Juustila	omas	\N	CIfqP4bVmo
2024-04-26 13:37:01.937	144	\N	\N	Anna Koskinen	omas	\N	hVhqstIvXq
2024-04-26 13:37:01.952	145	\N	\N	Tapani Määttä	pelleseura	\N	vTDcs5T8GT
2024-04-26 13:37:01.966	146	\N	\N	Tapio Kelanti	pelleseura	\N	3pec7Mq3cd
2024-04-26 13:37:01.98	147	\N	\N	Juhani Kumpulainen	pelleseura	\N	7hqn4XkaX2
2024-04-26 13:37:01.995	148	\N	\N	Tapio Hämäläinen	pelleseura	\N	MG6wvDPiai
2024-04-26 13:37:02.009	149	\N	\N	Olavi Komulainen	pelleseura	\N	VjNOpcy5oW
2024-04-26 13:37:02.023	150	\N	\N	Helena Määttä	pelleseura	\N	23mTyaJQYH
2024-04-26 13:37:02.036	151	\N	\N	Mikael Koskinen	pelleseura	\N	sZvPOLIrlK
2024-04-26 13:37:02.05	152	\N	\N	Juhani Hämäläinen	pelleseura	\N	4E0kvOtbwO
2024-04-26 13:37:02.065	153	\N	\N	Tapio Määttä	pelleseura	\N	N23v6ZkXbV
2024-04-26 13:37:02.077	154	\N	\N	Anna Kumpulainen	pelleseura	\N	luO3ONYBWV
2024-04-26 13:37:02.091	155	\N	\N	Johanna Virtanen	pelleseura	\N	TFQlqS2pOx
2024-04-26 13:37:02.104	156	\N	\N	Tapani Heikkinen	pelleseura	\N	Sw69L18u9w
2024-04-26 13:37:02.118	157	\N	\N	Maria Kelanti	yung_tallent	\N	6QBhNbVmT4
2024-04-26 13:37:02.131	158	\N	\N	Kalevi Lehtinen	yung_tallent	\N	0HrJFeHwP1
2024-04-26 13:37:02.144	159	\N	\N	Tapio Korhonen	yung_tallent	\N	773A6J0PpF
2024-04-26 13:37:02.158	160	\N	\N	Ilmari Mäkinen	yung_tallent	\N	9nkkdh2ha4
2024-04-26 13:37:02.172	161	\N	\N	Kaarina Korhonen	yung_tallent	\N	vraLvoXeQw
2024-04-26 13:37:02.186	162	\N	\N	Kaarina Hämäläinen	yung_tallent	\N	Ux7QVGuX2Z
2024-04-26 13:37:02.201	163	\N	\N	Anneli Juustila	yung_tallent	\N	N3C3PDHbKO
2024-04-26 13:37:02.214	164	\N	\N	Ilmari Mäkinen	yung_tallent	\N	lGvm59IB0t
2024-04-26 13:37:02.227	165	\N	\N	Anna Mäkinen	yung_tallent	\N	ge7vMWcW4a
2024-04-26 13:37:02.24	166	\N	\N	Maria Järvinen	yung_tallent	\N	rMfNbC8ewl
2024-04-26 13:37:02.255	167	\N	\N	Anna Kumpulainen	yung_tallent	\N	nbr1llWbBY
2024-04-26 13:37:02.268	168	\N	\N	Mikael Holappa	yung_tallent	\N	COdNezxyqS
2024-04-26 13:37:02.282	169	\N	\N	Kalevi Virtanen	yung_tallent	\N	IwZEnNmVeY
2024-04-26 13:37:02.296	170	\N	\N	Marjatta Kelanti	aseharrastajien_yhtenaisyys	\N	GzqiQ1I4Hd
2024-04-26 13:37:02.311	171	\N	\N	Maria Komulainen	aseharrastajien_yhtenaisyys	\N	1D6j07ssnr
2024-04-26 13:37:02.325	172	\N	\N	Juhani Kumpulainen	aseharrastajien_yhtenaisyys	\N	vBNgFS2pPm
2024-04-26 13:37:02.338	173	\N	\N	Johanna Heikkinen	aseharrastajien_yhtenaisyys	\N	9aEWrdesZa
2024-04-26 13:37:02.352	174	\N	\N	Anna Määttä	tahtaysmestarit	\N	4d1Bc9gH2x
2024-04-26 13:37:02.366	175	\N	\N	Anna Kelanti	tahtaysmestarit	\N	NaDNc51LCr
2024-04-26 13:37:02.38	176	\N	\N	Kaarina Juustila	tahtaysmestarit	\N	U3IuGNN1JV
2024-04-26 13:37:02.392	177	\N	\N	Anna Korhonen	tahtaysmestarit	\N	NAHOkPjqQh
2024-04-26 13:37:02.406	178	\N	\N	Marjatta Kumpulainen	tahtaysmestarit	\N	Pir5IYutD7
2024-04-26 13:37:02.421	179	\N	\N	Tapio Kumpulainen	tahtaysmestarit	\N	ubs3spfGGE
2024-04-26 13:37:02.437	180	\N	\N	Tapani Laine	tahtaysmestarit	\N	hcszFektTi
2024-04-26 13:37:02.451	181	\N	\N	Kaarina Juustila	tahtaysmestarit	\N	d1ImK2hp67
2024-04-26 13:37:02.465	182	\N	\N	Johanna Mäkelä	tahtaysmestarit	\N	ureSLGkYby
2024-04-26 13:37:02.48	183	\N	\N	Antero Korhonen	tahtaysmestarit	\N	bpGHd3oBLh
2024-04-26 13:37:02.495	184	\N	\N	Kaarina Järvinen	tahtaysmestarit	\N	srFZ3DdL4r
2024-04-26 13:37:02.508	185	\N	\N	Antero Hämäläinen	tahtaysmestarit	\N	5i6t1D9s0F
2024-04-26 13:37:02.52	186	\N	\N	Juhani Virtanen	tahtaysmestarit	\N	ZtHhqh2PtK
2024-04-26 13:37:02.534	187	\N	\N	Maria Mäkinen	laukausryhma_aurora	\N	znAnawHLCT
2024-04-26 13:37:02.548	188	\N	\N	Tapani Korhonen	laukausryhma_aurora	\N	YP60Wiqy6S
2024-04-26 13:37:02.561	189	\N	\N	Mikael Kumpulainen	laukausryhma_aurora	\N	6wzTq4DYw5
2024-04-26 13:37:02.573	190	\N	\N	Marjatta Kumpulainen	ampumataito	\N	r99dDX2JBw
2024-04-26 13:37:02.588	191	\N	\N	Ilmari Lehtinen	ampumataito	\N	kHswMmlQsU
2024-04-26 13:37:02.602	192	\N	\N	Tapio Määttä	ampumataito	\N	Ca5e6XSWon
2024-04-26 13:37:02.617	193	\N	\N	Johanna Holappa	ampumataito	\N	XtOnI04S8O
2024-04-26 13:37:02.631	194	\N	\N	Marjatta Heikkinen	ampumataito	\N	86Kh0txBgy
2024-04-26 13:37:02.644	195	\N	\N	Marjatta Järvinen	ampumataito	\N	wyKYHaEU3A
2024-04-26 13:37:02.656	196	\N	\N	Antero Kelanti	ampumataito	\N	K0hDAk4fos
2024-04-26 13:37:02.669	197	\N	\N	Liisa Mäkelä	poliisiseura	\N	psOJ55D0tV
2024-04-26 13:37:02.683	198	\N	\N	Olavi Kelanti	poliisiseura	\N	W9bPXTH1OM
2024-04-26 13:37:02.697	199	\N	\N	Anneli Ollakka	poliisiseura	\N	PCNq9bLJXr
2024-04-26 13:37:02.709	200	\N	\N	Maria Virtanen	poliisiseura	\N	tAlFW0d8Fn
2024-04-26 13:37:02.722	201	\N	\N	Juhani Kelanti	poliisiseura	\N	Q63lIwYtby
2024-04-26 13:37:02.737	202	\N	\N	Kaarina Koskinen	poliisiseura	\N	8qbicsZAPa
2024-04-26 13:37:02.75	203	\N	\N	Tapani Juustila	poliisiseura	\N	qX4Lm6ZTZg
2024-04-26 13:37:02.761	204	\N	\N	Tapani Hämäläinen	poliisiseura	\N	55UGk2TMzq
2024-04-26 13:37:02.774	205	\N	\N	Tapio Järvinen	poliisiseura	\N	d9YzZQZrap
2024-04-26 13:37:02.787	206	\N	\N	Johanna Määttä	poliisiseura	\N	nTAfFImhbY
2024-04-26 13:37:02.802	207	\N	\N	Ilmari Hämäläinen	poliisiseura	\N	l9Uzdv45V6
2024-04-26 13:37:02.815	208	\N	\N	Liisa Laine	poliisiseura	\N	UR2JiuHDwS
2024-04-26 13:37:02.828	209	\N	\N	Juhani Mäkelä	koiraseura	\N	Q0Gp0beoak
2024-04-26 13:37:02.841	210	\N	\N	Mikael Holappa	koiraseura	\N	3dBcaj1K1n
2024-04-26 13:37:02.857	211	\N	\N	Johannes Lehtinen	koiraseura	\N	8LwmI1qvEz
2024-04-26 13:37:02.869	212	\N	\N	Ilmari Kelanti	koiraseura	\N	u4VpfNZDyb
2024-04-26 13:37:02.883	213	\N	\N	Ilmari Virtanen	koiraseura	\N	AFA28LjTl2
2024-04-26 13:37:02.895	214	\N	\N	Ilmari Mäkinen	hammaspeikkoseura	\N	JRAzHCoePF
2024-04-26 13:37:02.908	215	\N	\N	Matti Järvinen	hammaspeikkoseura	\N	NF6Q2MO2K3
2024-04-26 13:37:02.922	216	\N	\N	Kaarina Korhonen	hammaspeikkoseura	\N	NsR3oPszO9
2024-04-26 13:37:02.935	217	\N	\N	Matti Mäkelä	hammaspeikkoseura	\N	muAWjkiGKV
2024-04-26 13:37:02.946	218	\N	\N	Johannes Korhonen	hammaspeikkoseura	\N	unCTBj8QAu
2024-04-26 13:37:02.959	219	\N	\N	Anneli Määttä	dog	\N	JEaEElrRLX
2024-04-26 13:37:02.971	220	\N	\N	Olavi Holappa	dog	\N	9vDdZBYQvN
2024-04-26 13:37:02.985	221	\N	\N	Tapani Järvinen	dog	\N	ceeyDIhtLk
2024-04-26 13:37:02.998	222	\N	\N	Tapani Korhonen	savu_seura	\N	j1LF3WXoYn
2024-04-26 13:37:03.01	223	\N	\N	Olavi Mäkelä	savu_seura	\N	yEtubeZfGO
2024-04-26 13:37:03.024	224	\N	\N	Antero Laine	savu_seura	\N	r032XeICgV
2024-04-26 13:37:03.038	225	\N	\N	Mikael Korhonen	savu_seura	\N	axtQjqqDWp
2024-04-26 13:37:03.052	226	\N	\N	Johannes Virtanen	savu_seura	\N	8DEQMgzPSw
2024-04-26 13:37:03.064	227	\N	\N	Olavi Kelanti	omas	\N	PVxsuRQZmv
2024-04-26 13:37:03.077	228	\N	\N	Mikael Kelanti	omas	\N	Z8IFDZ8bsY
2024-04-26 13:37:03.089	229	\N	\N	Olavi Holappa	omas	\N	9oloS4KLR4
2024-04-26 13:37:03.102	230	\N	\N	Anneli Heikkinen	omas	\N	Bong9mxBiu
2024-04-26 13:37:03.115	231	\N	\N	Juhani Mäkelä	omas	\N	okdC1bnz0i
2024-04-26 13:37:03.128	232	\N	\N	Helena Virtanen	omas	\N	NyKZdFbiID
2024-04-26 13:37:03.141	233	\N	\N	Matti Komulainen	omas	\N	LvjkAMy7EI
2024-04-26 13:37:03.154	234	\N	\N	Maria Kumpulainen	omas	\N	JbeQ9MRysn
2024-04-26 13:37:03.169	235	\N	\N	Maria Juustila	omas	\N	DXbKAF1pcH
2024-04-26 13:37:03.181	236	\N	\N	Juhani Mäkinen	omas	\N	d9pFZJ7sSa
2024-04-26 13:37:03.194	237	\N	\N	Anneli Määttä	omas	\N	lO8nBt2c77
2024-04-26 13:37:03.205	238	\N	\N	Anna Hämäläinen	pelleseura	\N	0iOvUP43Cx
2024-04-26 13:37:03.217	239	\N	\N	Ilmari Ollakka	pelleseura	\N	c1uwBM4hp0
2024-04-26 13:37:03.232	240	\N	\N	Kaarina Nieminen	pelleseura	\N	aocRHWTR2J
2024-04-26 13:37:03.245	241	\N	\N	Kalevi Mäkelä	pelleseura	\N	TiO2QJqEE4
2024-04-26 13:37:03.257	242	\N	\N	Maria Mäkelä	pelleseura	\N	C0VPbcq9qk
2024-04-26 13:37:03.271	243	\N	\N	Mikael Juustila	pelleseura	\N	suymKYusbg
2024-04-26 13:37:03.293	244	\N	\N	Johanna Mäkelä	pelleseura	\N	xW4AduS0TN
2024-04-26 13:37:03.31	245	\N	\N	Helena Ollakka	pelleseura	\N	wyT4tYEHDQ
2024-04-26 13:37:03.328	246	\N	\N	Juhani Mäkinen	pelleseura	\N	YUJp7XsnE0
2024-04-26 13:37:03.345	247	\N	\N	Kalevi Juustila	pelleseura	\N	obbqliyLal
2024-04-26 13:37:03.36	248	\N	\N	Kaarina Virtanen	pelleseura	\N	N5TvBlB5XX
2024-04-26 13:37:03.372	249	\N	\N	Ilmari Virtanen	pelleseura	\N	QIwllwwofj
2024-04-26 13:37:03.384	250	\N	\N	Anneli Mäkelä	pelleseura	\N	ksfa1j2rrB
2024-04-26 13:37:03.396	251	\N	\N	Liisa Lehtinen	pelleseura	\N	mC7F2hKXqL
2024-04-26 13:37:03.411	252	\N	\N	Anneli Mäkelä	yung_tallent	\N	HmAVUk3fVV
2024-04-26 13:37:03.423	253	\N	\N	Maria Lehtinen	yung_tallent	\N	7bCQgApFVp
2024-04-26 13:37:03.435	254	\N	\N	Tapani Ollakka	yung_tallent	\N	dYNMJXu0j2
2024-04-26 13:37:03.447	255	\N	\N	Juhani Mäkinen	yung_tallent	\N	rEROenP8pe
2024-04-26 13:37:03.459	256	\N	\N	Anna Korhonen	yung_tallent	\N	lVeBVZl35W
2024-04-26 13:37:03.474	257	\N	\N	Maria Juustila	yung_tallent	\N	bDuFf7041w
2024-04-26 13:37:03.488	258	\N	\N	Ilmari Kelanti	yung_tallent	\N	dcvLKowpNp
2024-04-26 13:37:03.502	259	\N	\N	Tapio Kelanti	yung_tallent	\N	b7Ip1ENjlQ
2024-04-26 13:37:03.516	260	\N	\N	Liisa Hämäläinen	yung_tallent	\N	l4Es8jsyf7
2024-04-26 13:37:03.531	261	\N	\N	Johannes Järvinen	yung_tallent	\N	Fr61gCfiHm
2024-04-26 13:37:03.544	262	\N	\N	Liisa Laine	yung_tallent	\N	9KMcCwMDWU
2024-04-26 13:37:03.557	263	\N	\N	Maria Mäkinen	yung_tallent	\N	6zGzmRn1zL
2024-04-26 13:37:03.57	264	\N	\N	Marjatta Juustila	yung_tallent	\N	uHBtGmVtsp
2024-04-26 13:37:03.584	265	\N	\N	Johannes Heikkinen	aseharrastajien_yhtenaisyys	\N	QSRDAWs7gR
2024-04-26 13:37:03.601	266	\N	\N	Kaarina Korhonen	aseharrastajien_yhtenaisyys	\N	xhPDIxqnZB
2024-04-26 13:37:03.614	267	\N	\N	Liisa Koskinen	aseharrastajien_yhtenaisyys	\N	d1tJTkcu2h
2024-04-26 13:37:03.627	268	\N	\N	Helena Holappa	aseharrastajien_yhtenaisyys	\N	4WdqPuBoeP
2024-04-26 13:37:03.64	269	\N	\N	Kaarina Juustila	aseharrastajien_yhtenaisyys	\N	Bm8LbLR16K
2024-04-26 13:37:03.653	270	\N	\N	Maria Järvinen	aseharrastajien_yhtenaisyys	\N	11JuxWwOGi
2024-04-26 13:37:03.666	271	\N	\N	Liisa Kelanti	aseharrastajien_yhtenaisyys	\N	Edpl7yznpj
2024-04-26 13:37:03.678	272	\N	\N	Tapio Lehtinen	aseharrastajien_yhtenaisyys	\N	3fkmITxOf0
2024-04-26 13:37:03.694	273	\N	\N	Matti Ollakka	aseharrastajien_yhtenaisyys	\N	sK74xu73zI
2024-04-26 13:37:03.709	274	\N	\N	Ilmari Komulainen	aseharrastajien_yhtenaisyys	\N	dQDTCki7Xk
2024-04-26 13:37:03.724	275	\N	\N	Kalevi Ollakka	aseharrastajien_yhtenaisyys	\N	7kSCKaDMO2
2024-04-26 13:37:03.737	276	\N	\N	Liisa Kumpulainen	tahtaysmestarit	\N	FuZRKOL3NK
2024-04-26 13:37:03.75	277	\N	\N	Anneli Holappa	tahtaysmestarit	\N	ODYFmSGe7K
2024-04-26 13:37:03.762	278	\N	\N	Marjatta Mäkinen	tahtaysmestarit	\N	uGbge09f9Z
2024-04-26 13:37:03.778	279	\N	\N	Tapani Nieminen	tahtaysmestarit	\N	mNPteyguno
2024-04-26 13:37:03.79	280	\N	\N	Tapio Mäkinen	tahtaysmestarit	\N	6hsE2cDgQ5
2024-04-26 13:37:03.804	281	\N	\N	Olavi Mäkelä	tahtaysmestarit	\N	wcssMDPAZm
2024-04-26 13:37:03.817	282	\N	\N	Maria Hämäläinen	tahtaysmestarit	\N	7QYW0UnpJU
2024-04-26 13:37:03.829	283	\N	\N	Anna Mäkinen	tahtaysmestarit	\N	nDy092Y8sO
2024-04-26 13:37:03.844	284	\N	\N	Ilmari Kumpulainen	laukausryhma_aurora	\N	RRMf7RU8FQ
2024-04-26 13:37:03.855	285	\N	\N	Olavi Korhonen	laukausryhma_aurora	\N	URHRFenHDl
2024-04-26 13:37:03.869	286	\N	\N	Maria Kumpulainen	laukausryhma_aurora	\N	Ixe9b7qupK
2024-04-26 13:37:03.881	287	\N	\N	Liisa Mäkelä	laukausryhma_aurora	\N	3DXoiu24Hh
2024-04-26 13:37:03.894	288	\N	\N	Helena Kelanti	laukausryhma_aurora	\N	a3gq9UIaeE
2024-04-26 13:37:03.906	289	\N	\N	Johanna Virtanen	laukausryhma_aurora	\N	Jlv2z3m4oY
2024-04-26 13:37:03.919	290	\N	\N	Tapani Heikkinen	laukausryhma_aurora	\N	CP6goLzUD9
2024-04-26 13:37:03.931	291	\N	\N	Antero Juustila	laukausryhma_aurora	\N	uluLn2sLol
2024-04-26 13:37:03.943	292	\N	\N	Matti Lehtinen	laukausryhma_aurora	\N	g4a0lBkQWp
2024-04-26 13:37:03.956	293	\N	\N	Marjatta Kelanti	laukausryhma_aurora	\N	4z73glHufL
2024-04-26 13:37:03.97	294	\N	\N	Olavi Holappa	ampumataito	\N	NHZyKqZAlr
2024-04-26 13:37:03.983	295	\N	\N	Johannes Nieminen	ampumataito	\N	dbcqQcBPG5
2024-04-26 13:37:03.996	296	\N	\N	Johannes Hämäläinen	ampumataito	\N	WSaJwZ5RaM
2024-04-26 13:37:04.009	297	\N	\N	Juhani Korhonen	ampumataito	\N	HiXg9N1YDI
2024-04-26 13:37:04.023	298	\N	\N	Johannes Lehtinen	ampumataito	\N	ZAap3lRAUc
2024-04-26 13:37:04.037	299	\N	\N	Tapani Holappa	ampumataito	\N	InTIgeBbKy
2024-04-26 13:37:04.049	300	\N	\N	Liisa Virtanen	ampumataito	\N	Jg5nvBJjGd
2024-04-26 13:37:04.062	301	\N	\N	Juhani Korhonen	ampumataito	\N	elCick43Lz
2024-04-26 13:37:04.075	302	\N	\N	Matti Lehtinen	ampumataito	\N	iIuygdIC35
2024-04-26 13:37:04.089	303	\N	\N	Juhani Koskinen	ampumataito	\N	1I7MGNzJ4a
2024-04-26 13:37:04.104	304	\N	\N	Mikael Virtanen	ampumataito	\N	fsnXvFzq9d
2024-04-26 13:37:04.116	305	\N	\N	Helena Ollakka	ampumataito	\N	ZkA8q7SQYL
2024-04-26 13:37:04.129	306	\N	\N	Maria Korhonen	ampumataito	\N	XlOAHnKTbe
2024-04-26 13:37:04.143	307	\N	\N	Tapani Juustila	ampumataito	\N	R1Qw6TOUsa
2024-04-26 13:37:04.156	308	\N	\N	Liisa Kelanti	poliisiseura	\N	FljlOv6FPm
2024-04-26 13:37:04.169	309	\N	\N	Matti Määttä	poliisiseura	\N	Y4cVvahcpY
2024-04-26 13:37:04.181	310	\N	\N	Tapani Lehtinen	poliisiseura	\N	Ai1ycAdjAm
2024-04-26 13:37:04.196	311	\N	\N	Matti Nieminen	poliisiseura	\N	OkG3N3wJi5
2024-04-26 13:37:04.211	312	\N	\N	Kaarina Kumpulainen	poliisiseura	\N	0ViOrWFBH5
2024-04-26 13:37:04.225	313	\N	\N	Maria Ollakka	poliisiseura	\N	q7kiWGpan8
2024-04-26 13:37:04.241	314	\N	\N	Johanna Koskinen	poliisiseura	\N	vO61DikqMn
2024-04-26 13:37:04.265	315	\N	\N	Johannes Korhonen	poliisiseura	\N	F3WrMyrrn6
2024-04-26 13:37:04.282	316	\N	\N	Juhani Mäkelä	poliisiseura	\N	jlDVQMWokW
2024-04-26 13:37:04.294	317	\N	\N	Kaarina Nieminen	poliisiseura	\N	Z243PEKI1E
2024-04-26 13:37:04.307	318	\N	\N	Kaarina Koskinen	poliisiseura	\N	HPtZOQpGen
2024-04-26 13:37:04.32	319	\N	\N	Anna Järvinen	poliisiseura	\N	49jJHByIn8
2024-04-26 13:37:04.333	320	\N	\N	Tapio Juustila	poliisiseura	\N	LhUackCedt
2024-04-26 13:37:04.346	321	\N	\N	Matti Heikkinen	koiraseura	\N	zjYdk7gRJO
2024-04-26 13:37:04.358	322	\N	\N	Helena Koskinen	koiraseura	\N	XgdLLHClS9
2024-04-26 13:37:04.37	323	\N	\N	Tapio Kumpulainen	koiraseura	\N	gwkbKtr8Ow
2024-04-26 13:37:04.381	324	\N	\N	Maria Kumpulainen	koiraseura	\N	wO8j2wzewe
2024-04-26 13:37:04.396	325	\N	\N	Juhani Lehtinen	koiraseura	\N	8Dkf3DUkZi
2024-04-26 13:37:04.408	326	\N	\N	Olavi Kumpulainen	koiraseura	\N	OAbfc2gxMQ
2024-04-26 13:37:04.42	327	\N	\N	Tapani Järvinen	koiraseura	\N	B6uo8Ahq6A
2024-04-26 13:37:04.432	328	\N	\N	Antero Korhonen	koiraseura	\N	rrJSExSnFr
2024-04-26 13:37:04.443	329	\N	\N	Mikael Lehtinen	koiraseura	\N	vHGZ1ktixT
2024-04-26 13:37:04.457	330	\N	\N	Antero Mäkelä	koiraseura	\N	KH0n8uBD3X
2024-04-26 13:37:04.47	331	\N	\N	Anna Mäkelä	koiraseura	\N	NnFIYwaIEi
2024-04-26 13:37:04.482	332	\N	\N	Johannes Korhonen	koiraseura	\N	bkzo0e2aYi
2024-04-26 13:37:04.493	333	\N	\N	Kalevi Juustila	koiraseura	\N	98RWpaXx6G
2024-04-26 13:37:04.505	334	\N	\N	Helena Mäkinen	koiraseura	\N	5XeeMcY7no
2024-04-26 13:37:04.519	335	\N	\N	Liisa Laine	hammaspeikkoseura	\N	ttISF5IzfJ
2024-04-26 13:37:04.531	336	\N	\N	Kaarina Määttä	hammaspeikkoseura	\N	5kXY6LLSab
2024-04-26 13:37:04.543	337	\N	\N	Mikael Juustila	hammaspeikkoseura	\N	Fn84n56jji
2024-04-26 13:37:04.556	338	\N	\N	Liisa Määttä	hammaspeikkoseura	\N	TUlq77LS5M
2024-04-26 13:37:04.569	339	\N	\N	Tapani Lehtinen	dog	\N	SZL7ZLKBxI
2024-04-26 13:37:04.583	340	\N	\N	Liisa Nieminen	dog	\N	DXgyueEqpz
2024-04-26 13:37:04.596	341	\N	\N	Helena Korhonen	dog	\N	q3dg81p6hQ
2024-04-26 13:37:04.608	342	\N	\N	Marjatta Mäkinen	dog	\N	clFc4CrQpo
2024-04-26 13:37:04.62	343	\N	\N	Ilmari Mäkelä	dog	\N	oz8FvLk1ZT
2024-04-26 13:37:04.633	344	\N	\N	Anneli Juustila	dog	\N	s97JW5QjCk
2024-04-26 13:37:04.646	345	\N	\N	Johanna Määttä	dog	\N	pEwWVEBThD
2024-04-26 13:37:04.659	346	\N	\N	Kaarina Heikkinen	dog	\N	A6QHeCds9E
2024-04-26 13:37:04.671	347	\N	\N	Ilmari Heikkinen	dog	\N	4CRU4f5RwL
2024-04-26 13:37:04.683	348	\N	\N	Ilmari Määttä	dog	\N	ZilDben62w
2024-04-26 13:37:04.697	349	\N	\N	Juhani Kumpulainen	dog	\N	AKbMesnOY9
2024-04-26 13:37:04.709	350	\N	\N	Juhani Nieminen	dog	\N	cZ3O2dOx7z
2024-04-26 13:37:04.722	351	\N	\N	Anneli Ollakka	savu_seura	\N	68mF0ZdSmK
2024-04-26 13:37:04.735	352	\N	\N	Maria Kumpulainen	savu_seura	\N	sJk6ix0Yo3
2024-04-26 13:37:04.749	353	\N	\N	Liisa Lehtinen	savu_seura	\N	yUTuUinKmw
2024-04-26 13:37:04.764	354	\N	\N	Johanna Kelanti	savu_seura	\N	UWJaDxW0tw
2024-04-26 13:37:04.777	355	\N	\N	Johanna Mäkinen	savu_seura	\N	dr9YOOjIAI
2024-04-26 13:37:04.791	356	\N	\N	Marjatta Kumpulainen	savu_seura	\N	1GUn65612S
2024-04-26 13:37:04.804	357	\N	\N	Marjatta Juustila	savu_seura	\N	rbljKgJAsq
2024-04-26 13:37:04.818	358	\N	\N	Anna Kumpulainen	savu_seura	\N	35vFHLfMeq
2024-04-26 13:37:04.832	359	\N	\N	Anneli Mäkelä	omas	\N	wKTR51NHFc
2024-04-26 13:37:04.846	360	\N	\N	Kalevi Komulainen	omas	\N	yeSYz0hEcl
2024-04-26 13:37:04.859	361	\N	\N	Matti Mäkinen	omas	\N	DjkX33jcEt
2024-04-26 13:37:04.871	362	\N	\N	Anna Nieminen	omas	\N	Et9z6ceajz
2024-04-26 13:37:04.887	363	\N	\N	Antero Juustila	omas	\N	J13XBYnMh1
2024-04-26 13:37:04.9	364	\N	\N	Tapio Kumpulainen	omas	\N	U2ABpTR88g
2024-04-26 13:37:04.913	365	\N	\N	Antero Järvinen	omas	\N	Zhwl2TRvaU
2024-04-26 13:37:04.927	366	\N	\N	Anneli Heikkinen	omas	\N	gaRIm1UZFt
2024-04-26 13:37:04.942	367	\N	\N	Mikael Juustila	omas	\N	5tvEUN9gzu
2024-04-26 13:37:04.956	368	\N	\N	Tapani Kelanti	pelleseura	\N	r6mQ4tsLBb
2024-04-26 13:37:04.97	369	\N	\N	Anna Kelanti	pelleseura	\N	OilgjeRe1B
2024-04-26 13:37:04.983	370	\N	\N	Ilmari Korhonen	pelleseura	\N	ptmZw5dfDP
2024-04-26 13:37:04.996	371	\N	\N	Juhani Järvinen	pelleseura	\N	IRKyaSh6qe
2024-04-26 13:37:05.012	372	\N	\N	Antero Kumpulainen	pelleseura	\N	DMtWiPpKoE
2024-04-26 13:37:05.026	373	\N	\N	Olavi Laine	pelleseura	\N	WK7fgMvoMb
2024-04-26 13:37:05.039	374	\N	\N	Liisa Kelanti	pelleseura	\N	siESbR4w0t
2024-04-26 13:37:05.051	375	\N	\N	Kaarina Komulainen	pelleseura	\N	ZilGRKfYqe
2024-04-26 13:37:05.064	376	\N	\N	Marjatta Virtanen	pelleseura	\N	KfGi85xCDD
2024-04-26 13:37:05.077	377	\N	\N	Matti Korhonen	pelleseura	\N	GVzuXn0g2P
2024-04-26 13:37:05.089	378	\N	\N	Johannes Järvinen	pelleseura	\N	2b6VD88L2G
2024-04-26 13:37:05.102	379	\N	\N	Liisa Laine	yung_tallent	\N	jibibWbMiJ
2024-04-26 13:37:05.113	380	\N	\N	Maria Korhonen	yung_tallent	\N	nQdMREp7Cq
2024-04-26 13:37:05.127	381	\N	\N	Johannes Järvinen	yung_tallent	\N	foVO23x882
2024-04-26 13:37:05.139	382	\N	\N	Matti Mäkelä	yung_tallent	\N	TddrV8JFVo
2024-04-26 13:37:05.151	383	\N	\N	Kalevi Mäkelä	aseharrastajien_yhtenaisyys	\N	nwWpPLfVHs
2024-04-26 13:37:05.17	384	\N	\N	Juhani Lehtinen	aseharrastajien_yhtenaisyys	\N	f78LWe05dN
2024-04-26 13:37:05.191	385	\N	\N	Juhani Juustila	aseharrastajien_yhtenaisyys	\N	8hniMtWauv
2024-04-26 13:37:05.207	386	\N	\N	Kaarina Heikkinen	aseharrastajien_yhtenaisyys	\N	uwKNJoug6j
2024-04-26 13:37:05.223	387	\N	\N	Anna Kelanti	aseharrastajien_yhtenaisyys	\N	DBNY7i30ME
2024-04-26 13:37:05.235	388	\N	\N	Tapani Korhonen	aseharrastajien_yhtenaisyys	\N	YmVlkmtoQ8
2024-04-26 13:37:05.249	389	\N	\N	Kaarina Heikkinen	aseharrastajien_yhtenaisyys	\N	xBxfIZnFAO
2024-04-26 13:37:05.262	390	\N	\N	Ilmari Juustila	tahtaysmestarit	\N	1LQw5NgbPI
2024-04-26 13:37:05.274	391	\N	\N	Maria Mäkelä	tahtaysmestarit	\N	tJ5BfG2LLi
2024-04-26 13:37:05.285	392	\N	\N	Olavi Ollakka	tahtaysmestarit	\N	bnEL9RmxjV
2024-04-26 13:37:05.298	393	\N	\N	Tapio Juustila	tahtaysmestarit	\N	V3vbB2DvNi
2024-04-26 13:37:05.313	394	\N	\N	Anna Kelanti	tahtaysmestarit	\N	f6mriCug6w
2024-04-26 13:37:05.325	395	\N	\N	Kalevi Hämäläinen	tahtaysmestarit	\N	HudaNaZ2ED
2024-04-26 13:37:05.337	396	\N	\N	Kalevi Korhonen	tahtaysmestarit	\N	6czaGETnSW
2024-04-26 13:37:05.349	397	\N	\N	Liisa Mäkinen	laukausryhma_aurora	\N	T5RUfvPOzE
2024-04-26 13:37:05.361	398	\N	\N	Johanna Heikkinen	laukausryhma_aurora	\N	9MxyQrG9eN
2024-04-26 13:37:05.374	399	\N	\N	Anna Mäkelä	laukausryhma_aurora	\N	y9USpjQrkt
2024-04-26 13:37:05.385	400	\N	\N	Anna Kelanti	ampumataito	\N	hLiKjlXXEd
2024-04-26 13:37:05.397	401	\N	\N	Anneli Ollakka	ampumataito	\N	EzQxh3LHXW
2024-04-26 13:37:05.409	402	\N	\N	Mikael Kelanti	ampumataito	\N	cbkSIBgW2Q
2024-04-26 13:37:05.421	403	\N	\N	Anneli Lehtinen	ampumataito	\N	gginbJpInP
2024-04-26 13:37:05.435	404	\N	\N	Tapio Kelanti	ampumataito	\N	cViEWiCSr8
2024-04-26 13:37:05.447	405	\N	\N	Juhani Juustila	ampumataito	\N	2ce14087qE
2024-04-26 13:37:05.459	406	\N	\N	Tapio Korhonen	ampumataito	\N	aVty88PA9h
2024-04-26 13:37:05.471	407	\N	\N	Olavi Holappa	ampumataito	\N	HbU1Gt7mzM
2024-04-26 13:37:05.483	408	\N	\N	Mikael Holappa	ampumataito	\N	G602sUBuHi
2024-04-26 13:37:05.495	409	\N	\N	Marjatta Holappa	ampumataito	\N	IMxIt6oGiw
2024-04-26 13:37:05.507	410	\N	\N	Marjatta Järvinen	ampumataito	\N	hAYSGgojh7
2024-04-26 13:37:05.52	411	\N	\N	Kaarina Lehtinen	ampumataito	\N	Th02FnVYcA
2024-04-26 13:37:05.531	412	\N	\N	Juhani Holappa	poliisiseura	\N	8OQ7amyOhi
2024-04-26 13:37:05.543	413	\N	\N	Liisa Kumpulainen	poliisiseura	\N	Qe1XrXuRlj
2024-04-26 13:37:05.556	414	\N	\N	Tapani Juustila	poliisiseura	\N	aacxQ52ZdR
2024-04-26 13:37:05.569	415	\N	\N	Liisa Määttä	poliisiseura	\N	hcaPbExb32
2024-04-26 13:37:05.582	416	\N	\N	Anneli Kelanti	poliisiseura	\N	dRnnnf6kA6
2024-04-26 13:37:05.596	417	\N	\N	Mikael Määttä	koiraseura	\N	7dlFfAGJHI
2024-04-26 13:37:05.609	418	\N	\N	Ilmari Mäkinen	koiraseura	\N	2xANrEu1Uz
2024-04-26 13:37:05.624	419	\N	\N	Maria Järvinen	koiraseura	\N	XYTcN6WHrA
2024-04-26 13:37:05.638	420	\N	\N	Helena Mäkelä	koiraseura	\N	f4SnOET0as
2024-04-26 13:37:05.652	421	\N	\N	Kalevi Lehtinen	koiraseura	\N	8LdXpiNM2t
2024-04-26 13:37:05.667	422	\N	\N	Anneli Kelanti	koiraseura	\N	UWb1i0f1Yz
2024-04-26 13:37:05.684	423	\N	\N	Kaarina Järvinen	koiraseura	\N	zjfylEt6rh
2024-04-26 13:37:05.699	424	\N	\N	Antero Määttä	hammaspeikkoseura	\N	8eHpsHx0BS
2024-04-26 13:37:05.713	425	\N	\N	Ilmari Ollakka	hammaspeikkoseura	\N	VV7al3GJt2
2024-04-26 13:37:05.728	426	\N	\N	Antero Komulainen	hammaspeikkoseura	\N	HPMwDaqIiI
2024-04-26 13:37:05.744	427	\N	\N	Marjatta Korhonen	hammaspeikkoseura	\N	KyY8DTMqOe
2024-04-26 13:37:05.759	428	\N	\N	Marjatta Virtanen	hammaspeikkoseura	\N	fVk5AMsFo3
2024-04-26 13:37:05.774	429	\N	\N	Kaarina Korhonen	hammaspeikkoseura	\N	h6SSLm2DPL
2024-04-26 13:37:05.788	430	\N	\N	Helena Juustila	hammaspeikkoseura	\N	FuPMn029so
2024-04-26 13:37:05.805	431	\N	\N	Ilmari Heikkinen	hammaspeikkoseura	\N	fXcSnQHj6R
2024-04-26 13:37:05.818	432	\N	\N	Matti Mäkelä	hammaspeikkoseura	\N	HA5GCrVPHl
2024-04-26 13:37:05.835	433	\N	\N	Kalevi Nieminen	dog	\N	UmVXIntw9Q
2024-04-26 13:37:05.853	434	\N	\N	Anneli Hämäläinen	dog	\N	xnVELNKG61
2024-04-26 13:37:05.876	435	\N	\N	Marjatta Laine	dog	\N	WwbwytRxa6
2024-04-26 13:37:05.894	436	\N	\N	Anneli Ollakka	dog	\N	drjqLKUsa5
2024-04-26 13:37:05.912	437	\N	\N	Johannes Kumpulainen	dog	\N	bT3tsEpj9l
2024-04-26 13:37:05.93	438	\N	\N	Matti Mäkelä	dog	\N	wXK3Exvzwd
2024-04-26 13:37:05.944	439	\N	\N	Liisa Mäkelä	dog	\N	T1O4k5222h
2024-04-26 13:37:05.96	440	\N	\N	Anneli Nieminen	dog	\N	OfCZLRFrHE
2024-04-26 13:37:05.973	441	\N	\N	Anna Juustila	dog	\N	ZgTytRi0In
2024-04-26 13:37:05.992	442	\N	\N	Kaarina Komulainen	dog	\N	w4mfQG3xot
2024-04-26 13:37:06.009	443	\N	\N	Maria Korhonen	dog	\N	5snExKHzH7
2024-04-26 13:37:06.026	444	\N	\N	Antero Kelanti	savu_seura	\N	4xSx6HnBVa
2024-04-26 13:37:06.043	445	\N	\N	Anna Korhonen	savu_seura	\N	SCYuLAX6uN
2024-04-26 13:37:06.061	446	\N	\N	Maria Ollakka	savu_seura	\N	ZtZLOk9wve
2024-04-26 13:37:06.075	447	\N	\N	Johannes Ollakka	savu_seura	\N	mIVhDiglHy
2024-04-26 13:37:06.089	448	\N	\N	Mikael Kelanti	savu_seura	\N	sL3SppRhH4
2024-04-26 13:37:06.104	449	\N	\N	Johannes Määttä	savu_seura	\N	TBQ4rUKPwb
2024-04-26 13:37:06.12	450	\N	\N	Matti Korhonen	savu_seura	\N	1TYqtsmymJ
2024-04-26 13:37:06.135	451	\N	\N	Johanna Laine	savu_seura	\N	8iIlKQkyGI
2024-04-26 13:37:06.15	452	\N	\N	Marjatta Holappa	savu_seura	\N	yQSxF5CIfz
2024-04-26 13:37:06.167	453	\N	\N	Mikael Koskinen	savu_seura	\N	JdOUZC0am5
2024-04-26 13:37:06.182	454	\N	\N	Antero Kelanti	savu_seura	\N	H0lutRYS23
2024-04-26 13:37:06.198	455	\N	\N	Johanna Mäkelä	omas	\N	HvvtFcUolN
2024-04-26 13:37:06.211	456	\N	\N	Ilmari Koskinen	omas	\N	oS0mbRGCRx
2024-04-26 13:37:06.224	457	\N	\N	Anna Hämäläinen	omas	\N	fmwiGnasTj
2024-04-26 13:37:06.237	458	\N	\N	Kaarina Holappa	omas	\N	y1bmwdZG5m
2024-04-26 13:37:06.25	459	\N	\N	Matti Nieminen	omas	\N	ZHjrPyguV2
2024-04-26 13:37:06.263	460	\N	\N	Anna Korhonen	omas	\N	l0hzuRsVyY
2024-04-26 13:37:06.275	461	\N	\N	Olavi Lehtinen	omas	\N	mcpnZNRcgh
2024-04-26 13:37:06.29	462	\N	\N	Juhani Juustila	omas	\N	7FHsRQEiAg
2024-04-26 13:37:06.305	463	\N	\N	Kalevi Järvinen	omas	\N	QSQC6yHl7J
2024-04-26 13:37:06.318	464	\N	\N	Liisa Nieminen	omas	\N	CW8e7NnoAr
2024-04-26 13:37:06.329	465	\N	\N	Liisa Mäkelä	omas	\N	6sP4oS5Bc1
2024-04-26 13:37:06.341	466	\N	\N	Kaarina Kelanti	omas	\N	fhFOLSx47w
2024-04-26 13:37:06.354	467	\N	\N	Anna Ollakka	omas	\N	dbsnShikIn
2024-04-26 13:37:06.366	468	\N	\N	Liisa Korhonen	omas	\N	55BAwvYTFn
2024-04-26 13:37:06.376	469	\N	\N	Kalevi Heikkinen	pelleseura	\N	rGCZrTG3vS
2024-04-26 13:37:06.388	470	\N	\N	Kalevi Hämäläinen	pelleseura	\N	bIONfkmBXY
2024-04-26 13:37:06.401	471	\N	\N	Mikael Ollakka	pelleseura	\N	AkFW0DgSDb
2024-04-26 13:37:06.414	472	\N	\N	Kalevi Määttä	pelleseura	\N	TAKOHuUzu1
2024-04-26 13:37:06.427	473	\N	\N	Anneli Koskinen	pelleseura	\N	q6q1huLF1i
2024-04-26 13:37:06.439	474	\N	\N	Ilmari Järvinen	pelleseura	\N	gWvBN3atJf
2024-04-26 13:37:06.451	475	\N	\N	Ilmari Mäkinen	pelleseura	\N	PWaOH23wiA
2024-04-26 13:37:06.462	476	\N	\N	Johannes Komulainen	pelleseura	\N	2l57PGkn4c
2024-04-26 13:37:06.475	477	\N	\N	Anneli Heikkinen	pelleseura	\N	9Zv3bPgaYh
2024-04-26 13:37:06.49	478	\N	\N	Maria Hämäläinen	pelleseura	\N	NsptCuxO5g
2024-04-26 13:37:06.502	479	\N	\N	Olavi Nieminen	pelleseura	\N	5yjlk7ObjO
2024-04-26 13:37:06.514	480	\N	\N	Juhani Kelanti	yung_tallent	\N	xpCZWHajsD
2024-04-26 13:37:06.526	481	\N	\N	Antero Ollakka	yung_tallent	\N	wAj4pngIUl
2024-04-26 13:37:06.539	482	\N	\N	Johanna Nieminen	yung_tallent	\N	NqjG4qs7Xy
2024-04-26 13:37:06.55	483	\N	\N	Liisa Mäkinen	yung_tallent	\N	yM8xBJVhHG
2024-04-26 13:37:06.563	484	\N	\N	Anneli Ollakka	aseharrastajien_yhtenaisyys	\N	nHxnXbuWwk
2024-04-26 13:37:06.574	485	\N	\N	Juhani Laine	aseharrastajien_yhtenaisyys	\N	HMHhp6Ech5
2024-04-26 13:37:06.586	486	\N	\N	Mikael Koskinen	aseharrastajien_yhtenaisyys	\N	US7XJPJoO9
2024-04-26 13:37:06.6	487	\N	\N	Ilmari Korhonen	aseharrastajien_yhtenaisyys	\N	4RZwb5Zhj5
2024-04-26 13:37:06.613	488	\N	\N	Kaarina Mäkinen	aseharrastajien_yhtenaisyys	\N	FfeZEL1dcN
2024-04-26 13:37:06.625	489	\N	\N	Johannes Heikkinen	aseharrastajien_yhtenaisyys	\N	kgqsTMtUtC
2024-04-26 13:37:06.636	490	\N	\N	Liisa Holappa	aseharrastajien_yhtenaisyys	\N	vocpCcSKPH
2024-04-26 13:37:06.648	491	\N	\N	Tapani Lehtinen	aseharrastajien_yhtenaisyys	\N	gzmFnxhoAM
2024-04-26 13:37:06.664	492	\N	\N	Johanna Koskinen	aseharrastajien_yhtenaisyys	\N	o4N28D3NVx
2024-04-26 13:37:06.676	493	\N	\N	Ilmari Järvinen	aseharrastajien_yhtenaisyys	\N	BbBpSofRCR
2024-04-26 13:37:06.688	494	\N	\N	Juhani Mäkelä	tahtaysmestarit	\N	P2pap2yRwP
2024-04-26 13:37:06.701	495	\N	\N	Helena Koskinen	tahtaysmestarit	\N	qeW5tyhwjB
2024-04-26 13:37:06.714	496	\N	\N	Liisa Ollakka	tahtaysmestarit	\N	XLIJyFQaZR
2024-04-26 13:37:06.727	497	\N	\N	Helena Juustila	tahtaysmestarit	\N	kJQNZfNBl4
2024-04-26 13:37:06.739	498	\N	\N	Marjatta Komulainen	tahtaysmestarit	\N	TYspJzfVyg
2024-04-26 13:37:06.751	499	\N	\N	Matti Järvinen	tahtaysmestarit	\N	3RmkthSV9F
2024-04-26 13:37:06.764	500	\N	\N	Anneli Lehtinen	tahtaysmestarit	\N	7R2mUEsGGL
2024-04-26 13:37:06.777	501	\N	\N	Anneli Komulainen	tahtaysmestarit	\N	REfst7OZpe
2024-04-26 13:37:06.793	502	\N	\N	Olavi Mäkelä	tahtaysmestarit	\N	WZl81UruTF
2024-04-26 13:37:06.805	503	\N	\N	Mikael Komulainen	tahtaysmestarit	\N	9ihw6p1i65
2024-04-26 13:37:06.818	504	\N	\N	Anneli Järvinen	tahtaysmestarit	\N	fI2SvRBz9y
2024-04-26 13:37:06.83	505	\N	\N	Liisa Komulainen	tahtaysmestarit	\N	reNz8bWp41
2024-04-26 13:37:06.843	506	\N	\N	Olavi Holappa	laukausryhma_aurora	\N	zCjsKeBrcX
2024-04-26 13:37:06.857	507	\N	\N	Liisa Korhonen	laukausryhma_aurora	\N	0AlCZE6AQk
2024-04-26 13:37:06.87	508	\N	\N	Anna Järvinen	laukausryhma_aurora	\N	TFV0yRsZ9o
2024-04-26 13:37:06.882	509	\N	\N	Helena Koskinen	laukausryhma_aurora	\N	6olt9jtCQb
2024-04-26 13:37:06.896	510	\N	\N	Juhani Mäkelä	laukausryhma_aurora	\N	eNefFJMJho
2024-04-26 13:37:06.911	511	\N	\N	Mikael Kelanti	laukausryhma_aurora	\N	wnKWv5PEM7
2024-04-26 13:37:06.924	512	\N	\N	Johanna Mäkelä	laukausryhma_aurora	\N	tA5JPUvJO9
2024-04-26 13:37:06.936	513	\N	\N	Kaarina Mäkinen	laukausryhma_aurora	\N	8Z9WG4I7Ik
2024-04-26 13:37:06.947	514	\N	\N	Johannes Heikkinen	laukausryhma_aurora	\N	3K4KYzcmrd
2024-04-26 13:37:06.959	515	\N	\N	Helena Ollakka	laukausryhma_aurora	\N	hVtZ98zZnF
2024-04-26 13:37:06.973	516	\N	\N	Tapio Heikkinen	laukausryhma_aurora	\N	8BIprwL3ia
2024-04-26 13:37:06.986	517	\N	\N	Antero Järvinen	laukausryhma_aurora	\N	JHllKr61hB
2024-04-26 13:37:07.004	518	\N	\N	Anneli Korhonen	laukausryhma_aurora	\N	YkGoOk4pUy
2024-04-26 13:37:07.024	519	\N	\N	Marjatta Ollakka	laukausryhma_aurora	\N	d9OC2HeDaj
2024-04-26 13:37:07.041	520	\N	\N	Anneli Hämäläinen	ampumataito	\N	BP9tCDB0Kt
2024-04-26 13:37:07.056	521	\N	\N	Johannes Virtanen	ampumataito	\N	wzotITEfe0
2024-04-26 13:37:07.071	522	\N	\N	Johannes Määttä	ampumataito	\N	70abgLVUh2
2024-04-26 13:37:07.084	523	\N	\N	Tapio Mäkinen	poliisiseura	\N	XTZzb610iv
2024-04-26 13:37:07.098	524	\N	\N	Tapio Laine	poliisiseura	\N	vCkmjFNenA
2024-04-26 13:37:07.112	525	\N	\N	Olavi Määttä	poliisiseura	\N	A6PZW5oyaY
2024-04-26 13:37:07.125	526	\N	\N	Johanna Ollakka	poliisiseura	\N	zZI4YmE3tG
2024-04-26 13:37:07.138	527	\N	\N	Marjatta Laine	poliisiseura	\N	rG1KDTw8TG
2024-04-26 13:37:07.154	528	\N	\N	Mikael Nieminen	poliisiseura	\N	maAVDUrdNS
2024-04-26 13:37:07.166	529	\N	\N	Kaarina Laine	poliisiseura	\N	59ALh84EUc
2024-04-26 13:37:07.18	530	\N	\N	Anna Kelanti	poliisiseura	\N	Rql5FgknbH
2024-04-26 13:37:07.195	531	\N	\N	Johanna Komulainen	poliisiseura	\N	9pFRI58l5I
2024-04-26 13:37:07.208	532	\N	\N	Mikael Holappa	koiraseura	\N	R5WDCWVd5W
2024-04-26 13:37:07.223	533	\N	\N	Maria Lehtinen	koiraseura	\N	RAZHdBstpS
2024-04-26 13:37:07.237	534	\N	\N	Ilmari Lehtinen	koiraseura	\N	DjS70imKXe
2024-04-26 13:37:07.249	535	\N	\N	Helena Mäkelä	koiraseura	\N	z2KaNYRBUM
2024-04-26 13:37:07.261	536	\N	\N	Mikael Ollakka	koiraseura	\N	WOcwL8SZEb
2024-04-26 13:37:07.273	537	\N	\N	Liisa Määttä	koiraseura	\N	PDt5rt0OnU
2024-04-26 13:37:07.286	538	\N	\N	Anneli Kelanti	koiraseura	\N	UqYbR8JFg8
2024-04-26 13:37:07.298	539	\N	\N	Kaarina Korhonen	koiraseura	\N	UyijcaulWc
2024-04-26 13:37:07.31	540	\N	\N	Anna Koskinen	hammaspeikkoseura	\N	0OSKqjpFz0
2024-04-26 13:37:07.321	541	\N	\N	Juhani Holappa	hammaspeikkoseura	\N	hzY4p8qmrk
2024-04-26 13:37:07.333	542	\N	\N	Maria Hämäläinen	hammaspeikkoseura	\N	4ve9kHXED6
2024-04-26 13:37:07.346	543	\N	\N	Anneli Nieminen	hammaspeikkoseura	\N	GnPS7ULvC4
2024-04-26 13:37:07.358	544	\N	\N	Matti Määttä	hammaspeikkoseura	\N	K4cXtB5EXG
2024-04-26 13:37:07.37	545	\N	\N	Kaarina Koskinen	hammaspeikkoseura	\N	YOmaMYyS5t
2024-04-26 13:37:07.382	546	\N	\N	Ilmari Heikkinen	hammaspeikkoseura	\N	RaS40o9BS9
2024-04-26 13:37:07.394	547	\N	\N	Liisa Virtanen	hammaspeikkoseura	\N	czhWR8tvJm
2024-04-26 13:37:07.407	548	\N	\N	Liisa Mäkelä	hammaspeikkoseura	\N	zsnKiK5YZo
2024-04-26 13:37:07.418	549	\N	\N	Anna Määttä	hammaspeikkoseura	\N	Cqc1HF83oe
2024-04-26 13:37:07.43	550	\N	\N	Ilmari Juustila	hammaspeikkoseura	\N	tv8C0Qnr8h
2024-04-26 13:37:07.442	551	\N	\N	Matti Virtanen	dog	\N	MLq2JJepPV
2024-04-26 13:37:07.453	552	\N	\N	Antero Komulainen	dog	\N	NaDovL1XC5
2024-04-26 13:37:07.467	553	\N	\N	Maria Komulainen	dog	\N	CefKOb9yr8
2024-04-26 13:37:07.479	554	\N	\N	Kaarina Mäkinen	dog	\N	hzRmSkf8WG
2024-04-26 13:37:07.491	555	\N	\N	Tapio Järvinen	savu_seura	\N	ezlLGAp7zN
2024-04-26 13:37:07.504	556	\N	\N	Helena Hämäläinen	savu_seura	\N	RG1rmeC7MY
2024-04-26 13:37:07.516	557	\N	\N	Tapani Kumpulainen	savu_seura	\N	rR1cUDcUri
2024-04-26 13:37:07.53	558	\N	\N	Kalevi Järvinen	savu_seura	\N	cDjY4Si06n
2024-04-26 13:37:07.543	559	\N	\N	Anneli Koskinen	savu_seura	\N	odiXztrHUz
2024-04-26 13:37:07.555	560	\N	\N	Anneli Heikkinen	savu_seura	\N	OdAYukl4OG
2024-04-26 13:37:07.567	561	\N	\N	Johannes Lehtinen	savu_seura	\N	ggElVGEEl8
2024-04-26 13:37:07.58	562	\N	\N	Johannes Määttä	savu_seura	\N	GuAC8egRbQ
2024-04-26 13:37:07.593	563	\N	\N	Liisa Komulainen	savu_seura	\N	FRa4fISxpV
2024-04-26 13:37:07.606	564	\N	\N	Helena Ollakka	savu_seura	\N	uCIAK9nV3o
2024-04-26 13:37:07.618	565	\N	\N	Anna Komulainen	savu_seura	\N	3khpd4woYe
2024-04-26 13:37:07.631	566	\N	\N	Matti Juustila	savu_seura	\N	CxwKF9Bd4w
2024-04-26 13:37:07.643	567	\N	\N	Juhani Komulainen	omas	\N	N2ZhV7FSAE
2024-04-26 13:37:07.655	568	\N	\N	Tapio Kumpulainen	omas	\N	geT93IYLR2
2024-04-26 13:37:07.666	569	\N	\N	Helena Kelanti	omas	\N	ndw7SUWAir
2024-04-26 13:37:07.679	570	\N	\N	Kaarina Komulainen	omas	\N	9h8WvYskmu
2024-04-26 13:37:07.691	571	\N	\N	Tapani Mäkinen	omas	\N	mDXIPRMv32
2024-04-26 13:37:07.703	572	\N	\N	Kaarina Määttä	omas	\N	CcKDbrjjhn
2024-04-26 13:37:07.715	573	\N	\N	Maria Lehtinen	omas	\N	Y7ZgvWsKDs
2024-04-26 13:37:07.727	574	\N	\N	Mikael Hämäläinen	omas	\N	rUQeTN8GYH
2024-04-26 13:37:07.74	575	\N	\N	Ilmari Komulainen	omas	\N	KCXvSwpzYq
2024-04-26 13:37:07.751	576	\N	\N	Antero Korhonen	pelleseura	\N	LuQYdCjl5h
2024-04-26 13:37:07.763	577	\N	\N	Maria Koskinen	pelleseura	\N	AsDMMIGQtJ
2024-04-26 13:37:07.777	578	\N	\N	Ilmari Mäkelä	pelleseura	\N	jpd8HOCtHW
2024-04-26 13:37:07.79	579	\N	\N	Juhani Mäkelä	pelleseura	\N	GJPQaH1aok
2024-04-26 13:37:07.801	580	\N	\N	Liisa Nieminen	pelleseura	\N	9EGC8U9Fc0
2024-04-26 13:37:07.814	581	\N	\N	Matti Järvinen	pelleseura	\N	W8piBFpb26
2024-04-26 13:37:07.827	582	\N	\N	Marjatta Ollakka	pelleseura	\N	JH9t7AAONw
2024-04-26 13:37:07.841	583	\N	\N	Marjatta Koskinen	yung_tallent	\N	4Y0iovwDQs
2024-04-26 13:37:07.853	584	\N	\N	Kalevi Järvinen	yung_tallent	\N	cGUcBsHrOa
2024-04-26 13:37:07.866	585	\N	\N	Maria Komulainen	yung_tallent	\N	qHrreeUZoJ
2024-04-26 13:37:07.88	586	\N	\N	Marjatta Lehtinen	yung_tallent	\N	saQpjhJ8P8
2024-04-26 13:37:07.894	587	\N	\N	Matti Virtanen	yung_tallent	\N	B8pMO2Bu71
2024-04-26 13:37:07.908	588	\N	\N	Matti Hämäläinen	aseharrastajien_yhtenaisyys	\N	HpUzliXLu3
2024-04-26 13:37:07.92	589	\N	\N	Tapio Korhonen	aseharrastajien_yhtenaisyys	\N	8WIW0W75st
2024-04-26 13:37:07.933	590	\N	\N	Maria Laine	aseharrastajien_yhtenaisyys	\N	Vr9Ivsa95j
2024-04-26 13:37:07.945	591	\N	\N	Marjatta Heikkinen	aseharrastajien_yhtenaisyys	\N	4AN3Jh2v3n
2024-04-26 13:37:07.96	592	\N	\N	Helena Koskinen	aseharrastajien_yhtenaisyys	\N	azGi4JCbJl
2024-04-26 13:37:07.973	593	\N	\N	Marjatta Koskinen	aseharrastajien_yhtenaisyys	\N	r5rn03Rn1H
2024-04-26 13:37:07.985	594	\N	\N	Anna Mäkinen	aseharrastajien_yhtenaisyys	\N	5iaJqEYzHZ
2024-04-26 13:37:07.997	595	\N	\N	Matti Hämäläinen	aseharrastajien_yhtenaisyys	\N	AMW68VY1hG
2024-04-26 13:37:08.012	596	\N	\N	Antero Määttä	aseharrastajien_yhtenaisyys	\N	XtwtC4roaj
2024-04-26 13:37:08.025	597	\N	\N	Anneli Laine	aseharrastajien_yhtenaisyys	\N	Qo3es1HKJI
2024-04-26 13:37:08.038	598	\N	\N	Johanna Lehtinen	aseharrastajien_yhtenaisyys	\N	GT1w5svhPI
2024-04-26 13:37:08.05	599	\N	\N	Matti Ollakka	tahtaysmestarit	\N	BmaTJN0iqB
2024-04-26 13:37:08.063	600	\N	\N	Anna Mäkinen	tahtaysmestarit	\N	PfAPKuBtm9
2024-04-26 13:37:08.077	601	\N	\N	Maria Ollakka	tahtaysmestarit	\N	TusuobaNKd
2024-04-26 13:37:08.089	602	\N	\N	Johanna Järvinen	tahtaysmestarit	\N	is15DhEmUV
2024-04-26 13:37:08.101	603	\N	\N	Mikael Kumpulainen	laukausryhma_aurora	\N	1wie9HVr7T
2024-04-26 13:37:08.114	604	\N	\N	Johanna Hämäläinen	laukausryhma_aurora	\N	7hkl9aMu3D
2024-04-26 13:37:08.127	605	\N	\N	Juhani Korhonen	laukausryhma_aurora	\N	sIuYCBbp1f
2024-04-26 13:37:08.141	606	\N	\N	Tapio Hämäläinen	laukausryhma_aurora	\N	4ciEUIuRAK
2024-04-26 13:37:08.154	607	\N	\N	Maria Kelanti	laukausryhma_aurora	\N	BsqZy5CTGp
2024-04-26 13:37:08.165	608	\N	\N	Mikael Ollakka	laukausryhma_aurora	\N	EOrgdSentc
2024-04-26 13:37:08.18	609	\N	\N	Kalevi Kelanti	laukausryhma_aurora	\N	oKR65Q737C
2024-04-26 13:37:08.193	610	\N	\N	Helena Koskinen	laukausryhma_aurora	\N	Ah4HfjKQiF
2024-04-26 13:37:08.207	611	\N	\N	Ilmari Mäkelä	laukausryhma_aurora	\N	9BzIJwnhTh
2024-04-26 13:37:08.22	612	\N	\N	Johannes Määttä	laukausryhma_aurora	\N	Qw5mFZREYS
2024-04-26 13:37:08.233	613	\N	\N	Antero Juustila	laukausryhma_aurora	\N	iiDHenSlYj
2024-04-26 13:37:08.248	614	\N	\N	Anneli Hämäläinen	ampumataito	\N	q53cyDgGR7
2024-04-26 13:37:08.261	615	\N	\N	Matti Kumpulainen	ampumataito	\N	icyROolGdL
2024-04-26 13:37:08.273	616	\N	\N	Anna Mäkinen	ampumataito	\N	SIWYTmWybN
2024-04-26 13:37:08.286	617	\N	\N	Tapio Nieminen	ampumataito	\N	cN6byMiaYh
2024-04-26 13:37:08.298	618	\N	\N	Olavi Korhonen	ampumataito	\N	aINFMpBKjB
2024-04-26 13:37:08.31	619	\N	\N	Kalevi Kelanti	ampumataito	\N	KCSdTR1qIv
2024-04-26 13:37:08.323	620	\N	\N	Kalevi Mäkinen	ampumataito	\N	Q1eE3cPKvo
2024-04-26 13:37:08.335	621	\N	\N	Maria Laine	poliisiseura	\N	Ho64TGjYq9
2024-04-26 13:37:08.347	622	\N	\N	Helena Holappa	poliisiseura	\N	zwQwZATz4d
2024-04-26 13:37:08.358	623	\N	\N	Anna Nieminen	poliisiseura	\N	F1uTKktO0x
2024-04-26 13:37:08.37	624	\N	\N	Helena Kumpulainen	poliisiseura	\N	GczOoWmiHE
2024-04-26 13:37:08.384	625	\N	\N	Johannes Nieminen	koiraseura	\N	6uZKpi3RTJ
2024-04-26 13:37:08.397	626	\N	\N	Ilmari Virtanen	koiraseura	\N	1vKuynvzGb
2024-04-26 13:37:08.409	627	\N	\N	Mikael Kumpulainen	koiraseura	\N	gaLerSZV6V
2024-04-26 13:37:08.42	628	\N	\N	Ilmari Virtanen	koiraseura	\N	6SRsssLrc3
2024-04-26 13:37:08.432	629	\N	\N	Tapio Mäkinen	koiraseura	\N	wJc2ENgqPF
2024-04-26 13:37:08.446	630	\N	\N	Tapani Juustila	koiraseura	\N	UcgUzTGjmY
2024-04-26 13:37:08.458	631	\N	\N	Kalevi Ollakka	koiraseura	\N	osicOABEtJ
2024-04-26 13:37:08.47	632	\N	\N	Helena Koskinen	hammaspeikkoseura	\N	6hashfdanw
2024-04-26 13:37:08.482	633	\N	\N	Johannes Kelanti	hammaspeikkoseura	\N	t8MMm96wmX
2024-04-26 13:37:08.494	634	\N	\N	Mikael Komulainen	hammaspeikkoseura	\N	yTi1og7CXT
2024-04-26 13:37:08.508	635	\N	\N	Anneli Heikkinen	hammaspeikkoseura	\N	XUPBCYsQnI
2024-04-26 13:37:08.52	636	\N	\N	Maria Kelanti	hammaspeikkoseura	\N	xdWWXA9UTh
2024-04-26 13:37:08.533	637	\N	\N	Johanna Heikkinen	hammaspeikkoseura	\N	DWZ0RhBLNG
2024-04-26 13:37:08.545	638	\N	\N	Anna Kelanti	hammaspeikkoseura	\N	ZATuM015Vs
2024-04-26 13:37:08.557	639	\N	\N	Matti Mäkinen	hammaspeikkoseura	\N	l72ZDx7iux
2024-04-26 13:37:08.57	640	\N	\N	Tapani Hämäläinen	hammaspeikkoseura	\N	Ahq9Xy3rjc
2024-04-26 13:37:08.582	641	\N	\N	Olavi Järvinen	hammaspeikkoseura	\N	B7AsumDWo2
2024-04-26 13:37:08.595	642	\N	\N	Anneli Järvinen	hammaspeikkoseura	\N	1CJibHYNqZ
2024-04-26 13:37:08.607	643	\N	\N	Juhani Hämäläinen	hammaspeikkoseura	\N	221vXoI5Cr
2024-04-26 13:37:08.619	644	\N	\N	Tapani Laine	hammaspeikkoseura	\N	bZ5HlUh3P5
2024-04-26 13:37:08.632	645	\N	\N	Maria Koskinen	dog	\N	eONp2YYkpJ
2024-04-26 13:37:08.644	646	\N	\N	Matti Hämäläinen	dog	\N	br2L7YtPIE
2024-04-26 13:37:08.655	647	\N	\N	Anneli Koskinen	dog	\N	3cxGLTHwkm
2024-04-26 13:37:08.667	648	\N	\N	Kaarina Virtanen	dog	\N	OdwSQu7Gqc
2024-04-26 13:37:08.678	649	\N	\N	Tapio Lehtinen	dog	\N	E7LTqo8Pfd
2024-04-26 13:37:08.692	650	\N	\N	Johanna Holappa	dog	\N	oINOZBXgvd
2024-04-26 13:37:08.705	651	\N	\N	Kalevi Ollakka	dog	\N	0ZntpW3it8
2024-04-26 13:37:08.717	652	\N	\N	Tapio Järvinen	dog	\N	45ipPzJ7KK
2024-04-26 13:37:08.729	653	\N	\N	Marjatta Virtanen	dog	\N	JSUkIgrA7E
2024-04-26 13:37:08.742	654	\N	\N	Olavi Kumpulainen	savu_seura	\N	0oJOkrUUU1
2024-04-26 13:37:08.755	655	\N	\N	Mikael Lehtinen	savu_seura	\N	NAogvaE0qJ
2024-04-26 13:37:08.767	656	\N	\N	Olavi Hämäläinen	savu_seura	\N	TZEKyfyZpR
2024-04-26 13:37:08.787	657	\N	\N	Mikael Hämäläinen	savu_seura	\N	yB0WC83sse
2024-04-26 13:37:08.804	658	\N	\N	Kaarina Mäkinen	omas	\N	V6u30U0soC
2024-04-26 13:37:08.823	659	\N	\N	Helena Lehtinen	omas	\N	k9vo9pVzee
2024-04-26 13:37:08.84	660	\N	\N	Matti Mäkinen	omas	\N	hOWzgAl4ng
2024-04-26 13:37:08.854	661	\N	\N	Antero Heikkinen	pelleseura	\N	JGXKex5Qh8
2024-04-26 13:37:08.871	662	\N	\N	Tapio Korhonen	pelleseura	\N	MqQQDBJFKj
2024-04-26 13:37:08.884	663	\N	\N	Johannes Virtanen	pelleseura	\N	mJ4fkHBNjd
2024-04-26 13:37:08.895	664	\N	\N	Johanna Juustila	pelleseura	\N	yiM7mnLcAS
2024-04-26 13:37:08.907	665	\N	\N	Anna Kumpulainen	pelleseura	\N	zQzGNqOfVy
2024-04-26 13:37:08.919	666	\N	\N	Antero Lehtinen	pelleseura	\N	XBVcQdDqpO
2024-04-26 13:37:08.931	667	\N	\N	Matti Mäkinen	pelleseura	\N	RHRDmYIsbU
2024-04-26 13:37:08.944	668	\N	\N	Marjatta Komulainen	yung_tallent	\N	7Rmwopd1Xj
2024-04-26 13:37:08.956	669	\N	\N	Mikael Juustila	yung_tallent	\N	yWLVjnXvRZ
2024-04-26 13:37:08.968	670	\N	\N	Olavi Laine	yung_tallent	\N	GGakGWcTel
2024-04-26 13:37:08.979	671	\N	\N	Liisa Korhonen	yung_tallent	\N	ySeF6IvKzX
2024-04-26 13:37:08.992	672	\N	\N	Tapio Laine	yung_tallent	\N	8LapZYB84E
2024-04-26 13:37:09.005	673	\N	\N	Tapani Hämäläinen	yung_tallent	\N	kGU07vvCUZ
2024-04-26 13:37:09.017	674	\N	\N	Antero Mäkelä	yung_tallent	\N	Ad5HlYMsIb
2024-04-26 13:37:09.028	675	\N	\N	Johannes Mäkelä	yung_tallent	\N	qAPcbMZCSN
2024-04-26 13:37:09.04	676	\N	\N	Marjatta Määttä	yung_tallent	\N	FHoNdSU944
2024-04-26 13:37:09.052	677	\N	\N	Matti Korhonen	yung_tallent	\N	y5Ivwb9P9x
2024-04-26 13:37:09.066	678	\N	\N	Helena Holappa	yung_tallent	\N	MKpFghs2cr
2024-04-26 13:37:09.078	679	\N	\N	Maria Järvinen	aseharrastajien_yhtenaisyys	\N	aHOpQx0KkM
2024-04-26 13:37:09.09	680	\N	\N	Anneli Mäkelä	aseharrastajien_yhtenaisyys	\N	gfuLD6p0N8
2024-04-26 13:37:09.103	681	\N	\N	Helena Mäkinen	aseharrastajien_yhtenaisyys	\N	OX6rP0Tiz2
2024-04-26 13:37:09.115	682	\N	\N	Mikael Määttä	aseharrastajien_yhtenaisyys	\N	EV1oVzpTiv
2024-04-26 13:37:09.128	683	\N	\N	Juhani Ollakka	tahtaysmestarit	\N	R3dxzWzsZD
2024-04-26 13:37:09.139	684	\N	\N	Olavi Lehtinen	tahtaysmestarit	\N	p28e1VGTQJ
2024-04-26 13:37:09.152	685	\N	\N	Anna Virtanen	tahtaysmestarit	\N	kdAunyUhAK
2024-04-26 13:37:09.163	686	\N	\N	Johanna Nieminen	tahtaysmestarit	\N	gsQbqiGeVO
2024-04-26 13:37:09.176	687	\N	\N	Mikael Kelanti	tahtaysmestarit	\N	LapPhqCr2h
2024-04-26 13:37:09.189	688	\N	\N	Liisa Juustila	tahtaysmestarit	\N	SyeWQ3ug2N
2024-04-26 13:37:09.201	689	\N	\N	Ilmari Järvinen	tahtaysmestarit	\N	vPs1zvlAaz
2024-04-26 13:37:09.212	690	\N	\N	Liisa Nieminen	laukausryhma_aurora	\N	bFtv0G5uCv
2024-04-26 13:37:09.224	691	\N	\N	Tapio Mäkelä	laukausryhma_aurora	\N	ZoXAKdP6i1
2024-04-26 13:37:09.237	692	\N	\N	Anna Juustila	laukausryhma_aurora	\N	8WtUmcAFSX
2024-04-26 13:37:09.25	693	\N	\N	Kalevi Hämäläinen	laukausryhma_aurora	\N	uPza1sDw0t
2024-04-26 13:37:09.262	694	\N	\N	Helena Heikkinen	laukausryhma_aurora	\N	lC2QybQmy5
2024-04-26 13:37:09.274	695	\N	\N	Johanna Mäkinen	laukausryhma_aurora	\N	AtXbBPKQo7
2024-04-26 13:37:09.286	696	\N	\N	Mikael Nieminen	laukausryhma_aurora	\N	7wodzkoPmy
2024-04-26 13:37:09.3	697	\N	\N	Juhani Mäkelä	laukausryhma_aurora	\N	8igQCSE2t3
2024-04-26 13:37:09.313	698	\N	\N	Helena Lehtinen	laukausryhma_aurora	\N	vgphnkcJRC
2024-04-26 13:37:09.324	699	\N	\N	Johanna Ollakka	ampumataito	\N	rNwRAEvlhN
2024-04-26 13:37:09.336	700	\N	\N	Juhani Nieminen	ampumataito	\N	JTIrKDVw1h
2024-04-26 13:37:09.347	701	\N	\N	Olavi Lehtinen	ampumataito	\N	MBYS8vYTqa
2024-04-26 13:37:09.359	702	\N	\N	Anna Laine	ampumataito	\N	EcFbdbDUEH
2024-04-26 13:37:09.373	703	\N	\N	Liisa Mäkinen	ampumataito	\N	0BNUV27pmC
2024-04-26 13:37:09.384	704	\N	\N	Antero Nieminen	ampumataito	\N	6C3fiIj3tt
2024-04-26 13:37:09.396	705	\N	\N	Marjatta Nieminen	ampumataito	\N	KWn2wQEOCw
2024-04-26 13:37:09.408	706	\N	\N	Ilmari Nieminen	ampumataito	\N	au8FalkwCh
2024-04-26 13:37:09.421	707	\N	\N	Tapani Lehtinen	ampumataito	\N	U6JbStmFnp
2024-04-26 13:37:09.433	708	\N	\N	Kaarina Mäkinen	ampumataito	\N	00cM3h31H8
2024-04-26 13:37:09.446	709	\N	\N	Maria Nieminen	ampumataito	\N	xmqFUtwpp1
2024-04-26 13:37:09.458	710	\N	\N	Tapio Lehtinen	ampumataito	\N	fvOoOctrec
2024-04-26 13:37:09.469	711	\N	\N	Kaarina Lehtinen	ampumataito	\N	utapYHhrh5
2024-04-26 13:37:09.482	712	\N	\N	Anna Mäkinen	ampumataito	\N	L9LXmWZWuV
2024-04-26 13:37:09.495	713	\N	\N	Matti Mäkinen	poliisiseura	\N	SIRALZrr0w
2024-04-26 13:37:09.507	714	\N	\N	Kaarina Lehtinen	poliisiseura	\N	gxbusjrQSd
2024-04-26 13:37:09.521	715	\N	\N	Kalevi Komulainen	poliisiseura	\N	4dwGWolp9I
2024-04-26 13:37:09.532	716	\N	\N	Anna Koskinen	poliisiseura	\N	vCD8utvSby
2024-04-26 13:37:09.544	717	\N	\N	Johannes Laine	poliisiseura	\N	KufBndKjm9
2024-04-26 13:37:09.557	718	\N	\N	Marjatta Mäkinen	poliisiseura	\N	SNOy3BJbZF
2024-04-26 13:37:09.57	719	\N	\N	Tapio Mäkelä	poliisiseura	\N	YtonMVFfHf
2024-04-26 13:37:09.583	720	\N	\N	Maria Nieminen	poliisiseura	\N	qix3Y2zXhu
2024-04-26 13:37:09.595	721	\N	\N	Helena Mäkinen	koiraseura	\N	oRqBdDObXM
2024-04-26 13:37:09.608	722	\N	\N	Marjatta Heikkinen	koiraseura	\N	Pq750PlY2x
2024-04-26 13:37:09.62	723	\N	\N	Helena Holappa	koiraseura	\N	X0RHjYtyER
2024-04-26 13:37:09.632	724	\N	\N	Juhani Mäkinen	koiraseura	\N	Xe8BNrpega
2024-04-26 13:37:09.645	725	\N	\N	Olavi Korhonen	koiraseura	\N	yMDcT5v6Oj
2024-04-26 13:37:09.657	726	\N	\N	Marjatta Heikkinen	koiraseura	\N	z4xKq1O64g
2024-04-26 13:37:09.67	727	\N	\N	Ilmari Heikkinen	koiraseura	\N	WMEUqDEtDh
2024-04-26 13:37:09.682	728	\N	\N	Helena Holappa	koiraseura	\N	fenR3Vofsu
2024-04-26 13:37:09.693	729	\N	\N	Olavi Juustila	koiraseura	\N	z0S5yL9GQa
2024-04-26 13:37:09.705	730	\N	\N	Marjatta Mäkelä	koiraseura	\N	DbhE8S9lsO
2024-04-26 13:37:09.716	731	\N	\N	Johannes Juustila	koiraseura	\N	cIoHOqsdVV
2024-04-26 13:37:09.728	732	\N	\N	Johanna Kumpulainen	hammaspeikkoseura	\N	nHTjvAXzRU
2024-04-26 13:37:09.742	733	\N	\N	Antero Korhonen	hammaspeikkoseura	\N	0lxaPGuXDh
2024-04-26 13:37:09.754	734	\N	\N	Johannes Koskinen	hammaspeikkoseura	\N	AHzaSJ0Eto
2024-04-26 13:37:09.766	735	\N	\N	Olavi Juustila	hammaspeikkoseura	\N	ZI4sunoxOJ
2024-04-26 13:37:09.778	736	\N	\N	Liisa Hämäläinen	dog	\N	7nzLN1zdJY
2024-04-26 13:37:09.792	737	\N	\N	Matti Juustila	dog	\N	xz2fsUFJKy
2024-04-26 13:37:09.805	738	\N	\N	Kalevi Laine	dog	\N	C9ZY5CadgF
2024-04-26 13:37:09.816	739	\N	\N	Olavi Virtanen	dog	\N	Oie8zVuGHi
2024-04-26 13:37:09.828	740	\N	\N	Johannes Järvinen	dog	\N	Yfjba2o4HH
2024-04-26 13:37:09.84	741	\N	\N	Olavi Juustila	dog	\N	9B307Gozuu
2024-04-26 13:37:09.852	742	\N	\N	Mikael Korhonen	dog	\N	NxZ9k2lYSX
2024-04-26 13:37:09.864	743	\N	\N	Johannes Järvinen	dog	\N	G5HMi8Nxzd
2024-04-26 13:37:09.876	744	\N	\N	Anna Ollakka	savu_seura	\N	yXM1UxXfkx
2024-04-26 13:37:09.888	745	\N	\N	Johanna Heikkinen	savu_seura	\N	W2kdgvJHox
2024-04-26 13:37:09.901	746	\N	\N	Anneli Ollakka	savu_seura	\N	0escEPXVNL
2024-04-26 13:37:09.914	747	\N	\N	Kalevi Mäkinen	savu_seura	\N	eTEDS046ci
2024-04-26 13:37:09.929	748	\N	\N	Olavi Lehtinen	savu_seura	\N	wEFieNWD35
2024-04-26 13:37:09.942	749	\N	\N	Tapani Koskinen	savu_seura	\N	grrWkMDaiP
2024-04-26 13:37:09.954	750	\N	\N	Antero Laine	savu_seura	\N	NvzKWacbIS
2024-04-26 13:37:09.966	751	\N	\N	Juhani Nieminen	savu_seura	\N	KPY9U1IDwZ
2024-04-26 13:37:09.979	752	\N	\N	Anneli Mäkelä	savu_seura	\N	L6xhVeeawP
2024-04-26 13:37:09.991	753	\N	\N	Marjatta Laine	savu_seura	\N	g72DYuyhVX
2024-04-26 13:37:10.003	754	\N	\N	Johannes Komulainen	savu_seura	\N	12e5wfMe9q
2024-04-26 13:37:10.015	755	\N	\N	Olavi Kelanti	savu_seura	\N	cLKouvqvbC
2024-04-26 13:37:10.028	756	\N	\N	Ilmari Mäkinen	omas	\N	4q7Hs5Daik
2024-04-26 13:37:10.049	757	\N	\N	Liisa Heikkinen	omas	\N	5dxcLmWVLG
2024-04-26 13:37:10.066	758	\N	\N	Olavi Lehtinen	omas	\N	qImoY9LH59
2024-04-26 13:37:10.084	759	\N	\N	Juhani Määttä	omas	\N	XJ4TF8JH0o
2024-04-26 13:37:10.097	760	\N	\N	Marjatta Heikkinen	pelleseura	\N	7wAv0i4cq3
2024-04-26 13:37:10.111	761	\N	\N	Anna Lehtinen	pelleseura	\N	Ed0HyT5AUp
2024-04-26 13:37:10.123	762	\N	\N	Tapani Lehtinen	pelleseura	\N	ehj2oYtxba
2024-04-26 13:37:10.136	763	\N	\N	Juhani Koskinen	pelleseura	\N	Z87hrlbPAR
2024-04-26 13:37:10.148	764	\N	\N	Maria Mäkelä	pelleseura	\N	q40E1VsZFK
2024-04-26 13:37:10.162	765	\N	\N	Helena Koskinen	pelleseura	\N	apJKzflPvW
2024-04-26 13:37:10.175	766	\N	\N	Juhani Ollakka	pelleseura	\N	jdAsazktDT
2024-04-26 13:37:10.188	767	\N	\N	Tapio Nieminen	pelleseura	\N	QHgQaX7uw7
2024-04-26 13:37:10.202	768	\N	\N	Anna Hämäläinen	pelleseura	\N	tVnOnyQjIo
2024-04-26 13:37:10.215	769	\N	\N	Ilmari Laine	pelleseura	\N	Zq7WwPpOYe
2024-04-26 13:37:10.23	770	\N	\N	Anna Kelanti	yung_tallent	\N	PnA5Idvbwa
2024-04-26 13:37:10.242	771	\N	\N	Olavi Komulainen	yung_tallent	\N	NCfsIgHP5W
2024-04-26 13:37:10.253	772	\N	\N	Kalevi Laine	yung_tallent	\N	HIPhlsWWFa
2024-04-26 13:37:10.265	773	\N	\N	Johannes Komulainen	aseharrastajien_yhtenaisyys	\N	jXTx6j7lNx
2024-04-26 13:37:10.276	774	\N	\N	Tapio Lehtinen	aseharrastajien_yhtenaisyys	\N	V5YJI9k3PA
2024-04-26 13:37:10.29	775	\N	\N	Liisa Järvinen	aseharrastajien_yhtenaisyys	\N	g1KstEpAMc
2024-04-26 13:37:10.303	776	\N	\N	Kalevi Nieminen	aseharrastajien_yhtenaisyys	\N	rmYvRO6pTX
2024-04-26 13:37:10.315	777	\N	\N	Maria Virtanen	aseharrastajien_yhtenaisyys	\N	SLIzqFrzlR
2024-04-26 13:37:10.328	778	\N	\N	Matti Järvinen	aseharrastajien_yhtenaisyys	\N	qttvg0WloP
2024-04-26 13:37:10.339	779	\N	\N	Mikael Kelanti	aseharrastajien_yhtenaisyys	\N	cwmWni0G9O
2024-04-26 13:37:10.353	780	\N	\N	Tapio Mäkinen	aseharrastajien_yhtenaisyys	\N	t3FCWW5A7X
2024-04-26 13:37:10.367	781	\N	\N	Mikael Juustila	aseharrastajien_yhtenaisyys	\N	sbNfDP6pcm
2024-04-26 13:37:10.379	782	\N	\N	Kalevi Kelanti	aseharrastajien_yhtenaisyys	\N	uHMtI8HwDT
2024-04-26 13:37:10.393	783	\N	\N	Kaarina Järvinen	tahtaysmestarit	\N	MTNadhcHQC
2024-04-26 13:37:10.407	784	\N	\N	Kaarina Mäkinen	tahtaysmestarit	\N	5s4U0jvqUy
2024-04-26 13:37:10.422	785	\N	\N	Anna Komulainen	tahtaysmestarit	\N	Q5SotmvrTE
2024-04-26 13:37:10.437	786	\N	\N	Ilmari Korhonen	tahtaysmestarit	\N	ysIPpRZndY
2024-04-26 13:37:10.451	787	\N	\N	Marjatta Juustila	tahtaysmestarit	\N	iJPgdyWP38
2024-04-26 13:37:10.465	788	\N	\N	Anna Holappa	laukausryhma_aurora	\N	gStHMqABP8
2024-04-26 13:37:10.479	789	\N	\N	Liisa Laine	laukausryhma_aurora	\N	xFIV8vReU3
2024-04-26 13:37:10.493	790	\N	\N	Kaarina Hämäläinen	laukausryhma_aurora	\N	Zueqpdt9wG
2024-04-26 13:37:10.505	791	\N	\N	Helena Määttä	laukausryhma_aurora	\N	vGcrO8goCC
2024-04-26 13:37:10.517	792	\N	\N	Matti Kelanti	laukausryhma_aurora	\N	AIiISbKWF0
2024-04-26 13:37:10.53	793	\N	\N	Tapani Mäkinen	laukausryhma_aurora	\N	wVRolzWWm5
2024-04-26 13:37:10.543	794	\N	\N	Johanna Kelanti	laukausryhma_aurora	\N	1eUkUgacpI
2024-04-26 13:37:10.556	795	\N	\N	Tapani Koskinen	laukausryhma_aurora	\N	aOIRcTIgl6
2024-04-26 13:37:10.57	796	\N	\N	Johannes Järvinen	laukausryhma_aurora	\N	jvjNaO3ReM
2024-04-26 13:37:10.582	797	\N	\N	Olavi Määttä	laukausryhma_aurora	\N	ptA8Gx4hBJ
2024-04-26 13:37:10.597	798	\N	\N	Marjatta Määttä	ampumataito	\N	3BC4VrLqtr
2024-04-26 13:37:10.609	799	\N	\N	Helena Järvinen	ampumataito	\N	bfHQnBJUU5
2024-04-26 13:37:10.629	800	\N	\N	Tapani Ollakka	ampumataito	\N	APbTBq2Pnk
2024-04-26 13:37:10.647	801	\N	\N	Ilmari Nieminen	ampumataito	\N	ECBY2EZvnS
2024-04-26 13:37:10.667	802	\N	\N	Tapani Mäkinen	poliisiseura	\N	T2wmwgJjXF
2024-04-26 13:37:10.681	803	\N	\N	Juhani Koskinen	poliisiseura	\N	0i4VQEN6Ko
2024-04-26 13:37:10.695	804	\N	\N	Ilmari Korhonen	poliisiseura	\N	iNcIu10wZy
2024-04-26 13:37:10.708	805	\N	\N	Helena Määttä	poliisiseura	\N	tLLsEHjBVN
2024-04-26 13:37:10.721	806	\N	\N	Matti Komulainen	koiraseura	\N	r4vUu1c4qV
2024-04-26 13:37:10.733	807	\N	\N	Olavi Juustila	koiraseura	\N	pJFJwJ54P6
2024-04-26 13:37:10.746	808	\N	\N	Kalevi Kumpulainen	koiraseura	\N	vXc10hrgLW
2024-04-26 13:37:10.757	809	\N	\N	Johannes Holappa	koiraseura	\N	KWpfPZVMAs
2024-04-26 13:37:10.768	810	\N	\N	Kaarina Nieminen	koiraseura	\N	6OjdfupAHD
2024-04-26 13:37:10.783	811	\N	\N	Ilmari Kumpulainen	koiraseura	\N	zfiwCUNJzA
2024-04-26 13:37:10.796	812	\N	\N	Tapani Holappa	koiraseura	\N	HREoueiz2b
2024-04-26 13:37:10.807	813	\N	\N	Johanna Mäkelä	koiraseura	\N	w0puAiQ9eQ
2024-04-26 13:37:10.818	814	\N	\N	Juhani Hämäläinen	koiraseura	\N	T4pkxRrLqK
2024-04-26 13:37:10.831	815	\N	\N	Tapio Kumpulainen	koiraseura	\N	Hn6lLxVPSM
2024-04-26 13:37:10.846	816	\N	\N	Johanna Laine	koiraseura	\N	5mB6mbDBJU
2024-04-26 13:37:10.857	817	\N	\N	Olavi Mäkelä	koiraseura	\N	b2V3ZveIVL
2024-04-26 13:37:10.869	818	\N	\N	Mikael Mäkinen	hammaspeikkoseura	\N	a19oojBKEM
2024-04-26 13:37:10.881	819	\N	\N	Olavi Heikkinen	hammaspeikkoseura	\N	hM2X3x2xKI
2024-04-26 13:37:10.897	820	\N	\N	Helena Laine	hammaspeikkoseura	\N	62VLEUtC1M
2024-04-26 13:37:10.911	821	\N	\N	Mikael Kelanti	hammaspeikkoseura	\N	SxFhsgPavX
2024-04-26 13:37:10.924	822	\N	\N	Anneli Laine	hammaspeikkoseura	\N	h2aJItR7Ao
2024-04-26 13:37:10.936	823	\N	\N	Johanna Komulainen	hammaspeikkoseura	\N	OnRcXjpZV7
2024-04-26 13:37:10.949	824	\N	\N	Johanna Nieminen	dog	\N	HIBa6Hqecr
2024-04-26 13:37:10.964	825	\N	\N	Tapani Koskinen	dog	\N	6h1EcpSruR
2024-04-26 13:37:10.979	826	\N	\N	Anneli Kumpulainen	dog	\N	SyW1FN3VT5
2024-04-26 13:37:10.993	827	\N	\N	Juhani Mäkelä	dog	\N	8T6XLYRSqZ
2024-04-26 13:37:11.009	828	\N	\N	Mikael Koskinen	dog	\N	FUCC8B9EBP
2024-04-26 13:37:11.026	829	\N	\N	Anneli Nieminen	dog	\N	lcmLyeSLYv
2024-04-26 13:37:11.041	830	\N	\N	Maria Kelanti	dog	\N	2Gz5CiPPyk
2024-04-26 13:37:11.056	831	\N	\N	Kaarina Hämäläinen	dog	\N	szShpcuHfa
2024-04-26 13:37:11.07	832	\N	\N	Juhani Korhonen	dog	\N	08XmR0dz05
2024-04-26 13:37:11.086	833	\N	\N	Olavi Hämäläinen	dog	\N	73ggNErvzO
2024-04-26 13:37:11.102	834	\N	\N	Antero Kumpulainen	dog	\N	rq5tGL0zJ1
2024-04-26 13:37:11.117	835	\N	\N	Johanna Määttä	dog	\N	g6nQ0jF3yo
2024-04-26 13:37:11.132	836	\N	\N	Helena Nieminen	dog	\N	yBkIK2c4ZD
2024-04-26 13:37:11.149	837	\N	\N	Ilmari Järvinen	savu_seura	\N	fgsKS10jmN
2024-04-26 13:37:11.164	838	\N	\N	Liisa Virtanen	savu_seura	\N	amshU0UJJ9
2024-04-26 13:37:11.181	839	\N	\N	Antero Holappa	savu_seura	\N	XruZgQ0auC
2024-04-26 13:37:11.199	840	\N	\N	Tapani Koskinen	savu_seura	\N	oeFtnAMJPA
2024-04-26 13:37:11.217	841	\N	\N	Matti Lehtinen	omas	\N	1ax2OIRAmm
2024-04-26 13:37:11.233	842	\N	\N	Kaarina Järvinen	omas	\N	QcUq1P7kkl
2024-04-26 13:37:11.248	843	\N	\N	Matti Juustila	omas	\N	eIaumRHqXX
2024-04-26 13:37:11.265	844	\N	\N	Liisa Ollakka	omas	\N	czwAnIZmYT
2024-04-26 13:37:11.28	845	\N	\N	Anneli Komulainen	omas	\N	Lx3oN0QPAF
2024-04-26 13:37:11.293	846	\N	\N	Ilmari Ollakka	omas	\N	ZuiZUYjlDx
2024-04-26 13:37:11.307	847	\N	\N	Kaarina Hämäläinen	omas	\N	nMR82TcgdN
2024-04-26 13:37:11.319	848	\N	\N	Kalevi Mäkelä	omas	\N	7xlRD32WWl
2024-04-26 13:37:11.334	849	\N	\N	Tapani Nieminen	omas	\N	6f0tUKBZdq
2024-04-26 13:37:11.349	850	\N	\N	Marjatta Lehtinen	omas	\N	2VhBQQnbmk
2024-04-26 13:37:11.361	851	\N	\N	Kaarina Komulainen	omas	\N	isH70BssXt
2024-04-26 13:37:11.374	852	\N	\N	Helena Korhonen	omas	\N	LWgEM7Woy8
2024-04-26 13:37:11.387	853	\N	\N	Johanna Järvinen	omas	\N	Km5i7WqjVk
2024-04-26 13:37:11.401	854	\N	\N	Anneli Ollakka	pelleseura	\N	s6mYnSQJBY
2024-04-26 13:37:11.415	855	\N	\N	Kalevi Kumpulainen	pelleseura	\N	TAt7Hg6PSS
2024-04-26 13:37:11.429	856	\N	\N	Johanna Kumpulainen	pelleseura	\N	zJVTIBtpOk
2024-04-26 13:37:11.442	857	\N	\N	Kaarina Ollakka	pelleseura	\N	feoZ9l2ACc
2024-04-26 13:37:11.455	858	\N	\N	Matti Lehtinen	pelleseura	\N	bq4L61AEF2
2024-04-26 13:37:11.47	859	\N	\N	Ilmari Juustila	pelleseura	\N	Uecrg3mm6P
2024-04-26 13:37:11.484	860	\N	\N	Johannes Hämäläinen	pelleseura	\N	vtsx66Pyge
2024-04-26 13:37:11.496	861	\N	\N	Mikael Holappa	pelleseura	\N	iPCP0FHsvw
2024-04-26 13:37:11.51	862	\N	\N	Kalevi Komulainen	yung_tallent	\N	lo7bRWbPAV
2024-04-26 13:37:11.527	863	\N	\N	Ilmari Mäkelä	yung_tallent	\N	muopQwOsnY
2024-04-26 13:37:11.54	864	\N	\N	Kalevi Määttä	yung_tallent	\N	U4goQJqJf5
2024-04-26 13:37:11.553	865	\N	\N	Anneli Hämäläinen	yung_tallent	\N	sYu0746b3z
2024-04-26 13:37:11.566	866	\N	\N	Kalevi Virtanen	aseharrastajien_yhtenaisyys	\N	JB2ieydgWH
2024-04-26 13:37:11.58	867	\N	\N	Anneli Ollakka	aseharrastajien_yhtenaisyys	\N	fZ1FluIiCU
2024-04-26 13:37:11.593	868	\N	\N	Maria Mäkelä	aseharrastajien_yhtenaisyys	\N	OojoJJubIO
2024-04-26 13:37:11.606	869	\N	\N	Juhani Ollakka	aseharrastajien_yhtenaisyys	\N	HvEdUbSQJa
2024-04-26 13:37:11.619	870	\N	\N	Antero Mäkinen	tahtaysmestarit	\N	MUon6m8qMP
2024-04-26 13:37:11.633	871	\N	\N	Antero Järvinen	tahtaysmestarit	\N	5jXrLHbirP
2024-04-26 13:37:11.647	872	\N	\N	Antero Korhonen	tahtaysmestarit	\N	iwE3lauDuZ
2024-04-26 13:37:11.661	873	\N	\N	Tapani Järvinen	tahtaysmestarit	\N	TXZtBHHdDB
2024-04-26 13:37:11.675	874	\N	\N	Antero Komulainen	tahtaysmestarit	\N	1kUzyLbiu1
2024-04-26 13:37:11.688	875	\N	\N	Tapio Holappa	tahtaysmestarit	\N	TLeQCtKRyS
2024-04-26 13:37:11.705	876	\N	\N	Kalevi Heikkinen	tahtaysmestarit	\N	rNrPQt1Z0f
2024-04-26 13:37:11.719	877	\N	\N	Anneli Heikkinen	tahtaysmestarit	\N	fdW720IC7w
2024-04-26 13:37:11.732	878	\N	\N	Kaarina Komulainen	tahtaysmestarit	\N	g1YkDfiukL
2024-04-26 13:37:11.745	879	\N	\N	Kalevi Koskinen	tahtaysmestarit	\N	XHbCJfq0Jc
2024-04-26 13:37:11.759	880	\N	\N	Kalevi Holappa	tahtaysmestarit	\N	7uwdqYXcHm
2024-04-26 13:37:11.773	881	\N	\N	Helena Laine	tahtaysmestarit	\N	f9vNY5M9aN
2024-04-26 13:37:11.787	882	\N	\N	Helena Virtanen	tahtaysmestarit	\N	gmK7Nfa0QH
2024-04-26 13:37:11.8	883	\N	\N	Marjatta Holappa	tahtaysmestarit	\N	hE39zdDKhQ
2024-04-26 13:37:11.814	884	\N	\N	Mikael Holappa	laukausryhma_aurora	\N	hC1u97odHJ
2024-04-26 13:37:11.83	885	\N	\N	Anna Mäkelä	laukausryhma_aurora	\N	MJpjG63bRh
2024-04-26 13:37:11.845	886	\N	\N	Marjatta Komulainen	laukausryhma_aurora	\N	EFJpVRvCuh
2024-04-26 13:37:11.857	887	\N	\N	Antero Määttä	ampumataito	\N	izRwVjPDEP
2024-04-26 13:37:11.871	888	\N	\N	Kaarina Kelanti	ampumataito	\N	ZSSmzvhQd2
2024-04-26 13:37:11.884	889	\N	\N	Anna Juustila	ampumataito	\N	HhPirbmLOi
2024-04-26 13:37:11.897	890	\N	\N	Ilmari Koskinen	ampumataito	\N	H5CJSGY5g3
2024-04-26 13:37:11.909	891	\N	\N	Liisa Holappa	ampumataito	\N	tx8tmiAwy5
2024-04-26 13:37:11.924	892	\N	\N	Kaarina Kumpulainen	ampumataito	\N	FitvDLphID
2024-04-26 13:37:11.938	893	\N	\N	Tapio Holappa	ampumataito	\N	T2Ijbyz1e6
2024-04-26 13:37:11.952	894	\N	\N	Helena Korhonen	ampumataito	\N	WhHimpOcXy
2024-04-26 13:37:11.965	895	\N	\N	Johanna Komulainen	poliisiseura	\N	20Ldrx5xDe
2024-04-26 13:37:11.979	896	\N	\N	Juhani Määttä	poliisiseura	\N	PylqccpiW4
2024-04-26 13:37:11.993	897	\N	\N	Kaarina Mäkinen	poliisiseura	\N	Iko8caXlJI
2024-04-26 13:37:12.008	898	\N	\N	Kaarina Juustila	poliisiseura	\N	frba2Jfqrs
2024-04-26 13:37:12.022	899	\N	\N	Anneli Komulainen	poliisiseura	\N	BGgNXS0Z29
2024-04-26 13:37:12.035	900	\N	\N	Marjatta Mäkelä	poliisiseura	\N	BhoDA7DhAF
2024-04-26 13:37:12.047	901	\N	\N	Liisa Juustila	poliisiseura	\N	qeGqhvccJu
2024-04-26 13:37:12.059	902	\N	\N	Johannes Nieminen	poliisiseura	\N	iZJB3yO89g
2024-04-26 13:37:12.074	903	\N	\N	Kalevi Hämäläinen	koiraseura	\N	ENQ3t87YAz
2024-04-26 13:37:12.086	904	\N	\N	Juhani Nieminen	koiraseura	\N	Ou6Fzu3dwk
2024-04-26 13:37:12.099	905	\N	\N	Anneli Juustila	koiraseura	\N	6mHq8MDlJ8
2024-04-26 13:37:12.113	906	\N	\N	Juhani Holappa	koiraseura	\N	B2CEg1aT4m
2024-04-26 13:37:12.127	907	\N	\N	Anna Järvinen	koiraseura	\N	yfez0FUnrr
2024-04-26 13:37:12.14	908	\N	\N	Anna Koskinen	koiraseura	\N	z1490W6EFI
2024-04-26 13:37:12.152	909	\N	\N	Johannes Koskinen	koiraseura	\N	5WxEEdGJH7
2024-04-26 13:37:12.166	910	\N	\N	Maria Koskinen	koiraseura	\N	fLymOkZ3c7
2024-04-26 13:37:12.178	911	\N	\N	Helena Koskinen	koiraseura	\N	2rjrynoTmT
2024-04-26 13:37:12.192	912	\N	\N	Marjatta Ollakka	koiraseura	\N	bNs0ewBXlE
2024-04-26 13:37:12.204	913	\N	\N	Ilmari Hämäläinen	koiraseura	\N	CDyatbLRYo
2024-04-26 13:37:12.216	914	\N	\N	Johannes Ollakka	hammaspeikkoseura	\N	DoRrLLNdBo
2024-04-26 13:37:12.228	915	\N	\N	Antero Kelanti	hammaspeikkoseura	\N	yeHpl62cq2
2024-04-26 13:37:12.239	916	\N	\N	Kalevi Lehtinen	hammaspeikkoseura	\N	6UO5Q6ZvBp
2024-04-26 13:37:12.253	917	\N	\N	Johanna Heikkinen	hammaspeikkoseura	\N	RtJx3VlerU
2024-04-26 13:37:12.266	918	\N	\N	Johanna Hämäläinen	hammaspeikkoseura	\N	a42m9fFEKA
2024-04-26 13:37:12.279	919	\N	\N	Liisa Ollakka	dog	\N	R9SzzGVNG5
2024-04-26 13:37:12.293	920	\N	\N	Tapani Koskinen	dog	\N	H4sZKjwOT8
2024-04-26 13:37:12.308	921	\N	\N	Juhani Laine	dog	\N	zG3GwvsURr
2024-04-26 13:37:12.321	922	\N	\N	Helena Laine	dog	\N	oGhhjRRuQv
2024-04-26 13:37:12.335	923	\N	\N	Maria Kelanti	dog	\N	UcbQYLwHQr
2024-04-26 13:37:12.347	924	\N	\N	Tapio Järvinen	dog	\N	yUeVYwtz4n
2024-04-26 13:37:12.361	925	\N	\N	Helena Korhonen	dog	\N	2YZHDBDaxY
2024-04-26 13:37:12.376	926	\N	\N	Liisa Korhonen	dog	\N	An7Shvq90F
2024-04-26 13:37:12.388	927	\N	\N	Kaarina Laine	dog	\N	0REkCydyrC
2024-04-26 13:37:12.402	928	\N	\N	Juhani Kumpulainen	savu_seura	\N	RpQiGztjLU
2024-04-26 13:37:12.414	929	\N	\N	Antero Nieminen	savu_seura	\N	Zdp6ma77jU
2024-04-26 13:37:12.426	930	\N	\N	Matti Mäkinen	savu_seura	\N	kBzW7f1ob6
2024-04-26 13:37:12.441	931	\N	\N	Antero Holappa	savu_seura	\N	kRBcxBmtKN
2024-04-26 13:37:12.46	932	\N	\N	Marjatta Komulainen	savu_seura	\N	XjiLh9JqT1
2024-04-26 13:37:12.478	933	\N	\N	Matti Koskinen	savu_seura	\N	fnPk8D6aov
2024-04-26 13:37:12.508	934	\N	\N	Matti Hämäläinen	savu_seura	\N	MMe9KO9LOC
2024-04-26 13:37:12.526	935	\N	\N	Kalevi Lehtinen	savu_seura	\N	2bAJl6EdNG
2024-04-26 13:37:12.539	936	\N	\N	Anna Laine	omas	\N	qyyg393bKq
2024-04-26 13:37:12.552	937	\N	\N	Johannes Nieminen	omas	\N	wZheiYNbWk
2024-04-26 13:37:12.565	938	\N	\N	Tapani Mäkinen	omas	\N	hLI8ELhp5z
2024-04-26 13:37:12.578	939	\N	\N	Anneli Holappa	omas	\N	5WJSP3UAC2
2024-04-26 13:37:12.592	940	\N	\N	Ilmari Hämäläinen	omas	\N	RZFacqoPyt
2024-04-26 13:37:12.606	941	\N	\N	Ilmari Koskinen	omas	\N	Vd2ykL9brD
2024-04-26 13:37:12.618	942	\N	\N	Antero Laine	omas	\N	WKu0NKeEfU
2024-04-26 13:37:12.631	943	\N	\N	Helena Juustila	omas	\N	XLDjqCzWPB
2024-04-26 13:37:12.644	944	\N	\N	Maria Heikkinen	omas	\N	FRvrmHskkU
2024-04-26 13:37:12.658	945	\N	\N	Antero Virtanen	pelleseura	\N	DPjbnmqxNA
2024-04-26 13:37:12.671	946	\N	\N	Helena Komulainen	pelleseura	\N	Er0M0rKJ0C
2024-04-26 13:37:12.684	947	\N	\N	Tapio Järvinen	pelleseura	\N	ebPWDjMBN5
2024-04-26 13:37:12.695	948	\N	\N	Marjatta Holappa	pelleseura	\N	FaVQIvvmmV
2024-04-26 13:37:12.706	949	\N	\N	Helena Mäkelä	pelleseura	\N	E7939eTPYt
2024-04-26 13:37:12.718	950	\N	\N	Mikael Korhonen	pelleseura	\N	9EWPmMFtTe
2024-04-26 13:37:12.732	951	\N	\N	Johanna Kelanti	pelleseura	\N	MLbWaOCitg
2024-04-26 13:37:12.744	952	\N	\N	Tapani Juustila	pelleseura	\N	UDaunDFlnJ
2024-04-26 13:37:12.756	953	\N	\N	Kalevi Holappa	yung_tallent	\N	G2HhyIL4fk
2024-04-26 13:37:12.768	954	\N	\N	Anneli Virtanen	yung_tallent	\N	CkUjtAhXtR
2024-04-26 13:37:12.78	955	\N	\N	Johannes Virtanen	yung_tallent	\N	jkiscQNcK6
2024-04-26 13:37:12.794	956	\N	\N	Marjatta Holappa	aseharrastajien_yhtenaisyys	\N	Ov5CeiQBf2
2024-04-26 13:37:12.806	957	\N	\N	Matti Mäkelä	aseharrastajien_yhtenaisyys	\N	Ubo0GIQhA5
2024-04-26 13:37:12.818	958	\N	\N	Anna Mäkelä	aseharrastajien_yhtenaisyys	\N	hgKfBLVf9N
2024-04-26 13:37:12.829	959	\N	\N	Juhani Lehtinen	aseharrastajien_yhtenaisyys	\N	P5OvycBHp5
2024-04-26 13:37:12.842	960	\N	\N	Maria Kelanti	aseharrastajien_yhtenaisyys	\N	2zitBBjzmv
2024-04-26 13:37:12.855	961	\N	\N	Kalevi Virtanen	aseharrastajien_yhtenaisyys	\N	iMPWxOLXn6
2024-04-26 13:37:12.867	962	\N	\N	Helena Komulainen	aseharrastajien_yhtenaisyys	\N	vRK2ZPZmkG
2024-04-26 13:37:12.878	963	\N	\N	Tapani Kumpulainen	aseharrastajien_yhtenaisyys	\N	IRzAZOAxW0
2024-04-26 13:37:12.891	964	\N	\N	Mikael Komulainen	aseharrastajien_yhtenaisyys	\N	wQ1r23Ne7k
2024-04-26 13:37:12.905	965	\N	\N	Ilmari Komulainen	aseharrastajien_yhtenaisyys	\N	d99iCPAkv9
2024-04-26 13:37:12.918	966	\N	\N	Helena Komulainen	aseharrastajien_yhtenaisyys	\N	OOXpDv0CeV
2024-04-26 13:37:12.93	967	\N	\N	Olavi Virtanen	aseharrastajien_yhtenaisyys	\N	OcUuqWBsCS
2024-04-26 13:37:12.942	968	\N	\N	Juhani Hämäläinen	aseharrastajien_yhtenaisyys	\N	PiujE5ys26
2024-04-26 13:37:12.955	969	\N	\N	Juhani Lehtinen	tahtaysmestarit	\N	QrWB2iZBbw
2024-04-26 13:37:12.968	970	\N	\N	Kalevi Koskinen	tahtaysmestarit	\N	ckXScMPzgt
2024-04-26 13:37:12.981	971	\N	\N	Anneli Määttä	tahtaysmestarit	\N	LzGotYsiL1
2024-04-26 13:37:12.993	972	\N	\N	Anna Ollakka	tahtaysmestarit	\N	CK5fgPcakA
2024-04-26 13:37:13.005	973	\N	\N	Mikael Mäkinen	tahtaysmestarit	\N	5MzLGj4A3A
2024-04-26 13:37:13.017	974	\N	\N	Kaarina Heikkinen	tahtaysmestarit	\N	noz8DMO7Xw
2024-04-26 13:37:13.03	975	\N	\N	Tapani Järvinen	tahtaysmestarit	\N	4nVDZU2vSU
2024-04-26 13:37:13.042	976	\N	\N	Johannes Määttä	tahtaysmestarit	\N	93vZxYhCwm
2024-04-26 13:37:13.055	977	\N	\N	Juhani Komulainen	tahtaysmestarit	\N	dX4e7BabIV
2024-04-26 13:37:13.067	978	\N	\N	Maria Korhonen	tahtaysmestarit	\N	65loOK8dqf
2024-04-26 13:37:13.08	979	\N	\N	Matti Komulainen	tahtaysmestarit	\N	8pU3gvW4Nu
2024-04-26 13:37:13.093	980	\N	\N	Johanna Mäkinen	tahtaysmestarit	\N	mZxOFvmYo9
2024-04-26 13:37:13.105	981	\N	\N	Juhani Koskinen	laukausryhma_aurora	\N	E8Dbs3Y20t
2024-04-26 13:37:13.117	982	\N	\N	Matti Laine	laukausryhma_aurora	\N	oRAUcWFzPj
2024-04-26 13:37:13.13	983	\N	\N	Johannes Kumpulainen	laukausryhma_aurora	\N	3B778eDnBS
2024-04-26 13:37:13.141	984	\N	\N	Kaarina Hämäläinen	laukausryhma_aurora	\N	b2HrGPXJeY
2024-04-26 13:37:13.154	985	\N	\N	Kaarina Hämäläinen	laukausryhma_aurora	\N	gKN61qjJXe
2024-04-26 13:37:13.167	986	\N	\N	Mikael Korhonen	laukausryhma_aurora	\N	niYSoD89Y5
2024-04-26 13:37:13.178	987	\N	\N	Marjatta Mäkinen	laukausryhma_aurora	\N	xfinLm4N8b
2024-04-26 13:37:13.19	988	\N	\N	Maria Heikkinen	laukausryhma_aurora	\N	8PyUXCpY1d
2024-04-26 13:37:13.202	989	\N	\N	Johannes Heikkinen	ampumataito	\N	Jz6f1K7Fe2
2024-04-26 13:37:13.215	990	\N	\N	Anneli Määttä	ampumataito	\N	6cf8Rvj2iG
2024-04-26 13:37:13.227	991	\N	\N	Matti Juustila	ampumataito	\N	VNSACywLXC
2024-04-26 13:37:13.238	992	\N	\N	Olavi Juustila	poliisiseura	\N	RJC5ZD8YrR
2024-04-26 13:37:13.25	993	\N	\N	Maria Holappa	poliisiseura	\N	tj7gNyVrQh
2024-04-26 13:37:13.262	994	\N	\N	Olavi Järvinen	poliisiseura	\N	dgi5HvkSIt
2024-04-26 13:37:13.273	995	\N	\N	Ilmari Holappa	poliisiseura	\N	0NznLNLOcH
2024-04-26 13:37:13.287	996	\N	\N	Antero Laine	poliisiseura	\N	UDjRgmyDvr
2024-04-26 13:37:13.298	997	\N	\N	Anna Komulainen	poliisiseura	\N	LpuxypN8Mn
2024-04-26 13:37:13.311	998	\N	\N	Kalevi Nieminen	poliisiseura	\N	hQ9utuH7vi
2024-04-26 13:37:13.323	999	\N	\N	Maria Mäkelä	poliisiseura	\N	yS7spC5t4y
2024-04-26 13:37:13.335	1000	\N	\N	Maria Laine	poliisiseura	\N	w7p4Eda5oL
2024-04-26 13:37:13.348	1001	\N	\N	Tapio Lehtinen	koiraseura	\N	D5vnUyBkcY
2024-04-26 13:37:13.36	1002	\N	\N	Matti Kumpulainen	koiraseura	\N	rpR1szHJaU
2024-04-26 13:37:13.374	1003	\N	\N	Marjatta Hämäläinen	koiraseura	\N	14NtChstvV
2024-04-26 13:37:13.384	1004	\N	\N	Helena Lehtinen	koiraseura	\N	BDRaKAVrXg
2024-04-26 13:37:13.397	1005	\N	\N	Anneli Korhonen	koiraseura	\N	B2Prql38ew
2024-04-26 13:37:13.411	1006	\N	\N	Kalevi Laine	koiraseura	\N	ZTVsk5CpLS
2024-04-26 13:37:13.422	1007	\N	\N	Tapio Kumpulainen	koiraseura	\N	iWOZcjpSCk
2024-04-26 13:37:13.435	1008	\N	\N	Tapio Kelanti	koiraseura	\N	MWctvaTcvF
2024-04-26 13:37:13.445	1009	\N	\N	Tapani Hämäläinen	hammaspeikkoseura	\N	QbiKzfJcdV
2024-04-26 13:37:13.459	1010	\N	\N	Antero Määttä	hammaspeikkoseura	\N	QByjOpQ285
2024-04-26 13:37:13.472	1011	\N	\N	Anna Laine	hammaspeikkoseura	\N	58nebMFJhD
2024-04-26 13:37:13.483	1012	\N	\N	Helena Koskinen	hammaspeikkoseura	\N	6yglqNHTA6
2024-04-26 13:37:13.496	1013	\N	\N	Tapio Holappa	hammaspeikkoseura	\N	csMmMmgCr4
2024-04-26 13:37:13.508	1014	\N	\N	Liisa Kumpulainen	hammaspeikkoseura	\N	nuRS4EyWW1
2024-04-26 13:37:13.52	1015	\N	\N	Maria Korhonen	hammaspeikkoseura	\N	GwQbLQzHe1
2024-04-26 13:37:13.534	1016	\N	\N	Matti Nieminen	hammaspeikkoseura	\N	5UTaun4qB7
2024-04-26 13:37:13.546	1017	\N	\N	Mikael Komulainen	hammaspeikkoseura	\N	iUhTQhXqeJ
2024-04-26 13:37:13.557	1018	\N	\N	Matti Ollakka	dog	\N	e2vDlA7ES7
2024-04-26 13:37:13.568	1019	\N	\N	Johanna Juustila	dog	\N	gYOwDZFCDL
2024-04-26 13:37:13.581	1020	\N	\N	Maria Korhonen	dog	\N	jZQTLjQNEG
2024-04-26 13:37:13.595	1021	\N	\N	Tapio Holappa	dog	\N	RstHLwvam3
2024-04-26 13:37:13.606	1022	\N	\N	Johanna Ollakka	dog	\N	6hD2JQPbVJ
2024-04-26 13:37:13.619	1023	\N	\N	Johanna Kelanti	dog	\N	jYffLJ67nx
2024-04-26 13:37:13.63	1024	\N	\N	Marjatta Holappa	dog	\N	znoEMmzyBk
2024-04-26 13:37:13.644	1025	\N	\N	Johanna Järvinen	dog	\N	ob1aRMUlJR
2024-04-26 13:37:13.656	1026	\N	\N	Liisa Koskinen	dog	\N	tubb7asfxN
2024-04-26 13:37:13.668	1027	\N	\N	Johannes Määttä	dog	\N	etBev68AF3
2024-04-26 13:37:13.679	1028	\N	\N	Maria Korhonen	dog	\N	C1d5GRiCM1
2024-04-26 13:37:13.691	1029	\N	\N	Juhani Hämäläinen	dog	\N	9q0lLwcttw
2024-04-26 13:37:13.703	1030	\N	\N	Tapio Nieminen	dog	\N	IoxwHhpHOj
2024-04-26 13:37:13.716	1031	\N	\N	Liisa Mäkelä	savu_seura	\N	bCPZqNpHWF
2024-04-26 13:37:13.728	1032	\N	\N	Liisa Juustila	savu_seura	\N	sGoPxqfYte
2024-04-26 13:37:13.748	1033	\N	\N	Maria Laine	savu_seura	\N	aTqBHTLQ0R
2024-04-26 13:37:13.761	1034	\N	\N	Helena Järvinen	savu_seura	\N	xQ04TAfZpt
2024-04-26 13:37:13.774	1035	\N	\N	Helena Heikkinen	savu_seura	\N	7cx30wIXID
2024-04-26 13:37:13.787	1036	\N	\N	Matti Holappa	savu_seura	\N	ZBFVdCaBD0
2024-04-26 13:37:13.798	1037	\N	\N	Mikael Korhonen	savu_seura	\N	Xy1cKXMNTI
2024-04-26 13:37:13.809	1038	\N	\N	Johanna Nieminen	savu_seura	\N	hpfj1Ut2VK
2024-04-26 13:37:13.82	1039	\N	\N	Olavi Komulainen	savu_seura	\N	0XOkMKLU1J
2024-04-26 13:37:13.835	1040	\N	\N	Kalevi Laine	omas	\N	XExvrRx34L
2024-04-26 13:37:13.847	1041	\N	\N	Kalevi Juustila	omas	\N	hykYd1Sdi2
2024-04-26 13:37:13.858	1042	\N	\N	Tapio Ollakka	omas	\N	q7ixscMuh8
2024-04-26 13:37:13.87	1043	\N	\N	Kalevi Komulainen	omas	\N	EJQkPaBCx8
2024-04-26 13:37:13.882	1044	\N	\N	Mikael Heikkinen	omas	\N	8xs8FvEmAs
2024-04-26 13:37:13.897	1045	\N	\N	Anna Laine	pelleseura	\N	dFdkWraK51
2024-04-26 13:37:13.909	1046	\N	\N	Liisa Ollakka	pelleseura	\N	NQpES4qzZA
2024-04-26 13:37:13.92	1047	\N	\N	Tapani Laine	pelleseura	\N	n2u0sHI2oE
2024-04-26 13:37:13.932	1048	\N	\N	Helena Virtanen	pelleseura	\N	FgWVMEHocN
2024-04-26 13:37:13.945	1049	\N	\N	Antero Heikkinen	pelleseura	\N	p1HiMyxkyP
2024-04-26 13:37:13.959	1050	\N	\N	Liisa Komulainen	pelleseura	\N	Rgk8ojzNcS
2024-04-26 13:37:13.971	1051	\N	\N	Marjatta Juustila	pelleseura	\N	NFyXnIiT2J
2024-04-26 13:37:13.984	1052	\N	\N	Anneli Mäkinen	pelleseura	\N	6VQlDzEEQE
2024-04-26 13:37:13.995	1053	\N	\N	Tapani Heikkinen	pelleseura	\N	J2ALdoor3j
2024-04-26 13:37:14.009	1054	\N	\N	Marjatta Komulainen	pelleseura	\N	MpLpdN9Z3b
2024-04-26 13:37:14.023	1055	\N	\N	Johannes Holappa	pelleseura	\N	CY8oNzGBoX
2024-04-26 13:37:14.037	1056	\N	\N	Kalevi Holappa	pelleseura	\N	90a7sOAWsm
2024-04-26 13:37:14.049	1057	\N	\N	Kaarina Virtanen	pelleseura	\N	yI35WJpBL5
2024-04-26 13:37:14.061	1058	\N	\N	Anna Koskinen	pelleseura	\N	hGcK74U9Iy
2024-04-26 13:37:14.073	1059	\N	\N	Anna Laine	pelleseura	\N	BxVHegeM20
2024-04-26 13:37:14.086	1060	\N	\N	Antero Hämäläinen	yung_tallent	\N	UVGromHnZz
2024-04-26 13:37:14.097	1061	\N	\N	Olavi Lehtinen	yung_tallent	\N	XR3ppHwaqr
2024-04-26 13:37:14.109	1062	\N	\N	Johannes Järvinen	yung_tallent	\N	qBjfSjJJFc
2024-04-26 13:37:14.12	1063	\N	\N	Kalevi Virtanen	aseharrastajien_yhtenaisyys	\N	CHWDYiLH5z
2024-04-26 13:37:14.132	1064	\N	\N	Tapio Kumpulainen	aseharrastajien_yhtenaisyys	\N	QhVFqy6ct7
2024-04-26 13:37:14.145	1065	\N	\N	Juhani Holappa	aseharrastajien_yhtenaisyys	\N	KPYIADZO2B
2024-04-26 13:37:14.155	1066	\N	\N	Kalevi Virtanen	aseharrastajien_yhtenaisyys	\N	vlLirL2vaz
2024-04-26 13:37:14.167	1067	\N	\N	Liisa Määttä	aseharrastajien_yhtenaisyys	\N	xrIGWsF2xK
2024-04-26 13:37:14.178	1068	\N	\N	Kaarina Juustila	aseharrastajien_yhtenaisyys	\N	emNfZXCztS
2024-04-26 13:37:14.189	1069	\N	\N	Olavi Kelanti	aseharrastajien_yhtenaisyys	\N	jDLnpCkzkT
2024-04-26 13:37:14.203	1070	\N	\N	Helena Järvinen	tahtaysmestarit	\N	VpEhtMNaBR
2024-04-26 13:37:14.215	1071	\N	\N	Maria Nieminen	tahtaysmestarit	\N	qqyKamQEps
2024-04-26 13:37:14.227	1072	\N	\N	Antero Ollakka	tahtaysmestarit	\N	UPc47XGqy5
2024-04-26 13:37:14.238	1073	\N	\N	Ilmari Lehtinen	tahtaysmestarit	\N	QnJa2NKkph
2024-04-26 13:37:14.264	1074	\N	\N	Olavi Laine	tahtaysmestarit	\N	fHZNnsUVpi
2024-04-26 13:37:14.279	1075	\N	\N	Tapani Järvinen	tahtaysmestarit	\N	JUgM0zRAwu
2024-04-26 13:37:14.296	1076	\N	\N	Kaarina Korhonen	tahtaysmestarit	\N	JDD1ijyvZI
2024-04-26 13:37:14.31	1077	\N	\N	Helena Mäkinen	tahtaysmestarit	\N	lhCzp5H4pV
2024-04-26 13:37:14.325	1078	\N	\N	Anneli Lehtinen	tahtaysmestarit	\N	NCp2u4Wbqq
2024-04-26 13:37:14.337	1079	\N	\N	Liisa Laine	tahtaysmestarit	\N	Xx1T0ISbCd
2024-04-26 13:37:14.349	1080	\N	\N	Johannes Ollakka	tahtaysmestarit	\N	4tjNY8ikQp
2024-04-26 13:37:14.361	1081	\N	\N	Marjatta Laine	tahtaysmestarit	\N	YI5UYq0iTN
2024-04-26 13:37:14.373	1082	\N	\N	Liisa Ollakka	laukausryhma_aurora	\N	p9XTDkGUhR
2024-04-26 13:37:14.388	1083	\N	\N	Ilmari Mäkelä	laukausryhma_aurora	\N	ktJYVLqIvK
2024-04-26 13:37:14.4	1084	\N	\N	Anna Lehtinen	laukausryhma_aurora	\N	9n8Y4iNBsj
2024-04-26 13:37:14.412	1085	\N	\N	Olavi Holappa	laukausryhma_aurora	\N	BbkbHZLcRH
2024-04-26 13:37:14.424	1086	\N	\N	Johannes Juustila	laukausryhma_aurora	\N	UEtdCvPdya
2024-04-26 13:37:14.437	1087	\N	\N	Maria Laine	laukausryhma_aurora	\N	MHdE2eTxy8
2024-04-26 13:37:14.452	1088	\N	\N	Tapio Lehtinen	laukausryhma_aurora	\N	pvUi9SXxDi
2024-04-26 13:37:14.466	1089	\N	\N	Anneli Heikkinen	laukausryhma_aurora	\N	Eg1Fd55ieK
2024-04-26 13:37:14.479	1090	\N	\N	Tapio Juustila	laukausryhma_aurora	\N	44WjvAJjBV
2024-04-26 13:37:14.492	1091	\N	\N	Kaarina Laine	laukausryhma_aurora	\N	4Ri2IVChEX
2024-04-26 13:37:14.507	1092	\N	\N	Maria Koskinen	laukausryhma_aurora	\N	8yAZvZrDAK
2024-04-26 13:37:14.519	1093	\N	\N	Johanna Komulainen	laukausryhma_aurora	\N	VZhQWk7lJe
2024-04-26 13:37:14.532	1094	\N	\N	Helena Juustila	laukausryhma_aurora	\N	1n1X97cEho
2024-04-26 13:37:14.544	1095	\N	\N	Anna Mäkelä	ampumataito	\N	0xZd8yKwTz
2024-04-26 13:37:14.556	1096	\N	\N	Ilmari Mäkelä	ampumataito	\N	28MfzLVWex
2024-04-26 13:37:14.572	1097	\N	\N	Olavi Kumpulainen	ampumataito	\N	aEXBr8r9hb
2024-04-26 13:37:14.584	1098	\N	\N	Helena Heikkinen	ampumataito	\N	Jhm3oJOBfg
2024-04-26 13:37:14.596	1099	\N	\N	Tapio Ollakka	ampumataito	\N	6R1vemsjXi
2024-04-26 13:37:14.608	1100	\N	\N	Anneli Ollakka	ampumataito	\N	3UGY6teR9c
2024-04-26 13:37:14.62	1101	\N	\N	Liisa Lehtinen	ampumataito	\N	3n0As0iPog
2024-04-26 13:37:14.633	1102	\N	\N	Ilmari Ollakka	ampumataito	\N	Nl576j1fmI
2024-04-26 13:37:14.645	1103	\N	\N	Tapio Määttä	poliisiseura	\N	gOmmEtG87M
2024-04-26 13:37:14.658	1104	\N	\N	Anna Ollakka	poliisiseura	\N	QzcAlTp8wZ
2024-04-26 13:37:14.67	1105	\N	\N	Maria Lehtinen	poliisiseura	\N	gaTDhKpwTF
2024-04-26 13:37:14.683	1106	\N	\N	Matti Korhonen	poliisiseura	\N	Kyc1QKFRz7
2024-04-26 13:37:14.698	1107	\N	\N	Kalevi Komulainen	poliisiseura	\N	c1oEZLEQls
2024-04-26 13:37:14.713	1108	\N	\N	Johannes Juustila	poliisiseura	\N	JKdqYWEBSm
2024-04-26 13:37:14.725	1109	\N	\N	Anna Nieminen	poliisiseura	\N	85bSVCprrs
2024-04-26 13:37:14.738	1110	\N	\N	Matti Määttä	poliisiseura	\N	r7zviBvHCv
2024-04-26 13:37:14.751	1111	\N	\N	Matti Nieminen	poliisiseura	\N	edVPVVyYp7
2024-04-26 13:37:14.764	1112	\N	\N	Marjatta Kumpulainen	poliisiseura	\N	zVm3ikjWdC
2024-04-26 13:37:14.777	1113	\N	\N	Matti Korhonen	poliisiseura	\N	rhKeGoFBuZ
2024-04-26 13:37:14.789	1114	\N	\N	Tapani Juustila	poliisiseura	\N	M38b5gos3y
2024-04-26 13:37:14.802	1115	\N	\N	Mikael Määttä	koiraseura	\N	YFrZ041LcB
2024-04-26 13:37:14.816	1116	\N	\N	Matti Nieminen	koiraseura	\N	Bj1Bqa2jBN
2024-04-26 13:37:14.828	1117	\N	\N	Anneli Laine	koiraseura	\N	D0nqZ3J7HA
2024-04-26 13:37:14.84	1118	\N	\N	Kaarina Lehtinen	koiraseura	\N	u9pxOEYhGi
2024-04-26 13:37:14.851	1119	\N	\N	Johanna Laine	koiraseura	\N	Y7GxRm49pK
2024-04-26 13:37:14.862	1120	\N	\N	Johanna Ollakka	koiraseura	\N	fNlXILyGhT
2024-04-26 13:37:14.877	1121	\N	\N	Olavi Komulainen	koiraseura	\N	4UHute4Qvh
2024-04-26 13:37:14.891	1122	\N	\N	Helena Mäkinen	koiraseura	\N	HRWkmlVIgy
2024-04-26 13:37:14.901	1123	\N	\N	Tapio Komulainen	koiraseura	\N	qMglOw3mgL
2024-04-26 13:37:14.913	1124	\N	\N	Tapani Heikkinen	koiraseura	\N	2hy0VXiZtp
2024-04-26 13:37:14.925	1125	\N	\N	Kaarina Määttä	hammaspeikkoseura	\N	ORGK5myq0k
2024-04-26 13:37:14.94	1126	\N	\N	Maria Heikkinen	hammaspeikkoseura	\N	Rb2GIa1AOC
2024-04-26 13:37:14.951	1127	\N	\N	Marjatta Koskinen	hammaspeikkoseura	\N	PyaSCIrDWL
2024-04-26 13:37:14.961	1128	\N	\N	Antero Ollakka	hammaspeikkoseura	\N	l8Dunhw3gr
2024-04-26 13:37:14.972	1129	\N	\N	Ilmari Koskinen	hammaspeikkoseura	\N	WOGsloU1Hn
2024-04-26 13:37:14.983	1130	\N	\N	Johannes Kelanti	hammaspeikkoseura	\N	2CC5TQWOnC
2024-04-26 13:37:14.997	1131	\N	\N	Olavi Järvinen	hammaspeikkoseura	\N	ycnR9JeY3h
2024-04-26 13:37:15.009	1132	\N	\N	Helena Nieminen	hammaspeikkoseura	\N	luNmU9XEW2
2024-04-26 13:37:15.021	1133	\N	\N	Helena Laine	hammaspeikkoseura	\N	d7iOYO4NFi
2024-04-26 13:37:15.034	1134	\N	\N	Johannes Korhonen	hammaspeikkoseura	\N	hDSRxKLLY0
2024-04-26 13:37:15.045	1135	\N	\N	Marjatta Määttä	hammaspeikkoseura	\N	9Ic8euhQBM
2024-04-26 13:37:15.06	1136	\N	\N	Maria Koskinen	hammaspeikkoseura	\N	5Q9X5tYsp3
2024-04-26 13:37:15.071	1137	\N	\N	Liisa Mäkelä	hammaspeikkoseura	\N	yrX2ZgXgsI
2024-04-26 13:37:15.082	1138	\N	\N	Ilmari Hämäläinen	dog	\N	yQsyae8uxs
2024-04-26 13:37:15.093	1139	\N	\N	Olavi Komulainen	dog	\N	groKMTqSUq
2024-04-26 13:37:15.105	1140	\N	\N	Tapani Hämäläinen	dog	\N	l2WEJ7NNZA
2024-04-26 13:37:15.117	1141	\N	\N	Matti Lehtinen	dog	\N	HW4WJwfqah
2024-04-26 13:37:15.13	1142	\N	\N	Mikael Määttä	dog	\N	CnkITxJvH2
2024-04-26 13:37:15.141	1143	\N	\N	Kalevi Kumpulainen	dog	\N	QuzhaGCiFJ
2024-04-26 13:37:15.152	1144	\N	\N	Mikael Komulainen	dog	\N	TJrL3uImh4
2024-04-26 13:37:15.162	1145	\N	\N	Matti Korhonen	savu_seura	\N	SLZigmoHbu
2024-04-26 13:37:15.174	1146	\N	\N	Liisa Mäkinen	savu_seura	\N	QwZms3Moct
2024-04-26 13:37:15.187	1147	\N	\N	Johannes Nieminen	savu_seura	\N	yhOvn3PA3B
2024-04-26 13:37:15.199	1148	\N	\N	Kaarina Kelanti	savu_seura	\N	TZJTW1NzQe
2024-04-26 13:37:15.21	1149	\N	\N	Tapio Hämäläinen	savu_seura	\N	qHx7vVi6S7
2024-04-26 13:37:15.222	1150	\N	\N	Ilmari Komulainen	savu_seura	\N	GrvKGHyQnQ
2024-04-26 13:37:15.233	1151	\N	\N	Maria Holappa	savu_seura	\N	boudXUsJhe
2024-04-26 13:37:15.246	1152	\N	\N	Tapani Määttä	savu_seura	\N	FkHQk5dx6i
2024-04-26 13:37:15.258	1153	\N	\N	Maria Kumpulainen	savu_seura	\N	mQLyfHTcPo
2024-04-26 13:37:15.269	1154	\N	\N	Matti Ollakka	savu_seura	\N	brYoye1Z4a
2024-04-26 13:37:15.281	1155	\N	\N	Kaarina Ollakka	savu_seura	\N	7809tbsbRS
2024-04-26 13:37:15.293	1156	\N	\N	Anneli Lehtinen	savu_seura	\N	2N7rDZ1w5h
2024-04-26 13:37:15.307	1157	\N	\N	Kalevi Juustila	omas	\N	HH9d6sYt7T
2024-04-26 13:37:15.319	1158	\N	\N	Marjatta Kelanti	omas	\N	CE8VZiyBrM
2024-04-26 13:37:15.331	1159	\N	\N	Anna Laine	omas	\N	fFJA2alBfP
2024-04-26 13:37:15.342	1160	\N	\N	Kalevi Kumpulainen	pelleseura	\N	LghnjDkDV9
2024-04-26 13:37:15.356	1161	\N	\N	Tapani Järvinen	pelleseura	\N	UcZNDyx782
2024-04-26 13:37:15.368	1162	\N	\N	Liisa Nieminen	pelleseura	\N	q2sj5Y66Ia
2024-04-26 13:37:15.379	1163	\N	\N	Tapani Järvinen	yung_tallent	\N	IwE9o35SrT
2024-04-26 13:37:15.391	1164	\N	\N	Maria Mäkinen	yung_tallent	\N	xu9vfTnYxe
2024-04-26 13:37:15.402	1165	\N	\N	Kaarina Nieminen	yung_tallent	\N	V4yhUEh0TY
2024-04-26 13:37:15.414	1166	\N	\N	Tapani Kumpulainen	yung_tallent	\N	hvlvuOM9Y0
2024-04-26 13:37:15.43	1167	\N	\N	Johanna Hämäläinen	yung_tallent	\N	zO0JBh1Rpb
2024-04-26 13:37:15.444	1168	\N	\N	Marjatta Koskinen	yung_tallent	\N	XWP0cuYUiA
2024-04-26 13:37:15.457	1169	\N	\N	Helena Ollakka	yung_tallent	\N	PLiG2XNhBf
2024-04-26 13:37:15.469	1170	\N	\N	Olavi Mäkinen	yung_tallent	\N	OmlkAcesKc
2024-04-26 13:37:15.482	1171	\N	\N	Ilmari Hämäläinen	yung_tallent	\N	PnGdyQhjVb
2024-04-26 13:37:15.495	1172	\N	\N	Tapio Määttä	yung_tallent	\N	haGXYjDfzq
2024-04-26 13:37:15.512	1173	\N	\N	Juhani Järvinen	yung_tallent	\N	d9pa2hwfIl
2024-04-26 13:37:15.525	1174	\N	\N	Anneli Virtanen	yung_tallent	\N	5eOlK9Rw63
2024-04-26 13:37:15.538	1175	\N	\N	Johanna Nieminen	aseharrastajien_yhtenaisyys	\N	DHCGM6U37M
2024-04-26 13:37:15.552	1176	\N	\N	Johanna Juustila	aseharrastajien_yhtenaisyys	\N	9uyqql3Bna
2024-04-26 13:37:15.564	1177	\N	\N	Antero Virtanen	aseharrastajien_yhtenaisyys	\N	LOYBXhBKJm
2024-04-26 13:37:15.575	1178	\N	\N	Juhani Kumpulainen	aseharrastajien_yhtenaisyys	\N	HGorJFM66M
2024-04-26 13:37:15.587	1179	\N	\N	Helena Määttä	aseharrastajien_yhtenaisyys	\N	Uw3PyaS5tf
2024-04-26 13:37:15.599	1180	\N	\N	Kaarina Komulainen	aseharrastajien_yhtenaisyys	\N	3pkkwTMMWL
2024-04-26 13:37:15.612	1181	\N	\N	Johanna Nieminen	aseharrastajien_yhtenaisyys	\N	TbfZ3K9Zop
2024-04-26 13:37:15.624	1182	\N	\N	Olavi Ollakka	aseharrastajien_yhtenaisyys	\N	3D6oEW9T35
2024-04-26 13:37:15.637	1183	\N	\N	Marjatta Holappa	aseharrastajien_yhtenaisyys	\N	flwFVaxCSN
2024-04-26 13:37:15.649	1184	\N	\N	Marjatta Kelanti	aseharrastajien_yhtenaisyys	\N	wOZQqMl362
2024-04-26 13:37:15.66	1185	\N	\N	Ilmari Lehtinen	aseharrastajien_yhtenaisyys	\N	FsqudCEEZl
2024-04-26 13:37:15.675	1186	\N	\N	Olavi Korhonen	tahtaysmestarit	\N	c7GHz6uENQ
2024-04-26 13:37:15.687	1187	\N	\N	Kalevi Nieminen	tahtaysmestarit	\N	ds9ViJsVCU
2024-04-26 13:37:15.706	1188	\N	\N	Liisa Heikkinen	tahtaysmestarit	\N	CojF7bw3tP
2024-04-26 13:37:15.729	1189	\N	\N	Anneli Virtanen	laukausryhma_aurora	\N	YM33ABcpDE
2024-04-26 13:37:15.745	1190	\N	\N	Kalevi Korhonen	laukausryhma_aurora	\N	OSTPXZqnb2
2024-04-26 13:37:15.758	1191	\N	\N	Matti Juustila	laukausryhma_aurora	\N	VbanN5NdWB
2024-04-26 13:37:15.77	1192	\N	\N	Marjatta Mäkelä	ampumataito	\N	ZmiiKhIMmd
2024-04-26 13:37:15.783	1193	\N	\N	Juhani Virtanen	ampumataito	\N	lLtxEIRd0d
2024-04-26 13:37:15.796	1194	\N	\N	Kalevi Määttä	ampumataito	\N	KjnyFoMV4R
2024-04-26 13:37:15.809	1195	\N	\N	Kaarina Heikkinen	ampumataito	\N	xyivohH0Du
2024-04-26 13:37:15.821	1196	\N	\N	Olavi Määttä	poliisiseura	\N	0hnTgcuYhG
2024-04-26 13:37:15.833	1197	\N	\N	Olavi Korhonen	poliisiseura	\N	RXMXHXuvXH
2024-04-26 13:37:15.845	1198	\N	\N	Kalevi Hämäläinen	poliisiseura	\N	lpNJIk1PfY
2024-04-26 13:37:15.859	1199	\N	\N	Liisa Korhonen	poliisiseura	\N	WT5yj7mfOb
2024-04-26 13:37:15.872	1200	\N	\N	Johannes Määttä	poliisiseura	\N	BKpn1fpSDq
2024-04-26 13:37:15.883	1201	\N	\N	Anna Juustila	poliisiseura	\N	2iOG6bmZHZ
2024-04-26 13:37:15.895	1202	\N	\N	Maria Kumpulainen	poliisiseura	\N	ewBUzotucg
2024-04-26 13:37:15.905	1203	\N	\N	Helena Holappa	poliisiseura	\N	vlSU6Lvzql
2024-04-26 13:37:15.917	1204	\N	\N	Anna Holappa	poliisiseura	\N	wJVX4LKZJs
2024-04-26 13:37:15.929	1205	\N	\N	Antero Virtanen	poliisiseura	\N	SQE2hyWMYR
2024-04-26 13:37:15.943	1206	\N	\N	Tapio Ollakka	poliisiseura	\N	5s6Mfjc3tB
2024-04-26 13:37:15.956	1207	\N	\N	Ilmari Järvinen	koiraseura	\N	VitiDuW71M
2024-04-26 13:37:15.968	1208	\N	\N	Mikael Laine	koiraseura	\N	noLDaADnfh
2024-04-26 13:37:15.984	1209	\N	\N	Anna Virtanen	koiraseura	\N	PKqafkyQZH
2024-04-26 13:37:15.998	1210	\N	\N	Johanna Laine	koiraseura	\N	DXxgBviflu
2024-04-26 13:37:16.011	1211	\N	\N	Tapani Ollakka	koiraseura	\N	fijryNjsvl
2024-04-26 13:37:16.025	1212	\N	\N	Liisa Komulainen	koiraseura	\N	PrxFQFq21N
2024-04-26 13:37:16.039	1213	\N	\N	Olavi Heikkinen	koiraseura	\N	e7pWrIqFlM
2024-04-26 13:37:16.052	1214	\N	\N	Johanna Holappa	koiraseura	\N	xUkoTIy11Q
2024-04-26 13:37:16.066	1215	\N	\N	Anna Mäkelä	koiraseura	\N	Bh1Y0b62v7
2024-04-26 13:37:16.081	1216	\N	\N	Liisa Järvinen	koiraseura	\N	EncuVjIkTT
2024-04-26 13:37:16.094	1217	\N	\N	Maria Koskinen	koiraseura	\N	B2sTyiwxwY
2024-04-26 13:37:16.131	1218	\N	\N	Tapio Korhonen	hammaspeikkoseura	\N	nEb70ut1rd
2024-04-26 13:37:16.165	1219	\N	\N	Tapio Korhonen	hammaspeikkoseura	\N	yxqjVEATRi
2024-04-26 13:37:16.183	1220	\N	\N	Marjatta Nieminen	hammaspeikkoseura	\N	IutERuLBfK
2024-04-26 13:37:16.196	1221	\N	\N	Johannes Holappa	hammaspeikkoseura	\N	f7jOKAl9f1
2024-04-26 13:37:16.209	1222	\N	\N	Kalevi Kelanti	dog	\N	2b983gIA0r
2024-04-26 13:37:16.221	1223	\N	\N	Kalevi Kumpulainen	dog	\N	JstwWyWsG3
2024-04-26 13:37:16.235	1224	\N	\N	Liisa Mäkelä	dog	\N	XgPWQVibVb
2024-04-26 13:37:16.247	1225	\N	\N	Juhani Juustila	dog	\N	Zfi6b1DiJa
2024-04-26 13:37:16.261	1226	\N	\N	Maria Hämäläinen	dog	\N	eMYVg0PA2c
2024-04-26 13:37:16.273	1227	\N	\N	Tapani Lehtinen	savu_seura	\N	nG9EIBOV9C
2024-04-26 13:37:16.287	1228	\N	\N	Marjatta Juustila	savu_seura	\N	EPdAbcw3GH
2024-04-26 13:37:16.3	1229	\N	\N	Kaarina Ollakka	savu_seura	\N	F5Fa6WV6dj
2024-04-26 13:37:16.313	1230	\N	\N	Anna Mäkelä	savu_seura	\N	9EfWU0nPhr
2024-04-26 13:37:16.325	1231	\N	\N	Helena Järvinen	savu_seura	\N	Y9iUTtT8WL
2024-04-26 13:37:16.337	1232	\N	\N	Anna Mäkelä	savu_seura	\N	ACrdE9iMcy
2024-04-26 13:37:16.351	1233	\N	\N	Kalevi Kumpulainen	savu_seura	\N	9IUeDliFvu
2024-04-26 13:37:16.363	1234	\N	\N	Liisa Kumpulainen	savu_seura	\N	VIL17OtRcX
2024-04-26 13:37:16.376	1235	\N	\N	Tapio Juustila	savu_seura	\N	PC727nP9qf
2024-04-26 13:37:16.388	1236	\N	\N	Tapio Nieminen	savu_seura	\N	U0b7FxZN1p
2024-04-26 13:37:16.399	1237	\N	\N	Anneli Ollakka	savu_seura	\N	kR9PLZRE2u
2024-04-26 13:37:16.413	1238	\N	\N	Antero Koskinen	omas	\N	14RKvgbS4k
2024-04-26 13:37:16.426	1239	\N	\N	Johannes Mäkelä	omas	\N	UfFYwcIipQ
2024-04-26 13:37:16.438	1240	\N	\N	Anneli Komulainen	omas	\N	u6ihFmFzsQ
2024-04-26 13:37:16.451	1241	\N	\N	Anneli Järvinen	omas	\N	5iOFbh3cHu
2024-04-26 13:37:16.464	1242	\N	\N	Kalevi Holappa	pelleseura	\N	A5NjuB3kCZ
2024-04-26 13:37:16.478	1243	\N	\N	Ilmari Järvinen	pelleseura	\N	GoiTBKquXU
2024-04-26 13:37:16.491	1244	\N	\N	Antero Juustila	pelleseura	\N	apfWBjBkDp
2024-04-26 13:37:16.504	1245	\N	\N	Johannes Määttä	pelleseura	\N	oV1xZfpjIk
2024-04-26 13:37:16.518	1246	\N	\N	Tapani Lehtinen	pelleseura	\N	cwxsPmkHsR
2024-04-26 13:37:16.534	1247	\N	\N	Maria Ollakka	pelleseura	\N	spclkBf2r9
2024-04-26 13:37:16.547	1248	\N	\N	Ilmari Kelanti	pelleseura	\N	K3Ro17Svog
2024-04-26 13:37:16.559	1249	\N	\N	Ilmari Komulainen	pelleseura	\N	TpQoRA9VoB
2024-04-26 13:37:16.57	1250	\N	\N	Helena Lehtinen	yung_tallent	\N	Vf3aENCuXh
2024-04-26 13:37:16.581	1251	\N	\N	Antero Kumpulainen	yung_tallent	\N	v8OHDhRJGu
2024-04-26 13:37:16.593	1252	\N	\N	Antero Kelanti	yung_tallent	\N	QIgKRZpVk4
2024-04-26 13:37:16.606	1253	\N	\N	Matti Järvinen	yung_tallent	\N	2p3L0ViKLL
2024-04-26 13:37:16.619	1254	\N	\N	Kaarina Määttä	yung_tallent	\N	g99k0L9OGf
2024-04-26 13:37:16.631	1255	\N	\N	Marjatta Ollakka	yung_tallent	\N	0vcktXMmMR
2024-04-26 13:37:16.645	1256	\N	\N	Mikael Hämäläinen	yung_tallent	\N	qSPS4TKJkT
2024-04-26 13:37:16.659	1257	\N	\N	Ilmari Heikkinen	yung_tallent	\N	PN0VP2LbiG
2024-04-26 13:37:16.672	1258	\N	\N	Tapani Heikkinen	aseharrastajien_yhtenaisyys	\N	8x5HbsZkWI
2024-04-26 13:37:16.685	1259	\N	\N	Marjatta Järvinen	aseharrastajien_yhtenaisyys	\N	JOXJDXHVa7
2024-04-26 13:37:16.697	1260	\N	\N	Johanna Järvinen	aseharrastajien_yhtenaisyys	\N	c28EJqqUh0
2024-04-26 13:37:16.709	1261	\N	\N	Juhani Laine	aseharrastajien_yhtenaisyys	\N	R5d923kG89
2024-04-26 13:37:16.722	1262	\N	\N	Mikael Järvinen	aseharrastajien_yhtenaisyys	\N	WXByRMeyYa
2024-04-26 13:37:16.735	1263	\N	\N	Anna Virtanen	aseharrastajien_yhtenaisyys	\N	D4cj3DC8wp
2024-04-26 13:37:16.748	1264	\N	\N	Tapani Järvinen	aseharrastajien_yhtenaisyys	\N	h88YHzVasi
2024-04-26 13:37:16.761	1265	\N	\N	Liisa Ollakka	aseharrastajien_yhtenaisyys	\N	a4sanCNHoy
2024-04-26 13:37:16.772	1266	\N	\N	Helena Laine	aseharrastajien_yhtenaisyys	\N	2wSiDJo1C1
2024-04-26 13:37:16.785	1267	\N	\N	Ilmari Nieminen	aseharrastajien_yhtenaisyys	\N	a7WLFAALvt
2024-04-26 13:37:16.798	1268	\N	\N	Johannes Mäkelä	aseharrastajien_yhtenaisyys	\N	Nefi0EAShk
2024-04-26 13:37:16.81	1269	\N	\N	Liisa Kumpulainen	tahtaysmestarit	\N	qRVZSJZmVR
2024-04-26 13:37:16.822	1270	\N	\N	Liisa Ollakka	tahtaysmestarit	\N	3Ld0m2IV5c
2024-04-26 13:37:16.834	1271	\N	\N	Johannes Kelanti	tahtaysmestarit	\N	BRcJDnHcrQ
2024-04-26 13:37:16.847	1272	\N	\N	Marjatta Mäkelä	tahtaysmestarit	\N	8coowF9ZIy
2024-04-26 13:37:16.858	1273	\N	\N	Kalevi Koskinen	laukausryhma_aurora	\N	d5S9kaPdLV
2024-04-26 13:37:16.871	1274	\N	\N	Olavi Holappa	laukausryhma_aurora	\N	i76UxdX6g7
2024-04-26 13:37:16.882	1275	\N	\N	Mikael Komulainen	laukausryhma_aurora	\N	EJFzCMIK0x
2024-04-26 13:37:16.895	1276	\N	\N	Johanna Hämäläinen	laukausryhma_aurora	\N	eE8yZJsSvg
2024-04-26 13:37:16.908	1277	\N	\N	Liisa Järvinen	laukausryhma_aurora	\N	j5LamBM8Wx
2024-04-26 13:37:16.92	1278	\N	\N	Liisa Lehtinen	laukausryhma_aurora	\N	TTsXSju6Cf
2024-04-26 13:37:16.933	1279	\N	\N	Johanna Holappa	laukausryhma_aurora	\N	UYmJYdpGaV
2024-04-26 13:37:16.945	1280	\N	\N	Marjatta Kumpulainen	laukausryhma_aurora	\N	YlhVQQyK4W
2024-04-26 13:37:16.958	1281	\N	\N	Olavi Lehtinen	ampumataito	\N	ahUmTNR1DI
2024-04-26 13:37:16.972	1282	\N	\N	Kaarina Kumpulainen	ampumataito	\N	BHiQKJXF6Q
2024-04-26 13:37:16.984	1283	\N	\N	Juhani Komulainen	ampumataito	\N	vlmwJwhJ0n
2024-04-26 13:37:16.997	1284	\N	\N	Johanna Komulainen	ampumataito	\N	u2WbS0xylW
2024-04-26 13:37:17.009	1285	\N	\N	Helena Mäkelä	ampumataito	\N	ifE5wGhVvn
2024-04-26 13:37:17.022	1286	\N	\N	Tapio Hämäläinen	ampumataito	\N	ObU0c3lO0M
2024-04-26 13:37:17.033	1287	\N	\N	Tapio Määttä	ampumataito	\N	i2iLVl0yg7
2024-04-26 13:37:17.045	1288	\N	\N	Tapio Järvinen	ampumataito	\N	RZCHGXPyS2
2024-04-26 13:37:17.056	1289	\N	\N	Maria Hämäläinen	ampumataito	\N	pl6T1yg13p
2024-04-26 13:37:17.068	1290	\N	\N	Tapani Nieminen	ampumataito	\N	c6HAYl6ljH
2024-04-26 13:37:17.081	1291	\N	\N	Anneli Mäkinen	ampumataito	\N	4gYmvEzAj8
2024-04-26 13:37:17.093	1292	\N	\N	Matti Mäkelä	ampumataito	\N	Ld5kc12c4K
2024-04-26 13:37:17.105	1293	\N	\N	Kaarina Heikkinen	poliisiseura	\N	S4evG1HL92
2024-04-26 13:37:17.118	1294	\N	\N	Kalevi Holappa	poliisiseura	\N	qPuLWGtomJ
2024-04-26 13:37:17.132	1295	\N	\N	Anna Virtanen	poliisiseura	\N	Oy9tP74YkO
2024-04-26 13:37:17.145	1296	\N	\N	Anneli Heikkinen	poliisiseura	\N	EAL7uB6Zkg
2024-04-26 13:37:17.158	1297	\N	\N	Juhani Virtanen	poliisiseura	\N	ayiv6KxQE5
2024-04-26 13:37:17.172	1298	\N	\N	Anneli Komulainen	poliisiseura	\N	ypuuLWzmMO
2024-04-26 13:37:17.185	1299	\N	\N	Juhani Kelanti	poliisiseura	\N	B0lrCK9Kj1
2024-04-26 13:37:17.198	1300	\N	\N	Juhani Nieminen	poliisiseura	\N	l6ZTmXs68f
2024-04-26 13:37:17.212	1301	\N	\N	Liisa Virtanen	poliisiseura	\N	AVBysri10P
2024-04-26 13:37:17.224	1302	\N	\N	Juhani Kelanti	poliisiseura	\N	kzIchyWC4C
2024-04-26 13:37:17.239	1303	\N	\N	Mikael Nieminen	koiraseura	\N	lDmMTw2qCA
2024-04-26 13:37:17.253	1304	\N	\N	Tapani Laine	koiraseura	\N	dtmkdpoA6c
2024-04-26 13:37:17.265	1305	\N	\N	Marjatta Virtanen	koiraseura	\N	PZ0PlIZYDf
2024-04-26 13:37:17.278	1306	\N	\N	Anneli Korhonen	koiraseura	\N	P3m25hvlE2
2024-04-26 13:37:17.29	1307	\N	\N	Tapio Kelanti	koiraseura	\N	RWBgjmPyKv
2024-04-26 13:37:17.302	1308	\N	\N	Anna Hämäläinen	koiraseura	\N	mjx4pWD5zC
2024-04-26 13:37:17.314	1309	\N	\N	Juhani Holappa	koiraseura	\N	Bnp59czIgN
2024-04-26 13:37:17.327	1310	\N	\N	Tapani Heikkinen	koiraseura	\N	6XNAsw5DqH
2024-04-26 13:37:17.34	1311	\N	\N	Anna Korhonen	koiraseura	\N	RciLMBGl6M
2024-04-26 13:37:17.352	1312	\N	\N	Kalevi Heikkinen	koiraseura	\N	t1GbPuiJum
2024-04-26 13:37:17.365	1313	\N	\N	Anna Komulainen	koiraseura	\N	nwx9UQ0emP
2024-04-26 13:37:17.375	1314	\N	\N	Juhani Järvinen	koiraseura	\N	MT9NBOAmYM
2024-04-26 13:37:17.388	1315	\N	\N	Anna Kumpulainen	koiraseura	\N	ZMs83niG72
2024-04-26 13:37:17.4	1316	\N	\N	Johanna Hämäläinen	hammaspeikkoseura	\N	8rMfqLR7cA
2024-04-26 13:37:17.412	1317	\N	\N	Antero Mäkelä	hammaspeikkoseura	\N	CMaxBS09af
2024-04-26 13:37:17.426	1318	\N	\N	Johanna Nieminen	hammaspeikkoseura	\N	z4NIHPwdn2
2024-04-26 13:37:17.438	1319	\N	\N	Mikael Virtanen	dog	\N	YdQNvWwHKf
2024-04-26 13:37:17.451	1320	\N	\N	Mikael Laine	dog	\N	OA1VvWaMiu
2024-04-26 13:37:17.463	1321	\N	\N	Anneli Juustila	dog	\N	eom5loMJdm
2024-04-26 13:37:17.475	1322	\N	\N	Kalevi Ollakka	savu_seura	\N	O3OGvTprd1
2024-04-26 13:37:17.487	1323	\N	\N	Maria Holappa	savu_seura	\N	b48UJoxuuO
2024-04-26 13:37:17.499	1324	\N	\N	Johanna Määttä	savu_seura	\N	PeT0PXHhYw
2024-04-26 13:37:17.511	1325	\N	\N	Marjatta Heikkinen	omas	\N	r2GZxk4jr8
2024-04-26 13:37:17.523	1326	\N	\N	Johannes Holappa	omas	\N	J3aTzKKDiH
2024-04-26 13:37:17.535	1327	\N	\N	Tapio Ollakka	omas	\N	fhlzFiQgMc
2024-04-26 13:37:17.546	1328	\N	\N	Liisa Nieminen	omas	\N	MurxyLrJsh
2024-04-26 13:37:17.558	1329	\N	\N	Liisa Määttä	omas	\N	KjXTLSTUbP
2024-04-26 13:37:17.57	1330	\N	\N	Kaarina Järvinen	pelleseura	\N	okUZHHcxed
2024-04-26 13:37:17.583	1331	\N	\N	Marjatta Hämäläinen	pelleseura	\N	3UjdjUvnSh
2024-04-26 13:37:17.595	1332	\N	\N	Antero Holappa	pelleseura	\N	z72NiOkIj8
2024-04-26 13:37:17.608	1333	\N	\N	Matti Holappa	yung_tallent	\N	3to9KSqYrx
2024-04-26 13:37:17.619	1334	\N	\N	Antero Lehtinen	yung_tallent	\N	N5OVqVAJ8u
2024-04-26 13:37:17.632	1335	\N	\N	Liisa Virtanen	yung_tallent	\N	bL7xAfFUlr
2024-04-26 13:37:17.645	1336	\N	\N	Johanna Laine	yung_tallent	\N	V47ii5n3f1
2024-04-26 13:37:17.657	1337	\N	\N	Ilmari Korhonen	yung_tallent	\N	Wy3ozi404e
2024-04-26 13:37:17.67	1338	\N	\N	Johannes Korhonen	yung_tallent	\N	nwlACcJJ6G
2024-04-26 13:37:17.68	1339	\N	\N	Anneli Heikkinen	yung_tallent	\N	C939gLhEIQ
2024-04-26 13:37:17.692	1340	\N	\N	Maria Juustila	yung_tallent	\N	XonCL2lbMW
2024-04-26 13:37:17.705	1341	\N	\N	Tapani Koskinen	yung_tallent	\N	ZtNTfKs3Xu
2024-04-26 13:37:17.718	1342	\N	\N	Matti Kelanti	aseharrastajien_yhtenaisyys	\N	1vGypwvVW4
2024-04-26 13:37:17.73	1343	\N	\N	Kaarina Komulainen	aseharrastajien_yhtenaisyys	\N	pfVObecNSV
2024-04-26 13:37:17.742	1344	\N	\N	Anna Hämäläinen	aseharrastajien_yhtenaisyys	\N	jHYZpkmirR
2024-04-26 13:37:17.755	1345	\N	\N	Juhani Korhonen	aseharrastajien_yhtenaisyys	\N	XX7hvEvEj9
2024-04-26 13:37:17.768	1346	\N	\N	Johannes Komulainen	tahtaysmestarit	\N	NWtZE4gtuy
2024-04-26 13:37:17.779	1347	\N	\N	Ilmari Ollakka	tahtaysmestarit	\N	7nzHtEwTf3
2024-04-26 13:37:17.791	1348	\N	\N	Mikael Ollakka	tahtaysmestarit	\N	AxF32K7Oic
2024-04-26 13:37:17.802	1349	\N	\N	Liisa Juustila	tahtaysmestarit	\N	KQ3BVJHja0
2024-04-26 13:37:17.832	1350	\N	\N	Mikael Mäkelä	tahtaysmestarit	\N	vuZDf0Rkz0
2024-04-26 13:37:17.843	1351	\N	\N	Antero Laine	laukausryhma_aurora	\N	SiQvISY92G
2024-04-26 13:37:17.854	1352	\N	\N	Juhani Juustila	laukausryhma_aurora	\N	qrvfacSpS5
2024-04-26 13:37:17.866	1353	\N	\N	Ilmari Juustila	laukausryhma_aurora	\N	h6jZmBq3gS
2024-04-26 13:37:17.878	1354	\N	\N	Marjatta Järvinen	laukausryhma_aurora	\N	HgzJ3jo5CC
2024-04-26 13:37:17.89	1355	\N	\N	Olavi Juustila	laukausryhma_aurora	\N	9K8xIuRplP
2024-04-26 13:37:17.902	1356	\N	\N	Olavi Laine	laukausryhma_aurora	\N	LEdVgQbFf7
2024-04-26 13:37:17.914	1357	\N	\N	Johannes Lehtinen	laukausryhma_aurora	\N	Q84Y9SQiF3
2024-04-26 13:37:17.925	1358	\N	\N	Helena Koskinen	laukausryhma_aurora	\N	utD8pskZk1
2024-04-26 13:37:17.936	1359	\N	\N	Anna Komulainen	laukausryhma_aurora	\N	r4qcptQFeH
2024-04-26 13:37:17.954	1360	\N	\N	Tapani Kumpulainen	laukausryhma_aurora	\N	qnMjHWHOAN
2024-04-26 13:37:17.971	1361	\N	\N	Kaarina Kelanti	ampumataito	\N	busP0DLiqs
2024-04-26 13:37:17.987	1362	\N	\N	Anneli Hämäläinen	ampumataito	\N	0N41zdNYy9
2024-04-26 13:37:18.007	1363	\N	\N	Anna Laine	ampumataito	\N	ozCprSm67w
2024-04-26 13:37:18.019	1364	\N	\N	Juhani Järvinen	ampumataito	\N	oTLq3MOdE4
2024-04-26 13:37:18.035	1365	\N	\N	Matti Mäkelä	ampumataito	\N	GzclrVImhX
2024-04-26 13:37:18.046	1366	\N	\N	Juhani Kumpulainen	ampumataito	\N	b3xsUdutaq
2024-04-26 13:37:18.058	1367	\N	\N	Helena Virtanen	ampumataito	\N	Iir2UoUfYB
2024-04-26 13:37:18.072	1368	\N	\N	Johanna Juustila	ampumataito	\N	er62Q7RkfA
2024-04-26 13:37:18.085	1369	\N	\N	Tapio Määttä	ampumataito	\N	1gbUZ7afKb
2024-04-26 13:37:18.097	1370	\N	\N	Maria Kelanti	ampumataito	\N	2VKceRdABP
2024-04-26 13:37:18.109	1371	\N	\N	Maria Komulainen	poliisiseura	\N	9MpY6JNTOc
2024-04-26 13:37:18.121	1372	\N	\N	Ilmari Koskinen	poliisiseura	\N	DDv156LFd4
2024-04-26 13:37:18.135	1373	\N	\N	Johannes Korhonen	poliisiseura	\N	B94nIrTIbA
2024-04-26 13:37:18.146	1374	\N	\N	Kalevi Koskinen	poliisiseura	\N	SprTnMObhj
2024-04-26 13:37:18.158	1375	\N	\N	Ilmari Kumpulainen	poliisiseura	\N	8aXEM4mrRn
2024-04-26 13:37:18.171	1376	\N	\N	Anneli Koskinen	poliisiseura	\N	NhsOxki31s
2024-04-26 13:37:18.182	1377	\N	\N	Olavi Juustila	poliisiseura	\N	EGw1Ew7zt1
2024-04-26 13:37:18.195	1378	\N	\N	Tapani Kelanti	poliisiseura	\N	E4GHRnVtnj
2024-04-26 13:37:18.207	1379	\N	\N	Tapani Lehtinen	poliisiseura	\N	U5Pr14Z98d
2024-04-26 13:37:18.219	1380	\N	\N	Helena Laine	poliisiseura	\N	8xAM4r8kgJ
2024-04-26 13:37:18.231	1381	\N	\N	Kalevi Mäkelä	poliisiseura	\N	RIff7XrxGN
2024-04-26 13:37:18.243	1382	\N	\N	Liisa Nieminen	poliisiseura	\N	RDGAtqsL7k
2024-04-26 13:37:18.258	1383	\N	\N	Tapani Hämäläinen	poliisiseura	\N	lJCZmcqYmU
2024-04-26 13:37:18.27	1384	\N	\N	Olavi Hämäläinen	koiraseura	\N	pnezmPmsx9
2024-04-26 13:37:18.282	1385	\N	\N	Maria Kelanti	koiraseura	\N	ccnqzOHRCl
2024-04-26 13:37:18.293	1386	\N	\N	Johanna Laine	koiraseura	\N	hYG0Jo51dP
2024-04-26 13:37:18.306	1387	\N	\N	Anna Virtanen	koiraseura	\N	6ozSU7Wd7Y
2024-04-26 13:37:18.32	1388	\N	\N	Johanna Järvinen	koiraseura	\N	NDjzY7i7aH
2024-04-26 13:37:18.334	1389	\N	\N	Juhani Mäkelä	koiraseura	\N	TcQZNVVDiq
2024-04-26 13:37:18.346	1390	\N	\N	Tapio Holappa	koiraseura	\N	4zAXLwIPlD
2024-04-26 13:37:18.358	1391	\N	\N	Olavi Komulainen	hammaspeikkoseura	\N	juQ9i14xmg
2024-04-26 13:37:18.371	1392	\N	\N	Kalevi Järvinen	hammaspeikkoseura	\N	de0JP0K40e
2024-04-26 13:37:18.384	1393	\N	\N	Juhani Ollakka	hammaspeikkoseura	\N	oUcABrkRBM
2024-04-26 13:37:18.399	1394	\N	\N	Liisa Virtanen	hammaspeikkoseura	\N	7A6C3qQanv
2024-04-26 13:37:18.412	1395	\N	\N	Johanna Holappa	dog	\N	kjmrvewFPS
2024-04-26 13:37:18.425	1396	\N	\N	Johanna Heikkinen	dog	\N	c6sCZSWtBU
2024-04-26 13:37:18.439	1397	\N	\N	Antero Järvinen	dog	\N	MO4izopaKR
2024-04-26 13:37:18.451	1398	\N	\N	Anna Kelanti	dog	\N	z5X1d943h5
2024-04-26 13:37:18.464	1399	\N	\N	Juhani Nieminen	dog	\N	RWZ2umQvlU
2024-04-26 13:37:18.478	1400	\N	\N	Liisa Komulainen	dog	\N	5icFB4xKql
2024-04-26 13:37:18.492	1401	\N	\N	Johannes Ollakka	dog	\N	bcmojQKNrs
2024-04-26 13:37:18.505	1402	\N	\N	Juhani Komulainen	dog	\N	LcQPGmyUJ4
2024-04-26 13:37:18.519	1403	\N	\N	Ilmari Mäkinen	savu_seura	\N	31Av85Y5Gf
2024-04-26 13:37:18.532	1404	\N	\N	Matti Juustila	savu_seura	\N	t59i3ofrDE
2024-04-26 13:37:18.545	1405	\N	\N	Ilmari Korhonen	savu_seura	\N	CRT1yfBIw4
2024-04-26 13:37:18.558	1406	\N	\N	Juhani Laine	savu_seura	\N	0oOeEL6o0z
2024-04-26 13:37:18.571	1407	\N	\N	Kaarina Kelanti	savu_seura	\N	zuaVqYsf6Y
2024-04-26 13:37:18.582	1408	\N	\N	Mikael Määttä	savu_seura	\N	7DVU8YxOWN
2024-04-26 13:37:18.595	1409	\N	\N	Maria Komulainen	savu_seura	\N	U52xy0rWD9
2024-04-26 13:37:18.606	1410	\N	\N	Ilmari Ollakka	savu_seura	\N	Vq5W5iQPZt
2024-04-26 13:37:18.62	1411	\N	\N	Liisa Nieminen	savu_seura	\N	W4HIYFuUa8
2024-04-26 13:37:18.632	1412	\N	\N	Johannes Määttä	savu_seura	\N	DtCm5NvKej
2024-04-26 13:37:18.645	1413	\N	\N	Helena Järvinen	omas	\N	XNNtF0oV21
2024-04-26 13:37:18.656	1414	\N	\N	Johanna Komulainen	omas	\N	XrHud9kVjo
2024-04-26 13:37:18.669	1415	\N	\N	Mikael Kelanti	omas	\N	CZ8lSB1Daw
2024-04-26 13:37:18.683	1416	\N	\N	Anneli Hämäläinen	omas	\N	5N7R0CFMZN
2024-04-26 13:37:18.694	1417	\N	\N	Johanna Määttä	omas	\N	ZiiVk78QUG
2024-04-26 13:37:18.706	1418	\N	\N	Olavi Ollakka	omas	\N	CfnnheWsfd
2024-04-26 13:37:18.718	1419	\N	\N	Tapani Komulainen	omas	\N	UYaUwdZWFO
2024-04-26 13:37:18.729	1420	\N	\N	Marjatta Heikkinen	omas	\N	DX7Hj6iEHF
2024-04-26 13:37:18.743	1421	\N	\N	Tapio Laine	omas	\N	WAjxqHnfMt
2024-04-26 13:37:18.755	1422	\N	\N	Kalevi Kumpulainen	omas	\N	ULK8V0LJpG
2024-04-26 13:37:18.767	1423	\N	\N	Kaarina Järvinen	pelleseura	\N	ZkBrpi10y3
2024-04-26 13:37:18.78	1424	\N	\N	Johannes Nieminen	pelleseura	\N	r4ZSpr7Q0H
2024-04-26 13:37:18.794	1425	\N	\N	Kaarina Mäkelä	pelleseura	\N	6KG2heM7MS
2024-04-26 13:37:18.81	1426	\N	\N	Kalevi Nieminen	pelleseura	\N	17E8IUNGlH
2024-04-26 13:37:18.824	1427	\N	\N	Kaarina Järvinen	pelleseura	\N	tWWO6DfYRc
2024-04-26 13:37:18.838	1428	\N	\N	Matti Hämäläinen	pelleseura	\N	3csiOpB3jE
2024-04-26 13:37:18.852	1429	\N	\N	Marjatta Komulainen	pelleseura	\N	H2FJhYDNCE
2024-04-26 13:37:18.868	1430	\N	\N	Matti Hämäläinen	yung_tallent	\N	sdXc0cidpj
2024-04-26 13:37:18.882	1431	\N	\N	Tapani Koskinen	yung_tallent	\N	7hHTulmmgJ
2024-04-26 13:37:18.896	1432	\N	\N	Anneli Mäkelä	yung_tallent	\N	PEpt1tGMf5
2024-04-26 13:37:18.907	1433	\N	\N	Ilmari Holappa	yung_tallent	\N	fJjMyZdIY9
2024-04-26 13:37:18.92	1434	\N	\N	Ilmari Määttä	yung_tallent	\N	KVrRwGdNoj
2024-04-26 13:37:18.934	1435	\N	\N	Ilmari Virtanen	yung_tallent	\N	Lubd27dYWA
2024-04-26 13:37:18.946	1436	\N	\N	Juhani Koskinen	yung_tallent	\N	SISMlXI4Qw
2024-04-26 13:37:18.959	1437	\N	\N	Johanna Korhonen	yung_tallent	\N	4ojo42bacd
2024-04-26 13:37:18.97	1438	\N	\N	Juhani Juustila	yung_tallent	\N	efUxyMOIRx
2024-04-26 13:37:18.984	1439	\N	\N	Juhani Koskinen	yung_tallent	\N	X5H02FVXuR
2024-04-26 13:37:18.997	1440	\N	\N	Ilmari Järvinen	aseharrastajien_yhtenaisyys	\N	raBHBtjlCm
2024-04-26 13:37:19.009	1441	\N	\N	Maria Ollakka	aseharrastajien_yhtenaisyys	\N	NZ2LovcLrJ
2024-04-26 13:37:19.02	1442	\N	\N	Kalevi Heikkinen	aseharrastajien_yhtenaisyys	\N	ltl7XXbnXM
2024-04-26 13:37:19.033	1443	\N	\N	Juhani Holappa	aseharrastajien_yhtenaisyys	\N	EoE8VPbr3B
2024-04-26 13:37:19.047	1444	\N	\N	Matti Virtanen	tahtaysmestarit	\N	EILorvN61f
2024-04-26 13:37:19.059	1445	\N	\N	Ilmari Järvinen	tahtaysmestarit	\N	QanLKyY6G6
2024-04-26 13:37:19.073	1446	\N	\N	Johanna Määttä	tahtaysmestarit	\N	O9pDalRiPg
2024-04-26 13:37:19.086	1447	\N	\N	Helena Kelanti	tahtaysmestarit	\N	jVcvvhYf1m
2024-04-26 13:37:19.097	1448	\N	\N	Juhani Ollakka	tahtaysmestarit	\N	3I9u4nSWoe
2024-04-26 13:37:19.112	1449	\N	\N	Ilmari Koskinen	tahtaysmestarit	\N	TiQxRBWcwI
2024-04-26 13:37:19.125	1450	\N	\N	Antero Holappa	tahtaysmestarit	\N	tlrJFxkwMj
2024-04-26 13:37:19.137	1451	\N	\N	Maria Virtanen	tahtaysmestarit	\N	juyjNVmMyM
2024-04-26 13:37:19.15	1452	\N	\N	Tapani Nieminen	tahtaysmestarit	\N	ThB6T2hKAN
2024-04-26 13:37:19.163	1453	\N	\N	Johannes Laine	laukausryhma_aurora	\N	iKFLc9cmQr
2024-04-26 13:37:19.176	1454	\N	\N	Marjatta Hämäläinen	laukausryhma_aurora	\N	txfQg61suw
2024-04-26 13:37:19.188	1455	\N	\N	Marjatta Komulainen	laukausryhma_aurora	\N	wtQOMy9hIS
2024-04-26 13:37:19.201	1456	\N	\N	Matti Määttä	laukausryhma_aurora	\N	3W9bWi9rbJ
2024-04-26 13:37:19.212	1457	\N	\N	Mikael Hämäläinen	laukausryhma_aurora	\N	IcUh5Bkuab
2024-04-26 13:37:19.226	1458	\N	\N	Anna Holappa	ampumataito	\N	OkVh1XN8O3
2024-04-26 13:37:19.238	1459	\N	\N	Antero Lehtinen	ampumataito	\N	WNJSaJ2a4f
2024-04-26 13:37:19.25	1460	\N	\N	Tapani Juustila	ampumataito	\N	Ui8EwHWLI8
2024-04-26 13:37:19.262	1461	\N	\N	Helena Hämäläinen	ampumataito	\N	3q8O9BTNQt
2024-04-26 13:37:19.273	1462	\N	\N	Johannes Hämäläinen	ampumataito	\N	1BjoC3G0U9
2024-04-26 13:37:19.287	1463	\N	\N	Mikael Ollakka	ampumataito	\N	Qn80RideO9
2024-04-26 13:37:19.299	1464	\N	\N	Liisa Nieminen	ampumataito	\N	kbN3y9bvU7
2024-04-26 13:37:19.31	1465	\N	\N	Maria Komulainen	ampumataito	\N	vbQRGIzJRT
2024-04-26 13:37:19.321	1466	\N	\N	Anneli Laine	ampumataito	\N	E6BoKmKLU9
2024-04-26 13:37:19.334	1467	\N	\N	Tapio Juustila	poliisiseura	\N	CNbmjikMLj
2024-04-26 13:37:19.345	1468	\N	\N	Johannes Mäkinen	poliisiseura	\N	CooWlYtD2t
2024-04-26 13:37:19.358	1469	\N	\N	Liisa Korhonen	poliisiseura	\N	R4Q1lPd0WQ
2024-04-26 13:37:19.369	1470	\N	\N	Matti Juustila	poliisiseura	\N	rmi3ucDWNr
2024-04-26 13:37:19.38	1471	\N	\N	Ilmari Virtanen	poliisiseura	\N	u7b2W5h7mU
2024-04-26 13:37:19.39	1472	\N	\N	Anna Virtanen	poliisiseura	\N	nCJkIJVFaA
2024-04-26 13:37:19.402	1473	\N	\N	Olavi Kumpulainen	poliisiseura	\N	TPGct6C62Y
2024-04-26 13:37:19.415	1474	\N	\N	Tapio Ollakka	poliisiseura	\N	wBfdDh7DKh
2024-04-26 13:37:19.428	1475	\N	\N	Mikael Nieminen	poliisiseura	\N	bdarZLMjhY
2024-04-26 13:37:19.439	1476	\N	\N	Kalevi Nieminen	poliisiseura	\N	LGl5fWGDQX
2024-04-26 13:37:19.45	1477	\N	\N	Tapani Lehtinen	poliisiseura	\N	nha39J3JZI
2024-04-26 13:37:19.461	1478	\N	\N	Tapio Hämäläinen	poliisiseura	\N	F2jomNvND0
2024-04-26 13:37:19.474	1479	\N	\N	Anneli Nieminen	poliisiseura	\N	0kYNQhj6pn
2024-04-26 13:37:19.486	1480	\N	\N	Anna Nieminen	poliisiseura	\N	8MQWEMxAIE
2024-04-26 13:37:19.497	1481	\N	\N	Anneli Hämäläinen	koiraseura	\N	vI3UXJZL4H
2024-04-26 13:37:19.508	1482	\N	\N	Helena Järvinen	koiraseura	\N	5NFhuoD6lF
2024-04-26 13:37:19.519	1483	\N	\N	Juhani Virtanen	koiraseura	\N	BKdqzpRKNJ
2024-04-26 13:37:19.531	1484	\N	\N	Marjatta Laine	koiraseura	\N	o2XDJNf0Zu
2024-04-26 13:37:19.544	1485	\N	\N	Antero Juustila	koiraseura	\N	gbsqZgIHVq
2024-04-26 13:37:19.555	1486	\N	\N	Marjatta Korhonen	koiraseura	\N	V5NGjlAQ0T
2024-04-26 13:37:19.566	1487	\N	\N	Kaarina Korhonen	koiraseura	\N	YJyrz9nV6p
2024-04-26 13:37:19.578	1488	\N	\N	Tapani Koskinen	koiraseura	\N	sWHyDSNAcb
2024-04-26 13:37:19.589	1489	\N	\N	Olavi Koskinen	koiraseura	\N	LNbky2aOPf
2024-04-26 13:37:19.602	1490	\N	\N	Kalevi Määttä	hammaspeikkoseura	\N	9MdrW1yHOf
2024-04-26 13:37:19.616	1491	\N	\N	Anneli Nieminen	hammaspeikkoseura	\N	f3BDF3ai2k
2024-04-26 13:37:19.627	1492	\N	\N	Marjatta Koskinen	hammaspeikkoseura	\N	kZcFc174cy
2024-04-26 13:37:19.638	1493	\N	\N	Tapani Nieminen	hammaspeikkoseura	\N	7916vP1U4c
2024-04-26 13:37:19.65	1494	\N	\N	Helena Ollakka	hammaspeikkoseura	\N	MUKLRUt6Sr
2024-04-26 13:37:19.663	1495	\N	\N	Tapani Lehtinen	hammaspeikkoseura	\N	M9rUMVERDA
2024-04-26 13:37:19.675	1496	\N	\N	Maria Holappa	hammaspeikkoseura	\N	QZYc8KkqTZ
2024-04-26 13:37:19.686	1497	\N	\N	Liisa Korhonen	hammaspeikkoseura	\N	XPLBuEZPl7
2024-04-26 13:37:19.698	1498	\N	\N	Helena Järvinen	hammaspeikkoseura	\N	dK8zH7jx1C
2024-04-26 13:37:19.709	1499	\N	\N	Anneli Koskinen	dog	\N	apBxsg0B4d
2024-04-26 13:37:19.722	1500	\N	\N	Liisa Korhonen	dog	\N	hyiqkGLu9p
2024-04-26 13:37:19.734	1501	\N	\N	Liisa Laine	dog	\N	scs5v08HWK
2024-04-26 13:37:19.746	1502	\N	\N	Matti Määttä	dog	\N	2xl8ldyWM1
2024-04-26 13:37:19.757	1503	\N	\N	Helena Ollakka	dog	\N	MuG734Yy3I
2024-04-26 13:37:19.769	1504	\N	\N	Johanna Heikkinen	dog	\N	L0mXp4oUMA
2024-04-26 13:37:19.78	1505	\N	\N	Maria Hämäläinen	dog	\N	Pf3E0szCnc
2024-04-26 13:37:19.798	1506	\N	\N	Liisa Virtanen	dog	\N	TBvIwwhaHT
2024-04-26 13:37:19.813	1507	\N	\N	Tapio Koskinen	dog	\N	KwW62PjUH6
2024-04-26 13:37:19.83	1508	\N	\N	Kaarina Kumpulainen	savu_seura	\N	QZoKKc6PDj
2024-04-26 13:37:19.846	1509	\N	\N	Mikael Laine	savu_seura	\N	lEuUknWCal
2024-04-26 13:37:19.861	1510	\N	\N	Ilmari Ollakka	savu_seura	\N	SymlhSn15Z
2024-04-26 13:37:19.873	1511	\N	\N	Johanna Ollakka	omas	\N	ztzbF0STiO
2024-04-26 13:37:19.885	1512	\N	\N	Mikael Mäkinen	omas	\N	EHNcwjnpXM
2024-04-26 13:37:19.896	1513	\N	\N	Maria Laine	omas	\N	dpWyQuq8yY
2024-04-26 13:37:19.909	1514	\N	\N	Juhani Määttä	omas	\N	9rHlGn1odA
2024-04-26 13:37:19.92	1515	\N	\N	Maria Kelanti	omas	\N	YcIJG2FYmM
2024-04-26 13:37:19.932	1516	\N	\N	Liisa Kumpulainen	omas	\N	QBaz9T7iup
2024-04-26 13:37:19.943	1517	\N	\N	Matti Mäkelä	omas	\N	2HRhRlrhS8
2024-04-26 13:37:19.955	1518	\N	\N	Liisa Laine	omas	\N	9FYH6JaH1p
2024-04-26 13:37:19.968	1519	\N	\N	Liisa Korhonen	omas	\N	S532SSfiKV
2024-04-26 13:37:19.98	1520	\N	\N	Antero Komulainen	omas	\N	Oi84xAopmk
2024-04-26 13:37:19.991	1521	\N	\N	Olavi Juustila	omas	\N	l9IqC9vFmV
2024-04-26 13:37:20.003	1522	\N	\N	Ilmari Mäkelä	pelleseura	\N	CndtkaLQO5
2024-04-26 13:37:20.015	1523	\N	\N	Marjatta Korhonen	pelleseura	\N	up4fj27JWp
2024-04-26 13:37:20.029	1524	\N	\N	Johannes Korhonen	pelleseura	\N	TYl6Um24cU
2024-04-26 13:37:20.041	1525	\N	\N	Mikael Laine	pelleseura	\N	EI9sXkYYGh
2024-04-26 13:37:20.052	1526	\N	\N	Ilmari Määttä	pelleseura	\N	ePjjTkBGuI
2024-04-26 13:37:20.064	1527	\N	\N	Anna Laine	yung_tallent	\N	0LeEJVMaDs
2024-04-26 13:37:20.076	1528	\N	\N	Olavi Nieminen	yung_tallent	\N	lOb0zVPxJd
2024-04-26 13:37:20.088	1529	\N	\N	Matti Koskinen	yung_tallent	\N	FVXqXFGQgO
2024-04-26 13:37:20.1	1530	\N	\N	Antero Kumpulainen	yung_tallent	\N	nNs5yGQyib
2024-04-26 13:37:20.111	1531	\N	\N	Mikael Mäkelä	yung_tallent	\N	HTZEBuA7e6
2024-04-26 13:37:20.122	1532	\N	\N	Tapani Hämäläinen	yung_tallent	\N	ITba5KMxZD
2024-04-26 13:37:20.133	1533	\N	\N	Johanna Määttä	aseharrastajien_yhtenaisyys	\N	qBDDiXmqOm
2024-04-26 13:37:20.145	1534	\N	\N	Anna Mäkelä	aseharrastajien_yhtenaisyys	\N	QItPgobXho
2024-04-26 13:37:20.165	1535	\N	\N	Tapio Kelanti	aseharrastajien_yhtenaisyys	\N	lYClepX6d6
2024-04-26 13:37:20.179	1536	\N	\N	Tapani Hämäläinen	aseharrastajien_yhtenaisyys	\N	PfTsYfYXP8
2024-04-26 13:37:20.192	1537	\N	\N	Juhani Hämäläinen	aseharrastajien_yhtenaisyys	\N	8kSebZm0zh
2024-04-26 13:37:20.207	1538	\N	\N	Kalevi Mäkelä	aseharrastajien_yhtenaisyys	\N	ezVr0jvpyZ
2024-04-26 13:37:20.225	1539	\N	\N	Kalevi Holappa	aseharrastajien_yhtenaisyys	\N	pBrdnibITi
2024-04-26 13:37:20.243	1540	\N	\N	Anneli Laine	aseharrastajien_yhtenaisyys	\N	lHfoV9sorJ
2024-04-26 13:37:20.255	1541	\N	\N	Marjatta Kumpulainen	aseharrastajien_yhtenaisyys	\N	QjpxaZVPl8
2024-04-26 13:37:20.266	1542	\N	\N	Olavi Lehtinen	aseharrastajien_yhtenaisyys	\N	E3tWARzMxq
2024-04-26 13:37:20.281	1543	\N	\N	Anna Ollakka	aseharrastajien_yhtenaisyys	\N	pj4anysPAN
2024-04-26 13:37:20.292	1544	\N	\N	Kaarina Komulainen	aseharrastajien_yhtenaisyys	\N	xVRZeMTktS
2024-04-26 13:37:20.304	1545	\N	\N	Antero Mäkelä	tahtaysmestarit	\N	xauYgYbCek
2024-04-26 13:37:20.315	1546	\N	\N	Kaarina Korhonen	tahtaysmestarit	\N	l4rv3Borqp
2024-04-26 13:37:20.327	1547	\N	\N	Olavi Heikkinen	tahtaysmestarit	\N	2gS2Wb4128
2024-04-26 13:37:20.34	1548	\N	\N	Anneli Komulainen	tahtaysmestarit	\N	N3IkWufajY
2024-04-26 13:37:20.351	1549	\N	\N	Kalevi Ollakka	tahtaysmestarit	\N	UWbmaBgiuv
2024-04-26 13:37:20.362	1550	\N	\N	Juhani Mäkinen	tahtaysmestarit	\N	iiCog2E7eT
2024-04-26 13:37:20.373	1551	\N	\N	Kalevi Juustila	laukausryhma_aurora	\N	88P0J39tbC
2024-04-26 13:37:20.385	1552	\N	\N	Marjatta Mäkinen	laukausryhma_aurora	\N	QKdt4FeWf0
2024-04-26 13:37:20.397	1553	\N	\N	Ilmari Järvinen	laukausryhma_aurora	\N	aEJXsYEwY5
2024-04-26 13:37:20.41	1554	\N	\N	Johannes Hämäläinen	laukausryhma_aurora	\N	h6bIijEnBv
2024-04-26 13:37:20.421	1555	\N	\N	Maria Mäkelä	laukausryhma_aurora	\N	1AFe2L3kMX
2024-04-26 13:37:20.433	1556	\N	\N	Liisa Juustila	laukausryhma_aurora	\N	HF0Holu6QL
2024-04-26 13:37:20.444	1557	\N	\N	Juhani Kumpulainen	laukausryhma_aurora	\N	yJt4r27lkV
2024-04-26 13:37:20.456	1558	\N	\N	Helena Juustila	ampumataito	\N	ajqwTiT15v
2024-04-26 13:37:20.469	1559	\N	\N	Anna Holappa	ampumataito	\N	HERqiIqGLk
2024-04-26 13:37:20.481	1560	\N	\N	Maria Ollakka	ampumataito	\N	iU9qe9qjNs
2024-04-26 13:37:20.493	1561	\N	\N	Juhani Heikkinen	ampumataito	\N	WGyLW5AwwY
2024-04-26 13:37:20.503	1562	\N	\N	Tapani Määttä	ampumataito	\N	GzVVPOJMPl
2024-04-26 13:37:20.515	1563	\N	\N	Olavi Hämäläinen	ampumataito	\N	5h7V1BIeBU
2024-04-26 13:37:20.529	1564	\N	\N	Maria Mäkinen	ampumataito	\N	LwFImUu50e
2024-04-26 13:37:20.54	1565	\N	\N	Maria Nieminen	ampumataito	\N	WqF3R4PBAk
2024-04-26 13:37:20.553	1566	\N	\N	Matti Hämäläinen	ampumataito	\N	BUuIXRxPDl
2024-04-26 13:37:20.563	1567	\N	\N	Juhani Koskinen	ampumataito	\N	RQcs6zYMoL
2024-04-26 13:37:20.575	1568	\N	\N	Maria Kelanti	ampumataito	\N	m3mgnpNE7O
2024-04-26 13:37:20.588	1569	\N	\N	Tapio Lehtinen	poliisiseura	\N	OdyebdAyKW
2024-04-26 13:37:20.6	1570	\N	\N	Liisa Määttä	poliisiseura	\N	4CxAyvE2vH
2024-04-26 13:37:20.612	1571	\N	\N	Ilmari Komulainen	poliisiseura	\N	E5IWuXcS1S
2024-04-26 13:37:20.623	1572	\N	\N	Marjatta Laine	koiraseura	\N	dz1w8IaCWT
2024-04-26 13:37:20.634	1573	\N	\N	Tapani Kelanti	koiraseura	\N	hd2U1Bh2WL
2024-04-26 13:37:20.647	1574	\N	\N	Juhani Heikkinen	koiraseura	\N	HHyCfMU7A8
2024-04-26 13:37:20.659	1575	\N	\N	Anna Koskinen	koiraseura	\N	AXjC5kjtkc
2024-04-26 13:37:20.67	1576	\N	\N	Tapio Korhonen	koiraseura	\N	MfqWPY31GN
2024-04-26 13:37:20.681	1577	\N	\N	Kaarina Heikkinen	koiraseura	\N	K6Hs0UiGJ9
2024-04-26 13:37:20.693	1578	\N	\N	Antero Komulainen	koiraseura	\N	Hnk90n74PL
2024-04-26 13:37:20.705	1579	\N	\N	Maria Mäkelä	hammaspeikkoseura	\N	IzospRD2sQ
2024-04-26 13:37:20.717	1580	\N	\N	Matti Virtanen	hammaspeikkoseura	\N	BQPyTc4Epr
2024-04-26 13:37:20.729	1581	\N	\N	Tapani Hämäläinen	hammaspeikkoseura	\N	kSEafO8Be5
2024-04-26 13:37:20.741	1582	\N	\N	Kaarina Lehtinen	hammaspeikkoseura	\N	qWMogc4S1J
2024-04-26 13:37:20.752	1583	\N	\N	Maria Holappa	hammaspeikkoseura	\N	NBSb0Dzdkr
2024-04-26 13:37:20.764	1584	\N	\N	Antero Koskinen	hammaspeikkoseura	\N	x9uTnRwZUy
2024-04-26 13:37:20.777	1585	\N	\N	Ilmari Mäkelä	hammaspeikkoseura	\N	6ZsuezsDFs
2024-04-26 13:37:20.789	1586	\N	\N	Juhani Järvinen	hammaspeikkoseura	\N	ynZFa3v2T8
2024-04-26 13:37:20.802	1587	\N	\N	Juhani Juustila	hammaspeikkoseura	\N	ZQ7EYqFLSl
2024-04-26 13:37:20.813	1588	\N	\N	Kalevi Heikkinen	hammaspeikkoseura	\N	HSjQc7Ffjg
2024-04-26 13:37:20.825	1589	\N	\N	Anna Holappa	hammaspeikkoseura	\N	4M6hEoyJ61
2024-04-26 13:37:20.837	1590	\N	\N	Johanna Kelanti	hammaspeikkoseura	\N	EEmYtpoGto
2024-04-26 13:37:20.849	1591	\N	\N	Matti Mäkinen	hammaspeikkoseura	\N	xtMt44DSoi
2024-04-26 13:37:20.861	1592	\N	\N	Liisa Holappa	hammaspeikkoseura	\N	rOpqkWiqVH
2024-04-26 13:37:20.873	1593	\N	\N	Ilmari Koskinen	hammaspeikkoseura	\N	Tugk9fxwQL
2024-04-26 13:37:20.886	1594	\N	\N	Juhani Nieminen	dog	\N	84ge6xFDJp
2024-04-26 13:37:20.899	1595	\N	\N	Kalevi Lehtinen	dog	\N	QVp9YKlapB
2024-04-26 13:37:20.911	1596	\N	\N	Juhani Virtanen	dog	\N	odncAJtwrY
2024-04-26 13:37:20.923	1597	\N	\N	Anneli Komulainen	dog	\N	yt6KJSbih4
2024-04-26 13:37:20.935	1598	\N	\N	Kalevi Järvinen	dog	\N	jm5dQdoHjJ
2024-04-26 13:37:20.947	1599	\N	\N	Maria Ollakka	dog	\N	HV7narOVhK
2024-04-26 13:37:20.959	1600	\N	\N	Johannes Nieminen	dog	\N	aykmp96gMx
2024-04-26 13:37:20.972	1601	\N	\N	Johannes Juustila	dog	\N	p3Oo0jwbF9
2024-04-26 13:37:20.984	1602	\N	\N	Antero Nieminen	dog	\N	4Mk8JsUyFv
2024-04-26 13:37:20.996	1603	\N	\N	Kaarina Määttä	dog	\N	opZUxr2onE
2024-04-26 13:37:21.01	1604	\N	\N	Juhani Määttä	dog	\N	V1ST86dAU4
2024-04-26 13:37:21.024	1605	\N	\N	Tapani Koskinen	dog	\N	XREiuOVs99
2024-04-26 13:37:21.037	1606	\N	\N	Antero Hämäläinen	dog	\N	jKKGolZINz
2024-04-26 13:37:21.052	1607	\N	\N	Tapio Korhonen	savu_seura	\N	8ogN7MXXiF
2024-04-26 13:37:21.065	1608	\N	\N	Kalevi Mäkelä	savu_seura	\N	eDdRfrpFLh
2024-04-26 13:37:21.082	1609	\N	\N	Anna Korhonen	savu_seura	\N	7TadA4iwRV
2024-04-26 13:37:21.095	1610	\N	\N	Antero Määttä	savu_seura	\N	sLQbclSNWe
2024-04-26 13:37:21.109	1611	\N	\N	Ilmari Järvinen	savu_seura	\N	KMj5WXuF0J
2024-04-26 13:37:21.121	1612	\N	\N	Kaarina Komulainen	savu_seura	\N	JiaStnNdei
2024-04-26 13:37:21.135	1613	\N	\N	Kaarina Lehtinen	savu_seura	\N	NWtwLT8Wik
2024-04-26 13:37:21.148	1614	\N	\N	Tapani Komulainen	omas	\N	x117PQuRru
2024-04-26 13:37:21.162	1615	\N	\N	Antero Laine	omas	\N	bBRordrIKg
2024-04-26 13:37:21.177	1616	\N	\N	Anneli Mäkinen	omas	\N	CS5irEHgO3
2024-04-26 13:37:21.19	1617	\N	\N	Olavi Mäkinen	omas	\N	2rPGG54jx5
2024-04-26 13:37:21.204	1618	\N	\N	Mikael Järvinen	omas	\N	aGLlThY1F4
2024-04-26 13:37:21.217	1619	\N	\N	Mikael Hämäläinen	omas	\N	NrzH6eFd60
2024-04-26 13:37:21.231	1620	\N	\N	Johannes Juustila	omas	\N	EQh8jphykh
2024-04-26 13:37:21.245	1621	\N	\N	Johannes Hämäläinen	pelleseura	\N	c6c5NWkg45
2024-04-26 13:37:21.262	1622	\N	\N	Kalevi Ollakka	pelleseura	\N	0yyCixvVzF
2024-04-26 13:37:21.276	1623	\N	\N	Matti Kelanti	pelleseura	\N	VhEmocU0yZ
2024-04-26 13:37:21.289	1624	\N	\N	Antero Määttä	pelleseura	\N	DIF8wypsBb
2024-04-26 13:37:21.304	1625	\N	\N	Matti Virtanen	pelleseura	\N	rDEDeR6Q3C
2024-04-26 13:37:21.317	1626	\N	\N	Tapani Heikkinen	pelleseura	\N	0bJhcGw40a
2024-04-26 13:37:21.332	1627	\N	\N	Anneli Juustila	pelleseura	\N	iqDVLQEP6V
2024-04-26 13:37:21.346	1628	\N	\N	Helena Komulainen	pelleseura	\N	irhqY6lWPY
2024-04-26 13:37:21.359	1629	\N	\N	Anna Kelanti	pelleseura	\N	4RbK2HNXBH
2024-04-26 13:37:21.373	1630	\N	\N	Liisa Ollakka	pelleseura	\N	sKx7d7YfP2
2024-04-26 13:37:21.388	1631	\N	\N	Mikael Juustila	pelleseura	\N	jMBn1f5OnK
2024-04-26 13:37:21.403	1632	\N	\N	Tapani Korhonen	pelleseura	\N	RUyz28w96e
2024-04-26 13:37:21.416	1633	\N	\N	Tapio Holappa	pelleseura	\N	prJvCAVYg1
2024-04-26 13:37:21.431	1634	\N	\N	Anneli Ollakka	yung_tallent	\N	VwYv9OvAR7
2024-04-26 13:37:21.446	1635	\N	\N	Tapio Määttä	yung_tallent	\N	P10eDgFcX3
2024-04-26 13:37:21.458	1636	\N	\N	Johannes Mäkinen	yung_tallent	\N	RXpiNNHdTV
2024-04-26 13:37:21.471	1637	\N	\N	Kaarina Kelanti	yung_tallent	\N	CSVEf9oPSL
2024-04-26 13:37:21.485	1638	\N	\N	Tapio Laine	yung_tallent	\N	wGd2DZl5M1
2024-04-26 13:37:21.499	1639	\N	\N	Kalevi Virtanen	yung_tallent	\N	S6nSOE7wT7
2024-04-26 13:37:21.513	1640	\N	\N	Antero Koskinen	yung_tallent	\N	IGDNpyLEg8
2024-04-26 13:37:21.526	1641	\N	\N	Johannes Mäkinen	aseharrastajien_yhtenaisyys	\N	XhiObj9yOa
2024-04-26 13:37:21.539	1642	\N	\N	Liisa Kumpulainen	aseharrastajien_yhtenaisyys	\N	wDPRZ2Fu0O
2024-04-26 13:37:21.553	1643	\N	\N	Juhani Hämäläinen	aseharrastajien_yhtenaisyys	\N	LEDGEVRUN8
2024-04-26 13:37:21.567	1644	\N	\N	Anna Nieminen	aseharrastajien_yhtenaisyys	\N	ytVXmp6vaK
2024-04-26 13:37:21.58	1645	\N	\N	Johannes Virtanen	aseharrastajien_yhtenaisyys	\N	NnSfNLrKEe
2024-04-26 13:37:21.592	1646	\N	\N	Matti Hämäläinen	aseharrastajien_yhtenaisyys	\N	liKzjl4sxr
2024-04-26 13:37:21.61	1647	\N	\N	Marjatta Järvinen	aseharrastajien_yhtenaisyys	\N	cJlRw2Q64Q
2024-04-26 13:37:21.627	1648	\N	\N	Mikael Mäkelä	aseharrastajien_yhtenaisyys	\N	dTDZSdvSsa
2024-04-26 13:37:21.642	1649	\N	\N	Tapani Holappa	tahtaysmestarit	\N	dHnQx5RrlE
2024-04-26 13:37:21.655	1650	\N	\N	Marjatta Hämäläinen	tahtaysmestarit	\N	zAvvQbjJum
2024-04-26 13:37:21.67	1651	\N	\N	Tapio Nieminen	tahtaysmestarit	\N	VgtHhzm88E
2024-04-26 13:37:21.681	1652	\N	\N	Olavi Koskinen	tahtaysmestarit	\N	NTDYdznjYf
2024-04-26 13:37:21.694	1653	\N	\N	Antero Juustila	tahtaysmestarit	\N	gsjbbY0MOq
2024-04-26 13:37:21.711	1654	\N	\N	Johanna Heikkinen	tahtaysmestarit	\N	QM8Zt4cXrz
2024-04-26 13:37:21.727	1655	\N	\N	Tapani Kumpulainen	tahtaysmestarit	\N	gX3qQ7IsOb
2024-04-26 13:37:21.744	1656	\N	\N	Juhani Määttä	tahtaysmestarit	\N	ntFj3ehZXh
2024-04-26 13:37:21.759	1657	\N	\N	Kalevi Järvinen	tahtaysmestarit	\N	L134qqPnAQ
2024-04-26 13:37:21.771	1658	\N	\N	Tapio Järvinen	tahtaysmestarit	\N	vpxCluySjt
2024-04-26 13:37:21.783	1659	\N	\N	Johannes Virtanen	tahtaysmestarit	\N	nscahDeDrm
2024-04-26 13:37:21.795	1660	\N	\N	Helena Nieminen	tahtaysmestarit	\N	glNwLJAhqG
2024-04-26 13:37:21.807	1661	\N	\N	Juhani Koskinen	tahtaysmestarit	\N	EF3mNPThs4
2024-04-26 13:37:21.819	1662	\N	\N	Johanna Holappa	laukausryhma_aurora	\N	N7AuPjwKbi
2024-04-26 13:37:21.832	1663	\N	\N	Kaarina Koskinen	laukausryhma_aurora	\N	78jybRTjlS
2024-04-26 13:37:21.843	1664	\N	\N	Mikael Hämäläinen	laukausryhma_aurora	\N	hT5uKtLw0t
2024-04-26 13:37:21.855	1665	\N	\N	Johannes Holappa	laukausryhma_aurora	\N	DYajLPNRjO
2024-04-26 13:37:21.868	1666	\N	\N	Ilmari Juustila	laukausryhma_aurora	\N	pivZLfIohJ
2024-04-26 13:37:21.881	1667	\N	\N	Anneli Komulainen	laukausryhma_aurora	\N	yuX3cBixEt
2024-04-26 13:37:21.894	1668	\N	\N	Anna Kumpulainen	laukausryhma_aurora	\N	ZROW3n2Sc6
2024-04-26 13:37:21.906	1669	\N	\N	Helena Virtanen	ampumataito	\N	661jVUTdOW
2024-04-26 13:37:21.919	1670	\N	\N	Antero Holappa	ampumataito	\N	dJ1UjyHus8
2024-04-26 13:37:21.931	1671	\N	\N	Kaarina Komulainen	ampumataito	\N	HxKNFPgGmS
2024-04-26 13:37:21.943	1672	\N	\N	Johanna Komulainen	ampumataito	\N	YZugo6vFNJ
2024-04-26 13:37:21.955	1673	\N	\N	Olavi Määttä	ampumataito	\N	vWgMou4R04
2024-04-26 13:37:21.966	1674	\N	\N	Johannes Komulainen	ampumataito	\N	bf6p9vzq3e
2024-04-26 13:37:21.978	1675	\N	\N	Marjatta Laine	ampumataito	\N	wuPABbiTP3
2024-04-26 13:37:21.989	1676	\N	\N	Ilmari Kelanti	ampumataito	\N	TUAGvRiiGu
2024-04-26 13:37:22.002	1677	\N	\N	Mikael Virtanen	ampumataito	\N	SSpFcMJMmG
2024-04-26 13:37:22.013	1678	\N	\N	Ilmari Lehtinen	poliisiseura	\N	RaEX9K9bft
2024-04-26 13:37:22.025	1679	\N	\N	Antero Määttä	poliisiseura	\N	f1unmGKdlY
2024-04-26 13:37:22.036	1680	\N	\N	Marjatta Ollakka	poliisiseura	\N	WsNdAjHsfy
2024-04-26 13:37:22.048	1681	\N	\N	Mikael Heikkinen	poliisiseura	\N	T5JhfNzYDt
2024-04-26 13:37:22.063	1682	\N	\N	Matti Mäkinen	poliisiseura	\N	UWMdKBDMXH
2024-04-26 13:37:22.075	1683	\N	\N	Mikael Holappa	poliisiseura	\N	xXlHaJzcPK
2024-04-26 13:37:22.087	1684	\N	\N	Maria Korhonen	poliisiseura	\N	adBbZ2JzHE
2024-04-26 13:37:22.099	1685	\N	\N	Mikael Koskinen	poliisiseura	\N	HKVe4PhIO7
2024-04-26 13:37:22.11	1686	\N	\N	Kaarina Holappa	koiraseura	\N	Tbwts8076C
2024-04-26 13:37:22.123	1687	\N	\N	Maria Heikkinen	koiraseura	\N	uG2FbDlDXK
2024-04-26 13:37:22.134	1688	\N	\N	Maria Koskinen	koiraseura	\N	QvUbzJdWy5
2024-04-26 13:37:22.145	1689	\N	\N	Liisa Järvinen	koiraseura	\N	3F9F4osc0K
2024-04-26 13:37:22.156	1690	\N	\N	Kalevi Komulainen	koiraseura	\N	XyGK3OhmYC
2024-04-26 13:37:22.168	1691	\N	\N	Kaarina Holappa	koiraseura	\N	jpN2zqMmo1
2024-04-26 13:37:22.181	1692	\N	\N	Johanna Komulainen	koiraseura	\N	sLQw2faIdQ
2024-04-26 13:37:22.192	1693	\N	\N	Antero Järvinen	hammaspeikkoseura	\N	jm8ujSm4Zo
2024-04-26 13:37:22.204	1694	\N	\N	Kalevi Juustila	hammaspeikkoseura	\N	KEWpuV01na
2024-04-26 13:37:22.215	1695	\N	\N	Ilmari Nieminen	hammaspeikkoseura	\N	3T5lASWoy7
2024-04-26 13:37:22.227	1696	\N	\N	Tapani Koskinen	hammaspeikkoseura	\N	EqRq6ysNBk
2024-04-26 13:37:22.243	1697	\N	\N	Olavi Holappa	hammaspeikkoseura	\N	BAT5FQqGFb
2024-04-26 13:37:22.254	1698	\N	\N	Anna Mäkinen	hammaspeikkoseura	\N	EcaFVCTsSF
2024-04-26 13:37:22.266	1699	\N	\N	Antero Järvinen	hammaspeikkoseura	\N	aP6IePE6iU
2024-04-26 13:37:22.277	1700	\N	\N	Marjatta Korhonen	hammaspeikkoseura	\N	Mi2qJetPHy
2024-04-26 13:37:22.289	1701	\N	\N	Marjatta Holappa	hammaspeikkoseura	\N	RZ5xqW1P5b
2024-04-26 13:37:22.302	1702	\N	\N	Matti Holappa	hammaspeikkoseura	\N	WAasDPsxEK
2024-04-26 13:37:22.313	1703	\N	\N	Matti Korhonen	hammaspeikkoseura	\N	QK2j4VFScj
2024-04-26 13:37:22.324	1704	\N	\N	Marjatta Kumpulainen	dog	\N	X2jZorC4g1
2024-04-26 13:37:22.336	1705	\N	\N	Ilmari Järvinen	dog	\N	bpRDJV4b48
2024-04-26 13:37:22.349	1706	\N	\N	Mikael Nieminen	dog	\N	57iGvtqHef
2024-04-26 13:37:22.363	1707	\N	\N	Antero Järvinen	dog	\N	tZjPZERLJe
2024-04-26 13:37:22.375	1708	\N	\N	Antero Mäkelä	dog	\N	H8tBgMq43j
2024-04-26 13:37:22.386	1709	\N	\N	Johannes Mäkinen	dog	\N	8WhP156P0g
2024-04-26 13:37:22.398	1710	\N	\N	Liisa Juustila	dog	\N	5ddJ7o7mDG
2024-04-26 13:37:22.409	1711	\N	\N	Anneli Ollakka	dog	\N	geIXH8TXio
2024-04-26 13:37:22.421	1712	\N	\N	Matti Korhonen	savu_seura	\N	urcbweoDxw
2024-04-26 13:37:22.433	1713	\N	\N	Juhani Kelanti	savu_seura	\N	tftPvKYFYl
2024-04-26 13:37:22.446	1714	\N	\N	Anna Virtanen	savu_seura	\N	MpKrVfW1uB
2024-04-26 13:37:22.457	1715	\N	\N	Kaarina Lehtinen	savu_seura	\N	OQkAfJZdHE
2024-04-26 13:37:22.468	1716	\N	\N	Mikael Mäkelä	savu_seura	\N	RfQ3lrhdsp
2024-04-26 13:37:22.48	1717	\N	\N	Kalevi Kumpulainen	savu_seura	\N	dzPOAbeFk1
2024-04-26 13:37:22.492	1718	\N	\N	Liisa Järvinen	savu_seura	\N	a4yZklMbwl
2024-04-26 13:37:22.502	1719	\N	\N	Liisa Mäkelä	savu_seura	\N	FkBXtj9zBp
2024-04-26 13:37:22.514	1720	\N	\N	Liisa Määttä	savu_seura	\N	s2t9fVH0ek
2024-04-26 13:37:22.525	1721	\N	\N	Olavi Mäkelä	savu_seura	\N	rulDP3U9sb
2024-04-26 13:37:22.538	1722	\N	\N	Ilmari Mäkinen	savu_seura	\N	X86rJtpRhr
2024-04-26 13:37:22.551	1723	\N	\N	Marjatta Juustila	savu_seura	\N	giso491o1q
2024-04-26 13:37:22.562	1724	\N	\N	Kaarina Mäkelä	savu_seura	\N	T8n2GGjK6U
2024-04-26 13:37:22.573	1725	\N	\N	Matti Nieminen	savu_seura	\N	RRHJn3SVr3
2024-04-26 13:37:22.585	1726	\N	\N	Anneli Korhonen	savu_seura	\N	VL7H0wTD0P
2024-04-26 13:37:22.596	1727	\N	\N	Kalevi Kumpulainen	omas	\N	qEyxk4yomv
2024-04-26 13:37:22.608	1728	\N	\N	Liisa Holappa	omas	\N	Gz5InMhCaW
2024-04-26 13:37:22.62	1729	\N	\N	Antero Mäkinen	omas	\N	kvjogFZhHJ
2024-04-26 13:37:22.631	1730	\N	\N	Anna Holappa	pelleseura	\N	ASP9fNG1KK
2024-04-26 13:37:22.641	1731	\N	\N	Johanna Heikkinen	pelleseura	\N	WAlm9zjhJ1
2024-04-26 13:37:22.652	1732	\N	\N	Tapani Juustila	pelleseura	\N	RPYuAxSRaC
2024-04-26 13:37:22.663	1733	\N	\N	Marjatta Heikkinen	pelleseura	\N	wC6f6kU9kW
2024-04-26 13:37:22.675	1734	\N	\N	Maria Koskinen	pelleseura	\N	FXObMocMIO
2024-04-26 13:37:22.686	1735	\N	\N	Maria Juustila	pelleseura	\N	kGF5wGNkJW
2024-04-26 13:37:22.698	1736	\N	\N	Kalevi Heikkinen	pelleseura	\N	xwffr7yK23
2024-04-26 13:37:22.709	1737	\N	\N	Johanna Juustila	pelleseura	\N	wXz2w6sPaW
2024-04-26 13:37:22.72	1738	\N	\N	Anneli Mäkelä	yung_tallent	\N	JFCQtJB0h1
2024-04-26 13:37:22.732	1739	\N	\N	Maria Lehtinen	yung_tallent	\N	1kLpslPsFf
2024-04-26 13:37:22.743	1740	\N	\N	Mikael Virtanen	yung_tallent	\N	WIGFhHrR9q
2024-04-26 13:37:22.754	1741	\N	\N	Antero Laine	yung_tallent	\N	hbDOP5Zoud
2024-04-26 13:37:22.764	1742	\N	\N	Anneli Nieminen	yung_tallent	\N	gSQdE4GUE2
2024-04-26 13:37:22.776	1743	\N	\N	Kalevi Nieminen	yung_tallent	\N	GQ9uK2MEls
2024-04-26 13:37:22.789	1744	\N	\N	Johanna Mäkinen	yung_tallent	\N	iBFM8Khe7S
2024-04-26 13:37:22.801	1745	\N	\N	Marjatta Komulainen	yung_tallent	\N	G0Kzw0pi0n
2024-04-26 13:37:22.812	1746	\N	\N	Matti Lehtinen	yung_tallent	\N	5UZpUZuaDf
2024-04-26 13:37:22.823	1747	\N	\N	Mikael Juustila	yung_tallent	\N	CUn3ZMMj7U
2024-04-26 13:37:22.835	1748	\N	\N	Kaarina Määttä	yung_tallent	\N	98FX8OGbjb
2024-04-26 13:37:22.847	1749	\N	\N	Juhani Ollakka	aseharrastajien_yhtenaisyys	\N	9PXwxeAArO
2024-04-26 13:37:22.86	1750	\N	\N	Juhani Määttä	aseharrastajien_yhtenaisyys	\N	9AHLp9lrSZ
2024-04-26 13:37:22.872	1751	\N	\N	Anna Hämäläinen	aseharrastajien_yhtenaisyys	\N	4QgjYhZs8O
2024-04-26 13:37:22.884	1752	\N	\N	Maria Koskinen	aseharrastajien_yhtenaisyys	\N	cAhgPcGMxz
2024-04-26 13:37:22.895	1753	\N	\N	Anneli Korhonen	aseharrastajien_yhtenaisyys	\N	DKcCtoUXog
2024-04-26 13:37:22.908	1754	\N	\N	Johanna Komulainen	aseharrastajien_yhtenaisyys	\N	Yn28uLjrM4
2024-04-26 13:37:22.921	1755	\N	\N	Anneli Hämäläinen	aseharrastajien_yhtenaisyys	\N	H7P96osTKV
2024-04-26 13:37:22.932	1756	\N	\N	Johanna Juustila	aseharrastajien_yhtenaisyys	\N	o7zdEdTsNl
2024-04-26 13:37:22.944	1757	\N	\N	Tapio Virtanen	aseharrastajien_yhtenaisyys	\N	nJpkVlBDzg
2024-04-26 13:37:22.956	1758	\N	\N	Tapani Holappa	aseharrastajien_yhtenaisyys	\N	w1t1tQbFtm
2024-04-26 13:37:22.968	1759	\N	\N	Tapio Lehtinen	aseharrastajien_yhtenaisyys	\N	yXySvx86vR
2024-04-26 13:37:22.981	1760	\N	\N	Mikael Määttä	aseharrastajien_yhtenaisyys	\N	c6mqhjio6T
2024-04-26 13:37:22.994	1761	\N	\N	Matti Heikkinen	aseharrastajien_yhtenaisyys	\N	2YTqhyueQj
2024-04-26 13:37:23.006	1762	\N	\N	Kalevi Kumpulainen	aseharrastajien_yhtenaisyys	\N	VxHCpTT7vW
2024-04-26 13:37:23.017	1763	\N	\N	Helena Ollakka	tahtaysmestarit	\N	h5Q5zNehqg
2024-04-26 13:37:23.029	1764	\N	\N	Matti Mäkinen	tahtaysmestarit	\N	J5bvpoKRh7
2024-04-26 13:37:23.043	1765	\N	\N	Tapani Korhonen	tahtaysmestarit	\N	VMyt7XEgBJ
2024-04-26 13:37:23.054	1766	\N	\N	Tapani Virtanen	tahtaysmestarit	\N	80NuVaVT1v
2024-04-26 13:37:23.065	1767	\N	\N	Johannes Juustila	tahtaysmestarit	\N	GPlgCUCYHT
2024-04-26 13:37:23.078	1768	\N	\N	Johanna Komulainen	laukausryhma_aurora	\N	hIoZP4vcu8
2024-04-26 13:37:23.092	1769	\N	\N	Liisa Lehtinen	laukausryhma_aurora	\N	6wogkWfsol
2024-04-26 13:37:23.107	1770	\N	\N	Johannes Heikkinen	laukausryhma_aurora	\N	kDNl9a8tXU
2024-04-26 13:37:23.119	1771	\N	\N	Mikael Kelanti	laukausryhma_aurora	\N	LUpaohcSEB
2024-04-26 13:37:23.13	1772	\N	\N	Helena Heikkinen	laukausryhma_aurora	\N	KFWK8HEi2C
2024-04-26 13:37:23.142	1773	\N	\N	Johanna Komulainen	laukausryhma_aurora	\N	WxFb2Hezq3
2024-04-26 13:37:23.155	1774	\N	\N	Liisa Korhonen	laukausryhma_aurora	\N	pSYEuowa1I
2024-04-26 13:37:23.168	1775	\N	\N	Liisa Laine	laukausryhma_aurora	\N	5GJu2lbAfx
2024-04-26 13:37:23.18	1776	\N	\N	Marjatta Virtanen	laukausryhma_aurora	\N	3lkZ87KLr7
2024-04-26 13:37:23.192	1777	\N	\N	Antero Komulainen	laukausryhma_aurora	\N	QLLUB5iOUd
2024-04-26 13:37:23.205	1778	\N	\N	Mikael Juustila	laukausryhma_aurora	\N	v8T7XhftlZ
2024-04-26 13:37:23.218	1779	\N	\N	Tapio Korhonen	laukausryhma_aurora	\N	s4gDlHWSLy
2024-04-26 13:37:23.232	1780	\N	\N	Johannes Virtanen	laukausryhma_aurora	\N	Sz0lSmfs9X
2024-04-26 13:37:23.245	1781	\N	\N	Anna Nieminen	laukausryhma_aurora	\N	MtT9CT10iA
2024-04-26 13:37:23.257	1782	\N	\N	Ilmari Nieminen	ampumataito	\N	ZTzA1Q6PrR
2024-04-26 13:37:23.27	1783	\N	\N	Kaarina Korhonen	ampumataito	\N	WO2e4kjVRt
2024-04-26 13:37:23.283	1784	\N	\N	Helena Mäkelä	ampumataito	\N	umNiyIhrOG
2024-04-26 13:37:23.294	1785	\N	\N	Mikael Hämäläinen	ampumataito	\N	YXeJLRtD3R
2024-04-26 13:37:23.307	1786	\N	\N	Matti Laine	ampumataito	\N	I2wTzsd3Oi
2024-04-26 13:37:23.318	1787	\N	\N	Mikael Juustila	poliisiseura	\N	fe8ik2ll9E
2024-04-26 13:37:23.33	1788	\N	\N	Olavi Heikkinen	poliisiseura	\N	jij6VnTOBb
2024-04-26 13:37:23.342	1789	\N	\N	Johanna Holappa	poliisiseura	\N	4j1gHg5jQZ
2024-04-26 13:37:23.356	1790	\N	\N	Kalevi Kelanti	koiraseura	\N	bcD3gzCCsa
2024-04-26 13:37:23.369	1791	\N	\N	Kaarina Järvinen	koiraseura	\N	TPjN7yfhrA
2024-04-26 13:37:23.382	1792	\N	\N	Ilmari Hämäläinen	koiraseura	\N	3A4JJSvet6
2024-04-26 13:37:23.403	1793	\N	\N	Maria Hämäläinen	koiraseura	\N	LVXH8YLo9z
2024-04-26 13:37:23.423	1794	\N	\N	Maria Mäkelä	koiraseura	\N	HZkLSL3YfF
2024-04-26 13:37:23.443	1795	\N	\N	Anna Juustila	hammaspeikkoseura	\N	HOXIb4PJXk
2024-04-26 13:37:23.459	1796	\N	\N	Helena Määttä	hammaspeikkoseura	\N	5jyQUhi6K0
2024-04-26 13:37:23.476	1797	\N	\N	Kalevi Korhonen	hammaspeikkoseura	\N	zO3bkRXpww
2024-04-26 13:37:23.49	1798	\N	\N	Antero Lehtinen	hammaspeikkoseura	\N	J01ePPg8x4
2024-04-26 13:37:23.505	1799	\N	\N	Antero Heikkinen	hammaspeikkoseura	\N	uvEzfBPhyF
2024-04-26 13:37:23.519	1800	\N	\N	Johannes Lehtinen	hammaspeikkoseura	\N	QaMc6FdeHm
2024-04-26 13:37:23.534	1801	\N	\N	Anneli Mäkinen	hammaspeikkoseura	\N	klnY5bDXdG
2024-04-26 13:37:23.547	1802	\N	\N	Helena Heikkinen	hammaspeikkoseura	\N	bh0WnrBlbS
2024-04-26 13:37:23.559	1803	\N	\N	Mikael Korhonen	hammaspeikkoseura	\N	wNoMNtoKmE
2024-04-26 13:37:23.572	1804	\N	\N	Tapio Koskinen	hammaspeikkoseura	\N	zLwAIhfp4f
2024-04-26 13:37:23.584	1805	\N	\N	Antero Hämäläinen	hammaspeikkoseura	\N	d0TniWJLer
2024-04-26 13:37:23.598	1806	\N	\N	Matti Hämäläinen	dog	\N	I7sCFc2gyD
2024-04-26 13:37:23.61	1807	\N	\N	Marjatta Hämäläinen	dog	\N	hgwyAzPVQc
2024-04-26 13:37:23.622	1808	\N	\N	Johannes Holappa	dog	\N	jfldtHeLwt
2024-04-26 13:37:23.634	1809	\N	\N	Juhani Holappa	dog	\N	dnszn41R6f
2024-04-26 13:37:23.648	1810	\N	\N	Anna Holappa	savu_seura	\N	81FWAi9n9S
2024-04-26 13:37:23.661	1811	\N	\N	Kaarina Laine	savu_seura	\N	NX8pZBHKfC
2024-04-26 13:37:23.672	1812	\N	\N	Antero Nieminen	savu_seura	\N	iz9RdQSYU3
2024-04-26 13:37:23.685	1813	\N	\N	Kalevi Komulainen	savu_seura	\N	o6Pq6Dkbhf
2024-04-26 13:37:23.696	1814	\N	\N	Kalevi Juustila	savu_seura	\N	7Z6Y0onzOj
2024-04-26 13:37:23.71	1815	\N	\N	Tapani Holappa	savu_seura	\N	HKae75ukiL
2024-04-26 13:37:23.721	1816	\N	\N	Johanna Järvinen	savu_seura	\N	CPDLnVdwb0
2024-04-26 13:37:23.734	1817	\N	\N	Anna Määttä	savu_seura	\N	RhKFzmLhWX
2024-04-26 13:37:23.745	1818	\N	\N	Juhani Kelanti	savu_seura	\N	gCztVplGKC
2024-04-26 13:37:23.757	1819	\N	\N	Anna Järvinen	savu_seura	\N	52FZPdVFWQ
2024-04-26 13:37:23.769	1820	\N	\N	Kaarina Hämäläinen	savu_seura	\N	GTxNf5zTjI
2024-04-26 13:37:23.784	1821	\N	\N	Matti Kumpulainen	savu_seura	\N	XeE3XS4UIl
2024-04-26 13:37:23.795	1822	\N	\N	Matti Komulainen	omas	\N	ofYVOulZXN
2024-04-26 13:37:23.806	1823	\N	\N	Ilmari Komulainen	omas	\N	9LtZkO6Rm5
2024-04-26 13:37:23.818	1824	\N	\N	Kalevi Hämäläinen	omas	\N	Cpr74c5e5x
2024-04-26 13:37:23.831	1825	\N	\N	Juhani Nieminen	omas	\N	bxp1In7IfQ
2024-04-26 13:37:23.843	1826	\N	\N	Anneli Määttä	omas	\N	ABY2h8pq1f
2024-04-26 13:37:23.856	1827	\N	\N	Matti Laine	pelleseura	\N	AiMWMvyVyF
2024-04-26 13:37:23.868	1828	\N	\N	Maria Järvinen	pelleseura	\N	2SjUxevoCb
2024-04-26 13:37:23.88	1829	\N	\N	Anneli Hämäläinen	pelleseura	\N	SXB5XDkqfx
2024-04-26 13:37:23.893	1830	\N	\N	Johannes Lehtinen	pelleseura	\N	MK2I8pHmYY
2024-04-26 13:37:23.906	1831	\N	\N	Mikael Koskinen	pelleseura	\N	sSGKqeRSoY
2024-04-26 13:37:23.917	1832	\N	\N	Maria Määttä	pelleseura	\N	m5ms9rGQ2h
2024-04-26 13:37:23.929	1833	\N	\N	Kaarina Heikkinen	pelleseura	\N	q9BE5qB9S7
2024-04-26 13:37:23.941	1834	\N	\N	Marjatta Virtanen	pelleseura	\N	mimJBZCzlq
2024-04-26 13:37:23.954	1835	\N	\N	Olavi Lehtinen	yung_tallent	\N	9O5gD0KlbK
2024-04-26 13:37:23.967	1836	\N	\N	Mikael Mäkelä	yung_tallent	\N	UosgLzkfSQ
2024-04-26 13:37:23.979	1837	\N	\N	Olavi Määttä	yung_tallent	\N	MokOgkXcWC
2024-04-26 13:37:23.991	1838	\N	\N	Matti Järvinen	yung_tallent	\N	SJWsdO55gT
2024-04-26 13:37:24.003	1839	\N	\N	Johanna Mäkelä	yung_tallent	\N	wLGJrdcOA4
2024-04-26 13:37:24.016	1840	\N	\N	Juhani Virtanen	yung_tallent	\N	Stg0DELOFs
2024-04-26 13:37:24.027	1841	\N	\N	Olavi Laine	yung_tallent	\N	kGcAmtt6by
2024-04-26 13:37:24.038	1842	\N	\N	Matti Järvinen	yung_tallent	\N	TCn9xqNw7H
2024-04-26 13:37:24.05	1843	\N	\N	Anna Komulainen	yung_tallent	\N	CMVqElZrn5
2024-04-26 13:37:24.062	1844	\N	\N	Anneli Lehtinen	yung_tallent	\N	JFkFuTmDQ5
2024-04-26 13:37:24.073	1845	\N	\N	Mikael Koskinen	aseharrastajien_yhtenaisyys	\N	wWgh2Hndf0
2024-04-26 13:37:24.086	1846	\N	\N	Johannes Nieminen	aseharrastajien_yhtenaisyys	\N	n7KcOYuMhR
2024-04-26 13:37:24.098	1847	\N	\N	Marjatta Lehtinen	aseharrastajien_yhtenaisyys	\N	R7aH3zGpgV
2024-04-26 13:37:24.11	1848	\N	\N	Anneli Juustila	aseharrastajien_yhtenaisyys	\N	ZbGrOWPcBc
2024-04-26 13:37:24.121	1849	\N	\N	Kalevi Mäkelä	aseharrastajien_yhtenaisyys	\N	0Y3bkicBU6
2024-04-26 13:37:24.132	1850	\N	\N	Helena Ollakka	aseharrastajien_yhtenaisyys	\N	Zs0BD7aUrF
2024-04-26 13:37:24.144	1851	\N	\N	Kaarina Määttä	aseharrastajien_yhtenaisyys	\N	jh1yXwwhl6
2024-04-26 13:37:24.156	1852	\N	\N	Tapani Kumpulainen	tahtaysmestarit	\N	TTXquaGtgu
2024-04-26 13:37:24.167	1853	\N	\N	Liisa Koskinen	tahtaysmestarit	\N	CSjM4nA63y
2024-04-26 13:37:24.179	1854	\N	\N	Ilmari Mäkelä	tahtaysmestarit	\N	sqdfcXjJw4
2024-04-26 13:37:24.191	1855	\N	\N	Matti Mäkelä	tahtaysmestarit	\N	zFSgL2v396
2024-04-26 13:37:24.205	1856	\N	\N	Johannes Laine	tahtaysmestarit	\N	9662n1Hr5F
2024-04-26 13:37:24.216	1857	\N	\N	Kaarina Komulainen	tahtaysmestarit	\N	t2gseOwkzT
2024-04-26 13:37:24.227	1858	\N	\N	Kaarina Virtanen	tahtaysmestarit	\N	gyJNjbwIfu
2024-04-26 13:37:24.239	1859	\N	\N	Anneli Virtanen	tahtaysmestarit	\N	8qe0QnMzBw
2024-04-26 13:37:24.25	1860	\N	\N	Antero Mäkinen	tahtaysmestarit	\N	seuaQkeZ0I
2024-04-26 13:37:24.263	1861	\N	\N	Juhani Määttä	tahtaysmestarit	\N	EVPByHZnDb
2024-04-26 13:37:24.276	1862	\N	\N	Tapani Komulainen	tahtaysmestarit	\N	eWgNKlYyQu
2024-04-26 13:37:24.287	1863	\N	\N	Antero Kelanti	laukausryhma_aurora	\N	P1RtOo8IYK
2024-04-26 13:37:24.298	1864	\N	\N	Olavi Korhonen	laukausryhma_aurora	\N	8GJoet79jN
2024-04-26 13:37:24.31	1865	\N	\N	Maria Kelanti	laukausryhma_aurora	\N	7dR68GAqUe
2024-04-26 13:37:24.321	1866	\N	\N	Mikael Kelanti	laukausryhma_aurora	\N	A5KW2ng1Im
2024-04-26 13:37:24.335	1867	\N	\N	Liisa Hämäläinen	laukausryhma_aurora	\N	6mrt6vdA54
2024-04-26 13:37:24.346	1868	\N	\N	Johanna Lehtinen	laukausryhma_aurora	\N	EgpNzVdz4B
2024-04-26 13:37:24.357	1869	\N	\N	Marjatta Koskinen	laukausryhma_aurora	\N	tkVe10qYOZ
2024-04-26 13:37:24.368	1870	\N	\N	Antero Järvinen	laukausryhma_aurora	\N	48jzvuvC8j
2024-04-26 13:37:24.38	1871	\N	\N	Kalevi Mäkelä	laukausryhma_aurora	\N	p8lylammhc
2024-04-26 13:37:24.393	1872	\N	\N	Kaarina Korhonen	laukausryhma_aurora	\N	gfq5N5ayZs
2024-04-26 13:37:24.405	1873	\N	\N	Anna Kumpulainen	ampumataito	\N	kpH4NSJMuJ
2024-04-26 13:37:24.417	1874	\N	\N	Johannes Mäkinen	ampumataito	\N	0WT7EX9pV8
2024-04-26 13:37:24.429	1875	\N	\N	Kalevi Kumpulainen	ampumataito	\N	BfodvhQZbx
2024-04-26 13:37:24.44	1876	\N	\N	Maria Järvinen	ampumataito	\N	pWE83Wj7W8
2024-04-26 13:37:24.454	1877	\N	\N	Johannes Mäkelä	poliisiseura	\N	WfmozTUfHV
2024-04-26 13:37:24.465	1878	\N	\N	Johannes Ollakka	poliisiseura	\N	RuU1oy9O6S
2024-04-26 13:37:24.476	1879	\N	\N	Anna Mäkelä	poliisiseura	\N	HH4WX92I6Q
2024-04-26 13:37:24.487	1880	\N	\N	Anneli Nieminen	poliisiseura	\N	eFGPKfmc9A
2024-04-26 13:37:24.498	1881	\N	\N	Kaarina Komulainen	poliisiseura	\N	77iQ4G8Ex2
2024-04-26 13:37:24.512	1882	\N	\N	Juhani Lehtinen	poliisiseura	\N	nnzsS9ZneA
2024-04-26 13:37:24.523	1883	\N	\N	Helena Juustila	poliisiseura	\N	xNMiLJxMEf
2024-04-26 13:37:24.534	1884	\N	\N	Kaarina Komulainen	poliisiseura	\N	4rgnpyZwHh
2024-04-26 13:37:24.547	1885	\N	\N	Matti Korhonen	poliisiseura	\N	3z5VUJDaXf
2024-04-26 13:37:24.558	1886	\N	\N	Kaarina Ollakka	poliisiseura	\N	rMBPcky0Ec
2024-04-26 13:37:24.569	1887	\N	\N	Matti Nieminen	koiraseura	\N	R3qqWq4CFB
2024-04-26 13:37:24.582	1888	\N	\N	Kaarina Heikkinen	koiraseura	\N	h5jWR9Wpts
2024-04-26 13:37:24.593	1889	\N	\N	Juhani Järvinen	koiraseura	\N	HjTo2e3xYH
2024-04-26 13:37:24.604	1890	\N	\N	Marjatta Järvinen	koiraseura	\N	NuH2PKHfPB
2024-04-26 13:37:24.615	1891	\N	\N	Tapio Juustila	koiraseura	\N	uO1REMd9Th
2024-04-26 13:37:24.626	1892	\N	\N	Matti Mäkelä	koiraseura	\N	WiFsZMNqi0
2024-04-26 13:37:24.636	1893	\N	\N	Anna Komulainen	koiraseura	\N	D9X4HI6bsW
2024-04-26 13:37:24.646	1894	\N	\N	Juhani Virtanen	koiraseura	\N	Uwn0GlhqUB
2024-04-26 13:37:24.657	1895	\N	\N	Johannes Hämäläinen	koiraseura	\N	1FNZs81ZOf
2024-04-26 13:37:24.668	1896	\N	\N	Tapio Määttä	hammaspeikkoseura	\N	cbBU8YAwaP
2024-04-26 13:37:24.68	1897	\N	\N	Juhani Hämäläinen	hammaspeikkoseura	\N	vVgKAYzRxG
2024-04-26 13:37:24.692	1898	\N	\N	Tapani Heikkinen	hammaspeikkoseura	\N	igdvNHcukz
2024-04-26 13:37:24.703	1899	\N	\N	Mikael Laine	hammaspeikkoseura	\N	QJowC9PfTl
2024-04-26 13:37:24.714	1900	\N	\N	Antero Kumpulainen	hammaspeikkoseura	\N	XQiPI6iNxC
2024-04-26 13:37:24.724	1901	\N	\N	Mikael Holappa	hammaspeikkoseura	\N	LSy2Cw6QFz
2024-04-26 13:37:24.737	1902	\N	\N	Johanna Hämäläinen	hammaspeikkoseura	\N	wWgxriLwYt
2024-04-26 13:37:24.75	1903	\N	\N	Tapani Mäkinen	hammaspeikkoseura	\N	OAKZpG0WjJ
2024-04-26 13:37:24.761	1904	\N	\N	Ilmari Nieminen	hammaspeikkoseura	\N	jTdf8ZRcA8
2024-04-26 13:37:24.772	1905	\N	\N	Juhani Koskinen	hammaspeikkoseura	\N	T479rYujH2
2024-04-26 13:37:24.783	1906	\N	\N	Olavi Koskinen	hammaspeikkoseura	\N	Nvxij5G6tl
2024-04-26 13:37:24.796	1907	\N	\N	Johannes Kelanti	hammaspeikkoseura	\N	zWrhm35Z9Q
2024-04-26 13:37:24.809	1908	\N	\N	Maria Kumpulainen	dog	\N	2At1YWIHLk
2024-04-26 13:37:24.821	1909	\N	\N	Kaarina Korhonen	dog	\N	gqizbKCZOy
2024-04-26 13:37:24.832	1910	\N	\N	Johanna Mäkelä	dog	\N	SUyk397TUx
2024-04-26 13:37:24.843	1911	\N	\N	Tapani Hämäläinen	dog	\N	HZemm3Za5e
2024-04-26 13:37:24.855	1912	\N	\N	Maria Koskinen	savu_seura	\N	jcljrTlgJM
2024-04-26 13:37:24.867	1913	\N	\N	Tapani Mäkinen	savu_seura	\N	w75PZqZJ3M
2024-04-26 13:37:24.878	1914	\N	\N	Juhani Komulainen	savu_seura	\N	LKIZGx1bXW
2024-04-26 13:37:24.89	1915	\N	\N	Helena Määttä	savu_seura	\N	0UDV4LFkYt
2024-04-26 13:37:24.902	1916	\N	\N	Kalevi Korhonen	savu_seura	\N	wqdnqlkdOt
2024-04-26 13:37:24.923	1917	\N	\N	Liisa Ollakka	savu_seura	\N	JitLbMc6Py
2024-04-26 13:37:24.935	1918	\N	\N	Matti Holappa	savu_seura	\N	eMAj0cMFYS
2024-04-26 13:37:24.946	1919	\N	\N	Juhani Järvinen	savu_seura	\N	l5dHNBgp2b
2024-04-26 13:37:24.957	1920	\N	\N	Kaarina Virtanen	savu_seura	\N	UtmU0uj4ZY
2024-04-26 13:37:24.967	1921	\N	\N	Anna Kumpulainen	savu_seura	\N	N7uNxNsnip
2024-04-26 13:37:24.977	1922	\N	\N	Tapani Komulainen	savu_seura	\N	NQZCy0eypY
2024-04-26 13:37:24.99	1923	\N	\N	Marjatta Määttä	omas	\N	49j9ZeBnvG
2024-04-26 13:37:25.001	1924	\N	\N	Johannes Heikkinen	omas	\N	reV8mwSWOu
2024-04-26 13:37:25.012	1925	\N	\N	Tapani Virtanen	omas	\N	VXABIj1uwQ
2024-04-26 13:37:25.023	1926	\N	\N	Kalevi Laine	omas	\N	wKtxCalE8W
2024-04-26 13:37:25.034	1927	\N	\N	Kalevi Hämäläinen	omas	\N	bWVU5QFqrq
2024-04-26 13:37:25.045	1928	\N	\N	Anneli Koskinen	omas	\N	NvYS6hJqj5
2024-04-26 13:37:25.057	1929	\N	\N	Matti Hämäläinen	omas	\N	GFlgokCle9
2024-04-26 13:37:25.068	1930	\N	\N	Juhani Mäkelä	omas	\N	EbmUYXTq0i
2024-04-26 13:37:25.079	1931	\N	\N	Ilmari Juustila	pelleseura	\N	ukcBoXMUOR
2024-04-26 13:37:25.091	1932	\N	\N	Anna Kumpulainen	pelleseura	\N	0Z51q9RkTp
2024-04-26 13:37:25.101	1933	\N	\N	Anneli Nieminen	pelleseura	\N	hId4L00iNJ
2024-04-26 13:37:25.116	1934	\N	\N	Juhani Mäkelä	yung_tallent	\N	joCFhgmCq0
2024-04-26 13:37:25.127	1935	\N	\N	Liisa Määttä	yung_tallent	\N	MtIkWRu6Z2
2024-04-26 13:37:25.139	1936	\N	\N	Mikael Mäkelä	yung_tallent	\N	umpDEZedWw
2024-04-26 13:37:25.158	1937	\N	\N	Maria Lehtinen	yung_tallent	\N	N1huWKdL3m
2024-04-26 13:37:25.173	1938	\N	\N	Kaarina Määttä	yung_tallent	\N	PqtaPe31tA
2024-04-26 13:37:25.189	1939	\N	\N	Antero Lehtinen	yung_tallent	\N	cx478Ly2jk
2024-04-26 13:37:25.2	1940	\N	\N	Kaarina Mäkinen	yung_tallent	\N	5K2NVzRhMR
2024-04-26 13:37:25.215	1941	\N	\N	Johannes Koskinen	yung_tallent	\N	FDJ7JiOdjh
2024-04-26 13:37:25.226	1942	\N	\N	Liisa Juustila	yung_tallent	\N	jYeQHr15Ak
2024-04-26 13:37:25.239	1943	\N	\N	Matti Järvinen	yung_tallent	\N	bfI4r8Cffq
2024-04-26 13:37:25.25	1944	\N	\N	Liisa Juustila	yung_tallent	\N	uC1xExX0Rg
2024-04-26 13:37:25.262	1945	\N	\N	Antero Virtanen	yung_tallent	\N	LKg6KZdWqc
2024-04-26 13:37:25.273	1946	\N	\N	Ilmari Kumpulainen	yung_tallent	\N	83ZsxPtFnr
2024-04-26 13:37:25.286	1947	\N	\N	Kalevi Kumpulainen	aseharrastajien_yhtenaisyys	\N	kbVwtCyu6I
2024-04-26 13:37:25.298	1948	\N	\N	Kalevi Määttä	aseharrastajien_yhtenaisyys	\N	uJWeRY7Xsd
2024-04-26 13:37:25.311	1949	\N	\N	Liisa Koskinen	aseharrastajien_yhtenaisyys	\N	pOCo2o54WW
2024-04-26 13:37:25.323	1950	\N	\N	Kalevi Koskinen	tahtaysmestarit	\N	hIFtlAr3q8
2024-04-26 13:37:25.334	1951	\N	\N	Antero Heikkinen	tahtaysmestarit	\N	halxjpf24e
2024-04-26 13:37:25.345	1952	\N	\N	Johanna Mäkinen	tahtaysmestarit	\N	VnZbQysSYK
2024-04-26 13:37:25.358	1953	\N	\N	Matti Heikkinen	tahtaysmestarit	\N	Rnk4OO4zlH
2024-04-26 13:37:25.37	1954	\N	\N	Kaarina Juustila	laukausryhma_aurora	\N	tFib8M0HnC
2024-04-26 13:37:25.381	1955	\N	\N	Mikael Nieminen	laukausryhma_aurora	\N	O8PHbgyrEz
2024-04-26 13:37:25.392	1956	\N	\N	Antero Komulainen	laukausryhma_aurora	\N	T1kF2W99BY
2024-04-26 13:37:25.405	1957	\N	\N	Mikael Kumpulainen	laukausryhma_aurora	\N	uzGOIzLHdF
2024-04-26 13:37:25.42	1958	\N	\N	Tapani Ollakka	laukausryhma_aurora	\N	nwqjz9Ytth
2024-04-26 13:37:25.432	1959	\N	\N	Olavi Virtanen	laukausryhma_aurora	\N	xXFc36XZD2
2024-04-26 13:37:25.444	1960	\N	\N	Marjatta Järvinen	ampumataito	\N	z9SS8rHbRe
2024-04-26 13:37:25.457	1961	\N	\N	Olavi Koskinen	ampumataito	\N	j1MJS9UMBW
2024-04-26 13:37:25.47	1962	\N	\N	Helena Määttä	ampumataito	\N	O2gqMaa8Wh
2024-04-26 13:37:25.486	1963	\N	\N	Tapani Lehtinen	ampumataito	\N	Ap5sgi1jiw
2024-04-26 13:37:25.498	1964	\N	\N	Tapio Laine	ampumataito	\N	dyTs9piRwj
\.


--
-- Name: user__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user__id_seq', 1964, true);


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

