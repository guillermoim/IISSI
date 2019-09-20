/*
    Procedimientos asociados a la inserción y eliminación de datos
    en las tablas.
*/

CREATE OR REPLACE PROCEDURE insertar_comunidad(

    w_nombre IN comunidades.comunidad%type

)
IS
BEGIN
    INSERT INTO comunidades(comunidad) values(w_nombre);
END insertar_comunidad;
/

CREATE OR REPLACE PROCEDURE borrar_comunidad(
    w_oid_com IN COMUNIDADES.OID_COM%type
)
IS
BEGIN
    DELETE FROM comunidades where oid_com = w_oid_com;
END borrar_comunidad;
/

--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_provincia(
    w_nombre IN provincias.provincia%type,
    w_oid_com IN provincias.oid_com%type
)
IS
BEGIN
    INSERT INTO provincias(provincia, oid_com) values(w_nombre, w_oid_com);
END insertar_provincia;
/

CREATE OR REPLACE PROCEDURE borrar_provincia(
    w_oid_pro IN provincias.OID_PRO%TYPE
)
IS
BEGIN
    DELETE FROM provincias WHERE oid_pro=w_oid_pro;
END borrar_provincia;
/

--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_municipio(
    w_nombre IN municipios.municipio%type,
    w_oid_pro IN municipios.oid_pro%type
)
IS
BEGIN
    INSERT INTO MUNICIPIOS(municipio, oid_pro) values(w_nombre, w_oid_pro);
END insertar_municipio;
/

CREATE OR REPLACE PROCEDURE borrar_municipio(
    w_oid_mun IN municipios.OID_MUN%TYPE
)
IS
BEGIN
    DELETE FROM municipios WHERE oid_mun=w_oid_mun;
END borrar_municipio;
/

--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_cliente_empresa(

    w_nombre IN personas.nombre%type,
    w_apellidos IN personas.apellidos%type,
    w_telefono IN personas.telefono%type,
    w_email IN personas.email%type,
    w_usuario IN personas.usuario%type,
    w_contrasena IN personas.contrasena%type,
    w_nif IN clientes.nif%type,
    w_empresa IN clientes.empresa%type,
    w_OID_MUN IN CLIENTES.OID_MUN%type
)
IS
BEGIN
    INSERT INTO personas(nombre, apellidos, telefono, email, usuario, contrasena) 
    values (w_nombre, w_apellidos, w_telefono, w_email, w_usuario, w_contrasena);
    INSERT INTO clientes(oid_p, nif, empresa,tipoCliente, OID_MUN) 
    values(seq_personas.currval, w_nif,w_empresa, 'EMPRESA', w_OID_MUN);
END insertar_cliente_empresa;
/


CREATE OR REPLACE PROCEDURE insertar_cliente_profesional(
    w_nombre IN personas.nombre%type,
    w_apellidos IN personas.apellidos%type,
    w_telefono IN personas.telefono%type,
    w_email IN personas.email%type,
    w_usuario IN personas.usuario%type,
    w_contrasena IN personas.contrasena%type,
    w_nif IN clientes.nif%type,
    w_OID_MUN IN CLIENTES.OID_MUN%type
)
IS
BEGIN
    INSERT INTO personas(nombre, apellidos, telefono, email, usuario, contrasena) 
    values (w_nombre, w_apellidos, w_telefono, w_email, w_usuario, w_contrasena);
    INSERT INTO clientes(oid_p, nif, tipoCliente, OID_MUN) 
    values(seq_personas.currval, w_nif,'PROFESIONAL', w_OID_MUN);
END insertar_cliente_profesional;
/
--------------------------------------
CREATE OR REPLACE PROCEDURE insertar_empleado(
    w_nombre IN personas.nombre%type,
    w_apellidos IN personas.apellidos%type,
    w_telefono IN personas.telefono%type,
    w_email IN personas.email%type,
    w_usuario IN personas.usuario%type,
    w_contrasena IN personas.contrasena%type,
    w_nss IN empleados.nss%type,
    w_fechaInicio IN empleados.fechaInicio%type,
    w_fechaFin IN empleados.fechaFin%type,
    w_salario IN empleados.salario%type,
    w_tipoEmpleado IN empleados.tipoEmpleado%type,
    w_domicilio IN empleados.domicilio%type
)
IS
BEGIN
    INSERT INTO personas(nombre, apellidos, telefono, email, usuario, contrasena) 
    values (w_nombre, w_apellidos, w_telefono, w_email, w_usuario, w_contrasena);
    INSERT INTO empleados(oid_p, nss, fechaInicio, fechaFin, salario, tipoEmpleado, domicilio) 
    values(seq_personas.currval, w_nss,w_fechaInicio,w_fechaFin, w_salario, w_tipoEmpleado, w_domicilio);
