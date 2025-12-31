--
-- PostgreSQL database dump
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';

CREATE TABLE public.customers (
                                  customer_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                  email character varying(255) NOT NULL,
                                  name character varying(255),
                                  created_at timestamp with time zone DEFAULT now()
);

--
-- TOC entry 229 (class 1259 OID 57344)
-- Name: expenses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.expenses (
                                 expense_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                 user_id uuid NOT NULL,
                                 amount numeric(10,2) NOT NULL,
                                 description text,
                                 expense_date timestamp with time zone DEFAULT now()
);

--
-- TOC entry 227 (class 1259 OID 40989)
-- Name: inventory_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.inventory_items (
                                        item_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                        name character varying(100) NOT NULL,
                                        quantity integer DEFAULT 0 NOT NULL,
                                        threshold integer DEFAULT 10 NOT NULL,
                                        is_active boolean DEFAULT true,
                                        created_at timestamp with time zone DEFAULT now(),
                                        updated_at timestamp with time zone DEFAULT now()
);

--
-- TOC entry 225 (class 1259 OID 24795)
-- Name: order_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_items (
                                    order_item_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                    order_id character varying(50) NOT NULL,
                                    variant_id uuid NOT NULL,
                                    topping_id uuid,
                                    quantity integer NOT NULL,
                                    price_at_purchase numeric(10,2) NOT NULL,
                                    topping_price_at_purchase numeric(10,2)
);

--
-- TOC entry 224 (class 1259 OID 24779)
-- Name: orders; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.orders (
                               order_id character varying(50) NOT NULL,
                               customer_id uuid NOT NULL,
                               user_id uuid NOT NULL,
                               total_amount numeric(10,2) NOT NULL,
                               payment_status character varying(50) NOT NULL,
                               order_date timestamp with time zone DEFAULT now(),
                               payment_confirmed_at timestamp with time zone
);

--
-- TOC entry 221 (class 1259 OID 24748)
-- Name: product_variants; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_variants (
                                         variant_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                         product_id uuid NOT NULL,
                                         name character varying(100) NOT NULL,
                                         price numeric(10,2) NOT NULL,
                                         created_at timestamp with time zone DEFAULT now()
);

--
-- TOC entry 220 (class 1259 OID 24738)
-- Name: products; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.products (
                                 product_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                 name character varying(255) NOT NULL,
                                 description text,
                                 image_url character varying(255),
                                 is_active boolean DEFAULT true,
                                 created_at timestamp with time zone DEFAULT now()
);


--
-- TOC entry 226 (class 1259 OID 24816)
-- Name: response_codes; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.response_codes (
                                       code character varying(50) NOT NULL,
                                       message_en text NOT NULL,
                                       message_id text NOT NULL,
                                       description text
);


--
-- TOC entry 218 (class 1259 OID 24716)
-- Name: roles; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.roles (
                              role_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                              role_name character varying(50) NOT NULL
);

--
-- TOC entry 222 (class 1259 OID 24760)
-- Name: toppings; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.toppings (
                                 topping_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                                 name character varying(100) NOT NULL,
                                 price numeric(10,2) NOT NULL,
                                 is_active boolean DEFAULT true,
                                 image_url character varying(255),
                                 created_at timestamp with time zone DEFAULT now()
);


--
-- TOC entry 219 (class 1259 OID 24724)
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
                              user_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
                              username character varying(100) NOT NULL,
                              password character varying(255) NOT NULL,
                              role_id uuid NOT NULL,
                              created_at timestamp with time zone DEFAULT now(),
                              is_active boolean DEFAULT true
);

--
-- TOC entry 228 (class 1259 OID 41002)
-- Name: variant_inventory_mapping; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.variant_inventory_mapping (
                                                  variant_id uuid NOT NULL,
                                                  inventory_item_id uuid NOT NULL,
                                                  quantity_to_decrement integer DEFAULT 1 NOT NULL
);


