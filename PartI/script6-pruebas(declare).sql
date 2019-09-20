--PRUEBAS
CREATE OR REPLACE PACKAGE PRUEBAS_PERSONAS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, 
        w_apellidos VARCHAR2, w_telefono VARCHAR2, w_email VARCHAR2, 
        w_notificaciones char, w_usuario VARCHAR2, w_contrasena VARCHAR2, 
        salidaEsperada BOOLEAN);
        
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_nombre VARCHAR2, 
        w_apellidos VARCHAR2, w_telefono VARCHAR2, w_email VARCHAR2, 
        w_notificaciones char, w_usuario VARCHAR2, w_contrasena VARCHAR2,
        salidaEsperada BOOLEAN);
        
PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_P SMALLINT, salidaEsperada BOOLEAN);
END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_PERSONAS AS
PROCEDURE inicializar AS
    BEGIN
        DELETE FROM personas;
    END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, 
        w_apellidos VARCHAR2, w_telefono VARCHAR2, w_email VARCHAR2, 
        w_notificaciones char, w_usuario VARCHAR2, w_contrasena VARCHAR2,
        salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        persona personas%ROWTYPE;
        w_OID_P SMALLINT;
    BEGIN
        INSERT INTO personas VALUES(seq_personas.NEXTVAL, w_nombre, w_apellidos,
        w_telefono,w_email, w_notificaciones, w_usuario,w_contrasena);
        w_OID_P := seq_personas.currval;
        SELECT * INTO persona FROM personas WHERE w_oid_p = oid_p;
        IF (persona.nombre <> w_nombre OR persona.apellidos<>w_apellidos OR 
            persona.telefono <> w_telefono OR persona.email <> w_email OR 
            persona.notificaciones <> w_notificaciones OR 
            persona.usuario <> w_usuario OR persona.contrasena <> w_contrasena)
        THEN 
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_nombre VARCHAR2, 
        w_apellidos VARCHAR2, w_telefono VARCHAR2, w_email VARCHAR2, 
        w_notificaciones char, w_usuario VARCHAR2, w_contrasena VARCHAR2,
        salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        persona personas%ROWTYPE;
    BEGIN
        UPDATE personas SET nombre =w_nombre, apellidos = w_apellidos,
            telefono = w_telefono, email = w_email, notificaciones = 
                w_notificaciones, usuario = w_usuario, contrasena = w_contrasena
                WHERE oid_p = w_oid_p;
        SELECT * INTO persona FROM personas WHERE oid_p = w_oid_p;
        IF (persona.nombre <> w_nombre OR persona.apellidos<>w_apellidos OR 
            persona.telefono <> w_telefono OR persona.email <> w_email OR 
            persona.notificaciones <> w_notificaciones OR 
            persona.usuario <> w_usuario OR persona.contrasena <> w_contrasena)
        THEN 
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2,
            w_OID_P SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_personas INTEGER;
        BEGIN
            DELETE FROM personas WHERE OID_P=w_OID_P;
            SELECT COUNT(*) INTO n_personas FROM personas WHERE OID_P=w_OID_P;
            IF (n_personas <> 0) THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
 COMMIT WORK;
 
END eliminar;

END pruebas_personas;
/


CREATE OR REPLACE PACKAGE PRUEBAS_COMUNIDADES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, 
            salidaEsperada BOOLEAN);

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid SMALLINT, w_nombre VARCHAR2, 
            salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid SMALLINT, 
            salidaEsperada BOOLEAN);       
END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_COMUNIDADES
    AS
PROCEDURE inicializar 
    AS
    BEGIN
        DELETE FROM comunidades;
END;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, 
            salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        comunidad comunidades%ROWTYPE;
        w_OID_com SMALLINT; 
    BEGIN
        INSERT INTO comunidades values(seq_comunidades.nextval, w_nombre);
        w_oid_com := seq_comunidades.currval;
        SELECT * INTO comunidad FROM comunidades WHERE w_oid_com = oid_com;
        IF(w_nombre <> comunidad.comunidad)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid SMALLINT, w_nombre VARCHAR2, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            comunidad comunidades%ROWTYPE;
        BEGIN
            UPDATE comunidades SET comunidad = w_nombre WHERE w_oid = oid_com;
            SELECT * INTO comunidad FROM comunidades WHERE w_oid = oid_com;
            IF (w_nombre <> comunidad.comunidad)
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_comunidades INTEGER;
        BEGIN
            DELETE FROM comunidades WHERE OID_com=w_oid;
            SELECT COUNT(*) INTO n_comunidades FROM comunidades 
                WHERE oid_com= w_oid;
            IF (n_comunidades <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_COMUNIDADES;
/

CREATE OR REPLACE PACKAGE PRUEBAS_PROVINCIAS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_provincia VARCHAR2,
        w_oid_com SMALLINT,salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_pro SMALLINT, w_provincia VARCHAR2,
        w_oid_com SMALLINT,salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pro SMALLINT,
    salidaEsperada BOOLEAN);
END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_PROVINCIAS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM provincias;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_provincia VARCHAR2,
        w_oid_com SMALLINT,salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        provincia provincias%ROWTYPE;
        w_OID_pro SMALLINT; 
    BEGIN
        INSERT INTO provincias values(seq_provincias.nextval, w_provincia,
        w_oid_com);
        w_oid_pro := seq_provincias.currval;
        SELECT * INTO provincia FROM provincias WHERE w_oid_pro = oid_pro;
        IF(provincia.provincia <> w_provincia OR provincia.oid_com <> w_oid_com)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_pro SMALLINT, 
        w_provincia VARCHAR2, w_oid_com SMALLINT,salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        provincia provincias%ROWTYPE;
    BEGIN
        UPDATE provincias SET oid_com = w_oid_com, provincia = w_provincia 
            WHERE oid_pro = w_oid_pro;
        SELECT * INTO provincia FROM provincias WHERE w_oid_pro = oid_pro;
        IF(provincia.provincia <> w_provincia OR provincia.oid_com <> w_oid_com)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pro SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_provincias INTEGER;
        BEGIN
            DELETE FROM provincias WHERE OID_pro=w_oid_pro;
            SELECT COUNT(*) INTO n_provincias FROM provincias 
                WHERE oid_pro= w_oid_pro;
            IF (n_provincias <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_PROVINCIAS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_MUNICIPIOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_municipio VARCHAR2,
        w_oid_pro SMALLINT,salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_mun SMALLINT, w_municipio VARCHAR2,
        w_oid_pro SMALLINT,salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_mun SMALLINT,
    salidaEsperada BOOLEAN);