END insertar_empleado;
/
--------------------------------------
CREATE OR REPLACE PROCEDURE insertar_director(
    w_nombre IN personas.nombre%type,
    w_apellidos IN personas.apellidos%type,
    w_telefono IN personas.telefono%type,
    w_email IN personas.email%type,
    w_usuario IN personas.usuario%type,
    w_contrasena IN personas.contrasena%type
)
IS
BEGIN
    INSERT INTO personas(nombre, apellidos, telefono, email, usuario, contrasena) 
    values (w_nombre, w_apellidos, w_telefono, w_email, w_usuario, w_contrasena);
    INSERT INTO directores(OID_P) values(seq_personas.currval);
END insertar_director;
/
----------------------------------------
CREATE OR REPLACE PROCEDURE borrar_persona(
    w_oid_p IN personas.oid_p%type
)
IS
BEGIN
    DELETE FROM personas WHERE oid_p = w_oid_p;
END borrar_persona;
/
--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_tarjetaCredito(
    w_OID_P IN tarjetasCredito.oid_p%type,
    w_numero IN tarjetasCredito.numero%type,
    w_mes IN tarjetasCredito.mes%type,
    w_anyo IN tarjetasCredito.anyo%type,
    w_titular IN tarjetasCredito.titular%type,
    w_marca IN tarjetasCredito.marca%type,
    w_cvv IN tarjetasCredito.cvv%type
)
IS
BEGIN
    INSERT INTO tarjetasCredito (OID_P, numero, mes, anyo, titular, marca, cvv)
    values(w_OID_P, w_numero, w_mes, w_anyo, w_titular, w_marca, w_cvv);
END insertar_tarjetaCredito;
/

CREATE OR REPLACE PROCEDURE borrar_tarjetaCredito(
    w_oid_p IN tarjetasCredito.oid_p%type
)
IS
BEGIN
    DELETE FROM tarjetasCredito where oid_p = w_oid_p;
END borrar_tarjetaCredito;
/
--------------------------------------
CREATE OR REPLACE PROCEDURE insertar_producto(
    w_familia IN productos.familia%type,
    w_precio IN productos.precio%type,
    w_numReferencia IN productos.numReferencia%type,
    w_coste  IN productos.coste%type,
    w_stock IN productos.stock%type,
    w_cantidadCritica IN productos.cantidadCritica%type
)
IS
BEGIN
    INSERT INTO productos(familia,precio, numReferencia, coste, stock,
    cantidadCritica) values(w_familia, w_precio, w_numReferencia, w_coste, w_stock,
    w_cantidadCritica);
END insertar_producto;
/

CREATE OR REPLACE PROCEDURE borrar_producto(
    w_oid_pr IN productos.oid_pr%type
)
IS
BEGIN
    DELETE FROM productos WHERE oid_pr = w_oid_pr;
END;
/

--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_valoracion_producto(
        w_oid_p IN valoracionesProductos.oid_p%type,
        w_oid_pr IN valoracionesProductos.oid_pr%type,
        w_valoracion IN valoracionesProductos.valoracion%type,
        w_comentario IN valoracionesProductos.comentario%type
)
IS
BEGIN
    INSERT INTO valoracionesProductos(oid_p, oid_pr, valoracion, comentario) 
    values(w_oid_p, w_oid_pr, w_valoracion, w_comentario);
END insertar_valoracion_producto;
/

CREATE OR REPLACE PROCEDURE borrar_valoracion_producto(
    w_oid_vpr IN valoracionesProductos.oid_vpr%type
)
IS
BEGIN
    DELETE FROM valoracionesProductos WHERE oid_vpr = w_oid_vpr;
END borrar_valoracion_producto;
/

