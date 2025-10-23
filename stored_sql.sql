--
-- PostgreSQL database dump
--

\restrict atH3uXzlEYE2Ykrmy0KV0ZYQLu0G3lBOlb79qyQPeRtcKxINcdbsnj8eJe4ZuoY

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-23 05:31:26

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
-- TOC entry 224 (class 1259 OID 18538)
-- Name: auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria (
    id integer NOT NULL,
    tabla character varying(50),
    accion character varying(50),
    usuario character varying(50) DEFAULT CURRENT_USER,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    detalles text
);


ALTER TABLE public.auditoria OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18550)
-- Name: auditoria_empleados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria_empleados (
    id integer NOT NULL,
    empleado_id integer,
    accion character varying(10),
    campo_modificado character varying(50),
    valor_anterior text,
    valor_nuevo text,
    usuario character varying(50) DEFAULT CURRENT_USER,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.auditoria_empleados OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18549)
-- Name: auditoria_empleados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditoria_empleados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditoria_empleados_id_seq OWNER TO postgres;

--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 225
-- Name: auditoria_empleados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditoria_empleados_id_seq OWNED BY public.auditoria_empleados.id;


--
-- TOC entry 223 (class 1259 OID 18537)
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditoria_id_seq OWNER TO postgres;

--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 223
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditoria_id_seq OWNED BY public.auditoria.id;


--
-- TOC entry 220 (class 1259 OID 18509)
-- Name: empleados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleados (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    salario numeric(10,2) NOT NULL,
    departamento character varying(50) NOT NULL,
    fecha_contratacion date DEFAULT CURRENT_DATE,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    CONSTRAINT empleados_salario_check CHECK ((salario >= (0)::numeric))
);


ALTER TABLE public.empleados OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18610)
-- Name: empleados_activos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.empleados_activos AS
 SELECT id,
    nombre,
    salario,
    departamento,
    fecha_contratacion,
    created_at,
    updated_at,
    deleted_at
   FROM public.empleados
  WHERE (deleted_at IS NULL);


ALTER VIEW public.empleados_activos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18508)
-- Name: empleados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleados_id_seq OWNER TO postgres;

--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 219
-- Name: empleados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleados_id_seq OWNED BY public.empleados.id;


--
-- TOC entry 227 (class 1259 OID 18561)
-- Name: estadisticas_departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadisticas_departamento (
    departamento character varying(50) NOT NULL,
    total_empleados integer DEFAULT 0,
    salario_promedio numeric(10,2) DEFAULT 0,
    ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.estadisticas_departamento OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18524)
-- Name: historial_salarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_salarios (
    id integer NOT NULL,
    empleado_id integer,
    salario_anterior numeric(10,2),
    salario_nuevo numeric(10,2),
    fecha_cambio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    motivo character varying(200)
);


ALTER TABLE public.historial_salarios OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18523)
-- Name: historial_salarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_salarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_salarios_id_seq OWNER TO postgres;

--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 221
-- Name: historial_salarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_salarios_id_seq OWNED BY public.historial_salarios.id;


--
-- TOC entry 233 (class 1259 OID 18601)
-- Name: log_operaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_operaciones (
    id integer NOT NULL,
    tabla character varying(50),
    operacion character varying(10),
    cantidad_filas integer,
    usuario character varying(50) DEFAULT CURRENT_USER,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.log_operaciones OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18600)
-- Name: log_operaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_operaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_operaciones_id_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 232
-- Name: log_operaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_operaciones_id_seq OWNED BY public.log_operaciones.id;


--
-- TOC entry 228 (class 1259 OID 18570)
-- Name: presupuesto_departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presupuesto_departamento (
    departamento character varying(50) NOT NULL,
    presupuesto_total numeric(12,2) NOT NULL,
    presupuesto_usado numeric(12,2) DEFAULT 0,
    "año" integer DEFAULT EXTRACT(year FROM CURRENT_DATE)
);


ALTER TABLE public.presupuesto_departamento OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18579)
-- Name: resumen_departamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resumen_departamentos (
    departamento character varying(50) NOT NULL,
    cantidad_empleados integer,
    masa_salarial numeric(12,2),
    salario_promedio numeric(10,2),
    salario_minimo numeric(10,2),
    salario_maximo numeric(10,2),
    ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.resumen_departamentos OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18587)
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id integer NOT NULL,
    producto character varying(100) NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2),
    impuesto numeric(10,2),
    total numeric(10,2),
    fecha_venta timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ventas_cantidad_check CHECK ((cantidad > 0)),
    CONSTRAINT ventas_precio_unitario_check CHECK ((precio_unitario > (0)::numeric))
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18586)
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventas_id_seq OWNER TO postgres;

