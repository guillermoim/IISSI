ALTER SESSION SET nls_date_format = 'DD/MM/YYYY';

drop table tarjetasCredito CASCADE CONSTRAINTS;
drop table documentosIAE CASCADE CONSTRAINTS;
drop table empleados CASCADE CONSTRAINTS;
drop table directores CASCADE CONSTRAINTS;
drop table municipios CASCADE CONSTRAINTS;
drop table provincias CASCADE CONSTRAINTS;
drop table comunidades CASCADE CONSTRAINTS;
drop table personas CASCADE CONSTRAINTS;
drop table lineasDeFactura CASCADE CONSTRAINTS;
drop table lineasDePedido CASCADE CONSTRAINTS;
drop table valoracionesProductos CASCADE CONSTRAINTS;
drop table productos CASCADE CONSTRAINTS;
drop table pedidos CASCADE CONSTRAINTS;
drop table facturas CASCADE CONSTRAINTS;
drop table clientes CASCADE CONSTRAINTS;
drop table cobrosEnvios CASCADE CONSTRAINTS;
drop table cobrosPedidos CASCADE CONSTRAINTS;
drop table cobrosAlquiler CASCADE CONSTRAINTS;
drop table cobrosInscripcion CASCADE CONSTRAINTS;
drop table cobrosST CASCADE CONSTRAINTS;
drop table cobros CASCADE CONSTRAINTS;
drop table envios CASCADE CONSTRAINTS;
drop table reparaciones CASCADE CONSTRAINTS;
drop table presupuestos CASCADE CONSTRAINTS;
drop table valoracionesST CASCADE CONSTRAINTS;
drop table soluciones CASCADE CONSTRAINTS;
drop table incidencias CASCADE CONSTRAINTS;
drop table alquileres CASCADE CONSTRAINTS;
drop table fotomatones CASCADE CONSTRAINTS;
drop table inscripciones CASCADE CONSTRAINTS;
drop table seminarios CASCADE CONSTRAINTS;

create table comunidades(
    OID_COM SMALLINT PRIMARY KEY,
    comunidad VARCHAR(50) UNIQUE NOT NULL
);

create table provincias(
    OID_PRO SMALLINT PRIMARY KEY,
    provincia VARCHAR(50) UNIQUE NOT NULL,
    OID_COM SMALLINT,
    FOREIGN KEY(OID_COM) REFERENCES comunidades ON DELETE CASCADE
);


create table municipios(
    OID_MUN SMALLINT PRIMARY KEY,
    municipio VARCHAR2(50) NOT NULL,
    OID_PRO SMALLINT,
    FOREIGN KEY(OID_PRO) REFERENCES provincias ON DELETE CASCADE,
    UNIQUE(OID_PRO, municipio)
);

create table personas(
    OID_P SMALLINT PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellidos VARCHAR2(50) NOT NULL,
    telefono VARCHAR2(10) NOT NULL,
    email VARCHAR2(50) UNIQUE NOT NULL CHECK(email LIKE('%@%')),
    notificaciones CHAR(1) DEFAULT 'T',
    usuario VARCHAR2(16) UNIQUE NOT NULL,
    contrasena VARCHAR2(16) NOT NULL,
    CONSTRAINT check_notif_value CHECK (notificaciones IN('T','F'))
);


create table clientes(
    OID_P Smallint PRIMARY KEY,
    nif VARCHAR2(9) UNIQUE NOT NULL,
    empresa VARCHAR2(50),
    tipoCliente VARCHAR2(20) NOT NULL,
    OID_MUN SMALLINT ,
    CONSTRAINT check_tipo_cliente CHECK (tipoCliente IN ('PROFESIONAL', 'EMPRESA')),
    FOREIGN KEY(OID_MUN) REFERENCES municipios,
    FOREIGN KEY(OID_P) REFERENCES personas ON DELETE CASCADE
);

create table empleados(
    OID_P SMALLINT PRIMARY KEY,
    nss CHAR(14) NOT NULL UNIQUE,
    fechaInicio DATE NOT NULL,
    fechaFin DATE,
    salario NUMBER(7,2),
    tipoEmpleado VARCHAR2(20) check(tipoEmpleado IN('ADMINISTRADOR','AGENTECOMERCIAL','ALMACEN','SERVICIOTECNICO')),
    domicilio VARCHAR2(70),
    CONSTRAINT check_fecha_empleados CHECK(fechaFin > fechaInicio),
    FOREIGN KEY(OID_P) REFERENCES personas ON DELETE CASCADE
);

create table directores(
    OID_P SMALLINT PRIMARY KEY,
    FOREIGN KEY(OID_P) REFERENCES personas ON DELETE CASCADE
);

