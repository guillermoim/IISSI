/*Triggers asociados a secuencias*/
drop sequence seq_municipios;
drop sequence seq_provincias;
drop sequence seq_comunidades;
drop sequence seq_docsIAE;
drop sequence seq_tarjetasCredito;
drop sequence seq_personas;
drop sequence seq_productos;
drop sequence seq_pedidos;
drop sequence seq_lineasDePedido;
drop sequence seq_facturas;
drop sequence seq_lineasDeFactura;
drop sequence seq_valoracionesProductos;
drop sequence seq_envios;
drop sequence seq_cobros;
drop sequence seq_incidencias;
drop sequence seq_soluciones;
drop sequence seq_presupuestos;
drop sequence seq_valoracionesST;
drop sequence seq_reparaciones;
drop sequence seq_alquileres;
drop sequence seq_fotomatones;
drop sequence seq_inscripciones;
drop sequence seq_seminarios;

create sequence seq_municipios;
create sequence seq_provincias;
create sequence seq_comunidades;
create sequence seq_docsIAE;
create sequence seq_tarjetasCredito; 
create sequence seq_personas;
create sequence seq_productos;
create sequence seq_pedidos;
create sequence seq_lineasDePedido;
create sequence seq_facturas;
create sequence seq_lineasDeFactura;
create sequence seq_valoracionesProductos;
create sequence seq_envios;
create sequence seq_cobros;
create sequence seq_incidencias;
create sequence seq_soluciones;
create sequence seq_presupuestos;
create sequence seq_valoracionesST;
create sequence seq_reparaciones;
create sequence seq_alquileres;
create sequence seq_fotomatones;
create sequence seq_inscripciones;
create sequence seq_seminarios;

CREATE OR REPLACE TRIGGER crea_oid_comunidad
BEFORE
INSERT
ON comunidades
FOR EACH ROW
BEGIN
SELECT seq_comunidades.NEXTVAL INTO :NEW.OID_COM FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_provincia
BEFORE
INSERT
ON provincias
FOR EACH ROW
BEGIN
SELECT seq_provincias.NEXTVAL INTO :NEW.OID_PRO FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_municipio 
BEFORE 
INSERT 
ON municipios
FOR EACH ROW
BEGIN
SELECT seq_municipios.NEXTVAL INTO :NEW.OID_MUN FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER crea_oid_persona
BEFORE
INSERT 
ON personas
FOR EACH ROW
BEGIN
SELECT seq_personas.NEXTVAL INTO :NEW.OID_P FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_tarjetas
BEFORE 
INSERT
ON tarjetasCredito
FOR EACH ROW
BEGIN
SELECT seq_tarjetasCredito.NEXTVAL INTO :NEW.OID_TC FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_docsIAE 
BEFORE 
INSERT 
ON documentosIAE
FOR EACH ROW
BEGIN 
SELECT seq_docsIAE.NEXTVAL INTO :NEW.OID_IAE FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_productos
BEFORE
INSERT
ON productos
FOR EACH ROW
BEGIN
SELECT seq_productos.NEXTVAL INTO :NEW.OID_PR FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_pedidos
BEFORE
INSERT
ON pedidos
FOR EACH ROW
BEGIN
SELECT seq_pedidos.NEXTVAL INTO :NEW.OID_PE FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_pedidos
BEFORE
INSERT
ON pedidos
FOR EACH ROW
BEGIN
SELECT seq_pedidos.NEXTVAL INTO :NEW.OID_PE FROM DUAL;
END;
/


CREATE OR REPLACE TRIGGER crea_oid_lineasDePedido
BEFORE
INSERT
ON lineasDePedido
FOR EACH ROW
BEGIN
SELECT seq_lineasDePedido.NEXTVAL INTO :NEW.OID_LPE FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_facturas
BEFORE
INSERT
ON facturas
FOR EACH ROW
BEGIN
SELECT seq_facturas.NEXTVAL INTO :NEW.OID_FA FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_lineasDeFactura
BEFORE
INSERT
ON lineasDeFactura
FOR EACH ROW
BEGIN
SELECT seq_lineasDeFactura.NEXTVAL INTO :NEW.OID_LFA FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_valoracionesProductos
BEFORE
INSERT
ON valoracionesProductos
FOR EACH ROW
BEGIN
SELECT seq_valoracionesProductos.NEXTVAL INTO :NEW.OID_VPR FROM DUAL;
END;
/


CREATE OR REPLACE TRIGGER crea_oid_envios
BEFORE
INSERT
ON envios
FOR EACH ROW
BEGIN
SELECT seq_envios.NEXTVAL INTO :NEW.OID_ENV FROM DUAL;
END;
/


CREATE OR REPLACE TRIGGER crea_oid_cobros
BEFORE
INSERT
ON cobros
FOR EACH ROW
BEGIN
SELECT seq_cobros.NEXTVAL INTO :NEW.OID_COB FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_alquileres
BEFORE
INSERT
ON alquileres
FOR EACH ROW
BEGIN
SELECT seq_alquileres.NEXTVAL INTO :NEW.OID_ALQ FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_fotomatones
BEFORE
INSERT
ON fotomatones
FOR EACH ROW
BEGIN
SELECT seq_fotomatones.NEXTVAL INTO :NEW.OID_FOT FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_inscripciones
BEFORE
INSERT
ON inscripciones
FOR EACH ROW
BEGIN
SELECT seq_inscripciones.NEXTVAL INTO :NEW.OID_INS FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_seminarios
BEFORE
INSERT
ON seminarios
FOR EACH ROW
BEGIN
SELECT seq_seminarios.NEXTVAL INTO :NEW.OID_SEM FROM DUAL;
END;
/


CREATE OR REPLACE TRIGGER crea_oid_incidencias
BEFORE
INSERT
ON incidencias
FOR EACH ROW
BEGIN
SELECT seq_incidencias.NEXTVAL INTO :NEW.OID_INC FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_soluciones
BEFORE
INSERT
ON soluciones
FOR EACH ROW
BEGIN
SELECT seq_soluciones.NEXTVAL INTO :NEW.OID_SOL FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_presupuestos
BEFORE
INSERT
ON presupuestos
FOR EACH ROW
BEGIN
SELECT seq_presupuestos.NEXTVAL INTO :NEW.OID_PRE FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_valoracionesST
BEFORE
INSERT
ON valoracionesST
FOR EACH ROW
BEGIN
SELECT seq_valoracionesST.NEXTVAL INTO :NEW.OID_VST FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER crea_oid_reparaciones
BEFORE
INSERT
ON reparaciones
FOR EACH ROW
BEGIN
SELECT seq_reparaciones.NEXTVAL INTO :NEW.OID_REP FROM DUAL;
END;
/

