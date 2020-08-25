
/*usuario*/
CREATE TABLE public.usuario
(
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    nome character varying(255) COLLATE pg_catalog."default",
    senha character varying(255) COLLATE pg_catalog."default",
    telefone character varying(30) COLLATE pg_catalog."default",
    ramal character varying(20) COLLATE pg_catalog."default",
    alterar_senha BOOLEAN NOT NULL DEFAULT FALSE,
    setor_id int null,    
    CONSTRAINT usuario_pk PRIMARY KEY (email),
    CONSTRAINT usuario_setor_fk FOREIGN KEY (setor_id) REFERENCES setor (id)
	MATCH SIMPLE  ON UPDATE NO ACTION  ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.usuario
    OWNER to postgres;
    
    
/*role*/   
CREATE TABLE public.role
(
    nome character varying(255) COLLATE pg_catalog."default" NOT NULL,
    label character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT role_pk PRIMARY KEY (nome)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.role
    OWNER to postgres;
    
/*usuario_role*/    
CREATE TABLE public.usuario_role
(
    usuario_email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    roles_nome character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT usuario_role_pk PRIMARY KEY (usuario_email, roles_nome),
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_email)
        REFERENCES public.usuario (email) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_nome FOREIGN KEY (roles_nome)
        REFERENCES public.role (nome) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.usuario_role
    OWNER to postgres;
    
/*setor*/  
CREATE TABLE setor
(
  id serial NOT NULL,
  descricao character varying(255) NOT NULL,
  nome character varying(50),
  status boolean NOT NULL,
  CONSTRAINT setor_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.setor
  OWNER TO postgres;

/*tipo_categoria*/    
CREATE TABLE tipo_categoria
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  descricao character varying(255),
  status boolean NOT NULL,
  CONSTRAINT tipo_categoria_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.tipo_categoria
  OWNER TO postgres;

/*categoria*/
CREATE TABLE categoria
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  status boolean NOT NULL,
  CONSTRAINT categoria_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.categoria
  OWNER TO postgres;
  
/*sub_categoria*/
CREATE TABLE public.sub_categoria
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  status boolean NOT NULL,
  CONSTRAINT sub_categoria_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.sub_categoria
  OWNER TO postgres;

/*categoria_sub_categoria*/
 CREATE TABLE categoria_sub_categoria
(
  categoria_id integer NOT NULL,
  sub_categoria_id integer NOT NULL,
  CONSTRAINT fk_csc_categoria_id FOREIGN KEY (categoria_id)
      REFERENCES categoria (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_csc_sub_categoria_id FOREIGN KEY (sub_categoria_id)
      REFERENCES sub_categoria (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE categoria_sub_categoria
  OWNER TO postgres;
  
/*chamado*/
  CREATE TABLE chamado
(
  id serial NOT NULL,
  data_abertura timestamp without time zone,
  data_encerramento timestamp without time zone,
  descricao text NOT NULL,
  status character varying(255) NOT NULL,
  categoria_id integer,
  setor_id integer,
  solicitante_email character varying(255),
  subcategoria_id integer NOT NULL,
  tipocategoria_id integer NOT NULL,
  CONSTRAINT chamado_pkey PRIMARY KEY (id),
  CONSTRAINT fk_solicitante_email FOREIGN KEY (solicitante_email)
      REFERENCES usuario (email) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_subcategoria_id FOREIGN KEY (subcategoria_id)
      REFERENCES sub_categoria (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_categoria_id FOREIGN KEY (categoria_id)
      REFERENCES categoria (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_tipocategoria_id FOREIGN KEY (tipocategoria_id)
      REFERENCES tipo_categoria (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_setor_id FOREIGN KEY (setor_id)
      REFERENCES setor (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE chamado
  OWNER TO postgres;
  
/*mensagem*/
CREATE TABLE mensagem
 (
   id serial NOT NULL,
   data timestamp without time zone,
   descricao text NOT NULL,
   usuario_email character varying(255),
   chamado_id integer,
   CONSTRAINT mensagem_pkey PRIMARY KEY (id),
   CONSTRAINT fk_usuario_email FOREIGN KEY (usuario_email)
       REFERENCES usuario (email) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION,
   CONSTRAINT fk_chamado_id FOREIGN KEY (chamado_id)
       REFERENCES chamado (id) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION
 )
 WITH (
   OIDS=FALSE
 );
 ALTER TABLE mensagem
   OWNER TO postgres;
    
insert into ROLE values ('ROLE_ADMIN','Administrador');
insert into ROLE values ('ROLE_USER','Usuário');
insert into ROLE values ('ROLE_SUP','Suporte');

insert into USUARIO values ('admin@helpdesk.parobe.rs.gov.br','Super Admin','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','','',FALSE);
insert into USUARIO values ('suporte.ti@parobe.rs.gov.br','Suporte TI','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','35438600','247',FALSE);
insert into USUARIO values ('usuario@parobe.rs.gov.br','Usuario','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','35438600','247',FALSE);

insert into USUARIO_ROLE values ('admin@helpdesk.parobe.rs.gov.br','ROLE_ADMIN');
insert into USUARIO_ROLE values ('admin@helpdesk.parobe.rs.gov.br','ROLE_SUP');
insert into USUARIO_ROLE values ('admin@helpdesk.parobe.rs.gov.br','ROLE_USER');

insert into USUARIO_ROLE values ('suporte.ti@parobe.rs.gov.br','ROLE_SUP');
insert into USUARIO_ROLE values ('suporte.ti@parobe.rs.gov.br','ROLE_USER');

insert into USUARIO_ROLE values ('usuario@parobe.rs.gov.br','ROLE_USER');

insert into categoria values (nextval('categoria_id_seq'::regclass),'Suporte - Hardware',true);
insert into categoria values (nextval('categoria_id_seq'::regclass),'Suporte - Infraestrutura',true);
insert into categoria values (nextval('categoria_id_seq'::regclass),'Suporte - Rede',true);
insert into categoria values (nextval('categoria_id_seq'::regclass),'Suporte - Sistemas',true);
insert into categoria values (nextval('categoria_id_seq'::regclass),'Suporte - Software',true);

insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Antivírus - Sophos',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Antivírus - Outros',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Armazenamento',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Certificado Digital',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Cabo Ethernet',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Cabo RJ45',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Computador - Desktop',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Computador - Notebook',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Computador - Servidor',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Conectores',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Conexão',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Estabilizador',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Fibra óptica',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Fio',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Impressora - Etiqueta',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Impressora - Fiscal',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Impressora - Multifuncional - Locada',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Impressora - Multifuncional - Própria',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'IP - Legado',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'IPM - Atende.net',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Legado',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Leitor de Cartões',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Leitor de Código de Barras',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Office - Excel',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Office - Outlook',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Office - Power Point',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Office - Word',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Monitor',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Mouse',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Navegador - Chrome',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Navegador - Firefox',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Navegador - Internet Explorer',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Nobreak',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Projetor',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Switch',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Teclado',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'TCE/RS',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Utilitários',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'VPN',true);
insert into sub_categoria values (nextval('sub_categoria_id_seq'::regclass),'Windows',true);

insert into categoria_sub_categoria values (1,3);
insert into categoria_sub_categoria values (1,7);
insert into categoria_sub_categoria values (1,8);
insert into categoria_sub_categoria values (1,9);
insert into categoria_sub_categoria values (1,12);
insert into categoria_sub_categoria values (1,15);
insert into categoria_sub_categoria values (1,16);
insert into categoria_sub_categoria values (1,17);
insert into categoria_sub_categoria values (1,18);
insert into categoria_sub_categoria values (1,28);
insert into categoria_sub_categoria values (1,29);
insert into categoria_sub_categoria values (1,33);
insert into categoria_sub_categoria values (1,34);
insert into categoria_sub_categoria values (1,35);
insert into categoria_sub_categoria values (1,36);
insert into categoria_sub_categoria values (2,6);
insert into categoria_sub_categoria values (2,14);
insert into categoria_sub_categoria values (2,35);
insert into categoria_sub_categoria values (3,5);
insert into categoria_sub_categoria values (3,6);
insert into categoria_sub_categoria values (3,11);
insert into categoria_sub_categoria values (3,13);
insert into categoria_sub_categoria values (3,14);
insert into categoria_sub_categoria values (3,35);
insert into categoria_sub_categoria values (3,39);
insert into categoria_sub_categoria values (4,19);
insert into categoria_sub_categoria values (4,20);
insert into categoria_sub_categoria values (4,21);
insert into categoria_sub_categoria values (4,37);
insert into categoria_sub_categoria values (5,1);
insert into categoria_sub_categoria values (5,2);
insert into categoria_sub_categoria values (5,4);
insert into categoria_sub_categoria values (5,24);
insert into categoria_sub_categoria values (5,25);
insert into categoria_sub_categoria values (5,26);
insert into categoria_sub_categoria values (5,27);
insert into categoria_sub_categoria values (5,30);
insert into categoria_sub_categoria values (5,31);
insert into categoria_sub_categoria values (5,32);
insert into categoria_sub_categoria values (5,38);

insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Ajuste de Configuração','Ajuste de Configuração',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Desinstalar','Desinstalar',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Defeito','Defeito',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Expansão','Expansão',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Falta de espaço','Falta de espaço',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Incompatível','Incompatível',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Instalar','Instalar',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Lentidão','Lentidão',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Não Conecta','Não Conecta',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Não Funciona','Não Funciona',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Não Liga','Não Liga',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Rompimento','Rompimento',true);
insert into tipo_categoria values (nextval('tipo_categoria_id_seq'::regclass),'Novo usuário','Novo usuário',true);