create table tarjetasCredito(
    OID_TC SMALLINT PRIMARY KEY,
    OID_P SMALLINT,
    numero CHAR(16) UNIQUE,
    mes NUMBER(2) check(mes BETWEEN 1 AND 12),
    anyo NUMBER(2) check(anyo BETWEEN 0 AND 99),
    titular VARCHAR2(70),
    marca VARCHAR2(12),
    cvv NUMBER(3) check(cvv BETWEEN 1 AND 999),
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE
);

create table documentosIAE(
    OID_IAE SMALLINT PRIMARY KEY,
    OID_P SMALLINT UNIQUE, 
    estado VARCHAR2(15) check(estado IN('ACEPTADO','ESPERA' ,'RECHAZADO')),
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE
);


create table productos(
    OID_PR SMALLINT PRIMARY KEY,
    familia VARCHAR2(20),
    precio NUMBER(9,2) NOT NULL,
    numReferencia VARCHAR2(30) UNIQUE NOT NULL,
    fechaIncorporacion DATE DEFAULT SYSDATE,
    coste NUMBER(9,2) NOT NULL,
    stock SMALLINT NOT NULL,
    cantidadCritica SMALLINT NOT NULL,
    CONSTRAINT check_precio CHECK(precio > coste)
);

create table pedidos(
    OID_PE SMALLINT PRIMARY KEY,
    OID_P SMALLINT,
    fecha DATE,
    importeTotal NUMBER(9,2) DEFAULT 0.0,
    estado CHAR(11) CHECK(estado IN('ALMACEN','ENVIADO','NOTRAMITADO')),
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE
);

create table lineasDePedido(
    OID_LPE SMALLINT PRIMARY KEY,
    OID_PE SMALLINT,
    OID_PR SMALLINT,
    cantidad SMALLINT NOT NULL check(cantidad > 0),
    FOREIGN KEY(OID_PE) REFERENCES pedidos ON DELETE CASCADE,
    FOREIGN KEY(OID_PR) REFERENCES productos,
    UNIQUE(oid_pe, oid_pr)
);

create table facturas(
    OID_FA SMALLINT PRIMARY KEY,
    OID_P SMALLINT,
    OID_PE SMALLINT,
    fechaExpedicion DATE,
    importeTotal NUMBER(9,2),
    importeTotalSinIVA NUMBER(9,2),
    importeTotalDescuento NUMBER(9,2),
    anotacion VARCHAR2(50),
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE,
    FOREIGN KEY(OID_PE) REFERENCES pedidos
);

create table lineasDeFactura(
    OID_LFA SMALLINT PRIMARY KEY,
    OID_FA SMALLINT,
    OID_LPE SMALLINT,
    importeTotal NUMBER(9,2) NOT NULL,
    FOREIGN KEY(OID_FA) REFERENCES facturas ON DELETE CASCADE,
    FOREIGN KEY(OID_LPE) REFERENCES lineasDePedido
);

create table valoracionesProductos(
    OID_VPR SMALLINT PRIMARY KEY,
    OID_P SMALLINT,
    OID_PR SMALLINT,
    fecha DATE DEFAULT SYSDATE,
    valoracion SMALLINT CHECK(valoracion BETWEEN 1 AND 5),
    comentario VARCHAR2(100),
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE,
    FOREIGN KEY(OID_PR) REFERENCES productos ON DELETE CASCADE
);

create table envios(
    OID_ENV SMALLINT PRIMARY KEY,
    fecha DATE DEFAULT SYSDATE,
    compañia VARCHAR2(16) NOT NULL,
    importe NUMBER(4,2) NOT NULL,
    numLocalizador VARCHAR2(50) NOT NULL,
    paga VARCHAR2(15) NOT NULL,
    OID_PE SMALLINT,
    CONSTRAINT check_paga CHECK(paga IN('EMPRESA', 'CLIENTE')),
    FOREIGN KEY(OID_PE) REFERENCES pedidos
);

CREATE TABLE incidencias(
    OID_INC SMALLINT PRIMARY KEY,
    fecha DATE DEFAULT SYSDATE,
    descripcion VARCHAR2(250) NOT NULL,
    numRefProd VARCHAR2(50) NOT NULL,
    OID_P SMALLINT,
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE
);

CREATE TABLE soluciones(
    OID_SOL SMALLINT PRIMARY KEY,
    fecha DATE NOT NULL,
    tipoSolucion CHAR(11) CHECK(tipoSolucion IN ('TELEMATICA', 'TALLER')),
    OID_INC SMALLINT,
    FOREIGN KEY(OID_INC) REFERENCES incidencias ON DELETE CASCADE
);