--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_pedido(
    w_oid_p IN pedidos.oid_p%type
)
IS
BEGIN
 INSERT INTO pedidos (oid_p, estado) values (w_oid_p, 'NOTRAMITADO');
END insertar_pedido;
/

CREATE OR REPLACE PROCEDURE cerrar_pedido(
    w_oid_pe in pedidos.oid_pe%type
)
IS
    f_importeTotal pedidos.importetotal%type := 0;
    CURSOR C1 IS
    SELECT * FROM lineasDePedido natural join productos where w_oid_pe = oid_pe;
BEGIN
    FOR fila IN C1 LOOP
        f_importeTotal := f_importeTotal + (fila.cantidad * fila.precio);
    END LOOP;
    UPDATE pedidos SET importeTotal = f_importeTotal, fecha = SYSDATE, 
    estado = 'ALMACEN' WHERE oid_pe = w_oid_pe;
END cerrar_pedido;
/

CREATE OR REPLACE PROCEDURE borrar_pedido(
    w_oid_pe IN pedidos.oid_pe%type
)
IS
BEGIN
    DELETE FROM pedidos WHERE oid_pe = w_oid_pe;
END borrar_pedido;
/
--------------------------------------

CREATE OR REPLACE PROCEDURE insertar_linea_pedido(
    w_oid_pe IN lineasDePedido.oid_pe%type,
    w_oid_pr IN lineasDePedido.oid_pr%type,
    w_cantidad IN lineasDePedido.cantidad%type
    
)
IS
    counter SMALLINT;
    f_cantidad lineasDePedido.cantidad%type;
BEGIN
    SELECT COUNT(*) INTO counter FROM lineasDePedido 
        WHERE w_oid_pe = oid_pe AND w_oid_pr = oid_pr;
    IF counter = 1
    THEN
        SELECT cantidad INTO f_cantidad FROM lineasDePedido 
          WHERE w_oid_pe = oid_pe AND w_oid_pr = oid_pr;
        UPDATE lineasDePedido SET cantidad = (f_cantidad + w_cantidad) WHERE
            w_oid_pe = oid_pe AND w_oid_pr = oid_pr;
    ELSE
        INSERT INTO lineasDePedido(oid_pe, oid_pr, cantidad) 
            values(w_oid_pe, w_oid_pr, w_cantidad);
    END IF;
END insertar_linea_pedido;
/

CREATE OR REPLACE PROCEDURE borrar_linea_pedido(
    w_oid_lpe IN lineasDePedido.oid_lpe%type
)
IS
BEGIN
    DELETE FROM lineasDePedido where w_oid_lpe = oid_lpe;
END borrar_linea_pedido;
/

--------------------------------------------
--------------------------------------------


CREATE OR REPLACE PROCEDURE insertar_factura(
    w_oid_pe IN facturas.oid_pe%type
)
IS
    f_cliente facturas.oid_p%type;
    f_importeTotalFA facturas.importetotal%type;
    f_oid_fa facturas.oid_fa%type;
    CURSOR C1 IS
        SELECT * FROM lineasDePedido natural join productos WHERE oid_pe = w_oid_pe;
BEGIN
    SELECT OID_P INTO f_cliente FROM pedidos WHERE oid_pe = w_oid_pe;
    INSERT INTO facturas(oid_p, oid_pe) VALUES (f_cliente, w_oid_pe);
    SELECT seq_facturas.currval INTO f_oid_fa FROM DUAL;
    FOR fila IN C1 LOOP
        INSERT INTO lineasDeFactura(OID_FA,OID_LPE, importeTotal)
        VALUES(f_oid_fa, fila.oid_lpe, (fila.precio * fila.cantidad));
    END LOOP;
    SELECT SUM(importeTotal) INTO f_importeTotalFA FROM lineasDeFactura 
    where f_oid_fa = oid_fa;
    UPDATE facturas 
        set fechaExpedicion = sysdate, 
        importetotal = f_importeTotalFA,
        importeTotalSinIVA = f_importeTotalFA * (0.89),
        importeTotalDescuento = f_importeTotalFA * (0.997)
        where oid_fa = f_oid_fa;
END insertar_factura;
/

