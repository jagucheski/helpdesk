
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

insert into USUARIO values ('super_admins@helpdesk.parobe.rs.gov.br','Super Admin','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','','',FALSE);
insert into USUARIO values ('admin@parobe.rs.gov.br','Admin','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','35438600','247',FALSE);
insert into USUARIO values ('maicon@parobe.rs.gov.br','Maicon','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','35438600','247',FALSE);
insert into USUARIO values ('ti@parobe.rs.gov.br', 'TI1 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti1@parobe.rs.gov.br','TI1 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti2@parobe.rs.gov.br','TI2 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti3@parobe.rs.gov.br','TI3 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti4@parobe.rs.gov.br','TI4 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti5@parobe.rs.gov.br','TI5 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti6@parobe.rs.gov.br','TI6 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti7@parobe.rs.gov.br','TI7 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti8@parobe.rs.gov.br','TI8 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti9@parobe.rs.gov.br','TI9 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('ti0@parobe.rs.gov.br','TI0 Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tiq@parobe.rs.gov.br','TIq Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tia@parobe.rs.gov.br','TIa Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tiz@parobe.rs.gov.br','TIz Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tix@parobe.rs.gov.br','TIx Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tic@parobe.rs.gov.br','TIc Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tiv@parobe.rs.gov.br','TIv Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tib@parobe.rs.gov.br','TIb Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tin@parobe.rs.gov.br','TIn Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tim@parobe.rs.gov.br','TIm Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);
insert into USUARIO values ('tij@parobe.rs.gov.br','TIj Novo','$2a$10$Tf/PkBfiWUjjvpiKVRB2Ne56Krj/VbHEx0q.rWKfPPgbFrooaZoqm','(51)3543-8600','212',FALSE);

insert into USUARIO_ROLE values ('super_admins@helpdesk.parobe.rs.gov.br','ROLE_ADMIN');
insert into USUARIO_ROLE values ('super_admins@helpdesk.parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('admin@parobe.rs.gov.br','ROLE_ADMIN');
insert into USUARIO_ROLE values ('admin@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('maicon@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti1@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti2@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti3@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti4@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti5@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti6@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti7@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti8@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti9@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('ti0@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tiq@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tia@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tiz@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tix@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tic@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tiv@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tib@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tin@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tim@parobe.rs.gov.br','ROLE_USER');
insert into USUARIO_ROLE values ('tij@parobe.rs.gov.br','ROLE_USER');