CREATE TABLE valoracionesST(
    OID_VST SMALLINT PRIMARY KEY,
    fecha DATE DEFAULT SYSDATE,
    valoracion SMALLINT CHECK(valoracion BETWEEN 1 AND 5),
    comentario VARCHAR2(150),
    OID_P SMALLINT,
    OID_SOL SMALLINT,
    FOREIGN KEY(OID_P) REFERENCES clientes ON DELETE CASCADE,
    FOREIGN KEY(OID_SOL) REFERENCES soluciones ON DELETE CASCADE
);

CREATE TABLE presupuestos(
    OID_PRE SMALLINT PRIMARY KEY,
    fechaElaboracion DATE DEFAULT SYSDATE,
    fechaDisponible DATE NOT NULL,
    estado CHAR(12) CHECK(estado IN('ACEPTADO', 'RECHAZADO', 'PENDIENTE')),
    importe NUMBER(7,2) NOT NULL,
    OID_SOL SMALLINT,
    OID_P SMALLINT,
    FOREIGN KEY(OID_SOL) REFERENCES soluciones ON DELETE CASCADE,
    FOREIGN KEY(OID_P) REFERENCES empleados
);

CREATE TABLE reparaciones(
    OID_REP SMALLINT PRIMARY KEY,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    notas VARCHAR2(250),
    OID_PRE SMALLINT, 
    OID_P SMALLINT,
    constraint check_fechas_rep CHECK(fechaFin > fechaInicio),
    FOREIGN KEY(OID_PRE) REFERENCES presupuestos ON DELETE CASCADE,
    FOREIGN KEY(OID_P) REFERENCES empleados
);
create table fotomatones(
    OID_FOT SMALLINT PRIMARY KEY,
    anotaciones VARCHAR2(150)
);

create table alquileres(
    OID_ALQ SMALLINT PRIMARY KEY,
    salida DATE NOT NULL,
    devPrev DATE NOT NULL,
    devEfectiva DATE,
    comentario VARCHAR2(100),
    OID_P SMALLINT NOT NULL,
    OID_FOT SMALLINT NOT NULL,
    FOREIGN KEY(OID_P) REFERENCES clientes,
    FOREIGN KEY(OID_FOT) REFERENCES fotomatones
);

create table seminarios(
    OID_SEM SMALLINT PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    fecha DATE NOT NULL,
    lugar VARCHAR2(100) NOT NULL,
    plazas SMALLINT NOT NULL,
    asistentes SMALLINT DEFAULT (0),
    precio NUMBER(5,2)
);

create table inscripciones(
    OID_INS SMALLINT PRIMARY KEY,
    OID_P SMALLINT NOT NULL,
    OID_SEM SMALLINT NOT NULL,
    fechaIns DATE DEFAULT SYSDATE,
    FOREIGN KEY(OID_P) REFERENCES clientes,
    FOREIGN KEY(OID_SEM) REFERENCES seminarios,
    unique (oid_ins, oid_p)
);

create table cobros(
    OID_COB SMALLINT PRIMARY KEY,
    fecha DATE DEFAULT SYSDATE,
    importeTotal NUMBER(9,2) NOT NULL,
    estado VARCHAR2(10) check(estado IN('PENDIENTE', 'REALIZADO'))
);

create table cobrosPedidos(
    OID_COB SMALLINT PRIMARY KEY,
    OID_PE SMALLINT NOT NULL,
    FOREIGN KEY(OID_COB) REFERENCES cobros ON DELETE CASCADE,
    FOREIGN KEY(OID_PE) REFERENCES pedidos ON DELETE CASCADE
);

create table cobrosEnvios(
    OID_COB SMALLINT PRIMARY KEY,
    OID_ENV SMALLINT NOT NULL,
    FOREIGN KEY(OID_COB) REFERENCES cobros ON DELETE CASCADE,
    FOREIGN KEY(OID_ENV) REFERENCES envios ON DELETE CASCADE
);

CREATE TABLE cobrosST(
    OID_COB SMALLINT PRIMARY KEY,
    OID_PRE SMALLINT,
    FOREIGN KEY(OID_COB) REFERENCES cobros ON DELETE CASCADE,
    FOREIGN KEY(OID_PRE) REFERENCES presupuestos ON DELETE CASCADE
);

CREATE TABLE cobrosAlquiler(
    OID_COB SMALLINT PRIMARY KEY,
    OID_ALQ SMALLINT,
    FOREIGN KEY(OID_COB) REFERENCES cobros ON DELETE CASCADE,
    FOREIGN KEY(OID_ALQ) REFERENCES alquileres ON DELETE CASCADE
);

CREATE TABLE cobrosInscripcion(
    OID_COB SMALLINT PRIMARY KEY,
    OID_INS SMALLINT,
    FOREIGN KEY(OID_COB) REFERENCES cobros ON DELETE CASCADE,
    FOREIGN KEY(OID_INS) REFERENCES inscripciones ON DELETE CASCADE
);