--
-- TOC entry 3458 (class 0 OID 24768)
-- Dependencies: 223
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.customers VALUES ('17880ea3-103a-44ad-a44d-21212577f40d', 'mulaibekasi@mail.com', NULL, '2025-10-04 23:42:32.127604+00');
INSERT INTO public.customers VALUES ('2c418ec4-cbe6-4872-89ca-cb3601517901', 'j@mai.co', NULL, '2025-10-04 23:48:36.921045+00');
INSERT INTO public.customers VALUES ('bb7cb342-233f-482d-bc99-e6fce651c249', 'h@ma.co', NULL, '2025-10-04 23:48:55.729554+00');
INSERT INTO public.customers VALUES ('1ab61c75-4819-4123-9dc6-a42e18a3ebcf', 'ma@mal.co', NULL, '2025-10-04 23:49:07.793125+00');
INSERT INTO public.customers VALUES ('0e1f01e1-65d7-42f7-ac00-36e18eeff09d', 'ht@mh.co', NULL, '2025-10-04 23:59:10.106282+00');
INSERT INTO public.customers VALUES ('8f65446b-1446-4cc0-99e6-d9760a654443', 'ng@mh.co', NULL, '2025-10-05 00:05:31.960892+00');
INSERT INTO public.customers VALUES ('edf83442-9003-415a-8343-20a8685d6da4', 'hg@ma.co', NULL, '2025-10-05 00:05:44.684903+00');
INSERT INTO public.customers VALUES ('fa1e3cfe-d5cf-41ea-982e-d3e2b3c6bed6', 'hg@mh.co', NULL, '2025-10-05 00:11:06.599184+00');
INSERT INTO public.customers VALUES ('eaf4698d-a4aa-4074-9df5-528ca4dd74ff', 'ht@nh.co', NULL, '2025-10-05 00:15:43.175628+00');
INSERT INTO public.customers VALUES ('dd4dfe1f-442d-427b-8117-44aa77be4e87', 'jy@ms.co', NULL, '2025-10-05 00:18:46.483795+00');
INSERT INTO public.customers VALUES ('34df6060-10e0-4ebe-92c0-20a97ced4604', 'nh@nh.co', NULL, '2025-10-05 00:45:35.031477+00');
INSERT INTO public.customers VALUES ('dc258d16-8c6d-4bd4-8cc8-616270c9cdfd', 'hy@nh.co', NULL, '2025-10-05 00:46:49.403853+00');
INSERT INTO public.customers VALUES ('760d21ca-f574-44f8-8117-9606168fd441', 'ht@mh.c9', NULL, '2025-10-05 00:48:25.781111+00');
INSERT INTO public.customers VALUES ('8ce309c4-0978-495c-94ce-6659bf6a106c', 'ht@jh.c9', NULL, '2025-10-05 00:55:07.063108+00');
INSERT INTO public.customers VALUES ('b2014c97-b571-4982-a39d-2cff0b5b13e8', 'hy@ng.c9', NULL, '2025-10-05 00:57:13.072089+00');
INSERT INTO public.customers VALUES ('dfc0511f-56ad-4966-9a10-ce14108026f0', 'ht@ng.c9', NULL, '2025-10-05 00:58:59.631821+00');
INSERT INTO public.customers VALUES ('b7722e83-5d40-4c0f-a734-b6253a78d30a', '7t@hg.c9', NULL, '2025-10-05 01:00:40.078898+00');
INSERT INTO public.customers VALUES ('666f064f-9266-40e7-b188-d39342fb77bb', 'ut@hg.co', NULL, '2025-10-05 01:03:23.240871+00');
INSERT INTO public.customers VALUES ('61aa4030-e0ce-414d-b278-628710d3cadd', 'hsy@hdg.c9', NULL, '2025-10-05 01:20:14.235631+00');
INSERT INTO public.customers VALUES ('c96ec666-2db3-4914-bc59-6eeb44842b10', 'bdg@hhe.c9', NULL, '2025-10-05 01:32:15.462391+00');
INSERT INTO public.customers VALUES ('33acc0c8-59f6-4102-bdbe-a87542befa69', 'hg@jg.f9', NULL, '2025-10-05 01:55:33.059794+00');
INSERT INTO public.customers VALUES ('97aa393f-bab9-47a5-9bc9-21a259bcf2c4', 'js@md.co', NULL, '2025-10-10 17:41:25.639793+00');
INSERT INTO public.customers VALUES ('20b2b031-9612-447e-99ed-7c3515e794c3', 'jhb', NULL, '2025-10-10 17:49:56.515278+00');
INSERT INTO public.customers VALUES ('0f070679-785b-4ba7-98a9-d5965d99566e', 'eydy', NULL, '2025-10-11 06:49:17.860662+00');
INSERT INTO public.customers VALUES ('14da367b-884e-4393-ab98-5883863c72ec', 'dsg', NULL, '2025-10-11 06:52:01.039509+00');
INSERT INTO public.customers VALUES ('0b8fd62f-56b1-4bca-9ef7-cb69a69e6fe4', 'hy', NULL, '2025-10-11 06:53:12.129988+00');
INSERT INTO public.customers VALUES ('e83e3a85-88af-4e0e-bd83-c580d926c796', 'hg@bg.xo', NULL, '2025-10-11 22:52:43.268016+00');
INSERT INTO public.customers VALUES ('d7da57bd-7f96-49e2-8329-3180f27b37bf', 'kkkk', NULL, '2025-10-11 22:53:39.261888+00');
INSERT INTO public.customers VALUES ('8f0803cf-723c-40ae-a5ba-b2b88416d93a', 'ppp', NULL, '2025-10-11 22:54:06.127297+00');
INSERT INTO public.customers VALUES ('26b85c23-7905-4fe4-99a4-793ff72e5a30', 'pesenan 1', NULL, '2025-10-11 22:55:13.925817+00');
INSERT INTO public.customers VALUES ('0a481909-395e-4dd4-9064-9d6a59d225ef', 'pppp', NULL, '2025-10-11 23:11:37.192743+00');
INSERT INTO public.customers VALUES ('e033af59-257c-4851-98d4-b80e1947b40b', 'dy', NULL, '2025-10-12 00:04:19.217632+00');
INSERT INTO public.customers VALUES ('dd65c45e-1724-4222-b3ca-024877ca3a94', 'd6', NULL, '2025-10-12 00:07:06.285179+00');
INSERT INTO public.customers VALUES ('3d593603-f16d-438a-bad6-e675f3a868df', 'u', NULL, '2025-10-12 00:09:34.85626+00');
INSERT INTO public.customers VALUES ('2ffefca4-467e-406b-84a0-7ccc87ef4448', 'hf', NULL, '2025-10-12 00:15:13.694816+00');
INSERT INTO public.customers VALUES ('e9d23afa-7d57-4cfe-aca2-b07e29ae765e', 'iy', NULL, '2025-10-12 00:15:51.995337+00');
INSERT INTO public.customers VALUES ('577630c8-600e-4872-b160-fbbd4e37c742', 'jy', NULL, '2025-10-12 01:00:15.17175+00');
INSERT INTO public.customers VALUES ('7ad10082-db5a-4f9d-965c-5e9d643501bb', 'hg', NULL, '2025-10-12 01:23:11.337693+00');
INSERT INTO public.customers VALUES ('2c4b2258-daec-455f-9092-38c22bbeb974', 'k', NULL, '2025-10-13 17:45:43.985561+00');
INSERT INTO public.customers VALUES ('68cc1938-64b3-428f-91b3-f068d73cbae1', 'd', NULL, '2025-10-13 18:16:40.513854+00');
INSERT INTO public.customers VALUES ('0d6755e2-9019-4b3d-bd86-e9b9814f648c', 'l', NULL, '2025-10-13 18:21:23.771669+00');
INSERT INTO public.customers VALUES ('4ea00ff5-a166-4839-b758-47a3185cf9b9', 'f', NULL, '2025-10-13 18:25:34.016999+00');
INSERT INTO public.customers VALUES ('acb8547c-bd0d-4417-b5b6-fe12da9b30a0', 'dd', NULL, '2025-10-13 18:37:23.507731+00');
INSERT INTO public.customers VALUES ('a77a96f4-af1a-4cd0-9bf2-7d64df1f7b3c', 'j', NULL, '2025-10-13 19:08:38.732796+00');
INSERT INTO public.customers VALUES ('71fa3df0-a699-4ec8-bcee-f168a8e41368', 'a', NULL, '2025-10-13 20:38:53.046716+00');
INSERT INTO public.customers VALUES ('b61d51e0-27d4-49fb-99f2-5c56552fab75', 'h', NULL, '2025-10-14 12:59:55.86561+00');
INSERT INTO public.customers VALUES ('f23af093-fc22-48f2-992f-d609e495b430', 'uy', NULL, '2025-10-15 10:20:37.712084+00');
INSERT INTO public.customers VALUES ('af5e9427-6532-4162-bef0-18885b0165a8', 'jh', NULL, '2025-10-19 00:11:19.342533+00');
INSERT INTO public.customers VALUES ('f73132fe-325d-40c4-9e03-e435eb64321b', 'gt', NULL, '2025-10-19 00:14:48.581282+00');
INSERT INTO public.customers VALUES ('fc22df1d-4679-457c-91b2-abcde4d08500', 'b', NULL, '2025-10-19 00:40:24.712452+00');
INSERT INTO public.customers VALUES ('3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'jg', NULL, '2025-10-19 00:55:26.134961+00');
INSERT INTO public.customers VALUES ('13966991-7492-4d78-88af-aac6d605448f', 'ug', NULL, '2025-10-19 00:59:12.472364+00');
INSERT INTO public.customers VALUES ('3779bc39-8cdd-4ce3-9745-58d1763234dd', 'ut', NULL, '2025-10-19 01:37:14.528918+00');
INSERT INTO public.customers VALUES ('e8769398-75ea-4f53-8c98-e4f76b294a76', 'n', NULL, '2025-10-21 14:09:11.769953+00');
INSERT INTO public.customers VALUES ('fd136865-f909-4114-be1a-6acf1c918403', 'dsd', NULL, '2025-11-04 15:28:11.439426+00');
INSERT INTO public.customers VALUES ('9714ba3b-f378-40f8-88a7-4d2b1a6eadcf', 'jk', NULL, '2025-11-04 15:30:39.626734+00');
INSERT INTO public.customers VALUES ('94aab094-a37b-4561-b0a3-523e38696940', 's', NULL, '2025-11-04 16:10:17.091632+00');
INSERT INTO public.customers VALUES ('d276ca38-b77f-43bc-99fb-823414fb4dd0', 'hqh@uwiw.com', NULL, '2025-11-07 05:20:58.449781+00');
INSERT INTO public.customers VALUES ('8cc00ddf-e8e2-43ec-889f-de148445d859', 'nv', NULL, '2025-11-08 12:31:33.31939+00');
INSERT INTO public.customers VALUES ('48749636-ce67-4a91-b7f5-e5c264524be7', 'bhh', NULL, '2025-11-08 23:38:33.78468+00');
INSERT INTO public.customers VALUES ('814c2b98-281f-4c43-897a-f822f0711868', 'jh@gaj.co', NULL, '2025-11-09 01:42:13.034581+00');
INSERT INTO public.customers VALUES ('4047a3b1-408c-44b1-b756-6adbd6a85a82', 'jj', NULL, '2025-11-09 02:00:44.013652+00');
INSERT INTO public.customers VALUES ('92e8e4dc-43c6-47c4-9d7b-372909e2bb98', '7h', NULL, '2025-11-09 02:14:25.705604+00');
INSERT INTO public.customers VALUES ('0ada98d8-7735-45d8-aabc-99da11ed1676', 'kh', NULL, '2025-11-09 02:19:24.982512+00');
INSERT INTO public.customers VALUES ('576d6b6e-0ade-4290-a631-8291c87d0989', 'gd', NULL, '2025-11-09 02:43:12.386089+00');
INSERT INTO public.customers VALUES ('862b7d8e-c278-4373-9c42-12911900930e', 'jgg', NULL, '2025-11-11 11:39:17.934954+00');
INSERT INTO public.customers VALUES ('5378bd0b-866e-4d6b-8398-d8cde52622db', 'gh', NULL, '2025-11-15 07:18:46.930336+00');
INSERT INTO public.customers VALUES ('42e9e0d7-3f2a-4388-9b88-9152a8b1f5db', 'ii', NULL, '2025-11-16 00:13:59.34224+00');
INSERT INTO public.customers VALUES ('2df5f39e-27f9-40a9-81f1-0d7cf338b302', 'ht', NULL, '2025-11-16 00:18:26.800288+00');
INSERT INTO public.customers VALUES ('4197b152-b229-4556-b4cf-e14c16caeac2', 'yg', NULL, '2025-11-16 00:23:23.463581+00');
INSERT INTO public.customers VALUES ('ae39ae55-b372-4e38-bec3-a707243c80bb', 'yfh', NULL, '2025-11-16 00:42:04.219629+00');
INSERT INTO public.customers VALUES ('4fb88497-211b-46c8-90f5-9f2957342575', 'tuf', NULL, '2025-11-16 00:52:51.055369+00');
INSERT INTO public.customers VALUES ('d7c2d813-fdca-4f97-a94c-85a88e550c5f', 'dhd', NULL, '2025-11-16 00:58:26.219887+00');
INSERT INTO public.customers VALUES ('4f8a8774-9816-4bb8-bf4d-d9a07238ed9e', 'dudg', NULL, '2025-11-16 01:11:38.620773+00');
INSERT INTO public.customers VALUES ('2d408d47-2718-4625-9b25-08761c4a2c57', 'utb', NULL, '2025-11-16 01:17:25.761516+00');
INSERT INTO public.customers VALUES ('6814cc35-c2c3-4d2f-9d56-aa59eafd2c9b', 'ufh', NULL, '2025-11-16 01:22:33.378125+00');
INSERT INTO public.customers VALUES ('d43bd43b-a428-4ec0-8ed4-e3e5ff86587f', 'yhyg', NULL, '2025-11-16 01:34:05.386826+00');
INSERT INTO public.customers VALUES ('8a753fbb-b719-44b0-944a-7be7eab52a6d', 'hfg', NULL, '2025-11-18 10:07:04.090628+00');
INSERT INTO public.customers VALUES ('949b05a1-a18c-4375-b7a8-ba20feceaaf3', 'hsf', NULL, '2025-11-18 10:07:46.760871+00');
INSERT INTO public.customers VALUES ('83312969-3b06-49ee-8260-00b9ddb757da', 'ugh', NULL, '2025-11-19 13:49:25.20343+00');
INSERT INTO public.customers VALUES ('0f61c4b1-ed5f-4c67-a8ea-aaa06298df59', 'jgh', NULL, '2025-11-20 23:12:09.085135+00');
INSERT INTO public.customers VALUES ('a30178b8-9fe0-49f7-835f-e6cfc0e19027', 'vyh', NULL, '2025-11-22 23:01:05.425213+00');
INSERT INTO public.customers VALUES ('6abfc33f-85c6-4fa2-b2ee-2d576e358443', 'hfh', NULL, '2025-11-22 23:30:57.029531+00');
INSERT INTO public.customers VALUES ('4ce2f2ab-890a-412a-b7d5-47a8fbb102b0', 'fh', NULL, '2025-11-23 00:03:36.168744+00');
INSERT INTO public.customers VALUES ('8de4d94e-fd35-475d-a08b-6f383c860482', 'jf', NULL, '2025-11-23 00:21:03.550655+00');
INSERT INTO public.customers VALUES ('385b92c9-ba3c-4429-b250-61afc19df6b3', 'fhg', NULL, '2025-11-23 00:33:24.225164+00');
INSERT INTO public.customers VALUES ('7d55b366-eb83-49fb-9746-1a1ee8f14520', 'fug', NULL, '2025-11-23 00:40:50.927161+00');
INSERT INTO public.customers VALUES ('5fb620f7-5661-4c36-8e55-8c668cdfc44e', 'jth', NULL, '2025-11-23 00:55:55.960068+00');
INSERT INTO public.customers VALUES ('7e115f09-58d0-455a-bc58-4bb9603c00ea', 'jfh', NULL, '2025-11-23 01:04:33.519912+00');
INSERT INTO public.customers VALUES ('6c66bc87-6f0f-4fff-92e7-1c1c7f8a3eeb', 'jfb', NULL, '2025-11-23 01:14:01.894446+00');
INSERT INTO public.customers VALUES ('ee00a8f5-5197-4261-851f-4f4f5c8b53ab', 'igh', NULL, '2025-11-23 01:32:34.529677+00');
INSERT INTO public.customers VALUES ('a57f96f9-aa7b-4f6f-8e55-e62ca0aac6a4', 'iry', NULL, '2025-11-23 01:40:41.837628+00');
INSERT INTO public.customers VALUES ('c252218f-d562-4e32-bc81-0d60bb0c7abb', 'jgn', NULL, '2025-11-23 01:45:10.971123+00');
INSERT INTO public.customers VALUES ('6dfb00d0-6e45-49c8-ac1c-26fad22cddca', 'jfn', NULL, '2025-11-23 01:52:26.691179+00');


--
-- TOC entry 3464 (class 0 OID 57344)
-- Dependencies: 229
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.expenses VALUES ('9035d6dd-9a23-474a-88e7-246f30039b04', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 5000.00, 'Parkir Burger King', '2025-10-19 05:05:00+00');
INSERT INTO public.expenses VALUES ('37e9e91c-a6cd-439d-88ea-22e06ef6b53a', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 15000.00, 'Lapak CFD', '2025-10-19 05:05:00+00');
INSERT INTO public.expenses VALUES ('bf117c9f-7575-424f-b8b7-31461b20c422', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'Parkir CFD', '2025-10-19 05:05:00+00');
INSERT INTO public.expenses VALUES ('5eab0388-2a8c-4b76-b4d2-b24f1d547678', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 5000.00, 'Amal', '2025-10-19 05:05:00+00');
INSERT INTO public.expenses VALUES ('4fd29aa4-b28f-4b7d-8fd7-e71fe5541df8', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 100000.00, 'Bensin', '2025-11-23 04:19:41.121134+00');
INSERT INTO public.expenses VALUES ('327fb8e9-644d-46da-9c08-3976f33b8f66', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 15000.00, 'Preman', '2025-11-23 04:19:54.260312+00');
INSERT INTO public.expenses VALUES ('d48a6723-4d27-41e8-9c8b-ed956abb14dd', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'Parkir cfd', '2025-11-23 04:20:17.99975+00');
INSERT INTO public.expenses VALUES ('97216e1f-f02f-4724-a609-bfffa3c06591', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 5000.00, 'Amal mingguan', '2025-11-23 04:20:33.76676+00');


--
-- TOC entry 3462 (class 0 OID 40989)
-- Dependencies: 227
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.inventory_items VALUES ('06e7ccc5-beea-42a5-83d4-5991769c3c61', 'Plastik Kecil', 96, 5, true, '2025-10-11 14:56:29.235494+00', '2025-11-23 00:56:29.773406+00');
INSERT INTO public.inventory_items VALUES ('def41244-3737-4cd1-8b17-c3fb2526aaec', 'Mika', 21, 10, true, '2025-10-11 14:56:29.235494+00', '2025-11-23 01:40:43.891566+00');
INSERT INTO public.inventory_items VALUES ('c0b30915-03af-42ee-bbae-0fb8e8f57d17', 'Plastik Besar', 189, 50, true, '2025-10-11 14:56:29.235494+00', '2025-11-23 01:40:57.536961+00');
INSERT INTO public.inventory_items VALUES ('48ba1387-bbd7-4206-8070-bfbffef0486c', 'Sumpit', 95, 20, true, '2025-10-11 14:56:29.235494+00', '2025-11-23 01:41:08.388554+00');
INSERT INTO public.inventory_items VALUES ('e48fc67e-8741-4565-b10e-974b2a4a6dc3', 'Foil isi 4', 27, 10, true, '2025-10-11 14:56:29.235494+00', '2025-11-23 01:52:28.962303+00');
INSERT INTO public.inventory_items VALUES ('f19c3438-61d3-47eb-98b6-0ee495a76cf1', 'Foil isi 6', 264, 10, true, '2025-10-11 14:56:29.235494+00', '2025-11-23 01:52:28.9624+00');


--
-- TOC entry 3460 (class 0 OID 24795)
-- Dependencies: 225
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.order_items VALUES ('ed5d1fc8-24ca-436c-bdaa-c263c0b66e97', 'ORD-20251004-53AC4147', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('a491e898-7349-4994-b7c5-9e9f38256fe0', 'ORD-20251004-8F6F608C', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('ab9a5d61-8392-4058-94e1-5e47874edb82', 'ORD-20251004-D090FF18', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('4f52fa4a-c94c-45f5-9075-bb465ea168a7', 'ORD-20251004-556DFFC4', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('03b8e9dc-f7c4-48e6-ad1c-91e0120f45f0', 'ORD-20251004-1686FF92', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('03bf2d40-5ba5-418a-b021-758ec398d497', 'ORD-20251005-096D9C72', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('6e1dbf48-2c81-4895-823d-13b53906f046', 'ORD-20251005-905D45F6', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 3, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('b89e626f-d172-42dd-b2fb-cd09b7a77601', 'ORD-20251005-2AD0EDC8', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('131e85e8-2c78-456a-8404-bdb6bed78535', 'ORD-20251005-DDFD3764', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '385804c7-125f-4f42-9c44-816d0df4ddd7', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('83962e45-0469-46d4-89b6-bf0d8db1285a', 'ORD-20251005-8DA0B2C4', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('6df682dd-b245-47c7-a857-9349bc89c27c', 'ORD-20251005-8DA0B2C4', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '369a7232-cb27-4194-bcc8-f6d3c560161f', 3, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('9d28b0cc-94fb-43c9-b8ed-3c7fd5d6503e', 'ORD-20251005-0A876C2C', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('4d35d9e7-fd93-463b-a955-ea17da89226d', 'ORD-20251005-4D533DDC', '49439008-3859-4363-9bd5-880a71fcc834', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('838f5996-f322-466d-b9fd-a5a1e4439585', 'ORD-20251005-4D533DDC', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('7377a515-66ff-427a-985e-26cb3852830a', 'ORD-20251005-4D533DDC', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('9fe762ef-937b-44bd-8370-800c93ce4c07', 'ORD-20251005-4D533DDC', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('829a6e3c-0337-4415-8c3e-de516586313d', 'ORD-20251005-E03FFE39', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('5b546c45-04d3-4cd0-a04d-37f7e15589ef', 'ORD-20251005-9A74930B', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('de6f9bfa-2c6a-41e2-ad14-ebbd41412904', 'ORD-20251005-D099CA21', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('a11becf6-e67f-4a67-853b-aa7b299da893', 'ORD-20251005-D58459FC', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('f6800975-eaf5-4962-8333-5729edcdc74e', 'ORD-20251005-5A04372A', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('d0c25439-c62b-41d7-91a2-9a0c9e59632c', 'ORD-20251005-82EC1AF0', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('39e34303-5a4e-4124-8f1a-3495c7b91798', 'ORD-20251005-2301794D', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('29d305e5-aa31-4869-ad13-8f954bb6dc84', 'ORD-20251005-28E6D413', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('6fe8bbed-51f1-47a0-a812-8f71521ad03a', 'ORD-20251005-0E476468', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('bd124765-40ec-4519-be28-346b33194b4d', 'ORD-20251005-FFBD0F8A', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('1abcc743-3611-4938-bfaa-effdee13047e', 'ORD-20251012-79FB604D', '54eab302-2dbc-45cf-b072-b7b90449eace', '385804c7-125f-4f42-9c44-816d0df4ddd7', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('301554e0-46de-4fba-a460-ccc93d5e4853', 'ORD-20251012-79FB604D', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('6cf31fa5-3ae1-4240-b160-2f5894c36859', 'ORD-20251012-79FB604D', 'c16bb391-a8df-4c86-9b66-63bb12f03e76', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 28000.00, 0.00);
INSERT INTO public.order_items VALUES ('2b1f5df9-a6e2-47f4-b6fe-dd12a444fefd', 'ORD-20251012-79FB604D', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('2568e00b-fb4e-4b4e-ac9f-7c9b4ef48f68', 'ORD-20251012-3E053E87', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('48d7c0ea-b1e8-43de-816c-95603fcdbecc', 'ORD-20251012-8BFE06C9', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('bcf28d77-e7f3-440f-9e6e-cd71b77ee05e', 'ORD-20251012-8D1599C7', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('d9dffb62-d1b6-4fac-b9a1-d3b9439659bd', 'ORD-20251012-A103CC0A', '54eab302-2dbc-45cf-b072-b7b90449eace', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('94bcdb5c-6ba0-402a-bd5f-d618a8f8dee1', 'ORD-20251012-B9CCC01F', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '385804c7-125f-4f42-9c44-816d0df4ddd7', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('2bad1d64-9846-44a3-9153-8ebb5e783275', 'ORD-20251012-9082E70A', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('6542a7aa-f076-43cb-ad22-cd6d5ad5a2d7', 'ORD-20251012-1F2DC970', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '385804c7-125f-4f42-9c44-816d0df4ddd7', 2, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('5230807d-c5e8-4816-9e34-a2209dffb209', 'ORD-20251012-55E93F73', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '385804c7-125f-4f42-9c44-816d0df4ddd7', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('d4f85e56-dce3-47aa-8e47-56c2afd3e204', 'ORD-20251012-29820780', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('eb652f91-5b2b-400a-b5c2-ff51e6cb8179', 'ORD-20251012-E3592706', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('718ac4e4-5502-48af-b650-f49f978bca40', 'ORD-20251012-2ACC419A', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('bc31228b-644e-4d90-ab49-5cf5e42df75d', 'ORD-20251012-3D4E19E7', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('f17c2466-bb17-47f7-b476-30254acbe317', 'ORD-20251012-F9BEECE1', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('7ba63aab-6f49-4c7d-a94e-dfcafc94e2b9', 'ORD-20251012-98A04CE3', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('6f73d742-c399-4169-ae39-1f9a2f859905', 'ORD-20251012-C29CF2F2', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('773d5019-e804-4b3f-b447-55434dd8080b', 'ORD-20251012-DA390E8C', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('bfb1a0ee-c297-4bf7-8383-d0dcd14fbe69', 'ORD-20251012-3BFDC483', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('cf6fa52e-1258-4715-87f0-0047ad2a1035', 'ORD-20251012-3BFDC483', '54eab302-2dbc-45cf-b072-b7b90449eace', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('34e81b27-7cca-45a8-b6a6-b43c81e95cd7', 'ORD-20251012-6A50C03F', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('8dfaba78-75ac-4e98-aad8-df6be62989c3', 'ORD-20251012-3D5342C9', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('51d5f78a-7765-42dc-8935-b663f2346b65', 'ORD-20251012-3D5342C9', '54eab302-2dbc-45cf-b072-b7b90449eace', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('8f7bd0db-1a77-4547-8c75-5a63e85a2b2c', 'ORD-20251012-21C68FE1', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('bfc64a95-5ecd-470b-8421-43b36af5e604', 'ORD-20251012-2133E0AE', '07552090-8fd4-48bd-b70f-70e1c0d96065', 'baef8919-e6bc-4940-88ca-affa0084f13d', 1, 20000.00, 0.00);
INSERT INTO public.order_items VALUES ('6357f0c2-ad95-44bc-b6fb-7665b9bad9ac', 'ORD-20251012-DB2578A9', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('4b7427d2-9eef-4625-9352-b504c18940bc', 'ORD-20251012-DB2578A9', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('59fcf133-0933-4dce-9a62-4bf9feac5e4c', 'ORD-20251012-3E5E94B9', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('c99e949f-fcae-420f-bb4d-16463f7def4f', 'ORD-20251012-F9D757C4', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('4abafc51-d97a-4ba2-867b-d50be810c2f6', 'ORD-20251012-EA29651B', '07552090-8fd4-48bd-b70f-70e1c0d96065', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 20000.00, 0.00);
INSERT INTO public.order_items VALUES ('a0bec43f-44c7-4747-942c-84f4992bd69a', 'ORD-20251012-FE05D61C', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('88760f3b-93dc-4769-8d11-71b9b921cc3c', 'ORD-20251012-778E7657', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('5c32348d-9905-437d-8214-bb923322a610', 'ORD-20251012-5A64A918', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('302bb07b-c739-47a8-bc63-339c67a46d87', 'ORD-20251012-8EFEF814', '54eab302-2dbc-45cf-b072-b7b90449eace', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('43cec996-082b-4240-9396-697ef16b1a66', 'ORD-20251014-CD36A4F1', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 4, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('b598d369-cddf-41e0-816f-ea730650d66d', 'ORD-20251014-CD36A4F1', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('f0632463-4f88-488c-b4f4-cedc5f6e481c', 'ORD-20251015-075A02A7', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('be81d475-c529-4c60-81cb-bc197bc65234', 'ORD-20251016-CC94B96C', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('73d33ce5-8750-4977-b4b4-d3ffc18b4fc6', 'ORD-20251017-A43D303E', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 10, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('d22546cc-4b01-499c-b9a7-41777ae5fa54', 'ORD-20251019-A70B0A26', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('12328097-727e-40fa-9123-7f5ead07a992', 'ORD-20251019-71FCDBCC', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 3, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('803abd1d-d63c-435d-b874-9231d888cc5f', 'ORD-20251019-71FCDBCC', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('37dada43-c842-4403-a440-1a19e0a157f0', 'ORD-20251019-6A0E5230', '49439008-3859-4363-9bd5-880a71fcc834', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('32286f85-0980-4267-9a6b-47022a939f5e', 'ORD-20251019-5A092F10', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('e2b70051-d118-43ad-a492-466216cd7ea3', 'ORD-20251019-74A4808C', '07552090-8fd4-48bd-b70f-70e1c0d96065', NULL, 1, 20000.00, 0.00);
INSERT INTO public.order_items VALUES ('cf1d33c7-e259-46ad-962d-23f79c18e834', 'ORD-20251019-74A4808C', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('ce4fd307-ddb9-43d5-a39d-01f777db2103', 'ORD-20251019-7A08EB70', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('51ff0427-1695-4b86-9cc5-c6d2864b6056', 'ORD-20251019-107C957D', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('8c25071d-03bd-435b-b9d9-488195e2ff42', 'ORD-20251019-D55F8CDA', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('73b298bf-7c0f-4751-ab97-24c8940984af', 'ORD-20251019-56B820AC', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('c3fd3436-9173-4f26-b7c2-b5880a9b170c', 'ORD-20251019-C7ABB70C', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('8a931aa6-6468-40db-b93b-27ab1c3ec53a', 'ORD-20251019-4F734BCB', '54eab302-2dbc-45cf-b072-b7b90449eace', NULL, 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('9eb2b281-4ad0-40ab-919a-85749f799b21', 'ORD-20251019-E494C2E4', 'c16bb391-a8df-4c86-9b66-63bb12f03e76', NULL, 1, 28000.00, 0.00);
INSERT INTO public.order_items VALUES ('08c1dccb-b124-4926-a0a8-c56133a187d1', 'ORD-20251019-4B44B7F5', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '369a7232-cb27-4194-bcc8-f6d3c560161f', 2, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('094244fc-10e2-40b1-9dbe-1a57f95f87c7', 'ORD-20251019-D8E15E2A', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('eeb1f500-cb04-4ada-858f-8f90a4e3cc76', 'ORD-20251019-7029B40D', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('0b3ab289-6027-4631-bd27-93ef97e9a7b5', 'ORD-20251019-7029B40D', '07552090-8fd4-48bd-b70f-70e1c0d96065', NULL, 1, 20000.00, 0.00);
INSERT INTO public.order_items VALUES ('7ff50eb2-1584-48e9-ac86-84c6916d08c2', 'ORD-20251019-498F3370', '07552090-8fd4-48bd-b70f-70e1c0d96065', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 20000.00, 0.00);
INSERT INTO public.order_items VALUES ('be10323e-8e2d-4bf0-bdf2-ff3ec088b964', 'ORD-20251019-47486130', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('477fb1fb-565b-4bb0-8a70-3488c2d3fdda', 'ORD-20251019-47486130', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('0d05a40e-00f0-4da2-bfb9-7a4e4a2e9ff8', 'ORD-20251019-47486130', '49439008-3859-4363-9bd5-880a71fcc834', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('2ca853c2-9b0b-4868-bfe7-3c6ea8f05ede', 'ORD-20251019-D1B9968B', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('c18658aa-4e44-4d83-a3f3-9fae3fff988e', 'ORD-20251019-5072150E', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('7c76571e-587c-4236-9cc3-ab784a359663', 'ORD-20251019-97C25C7D', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('fe31d6d3-e2c5-4d48-a347-ae40568a6802', 'ORD-20251019-6AA1FCD6', '07552090-8fd4-48bd-b70f-70e1c0d96065', NULL, 1, 20000.00, 0.00);
INSERT INTO public.order_items VALUES ('4392b0b0-d125-49ef-9859-765a6c98c317', 'ORD-20251019-6AA1FCD6', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('a6339496-3eae-4bf2-9fdd-1c4a9fbaf393', 'ORD-20251019-EF2699FF', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('f493c824-0d83-49d4-8c16-cca066531af2', 'ORD-20251019-7A498A65', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('044acc60-51ac-43c4-a422-024a01546ece', 'ORD-20251019-8F6B83E4', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('8a88aca2-2f49-4350-ab5e-7243120c7f50', 'ORD-20251019-882487F6', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('9fc22f39-72f6-42ee-8973-fc65cab6ceee', 'ORD-20251019-882487F6', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('f85faff6-7e89-42d7-839d-68b68413e563', 'ORD-20251019-D8251078', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('73b137f3-a8be-4dbc-8dcb-cc9f4f262c5f', 'ORD-20251019-EDFDD36C', '54eab302-2dbc-45cf-b072-b7b90449eace', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('9ce03082-f2f3-4053-a4a5-13262a0ad582', 'ORD-20251019-EDFDD36C', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('f968953c-7e4a-4bd9-b8f0-ac32ea7ee830', 'ORD-20251021-B795DFA3', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('a633478b-2971-4c51-959a-9a677b39d935', 'ORD-20251021-F8D521D0', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('4a2d30ab-ba74-4fee-862e-437490d06224', 'ORD-20251022-B5E77D8F', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 10, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('18032a7f-670c-423e-a2cd-6c39d082618b', 'ORD-20251023-242EA846', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 11, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('f0c333e6-ed4c-45b1-a8e3-12c673e5c747', 'ORD-20251023-242EA846', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('83536cff-834a-4403-aa1e-ae627ee1dfa5', 'ORD-20251104-A26AEA80', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('4b3034a8-38a2-4fc4-8e58-fe097199f899', 'ORD-20251104-F2D4FF90', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('1a7a5d62-9daf-4e66-b938-67c7fcd72c2e', 'ORD-20251106-2A263677', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 6, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('a2b430f0-e908-4b50-9af1-f66ad8fe2c37', 'ORD-20251108-657690F0', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('7e7968bb-0def-4130-8af2-5c4e68e86a8f', 'ORD-20251109-CE10C02B', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('633fd6c9-4ea0-4524-a002-0ff3e07070c7', 'ORD-20251109-A34D32D7', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 4, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('7ff93067-54d0-4db7-b120-bbba840ced31', 'ORD-20251109-EC606C83', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('9c78e8f4-7303-4158-b438-18f7b0c7b9ed', 'ORD-20251109-EC606C83', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('bc837644-c45b-494e-b49a-ee928bb95471', 'ORD-20251109-89B0FBDA', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('4464f2e2-6f0c-4fee-8591-dac019672c07', 'ORD-20251109-D59BACF6', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 3, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('8cbace34-a6fb-4692-bf9b-4a39f138e9e3', 'ORD-20251109-D59BACF6', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 3, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('13d8d32e-02ca-45b7-b03a-61306fe71324', 'ORD-20251109-D59BACF6', '54eab302-2dbc-45cf-b072-b7b90449eace', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('6817118f-8f67-4ef2-9b8f-434ba93724cf', 'ORD-20251109-D59BACF6', '54eab302-2dbc-45cf-b072-b7b90449eace', NULL, 1, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('3c7c2f06-b7ec-440f-92b1-e07100514307', 'ORD-20251109-D59BACF6', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('14424881-e02f-416c-b4ab-806b90c1539b', 'ORD-20251109-D59BACF6', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 4, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('402a1000-9bc8-4658-b1a0-5f50a6b770dd', 'ORD-20251109-D59BACF6', 'ed778c23-b212-4d37-8fc0-09d6a5a5730f', NULL, 1, 8000.00, 0.00);
INSERT INTO public.order_items VALUES ('dab31a19-f5ce-4f00-8ffb-66935caa50bc', 'ORD-20251109-D59BACF6', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 2, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('185f82e8-2522-4653-b651-0bd78eb9b354', 'ORD-20251109-727124A3', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('79f5e9e5-13b6-4e3b-a2b6-8b6187daafef', 'ORD-20251109-A917C6E0', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('e6305095-c1ea-4f4e-9520-70d9bf080fb0', 'ORD-20251109-CB65C74D', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('65ab9083-adf8-4fbd-9fa5-730180a85b14', 'ORD-20251109-621A9AF3', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('a09cde0d-e37e-4f75-b286-a2f345e84628', 'ORD-20251109-BF71FA98', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('81da7262-ac8c-431e-bff5-df3c29c1ad26', 'ORD-20251109-BF71FA98', 'ed778c23-b212-4d37-8fc0-09d6a5a5730f', NULL, 1, 8000.00, 0.00);
INSERT INTO public.order_items VALUES ('02b4d063-2e68-4b2b-a117-c222f52c4f04', 'ORD-20251109-8597E8A5', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('c13f6614-3e11-40a9-b6a6-8869de2817c8', 'ORD-20251109-8597E8A5', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('e7853c56-539a-426b-85aa-878c89fef880', 'ORD-20251109-2DA4C809', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('a8c1a868-4b2f-43f0-885f-5a2e642841e8', 'ORD-20251109-34CD35E2', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 2, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('2fa8f39e-b1c4-4b07-ab2c-a9062104335d', 'ORD-20251109-34CD35E2', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('31d37325-558e-4d03-b2c3-293f1d3e5cd4', 'ORD-20251109-3E5F2866', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('f9337adc-3b8c-4a95-af00-6c215f709c40', 'ORD-20251111-04AE27F0', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 2, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('7edbffeb-e85e-4923-b9b0-283a8d65ff2b', 'ORD-20251113-4F278353', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 14, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('66275133-8b90-4103-9288-c43d63bed71e', 'ORD-20251113-4F278353', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 2, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('b1b686b4-82b8-4713-b236-d8745de90067', 'ORD-20251115-B43899AC', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 15, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('8f81804d-bc46-4032-a757-5f9e73bb1373', 'ORD-20251116-D0F1B22E', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('c719754b-b4f1-4115-9fe3-939a9ff2fa8e', 'ORD-20251116-2A4D54B2', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '369a7232-cb27-4194-bcc8-f6d3c560161f', 2, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('96da62c1-4b01-4dc2-836d-094dfc1bde7f', 'ORD-20251116-18E06C4F', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('ccc25512-d5a8-4ca5-99e9-be7cc3a2642d', 'ORD-20251116-B450E082', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 2, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('c38acc9f-9825-4c75-8895-f488bc2db046', 'ORD-20251116-92E3BA49', '54eab302-2dbc-45cf-b072-b7b90449eace', '369a7232-cb27-4194-bcc8-f6d3c560161f', 2, 12000.00, 0.00);
INSERT INTO public.order_items VALUES ('c83cec53-df75-4882-927a-b8a7a761a10b', 'ORD-20251116-3A26805F', 'bed95cc1-344d-450e-841b-11f1d84e52bd', 'baef8919-e6bc-4940-88ca-affa0084f13d', 2, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('92029a75-8569-4012-b327-028d68e4ccfb', 'ORD-20251116-685C02C4', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('da9f7b8f-d13e-4bf4-bef5-2d13a4772405', 'ORD-20251116-685C02C4', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('ccfe11d5-2eb7-4dbe-a92c-95a81f429def', 'ORD-20251116-A498BD30', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('dde850ed-97e4-49d0-ba94-d450ede0b2a4', 'ORD-20251116-89AE09BC', 'bed95cc1-344d-450e-841b-11f1d84e52bd', NULL, 2, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('f4816cb7-0fe9-4829-a03a-02ac6c06daab', 'ORD-20251116-BE678EF2', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('0915d280-9b1b-4b9a-ad0b-9b8f498709af', 'ORD-20251116-BE678EF2', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('dc92bd23-1927-4a68-8057-f9e759213acb', 'ORD-20251116-BE678EF2', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 2, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('6d7d7d95-1297-4180-b9b5-d8342ebda5dc', 'ORD-20251116-7C3B9F8B', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('d8b76ad9-a916-4835-be9f-85fba6f223f0', 'ORD-20251116-D6FBE17F', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('71fcf0fe-f849-493e-92a9-b7f56e7c93f7', 'ORD-20251116-D9144411', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('dcc95b08-54a4-46ea-bbc4-730f7b719eed', 'ORD-20251116-1A39A679', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('e9686de4-c731-4bd2-bf72-352bf6d1f287', 'ORD-20251116-25A3E56A', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('3b8ab888-2628-4d42-87d9-2fc8fdbea7f1', 'ORD-20251116-2CE7CB88', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('6c2af83d-6d06-4459-afde-5e7af9dc9c3e', 'ORD-20251116-2CE7CB88', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('8f556535-9bff-4ec3-b03a-792943b1e193', 'ORD-20251116-A0AC040F', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('89c12c24-8a6b-4503-9b12-fe85878a5f4d', 'ORD-20251116-4BB54981', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('473fefca-a592-4251-8783-65fc59eb9a4c', 'ORD-20251116-C040DDC6', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('e143b69a-66dc-42d2-aeb8-da4fabef6f01', 'ORD-20251116-C040DDC6', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('524a3807-8709-41ed-9517-cb3b189007fb', 'ORD-20251116-C94EE761', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('82f4ad5e-fe17-4041-aa7e-0ddafd26d70e', 'ORD-20251116-46C7EAA4', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('54fff094-4f9d-44d6-b6e7-7f6a06377799', 'ORD-20251118-8D2FFA26', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('9e9f31e0-8ae9-4f1a-8aa8-93e5e8e8237e', 'ORD-20251118-8D2FFA26', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('a2a44d77-c8a2-403d-9f05-33b47cad332a', 'ORD-20251118-194F6DEB', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 12, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('97ac9fa5-557b-4350-8da1-ab536b2f5924', 'ORD-20251118-194F6DEB', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 2, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('336d2707-cb7f-4508-b4f3-c5eebe1be296', 'ORD-20251119-FE8DE0A4', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 13, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('098a39ac-b644-4af2-b89a-5a717bc23d7a', 'ORD-20251119-FE8DE0A4', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 2, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('3aba7fcb-c74f-456a-a905-3377e34931b9', 'ORD-20251121-C0EA2769', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 8, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('c2898b59-0c31-4342-8a71-45f038341522', 'ORD-20251123-67D42EB1', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('63a8bd3b-e570-4421-be15-2d555ff0ed63', 'ORD-20251123-FF227E2A', '49439008-3859-4363-9bd5-880a71fcc834', '369a7232-cb27-4194-bcc8-f6d3c560161f', 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('a6f838d8-a89a-423a-a558-94d072b1521d', 'ORD-20251123-89289A8B', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('1d9daca1-540a-4530-8fc2-723ba877328f', 'ORD-20251123-89289A8B', 'ed778c23-b212-4d37-8fc0-09d6a5a5730f', NULL, 1, 8000.00, 0.00);
INSERT INTO public.order_items VALUES ('aeaf628e-659a-4d4d-bd33-e726f2283bec', 'ORD-20251123-A125BDA6', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('ec1345b0-c75f-4f60-9d81-0d1c1fdd7799', 'ORD-20251123-5F089540', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('1b16269d-4321-44a9-8b25-dcc809c79da5', 'ORD-20251123-B4FE826B', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('d1c37c22-8f6f-440c-b805-0a2d17c1a158', 'ORD-20251123-B4FE826B', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('d592adb8-d307-4857-b516-704314c01447', 'ORD-20251123-652EA4F8', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', 'baef8919-e6bc-4940-88ca-affa0084f13d', 3, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('efbaea2c-d40e-4d30-bc8e-33453c6df319', 'ORD-20251123-652EA4F8', 'bed95cc1-344d-450e-841b-11f1d84e52bd', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 22000.00, 0.00);
INSERT INTO public.order_items VALUES ('a67a25b6-f9e6-4c57-821c-1a864333c93e', 'ORD-20251123-652EA4F8', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('e552e113-dd2d-416a-bdff-adb28e9c5fb7', 'ORD-20251123-652EA4F8', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 1, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('6a652224-bec8-4d61-bed9-28ba9fed162b', 'ORD-20251123-1F793844', '4676eedd-0a48-4f55-964d-bebbec7042a1', NULL, 2, 25000.00, 0.00);
INSERT INTO public.order_items VALUES ('661806a1-ba35-4cd6-9a79-975f8dbf7d9d', 'ORD-20251123-1F793844', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('f60e9c26-18e0-46c7-b990-0b07f4f6db4e', 'ORD-20251123-1F793844', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('e19d0bf3-4152-4869-8224-a365d2fcd81f', 'ORD-20251123-9FF47ED5', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('40091206-fbda-4272-8ab6-a6ecb84fd539', 'ORD-20251123-9FF47ED5', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('9186b8d9-570c-4160-bbe8-efa41bfc416f', 'ORD-20251123-E24E620A', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 1, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('37ce01f2-9e66-4102-b48c-d991f003351a', 'ORD-20251123-E24E620A', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('6f842592-5363-4b49-8441-bff57979f620', 'ORD-20251123-5F18CF42', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);
INSERT INTO public.order_items VALUES ('edf24ea3-0337-4076-b9b5-b2b3e2936d59', 'ORD-20251123-0160F18C', '60f3540b-b322-40c9-b7c1-e4c998546d57', NULL, 1, 10000.00, 0.00);
INSERT INTO public.order_items VALUES ('8485eff6-b0ac-448e-b72b-29d239008cb5', 'ORD-20251123-0160F18C', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', '330db7d2-45d5-4bb3-aefb-cdba6289f388', 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('bb906a22-6324-4c72-bd23-770417bceee1', 'ORD-20251123-AAFC3378', 'e0cf9755-cf11-45fc-8857-f68aa6d5903e', NULL, 1, 23000.00, 0.00);
INSERT INTO public.order_items VALUES ('69b5a605-f753-44a4-9681-7adfa77466c1', 'ORD-20251123-19B4C567', '3544903c-d5ae-48a8-b941-306fccaeac4d', NULL, 1, 16000.00, 0.00);
INSERT INTO public.order_items VALUES ('2504cb9b-4fdc-4cb4-aa66-03cf15e9f6e3', 'ORD-20251123-19B4C567', 'a4a08b09-1bf4-4e91-9a73-d2a12670e762', NULL, 1, 30000.00, 0.00);
INSERT INTO public.order_items VALUES ('dcf836c1-4720-42bd-86f7-ac5b9b03ea9b', 'ORD-20251123-19B4C567', '510a5f6d-afc3-4c2c-befb-a17e98320130', NULL, 2, 18000.00, 0.00);


--
-- TOC entry 3459 (class 0 OID 24779)
-- Dependencies: 224
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.orders VALUES ('ORD-20251012-79FB604D', '8f0803cf-723c-40ae-a5ba-b2b88416d93a', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 88000.00, 'PAID', '2025-10-11 22:54:06.16159+00', '2025-10-11 22:54:08.694522+00');
INSERT INTO public.orders VALUES ('ORD-20251012-3E053E87', '26b85c23-7905-4fe4-99a4-793ff72e5a30', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-11 22:55:13.942814+00', '2025-10-11 22:55:18.406982+00');
INSERT INTO public.orders VALUES ('ORD-20251004-53AC4147', '17880ea3-103a-44ad-a44d-21212577f40d', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 10000.00, 'PAID', '2025-10-04 23:42:32.145292+00', '2025-10-04 23:42:33.160703+00');
INSERT INTO public.orders VALUES ('ORD-20251004-8F6F608C', '2c418ec4-cbe6-4872-89ca-cb3601517901', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-04 23:48:36.934402+00', '2025-10-04 23:48:37.847948+00');
INSERT INTO public.orders VALUES ('ORD-20251004-D090FF18', 'bb7cb342-233f-482d-bc99-e6fce651c249', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-04 23:48:55.74379+00', '2025-10-04 23:48:58.089401+00');
INSERT INTO public.orders VALUES ('ORD-20251004-556DFFC4', '1ab61c75-4819-4123-9dc6-a42e18a3ebcf', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 16000.00, 'PAID', '2025-10-04 23:49:07.807873+00', '2025-10-04 23:49:08.949703+00');
INSERT INTO public.orders VALUES ('ORD-20251004-1686FF92', '0e1f01e1-65d7-42f7-ac00-36e18eeff09d', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-04 23:59:10.122605+00', '2025-10-04 23:59:10.870537+00');
INSERT INTO public.orders VALUES ('ORD-20251005-096D9C72', '8f65446b-1446-4cc0-99e6-d9760a654443', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-05 00:05:31.977923+00', '2025-10-05 00:05:32.808641+00');
INSERT INTO public.orders VALUES ('ORD-20251005-905D45F6', 'edf83442-9003-415a-8343-20a8685d6da4', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 54000.00, 'PAID', '2025-10-05 00:05:44.7056+00', '2025-10-05 00:05:46.255642+00');
INSERT INTO public.orders VALUES ('ORD-20251005-2AD0EDC8', 'fa1e3cfe-d5cf-41ea-982e-d3e2b3c6bed6', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-05 00:11:06.616595+00', '2025-10-05 00:11:07.433329+00');
INSERT INTO public.orders VALUES ('ORD-20251005-DDFD3764', 'eaf4698d-a4aa-4074-9df5-528ca4dd74ff', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 22000.00, 'PAID', '2025-10-05 00:15:43.199673+00', '2025-10-05 00:15:43.946968+00');
INSERT INTO public.orders VALUES ('ORD-20251005-8DA0B2C4', 'fa1e3cfe-d5cf-41ea-982e-d3e2b3c6bed6', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 84000.00, 'PAID', '2025-10-05 00:17:07.254003+00', '2025-10-05 00:17:09.156518+00');
INSERT INTO public.orders VALUES ('ORD-20251005-0A876C2C', 'dd4dfe1f-442d-427b-8117-44aa77be4e87', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-05 00:18:46.499698+00', '2025-10-05 00:18:47.560169+00');
INSERT INTO public.orders VALUES ('ORD-20251005-4D533DDC', '34df6060-10e0-4ebe-92c0-20a97ced4604', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 83000.00, 'PAID', '2025-10-05 00:45:35.066976+00', '2025-10-05 00:45:36.269947+00');
INSERT INTO public.orders VALUES ('ORD-20251005-E03FFE39', 'dc258d16-8c6d-4bd4-8cc8-616270c9cdfd', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 22000.00, 'PAID', '2025-10-05 00:46:49.426553+00', '2025-10-05 00:46:50.224641+00');
INSERT INTO public.orders VALUES ('ORD-20251005-9A74930B', '760d21ca-f574-44f8-8117-9606168fd441', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 23000.00, 'PAID', '2025-10-05 00:48:25.793746+00', '2025-10-05 00:48:26.599672+00');
INSERT INTO public.orders VALUES ('ORD-20251005-D099CA21', '8ce309c4-0978-495c-94ce-6659bf6a106c', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-05 00:55:07.076176+00', '2025-10-05 00:55:08.135417+00');
INSERT INTO public.orders VALUES ('ORD-20251005-D58459FC', 'b2014c97-b571-4982-a39d-2cff0b5b13e8', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 25000.00, 'PAID', '2025-10-05 00:57:13.085341+00', '2025-10-05 00:57:22.559294+00');
INSERT INTO public.orders VALUES ('ORD-20251005-5A04372A', 'dfc0511f-56ad-4966-9a10-ce14108026f0', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 36000.00, 'PAID', '2025-10-05 00:58:59.644049+00', '2025-10-05 00:59:00.507894+00');
INSERT INTO public.orders VALUES ('ORD-20251005-82EC1AF0', 'b7722e83-5d40-4c0f-a734-b6253a78d30a', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 18000.00, 'PAID', '2025-10-05 01:00:40.092383+00', '2025-10-05 01:00:40.909374+00');
INSERT INTO public.orders VALUES ('ORD-20251005-2301794D', '666f064f-9266-40e7-b188-d39342fb77bb', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 36000.00, 'PAID', '2025-10-05 01:03:23.256796+00', '2025-10-05 01:03:24.237476+00');
INSERT INTO public.orders VALUES ('ORD-20251005-28E6D413', '61aa4030-e0ce-414d-b278-628710d3cadd', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 25000.00, 'PAID', '2025-10-05 01:20:14.24959+00', '2025-10-05 01:20:15.518473+00');
INSERT INTO public.orders VALUES ('ORD-20251005-0E476468', 'c96ec666-2db3-4914-bc59-6eeb44842b10', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 25000.00, 'PAID', '2025-10-05 01:32:15.478277+00', '2025-10-05 01:32:16.805312+00');
INSERT INTO public.orders VALUES ('ORD-20251005-FFBD0F8A', '33acc0c8-59f6-4102-bdbe-a87542befa69', '0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 30000.00, 'PAID', '2025-10-05 01:55:33.080544+00', '2025-10-05 01:55:34.00356+00');
INSERT INTO public.orders VALUES ('ORD-20251012-8BFE06C9', '8f0803cf-723c-40ae-a5ba-b2b88416d93a', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-11 22:55:57.667517+00', '2025-10-11 22:57:01.213206+00');
INSERT INTO public.orders VALUES ('ORD-20251012-8D1599C7', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-10-11 23:11:37.212688+00', '2025-10-11 23:12:46.806054+00');
INSERT INTO public.orders VALUES ('ORD-20251012-A103CC0A', '8f0803cf-723c-40ae-a5ba-b2b88416d93a', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 12000.00, 'PAID', '2025-10-11 23:14:48.676863+00', '2025-10-11 23:18:02.912757+00');
INSERT INTO public.orders VALUES ('ORD-20251012-B9CCC01F', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-11 23:47:45.931491+00', '2025-10-11 23:48:31.195555+00');
INSERT INTO public.orders VALUES ('ORD-20251012-9082E70A', '8f0803cf-723c-40ae-a5ba-b2b88416d93a', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'PAID', '2025-10-11 23:49:22.603825+00', '2025-10-11 23:49:28.2821+00');
INSERT INTO public.orders VALUES ('ORD-20251012-1F2DC970', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 60000.00, 'PAID', '2025-10-11 23:54:26.808413+00', '2025-10-11 23:54:47.229631+00');
INSERT INTO public.orders VALUES ('ORD-20251012-55E93F73', 'e033af59-257c-4851-98d4-b80e1947b40b', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-12 00:04:19.235189+00', '2025-10-12 00:04:20.088214+00');
INSERT INTO public.orders VALUES ('ORD-20251012-29820780', 'dd65c45e-1724-4222-b3ca-024877ca3a94', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-12 00:07:06.302804+00', '2025-10-12 00:07:08.334119+00');
INSERT INTO public.orders VALUES ('ORD-20251012-E3592706', '3d593603-f16d-438a-bad6-e675f3a868df', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 30000.00, 'PAID', '2025-10-12 00:09:34.875674+00', '2025-10-12 00:09:35.854814+00');
INSERT INTO public.orders VALUES ('ORD-20251012-2ACC419A', '2ffefca4-467e-406b-84a0-7ccc87ef4448', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 16000.00, 'PAID', '2025-10-12 00:15:13.708955+00', '2025-10-12 00:15:16.965836+00');
INSERT INTO public.orders VALUES ('ORD-20251012-3D4E19E7', 'e9d23afa-7d57-4cfe-aca2-b07e29ae765e', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-12 00:15:52.010999+00', '2025-10-12 00:15:52.817054+00');
INSERT INTO public.orders VALUES ('ORD-20251012-F9BEECE1', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 16000.00, 'PAID', '2025-10-12 00:17:32.989772+00', '2025-10-12 00:17:34.186826+00');
INSERT INTO public.orders VALUES ('ORD-20251012-98A04CE3', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-12 00:18:39.019344+00', '2025-10-12 00:18:40.662225+00');
INSERT INTO public.orders VALUES ('ORD-20251012-C29CF2F2', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-10-12 00:19:48.322019+00', '2025-10-12 00:19:49.496487+00');
INSERT INTO public.orders VALUES ('ORD-20251012-DA390E8C', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 16000.00, 'PAID', '2025-10-12 00:23:07.70268+00', '2025-10-12 00:23:08.70022+00');
INSERT INTO public.orders VALUES ('ORD-20251012-3BFDC483', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-12 00:26:43.622795+00', '2025-10-12 00:26:44.708089+00');
INSERT INTO public.orders VALUES ('ORD-20251012-6A50C03F', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-12 00:31:17.688539+00', '2025-10-12 00:31:19.762395+00');
INSERT INTO public.orders VALUES ('ORD-20251012-3D5342C9', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 30000.00, 'PAID', '2025-10-12 00:47:40.791166+00', '2025-10-12 00:48:19.587065+00');
INSERT INTO public.orders VALUES ('ORD-20251012-21C68FE1', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-12 00:52:23.801463+00', '2025-10-12 00:52:25.102026+00');
INSERT INTO public.orders VALUES ('ORD-20251012-2133E0AE', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 20000.00, 'PAID', '2025-10-12 00:57:19.084722+00', '2025-10-12 00:57:21.626628+00');
INSERT INTO public.orders VALUES ('ORD-20251012-DB2578A9', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 34000.00, 'PAID', '2025-10-12 00:59:43.686325+00', '2025-10-12 00:59:47.252473+00');
INSERT INTO public.orders VALUES ('ORD-20251012-3E5E94B9', '577630c8-600e-4872-b160-fbbd4e37c742', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 16000.00, 'PAID', '2025-10-12 01:00:15.189968+00', '2025-10-12 01:00:16.159651+00');
INSERT INTO public.orders VALUES ('ORD-20251012-F9D757C4', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-12 01:01:12.481305+00', '2025-10-12 01:01:13.513843+00');
INSERT INTO public.orders VALUES ('ORD-20251012-EA29651B', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 20000.00, 'PAID', '2025-10-12 01:02:49.01099+00', '2025-10-12 01:02:50.365676+00');
INSERT INTO public.orders VALUES ('ORD-20251012-FE05D61C', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-12 01:07:00.483452+00', '2025-10-12 01:07:01.400229+00');
INSERT INTO public.orders VALUES ('ORD-20251012-778E7657', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-12 01:10:28.136749+00', '2025-10-12 01:10:29.833178+00');
INSERT INTO public.orders VALUES ('ORD-20251012-5A64A918', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-10-12 01:11:17.391761+00', '2025-10-12 01:11:18.223722+00');
INSERT INTO public.orders VALUES ('ORD-20251012-8EFEF814', '0a481909-395e-4dd4-9064-9d6a59d225ef', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 12000.00, 'PAID', '2025-10-12 01:14:34.598653+00', '2025-10-12 01:14:35.787406+00');
INSERT INTO public.orders VALUES ('ORD-20251015-075A02A7', 'f23af093-fc22-48f2-992f-d609e495b430', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-10-15 10:20:37.72854+00', '2025-10-15 10:20:40.292665+00');
INSERT INTO public.orders VALUES ('ORD-20251016-CC94B96C', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-10-16 10:37:23.18642+00', '2025-10-16 10:37:24.874766+00');
INSERT INTO public.orders VALUES ('ORD-20251017-A43D303E', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 250000.00, 'PAID', '2025-10-17 11:53:52.336943+00', '2025-10-17 11:53:57.351249+00');
INSERT INTO public.orders VALUES ('ORD-20251014-CD36A4F1', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'db3da56e-51b6-4766-b865-adefed6ecf2b', 118000.00, 'PAID', '2025-10-14 12:59:55.890255+00', '2025-10-14 13:00:25.788505+00');
INSERT INTO public.orders VALUES ('ORD-20251019-A70B0A26', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'PAID', '2025-10-18 23:36:30.616402+00', '2025-10-18 23:36:32.62494+00');
INSERT INTO public.orders VALUES ('ORD-20251019-71FCDBCC', 'a77a96f4-af1a-4cd0-9bf2-7d64df1f7b3c', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 96000.00, 'PAID', '2025-10-18 23:39:03.277583+00', '2025-10-18 23:39:06.750018+00');
INSERT INTO public.orders VALUES ('ORD-20251019-6A0E5230', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'PAID', '2025-10-18 23:54:52.306305+00', '2025-10-18 23:54:53.763714+00');
INSERT INTO public.orders VALUES ('ORD-20251019-5A092F10', 'af5e9427-6532-4162-bef0-18885b0165a8', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-10-19 00:11:19.362528+00', '2025-10-19 00:11:20.238396+00');
INSERT INTO public.orders VALUES ('ORD-20251019-74A4808C', 'f73132fe-325d-40c4-9e03-e435eb64321b', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 38000.00, 'PAID', '2025-10-19 00:14:48.607034+00', '2025-10-19 00:14:50.211626+00');
INSERT INTO public.orders VALUES ('ORD-20251019-7A08EB70', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-19 00:15:18.498113+00', '2025-10-19 00:15:20.065955+00');
INSERT INTO public.orders VALUES ('ORD-20251019-107C957D', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 36000.00, 'PAID', '2025-10-19 00:24:44.339215+00', '2025-10-19 00:24:45.188887+00');
INSERT INTO public.orders VALUES ('ORD-20251019-D55F8CDA', '3d593603-f16d-438a-bad6-e675f3a868df', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-19 00:27:49.118581+00', '2025-10-19 00:27:50.056458+00');
INSERT INTO public.orders VALUES ('ORD-20251019-56B820AC', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-19 00:38:39.6584+00', '2025-10-19 00:38:40.752694+00');
INSERT INTO public.orders VALUES ('ORD-20251019-C7ABB70C', 'fc22df1d-4679-457c-91b2-abcde4d08500', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-10-19 00:40:24.728161+00', '2025-10-19 00:40:25.577614+00');
INSERT INTO public.orders VALUES ('ORD-20251019-4F734BCB', 'a77a96f4-af1a-4cd0-9bf2-7d64df1f7b3c', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 12000.00, 'PAID', '2025-10-19 00:44:01.543197+00', '2025-10-19 00:44:04.405815+00');
INSERT INTO public.orders VALUES ('ORD-20251019-E494C2E4', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 28000.00, 'PAID', '2025-10-19 00:46:18.530859+00', '2025-10-19 00:46:20.920928+00');
INSERT INTO public.orders VALUES ('ORD-20251019-4B44B7F5', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 44000.00, 'PAID', '2025-10-19 00:48:16.114556+00', '2025-10-19 00:48:38.326199+00');
INSERT INTO public.orders VALUES ('ORD-20251019-D8E15E2A', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-19 00:55:26.157191+00', '2025-10-19 00:55:27.46111+00');
INSERT INTO public.orders VALUES ('ORD-20251019-7029B40D', '13966991-7492-4d78-88af-aac6d605448f', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 42000.00, 'PAID', '2025-10-19 00:59:12.494706+00', '2025-10-19 00:59:13.510369+00');
INSERT INTO public.orders VALUES ('ORD-20251019-498F3370', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 20000.00, 'PAID', '2025-10-19 01:00:52.955803+00', '2025-10-19 01:00:53.815506+00');
INSERT INTO public.orders VALUES ('ORD-20251019-47486130', '3d593603-f16d-438a-bad6-e675f3a868df', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 63000.00, 'PAID', '2025-10-19 01:09:07.710784+00', '2025-10-19 01:09:08.626105+00');
INSERT INTO public.orders VALUES ('ORD-20251019-D1B9968B', '68cc1938-64b3-428f-91b3-f068d73cbae1', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 23000.00, 'PAID', '2025-10-19 01:15:20.018075+00', '2025-10-19 01:15:23.674199+00');
INSERT INTO public.orders VALUES ('ORD-20251019-5072150E', 'a77a96f4-af1a-4cd0-9bf2-7d64df1f7b3c', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 23000.00, 'PAID', '2025-10-19 01:21:28.941604+00', '2025-10-19 01:21:29.761078+00');
INSERT INTO public.orders VALUES ('ORD-20251019-97C25C7D', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-19 01:24:53.950663+00', '2025-10-19 01:24:54.915543+00');
INSERT INTO public.orders VALUES ('ORD-20251019-6AA1FCD6', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 36000.00, 'PAID', '2025-10-19 01:27:51.994819+00', '2025-10-19 01:27:53.377905+00');
INSERT INTO public.orders VALUES ('ORD-20251019-EF2699FF', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-10-19 01:32:05.001799+00', '2025-10-19 01:32:05.881721+00');
INSERT INTO public.orders VALUES ('ORD-20251019-7A498A65', '3779bc39-8cdd-4ce3-9745-58d1763234dd', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 22000.00, 'PAID', '2025-10-19 01:37:14.551604+00', '2025-10-19 01:37:15.510859+00');
INSERT INTO public.orders VALUES ('ORD-20251019-8F6B83E4', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 30000.00, 'PAID', '2025-10-19 01:46:41.711859+00', '2025-10-19 01:46:42.682336+00');
INSERT INTO public.orders VALUES ('ORD-20251019-882487F6', '7ad10082-db5a-4f9d-965c-5e9d643501bb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 47000.00, 'PAID', '2025-10-19 01:48:51.744289+00', '2025-10-19 01:48:52.927091+00');
INSERT INTO public.orders VALUES ('ORD-20251019-D8251078', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 30000.00, 'PAID', '2025-10-19 02:06:26.367642+00', '2025-10-19 02:06:27.283491+00');
INSERT INTO public.orders VALUES ('ORD-20251019-EDFDD36C', 'b61d51e0-27d4-49fb-99f2-5c56552fab75', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 30000.00, 'PAID', '2025-10-19 02:39:36.20354+00', '2025-10-19 02:39:37.195766+00');
INSERT INTO public.orders VALUES ('ORD-20251021-B795DFA3', '68cc1938-64b3-428f-91b3-f068d73cbae1', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-10-21 14:08:37.216629+00', '2025-10-21 14:08:41.579698+00');
INSERT INTO public.orders VALUES ('ORD-20251021-F8D521D0', 'e8769398-75ea-4f53-8c98-e4f76b294a76', '87cc478d-6cde-44a7-811e-2c064671291c', 25000.00, 'PAID', '2025-10-21 14:09:11.789748+00', '2025-10-21 14:09:13.79825+00');
INSERT INTO public.orders VALUES ('ORD-20251022-B5E77D8F', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 250000.00, 'PAID', '2025-10-22 13:09:53.833498+00', '2025-10-22 13:09:55.396492+00');
INSERT INTO public.orders VALUES ('ORD-20251023-242EA846', '7ad10082-db5a-4f9d-965c-5e9d643501bb', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 298000.00, 'PAID', '2025-10-23 05:41:03.50081+00', '2025-10-23 05:41:04.987172+00');
INSERT INTO public.orders VALUES ('ORD-20251104-A26AEA80', 'fd136865-f909-4114-be1a-6acf1c918403', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-11-03 15:28:11.67+00', '2025-11-04 15:28:13.495292+00');
INSERT INTO public.orders VALUES ('ORD-20251104-F2D4FF90', '9714ba3b-f378-40f8-88a7-4d2b1a6eadcf', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-11-04 15:30:39.752044+00', '2025-11-04 15:30:41.496861+00');
INSERT INTO public.orders VALUES ('ORD-20251106-2A263677', 'e8769398-75ea-4f53-8c98-e4f76b294a76', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 150000.00, 'PAID', '2025-11-06 14:57:04.658066+00', '2025-11-06 14:57:06.222911+00');
INSERT INTO public.orders VALUES ('ORD-20251109-621A9AF3', '0ada98d8-7735-45d8-aabc-99da11ed1676', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-09 02:19:26.137125+00', '2025-11-09 02:19:31.124179+00');
INSERT INTO public.orders VALUES ('ORD-20251108-657690F0', '8cc00ddf-e8e2-43ec-889f-de148445d859', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-11-07 00:00:00+00', '2025-11-07 00:00:00+00');
INSERT INTO public.orders VALUES ('ORD-20251109-CE10C02B', '48749636-ce67-4a91-b7f5-e5c264524be7', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-08 23:38:35.138509+00', '2025-11-08 23:38:40.463089+00');
INSERT INTO public.orders VALUES ('ORD-20251109-A34D32D7', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 100000.00, 'PAID', '2025-11-08 23:55:52.744355+00', '2025-11-08 23:55:57.289541+00');
INSERT INTO public.orders VALUES ('ORD-20251109-EC606C83', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 43000.00, 'PAID', '2025-11-09 00:12:02.531323+00', '2025-11-09 00:12:07.538588+00');
INSERT INTO public.orders VALUES ('ORD-20251109-89B0FBDA', '13966991-7492-4d78-88af-aac6d605448f', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 10000.00, 'PENDING', '2025-11-09 01:29:01.696485+00', NULL);
INSERT INTO public.orders VALUES ('ORD-20251109-D59BACF6', '814c2b98-281f-4c43-897a-f822f0711868', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 311000.00, 'PAID', '2025-11-09 01:42:16.884501+00', '2025-11-09 01:42:25.032695+00');
INSERT INTO public.orders VALUES ('ORD-20251109-727124A3', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-11-09 01:50:38.715526+00', '2025-11-09 01:50:48.228251+00');
INSERT INTO public.orders VALUES ('ORD-20251109-A917C6E0', '4047a3b1-408c-44b1-b756-6adbd6a85a82', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-11-09 02:00:45.174109+00', '2025-11-09 02:00:55.608432+00');
INSERT INTO public.orders VALUES ('ORD-20251109-CB65C74D', '92e8e4dc-43c6-47c4-9d7b-372909e2bb98', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 36000.00, 'PAID', '2025-11-09 02:14:26.867904+00', '2025-11-09 02:14:31.046893+00');
INSERT INTO public.orders VALUES ('ORD-20251109-BF71FA98', 'af5e9427-6532-4162-bef0-18885b0165a8', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-09 02:25:15.95353+00', '2025-11-09 02:25:21.774362+00');
INSERT INTO public.orders VALUES ('ORD-20251109-8597E8A5', 'af5e9427-6532-4162-bef0-18885b0165a8', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 61000.00, 'PAID', '2025-11-09 02:32:22.441497+00', '2025-11-09 02:32:27.947569+00');
INSERT INTO public.orders VALUES ('ORD-20251109-2DA4C809', 'f23af093-fc22-48f2-992f-d609e495b430', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 23000.00, 'PAID', '2025-11-09 02:33:53.784074+00', '2025-11-09 02:34:02.830798+00');
INSERT INTO public.orders VALUES ('ORD-20251109-34CD35E2', '576d6b6e-0ade-4290-a631-8291c87d0989', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 96000.00, 'PAID', '2025-11-09 02:43:14.36886+00', '2025-11-09 02:43:19.925405+00');
INSERT INTO public.orders VALUES ('ORD-20251109-3E5F2866', 'acb8547c-bd0d-4417-b5b6-fe12da9b30a0', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 16000.00, 'PAID', '2025-11-09 02:43:32.558359+00', '2025-11-09 02:43:37.870139+00');
INSERT INTO public.orders VALUES ('ORD-20251111-04AE27F0', '862b7d8e-c278-4373-9c42-12911900930e', '87cc478d-6cde-44a7-811e-2c064671291c', 50000.00, 'PAID', '2025-11-11 11:39:19.420998+00', '2025-11-11 11:39:24.678151+00');
INSERT INTO public.orders VALUES ('ORD-20251113-4F278353', '13966991-7492-4d78-88af-aac6d605448f', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 410000.00, 'PAID', '2025-11-13 00:44:54.080263+00', '2025-11-13 00:44:59.531498+00');
INSERT INTO public.orders VALUES ('ORD-20251115-B43899AC', '5378bd0b-866e-4d6b-8398-d8cde52622db', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 375000.00, 'PAID', '2025-11-15 07:18:48.158801+00', '2025-11-15 07:18:52.67551+00');
INSERT INTO public.orders VALUES ('ORD-20251116-D0F1B22E', 'af5e9427-6532-4162-bef0-18885b0165a8', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-11-15 23:00:03.869914+00', '2025-11-15 23:00:08.090989+00');
INSERT INTO public.orders VALUES ('ORD-20251116-2A4D54B2', '3a6c2516-06e2-4b79-abfb-7cf8d450d66d', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 60000.00, 'PAID', '2025-11-15 23:16:49.642382+00', '2025-11-15 23:16:55.96472+00');
INSERT INTO public.orders VALUES ('ORD-20251116-18E06C4F', '7ad10082-db5a-4f9d-965c-5e9d643501bb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-11-15 23:25:05.976654+00', '2025-11-15 23:25:53.471794+00');
INSERT INTO public.orders VALUES ('ORD-20251116-B450E082', '7ad10082-db5a-4f9d-965c-5e9d643501bb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 44000.00, 'PAID', '2025-11-15 23:26:52.922015+00', '2025-11-15 23:26:56.777439+00');
INSERT INTO public.orders VALUES ('ORD-20251116-92E3BA49', '7ad10082-db5a-4f9d-965c-5e9d643501bb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 24000.00, 'PAID', '2025-11-15 23:37:54.877689+00', '2025-11-15 23:38:00.681827+00');
INSERT INTO public.orders VALUES ('ORD-20251116-3A26805F', '3779bc39-8cdd-4ce3-9745-58d1763234dd', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 44000.00, 'PAID', '2025-11-15 23:39:05.082037+00', '2025-11-15 23:39:10.056255+00');
INSERT INTO public.orders VALUES ('ORD-20251116-685C02C4', '7ad10082-db5a-4f9d-965c-5e9d643501bb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 40000.00, 'PAID', '2025-11-15 23:46:23.33593+00', '2025-11-15 23:46:27.958974+00');
INSERT INTO public.orders VALUES ('ORD-20251116-A498BD30', '3779bc39-8cdd-4ce3-9745-58d1763234dd', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-15 23:51:25.954283+00', '2025-11-15 23:51:29.695146+00');
INSERT INTO public.orders VALUES ('ORD-20251116-89AE09BC', 'e9d23afa-7d57-4cfe-aca2-b07e29ae765e', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 44000.00, 'PAID', '2025-11-16 00:03:36.321206+00', '2025-11-16 00:03:40.331913+00');
INSERT INTO public.orders VALUES ('ORD-20251116-BE678EF2', '42e9e0d7-3f2a-4388-9b88-9152a8b1f5db', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 67000.00, 'PAID', '2025-11-16 00:14:01.445904+00', '2025-11-16 00:14:10.416434+00');
INSERT INTO public.orders VALUES ('ORD-20251116-7C3B9F8B', '2df5f39e-27f9-40a9-81f1-0d7cf338b302', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 30000.00, 'PAID', '2025-11-16 00:18:27.968927+00', '2025-11-16 00:18:31.924109+00');
INSERT INTO public.orders VALUES ('ORD-20251116-D6FBE17F', '4197b152-b229-4556-b4cf-e14c16caeac2', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-16 00:23:24.626789+00', '2025-11-16 00:23:28.742185+00');
INSERT INTO public.orders VALUES ('ORD-20251116-D9144411', '3779bc39-8cdd-4ce3-9745-58d1763234dd', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 36000.00, 'PAID', '2025-11-16 00:29:43.171405+00', '2025-11-16 00:29:47.020492+00');
INSERT INTO public.orders VALUES ('ORD-20251116-1A39A679', 'af5e9427-6532-4162-bef0-18885b0165a8', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 36000.00, 'PAID', '2025-11-16 00:39:56.499013+00', '2025-11-16 00:40:01.412399+00');
INSERT INTO public.orders VALUES ('ORD-20251116-25A3E56A', 'ae39ae55-b372-4e38-bec3-a707243c80bb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'PAID', '2025-11-16 00:42:05.380927+00', '2025-11-16 00:42:09.440949+00');
INSERT INTO public.orders VALUES ('ORD-20251116-2CE7CB88', '4fb88497-211b-46c8-90f5-9f2957342575', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 43000.00, 'PAID', '2025-11-16 00:52:52.710136+00', '2025-11-16 00:52:57.241392+00');
INSERT INTO public.orders VALUES ('ORD-20251116-A0AC040F', 'd7c2d813-fdca-4f97-a94c-85a88e550c5f', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 16000.00, 'PAID', '2025-11-16 00:58:27.383195+00', '2025-11-16 00:58:31.458201+00');
INSERT INTO public.orders VALUES ('ORD-20251116-4BB54981', '4f8a8774-9816-4bb8-bf4d-d9a07238ed9e', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 25000.00, 'PAID', '2025-11-16 01:11:39.782553+00', '2025-11-16 01:11:43.979609+00');
INSERT INTO public.orders VALUES ('ORD-20251116-C040DDC6', '2d408d47-2718-4625-9b25-08761c4a2c57', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 45000.00, 'PAID', '2025-11-16 01:17:27.631303+00', '2025-11-16 01:17:32.599497+00');
INSERT INTO public.orders VALUES ('ORD-20251116-C94EE761', '6814cc35-c2c3-4d2f-9d56-aa59eafd2c9b', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-16 01:22:34.54178+00', '2025-11-16 01:22:39.456508+00');
INSERT INTO public.orders VALUES ('ORD-20251116-46C7EAA4', 'd43bd43b-a428-4ec0-8ed4-e3e5ff86587f', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-16 01:34:06.574905+00', '2025-11-16 01:34:11.028294+00');
INSERT INTO public.orders VALUES ('ORD-20251118-8D2FFA26', '8a753fbb-b719-44b0-944a-7be7eab52a6d', '87cc478d-6cde-44a7-811e-2c064671291c', 48000.00, 'PAID', '2025-11-18 10:07:05.870157+00', '2025-11-18 10:07:11.03646+00');
INSERT INTO public.orders VALUES ('ORD-20251118-194F6DEB', '949b05a1-a18c-4375-b7a8-ba20feceaaf3', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 360000.00, 'PAID', '2025-11-18 10:07:48.197708+00', '2025-11-18 10:07:52.434552+00');
INSERT INTO public.orders VALUES ('ORD-20251119-FE8DE0A4', '83312969-3b06-49ee-8260-00b9ddb757da', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 385000.00, 'PAID', '2025-11-19 13:49:26.625807+00', '2025-11-19 13:49:32.552479+00');
INSERT INTO public.orders VALUES ('ORD-20251121-C0EA2769', '0f61c4b1-ed5f-4c67-a8ea-aaa06298df59', '86dd0f86-ad91-41f6-90d2-bc22194bf31e', 200000.00, 'PAID', '2025-11-20 23:12:10.315072+00', '2025-11-20 23:12:14.447316+00');
INSERT INTO public.orders VALUES ('ORD-20251123-67D42EB1', 'a30178b8-9fe0-49f7-835f-e6cfc0e19027', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 23000.00, 'PAID', '2025-11-22 23:01:06.692747+00', '2025-11-22 23:01:20.990781+00');
INSERT INTO public.orders VALUES ('ORD-20251123-FF227E2A', '6abfc33f-85c6-4fa2-b2ee-2d576e358443', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 10000.00, 'PAID', '2025-11-22 23:30:58.400968+00', '2025-11-22 23:31:07.802427+00');
INSERT INTO public.orders VALUES ('ORD-20251123-89289A8B', '4ce2f2ab-890a-412a-b7d5-47a8fbb102b0', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 44000.00, 'PAID', '2025-11-23 00:03:37.786045+00', '2025-11-23 00:04:15.501281+00');
INSERT INTO public.orders VALUES ('ORD-20251123-A125BDA6', '8de4d94e-fd35-475d-a08b-6f383c860482', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-23 00:21:04.684792+00', '2025-11-23 00:21:46.302954+00');
INSERT INTO public.orders VALUES ('ORD-20251123-5F089540', '385b92c9-ba3c-4429-b250-61afc19df6b3', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 18000.00, 'PAID', '2025-11-23 00:33:25.368399+00', '2025-11-23 00:33:29.783929+00');
INSERT INTO public.orders VALUES ('ORD-20251123-B4FE826B', '7d55b366-eb83-49fb-9746-1a1ee8f14520', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 55000.00, 'PAID', '2025-11-23 00:40:52.295259+00', '2025-11-23 00:40:56.536811+00');
INSERT INTO public.orders VALUES ('ORD-20251123-652EA4F8', '5fb620f7-5661-4c36-8e55-8c668cdfc44e', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 155000.00, 'PAID', '2025-11-23 00:55:58.454232+00', '2025-11-23 00:56:04.041548+00');
INSERT INTO public.orders VALUES ('ORD-20251123-1F793844', '7e115f09-58d0-455a-bc58-4bb9603c00ea', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 91000.00, 'PAID', '2025-11-23 01:04:35.339309+00', '2025-11-23 01:04:40.044143+00');
INSERT INTO public.orders VALUES ('ORD-20251123-9FF47ED5', '6c66bc87-6f0f-4fff-92e7-1c1c7f8a3eeb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 46000.00, 'PAID', '2025-11-23 01:14:03.490042+00', '2025-11-23 01:14:08.003691+00');
INSERT INTO public.orders VALUES ('ORD-20251123-E24E620A', '6c66bc87-6f0f-4fff-92e7-1c1c7f8a3eeb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 28000.00, 'PAID', '2025-11-23 01:28:57.401616+00', '2025-11-23 01:29:02.220236+00');
INSERT INTO public.orders VALUES ('ORD-20251123-5F18CF42', 'ee00a8f5-5197-4261-851f-4f4f5c8b53ab', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 36000.00, 'PAID', '2025-11-23 01:32:35.67783+00', '2025-11-23 01:32:39.903409+00');
INSERT INTO public.orders VALUES ('ORD-20251123-0160F18C', 'a57f96f9-aa7b-4f6f-8e55-e62ca0aac6a4', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 40000.00, 'PAID', '2025-11-23 01:40:43.662135+00', '2025-11-23 01:40:48.798089+00');
INSERT INTO public.orders VALUES ('ORD-20251123-AAFC3378', 'c252218f-d562-4e32-bc81-0d60bb0c7abb', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 23000.00, 'PAID', '2025-11-23 01:45:12.113569+00', '2025-11-23 01:45:16.04335+00');
INSERT INTO public.orders VALUES ('ORD-20251123-19B4C567', '6dfb00d0-6e45-49c8-ac1c-26fad22cddca', 'f3d59ce9-0cd5-46cb-935c-9c12033134e9', 82000.00, 'PAID', '2025-11-23 01:52:28.508042+00', '2025-11-23 01:52:40.178328+00');


--
-- TOC entry 3456 (class 0 OID 24748)
-- Dependencies: 221
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.product_variants VALUES ('60f3540b-b322-40c9-b7c1-e4c998546d57', '8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Isi 2', 10000.00, '2025-10-02 04:24:03.712734+00');
INSERT INTO public.product_variants VALUES ('54eab302-2dbc-45cf-b072-b7b90449eace', '8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Isi 2 + Topping', 12000.00, '2025-10-02 04:24:03.735248+00');
INSERT INTO public.product_variants VALUES ('510a5f6d-afc3-4c2c-befb-a17e98320130', '8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Isi 4', 18000.00, '2025-10-02 04:24:03.756317+00');
INSERT INTO public.product_variants VALUES ('bed95cc1-344d-450e-841b-11f1d84e52bd', '8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Isi 4 + Topping', 22000.00, '2025-10-02 04:24:03.778829+00');
INSERT INTO public.product_variants VALUES ('4676eedd-0a48-4f55-964d-bebbec7042a1', '8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Isi 6', 25000.00, '2025-10-02 04:24:03.799702+00');
INSERT INTO public.product_variants VALUES ('a4a08b09-1bf4-4e91-9a73-d2a12670e762', '8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Isi 6 + Topping', 30000.00, '2025-10-02 04:24:03.820948+00');
INSERT INTO public.product_variants VALUES ('ed778c23-b212-4d37-8fc0-09d6a5a5730f', '2af11905-8c3d-4710-98ba-4614cabffc16', 'Isi 2', 8000.00, '2025-10-02 04:24:03.841916+00');
INSERT INTO public.product_variants VALUES ('49439008-3859-4363-9bd5-880a71fcc834', '2af11905-8c3d-4710-98ba-4614cabffc16', 'Isi 2 + Topping', 10000.00, '2025-10-02 04:24:03.863573+00');
INSERT INTO public.product_variants VALUES ('3544903c-d5ae-48a8-b941-306fccaeac4d', '2af11905-8c3d-4710-98ba-4614cabffc16', 'Isi 4', 16000.00, '2025-10-02 04:24:03.8851+00');
INSERT INTO public.product_variants VALUES ('07552090-8fd4-48bd-b70f-70e1c0d96065', '2af11905-8c3d-4710-98ba-4614cabffc16', 'Isi 4 + Topping', 20000.00, '2025-10-02 04:24:03.906505+00');
INSERT INTO public.product_variants VALUES ('e0cf9755-cf11-45fc-8857-f68aa6d5903e', '2af11905-8c3d-4710-98ba-4614cabffc16', 'Isi 6', 23000.00, '2025-10-02 04:24:03.927931+00');
INSERT INTO public.product_variants VALUES ('c16bb391-a8df-4c86-9b66-63bb12f03e76', '2af11905-8c3d-4710-98ba-4614cabffc16', 'Isi 6 + Topping', 28000.00, '2025-10-02 04:24:03.948881+00');
INSERT INTO public.product_variants VALUES ('a12a5e8d-3539-48c0-8a6c-d0db7e0d2ff5', 'ae1137d4-a044-4ea3-95d7-d321c3445768', 'Koin', 20000.00, '2025-11-22 14:23:26.071932+00');
INSERT INTO public.product_variants VALUES ('0f185cfa-1099-417a-ba3e-09a401eab9ba', 'ae1137d4-a044-4ea3-95d7-d321c3445768', 'Kemplang', 13000.00, '2025-11-22 14:23:54.040571+00');
INSERT INTO public.product_variants VALUES ('757eb2c0-f4a7-47e2-9e98-ed6295c83379', 'ae1137d4-a044-4ea3-95d7-d321c3445768', 'Keriting', 20000.00, '2025-11-22 14:24:15.4446+00');


--
-- TOC entry 3455 (class 0 OID 24738)
-- Dependencies: 220
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.products VALUES ('8f0aa2ed-c85d-4b8e-ba03-75761378977d', 'Dimsum Mentai', 'Dimsum dengan > 80% daging ayam dan saus mentai yang enak dan creamy', 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/dimsum-mentai.png', true, '2025-10-02 04:24:03.668427+00');
INSERT INTO public.products VALUES ('2af11905-8c3d-4710-98ba-4614cabffc16', 'Dimsum Original', 'Dimsum dengan > 80% daging ayam yang lezat sekali', 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/dimsum-ori.png', true, '2025-10-02 04:24:03.690905+00');
INSERT INTO public.products VALUES ('ae1137d4-a044-4ea3-95d7-d321c3445768', 'Kerupuk Mamah', '', 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/07585ea3-1181-40e0-93a1-1bbd27477010.jpg', true, '2025-11-22 14:22:44.418879+00');


--
-- TOC entry 3461 (class 0 OID 24816)
-- Dependencies: 226
-- Data for Name: response_codes; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.response_codes VALUES ('SAJI-00-001', 'Success.', 'Berhasil.', 'Generic success response');
INSERT INTO public.response_codes VALUES ('SAJI-00-400', 'Bad Request.', 'Request Tidak Valid.', 'Generic bad request from client');
INSERT INTO public.response_codes VALUES ('SAJI-01-404', 'Order not found.', 'Pesanan tidak ditemukan.', 'Used when an order ID does not exist');


--
-- TOC entry 3453 (class 0 OID 24716)
-- Dependencies: 218
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.roles VALUES ('3e9fbf8f-a1c9-427f-8290-c329bdd30b3f', 'ADMIN');
INSERT INTO public.roles VALUES ('133162f3-c5bc-4905-9582-94a89d06b14a', 'CASHIER');


--
-- TOC entry 3457 (class 0 OID 24760)
-- Dependencies: 222
-- Data for Name: toppings; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.toppings VALUES ('330db7d2-45d5-4bb3-aefb-cdba6289f388', 'Keju Cheddar', 0.00, true, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/keju-cheddar.png', '2025-10-02 04:24:03.970092+00');
INSERT INTO public.toppings VALUES ('369a7232-cb27-4194-bcc8-f6d3c560161f', 'Keju Quickmelt', 0.00, true, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/keju-quickmelt.png', '2025-10-02 04:24:03.991902+00');
INSERT INTO public.toppings VALUES ('385804c7-125f-4f42-9c44-816d0df4ddd7', 'Nori Flakes', 0.00, true, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/nori-flakes.png', '2025-10-02 04:24:04.012749+00');
INSERT INTO public.toppings VALUES ('baef8919-e6bc-4940-88ca-affa0084f13d', 'Katsuboshi', 0.00, true, 'https://saji-kitchen-asset.s3.ap-southeast-1.amazonaws.com/katsuboshi.png', '2025-10-02 04:24:04.033761+00');


--
-- TOC entry 3454 (class 0 OID 24724)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.users VALUES ('0475a0a4-c1ef-427c-b822-8c2adbd17bcd', 'CFDBEKASI', '$2a$12$nYIt2xs6dRWK8XHV6/EdruuBuqiN3DQJ48cVXZEhR9yRi0RXT.HGS', '133162f3-c5bc-4905-9582-94a89d06b14a', '2025-10-02 04:24:03.644574+00', true);
INSERT INTO public.users VALUES ('d604e26e-a32f-4518-90f7-ced6641801ee', 'ADMIN01', '$2a$12$nYIt2xs6dRWK8XHV6/EdruuBuqiN3DQJ48cVXZEhR9yRi0RXT.HGS', '3e9fbf8f-a1c9-427f-8290-c329bdd30b3f', '2025-10-06 05:26:54.351202+00', true);
INSERT INTO public.users VALUES ('86dd0f86-ad91-41f6-90d2-bc22194bf31e', 'FORESTA', '$2a$10$sstjqWOUZ/QLWdl7kChJrOoAMmqCmiDOfQlwU6cck2WFBgj8C1ay2', '133162f3-c5bc-4905-9582-94a89d06b14a', '2025-10-10 16:17:47.787953+00', true);
INSERT INTO public.users VALUES ('f3d59ce9-0cd5-46cb-935c-9c12033134e9', 'CFDSENAYAN', '$2a$10$UiRKt.YcLgVlWYc9iUGPH.cNq37b0eVqF2ZEWkkMhNnrrV5WrFHcy', '133162f3-c5bc-4905-9582-94a89d06b14a', '2025-10-10 16:17:36.566548+00', true);
INSERT INTO public.users VALUES ('db3da56e-51b6-4766-b865-adefed6ecf2b', 'FAMILY', '$2a$10$T2IV1npKkxkqUQnKFw5X8u5koShxPlaouEkJaVyN2Ayxwx8zSoTFm', '133162f3-c5bc-4905-9582-94a89d06b14a', '2025-10-14 12:58:58.928593+00', true);
INSERT INTO public.users VALUES ('87cc478d-6cde-44a7-811e-2c064671291c', 'GOFOOD', '$2a$10$QgwBAPvKzGEPLV3ejeT7DOTEhAoogQyOCm/yzbWADgML.M2S1e8/m', '133162f3-c5bc-4905-9582-94a89d06b14a', '2025-10-21 14:07:19.132689+00', true);


--
-- TOC entry 3463 (class 0 OID 41002)
-- Dependencies: 228
-- Data for Name: variant_inventory_mapping; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.variant_inventory_mapping VALUES ('60f3540b-b322-40c9-b7c1-e4c998546d57', 'def41244-3737-4cd1-8b17-c3fb2526aaec', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('54eab302-2dbc-45cf-b072-b7b90449eace', 'def41244-3737-4cd1-8b17-c3fb2526aaec', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('ed778c23-b212-4d37-8fc0-09d6a5a5730f', 'def41244-3737-4cd1-8b17-c3fb2526aaec', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('49439008-3859-4363-9bd5-880a71fcc834', 'def41244-3737-4cd1-8b17-c3fb2526aaec', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('510a5f6d-afc3-4c2c-befb-a17e98320130', 'e48fc67e-8741-4565-b10e-974b2a4a6dc3', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('bed95cc1-344d-450e-841b-11f1d84e52bd', 'e48fc67e-8741-4565-b10e-974b2a4a6dc3', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('3544903c-d5ae-48a8-b941-306fccaeac4d', 'e48fc67e-8741-4565-b10e-974b2a4a6dc3', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('07552090-8fd4-48bd-b70f-70e1c0d96065', 'e48fc67e-8741-4565-b10e-974b2a4a6dc3', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('4676eedd-0a48-4f55-964d-bebbec7042a1', 'f19c3438-61d3-47eb-98b6-0ee495a76cf1', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('a4a08b09-1bf4-4e91-9a73-d2a12670e762', 'f19c3438-61d3-47eb-98b6-0ee495a76cf1', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('e0cf9755-cf11-45fc-8857-f68aa6d5903e', 'f19c3438-61d3-47eb-98b6-0ee495a76cf1', 1);
INSERT INTO public.variant_inventory_mapping VALUES ('c16bb391-a8df-4c86-9b66-63bb12f03e76', 'f19c3438-61d3-47eb-98b6-0ee495a76cf1', 1);


--
-- TOC entry 3281 (class 2606 OID 24778)
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- TOC entry 3283 (class 2606 OID 24776)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3297 (class 2606 OID 57352)
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (expense_id);


--
-- TOC entry 3291 (class 2606 OID 41001)
-- Name: inventory_items inventory_items_name_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_name_key UNIQUE (name);


--
-- TOC entry 3293 (class 2606 OID 40999)
-- Name: inventory_items inventory_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 3287 (class 2606 OID 24800)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 3285 (class 2606 OID 24784)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3277 (class 2606 OID 24754)
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (variant_id);


--
-- TOC entry 3275 (class 2606 OID 24747)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3289 (class 2606 OID 24822)
-- Name: response_codes response_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.response_codes
    ADD CONSTRAINT response_codes_pkey PRIMARY KEY (code);


--
-- TOC entry 3267 (class 2606 OID 24721)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3269 (class 2606 OID 24723)
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- TOC entry 3279 (class 2606 OID 24767)
-- Name: toppings toppings_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.toppings
    ADD CONSTRAINT toppings_pkey PRIMARY KEY (topping_id);


--
-- TOC entry 3271 (class 2606 OID 24730)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3273 (class 2606 OID 24732)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3295 (class 2606 OID 41007)
-- Name: variant_inventory_mapping variant_inventory_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.variant_inventory_mapping
    ADD CONSTRAINT variant_inventory_mapping_pkey PRIMARY KEY (variant_id, inventory_item_id);


--
-- TOC entry 3300 (class 2606 OID 24785)
-- Name: orders fk_customer; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- TOC entry 3305 (class 2606 OID 41013)
-- Name: variant_inventory_mapping fk_inventory_item; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.variant_inventory_mapping
    ADD CONSTRAINT fk_inventory_item FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(item_id) ON DELETE CASCADE;


--
-- TOC entry 3302 (class 2606 OID 24801)
-- Name: order_items fk_order; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 3299 (class 2606 OID 24755)
-- Name: product_variants fk_product; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 3298 (class 2606 OID 24733)
-- Name: users fk_role; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- TOC entry 3303 (class 2606 OID 24811)
-- Name: order_items fk_topping; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_topping FOREIGN KEY (topping_id) REFERENCES public.toppings(topping_id);


--
-- TOC entry 3301 (class 2606 OID 24790)
-- Name: orders fk_user; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3307 (class 2606 OID 57353)
-- Name: expenses fk_user_expense; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT fk_user_expense FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3304 (class 2606 OID 24806)
-- Name: order_items fk_variant; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_variant FOREIGN KEY (variant_id) REFERENCES public.product_variants(variant_id);


--
-- TOC entry 3306 (class 2606 OID 41008)
-- Name: variant_inventory_mapping fk_variant; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.variant_inventory_mapping
    ADD CONSTRAINT fk_variant FOREIGN KEY (variant_id) REFERENCES public.product_variants(variant_id) ON DELETE CASCADE;


--
-- TOC entry 2099 (class 826 OID 24704)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

--
-- TOC entry 2098 (class 826 OID 24703)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

-- Completed on 2025-12-22 23:37:12 WIB

--
-- PostgreSQL database dump complete
--
CREATE TABLE images (
                        image_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                        name VARCHAR(255),
                        type VARCHAR(100),
                        data BYTEA NOT NULL -- BYTEA adalah tipe data binary di PostgreSQL
);