END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_MUNICIPIOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM municipios;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_municipio VARCHAR2,
        w_oid_pro SMALLINT,salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        municipio municipios%ROWTYPE;
        w_OID_mun SMALLINT; 
    BEGIN
        INSERT INTO municipioS values(seq_municipios.nextval, w_municipio,
        w_oid_pro);
        w_oid_mun := seq_municipios.currval;
        SELECT * INTO municipio FROM municipios WHERE w_oid_mun = oid_mun;
        IF(municipio.municipio <> w_municipio OR municipio.oid_pro <> w_oid_pro)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_mun SMALLINT, w_municipio VARCHAR2,
        w_oid_pro SMALLINT,salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        municipio municipios%ROWTYPE;
    BEGIN
        UPDATE municipios SET oid_pro = w_oid_pro, municipio = w_municipio 
            WHERE oid_mun = w_oid_mun;
        SELECT * INTO municipio FROM municipios WHERE w_oid_mun = oid_mun;
        IF(municipio.municipio <> w_municipio OR municipio.oid_pro <> w_oid_pro)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_mun SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_municipios INTEGER;
        BEGIN
            DELETE FROM municipios WHERE OID_mun=w_oid_mun;
            SELECT COUNT(*) INTO n_municipios FROM municipios 
                WHERE oid_mun = w_oid_mun;
            IF (n_municipios <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_MUNICIPIOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_CLIENTES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, w_nif VARCHAR2,
             w_empresa VARCHAR2, w_tipoCliente VARCHAR2, 
            w_OID_MUN SMALLINT, salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, w_nif VARCHAR2,
            w_empresa VARCHAR2, w_tipoCliente VARCHAR2, 
            w_OID_MUN SMALLINT, salidaEsperada BOOLEAN);
PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, 
                salidaEsperada BOOLEAN);
END;
/
CREATE OR REPLACE PACKAGE BODY PRUEBAS_CLIENTES
AS
PROCEDURE inicializar
    AS
    BEGIN
        DELETE FROM clientes;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, w_nif VARCHAR2,
            w_empresa VARCHAR2, w_tipoCliente VARCHAR2, 
            w_OID_MUN SMALLINT, salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        cliente clientes%rowtype;
    BEGIN
        INSERT INTO clientes VALUES(w_oid_p, w_nif,
            w_empresa, w_tipoCliente, w_oid_mun);
        SELECT * INTO cliente FROM clientes WHERE oid_p = w_oid_p;
        IF(cliente.nif <> w_nif OR cliente.empresa <> w_empresa OR 
            cliente.tipoCliente <> w_tipoCliente OR cliente.oid_mun <> w_oid_mun)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, w_nif VARCHAR2,
            w_empresa VARCHAR2, w_tipoCliente VARCHAR2, 
            w_OID_MUN SMALLINT, salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        cliente clientes%rowtype;
    BEGIN
        UPDATE clientes SET nif = w_nif, empresa = w_empresa, 
            tipoCliente = w_tipoCliente, oid_mun = w_oid_mun 
                WHERE w_oid_p = oid_p;
        SELECT * INTO cliente FROM clientes WHERE oid_p = w_oid_p;
        IF(cliente.nif <> w_nif OR cliente.empresa <> w_empresa OR 
            cliente.tipoCliente <> w_tipoCliente OR cliente.oid_mun <> w_oid_mun)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_clientes INTEGER;
        BEGIN
            DELETE FROM clientes WHERE OID_p=w_oid_p;
            SELECT COUNT(*) INTO n_clientes FROM clientes 
                WHERE oid_p= w_oid_p;
            IF (n_clientes <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_CLIENTES;
/

CREATE OR REPLACE PACKAGE PRUEBAS_EMPLEADOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_nss CHAR,
    w_fechaInicio DATE, w_fechaFin DATE, W_salario NUMBER, 
    W_tipoEmpleado VARCHAR2, w_domicilio VARCHAR2, salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_nss CHAR,
    w_fechaInicio DATE, w_fechaFin DATE, W_salario NUMBER, 
    W_tipoEmpleado VARCHAR2, w_domicilio VARCHAR2, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, 
    salidaEsperada BOOLEAN);
