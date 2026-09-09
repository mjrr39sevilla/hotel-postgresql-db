--
-- PostgreSQL database dump
--

\restrict 0gzHClfW9JJ11es9LvpoaEZ9vdgeDyniiaiVnw38Fdd2szs2cNSmXhBu7thcZpb

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-09-09 09:01:58

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16730)
-- Name: anfitriones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anfitriones (
    id_anfitrion integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    telefono character varying(20),
    ciudad character varying(50),
    fecha_registro date DEFAULT CURRENT_DATE
);


ALTER TABLE public.anfitriones OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16729)
-- Name: anfitriones_id_anfitrion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.anfitriones_id_anfitrion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.anfitriones_id_anfitrion_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 219
-- Name: anfitriones_id_anfitrion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.anfitriones_id_anfitrion_seq OWNED BY public.anfitriones.id_anfitrion;


--
-- TOC entry 233 (class 1259 OID 16867)
-- Name: habitacion_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habitacion_servicio (
    id_habitacion integer NOT NULL,
    id_servicio integer NOT NULL,
    costo_adicional numeric(10,2) DEFAULT 0,
    disponibilidad boolean DEFAULT true
);


ALTER TABLE public.habitacion_servicio OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16769)
-- Name: habitaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habitaciones (
    id_habitacion integer NOT NULL,
    id_anfitrion integer NOT NULL,
    titulo character varying(150) NOT NULL,
    tipo character varying(50) NOT NULL,
    ciudad character varying(50) NOT NULL,
    precio_noche numeric(10,2) NOT NULL,
    capacidad integer NOT NULL,
    descripcion text,
    fecha_publicacion date DEFAULT CURRENT_DATE,
    disponible boolean DEFAULT true,
    CONSTRAINT habitaciones_capacidad_check CHECK ((capacidad > 0)),
    CONSTRAINT habitaciones_precio_noche_check CHECK ((precio_noche > (0)::numeric)),
    CONSTRAINT habitaciones_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['Privada'::character varying, 'Compartida'::character varying])::text[])))
);


ALTER TABLE public.habitaciones OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16768)
-- Name: habitaciones_id_habitacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.habitaciones_id_habitacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habitaciones_id_habitacion_seq OWNER TO postgres;

--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 225
-- Name: habitaciones_id_habitacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.habitaciones_id_habitacion_seq OWNED BY public.habitaciones.id_habitacion;


--
-- TOC entry 222 (class 1259 OID 16743)
-- Name: huespedes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.huespedes (
    id_huesped integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    telefono character varying(20),
    ciudad character varying(50),
    fecha_registro date DEFAULT CURRENT_DATE
);


ALTER TABLE public.huespedes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16742)
-- Name: huespedes_id_huesped_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.huespedes_id_huesped_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.huespedes_id_huesped_seq OWNER TO postgres;

--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 221
-- Name: huespedes_id_huesped_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.huespedes_id_huesped_seq OWNED BY public.huespedes.id_huesped;


--
-- TOC entry 230 (class 1259 OID 16821)
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    id_pago integer NOT NULL,
    id_reserva integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    fecha_pago date DEFAULT CURRENT_DATE,
    metodo_pago character varying(50) NOT NULL,
    estado_pago character varying(50) NOT NULL,
    CONSTRAINT pagos_estado_pago_check CHECK (((estado_pago)::text = ANY ((ARRAY['pendiente'::character varying, 'completado'::character varying, 'cancelado'::character varying])::text[]))),
    CONSTRAINT pagos_monto_check CHECK ((monto > (0)::numeric))
);


ALTER TABLE public.pagos OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16820)
-- Name: pagos_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_id_pago_seq OWNER TO postgres;

--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 229
-- Name: pagos_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_id_pago_seq OWNED BY public.pagos.id_pago;


