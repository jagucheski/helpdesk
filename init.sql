
/*usuario*/
CREATE TABLE public.usuario
(
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    nome character varying(255) COLLATE pg_catalog."default",
    senha character varying(255) COLLATE pg_catalog."default",
    telefone character varying(30) COLLATE pg_catalog."default",
    ramal character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT usuario_pk PRIMARY KEY (email)
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
    
    
insert into ROLE values ('ROLE_ADMIN');
insert into ROLE values ('ROLE_USER');

insert into USUARIO values ('admin@parobe.rs.gov.br','Admin','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','35438600','247');
insert into USUARIO values ('maicon@parobe.rs.gov.br','Maicon','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','35438600','247');
insert into USUARIO values ('ti@parobe.rs.gov.br','TI','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','','');

insert into USUARIO_ROLE values ('admin@parobe.rs.gov.br','ROLE_ADMIN');
insert into USUARIO_ROLE values ('admin@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('maicon@parobe.rs.gov.br','ROLE_USER');