CREATE OR REPLACE PROCEDURE borrar_factura(
    w_oid_fa IN facturas.oid_fa%type
)
IS
BEGIN
    DELETE FROM facturas where w_oid_fa = w_oid_fa;
END borrar_factura;
/

--------------------------------------------

CREATE OR REPLACE PROCEDURE insertar_envio(
    w_compañia IN envios.compañia%type,
    w_importe IN envios.importe%type,
    w_numLocalizador IN envios.numLocalizador%type,
    w_oid_pe IN envios.oid_pe%type
)
IS
BEGIN
    INSERT INTO envios(compañia, importe, numLocalizador, oid_pe) 
    values(w_compañia, w_importe, w_numLocalizador, w_oid_pe);
END insertar_envio;
/

CREATE OR REPLACE PROCEDURE borrar_envio(
    w_oid_env IN envios.oid_env%type
)
IS
BEGIN
    DELETE FROM envios WHERE oid_env = w_oid_env;
END borrar_envio;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_incidencia(
    w_fecha IN incidencias.fecha%type,
    w_descripcion IN incidencias.descripcion%type,
    w_numRefProd IN incidencias.numRefProd%type,
    w_oid_p IN incidencias.oid_p%type
)
IS
BEGIN
    INSERT INTO incidencias(fecha, descripcion, numRefProd, oid_p)
    values (w_fecha, w_descripcion, w_numRefProd, w_oid_p);
END insertar_incidencia;
/

CREATE OR REPLACE PROCEDURE borrar_incidencia(
    w_oid_inc IN incidencias.oid_inc%type
)
IS
BEGIN
    DELETE FROM incidencias WHERE w_oid_inc = oid_inc;
END borrar_incidencia;
/

--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_solucion(
    w_fecha IN soluciones.fecha%type,
    w_tipoSolucion IN soluciones.tipoSolucion%type,
    w_oid_inc IN incidencias.oid_inc%type
)
IS
BEGIN
    INSERT INTO soluciones(fecha, tipoSolucion, oid_inc)
    values (w_fecha, w_tipoSolucion, w_oid_inc);
END insertar_solucion;
/

CREATE OR REPLACE PROCEDURE borrar_solucion(
    w_oid_sol IN soluciones.oid_sol%type
)
IS
BEGIN
    DELETE FROM soluciones WHERE w_oid_sol = oid_sol;
END borrar_solucion;
/

CREATE OR REPLACE PROCEDURE insertar_valoracionST(
    w_fecha IN valoracionesST.fecha%type,
    w_comentario IN valoracionesST.comentario%type,
    w_OID_P IN valoracionesST.oid_p%type,
    w_OID_SOL IN valoracionesST.oid_p%type
)
IS
BEGIN
    INSERT INTO valoracionesST(fecha, comentario, oid_p, oid_sol)
    values (w_fecha, w_comentario, w_oid_p, w_oid_sol);
END insertar_valoracionST;
/

CREATE OR REPLACE PROCEDURE borrar_valoracionST(
    w_oid_vst IN valoracionesST.oid_vst%type
)
IS
BEGIN
    DELETE FROM valoracionesST WHERE w_oid_vst = oid_vst;
END borrar_valoracionST;
/
--------------------------------------------

CREATE OR REPLACE PROCEDURE insertar_presupuesto(
    w_fechaDisponible IN presupuestos.fechaDisponible%type,
    w_importe IN presupuestos.importe%type,
    w_OID_SOL IN presupuestos.oid_sol%type,
    w_OID_P IN presupuestos.oid_p%type
)
IS 
BEGIN
    INSERT INTO presupuestos(fechaDisponible, importe,estado, oid_sol, oid_p)
    values(w_fechaDisponible, w_importe,'PENDIENTE', w_oid_sol, w_oid_p);
END insertar_presupuesto;
/

CREATE OR REPLACE PROCEDURE borrar_presupuesto(
    w_oid_pre IN presupuestos.oid_pre%type
)
IS
BEGIN
    DELETE FROM presupuestos WHERE w_oid_pre = oid_pre;