--
-- TOC entry 232 (class 1259 OID 16843)
-- Name: resenas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resenas (
    id_resena integer NOT NULL,
    id_habitacion integer NOT NULL,
    id_huesped integer NOT NULL,
    calificacion integer NOT NULL,
    comentario text,
    fecha_resena date DEFAULT CURRENT_DATE,
    CONSTRAINT resenas_calificacion_check CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);


ALTER TABLE public.resenas OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16842)
-- Name: resenas_id_resena_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resenas_id_resena_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resenas_id_resena_seq OWNER TO postgres;

--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 231
-- Name: resenas_id_resena_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resenas_id_resena_seq OWNED BY public.resenas.id_resena;


--
-- TOC entry 228 (class 1259 OID 16795)
-- Name: reservas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservas (
    id_reserva integer NOT NULL,
    id_habitacion integer NOT NULL,
    id_huesped integer NOT NULL,
    fecha_checkin date NOT NULL,
    fecha_checkout date NOT NULL,
    estado character varying(50) NOT NULL,
    fecha_reserva date DEFAULT CURRENT_DATE,
    CONSTRAINT reservas_check CHECK ((fecha_checkout > fecha_checkin)),
    CONSTRAINT reservas_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'confirmada'::character varying, 'cancelada'::character varying, 'completada'::character varying])::text[])))
);


ALTER TABLE public.reservas OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16794)
-- Name: reservas_id_reserva_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservas_id_reserva_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservas_id_reserva_seq OWNER TO postgres;

--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 227
-- Name: reservas_id_reserva_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservas_id_reserva_seq OWNED BY public.reservas.id_reserva;


--
-- TOC entry 224 (class 1259 OID 16756)
-- Name: servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicios (
    id_servicio integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    costo_base numeric(10,2)
);


ALTER TABLE public.servicios OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16755)
-- Name: servicios_id_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicios_id_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicios_id_servicio_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 223
-- Name: servicios_id_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicios_id_servicio_seq OWNED BY public.servicios.id_servicio;


