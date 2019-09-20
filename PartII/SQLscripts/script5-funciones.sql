SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION lista_clientes
RETURN NUMBER
IS
resultado INTEGER;
CURSOR C1 IS 
select * from personas natural join clientes;
BEGIN
SELECT COUNT(*) INTO resultado from clientes;
DBMS_OUTPUT.PUT_LINE('Lista de clientes:');
FOR fila IN c1 LOOP
    DBMS_OUTPUT.PUT_LINE(fila.NIF||' '||fila.nombre||' '||fila.apellidos||' '||
    fila.tipoCliente||' '||fila.empresa||' '||fila.telefono||' '||fila.email);
END LOOP;
RETURN resultado; 
END;
/

CREATE OR REPLACE FUNCTION lista_clientes_profesionales
RETURN NUMBER
IS
resultado INTEGER;
CURSOR C1 IS 
select * from clientes c natural join personas natural join  documentosIAE where c.tipoCliente='PROFESIONAL';
BEGIN
    SELECT COUNT(*) INTO resultado from clientes where tipoCliente = 'PROFESIONAL';
    DBMS_OUTPUT.PUT_LINE('Lista de clientes profesionales y estado del IAE:');
    FOR fila IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE(fila.NIF||' '||fila.nombre||' '||fila.apellidos ||' '
        ||fila.apellidos||' '||fila.estado);
    END LOOP;
RETURN resultado; 
END;
/

CREATE OR REPLACE FUNCTION lista_clientes_ccaa(
    w_ccaa IN comunidades.oid_com%type
)
RETURN NUMBER
IS
resultado NUMBER;
f_comunidad VARCHAR2(30);
CURSOR C1 IS 
select nif, nombre, apellidos, telefono, email,
    provincia, comunidad, municipio from personas natural join clientes 
    natural join municipios  natural join provincias 
    natural join comunidades where w_ccaa = oid_com;
BEGIN
    SELECT comunidad INTO f_comunidad from comunidades where oid_com = w_ccaa;
    DBMS_OUTPUT.PUT_LINE('Lista de clientes con domicilio en '||f_comunidad||':');
    FOR fila IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(fila.nif||' '||fila.nombre||' '||fila.apellidos||' '
        ||fila.telefono||' '||fila.email||' '||fila.provincia||' '
        ||fila.municipio);
        resultado := C1%ROWCOUNT;
    END LOOP;
RETURN resultado; 
END;
/

CREATE OR REPLACE FUNCTION lista_clientes_provincia(
    w_prov IN provincias.oid_pro%type
)
RETURN NUMBER
IS
resultado NUMBER;
f_provincia VARCHAR2(30);
CURSOR C1 IS 
select nif, nombre, apellidos, telefono, email, municipio 
    from personas natural join clientes 
    natural join municipios  natural join provincias 
    natural join comunidades where w_prov = oid_pro;
BEGIN
    SELECT provincia INTO f_provincia from provincias where oid_pro = w_prov;
    DBMS_OUTPUT.PUT_LINE('Lista de clientes con domicilio en '||f_provincia||':');
    FOR fila IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(fila.nif||' '||fila.nombre||' '||fila.apellidos||' '
        ||fila.telefono||' '||fila.email||' '||fila.municipio);
        resultado := C1%ROWCOUNT;
    END LOOP;
RETURN resultado; 
END;
/

CREATE OR REPLACE FUNCTION asistencia_media_seminarios
RETURN NUMBER
IS
resultado NUMBER;
BEGIN
    SELECT AVG(asistentes) INTO resultado FROM seminarios;
RETURN resultado;
END;
/

CREATE OR REPLACE FUNCTION ASSERT_EQUALS (salida BOOLEAN, 
salidaEsperada BOOLEAN)
RETURN VARCHAR2
AS
    PruebasCorrectas INTEGER; 
    PruebasFallidas INTEGER;
BEGIN
    IF (salida = salidaEsperada) THEN
        BEGIN
            pruebasCorrectas := Seq_PruebasCorrectas.nextval; 
            RETURN 'EXITO';
        END;
    ELSE
        BEGIN
            pruebasFallidas := Seq_PruebasFallidas.nextval; 
            RETURN 'FALLO';
        END;
    END IF;
END;
/

CREATE OR REPLACE FUNCTION obtener_Estadisticas_Pruebas 
RETURN VARCHAR2
IS
pruebasCorrectas INTEGER;
pruebasFallidas INTEGER; total INTEGER;
BEGIN
DBMS_OUTPUT.PUT_LINE('----------------------RESULTADOS DE LAS PRUEBAS- -------------------------');
pruebasCorrectas := Seq_PruebasCorrectas.nextval;
pruebasFallidas := Seq_PruebasFallidas.nextval;
total := pruebasCorrectas + PruebasFallidas; 
DBMS_OUTPUT.put_line('Pruebas realizadas: ' || total); 
DBMS_OUTPUT.put_line('Pruebas correctas: ' || pruebasCorrectas); 
DBMS_OUTPUT.put_line('Pruebas fallidas: ' || pruebasFallidas);
RETURN ('-----------------------------------------');
END;
/



