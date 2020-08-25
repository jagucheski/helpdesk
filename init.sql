
/*usuario*/
CREATE TABLE public.usuario
(
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    nome character varying(255) COLLATE pg_catalog."default",
    senha character varying(255) COLLATE pg_catalog."default",
    telefone character varying(30) COLLATE pg_catalog."default",
    ramal character varying(20) COLLATE pg_catalog."default",
    alterar_senha BOOLEAN NOT NULL DEFAULT FALSE,
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