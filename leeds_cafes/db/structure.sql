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

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.restaurants (
    id bigint NOT NULL,
    cafe_name character varying,
    street_address character varying,
    post_code character varying,
    number_of_chairs integer,
    category character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.categories AS
 SELECT restaurants.category,
    sum(restaurants.number_of_chairs) AS "Total_Chairs",
    count(restaurants.id) AS "Total_Places",
    ( SELECT sum(restaurants_1.number_of_chairs) AS sum
           FROM public.restaurants restaurants_1) AS "Total_Chairs_in_Leeds",
    round(((((sum(restaurants.number_of_chairs))::numeric * 1.0) / (( SELECT sum(restaurants_1.number_of_chairs) AS sum
           FROM public.restaurants restaurants_1))::numeric) * (100)::numeric), 2) AS "Percent_Leeds_Chairs"
   FROM public.restaurants
  GROUP BY restaurants.category;


--
-- Name: post_codes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.post_codes AS
 SELECT "left"((r.post_code)::text, 3) AS "Post_Code_Prefix",
    max(mc.most_chairs) AS "Most_Chairs",
    max((mc.cafe_name)::text) AS cafe_name,
    sum(r.number_of_chairs) AS "Total_Chairs",
    count(r.id) AS "Total_Places",
    ( SELECT sum(restaurants.number_of_chairs) AS sum
           FROM public.restaurants) AS "Total_Chairs_in_Leeds",
    round(((((sum(r.number_of_chairs))::numeric * 1.0) / (( SELECT sum(restaurants.number_of_chairs) AS sum
           FROM public.restaurants))::numeric) * (100)::numeric), 2) AS "Percent_Leeds_Chairs"
   FROM (public.restaurants r
     LEFT JOIN ( SELECT restaurants.id,
            restaurants.cafe_name,
            max(restaurants.number_of_chairs) AS most_chairs
           FROM public.restaurants
          GROUP BY restaurants.id, restaurants.cafe_name) mc ON ((r.id = mc.id)))
  GROUP BY ("left"((r.post_code)::text, 3));


--
-- Name: restaurants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.restaurants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.restaurants_id_seq OWNED BY public.restaurants.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: restaurants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN id SET DEFAULT nextval('public.restaurants_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20191002143006'),
('20191007172046'),
('20191007205051');


