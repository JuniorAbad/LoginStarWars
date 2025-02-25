PGDMP  )    8                }            login    17.2    17.2 P    ]           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            ^           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            _           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            `           1262    17980    login    DATABASE     w   CREATE DATABASE login WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Peru.1252';
    DROP DATABASE login;
                     postgres    false            �            1259    18079    cache    TABLE     �   CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);
    DROP TABLE public.cache;
       public         heap r       postgres    false            �            1259    18086    cache_locks    TABLE     �   CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);
    DROP TABLE public.cache_locks;
       public         heap r       postgres    false            �            1259    17998    especies    TABLE     ?  CREATE TABLE public.especies (
    especie_id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    clasificacion character varying(100),
    designacion character varying(100),
    altura_promedio numeric(5,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.especies;
       public         heap r       postgres    false            �            1259    17997    especies_especie_id_seq    SEQUENCE     �   CREATE SEQUENCE public.especies_especie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.especies_especie_id_seq;
       public               postgres    false    222            a           0    0    especies_especie_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.especies_especie_id_seq OWNED BY public.especies.especie_id;
          public               postgres    false    221            �            1259    18041    historial_consultas    TABLE     �   CREATE TABLE public.historial_consultas (
    historial_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    endpoint character varying(255) NOT NULL,
    params json,
    fecha timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 '   DROP TABLE public.historial_consultas;
       public         heap r       postgres    false            �            1259    18040 $   historial_consultas_historial_id_seq    SEQUENCE     �   CREATE SEQUENCE public.historial_consultas_historial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.historial_consultas_historial_id_seq;
       public               postgres    false    230            b           0    0 $   historial_consultas_historial_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.historial_consultas_historial_id_seq OWNED BY public.historial_consultas.historial_id;
          public               postgres    false    229            �            1259    17982 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap r       postgres    false            �            1259    17981    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public               postgres    false    218            c           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public               postgres    false    217            �            1259    18007 	   peliculas    TABLE     
  CREATE TABLE public.peliculas (
    pelicula_id bigint NOT NULL,
    titulo character varying(100) NOT NULL,
    director character varying(100),
    fecha_estreno date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.peliculas;
       public         heap r       postgres    false            �            1259    18006    peliculas_pelicula_id_seq    SEQUENCE     �   CREATE SEQUENCE public.peliculas_pelicula_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.peliculas_pelicula_id_seq;
       public               postgres    false    224            d           0    0    peliculas_pelicula_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.peliculas_pelicula_id_seq OWNED BY public.peliculas.pelicula_id;
          public               postgres    false    223            �            1259    18064    personaje_pelicula    TABLE     n   CREATE TABLE public.personaje_pelicula (
    personaje_id bigint NOT NULL,
    pelicula_id bigint NOT NULL
);
 &   DROP TABLE public.personaje_pelicula;
       public         heap r       postgres    false            �            1259    18016 
   personajes    TABLE       CREATE TABLE public.personajes (
    personaje_id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    altura numeric(5,2),
    peso numeric(5,2),
    planeta_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.personajes;
       public         heap r       postgres    false            �            1259    18015    personajes_personaje_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personajes_personaje_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.personajes_personaje_id_seq;
       public               postgres    false    226            e           0    0    personajes_personaje_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.personajes_personaje_id_seq OWNED BY public.personajes.personaje_id;
          public               postgres    false    225            �            1259    17989    planetas    TABLE       CREATE TABLE public.planetas (
    planeta_id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    clima character varying(100),
    terreno character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.planetas;
       public         heap r       postgres    false            �            1259    17988    planetas_planeta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.planetas_planeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.planetas_planeta_id_seq;
       public               postgres    false    220            f           0    0    planetas_planeta_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.planetas_planeta_id_seq OWNED BY public.planetas.planeta_id;
          public               postgres    false    219            �            1259    18030    usuarios    TABLE     6  CREATE TABLE public.usuarios (
    usuario_id bigint NOT NULL,
    nombre_usuario character varying(100) NOT NULL,
    "contraseña_hash" character varying(255) NOT NULL,
    email character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    18029    usuarios_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_usuario_id_seq;
       public               postgres    false    228            g           0    0    usuarios_usuario_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;
          public               postgres    false    227            �            1259    18056 	   vehiculos    TABLE     0  CREATE TABLE public.vehiculos (
    vehiculo_id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    modelo character varying(100),
    fabricante character varying(100),
    costo numeric(15,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.vehiculos;
       public         heap r       postgres    false            �            1259    18055    vehiculos_vehiculo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vehiculos_vehiculo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.vehiculos_vehiculo_id_seq;
       public               postgres    false    232            h           0    0    vehiculos_vehiculo_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.vehiculos_vehiculo_id_seq OWNED BY public.vehiculos.vehiculo_id;
          public               postgres    false    231            �           2604    18001    especies especie_id    DEFAULT     z   ALTER TABLE ONLY public.especies ALTER COLUMN especie_id SET DEFAULT nextval('public.especies_especie_id_seq'::regclass);
 B   ALTER TABLE public.especies ALTER COLUMN especie_id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    18044     historial_consultas historial_id    DEFAULT     �   ALTER TABLE ONLY public.historial_consultas ALTER COLUMN historial_id SET DEFAULT nextval('public.historial_consultas_historial_id_seq'::regclass);
 O   ALTER TABLE public.historial_consultas ALTER COLUMN historial_id DROP DEFAULT;
       public               postgres    false    229    230    230            �           2604    17985    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    18010    peliculas pelicula_id    DEFAULT     ~   ALTER TABLE ONLY public.peliculas ALTER COLUMN pelicula_id SET DEFAULT nextval('public.peliculas_pelicula_id_seq'::regclass);
 D   ALTER TABLE public.peliculas ALTER COLUMN pelicula_id DROP DEFAULT;
       public               postgres    false    224    223    224            �           2604    18019    personajes personaje_id    DEFAULT     �   ALTER TABLE ONLY public.personajes ALTER COLUMN personaje_id SET DEFAULT nextval('public.personajes_personaje_id_seq'::regclass);
 F   ALTER TABLE public.personajes ALTER COLUMN personaje_id DROP DEFAULT;
       public               postgres    false    225    226    226            �           2604    17992    planetas planeta_id    DEFAULT     z   ALTER TABLE ONLY public.planetas ALTER COLUMN planeta_id SET DEFAULT nextval('public.planetas_planeta_id_seq'::regclass);
 B   ALTER TABLE public.planetas ALTER COLUMN planeta_id DROP DEFAULT;
       public               postgres    false    219    220    220            �           2604    18033    usuarios usuario_id    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN usuario_id DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    18059    vehiculos vehiculo_id    DEFAULT     ~   ALTER TABLE ONLY public.vehiculos ALTER COLUMN vehiculo_id SET DEFAULT nextval('public.vehiculos_vehiculo_id_seq'::regclass);
 D   ALTER TABLE public.vehiculos ALTER COLUMN vehiculo_id DROP DEFAULT;
       public               postgres    false    231    232    232            Y          0    18079    cache 
   TABLE DATA           7   COPY public.cache (key, value, expiration) FROM stdin;
    public               postgres    false    234   gc       Z          0    18086    cache_locks 
   TABLE DATA           =   COPY public.cache_locks (key, owner, expiration) FROM stdin;
    public               postgres    false    235   �c       M          0    17998    especies 
   TABLE DATA           {   COPY public.especies (especie_id, nombre, clasificacion, designacion, altura_promedio, created_at, updated_at) FROM stdin;
    public               postgres    false    222   �c       U          0    18041    historial_consultas 
   TABLE DATA           `   COPY public.historial_consultas (historial_id, usuario_id, endpoint, params, fecha) FROM stdin;
    public               postgres    false    230   �c       I          0    17982 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public               postgres    false    218   �c       O          0    18007 	   peliculas 
   TABLE DATA           i   COPY public.peliculas (pelicula_id, titulo, director, fecha_estreno, created_at, updated_at) FROM stdin;
    public               postgres    false    224   �d       X          0    18064    personaje_pelicula 
   TABLE DATA           G   COPY public.personaje_pelicula (personaje_id, pelicula_id) FROM stdin;
    public               postgres    false    233   �d       Q          0    18016 
   personajes 
   TABLE DATA           l   COPY public.personajes (personaje_id, nombre, altura, peso, planeta_id, created_at, updated_at) FROM stdin;
    public               postgres    false    226   �d       K          0    17989    planetas 
   TABLE DATA           ^   COPY public.planetas (planeta_id, nombre, clima, terreno, created_at, updated_at) FROM stdin;
    public               postgres    false    220   �d       S          0    18030    usuarios 
   TABLE DATA           q   COPY public.usuarios (usuario_id, nombre_usuario, "contraseña_hash", email, created_at, updated_at) FROM stdin;
    public               postgres    false    228   �d       W          0    18056 	   vehiculos 
   TABLE DATA           k   COPY public.vehiculos (vehiculo_id, nombre, modelo, fabricante, costo, created_at, updated_at) FROM stdin;
    public               postgres    false    232   e       i           0    0    especies_especie_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.especies_especie_id_seq', 1, false);
          public               postgres    false    221            j           0    0 $   historial_consultas_historial_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.historial_consultas_historial_id_seq', 1, false);
          public               postgres    false    229            k           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 9, true);
          public               postgres    false    217            l           0    0    peliculas_pelicula_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.peliculas_pelicula_id_seq', 1, false);
          public               postgres    false    223            m           0    0    personajes_personaje_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.personajes_personaje_id_seq', 1, false);
          public               postgres    false    225            n           0    0    planetas_planeta_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.planetas_planeta_id_seq', 1, false);
          public               postgres    false    219            o           0    0    usuarios_usuario_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 1, false);
          public               postgres    false    227            p           0    0    vehiculos_vehiculo_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.vehiculos_vehiculo_id_seq', 1, false);
          public               postgres    false    231            �           2606    18092    cache_locks cache_locks_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);
 F   ALTER TABLE ONLY public.cache_locks DROP CONSTRAINT cache_locks_pkey;
       public                 postgres    false    235            �           2606    18085    cache cache_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);
 :   ALTER TABLE ONLY public.cache DROP CONSTRAINT cache_pkey;
       public                 postgres    false    234            �           2606    18005    especies especies_nombre_unique 
   CONSTRAINT     \   ALTER TABLE ONLY public.especies
    ADD CONSTRAINT especies_nombre_unique UNIQUE (nombre);
 I   ALTER TABLE ONLY public.especies DROP CONSTRAINT especies_nombre_unique;
       public                 postgres    false    222            �           2606    18003    especies especies_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.especies
    ADD CONSTRAINT especies_pkey PRIMARY KEY (especie_id);
 @   ALTER TABLE ONLY public.especies DROP CONSTRAINT especies_pkey;
       public                 postgres    false    222            �           2606    18049 ,   historial_consultas historial_consultas_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.historial_consultas
    ADD CONSTRAINT historial_consultas_pkey PRIMARY KEY (historial_id);
 V   ALTER TABLE ONLY public.historial_consultas DROP CONSTRAINT historial_consultas_pkey;
       public                 postgres    false    230            �           2606    17987    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public                 postgres    false    218            �           2606    18012    peliculas peliculas_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (pelicula_id);
 B   ALTER TABLE ONLY public.peliculas DROP CONSTRAINT peliculas_pkey;
       public                 postgres    false    224            �           2606    18014 !   peliculas peliculas_titulo_unique 
   CONSTRAINT     ^   ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_titulo_unique UNIQUE (titulo);
 K   ALTER TABLE ONLY public.peliculas DROP CONSTRAINT peliculas_titulo_unique;
       public                 postgres    false    224            �           2606    18068 *   personaje_pelicula personaje_pelicula_pkey 
   CONSTRAINT        ALTER TABLE ONLY public.personaje_pelicula
    ADD CONSTRAINT personaje_pelicula_pkey PRIMARY KEY (personaje_id, pelicula_id);
 T   ALTER TABLE ONLY public.personaje_pelicula DROP CONSTRAINT personaje_pelicula_pkey;
       public                 postgres    false    233    233            �           2606    18028 #   personajes personajes_nombre_unique 
   CONSTRAINT     `   ALTER TABLE ONLY public.personajes
    ADD CONSTRAINT personajes_nombre_unique UNIQUE (nombre);
 M   ALTER TABLE ONLY public.personajes DROP CONSTRAINT personajes_nombre_unique;
       public                 postgres    false    226            �           2606    18021    personajes personajes_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.personajes
    ADD CONSTRAINT personajes_pkey PRIMARY KEY (personaje_id);
 D   ALTER TABLE ONLY public.personajes DROP CONSTRAINT personajes_pkey;
       public                 postgres    false    226            �           2606    17996    planetas planetas_nombre_unique 
   CONSTRAINT     \   ALTER TABLE ONLY public.planetas
    ADD CONSTRAINT planetas_nombre_unique UNIQUE (nombre);
 I   ALTER TABLE ONLY public.planetas DROP CONSTRAINT planetas_nombre_unique;
       public                 postgres    false    220            �           2606    17994    planetas planetas_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.planetas
    ADD CONSTRAINT planetas_pkey PRIMARY KEY (planeta_id);
 @   ALTER TABLE ONLY public.planetas DROP CONSTRAINT planetas_pkey;
       public                 postgres    false    220            �           2606    18039    usuarios usuarios_email_unique 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_unique UNIQUE (email);
 H   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_email_unique;
       public                 postgres    false    228            �           2606    18037 '   usuarios usuarios_nombre_usuario_unique 
   CONSTRAINT     l   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_unique UNIQUE (nombre_usuario);
 Q   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_nombre_usuario_unique;
       public                 postgres    false    228            �           2606    18035    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    228            �           2606    18063 !   vehiculos vehiculos_nombre_unique 
   CONSTRAINT     ^   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_nombre_unique UNIQUE (nombre);
 K   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_nombre_unique;
       public                 postgres    false    232            �           2606    18061    vehiculos vehiculos_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_pkey PRIMARY KEY (vehiculo_id);
 B   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_pkey;
       public                 postgres    false    232            �           2606    18050 :   historial_consultas historial_consultas_usuario_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.historial_consultas
    ADD CONSTRAINT historial_consultas_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.historial_consultas DROP CONSTRAINT historial_consultas_usuario_id_foreign;
       public               postgres    false    4774    228    230            �           2606    18074 9   personaje_pelicula personaje_pelicula_pelicula_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.personaje_pelicula
    ADD CONSTRAINT personaje_pelicula_pelicula_id_foreign FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.personaje_pelicula DROP CONSTRAINT personaje_pelicula_pelicula_id_foreign;
       public               postgres    false    224    233    4762            �           2606    18069 :   personaje_pelicula personaje_pelicula_personaje_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.personaje_pelicula
    ADD CONSTRAINT personaje_pelicula_personaje_id_foreign FOREIGN KEY (personaje_id) REFERENCES public.personajes(personaje_id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.personaje_pelicula DROP CONSTRAINT personaje_pelicula_personaje_id_foreign;
       public               postgres    false    4768    226    233            �           2606    18022 (   personajes personajes_planeta_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.personajes
    ADD CONSTRAINT personajes_planeta_id_foreign FOREIGN KEY (planeta_id) REFERENCES public.planetas(planeta_id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.personajes DROP CONSTRAINT personajes_planeta_id_foreign;
       public               postgres    false    4756    226    220            Y      x������ � �      Z      x������ � �      M      x������ � �      U      x������ � �      I   �   x�e��
�0�k�0��VݻBVv+���a�Br�������4�s��T�@;�X�x0
��f9�<�vv�z9xWCW<	<�8�ӧ��Bۦk��|��,����s��S@�\C��"bK�}y;��v������+��S ��tK9r�!��C)�_遆      O      x������ � �      X      x������ � �      Q      x������ � �      K      x������ � �      S      x������ � �      W      x������ � �     