END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_EMPLEADOS
AS
PROCEDURE inicializar
AS
BEGIN
    DELETE FROM empleados;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_nss CHAR,
    w_fechaInicio DATE, w_fechaFin DATE, w_salario NUMBER, 
    W_tipoEmpleado VARCHAR2, w_domicilio VARCHAR2, salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        empleado empleados%rowtype;
    BEGIN
        INSERT INTO empleados VALUES(w_oid_p, w_nss, w_fechaInicio,
        w_fechaFin, w_salario, w_tipoEmpleado, w_domicilio);
        SELECT * INTO empleado FROM empleados WHERE oid_p = w_oid_p;
        IF(empleado.nss <> w_nss OR empleado.fechaInicio <> w_fechaInicio OR 
        empleado.fechaFin <> w_fechaFin OR empleado.salario <> w_salario OR
        empleado.tipoEmpleado<>w_tipoEmpleado OR empleado.domicilio<>w_domicilio)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_nss CHAR,
    w_fechaInicio DATE, w_fechaFin DATE, w_salario NUMBER, 
    W_tipoEmpleado VARCHAR2, w_domicilio VARCHAR2, salidaEsperada BOOLEAN)
    AS
        salida BOOLEAN := true;
        empleado empleados%rowtype;
    BEGIN
        UPDATE empleados SET nss = w_nss, fechaInicio = w_fechaInicio, 
            fechaFin = w_fechaFin, salario = w_salario, 
            tipoEmpleado = w_tipoEmpleado, domicilio = w_domicilio WHERE
            oid_p = w_oid_p;
        SELECT * INTO empleado FROM empleados WHERE oid_p = w_oid_p;
        IF(empleado.nss <> w_nss OR empleado.fechaInicio <> w_fechaInicio OR 
        empleado.fechaFin <> w_fechaFin OR empleado.salario <> w_salario OR
        empleado.tipoEmpleado<>w_tipoEmpleado OR empleado.domicilio<>w_domicilio)
        THEN
            salida := false;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
            ASSERT_EQUALS(salida,  salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
            ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_p SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_empleados INTEGER;
        BEGIN
            DELETE FROM empleados WHERE OID_p=w_oid_p;
            SELECT COUNT(*) INTO n_empleados FROM empleados 
                WHERE oid_p= w_oid_p;
            IF (n_empleados <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_EMPLEADOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_TARJETAS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_numero CHAR, 
            w_mes NUMBER, w_anyo NUMBER, w_titular VARCHAR2, w_marca VARCHAR2, 
            w_cvv NUMBER, salidaEsperada BOOLEAN);
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_tc SMALLINT, w_oid_p SMALLINT,
            w_numero CHAR, w_mes NUMBER, w_anyo NUMBER, w_titular VARCHAR2, 
            w_marca VARCHAR2, w_cvv NUMBER, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_tc SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_TARJETAS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM tarjetasCredito;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_numero CHAR, 
            w_mes NUMBER, w_anyo NUMBER, w_titular VARCHAR2, w_marca VARCHAR2, 
            w_cvv NUMBER, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            tarjeta tarjetasCredito%rowtype;
            w_oid_tc SMALLINT;
        BEGIN
            INSERT INTO tarjetasCredito VALUES(seq_tarjetasCredito.nextval, 
                w_oid_p, w_numero, w_mes, w_anyo, w_titular, w_marca, w_cvv);
            w_oid_tc := seq_tarjetasCredito.currval;
            SELECT * INTO tarjeta FROM tarjetasCredito WHERE oid_tc = w_oid_tc;
            IF(tarjeta.oid_p <> w_oid_p OR tarjeta.numero <> w_numero OR
                tarjeta.mes <> w_mes OR tarjeta.anyo <> w_anyo OR 
                tarjeta.titular <> w_titular OR tarjeta.marca <> w_marca OR
                tarjeta.cvv <> w_cvv)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_tc SMALLINT, w_oid_p SMALLINT,
            w_numero CHAR, w_mes NUMBER, w_anyo NUMBER, w_titular VARCHAR2, 
            w_marca VARCHAR2, w_cvv NUMBER, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                tarjeta tarjetasCredito%rowtype;
            BEGIN
            UPDATE tarjetasCredito SET oid_p = w_oid_p, numero = w_numero,
                mes = w_mes, anyo = w_anyo, titular = w_titular, marca = w_marca,
                cvv = w_cvv WHERE oid_tc = w_oid_tc;
            SELECT * INTO tarjeta FROM tarjetasCredito WHERE oid_tc = w_oid_tc;
            IF(tarjeta.oid_p <> w_oid_p OR tarjeta.numero <> w_numero OR
                tarjeta.mes <> w_mes OR tarjeta.anyo <> w_anyo OR 
                tarjeta.titular <> w_titular OR tarjeta.marca <> w_marca OR
                tarjeta.cvv <> w_cvv)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_tc SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_tarjetas INTEGER;
        BEGIN
            DELETE FROM tarjetasCredito WHERE OID_tc = w_oid_tc;
            SELECT COUNT(*) INTO n_tarjetas FROM tarjetasCredito 
                WHERE oid_tc= w_oid_tc;
            IF (n_tarjetas <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_TARJETAS;
/


CREATE OR REPLACE PACKAGE PRUEBAS_DOCSIAE
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_estado VARCHAR2, 
                salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_iae SMALLINT, w_oid_p SMALLINT,
                w_estado VARCHAR2, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_iae SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_DOCSIAE
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM documentosIAE;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_oid_p SMALLINT, w_estado VARCHAR2, 
                salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            documento documentosIAE%rowtype;
            w_oid_iae SMALLINT;
        BEGIN
            INSERT INTO documentosIAE VALUES(seq_docsIAE.nextval, w_oid_p, 
                w_estado);
            w_oid_iae := seq_docsIAE.currval;
            SELECT * INTO documento FROM documentosIAE WHERE oid_iae = w_oid_iae;
            IF(documento.oid_p <> w_oid_p OR documento.estado <> w_estado)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_iae SMALLINT, w_oid_p SMALLINT,
                w_estado VARCHAR2, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                documento documentosIAE%rowtype;
            BEGIN
            UPDATE documentosIAE SET oid_p = w_oid_p, estado = w_estado
                WHERE oid_iae = w_oid_iae;
            SELECT * INTO documento FROM documentosIAE WHERE oid_iae = w_oid_iae;
            IF(documento.oid_p <> w_oid_p OR documento.estado <> w_estado)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_iae SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_docs INTEGER;
        BEGIN
            DELETE FROM documentosIAE WHERE OID_iae = w_oid_iae;
            SELECT COUNT(*) INTO n_docs FROM documentosIAE 
                WHERE oid_iae= w_oid_iae;
            IF (n_docs <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_DOCSIAE;
/

---------------------------

CREATE OR REPLACE PACKAGE PRUEBAS_PRODUCTOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_familia VARCHAR2,
        w_precio NUMBER, w_numReferencia VARCHAR2, w_fechaIncorporacion DATE, 
        w_coste NUMBER, w_stock SMALLINT, w_cantidadCritica SMALLINT, 
        salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_pr SMALLINT, w_familia VARCHAR2,
        w_precio NUMBER, w_numReferencia VARCHAR2, w_fechaIncorporacion DATE, 
        w_coste NUMBER, w_stock SMALLINT, w_cantidadCritica SMALLINT, 
        salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pr SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_PRODUCTOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM productos;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_familia VARCHAR2,
        w_precio NUMBER, w_numReferencia VARCHAR2, w_fechaIncorporacion DATE, 
        w_coste NUMBER, w_stock SMALLINT, w_cantidadCritica SMALLINT, 
        salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            producto productos%rowtype;
            w_oid_pr SMALLINT;
        BEGIN
            INSERT INTO productos VALUES(seq_docsIAE.nextval, w_familia, 
                w_precio, w_numReferencia, w_fechaIncorporacion, w_coste,
                w_stock, w_cantidadCritica);
            w_oid_pr := seq_productos.currval;
            SELECT * INTO producto FROM productos WHERE oid_pr = w_oid_pr;
            IF(producto.familia<> w_familia OR producto.precio <> w_precio
                OR producto.numReferencia <> w_numReferencia OR 
                producto.fechaIncorporacion <> w_fechaIncorporacion OR
                producto.coste <> w_coste OR producto.stock <> w_stock OR
                producto.cantidadCritica <> w_cantidadCritica)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_pr SMALLINT, w_familia VARCHAR2,
        w_precio NUMBER, w_numReferencia VARCHAR2, w_fechaIncorporacion DATE, 
        w_coste NUMBER, w_stock SMALLINT, w_cantidadCritica SMALLINT, 
        salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                producto productos%rowtype;
            BEGIN
            UPDATE productos SET familia = w_familia, precio = w_precio,
                numReferencia = w_numReferencia, 
                fechaIncorporacion = w_fechaIncorporacion, coste = w_coste,
                stock = w_stock, cantidadCritica = w_cantidadCritica
                WHERE oid_pr = w_oid_pr;
            SELECT * INTO producto FROM productos WHERE oid_pr = w_oid_pr;
            IF(producto.familia<> w_familia OR producto.precio <> w_precio
                OR producto.numReferencia <> w_numReferencia OR 
                producto.fechaIncorporacion <> w_fechaIncorporacion OR
                producto.coste <> w_coste OR producto.stock <> w_stock OR
                producto.cantidadCritica <> w_cantidadCritica)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pr SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_productos INTEGER;
        BEGIN
            DELETE FROM productos WHERE OID_pr = w_oid_pr;
            SELECT COUNT(*) INTO n_productos FROM productos 
                WHERE oid_pr= w_oid_pr;
            IF (n_productos <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_PRODUCTOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_VALORACIONES_PRODUCTOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT,
        w_OID_PR SMALLINT, w_fecha DATE , w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_vpr SMALLINT,  
        w_OID_P SMALLINT, w_OID_PR SMALLINT, w_fecha DATE, w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_vpr SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_VALORACIONES_PRODUCTOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM valoracionesProductos;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT,
        w_OID_PR SMALLINT, w_fecha DATE , w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            valoracion valoracionesProductos%rowtype;
            w_oid_vpr SMALLINT;
        BEGIN
            INSERT INTO valoracionesProductos VALUES(seq_valoracionesProductos.nextval,
                w_oid_p, w_oid_pr, w_fecha, w_valoracion, w_comentario);
            w_oid_vpr := seq_valoracionesProductos.currval;
            SELECT * INTO valoracion FROM valoracionesProductos 
            WHERE oid_Vpr = w_oid_vpr;
            IF(valoracion.oid_p<> w_oid_p OR valoracion.oid_pr <> w_oid_pr
                OR valoracion.fecha <> w_fecha OR 
                valoracion.valoracion <> w_valoracion OR
                valoracion.comentario <> w_comentario)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_vpr SMALLINT,  
        w_OID_P SMALLINT, w_OID_PR SMALLINT, w_fecha DATE, w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                valoracion valoracionesProductos%rowtype;
            BEGIN
            UPDATE valoracionesProductos SET oid_p = w_oid_p, oid_pr = w_oid_pr,
                fecha = w_fecha, 
                valoracion = w_valoracion, comentario = w_comentario
                WHERE oid_vpr = w_oid_vpr;
            SELECT * INTO valoracion FROM valoracionesProductos 
            WHERE oid_vpr = w_oid_vpr;
            IF(valoracion.oid_p<> w_oid_p OR valoracion.oid_pr <> w_oid_pr
                OR valoracion.fecha <> w_fecha OR 
                valoracion.valoracion <> w_valoracion OR
                valoracion.comentario <> w_comentario)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_vpr SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_valoraciones INTEGER;
        BEGIN
            DELETE FROM valoracionesProductos WHERE OID_vpr = w_oid_vpr;
            SELECT COUNT(*) INTO n_valoraciones FROM valoracionesProductos 
                WHERE oid_vpr= w_oid_vpr;
            IF (n_valoraciones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_VALORACIONES_PRODUCTOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_PEDIDOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT, w_fecha DATE, 
                w_importeTotal NUMBER, w_estado CHAR , salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid_pe SMALLINT, w_OID_P SMALLINT,
                w_fecha DATE,  w_importeTotal NUMBER, w_estado CHAR , 
                salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pe SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_PEDIDOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM pedidos;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT, w_fecha DATE, 
                w_importeTotal NUMBER, w_estado CHAR , salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            pedido pedidos%rowtype;
            w_oid_pe SMALLINT;
        BEGIN
            INSERT INTO pedidos VALUES(seq_pedidos.nextval,
                w_oid_p,w_fecha, w_importeTotal, w_estado);
            w_oid_pe := seq_pedidos.currval;
            SELECT * INTO pedido FROM pedidos 
            WHERE oid_pe = w_oid_pe;
            IF(pedido.oid_p<> w_oid_p OR pedido.fecha <> w_fecha
                OR pedido.importeTotal <> w_importeTotal OR 
                pedido.estado <> w_estado)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid_pe SMALLINT, w_OID_P SMALLINT,
                w_fecha DATE,  w_importeTotal NUMBER, w_estado CHAR , 
                salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                pedido pedidos%rowtype;
            BEGIN
            UPDATE pedidos SET oid_p = w_oid_p, fecha = w_fecha,
                importeTotal = w_importeTotal, estado = w_estado
                WHERE oid_pe = w_oid_pe;
            SELECT * INTO pedido FROM pedidos 
            WHERE oid_pe = w_oid_pe;
            IF(pedido.oid_p<> w_oid_p OR pedido.fecha <> w_fecha
                OR pedido.importeTotal <> w_importeTotal OR 
                pedido.estado <> w_estado)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pe SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_pedidos INTEGER;
        BEGIN
            DELETE FROM pedidos WHERE OID_pe = w_oid_pe;
            SELECT COUNT(*) INTO n_pedidos FROM pedidos 
                WHERE oid_pe= w_oid_pe;
            IF (n_pedidos <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_PEDIDOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_LINEAS_PEDIDOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_PE SMALLINT,
                w_OID_PR SMALLINT, w_cantidad SMALLINT, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_lpe SMALLINT, w_OID_PE SMALLINT,
                w_OID_PR SMALLINT, w_cantidad SMALLINT, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_lpe SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_LINEAS_PEDIDOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM lineasdepedido;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_PE SMALLINT,
                w_OID_PR SMALLINT, w_cantidad SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            linea lineasdepedido%rowtype;
            w_oid_lpe SMALLINT;
        BEGIN
            INSERT INTO lineasdepedido VALUES(seq_lineasdepedido.nextval,
                w_oid_pe,w_oid_pr,w_cantidad);
            w_oid_lpe := seq_lineasdepedido.currval;
            SELECT * INTO linea FROM lineasdepedido 
            WHERE oid_lpe = w_oid_lpe;
            IF(linea.oid_pe<> w_oid_pe OR linea.oid_pr <> w_oid_pr
                OR linea.cantidad <> w_cantidad)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_lpe SMALLINT, w_OID_PE SMALLINT,
                w_OID_PR SMALLINT, w_cantidad SMALLINT, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                linea lineasdepedido%rowtype;
            BEGIN
            UPDATE lineasdepedido SET oid_pe = w_oid_pe, oid_pr = w_oid_pr,
                cantidad = w_cantidad
                WHERE oid_lpe = w_oid_lpe;
            SELECT * INTO linea FROM lineasdepedido 
            WHERE oid_lpe = w_oid_lpe;
            IF(linea.oid_pe<> w_oid_pe OR linea.oid_pr <> w_oid_pr
                OR linea.cantidad <> w_cantidad)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_lpe SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_lineas INTEGER;
        BEGIN
            DELETE FROM lineasdepedido WHERE OID_lpe = w_oid_lpe;
            SELECT COUNT(*) INTO n_lineas FROM lineasdepedido 
                WHERE oid_lpe= w_oid_lpe;
            IF (n_lineas <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_LINEAS_PEDIDOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_FACTURAS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_OID_P SMALLINT,w_OID_PE SMALLINT,
        w_fechaExpedicion DATE,w_importeTotal NUMBER, w_importeTotalSinIVA NUMBER, 
        w_importeTotalDescuento NUMBER, w_anotacion VARCHAR2,
        salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_FA SMALLINT,w_OID_P SMALLINT,
        w_OID_PE SMALLINT, w_fechaExpedicion DATE,w_importeTotal NUMBER,
        w_importeTotalSinIVA NUMBER, w_importeTotalDescuento NUMBER, 
        w_anotacion VARCHAR2, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_fa SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_FACTURAS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM facturas;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_OID_P SMALLINT,w_OID_PE SMALLINT,
        w_fechaExpedicion DATE,w_importeTotal NUMBER, w_importeTotalSinIVA NUMBER, 
        w_importeTotalDescuento NUMBER, w_anotacion VARCHAR2,
        salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            factura facturas%rowtype;
            w_oid_fa SMALLINT;
        BEGIN
            INSERT INTO facturas VALUES(seq_facturas.nextval,
                w_OID_P ,w_OID_PE, w_fechaExpedicion, w_importeTotal,
                w_importeTotalSinIVA, w_importeTotalDescuento, w_anotacion );
            w_oid_fa := seq_facturas.currval;
            SELECT * INTO factura FROM facturas 
            WHERE oid_fa = w_oid_fa;
            IF(factura.oid_p<> w_oid_p OR factura.oid_pe <> w_oid_pe
                OR factura.fechaExpedicion <> w_fechaExpedicion OR 
                factura.importeTotal <> w_importeTotal OR factura.importeTotalSinIVA
                <> w_importeTotalSinIva OR factura.importeTotalDescuento <> 
                w_importeTotalDescuento OR factura.anotacion <> w_anotacion)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_FA SMALLINT,w_OID_P SMALLINT,
            w_OID_PE SMALLINT, w_fechaExpedicion DATE,w_importeTotal NUMBER,
            w_importeTotalSinIVA NUMBER, w_importeTotalDescuento NUMBER, 
            w_anotacion VARCHAR2, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                factura facturas%rowtype;
            BEGIN
            UPDATE facturas SET oid_p = w_oid_p, oid_pe = w_oid_pe,
                fechaExpedicion = w_fechaExpedicion, importeTotal = w_importeTotal,
                importeTotalSinIVA = w_importeTotalSinIVA,
                importeTotalDescuento = w_importeTotalDescuento, anotacion = w_anotacion
                WHERE oid_fa = w_oid_fa;
            SELECT * INTO factura FROM facturas 
            WHERE oid_fa = w_oid_fa;
            IF(factura.oid_p<> w_oid_p OR factura.oid_pe <> w_oid_pe
                OR factura.fechaExpedicion <> w_fechaExpedicion OR 
                factura.importeTotal <> w_importeTotal OR factura.importeTotalSinIVA
                <> w_importeTotalSinIva OR factura.importeTotalDescuento <> 
                w_importeTotalDescuento OR factura.anotacion <> w_anotacion)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_fa SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_facturas INTEGER;
        BEGIN
            DELETE FROM facturas WHERE OID_fa = w_oid_fa;
            SELECT COUNT(*) INTO n_facturas FROM facturas 
                WHERE oid_fa= w_oid_fa;
            IF (n_facturas <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_FACTURAS;
/


CREATE OR REPLACE PACKAGE PRUEBAS_LINEAS_FACTURAS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_OID_FA SMALLINT,
            w_OID_LPE SMALLINT,w_importeTotal NUMBER,
            salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_LFA SMALLINT,w_OID_FA SMALLINT,
            w_OID_LPE SMALLINT,w_importeTotal NUMBER, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_lfa SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_LINEAS_FACTURAS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM facturas;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_OID_FA SMALLINT,
            w_OID_LPE SMALLINT,w_importeTotal NUMBER,
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            linea lineasdefactura%rowtype;
            w_oid_lfa SMALLINT;
        BEGIN
            INSERT INTO lineasdefactura VALUES(seq_lineasdefactura.nextval,
                w_OID_FA ,w_OID_LPE, w_importeTotal );
            w_oid_lfa := seq_lineasdefactura.currval;
            SELECT * INTO linea FROM lineasdefactura 
            WHERE oid_lfa = w_oid_lfa;
            IF(linea.oid_fa <> w_oid_fa OR linea.oid_lpe <> w_oid_lpe OR
                linea.importeTotal <> w_importeTotal)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_LFA SMALLINT,w_OID_FA SMALLINT,
            w_OID_LPE SMALLINT,w_importeTotal NUMBER, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                linea lineasdefactura%rowtype;
            BEGIN
            UPDATE lineasdefactura SET oid_fa = w_oid_fa, oid_lpe = w_oid_lpe,
                importeTotal = w_importeTotal
                WHERE oid_lfa = w_oid_lfa;
            SELECT * INTO linea FROM lineasdefactura 
            WHERE oid_lfa = w_oid_lfa;
            IF(linea.oid_fa <> w_oid_fa OR linea.oid_lpe <> w_oid_lpe OR
                linea.importeTotal <> w_importeTotal)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_lfa SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_lineas INTEGER;
        BEGIN
            DELETE FROM lineasdefactura WHERE OID_lfa = w_oid_lfa;
            SELECT COUNT(*) INTO n_lineas FROM lineasdefactura 
                WHERE oid_lfa= w_oid_lfa;
            IF (n_lineas <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_LINEAS_FACTURAS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_ENVIOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE, w_compañia VARCHAR2,
            w_importe NUMBER, w_numLocalizador VARCHAR2, w_paga VARCHAR2,
            w_OID_PE SMALLINT, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_ENV SMALLINT,
            w_fecha DATE, w_compañia VARCHAR2, w_importe NUMBER,
            w_numLocalizador VARCHAR2, w_paga VARCHAR2, w_OID_PE SMALLINT,
            salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_env SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_ENVIOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM envios;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE, w_compañia VARCHAR2,
            w_importe NUMBER, w_numLocalizador VARCHAR2, w_paga VARCHAR2,
            w_OID_PE SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            envio envios%rowtype;
            w_oid_env SMALLINT;
        BEGIN
            INSERT INTO envios VALUES(seq_envios.nextval,
                w_fecha, w_compañia, w_importe, w_numLocalizador, w_paga,
                w_OID_PE);
            w_oid_env := seq_envios.currval;
            SELECT * INTO envio FROM envios 
            WHERE oid_env = w_oid_env;
            IF(envio.fecha <> w_fecha OR envio.compañia <> w_compañia OR
                envio.importe <> w_importe OR envio.numLocalizador <> w_numLocalizador
                OR envio.paga <> w_paga OR envio.oid_pe <> w_oid_pe)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_ENV SMALLINT,
            w_fecha DATE, w_compañia VARCHAR2, w_importe NUMBER,
            w_numLocalizador VARCHAR2, w_paga VARCHAR2,w_OID_PE SMALLINT,
            salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                envio envios%rowtype;
            BEGIN
            UPDATE envios SET fecha = w_fecha, compañia = w_compañia,
                importe = w_importe, numLocalizador = w_numLocalizador,
                paga = w_paga, oid_pe = w_oid_pe
                WHERE oid_env = w_oid_env;
            SELECT * INTO envio FROM envios 
            WHERE oid_env = w_oid_env;
            IF(envio.fecha <> w_fecha OR envio.compañia <> w_compañia OR
                envio.importe <> w_importe OR envio.numLocalizador <> w_numLocalizador
                OR envio.paga <> w_paga OR envio.oid_pe <> w_oid_pe)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_env SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_envios INTEGER;
        BEGIN
            DELETE FROM envios WHERE OID_env = w_oid_env;
            SELECT COUNT(*) INTO n_envios FROM envios 
                WHERE oid_env= w_oid_env;
            IF (n_envios <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_ENVIOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_INCIDENCIAS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE, w_descripcion VARCHAR2,
        w_numRefProd VARCHAR2, w_OID_P SMALLINT, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_INC SMALLINT,
        w_fecha DATE, w_descripcion VARCHAR2, w_numRefProd VARCHAR2,
        w_OID_P SMALLINT, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_inc SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_INCIDENCIAS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM incidencias;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE, w_descripcion VARCHAR2,
        w_numRefProd VARCHAR2, w_OID_P SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            incidencia incidencias%rowtype;
            w_oid_inc SMALLINT;
        BEGIN
            INSERT INTO incidencias VALUES(seq_incidencias.nextval,
                w_fecha, w_descripcion, w_numRefProd, w_OID_P);
            w_oid_inc := seq_incidencias.currval;
            SELECT * INTO incidencia FROM incidencias 
            WHERE oid_inc = w_oid_inc;
            IF(incidencia.fecha <> w_fecha OR incidencia.descripcion <> w_descripcion 
            OR incidencia.numRefProd <> w_numRefProd OR incidencia.oid_p <> w_oid_p)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_INC SMALLINT,
        w_fecha DATE, w_descripcion VARCHAR2, w_numRefProd VARCHAR2,
        w_OID_P SMALLINT, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                incidencia incidencias%rowtype;
            BEGIN
            UPDATE incidencias SET fecha = w_fecha, descripcion = w_descripcion,
                numRefProd = w_numRefProd, oid_p = w_oid_p
                WHERE oid_inc = w_oid_inc;
            SELECT * INTO incidencia FROM incidencias 
            WHERE oid_inc = w_oid_inc;
            IF(incidencia.fecha <> w_fecha OR incidencia.descripcion <> w_descripcion 
                OR incidencia.numRefProd <> w_numRefProd 
                OR incidencia.oid_p <> w_oid_p)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_inc SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_incidencias INTEGER;
        BEGIN
            DELETE FROM incidencias WHERE OID_inc = w_oid_inc;
            SELECT COUNT(*) INTO n_incidencias FROM incidencias 
                WHERE oid_inc= w_oid_inc;
            IF (n_incidencias <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_INCIDENCIAS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_SOLUCIONES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE,
        w_tipoSolucion CHAR, w_OID_INC SMALLINT, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid_sol SMALLINT,w_fecha DATE,
        w_tipoSolucion CHAR, w_OID_INC SMALLINT, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_sol SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_SOLUCIONES
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM soluciones;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE,
        w_tipoSolucion CHAR, w_OID_INC SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            solucion soluciones%rowtype;
            w_oid_SOL SMALLINT;
        BEGIN
            INSERT INTO soluciones VALUES(seq_soluciones.nextval,
                w_fecha, w_tipoSolucion, w_OID_inc);
            w_oid_sol := seq_soluciones.currval;
            SELECT * INTO solucion FROM soluciones 
            WHERE oid_sol = w_oid_sol;
            IF(solucion.fecha <> w_fecha OR solucion.tipoSolucion <> w_tipoSolucion
                OR solucion.oid_inc <> w_oid_inc)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_oid_sol SMALLINT,w_fecha DATE,
            w_tipoSolucion CHAR, w_OID_INC SMALLINT, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                solucion soluciones%rowtype;
            BEGIN
            UPDATE soluciones SET fecha = w_fecha, tipoSolucion = w_tipoSolucion,
               oid_inc = w_oid_inc
                WHERE oid_sol = w_oid_sol;
            SELECT * INTO solucion FROM soluciones 
            WHERE oid_inc = w_oid_inc;
            IF(solucion.fecha <> w_fecha OR solucion.tipoSolucion <> w_tipoSolucion
                OR solucion.oid_inc <> w_oid_inc)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_sol SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_soluciones INTEGER;
        BEGIN
            DELETE FROM soluciones WHERE OID_sol = w_oid_sol;
            SELECT COUNT(*) INTO n_soluciones FROM soluciones 
                WHERE oid_sol= w_oid_sol;
            IF (n_soluciones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_SOLUCIONES;
/

--******************************************
CREATE OR REPLACE PACKAGE PRUEBAS_VALORACIONES_ST
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT,
        w_OID_sol SMALLINT, w_fecha DATE , w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_vst SMALLINT,  
        w_OID_P SMALLINT, w_OID_sol SMALLINT, w_fecha DATE, w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_vst SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_VALORACIONES_ST
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM valoracionesST;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT,
        w_OID_sol SMALLINT, w_fecha DATE , w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            valoracion valoracionesST%rowtype;
            w_oid_vst SMALLINT;
        BEGIN
            INSERT INTO valoracionesST VALUES(seq_valoracionesST.nextval,
                 w_fecha,w_valoracion, w_comentario, w_oid_p, w_oid_sol);
            w_oid_vst := seq_valoracionesst.currval;
            SELECT * INTO valoracion FROM valoracionesST 
            WHERE oid_vst = w_oid_vst;
            IF(valoracion.oid_p<> w_oid_p OR valoracion.oid_sol <> w_oid_sol
                OR valoracion.fecha <> w_fecha OR 
                valoracion.valoracion <> w_valoracion OR
                valoracion.comentario <> w_comentario)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_vst SMALLINT,  
        w_OID_P SMALLINT, w_OID_sol SMALLINT, w_fecha DATE, w_valoracion SMALLINT, 
        w_comentario VARCHAR2, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                valoracion valoracionesST%rowtype;
            BEGIN
            UPDATE valoracionesST SET oid_p = w_oid_p, oid_sol = w_oid_sol,
                fecha = w_fecha, valoracion = w_valoracion, comentario = w_comentario
                WHERE oid_vst = w_oid_vst;
            SELECT * INTO valoracion FROM valoracionesST
            WHERE oid_vst = w_oid_vst;
            IF(valoracion.oid_p<> w_oid_p OR valoracion.oid_sol <> w_oid_sol
                OR valoracion.fecha <> w_fecha OR 
                valoracion.valoracion <> w_valoracion OR
                valoracion.comentario <> w_comentario)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_vst SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_valoraciones INTEGER;
        BEGIN
            DELETE FROM valoracionesst WHERE OID_vst = w_oid_vst;
            SELECT COUNT(*) INTO n_valoraciones FROM valoracionesST
                WHERE oid_vst= w_oid_vst;
            IF (n_valoraciones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_VALORACIONES_ST;
/

CREATE OR REPLACE PACKAGE PRUEBAS_PRESUPUESTOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,w_fechaElaboracion DATE, 
        w_fechaDisponible DATE, w_estado CHAR, w_importe NUMBER,w_OID_SOL SMALLINT,
        w_OID_P SMALLINT, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_PRE SMALLINT,
        w_fechaElaboracion DATE, w_fechaDisponible DATE, w_estado CHAR, w_importe NUMBER,
        w_OID_SOL SMALLINT, w_OID_P SMALLINT, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pre SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_PRESUPUESTOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM presupuestos;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2,w_fechaElaboracion DATE, 
        w_fechaDisponible DATE, w_estado CHAR, w_importe NUMBER,w_OID_SOL SMALLINT,
        w_OID_P SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            presupuesto presupuestos%rowtype;
            w_oid_pre SMALLINT;
        BEGIN
            INSERT INTO presupuestos VALUES(seq_presupuestos.nextval,
                 w_fechaElaboracion,w_fechaDisponible, w_estado, w_importe, w_oid_sol,
                 w_oid_p);
            w_oid_pre:= seq_presupuestos.currval;
            SELECT * INTO presupuesto FROM presupuestos 
            WHERE oid_pre = w_oid_pre;
            IF(presupuesto.fechaElaboracion <> w_fechaElaboracion OR 
                presupuesto.fechaDisponible <> w_fechaDisponible OR
                presupuesto.estado <> w_estado OR presupuesto.importe <> w_importe
                OR presupuesto.oid_sol <> w_oid_sol OR  presupuesto.oid_p <>w_oid_p)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_PRE SMALLINT,
        w_fechaElaboracion DATE, w_fechaDisponible DATE, w_estado CHAR, w_importe NUMBER,
        w_OID_SOL SMALLINT, w_OID_P SMALLINT, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                presupuesto presupuestos%rowtype;
            BEGIN
            UPDATE presupuestos SET fechaElaboracion = w_fechaElaboracion,
                fechaDisponible = w_fechaDisponible, estado = w_estado,
                importe = w_importe, oid_sol = w_oid_sol, oid_p = w_oid_p
                WHERE oid_pre = w_oid_pre;
            SELECT * INTO presupuesto FROM presupuestos
                WHERE oid_pre = w_oid_pre;
            IF(presupuesto.fechaElaboracion <> w_fechaElaboracion OR 
                presupuesto.fechaDisponible <> w_fechaDisponible OR
                presupuesto.estado <> w_estado OR presupuesto.importe <> w_importe
                OR presupuesto.oid_sol <> w_oid_sol OR  presupuesto.oid_p <>w_oid_p)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_pre SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_presupuestos INTEGER;
        BEGIN
            DELETE FROM presupuestos WHERE OID_pre = w_oid_pre;
            SELECT COUNT(*) INTO n_presupuestos FROM presupuestos
                WHERE oid_pre= w_oid_pre;
            IF (n_presupuestos <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_PRESUPUESTOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_REPARACIONES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_fechaInicio DATE,
        w_fechaFin DATE, w_notas VARCHAR2, w_OID_PRE SMALLINT, w_OID_P SMALLINT,
        salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_REP SMALLINT, w_fechaInicio DATE,
        w_fechaFin DATE, w_notas VARCHAR2, w_OID_PRE SMALLINT, w_OID_P SMALLINT,
        salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_rep SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_REPARACIONES
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM reparaciones;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_fechaInicio DATE,
        w_fechaFin DATE, w_notas VARCHAR2, w_OID_PRE SMALLINT, w_OID_P SMALLINT,
        salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            reparacion reparaciones%rowtype;
            w_oid_rep SMALLINT;
        BEGIN
            INSERT INTO reparaciones VALUES(seq_reparaciones.nextval,
                 w_fechaInicio,w_fechaFin, w_notas, w_oid_pre, w_oid_p);
            w_oid_rep:= seq_reparaciones.currval;
            SELECT * INTO reparacion FROM reparaciones 
            WHERE oid_rep= w_oid_rep;
            IF(reparacion.fechaInicio <> w_fechaInicio OR 
            reparacion.fechaFin <> w_fechaFin OR reparacion.notas <> w_notas OR
            reparacion.oid_pre <> w_oid_pre OR reparacion.oid_p <> w_oid_p)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_REP SMALLINT, w_fechaInicio DATE,
        w_fechaFin DATE, w_notas VARCHAR2, w_OID_PRE SMALLINT, w_OID_P SMALLINT,
        salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                reparacion reparaciones%rowtype;
            BEGIN
            UPDATE reparaciones SET fechaInicio = w_fechaInicio,
                fechaFin = w_fechaFin, notas = w_notas, oid_pre = w_oid_pre, 
                oid_p = w_oid_p
                WHERE oid_rep = w_oid_rep;
            SELECT * INTO reparacion FROM reparaciones
                WHERE oid_rep = w_oid_rep;
            IF(reparacion.fechaInicio <> w_fechaInicio OR 
            reparacion.fechaFin <> w_fechaFin OR reparacion.notas <> w_notas OR
            reparacion.oid_pre <> w_oid_pre OR reparacion.oid_p <> w_oid_p)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_rep SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_reparaciones INTEGER;
        BEGIN
            DELETE FROM reparaciones WHERE OID_rep = w_oid_rep;
            SELECT COUNT(*) INTO n_reparaciones FROM reparaciones
                WHERE oid_rep= w_oid_rep;
            IF (n_reparaciones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_REPARACIONES;
/


CREATE OR REPLACE PACKAGE PRUEBAS_FOTOMATONES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_FOT SMALLINT,W_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_fot SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_FOTOMATONES
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM fotomatones;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            fotomaton fotomatones%rowtype;
            w_oid_fot SMALLINT;
        BEGIN
            INSERT INTO fotomatones VALUES(seq_fotomatones.nextval, w_anotaciones);
            w_oid_fot := seq_fotomatones.currval;
            SELECT * INTO fotomaton FROM fotomatones 
            WHERE oid_fot= w_oid_fot;
            IF(fotomaton.anotaciones <> w_anotaciones)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_FOT SMALLINT,W_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                fotomaton fotomatones%rowtype;
            BEGIN
            UPDATE fotomatones SET anotaciones = w_anotaciones 
                WHERE oid_fot = w_oid_fot;
            SELECT * INTO fotomaton FROM fotomatones
                WHERE oid_fot = w_oid_fot;
            IF(fotomaton.anotaciones <> w_anotaciones)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_fot SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_fotomatones INTEGER;
        BEGIN
            DELETE FROM fotomatones WHERE OID_fot = w_oid_fot;
            SELECT COUNT(*) INTO n_fotomatones FROM fotomatones
                WHERE oid_fot = w_oid_fot;
            IF (n_fotomatones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_FOTOMATONES;
/


CREATE OR REPLACE PACKAGE PRUEBAS_SEMINARIOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_FOT SMALLINT,W_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_fot SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_FOTOMATONES
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM fotomatones;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            fotomaton fotomatones%rowtype;
            w_oid_fot SMALLINT;
        BEGIN
            INSERT INTO fotomatones VALUES(seq_fotomatones.nextval, w_anotaciones);
            w_oid_fot := seq_fotomatones.currval;
            SELECT * INTO fotomaton FROM fotomatones 
            WHERE oid_fot= w_oid_fot;
            IF(fotomaton.anotaciones <> w_anotaciones)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_FOT SMALLINT,W_anotaciones VARCHAR2,
        salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                fotomaton fotomatones%rowtype;
            BEGIN
            UPDATE fotomatones SET anotaciones = w_anotaciones 
                WHERE oid_fot = w_oid_fot;
            SELECT * INTO fotomaton FROM fotomatones
                WHERE oid_fot = w_oid_fot;
            IF(fotomaton.anotaciones <> w_anotaciones)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_fot SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_fotomatones INTEGER;
        BEGIN
            DELETE FROM fotomatones WHERE OID_fot = w_oid_fot;
            SELECT COUNT(*) INTO n_fotomatones FROM fotomatones
                WHERE oid_fot = w_oid_fot;
            IF (n_fotomatones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_FOTOMATONES;
/

CREATE OR REPLACE PACKAGE PRUEBAS_SEMINARIOS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, w_fecha DATE, 
        w_lugar VARCHAR2, w_plazas SMALLINT, w_asistentes SMALLINT, w_precio NUMBER,
        salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_SEM SMALLINT, w_nombre VARCHAR2,
        w_fecha DATE, w_lugar VARCHAR2, w_plazas SMALLINT, w_asistentes SMALLINT,
        w_precio NUMBER, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_sem SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_SEMINARIOS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM seminarios;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, w_fecha DATE, 
        w_lugar VARCHAR2, w_plazas SMALLINT, w_asistentes SMALLINT, w_precio NUMBER,
        salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            seminario seminarios%rowtype;
            w_oid_sem SMALLINT;
        BEGIN
            INSERT INTO seminarios VALUES(seq_seminarios.nextval, w_nombre, 
                w_fecha, w_lugar, w_plazas, w_asistentes, w_precio);
            w_oid_sem:= seq_seminarios.currval;
            SELECT * INTO seminario FROM seminarios 
            WHERE oid_sem = w_oid_sem;
            IF(seminario.nombre <> w_nombre OR seminario.fecha <> w_fecha OR 
                seminario.lugar <> w_lugar OR seminario.plazas <> w_plazas OR
                seminario.asistentes <> w_asistentes OR 
                seminario.precio <> w_precio)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_SEM SMALLINT, w_nombre VARCHAR2,
        w_fecha DATE, w_lugar VARCHAR2, w_plazas SMALLINT, w_asistentes SMALLINT,
        w_precio NUMBER, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                seminario seminarios%rowtype;
            BEGIN
            UPDATE seminarios SET nombre = w_nombre, fecha = w_fecha, lugar = w_lugar,
                plazas = w_plazas, asistentes = w_asistentes, precio = w_precio
                WHERE oid_sem = w_oid_sem;
            SELECT * INTO seminario FROM seminarios
                WHERE oid_sem = w_oid_sem;
            IF(seminario.nombre <> w_nombre OR seminario.fecha <> w_fecha OR 
                seminario.lugar <> w_lugar OR seminario.plazas <> w_plazas OR
                seminario.asistentes <> w_asistentes OR 
                seminario.precio <> w_precio)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_sem SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_seminarios INTEGER;
        BEGIN
            DELETE FROM seminarios WHERE OID_sem = w_oid_sem;
            SELECT COUNT(*) INTO n_seminarios FROM seminarios
                WHERE oid_sem = w_oid_sem;
            IF (n_seminarios <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_SEMINARIOS;
/

CREATE OR REPLACE PACKAGE PRUEBAS_ALQUILERES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2,  w_salida DATE, w_devPrev DATE,
        w_devEfectiva DATE, w_comentario VARCHAR2, w_OID_P SMALLINT, 
        w_OID_FOT SMALLINT, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_ALQ SMALLINT,
        w_salida DATE, w_devPrev DATE, w_devEfectiva DATE, w_comentario VARCHAR2,
        w_OID_P SMALLINT, w_OID_FOT SMALLINT , salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_alq SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_ALQUILERES
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM alquileres;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_salida DATE, w_devPrev DATE,
        w_devEfectiva DATE, w_comentario VARCHAR2, w_OID_P SMALLINT, 
        w_OID_FOT SMALLINT, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            alquiler alquileres%rowtype;
            w_oid_alq SMALLINT;
        BEGIN
            INSERT INTO alquileres VALUES(seq_alquileres.nextval, w_salida, 
                w_devPrev, w_devEfectiva, w_comentario, w_oid_p, w_oid_fot);
            w_oid_alq:= seq_alquileres.currval;
            SELECT * INTO alquiler FROM alquileres 
            WHERE oid_alq = w_oid_alq;
            IF(alquiler.salida <> w_salida OR alquiler.devPrev <> w_devPrev OR
                alquiler.devEfectiva <> w_devEfectiva OR alquiler.comentario <>
                w_comentario OR alquiler.oid_p <> w_oid_p OR
                alquiler.oid_fot <> w_oid_fot)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_ALQ SMALLINT,
        w_salida DATE, w_devPrev DATE, w_devEfectiva DATE, w_comentario VARCHAR2,
        w_OID_P SMALLINT, w_OID_FOT SMALLINT , salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                alquiler alquileres%rowtype;
            BEGIN
            UPDATE alquileres SET salida = w_salida, devPrev = w_devPrev, 
                devEfectiva = w_devEfectiva, comentario = w_comentario, 
                oid_p = w_oid_p, oid_fot = w_oid_fot
                WHERE oid_alq = w_oid_alq;
            SELECT * INTO alquiler FROM alquileres
                WHERE oid_alq = w_oid_alq;
            IF(alquiler.salida <> w_salida OR alquiler.devPrev <> w_devPrev OR
                alquiler.devEfectiva <> w_devEfectiva OR alquiler.comentario <>
                w_comentario OR alquiler.oid_p <> w_oid_p OR
                alquiler.oid_fot <> w_oid_fot)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_alq SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_alquileres INTEGER;
        BEGIN
            DELETE FROM alquileres WHERE OID_alq = w_oid_alq;
            SELECT COUNT(*) INTO n_alquileres FROM alquileres
                WHERE oid_alq = w_oid_alq;
            IF (n_alquileres <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_ALQUILERES;
/

CREATE OR REPLACE PACKAGE PRUEBAS_INSCRIPCIONES
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT, w_OID_SEM SMALLINT, 
        w_fechaIns DATE, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_oid_ins SMALLINT,w_oid_p SMALLINT,
        w_oid_sem SMALLINT, w_fechaIns DATE, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_ins SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_INSCRIPCIONES
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM inscripciones;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_P SMALLINT, w_OID_SEM SMALLINT, 
        w_fechaIns DATE, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            inscripcion inscripciones%rowtype;
            w_oid_ins SMALLINT;
        BEGIN
            INSERT INTO inscripciones VALUES(seq_inscripciones.nextval, w_OID_P, 
                w_OID_SEM, w_fechaIns);
            w_oid_ins:= seq_inscripciones.currval;
            SELECT * INTO inscripcion FROM inscripciones 
            WHERE oid_ins = w_oid_ins;
            IF(inscripcion.oid_p <> w_oid_p OR inscripcion.oid_sem <> w_oid_sem
                OR inscripcion.fechaIns <> w_fechaIns)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_INS SMALLINT,w_OID_P SMALLINT,
        w_OID_SEM SMALLINT, w_fechaIns DATE, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                inscripcion inscripciones%rowtype;
            BEGIN
            UPDATE inscripciones SET oid_p = w_oid_p, oid_sem = w_oid_sem,
                fechaIns = w_fechaIns 
                WHERE oid_ins = w_oid_ins;
            SELECT * INTO inscripcion FROM inscripciones
                WHERE oid_ins = w_oid_ins;
            IF(inscripcion.oid_p <>w_oid_p OR inscripcion.oid_sem <> w_oid_sem
                OR inscripcion.fechaIns <> w_fechaIns)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_ins SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_inscripciones INTEGER;
        BEGIN
            DELETE FROM inscripciones WHERE OID_ins = w_oid_ins;
            SELECT COUNT(*) INTO n_inscripciones FROM inscripciones
                WHERE oid_ins = w_oid_ins;
            IF (n_inscripciones <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_INSCRIPCIONES;
/

CREATE OR REPLACE PACKAGE PRUEBAS_COBROS
AS
PROCEDURE inicializar;
PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE,w_importeTotal NUMBER,
            w_estado VARCHAR2, salidaEsperada BOOLEAN);
                
PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_COB SMALLINT, w_fecha DATE,
            w_importeTotal NUMBER, w_estado VARCHAR2, salidaEsperada BOOLEAN);

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_cob SMALLINT, 
                salidaEsperada BOOLEAN);

END;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_COBROS
AS
PROCEDURE inicializar
AS
    BEGIN
        DELETE FROM cobros;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_fecha DATE, w_importeTotal NUMBER,
            w_estado VARCHAR2, salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            cobro cobros%rowtype;
            w_oid_cob SMALLINT;
        BEGIN
            INSERT INTO cobros VALUES(seq_cobros.nextval, w_fecha, w_importeTotal, 
                w_estado);
            w_oid_cob:= seq_cobros.currval;
            SELECT * INTO cobro FROM cobros 
            WHERE oid_cob = w_oid_cob;
            IF(cobro.fecha <> w_fecha OR cobro.importeTotal <> w_importeTotal OR
                cobro.estado <> w_estado)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
            
END insertar;

PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_COB SMALLINT, w_fecha DATE,
            w_importeTotal NUMBER, w_estado VARCHAR2, salidaEsperada BOOLEAN)
            AS
                salida BOOLEAN := true;
                cobro cobros%rowtype;
            BEGIN
            UPDATE cobros SET fecha = w_fecha, estado = w_estado,
                importeTotal = w_importeTotal WHERE oid_cob = w_oid_cob;
            SELECT * INTO cobro FROM cobros
                WHERE oid_cob = w_oid_cob;
            IF(cobro.fecha <> w_fecha OR cobro.importeTotal <> w_importeTotal OR
                cobro.estado <> w_estado)
            THEN
                salida :=false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END actualizar;

PROCEDURE eliminar(nombre_prueba VARCHAR2, w_oid_cob SMALLINT, 
            salidaEsperada BOOLEAN)
        AS
            salida BOOLEAN := true;
            n_cobros INTEGER;
        BEGIN
            DELETE FROM cobros WHERE OID_cob = w_oid_cob;
            SELECT COUNT(*) INTO n_cobros FROM cobros
                WHERE oid_cob = w_oid_cob;
            IF (n_cobros <> 0) 
            THEN
                salida := false;
            END IF;
            COMMIT WORK;
                DBMS_OUTPUT.put_line(nombre_prueba || ':' || 
                ASSERT_EQUALS(salida,  salidaEsperada));
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line(nombre_prueba || ':' ||
                ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END eliminar;

END PRUEBAS_COBROS;
/