--
-- TOC entry 4890 (class 2604 OID 16733)
-- Name: anfitriones id_anfitrion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anfitriones ALTER COLUMN id_anfitrion SET DEFAULT nextval('public.anfitriones_id_anfitrion_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 16772)
-- Name: habitaciones id_habitacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitaciones ALTER COLUMN id_habitacion SET DEFAULT nextval('public.habitaciones_id_habitacion_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 16746)
-- Name: huespedes id_huesped; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.huespedes ALTER COLUMN id_huesped SET DEFAULT nextval('public.huespedes_id_huesped_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 16824)
-- Name: pagos id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos ALTER COLUMN id_pago SET DEFAULT nextval('public.pagos_id_pago_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 16846)
-- Name: resenas id_resena; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas ALTER COLUMN id_resena SET DEFAULT nextval('public.resenas_id_resena_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 16798)
-- Name: reservas id_reserva; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas ALTER COLUMN id_reserva SET DEFAULT nextval('public.reservas_id_reserva_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 16759)
-- Name: servicios id_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios ALTER COLUMN id_servicio SET DEFAULT nextval('public.servicios_id_servicio_seq'::regclass);


--
-- TOC entry 5094 (class 0 OID 16730)
-- Dependencies: 220
-- Data for Name: anfitriones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anfitriones (id_anfitrion, nombre, email, telefono, ciudad, fecha_registro) FROM stdin;
2	Laura García	laura@email.com	3012345678	Medellín	2026-08-16
3	Luis Martínez	luis@email.com	3123456789	Cali	2026-08-16
4	María López	maria@email.com	3134567890	Bogotá	2026-08-16
5	Diego Sánchez	diego@email.com	3145678901	Cartagena	2026-08-16
1	Carlos Ramírez	carlos@email.com	3001111111	Bogotá	2026-08-16
\.


--
-- TOC entry 5107 (class 0 OID 16867)
-- Dependencies: 233
-- Data for Name: habitacion_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habitacion_servicio (id_habitacion, id_servicio, costo_adicional, disponibilidad) FROM stdin;
1	1	0.00	t
1	2	0.00	t
1	3	0.00	t
2	1	0.00	t
2	2	0.00	t
2	3	0.00	t
2	11	25000.00	t
3	1	0.00	t
3	7	0.00	t
4	1	0.00	t
4	2	0.00	t
4	3	0.00	t
5	1	0.00	t
5	7	0.00	t
6	1	0.00	t
6	3	0.00	t
6	9	20000.00	t
7	1	0.00	t
7	2	0.00	t
7	3	0.00	t
7	5	30000.00	t
7	11	25000.00	t
9	1	0.00	t
9	2	0.00	t
9	3	0.00	t
9	10	60000.00	t
10	1	0.00	t
10	2	0.00	t
10	3	0.00	t
10	4	50000.00	t
10	6	40000.00	t
4	4	35000.00	t
\.


--
-- TOC entry 5100 (class 0 OID 16769)
-- Dependencies: 226
-- Data for Name: habitaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habitaciones (id_habitacion, id_anfitrion, titulo, tipo, ciudad, precio_noche, capacidad, descripcion, fecha_publicacion, disponible) FROM stdin;
2	1	Suite Norte	Privada	Bogotá	200000.00	4	Suite amplia con vista	2024-02-01	t
3	1	Apartamento Económico	Compartida	Bogotá	80000.00	1	Apartamento pequeño	2024-01-20	t
4	2	Casa Medellín	Privada	Medellín	180000.00	3	Casa moderna en Medellín	2024-01-10	t
5	2	Habitación Compartida	Compartida	Medellín	60000.00	1	Habitación en casa compartida	2024-02-05	t
6	3	Studio Cali	Privada	Cali	120000.00	2	Studio funcional	2024-01-25	t
7	4	Penthouse Bogotá	Privada	Bogotá	250000.00	6	Penthouse con vista panorámica	2024-02-10	t
8	4	Habitación Económica	Compartida	Bogotá	50000.00	1	Habitación básica	2024-02-15	t
9	5	Departamento Cartagena	Privada	Cartagena	220000.00	4	Departamento en el centro histórico	2024-01-30	t
10	5	Casa Grande	Privada	Cartagena	300000.00	8	Casa para grupos grandes	2024-02-20	t
1	1	Loft Central	Privada	Bogotá	160000.00	2	Loft moderno en el centro	2024-01-15	t
\.


--
-- TOC entry 5096 (class 0 OID 16743)
-- Dependencies: 222
-- Data for Name: huespedes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.huespedes (id_huesped, nombre, email, telefono, ciudad, fecha_registro) FROM stdin;
1	Paula Ríos	paula@email.com	3156789012	Bogotá	2026-08-16
2	Miguel Torres	miguel@email.com	3167890123	Medellín	2026-08-16
3	Ana Martínez	ana@email.com	3178901234	Cali	2026-08-16
4	Mariana López	mariana@email.com	3189012345	Bogotá	2026-08-16
5	Manuel Gómez	manuel@email.com	3190123456	Santa Marta	2026-08-16
6	Sofía Ruiz	sofia@email.com	3201234567	Medellín	2026-08-16
\.


--
-- TOC entry 5104 (class 0 OID 16821)
-- Dependencies: 230
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos (id_pago, id_reserva, monto, fecha_pago, metodo_pago, estado_pago) FROM stdin;
2	2	750000.00	2026-08-16	transferencia	completado
3	3	1400000.00	2026-08-16	tarjeta_credito	pendiente
4	4	160000.00	2026-08-16	efectivo	completado
5	5	900000.00	2026-08-16	tarjeta_credito	completado
6	6	1260000.00	2026-08-16	transferencia	completado
7	7	300000.00	2026-08-16	tarjeta_credito	completado
8	8	600000.00	2026-08-16	tarjeta_credito	pendiente
9	9	1470000.00	2026-08-16	transferencia	completado
10	10	360000.00	2026-08-16	efectivo	completado
11	11	1680000.00	2026-08-16	tarjeta_credito	completado
1	1	700000.00	2026-08-16	tarjeta_credito	completado
\.


--
-- TOC entry 5106 (class 0 OID 16843)
-- Dependencies: 232
-- Data for Name: resenas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resenas (id_resena, id_habitacion, id_huesped, calificacion, comentario, fecha_resena) FROM stdin;
1	1	1	5	Excelente ubicación y muy cómodo	2026-08-16
2	1	2	4	Bueno pero algo ruidoso	2026-08-16
3	2	3	5	Hermoso y limpio	2026-08-16
4	3	4	3	Básico pero funcional	2026-08-16
5	4	1	5	Fantástico anfitrión	2026-08-16
6	6	3	4	Muy agradable	2026-08-16
7	7	6	5	Lujo absoluto	2026-08-16
8	9	1	5	Ubicación increíble en Cartagena	2026-08-16
\.


--
-- TOC entry 5102 (class 0 OID 16795)
-- Dependencies: 228
-- Data for Name: reservas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservas (id_reserva, id_habitacion, id_huesped, fecha_checkin, fecha_checkout, estado, fecha_reserva) FROM stdin;
1	1	1	2024-06-01	2024-06-05	confirmada	2026-08-16
2	1	2	2024-06-10	2024-06-15	confirmada	2026-08-16
4	3	4	2024-06-08	2024-06-10	confirmada	2026-08-16
5	4	1	2024-06-15	2024-06-20	confirmada	2026-08-16
6	4	5	2024-07-01	2024-07-08	confirmada	2026-08-16
7	5	2	2024-06-20	2024-06-25	confirmada	2026-08-16
8	6	3	2024-07-05	2024-07-10	pendiente	2026-08-16
9	7	6	2024-06-15	2024-06-22	confirmada	2026-08-16
10	8	4	2024-07-10	2024-07-12	confirmada	2026-08-16
11	9	1	2024-08-01	2024-08-08	confirmada	2026-08-16
3	2	3	2024-06-05	2024-06-12	confirmada	2026-08-16
\.


--
-- TOC entry 5098 (class 0 OID 16756)
-- Dependencies: 224
-- Data for Name: servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servicios (id_servicio, nombre, descripcion, costo_base) FROM stdin;
1	WiFi	Conexión inalámbrica de alta velocidad	0.00
2	Televisión	Televisor con canales por cable	0.00
3	Aire acondicionado	Sistema de climatización	0.00
4	Piscina	Acceso a piscina compartida	50000.00
5	Gimnasio	Acceso a gimnasio equipado	30000.00
6	Mascotas	Se permiten mascotas	40000.00
7	Cocina	Cocina completa equipada	0.00
8	Lavadora	Acceso a lavadora	0.00
9	Netflix	Acceso a plataforma Netflix	20000.00
10	Desayuno	Desayuno incluido diario	60000.00
11	Parking	Estacionamiento privado	25000.00
12	Aire	Aire acondicionado	15000.00
\.


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 219
-- Name: anfitriones_id_anfitrion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.anfitriones_id_anfitrion_seq', 5, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 225
-- Name: habitaciones_id_habitacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.habitaciones_id_habitacion_seq', 10, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 221
-- Name: huespedes_id_huesped_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.huespedes_id_huesped_seq', 6, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 229
-- Name: pagos_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_id_pago_seq', 12, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 231
-- Name: resenas_id_resena_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resenas_id_resena_seq', 8, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 227
-- Name: reservas_id_reserva_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservas_id_reserva_seq', 12, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 223
-- Name: servicios_id_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicios_id_servicio_seq', 12, true);


--
-- TOC entry 4915 (class 2606 OID 16741)
-- Name: anfitriones anfitriones_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anfitriones
    ADD CONSTRAINT anfitriones_email_key UNIQUE (email);


--
-- TOC entry 4917 (class 2606 OID 16739)
-- Name: anfitriones anfitriones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anfitriones
    ADD CONSTRAINT anfitriones_pkey PRIMARY KEY (id_anfitrion);


--
-- TOC entry 4937 (class 2606 OID 16875)
-- Name: habitacion_servicio habitacion_servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitacion_servicio
    ADD CONSTRAINT habitacion_servicio_pkey PRIMARY KEY (id_habitacion, id_servicio);


--
-- TOC entry 4927 (class 2606 OID 16788)
-- Name: habitaciones habitaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitaciones
    ADD CONSTRAINT habitaciones_pkey PRIMARY KEY (id_habitacion);


--
-- TOC entry 4919 (class 2606 OID 16754)
-- Name: huespedes huespedes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.huespedes
    ADD CONSTRAINT huespedes_email_key UNIQUE (email);


--
-- TOC entry 4921 (class 2606 OID 16752)
-- Name: huespedes huespedes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.huespedes
    ADD CONSTRAINT huespedes_pkey PRIMARY KEY (id_huesped);


--
-- TOC entry 4931 (class 2606 OID 16836)
-- Name: pagos pagos_id_reserva_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_id_reserva_key UNIQUE (id_reserva);


--
-- TOC entry 4933 (class 2606 OID 16834)
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4935 (class 2606 OID 16856)
-- Name: resenas resenas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_pkey PRIMARY KEY (id_resena);


--
-- TOC entry 4929 (class 2606 OID 16809)
-- Name: reservas reservas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_pkey PRIMARY KEY (id_reserva);


--
-- TOC entry 4923 (class 2606 OID 16767)
-- Name: servicios servicios_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_nombre_key UNIQUE (nombre);


--
-- TOC entry 4925 (class 2606 OID 16765)
-- Name: servicios servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_pkey PRIMARY KEY (id_servicio);


--
-- TOC entry 4944 (class 2606 OID 16876)
-- Name: habitacion_servicio habitacion_servicio_id_habitacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitacion_servicio
    ADD CONSTRAINT habitacion_servicio_id_habitacion_fkey FOREIGN KEY (id_habitacion) REFERENCES public.habitaciones(id_habitacion) ON DELETE CASCADE;


--
-- TOC entry 4945 (class 2606 OID 16881)
-- Name: habitacion_servicio habitacion_servicio_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitacion_servicio
    ADD CONSTRAINT habitacion_servicio_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicios(id_servicio) ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 16789)
-- Name: habitaciones habitaciones_id_anfitrion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitaciones
    ADD CONSTRAINT habitaciones_id_anfitrion_fkey FOREIGN KEY (id_anfitrion) REFERENCES public.anfitriones(id_anfitrion) ON DELETE CASCADE;


--
-- TOC entry 4941 (class 2606 OID 16837)
-- Name: pagos pagos_id_reserva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reservas(id_reserva) ON DELETE CASCADE;


--
-- TOC entry 4942 (class 2606 OID 16857)
-- Name: resenas resenas_id_habitacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_id_habitacion_fkey FOREIGN KEY (id_habitacion) REFERENCES public.habitaciones(id_habitacion) ON DELETE CASCADE;


--
-- TOC entry 4943 (class 2606 OID 16862)
-- Name: resenas resenas_id_huesped_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_id_huesped_fkey FOREIGN KEY (id_huesped) REFERENCES public.huespedes(id_huesped) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 16810)
-- Name: reservas reservas_id_habitacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_id_habitacion_fkey FOREIGN KEY (id_habitacion) REFERENCES public.habitaciones(id_habitacion) ON DELETE CASCADE;


--
-- TOC entry 4940 (class 2606 OID 16815)
-- Name: reservas reservas_id_huesped_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_id_huesped_fkey FOREIGN KEY (id_huesped) REFERENCES public.huespedes(id_huesped) ON DELETE CASCADE;


-- Completed on 2026-09-09 09:01:59

--
-- PostgreSQL database dump complete
--

\unrestrict 0gzHClfW9JJ11es9LvpoaEZ9vdgeDyniiaiVnw38Fdd2szs2cNSmXhBu7thcZpb