END borrar_presupuesto;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_reparacion(
    w_fechaInicio IN reparaciones.fechaInicio%type,
    w_fechaFin IN reparaciones.fechaFin%type,
    w_notas IN reparaciones.notas%type,
    w_OID_PRE IN reparaciones.oid_pre%type, 
    w_OID_P IN reparaciones.oid_p%type
)
IS
BEGIN
    INSERT INTO reparaciones(fechaInicio, fechaFin, notas, oid_pre,oid_p)
    values(w_fechaInicio, w_fechaFin, w_notas, w_oid_pre, w_oid_p);
END insertar_reparacion;
/

CREATE OR REPLACE PROCEDURE borrar_reparacion(
    w_oid_rep IN reparaciones.oid_rep%type
)
IS
BEGIN
    DELETE FROM reparaciones WHERE w_oid_rep = oid_rep;
END borrar_reparacion;
/

--------------------------------------------

CREATE OR REPLACE PROCEDURE insertar_fotomaton(
    w_anotaciones IN fotomatones.anotaciones%type
)
IS
BEGIN
    INSERT INTO fotomatones(anotaciones) values (w_anotaciones);
END insertar_fotomaton;
/

CREATE OR REPLACE PROCEDURE borrar_fotomaton(
    w_oid_fot IN fotomatones.oid_fot%type
)
IS
BEGIN
    DELETE FROM fotomatones WHERE oid_fot = w_oid_fot;
END borrar_fotomaton;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_alquiler(
    w_salida IN alquileres.salida%type,
    w_devPrev IN alquileres.devPrev%type,
    w_comentario IN alquileres.comentario%type,
    w_OID_P IN alquileres.oid_p%type,
    w_OID_FOT IN alquileres.oid_fot%type
)
IS
BEGIN
    INSERT INTO alquileres(salida, devPrev, comentario, OID_P, OID_FOT)
    values (w_salida, w_devPrev, w_comentario, w_oid_P, w_oid_fot);
END insertar_alquiler;
/

CREATE OR REPLACE PROCEDURE cerrar_alquiler(
    w_oid_alq In alquileres.oid_alq%type,
    w_devEfectiva IN alquileres.devEfectiva%type
)
IS
BEGIN
    UPDATE alquileres SET devEfectiva = w_devEfectiva WHERE w_oid_alq = oid_alq;
END cerrar_alquiler;
/


CREATE OR REPLACE PROCEDURE borrar_alquiler(
    w_oid_alq IN alquileres.oid_alq%type
)
IS
BEGIN
    DELETE FROM alquileres WHERE oid_alq = w_oid_alq;
END borrar_alquiler;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_seminario(
    w_nombre IN seminarios.nombre%type,
    w_fecha IN seminarios.fecha%type,
    w_lugar IN seminarios.lugar%type,
    w_plazas IN seminarios.plazas%type,
    w_precio IN seminarios.precio%type
)
IS
BEGIN
    INSERT INTO seminarios(nombre, fecha, lugar, plazas, precio) 
        values(w_nombre, w_fecha, w_lugar,  w_plazas, w_precio);
END insertar_seminario;
/

CREATE OR REPLACE PROCEDURE borrar_seminario(
    w_oid_sem IN seminarios.oid_sem%type
)
IS
BEGIN
    DELETE FROM seminarios WHERE oid_sem = w_oid_Sem;
END borrar_seminario;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_inscripcion(
    w_oid_p IN inscripciones.oid_P%type,
    w_oid_sem IN inscripciones.oid_ins%type
)
IS
BEGIN
    INSERT INTO inscripciones(oid_p, oid_sem) values (w_oid_p, w_oid_sem);
END insertar_inscripcion;
/

CREATE OR REPLACE PROCEDURE borrar_inscripcion(
    w_oid_ins IN inscripciones.oid_ins%type
)
IS
BEGIN
    DELETE FROM inscripciones WHERE oid_ins = w_oid_ins;
END borrar_inscripcion;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_cobro_presupuesto(
    w_importeTotal IN cobros.importeTotal%type,
    w_oid_pre IN cobrosST.oid_pre%type
)
IS
BEGIN
    INSERT INTO cobros(importeTotal, estado) values (w_importeTotal, 'PENDIENTE');
    INSERT INTO cobrosST(oid_cob,oid_pre) 
    values(seq_cobros.currval, w_oid_pre);