--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 230
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- TOC entry 4903 (class 2604 OID 18541)
-- Name: auditoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria ALTER COLUMN id SET DEFAULT nextval('public.auditoria_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 18553)
-- Name: auditoria_empleados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria_empleados ALTER COLUMN id SET DEFAULT nextval('public.auditoria_empleados_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 18512)
-- Name: empleados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados ALTER COLUMN id SET DEFAULT nextval('public.empleados_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 18527)
-- Name: historial_salarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_salarios ALTER COLUMN id SET DEFAULT nextval('public.historial_salarios_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 18604)
-- Name: log_operaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_operaciones ALTER COLUMN id SET DEFAULT nextval('public.log_operaciones_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 18590)
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- TOC entry 5100 (class 0 OID 18538)
-- Dependencies: 224
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditoria (id, tabla, accion, usuario, fecha, detalles) FROM stdin;
1	empleados	INSERT	admin	2025-01-15 09:30:00	Contratación masiva Q1
2	empleados	UPDATE	hr_manager	2025-02-01 14:20:00	Ajustes salariales anuales
3	empleados	UPDATE	system	2025-03-10 11:15:00	Actualización de departamentos
4	presupuesto_departamento	UPDATE	finance_admin	2025-01-05 10:00:00	Ajuste presupuesto anual
5	ventas	INSERT	sales_system	2025-04-01 16:45:00	Cierre ventas Q1
6	empleados	INSERT	hr_manager	2025-01-20 09:00:00	Contratación departamento IT
7	empleados	INSERT	hr_manager	2025-02-01 10:30:00	Contratación departamento Ventas
8	empleados	INSERT	hr_manager	2025-02-15 11:45:00	Contratación departamento Marketing
9	empleados	UPDATE	system	2025-03-01 08:00:00	Actualización masiva salarios Q1
10	empleados	UPDATE	hr_admin	2025-03-15 14:20:00	Cambios departamentales
11	historial_salarios	INSERT	system	2025-03-01 08:05:00	Registro cambios salariales
12	ventas	INSERT	sales_system	2025-01-31 23:59:00	Cierre ventas Enero
13	ventas	INSERT	sales_system	2025-02-28 23:59:00	Cierre ventas Febrero
14	ventas	INSERT	sales_system	2025-03-31 23:59:00	Cierre ventas Marzo
15	ventas	INSERT	sales_system	2025-04-30 23:59:00	Cierre ventas Abril
16	presupuesto_departamento	UPDATE	finance_admin	2025-01-01 00:00:00	Ajuste presupuesto año fiscal 2025
17	presupuesto_departamento	UPDATE	finance_admin	2025-04-01 10:00:00	Revisión Q1
18	empleados	INSERT	hr_manager	2025-04-10 09:30:00	Creación departamento Soporte Técnico
19	empleados	INSERT	hr_manager	2025-04-15 11:00:00	Creación departamento Legal
\.


--
-- TOC entry 5102 (class 0 OID 18550)
-- Dependencies: 226
-- Data for Name: auditoria_empleados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditoria_empleados (id, empleado_id, accion, campo_modificado, valor_anterior, valor_nuevo, usuario, fecha) FROM stdin;
\.


--
-- TOC entry 5096 (class 0 OID 18509)
-- Dependencies: 220
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleados (id, nombre, salario, departamento, fecha_contratacion, created_at, updated_at, deleted_at) FROM stdin;
1	Ana García	45000.00	Ventas	2020-03-15	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
2	Carlos López	55000.00	IT	2019-06-01	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
3	María Rodríguez	48000.00	Marketing	2021-01-10	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
4	Juan Pérez	42000.00	Ventas	2022-02-20	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
5	Laura Martínez	62000.00	IT	2018-09-05	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
6	Pedro Sánchez	38000.00	Marketing	2023-03-12	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
7	Sofía González	51000.00	IT	2020-11-22	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
8	Diego Torres	46000.00	Ventas	2021-07-08	2025-10-23 05:15:12.194838	2025-10-23 05:15:12.194838	\N
9	Lucía Fernández	58000.00	IT	2019-01-15	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
10	Miguel Ángel Ruiz	62000.00	IT	2018-03-20	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
11	Patricia Moreno	52000.00	IT	2020-07-10	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
12	Fernando Castro	48000.00	IT	2021-09-15	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
13	Isabel Romero	71000.00	IT	2017-05-22	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
14	Javier Navarro	54000.00	IT	2020-11-08	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
15	Carmen Jiménez	49000.00	IT	2022-02-14	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
16	Ricardo Álvarez	43000.00	Ventas	2020-08-05	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
17	Elena Vargas	47000.00	Ventas	2019-12-10	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
18	Pablo Herrera	41000.00	Ventas	2021-06-18	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
19	Cristina Medina	44000.00	Ventas	2020-04-22	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
20	Andrés Serrano	39000.00	Ventas	2022-10-30	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
21	Beatriz Molina	46000.00	Ventas	2019-07-14	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
22	Gabriel Ortiz	42000.00	Ventas	2021-11-03	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
23	Raquel Delgado	48000.00	Ventas	2018-09-25	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
24	Sergio Vega	45000.00	Marketing	2020-05-12	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
25	Natalia Iglesias	49000.00	Marketing	2019-08-20	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
26	Óscar Ramírez	43000.00	Marketing	2021-03-15	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
27	Daniela Fuentes	47000.00	Marketing	2020-10-08	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
28	Víctor Santana	41000.00	Marketing	2022-01-25	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
29	Silvia Reyes	52000.00	Marketing	2018-11-30	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
30	Lorena Cortés	46000.00	Recursos Humanos	2019-04-18	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
31	Rubén Pascual	48000.00	Recursos Humanos	2020-06-22	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
32	Mónica Gil	44000.00	Recursos Humanos	2021-08-10	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
33	Alberto Campos	50000.00	Recursos Humanos	2019-02-14	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
34	Teresa Núñez	65000.00	Finanzas	2018-07-15	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
35	Enrique Domínguez	68000.00	Finanzas	2017-12-05	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
36	Pilar Cano	62000.00	Finanzas	2019-09-20	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
37	Francisco Velasco	59000.00	Finanzas	2020-11-12	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
38	Rosa Gutiérrez	71000.00	Finanzas	2017-03-08	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
39	Marcos Cabrera	42000.00	Operaciones	2020-04-15	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
40	Sara Rubio	44000.00	Operaciones	2021-07-20	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
41	Adrián Prieto	40000.00	Operaciones	2022-05-10	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
42	Irene Mora	43000.00	Operaciones	2020-12-03	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
43	Luis Peña	45000.00	Operaciones	2019-10-18	2025-10-23 05:20:55.924623	2025-10-23 05:20:55.924623	\N
44	Alejandro Prieto	56000.00	IT	2019-02-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
45	Claudia Vidal	61000.00	IT	2018-06-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
46	Héctor Rojas	53000.00	IT	2020-08-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
47	Verónica Luna	49000.00	IT	2021-10-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
48	Tomás Aguilar	68000.00	IT	2017-11-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
49	Lidia Mendoza	55000.00	IT	2020-03-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
50	Gonzalo Marín	51000.00	IT	2021-05-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
51	Paula Garrido	59000.00	IT	2019-09-14	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
52	Raúl Benítez	64000.00	IT	2018-12-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
53	Marina León	52000.00	IT	2020-07-25	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
54	Ignacio Soler	57000.00	IT	2019-04-30	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
55	Alicia Bravo	50000.00	IT	2021-11-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
56	Emilio Cruz	66000.00	IT	2018-01-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
57	Nuria Carrasco	54000.00	IT	2020-09-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
58	Iván Suárez	48000.00	IT	2022-03-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
59	Marta Blanco	44000.00	Ventas	2020-01-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
60	Jorge Lozano	42000.00	Ventas	2021-02-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
61	Susana Díaz	46000.00	Ventas	2019-11-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
62	Manuel Gil	43000.00	Ventas	2020-06-25	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
63	Eva Rubio	45000.00	Ventas	2019-08-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
64	Antonio Castillo	41000.00	Ventas	2021-09-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
65	Inés Guerrero	47000.00	Ventas	2019-03-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
66	Felipe Santos	42000.00	Ventas	2020-12-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
67	Rocío Méndez	44000.00	Ventas	2020-04-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
68	Adrián Muñoz	40000.00	Ventas	2022-07-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
69	Celia Ferrer	46000.00	Ventas	2019-05-30	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
70	Guillermo Ibáñez	43000.00	Ventas	2021-01-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
71	Amparo Lorenzo	45000.00	Ventas	2020-10-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
72	Jesús Caballero	41000.00	Ventas	2022-02-14	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
73	Esther Ramos	47000.00	Ventas	2019-09-28	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
74	David Pardo	42000.00	Ventas	2021-06-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
75	Gloria Peña	44000.00	Ventas	2020-08-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
76	Jaime Soto	40000.00	Ventas	2022-11-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
77	Inmaculada Vila	46000.00	Ventas	2019-12-17	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
78	Rodrigo Arias	43000.00	Ventas	2021-04-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
79	Miriam Esteban	46000.00	Marketing	2020-02-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
80	César Gallego	48000.00	Marketing	2019-07-25	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
81	Ainhoa Montero	44000.00	Marketing	2021-03-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
82	Bruno Carmona	47000.00	Marketing	2020-09-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
83	Noelia Sanz	45000.00	Marketing	2020-01-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
84	Marcos Hidalgo	49000.00	Marketing	2019-06-14	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
85	Julia Durán	43000.00	Marketing	2021-08-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
86	Ángel Giménez	46000.00	Marketing	2020-05-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
87	Victoria Robles	48000.00	Marketing	2019-11-28	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
88	Samuel Herrero	44000.00	Marketing	2021-02-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
89	Ainara Martín	47000.00	Marketing	2020-07-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
90	Hugo Flores	45000.00	Marketing	2020-12-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
91	Bárbara Calvo	47000.00	Recursos Humanos	2020-03-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
92	Nicolás Vega	49000.00	Recursos Humanos	2019-08-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
93	Dolores Mora	45000.00	Recursos Humanos	2021-01-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
94	Eduardo Pastor	48000.00	Recursos Humanos	2020-06-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
95	Magdalena Sáez	46000.00	Recursos Humanos	2020-11-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
96	Julián Nieto	50000.00	Recursos Humanos	2019-04-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
97	Encarnación Moya	44000.00	Recursos Humanos	2021-07-28	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
98	Mateo Román	47000.00	Recursos Humanos	2020-09-14	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
99	Concepción Torres	66000.00	Finanzas	2018-05-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
100	Agustín Jiménez	64000.00	Finanzas	2019-01-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
101	Remedios Navarro	61000.00	Finanzas	2019-09-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
102	Valentín Alonso	67000.00	Finanzas	2018-03-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
103	Manuela Cruz	63000.00	Finanzas	2019-07-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
104	Sebastián Vargas	69000.00	Finanzas	2017-11-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
105	Josefa Reyes	62000.00	Finanzas	2019-12-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
106	Alfredo Ortega	65000.00	Finanzas	2018-08-14	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
107	Asunción Medina	60000.00	Finanzas	2020-02-28	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
108	Bernardo Silva	68000.00	Finanzas	2018-06-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
109	Fátima Pascual	43000.00	Operaciones	2020-05-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
110	Eugenio Castro	45000.00	Operaciones	2019-10-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
111	Rosario Ortiz	42000.00	Operaciones	2021-03-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
112	Esteban Ruiz	44000.00	Operaciones	2020-08-25	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
113	Angustias Serrano	41000.00	Operaciones	2021-11-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
114	Pascual Iglesias	46000.00	Operaciones	2019-12-05	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
115	Soledad Ramírez	43000.00	Operaciones	2020-07-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
116	Carmelo Fuentes	45000.00	Operaciones	2020-02-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
117	Visitación Santos	42000.00	Operaciones	2021-09-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
118	Maximiliano Delgado	44000.00	Operaciones	2020-04-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
119	Estrella Peña	41000.00	Soporte Técnico	2020-06-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
120	Leandro Gutiérrez	43000.00	Soporte Técnico	2020-03-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
121	Milagros Molina	40000.00	Soporte Técnico	2021-08-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
122	Casiano Cortés	42000.00	Soporte Técnico	2020-11-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
123	Purificación Campos	39000.00	Soporte Técnico	2022-01-25	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
124	Urbano Cabrera	44000.00	Soporte Técnico	2020-04-08	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
125	Vicenta Prieto	41000.00	Soporte Técnico	2021-06-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
126	Saturnino Vidal	43000.00	Soporte Técnico	2020-09-22	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
127	Ascensión Rojas	58000.00	Legal	2019-03-15	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
128	Timoteo Luna	62000.00	Legal	2018-09-20	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
129	Trinidad Aguilar	56000.00	Legal	2019-11-10	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
130	Clemente Mendoza	60000.00	Legal	2019-05-25	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
131	Angélica Marín	57000.00	Legal	2019-08-18	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
132	Demetrio Garrido	61000.00	Legal	2019-01-12	2025-10-23 05:24:58.962975	2025-10-23 05:24:58.962975	\N
\.


--
-- TOC entry 5103 (class 0 OID 18561)
-- Dependencies: 227
-- Data for Name: estadisticas_departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadisticas_departamento (departamento, total_empleados, salario_promedio, ultima_actualizacion) FROM stdin;
Finanzas	15	64666.67	2025-10-23 05:24:58.962975
IT	25	56200.00	2025-10-23 05:24:58.962975
Legal	6	59000.00	2025-10-23 05:24:58.962975
Marketing	20	45750.00	2025-10-23 05:24:58.962975
Operaciones	15	43266.67	2025-10-23 05:24:58.962975
Recursos Humanos	12	47000.00	2025-10-23 05:24:58.962975
Soporte Técnico	8	41625.00	2025-10-23 05:24:58.962975
Ventas	31	43677.42	2025-10-23 05:24:58.962975
\.


--
-- TOC entry 5098 (class 0 OID 18524)
-- Dependencies: 222
-- Data for Name: historial_salarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_salarios (id, empleado_id, salario_anterior, salario_nuevo, fecha_cambio, motivo) FROM stdin;
1	1	42000.00	45000.00	2023-01-15 00:00:00	Aumento anual por desempeño
2	2	52000.00	55000.00	2023-01-15 00:00:00	Aumento anual por desempeño
3	3	45000.00	48000.00	2023-01-15 00:00:00	Aumento anual por desempeño
4	1	45000.00	47000.00	2024-01-15 00:00:00	Ajuste salarial 2024
5	2	55000.00	58000.00	2024-01-15 00:00:00	Ajuste salarial 2024
6	5	58000.00	62000.00	2023-06-01 00:00:00	Promoción a Senior Developer
7	10	39000.00	41000.00	2023-09-01 00:00:00	Aumento por cumplimiento de objetivos
8	15	64000.00	68000.00	2023-03-01 00:00:00	Promoción a Director de Finanzas
9	4	40000.00	42000.00	2023-02-15 00:00:00	Aumento anual
10	6	36000.00	38000.00	2023-02-15 00:00:00	Aumento anual
11	7	48000.00	51000.00	2023-02-15 00:00:00	Aumento anual
12	8	44000.00	46000.00	2023-02-15 00:00:00	Aumento anual
13	11	55000.00	58000.00	2023-05-10 00:00:00	Promoción
14	12	50000.00	52000.00	2023-06-15 00:00:00	Ajuste de mercado
15	13	46000.00	48000.00	2023-06-15 00:00:00	Ajuste de mercado
16	16	43000.00	45000.00	2023-07-01 00:00:00	Buen desempeño
17	17	47000.00	49000.00	2023-07-01 00:00:00	Buen desempeño
18	20	43000.00	44000.00	2023-08-20 00:00:00	Inflación
19	22	44000.00	46000.00	2023-09-10 00:00:00	Certificación obtenida
20	25	62000.00	65000.00	2023-10-01 00:00:00	Promoción a Senior
21	28	45000.00	47000.00	2023-11-15 00:00:00	Revisión anual
22	30	59000.00	62000.00	2023-12-01 00:00:00	Fin de año
23	3	48000.00	50000.00	2024-01-15 00:00:00	Ajuste 2024
24	4	42000.00	44000.00	2024-01-15 00:00:00	Ajuste 2024
25	9	39000.00	41000.00	2024-02-01 00:00:00	Cumplimiento objetivos Q1
26	14	46000.00	48000.00	2024-03-10 00:00:00	Revisión trimestral
27	18	68000.00	71000.00	2024-03-15 00:00:00	Retención de talento
28	21	41000.00	43000.00	2024-04-01 00:00:00	Antigüedad
29	23	52000.00	54000.00	2024-04-20 00:00:00	Proyecto exitoso
30	26	54000.00	56000.00	2024-05-15 00:00:00	Nuevas responsabilidades
31	29	49000.00	51000.00	2024-06-01 00:00:00	Mid-year review
32	31	43000.00	45000.00	2024-06-15 00:00:00	Buen desempeño
33	33	47000.00	49000.00	2024-07-01 00:00:00	Promoción interna
34	35	65000.00	68000.00	2024-08-01 00:00:00	Ajuste de mercado
35	38	44000.00	46000.00	2024-09-01 00:00:00	Incremento regular
36	40	62000.00	65000.00	2024-09-15 00:00:00	Nueva certificación
37	42	46000.00	48000.00	2024-10-01 00:00:00	Revisión anual anticipada
38	45	43000.00	45000.00	2024-10-15 00:00:00	Mejora continua
\.


--
-- TOC entry 5109 (class 0 OID 18601)
-- Dependencies: 233
-- Data for Name: log_operaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_operaciones (id, tabla, operacion, cantidad_filas, usuario, fecha) FROM stdin;
\.


--
-- TOC entry 5104 (class 0 OID 18570)
-- Dependencies: 228
-- Data for Name: presupuesto_departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.presupuesto_departamento (departamento, presupuesto_total, presupuesto_usado, "año") FROM stdin;
IT	500000.00	168000.00	2025
Ventas	400000.00	133000.00	2025
Marketing	350000.00	86000.00	2025
Recursos Humanos	300000.00	188000.00	2025
Finanzas	450000.00	325000.00	2025
Operaciones	280000.00	214000.00	2025
Soporte Técnico	250000.00	168000.00	2025
Legal	380000.00	354000.00	2025
\.


--
-- TOC entry 5105 (class 0 OID 18579)
-- Dependencies: 229
-- Data for Name: resumen_departamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resumen_departamentos (departamento, cantidad_empleados, masa_salarial, salario_promedio, salario_minimo, salario_maximo, ultima_actualizacion) FROM stdin;
Finanzas	15	970000.00	64666.67	59000.00	71000.00	2025-10-23 05:24:58.962975
IT	25	1405000.00	56200.00	48000.00	71000.00	2025-10-23 05:24:58.962975
Legal	6	354000.00	59000.00	56000.00	62000.00	2025-10-23 05:24:58.962975
Marketing	20	915000.00	45750.00	38000.00	52000.00	2025-10-23 05:24:58.962975
Operaciones	15	649000.00	43266.67	40000.00	46000.00	2025-10-23 05:24:58.962975
Recursos Humanos	12	564000.00	47000.00	44000.00	50000.00	2025-10-23 05:24:58.962975
Soporte Técnico	8	333000.00	41625.00	39000.00	44000.00	2025-10-23 05:24:58.962975
Ventas	31	1354000.00	43677.42	39000.00	48000.00	2025-10-23 05:24:58.962975
\.


--
-- TOC entry 5107 (class 0 OID 18587)
-- Dependencies: 231
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id, producto, cantidad, precio_unitario, subtotal, impuesto, total, fecha_venta) FROM stdin;
1	Laptop HP	2	1000.00	2000.00	420.00	2420.00	2025-10-23 05:15:12.194838
2	Mouse Logitech	10	25.00	250.00	52.50	302.50	2025-10-23 05:15:12.194838
3	Teclado Mecánico	5	80.00	400.00	84.00	484.00	2025-10-23 05:15:12.194838
4	Monitor Dell 27"	5	350.00	1750.00	367.50	2117.50	2025-01-15 10:30:00
5	Webcam HD	15	45.00	675.00	141.75	816.75	2025-01-16 11:20:00
6	Auriculares Bluetooth	8	60.00	480.00	100.80	580.80	2025-01-18 14:15:00
7	Hub USB-C	12	35.00	420.00	88.20	508.20	2025-01-20 09:45:00
8	SSD 1TB	6	120.00	720.00	151.20	871.20	2025-01-22 16:30:00
9	Silla Ergonómica	10	250.00	2500.00	525.00	3025.00	2025-02-01 10:00:00
10	Escritorio Ajustable	4	450.00	1800.00	378.00	2178.00	2025-02-03 11:30:00
11	Lámpara LED	20	30.00	600.00	126.00	726.00	2025-02-05 13:45:00
12	Organizador Cables	25	12.00	300.00	63.00	363.00	2025-02-07 15:20:00
13	Reposapiés	8	40.00	320.00	67.20	387.20	2025-02-10 09:15:00
14	Licencia Office 365	50	85.00	4250.00	892.50	5142.50	2025-03-01 08:00:00
15	Antivirus Empresarial	30	45.00	1350.00	283.50	1633.50	2025-03-05 10:30:00
16	Adobe Creative Cloud	10	55.00	550.00	115.50	665.50	2025-03-08 14:00:00
17	Alfombrilla Ratón XXL	30	15.00	450.00	94.50	544.50	2025-04-01 11:00:00
18	Cable HDMI 2m	40	8.00	320.00	67.20	387.20	2025-04-03 12:30:00
19	Adaptador USB-C	35	18.00	630.00	132.30	762.30	2025-04-05 15:45:00
20	Funda Laptop 15"	20	25.00	500.00	105.00	605.00	2025-04-08 09:30:00
21	Mouse Inalámbrico	18	35.00	630.00	132.30	762.30	2025-04-10 16:00:00
22	Teclado Mecánico RGB	15	85.00	1275.00	267.75	1542.75	2025-01-05 09:15:00
23	Ratón Gaming	20	45.00	900.00	189.00	1089.00	2025-01-06 10:30:00
24	Memoria RAM 16GB	10	95.00	950.00	199.50	1149.50	2025-01-08 11:45:00
25	Disco Duro Externo 2TB	8	85.00	680.00	142.80	822.80	2025-01-10 14:20:00
26	Router WiFi 6	6	120.00	720.00	151.20	871.20	2025-01-12 15:30:00
27	Switch 8 puertos	12	40.00	480.00	100.80	580.80	2025-01-14 09:00:00
28	Cable Ethernet Cat6	50	5.00	250.00	52.50	302.50	2025-01-16 10:15:00
29	Protector Sobretensión	18	25.00	450.00	94.50	544.50	2025-01-18 11:30:00
30	Batería Externa 20000mAh	14	35.00	490.00	102.90	592.90	2025-01-20 13:45:00
31	Cargador USB-C 65W	22	30.00	660.00	138.60	798.60	2025-01-22 15:00:00
32	Micrófono USB Podcast	5	110.00	550.00	115.50	665.50	2025-02-02 09:30:00
33	Cámara Web 4K	8	150.00	1200.00	252.00	1452.00	2025-02-04 10:45:00
34	Trípode Ajustable	12	35.00	420.00	88.20	508.20	2025-02-06 12:00:00
35	Luz LED Ring Light	10	45.00	450.00	94.50	544.50	2025-02-08 13:15:00
36	Green Screen	6	55.00	330.00	69.30	399.30	2025-02-10 14:30:00
37	Soporte Monitor Dual	15	75.00	1125.00	236.25	1361.25	2025-02-12 09:45:00
38	Alfombrilla Escritorio XXL	25	20.00	500.00	105.00	605.00	2025-02-14 11:00:00
39	Reposamuñecas Ergonómico	30	12.00	360.00	75.60	435.60	2025-02-16 12:15:00
40	Soporte Portátil Ajustable	10	40.00	400.00	84.00	484.00	2025-02-18 13:30:00
41	Hub USB 3.0 10 puertos	8	45.00	360.00	75.60	435.60	2025-02-20 14:45:00
42	Tablet Gráfica Wacom	4	280.00	1120.00	235.20	1355.20	2025-03-02 10:00:00
43	Stylus Pen Precision	12	35.00	420.00	88.20	508.20	2025-03-04 11:15:00
44	Escáner Documentos	3	350.00	1050.00	220.50	1270.50	2025-03-06 12:30:00
45	Impresora Láser Color	2	450.00	900.00	189.00	1089.00	2025-03-08 13:45:00
46	Tóner Negro	20	55.00	1100.00	231.00	1331.00	2025-03-10 15:00:00
47	Papel A4 Resma	40	8.00	320.00	67.20	387.20	2025-03-12 09:15:00
48	Grapadora Eléctrica	8	35.00	280.00	58.80	338.80	2025-03-14 10:30:00
49	Perforadora 3 Agujeros	15	12.00	180.00	37.80	217.80	2025-03-16 11:45:00
50	Calculadora Científica	25	18.00	450.00	94.50	544.50	2025-03-18 13:00:00
51	Pizarra Blanca 120x90	6	85.00	510.00	107.10	617.10	2025-03-20 14:15:00
52	Monitor 24" Full HD	10	180.00	1800.00	378.00	2178.00	2025-04-02 09:30:00
53	Monitor 27" 4K	5	450.00	2250.00	472.50	2722.50	2025-04-04 10:45:00
54	Brazo Articulado Monitor	12	65.00	780.00	163.80	943.80	2025-04-06 12:00:00
55	Filtro Privacidad 24"	8	45.00	360.00	75.60	435.60	2025-04-08 13:15:00
56	Cable DisplayPort 2m	20	15.00	300.00	63.00	363.00	2025-04-10 14:30:00
57	Adaptador HDMI a VGA	15	12.00	180.00	37.80	217.80	2025-04-12 09:45:00
58	Splitter HDMI 1x4	10	35.00	350.00	73.50	423.50	2025-04-14 11:00:00
59	Extensor HDMI 15m	6	55.00	330.00	69.30	399.30	2025-04-16 12:15:00
60	Convertidor USB-C HDMI	18	25.00	450.00	94.50	544.50	2025-04-18 13:30:00
61	Dock Station USB-C	4	120.00	480.00	100.80	580.80	2025-04-20 14:45:00
62	Licencia Windows Pro	25	199.00	4975.00	1044.75	6019.75	2025-05-02 10:00:00
63	Adobe Photoshop Anual	8	240.00	1920.00	403.20	2323.20	2025-05-04 11:15:00
64	AutoCAD Licencia	5	1800.00	9000.00	1890.00	10890.00	2025-05-06 12:30:00
65	Kaspersky Total Security	35	40.00	1400.00	294.00	1694.00	2025-05-08 13:45:00
66	Microsoft 365 Business	50	120.00	6000.00	1260.00	7260.00	2025-05-10 15:00:00
67	Zoom Pro Anual	20	150.00	3000.00	630.00	3630.00	2025-05-12 09:15:00
68	Slack Business	30	90.00	2700.00	567.00	3267.00	2025-05-14 10:30:00
69	Dropbox Business 5TB	15	180.00	2700.00	567.00	3267.00	2025-05-16 11:45:00
70	Trello Premium	25	60.00	1500.00	315.00	1815.00	2025-05-18 13:00:00
71	GitHub Team	12	48.00	576.00	120.96	696.96	2025-05-20 14:15:00
72	Mochila Portátil 17"	20	45.00	900.00	189.00	1089.00	2025-06-02 09:30:00
73	Maletín Ejecutivo	12	65.00	780.00	163.80	943.80	2025-06-04 10:45:00
74	Candado Kensington	30	18.00	540.00	113.40	653.40	2025-06-06 12:00:00
75	Limpiador Pantallas Kit	40	8.00	320.00	67.20	387.20	2025-06-08 13:15:00
76	Aire Comprimido	35	6.00	210.00	44.10	254.10	2025-06-10 14:30:00
77	Toallitas Desinfectantes	50	5.00	250.00	52.50	302.50	2025-06-12 09:45:00
78	Etiquetadora Térmica	8	75.00	600.00	126.00	726.00	2025-06-14 11:00:00
79	Rollo Etiquetas 500 Uds	25	12.00	300.00	63.00	363.00	2025-06-16 12:15:00
80	Pistola Silicona Caliente	15	15.00	225.00	47.25	272.25	2025-06-18 13:30:00
81	Organizador Cables 20 Uds	30	10.00	300.00	63.00	363.00	2025-06-20 14:45:00
\.


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 225
-- Name: auditoria_empleados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditoria_empleados_id_seq', 1, false);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 223
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditoria_id_seq', 19, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 219
-- Name: empleados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleados_id_seq', 132, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 221
-- Name: historial_salarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_salarios_id_seq', 38, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 232
-- Name: log_operaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_operaciones_id_seq', 1, false);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 230
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_seq', 81, true);


--
-- TOC entry 4934 (class 2606 OID 18560)
-- Name: auditoria_empleados auditoria_empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria_empleados
    ADD CONSTRAINT auditoria_empleados_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 18548)
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 18522)
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id);


--
-- TOC entry 4937 (class 2606 OID 18569)
-- Name: estadisticas_departamento estadisticas_departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadisticas_departamento
    ADD CONSTRAINT estadisticas_departamento_pkey PRIMARY KEY (departamento);


--
-- TOC entry 4929 (class 2606 OID 18531)
-- Name: historial_salarios historial_salarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_salarios
    ADD CONSTRAINT historial_salarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4945 (class 2606 OID 18609)
-- Name: log_operaciones log_operaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_operaciones
    ADD CONSTRAINT log_operaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4939 (class 2606 OID 18578)
-- Name: presupuesto_departamento presupuesto_departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto_departamento
    ADD CONSTRAINT presupuesto_departamento_pkey PRIMARY KEY (departamento);


--
-- TOC entry 4941 (class 2606 OID 18585)
-- Name: resumen_departamentos resumen_departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumen_departamentos
    ADD CONSTRAINT resumen_departamentos_pkey PRIMARY KEY (departamento);


--
-- TOC entry 4943 (class 2606 OID 18599)
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- TOC entry 4935 (class 1259 OID 18618)
-- Name: idx_auditoria_empleados_empleado_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auditoria_empleados_empleado_id ON public.auditoria_empleados USING btree (empleado_id);


--
-- TOC entry 4925 (class 1259 OID 18616)
-- Name: idx_empleados_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empleados_deleted_at ON public.empleados USING btree (deleted_at);


--
-- TOC entry 4926 (class 1259 OID 18614)
-- Name: idx_empleados_departamento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empleados_departamento ON public.empleados USING btree (departamento);


--
-- TOC entry 4927 (class 1259 OID 18615)
-- Name: idx_empleados_salario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empleados_salario ON public.empleados USING btree (salario);


--
-- TOC entry 4930 (class 1259 OID 18617)
-- Name: idx_historial_empleado_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_historial_empleado_id ON public.historial_salarios USING btree (empleado_id);


--
-- TOC entry 4946 (class 2606 OID 18532)
-- Name: historial_salarios historial_salarios_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_salarios
    ADD CONSTRAINT historial_salarios_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleados(id) ON DELETE CASCADE;


-- Completed on 2025-10-23 05:31:26

--
-- PostgreSQL database dump complete
--

\unrestrict atH3uXzlEYE2Ykrmy0KV0ZYQLu0G3lBOlb79qyQPeRtcKxINcdbsnj8eJe4ZuoY