END insertar_cobro_presupuesto;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_cobro_alquiler(
    w_importeTotal IN cobros.importeTotal%type,
    w_oid_alq IN cobrosAlquiler.oid_alq%type
)
IS
BEGIN
    INSERT INTO cobros(importeTotal, estado) values (w_importeTotal, 'PENDIENTE');
    INSERT INTO cobrosAlquiler(oid_cob,oid_alq) 
    values(seq_cobros.currval, w_oid_alq);
END insertar_cobro_alquiler;
/   
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_cobro_pedido(
    w_importeTotal IN cobros.importeTotal%type,
    w_oid_pe IN cobrosPedidos.oid_pe%type
)
IS
BEGIN
    INSERT INTO cobros(importeTotal, estado) values (w_importeTotal, 'PENDIENTE');
    INSERT INTO cobrosPedidos(oid_cob,oid_pe) 
    values(seq_cobros.currval, w_oid_pe);
END insertar_cobro_pedido;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_cobro_inscripcion(
    w_importeTotal IN cobros.importeTotal%type,
    w_oid_ins IN cobrosInscripcion.oid_ins%type
)
IS
BEGIN
    INSERT INTO cobros(importeTotal, estado) values (w_importeTotal, 'PENDIENTE');
    INSERT INTO cobrosInscripcion(oid_cob,oid_ins) 
    values(seq_cobros.currval, w_oid_ins);
END insertar_cobro_inscripcion;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE insertar_cobro_envio(
    w_importeTotal IN cobros.importeTotal%type,
    w_oid_env IN cobrosEnvios.oid_env%type
)
IS
BEGIN
    INSERT INTO cobros(importeTotal, estado) values (w_importeTotal, 'PENDIENTE');
    INSERT INTO cobrosEnvios(oid_cob,oid_env) 
    values(seq_cobros.currval, w_oid_env);
END insertar_cobro_envio;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE borrar_cobro(
    w_oid_cob IN cobros.oid_cob%type
)
IS
BEGIN
    DELETE FROM cobros WHERE oid_cob = w_oid_cob;
END borrar_cobro;
/

--------------------------------------------

CREATE OR REPLACE PROCEDURE aceptar_doc_iae(
    w_oid_iae IN documentosIAE.oid_iae%type
)
IS
BEGIN
    UPDATE documentosIAE SET estado = 'ACEPTADO'
    WHERE oid_iae = w_oid_iae;
END aceptar_doc_iae;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE rechazar_doc_iae(
    w_oid_iae IN documentosIAE.oid_iae%type
)
IS
BEGIN
    UPDATE documentosIAE SET estado = 'RECHAZADO'
    WHERE oid_iae = w_oid_iae;
END rechazar_doc_iae;
/
--------------------------------------------
CREATE OR REPLACE PROCEDURE marcar_cobro_recibido(
    w_oid_cob IN cobros.oid_cob%type
)
IS
BEGIN
    UPDATE cobros SET estado = 'REALIZADO' 
    WHERE oid_cob = w_oid_cob;
END marcar_cobro_recibido;
/

--------------------------------------------
CREATE OR REPLACE PROCEDURE borrar_todas_tablas
IS
BEGIN
DELETE FROM cobrosEnvios;
DELETE FROM cobrosPedidos;
DELETE FROM cobrosST;
DELETE FROM cobrosAlquiler;
DELETE FROM cobrosInscripcion;
DELETE FROM cobros;
DELETE FROM tarjetasCredito;
DELETE FROM documentosIAE;
DELETE FROM lineasDeFactura;
DELETE FROM lineasDePedido;
DELETE FROM valoracionesProductos;
DELETE FROM productos;
DELETE FROM envios;
DELETE FROM facturas;
DELETE FROM pedidos;
DELETE FROM reparaciones;
DELETE FROM presupuestos;
DELETE FROM valoracionesST;
DELETE FROM soluciones;
DELETE FROM incidencias;
DELETE FROM alquileres;
DELETE FROM fotomatones;
DELETE FROM inscripciones;
DELETE FROM seminarios;
DELETE FROM empleados;
DELETE FROM directores;
DELETE FROM clientes;
DELETE FROM personas;
DELETE FROM municipios;
DELETE FROM provincias;
DELETE FROM comunidades;
END borrar_todas_tablas;
/

