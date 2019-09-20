SET SERVEROUTPUT ON;

drop sequence seq_pruebascorrectas;
drop sequence seq_pruebasfallidas;

create sequence seq_pruebascorrectas start with 0 minvalue 0;
create sequence seq_pruebasfallidas start with 0 minvalue 0;

DECLARE
oid_persona1 SMALLINT;
oid_persona2 SMALLINT;
oid_persona3 SMALLINT;
oid_comunidad1 SMALLINT;
oid_comunidad2 SMALLINT;
oid_provincia1 SMALLINT;
oid_provincia2 SMALLINT;
oid_municipio1 SMALLINT;
oid_municipio2 SMALLINT;
oid_cliente1 SMALLINT;
oid_cliente2 SMALLINT;
oid_empleado1 SMALLINT;
oid_empleado2 SMALLINT;
oid_tarjeta1 SMALLINT;
oid_tarjeta2 SMALLINT;
oid_iae SMALLINT;
oid_producto1 SMALLINT;
oid_producto2 SMALLINT;
oid_producto3 SMALLINT;
oid_producto4 SMALLINT;
oid_pedido1 SMALLINT;
oid_pedido2 SMALLINT;
oid_lineapedido1 SMALLINT;
oid_lineapedido2 SMALLINT;
oid_valpr SMALLINT;
oid_factura1 SMALLINT;
oid_factura2 SMALLINT;
oid_lineafactura SMALLINT;
oid_envio SMALLINT;
oid_cob1 SMALLINT;
oid_incidencia SMALLINT;
oid_solucion SMALLINT;
oid_valst SMALLINT;
oid_presupuesto SMALLINT;
oid_reparacion SMALLINT;
oid_fotomaton1 SMALLINT;
oid_fotomaton2 SMALLINT;
oid_seminario1 SMALLINT;
oid_seminario2 SMALLINT;
oid_seminario3 SMALLINT;
oid_alquiler SMALLINT;
oid_inscripcion SMALLINT;
oid_cobro SMALLINT;
BEGIN
PRUEBAS_COBROS.INICIALIZAR;
PRUEBAS_INSCRIPCIONES.INICIALIZAR;
PRUEBAS_ALQUILERES.INICIALIZAR;
PRUEBAS_SEMINARIOS.INICIALIZAR;
PRUEBAS_FOTOMATONES.INICIALIZAR;
PRUEBAS_REPARACIONES.INICIALIZAR;
PRUEBAS_PRESUPUESTOS.INICIALIZAR;
PRUEBAS_VALORACIONES_ST.INICIALIZAR;
PRUEBAS_SOLUCIONES.INICIALIZAR;
PRUEBAS_INCIDENCIAS.INICIALIZAR;
PRUEBAS_ENVIOS.INICIALIZAR;
PRUEBAS_LINEAS_FACTURAS.INICIALIZAR;
PRUEBAS_FACTURAS.INICIALIZAR;
PRUEBAS_LINEAS_PEDIDOS.INICIALIZAR;
PRUEBAS_PEDIDOS.INICIALIZAR;
PRUEBAS_PRODUCTOS.INICIALIZAR;
PRUEBAS_DOCSIAE.INICIALIZAR;
PRUEBAS_TARJETAS.INICIALIZAR;
PRUEBAS_CLIENTES.INICIALIZAR;
PRUEBAS_EMPLEADOS.INICIALIZAR;
PRUEBAS_PERSONAS.INICIALIZAR;
PRUEBAS_MUNICIPIOS.INICIALIZAR;
PRUEBAS_PROVINCIAS.INICIALIZAR;
PRUEBAS_COMUNIDADES.INICIALIZAR;


 /**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE PERSONAS 
 ****************************************/
 
DBMS_OUTPUT.PUT_LINE('PRUEBAS PERSONAS');

PRUEBAS_PERSONAS.INSERTAR('Prueba 1, inserción de persona correcta', 'Guillermo', 
        'Infante','9546738', 'correo@gmail.com', 
        'F','usuario', 'contrasena', 
        true);
        
        oid_persona1 := seq_personas.currval;
        
PRUEBAS_PERSONAS.INSERTAR('Prueba 2, inserción(2) de persona correcta', 'Guillermo', 
        'Infante', '9546738', 'correo2@gmail.com', 
        'F','usuario2', 'contrasena', 
        true);
        
        oid_persona2 := seq_personas.currval;
        
PRUEBAS_PERSONAS.INSERTAR('Prueba 3, inserción(3) de persona correcta', 'Guillermo', 
        'Infante','9546738', 'correo3@gmail.com', 
        'T','usuario3', 'contrasena', 
        true);
        
        oid_persona3 := seq_personas.currval;
        
PRUEBAS_PERSONAS.INSERTAR('Prueba 4, inserción de persona con número no válido', 'Guillermo', 
        'Infante','K123413', 'correo@gmail.com', 
        'F','usuario', 'contrasena', 
        false);
        
PRUEBAS_PERSONAS.ACTUALIZAR('Prueba 5, actualización de persona correcta', 
        oid_persona1,'Guillermo', 
        'Infante','9546738', 'correo@gmail.com', 
        'F','usuario', 'contrasena', 
        true);

PRUEBAS_PERSONAS.ACTUALIZAR('Prueba 6, actualización de persona con número no válido', 
        oid_persona1,'Guillermo', 
        'Infante','A954A6738', 'correo@gmail.com', 
        'F','usuario', 'contrasena', 
        false);

PRUEBAS_PERSONAS.ELIMINAR('Prueba 7, eliminación de persona', oid_persona1, true);

 /**************************************** 
PRUEBAS DE LAS OPERACIONES SOBRE COMUNIDADES 
 ****************************************/
 
DBMS_OUTPUT.PUT_LINE('PRUEBAS COMUNIDADES');

PRUEBAS_COMUNIDADES.insertar('Prueba 8, inserción comunidad correcta', 'ANDALUCIA', 
            TRUE);
            
            oid_comunidad1 := seq_comunidades.currval;

PRUEBAS_COMUNIDADES.insertar('Prueba 9, inserción (2) comunidad correcta', 'CATALUÑA', 
            TRUE);
            
            oid_comunidad2 := seq_comunidades.currval;
            
PRUEBAS_COMUNIDADES.insertar('Prueba 10, inserción comunidad repetida', 'ANDALUCIA', 
            false);
            
PRUEBAS_COMUNIDADES.actualizar('Prueba 11, actualización comunidad', oid_comunidad1,
            'EXTREMADURA', true);  

PRUEBAS_COMUNIDADES.eliminar('Prueba 12, eliminación comunidad', oid_comunidad1, true);

 /**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE PROVINCIAS
 ****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS PROVINCIAS');

PRUEBAS_PROVINCIAS.insertar('Prueba 13, inserción provincia correcta', 'BARCELONA', 
            oid_comunidad2, true);
            
            oid_provincia1 := seq_provincias.currval;
            
PRUEBAS_PROVINCIAS.insertar('Prueba 14, inserción (2) provincia correcta', 'TARRAGONA', 
            oid_comunidad2, true);
            
            oid_provincia2 := seq_provincias.currval;
            
PRUEBAS_PROVINCIAS.insertar('Prueba 15, inserción provincia repetida', 'BARCELONA', 
            oid_comunidad2, false);
            
PRUEBAS_PROVINCIAS.actualizar('Prueba 16, actualización provincia', oid_provincia1,
            'LLEIDA', oid_comunidad2, true);  

PRUEBAS_PROVINCIAS.eliminar('Prueba 17, eliminación provincia', oid_provincia1, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE MUNICIPIOS
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS MUNICIPIOS');

 
PRUEBAS_MUNICIPIOS.insertar('Prueba 18, inserción municipio correcta', 'ALIÓ', 
            oid_provincia2, true);
            
            oid_municipio1 := seq_municipios.currval;
            
PRUEBAS_MUNICIPIOS.insertar('Prueba 19, inserción (2) municipio correcta', 'FIGUEROLA', 
            oid_provincia2, true);
            
            oid_municipio2 := seq_municipios.currval;
            
PRUEBAS_MUNICIPIOS.insertar('Prueba 20, inserción municipio repetida', 'ALIÓ', 
            oid_provincia2, false);
            
PRUEBAS_MUNICIPIOS.actualizar('Prueba 21, actualización municipio', oid_municipio1,
            'MILÁ', oid_comunidad2, true);  

PRUEBAS_MUNICIPIOS.eliminar('Prueba 22, eliminación municipio', oid_municipio1, true);


/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE CLIENTES
 ****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS CLIENTES');

PRUEBAS_CLIENTES.insertar('Prueba 23, inserción cliente correcta', oid_persona2, 
            '12345312K', NULL, 'PROFESIONAL', oid_municipio2, true);
            
            oid_cliente2 := oid_persona2;
            
PRUEBAS_CLIENTES.insertar('Prueba 24, inserción (2) cliente correcta', oid_persona3, 
            '1234512P', 'Fotomania', 'EMPRESA', oid_municipio2, true);
            
            oid_cliente1 := oid_persona3;
            
PRUEBAS_CLIENTES.actualizar('Prueba 25, actualización cliente', oid_persona2, 
            '02345312K', NULL, 'PROFESIONAL', oid_municipio2, true);  

PRUEBAS_CLIENTES.eliminar('Prueba 26, eliminación cliente', oid_cliente1, true);


/**************************************** 
PRUEBAS DE LAS OPERACIONES SOBRE EMPLEADOS
****************************************/
 
DBMS_OUTPUT.PUT_LINE('PRUEBAS EMPLEADOS');

PRUEBAS_EMPLEADOS.insertar('Prueba 27, inserción empleado correcta', oid_persona3, 
            '12345671234567','20/11/1997', NULL, 1200.50, 'ALMACEN', 'Domicilio empleado',
            true);
            
            oid_empleado1 := seq_personas.currval;
            
PRUEBAS_EMPLEADOS.actualizar('Prueba 28, actualización empleado', oid_persona3, 
            '12345672134567','20/11/1999', '11/12/2004',10050.00, 'ADMINISTRADOR',
            'Domicilio empleado', true);  

PRUEBAS_EMPLEADOS.eliminar('Prueba 29, eliminación empleado', oid_persona3, true);

PRUEBAS_EMPLEADOS.insertar('Prueba 30, inserción(2) empleado correcta', oid_persona3, 
            '12345677654321','20/11/1999', '11/12/2003',10050.00, 'SERVICIOTECNICO', 'Domicilio empleado',
            true);
            
            oid_empleado2 := oid_persona3;



/**************************************** 
PRUEBAS DE LAS OPERACIONES SOBRE TARJETAS DE CREDITO
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS TARJETAS DE CREDITO');

PRUEBAS_TARJETAS.insertar('Prueba 31, inserción tajeta correcta', oid_cliente2, 
            '1111111111111', 12, 21, 'NOMBRE DEL TITULAR', 'VISA', 301,
            true);

            oid_tarjeta1 := seq_tarjetasCredito.currval;
            
PRUEBAS_TARJETAS.insertar('Prueba 32, inserción(2) tajeta correcta', oid_cliente2, 
            '1111111114444', 10, 21, 'NOMBRE DEL TITULAR', 'master card', 301,
            true);

            oid_tarjeta2 := seq_tarjetasCredito.currval;
            
PRUEBAS_TARJETAS.actualizar('Prueba 33, actualización tarjeta',oid_tarjeta1, oid_cliente2, 
            '2111111111111', 11, 21, 'NOMBRE DEL TITULAR', 'VISA', 301, true);  

PRUEBAS_TARJETAS.actualizar('Prueba 34, actualización tarjeta incorrecta',oid_tarjeta1, oid_cliente2, 
            '211111111111', 13, 21, 'NOMBRE DEL TITULAR', 'VISA', 301, false); 

PRUEBAS_TARJETAS.eliminar('Prueba 35, eliminación tarjeta', oid_tarjeta1, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE DOCUMENTOS IAE
 ****************************************/
oid_iae := seq_docsIAE.currval;

DBMS_OUTPUT.PUT_LINE('PRUEBAS DOCUMENTOS IAE');

PRUEBAS_DOCSIAE.insertar('Prueba 36, inserción documento IAE correcta', oid_cliente2, 
            'ESPERA', false);


PRUEBAS_DOCSIAE.actualizar('Prueba 37, actualización documento IAE', oid_iae,
                oid_cliente2, 'ACEPTADO', true);  

PRUEBAS_DOCSIAE.actualizar('Prueba 38, actualización documento IAE incorrecta', oid_iae,
                oid_cliente2, 'OTRO ESTADO', false); 

PRUEBAS_DOCSIAE.eliminar('Prueba 39,  eliminación documento IAE', oid_iae, true);

 PRUEBAS_DOCSIAE.insertar('Prueba 40, inserción (2) documento IAE correcta', oid_cliente2, 
            'ACEPTADO', true);

            oid_iae := seq_docsIAE.currval;

/**************************************** 
PRUEBAS DE LAS OPERACIONES SOBRE PRODUCTOS
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS PRODUCTOS');

PRUEBAS_PRODUCTOS.insertar('Prueba 41, insercion producto correcta','CONSUMIBLES',
        15.99, '14NJN1R87BJH', '01/01/2016', 7.50, 40, 10, true);

            oid_producto1 := seq_productos.currval;
            
PRUEBAS_PRODUCTOS.insertar('Prueba 42, insercion(2) producto correcta','CAMARAS',
        399.99, 'KPO32F3NXSA', '01/01/2017', 350.00, 200, 20, true);

            oid_producto2 := seq_productos.currval;
            
PRUEBAS_PRODUCTOS.insertar('Prueba 43, insercion(3) producto correcta','IMPRESORAS',
        799.99, 'KPO323NXSA', '01/01/2017', 200.00, 200, 20, true);

            oid_producto3 := seq_productos.currval;

PRUEBAS_PRODUCTOS.insertar('Prueba 44, insercion(4) producto correcta','OTROS',
        100.99, 'ASD34DAS12', '01/01/2018', 50.00, 1, 2, true);

            oid_producto4 := seq_productos.currval;
            
PRUEBAS_PRODUCTOS.actualizar('Prueba 45, actualización producto incorrecta',
           oid_producto1,'OTROS', 10.99, 'ASD34DAS12', '01/01/2018', 50.00, 1, 2, false);  

PRUEBAS_PRODUCTOS.actualizar('Prueba 46, actualización producto correcta',oid_producto1,
        'CONSUMIBLES', 20.00, '14NJN1R87BJH', '01/01/2017', 10.00, 20,10, TRUE); 

PRUEBAS_PRODUCTOS.eliminar('Prueba 47, eliminación producto', oid_producto4, true);

/**************************************** 
PRUEBAS DE LAS OPERACIONES SOBRE PEDIDOS
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS PEDIDOS');

PRUEBAS_PEDIDOS.insertar('Prueba 48, insercion pedido correcta', oid_cliente2,
                SYSDATE,0.0,'NOTRAMITADO', true);

            oid_pedido1 := seq_pedidos.currval;
            
PRUEBAS_PEDIDOS.insertar('Prueba 49, insercion pedido(2) correcta', oid_cliente2,
                SYSDATE,0.0,'NOTRAMITADO', true);

            oid_pedido2 := seq_pedidos.currval;
            
PRUEBAS_PEDIDOS.actualizar('Prueba 50, actualización pedido correcta',
           oid_pedido1,oid_cliente2, SYSDATE, 10, 'NOTRAMITADO', true);  


PRUEBAS_PEDIDOS.eliminar('Prueba 51, eliminación pedido', oid_pedido2, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE LINEAS DE PEDIDO
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS LINEAS DE PEDIDO');


PRUEBAS_LINEAS_PEDIDOS.insertar('Prueba 52, insercion línea de pedido correcta', oid_pedido1,
                oid_producto2,3, true);

            oid_lineapedido1 := seq_lineasdepedido.currval;
            
PRUEBAS_LINEAS_PEDIDOS.insertar('Prueba 53, insercion línea de pedido(2) correcta', oid_pedido1,
                oid_producto3,3,true);

            oid_lineapedido2 := seq_lineasdepedido.currval;
            
PRUEBAS_LINEAS_PEDIDOS.actualizar('Prueba 54, actualización línea de pedido correcta',oid_lineapedido2,
           oid_pedido1,oid_producto3, 4, true);  


PRUEBAS_LINEAS_PEDIDOS.eliminar('Prueba 55, eliminación línea de pedido', oid_lineapedido2, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE VALORACIONES DE PRODUCTOS
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS VALORACIONES DE PRODUCTOS');

PRUEBAS_VALORACIONES_PRODUCTOS.insertar('Prueba 56, insercion valoración producto correcta', oid_cliente2,
            oid_producto2,SYSDATE, 3,'Producto de muy buena calidad', true);

            oid_valpr := seq_valoracionesproductos.currval;
            
PRUEBAS_VALORACIONES_PRODUCTOS.insertar('Prueba 57, insercion valoración producto incorrecta', oid_cliente2,
            oid_producto3,SYSDATE, 3,'Producto de muy buena calidad', false);
             
PRUEBAS_VALORACIONES_PRODUCTOS.actualizar('Prueba 58, actualización valoración producto correcta', 
            oid_valpr, oid_cliente2, oid_producto2,SYSDATE, 4,'Producto de muy buena calidad', true);

PRUEBAS_VALORACIONES_PRODUCTOS.eliminar('Prueba 59, eliminación valoración producto', oid_valpr, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE FACTURAS
****************************************/

DBMS_OUTPUT.PUT_LINE('PRUEBAS FACTURAS');

PRUEBAS_FACTURAS.insertar('Prueba 60, insercion factura correcta', oid_cliente2,
            oid_pedido1,SYSDATE, 0,0,0,'Se le aplica descuento...', true);

            oid_factura2 := seq_facturas.currval;
             
PRUEBAS_FACTURAS.actualizar('Prueba 61, actualización factura correcta', oid_factura2, oid_cliente2,
            oid_pedido1,SYSDATE, 1,1,1,'Se le aplica descuento...', true);

PRUEBAS_FACTURAS.eliminar('Prueba 52, eliminación factura producto', oid_factura2, true);

PRUEBAS_FACTURAS.insertar('Prueba 63, insercion(2) factura correcta', oid_cliente2,
            oid_pedido1,SYSDATE, 0,0,0,'Se le aplica descuento...', true);

            oid_factura1 := seq_facturas.currval;

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE LINEAS DE FACTURAS
****************************************/


PRUEBAS_LINEAS_FACTURAS.insertar('Prueba 64, insercion línea de factura correcta', oid_factura1,
            oid_lineapedido1, 4  * 400,true);

            oid_lineafactura := seq_lineasdefactura.currval;
             
PRUEBAS_LINEAS_FACTURAS.actualizar('Prueba 65, actualización línea de factura correcta', oid_lineafactura,
            oid_factura1, oid_lineapedido1, 4  * 450,true);

PRUEBAS_LINEAS_FACTURAS.eliminar('Prueba 66, eliminación línea de factura producto', oid_lineafactura, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE ENVIOS
****************************************/

cerrar_pedido(oid_pedido1);
SELECT oid_cob INTO oid_cob1 from cobrospedidos WHERE oid_pe = oid_pedido1;
marcar_cobro_recibido(oid_cob1);

PRUEBAS_ENVIOS.insertar('Prueba 67, insercinn de envío correcta',SYSDATE, 'correos',
            20.00, '235FW4352', 'CLIENTE', oid_pedido1,true);
            
            oid_envio := seq_envios.currval;

PRUEBAS_ENVIOS.actualizar('Prueba 68, actualización de envío correcta',oid_envio,SYSDATE, 'correos',
            20.00, 'ASDASC352', 'CLIENTE', oid_pedido1,true);
            
PRUEBAS_ENVIOS.ELIMINAR('Prueba 69, eliminación de envío', oid_envio, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE INCIDENCIAS
****************************************/

PRUEBAS_INCIDENCIAS.insertar('Prueba 70, inserción de incidencia correcta',SYSDATE,
            'La cámara no salta el flash cuando está seleccionado.',
            'numeroreferencia', oid_cliente2,true);
            
            oid_incidencia := seq_incidencias.currval;


PRUEBAS_INCIDENCIAS.actualizar('Prueba 71, actualización de incidencia correcta',
            oid_incidencia,SYSDATE, 'Otra descripción.',
            'numeroreferencia', oid_cliente2,true);
            
PRUEBAS_INCIDENCIAS.ELIMINAR('Prueba 72, eliminación de incidencia', oid_incidencia, true);

            
PRUEBAS_INCIDENCIAS.insertar('Prueba 73, inserción(2) de incidencia correcta',SYSDATE,
            'La cámara no salta el flash cuando está seleccionado.',
            'numeroreferencia', oid_cliente2,true);
            
            oid_incidencia := seq_incidencias.currval;
            
/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE SOLUCIONES
****************************************/


PRUEBAS_SOLUCIONES.insertar('Prueba 74, inserción de solucion correcta',SYSDATE,
            'TALLER', oid_incidencia,true);
            
            oid_solucion := seq_soluciones.currval;


PRUEBAS_SOLUCIONES.actualizar('Prueba 75, actualización de solución correcta',
            oid_solucion, SYSDATE, 'TALLER', oid_incidencia, true);
            
PRUEBAS_SOLUCIONES.ELIMINAR('Prueba 76, eliminación de solucion', oid_solucion, true);

            
PRUEBAS_SOLUCIONES.insertar('Prueba 77, inserción(2) de solucion correcta',SYSDATE,
            'TALLER', oid_incidencia,true);
            
            oid_solucion := seq_soluciones.currval;

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE VALORACIONESST
****************************************/

PRUEBAS_VALORACIONES_ST.insertar('Prueba 78, inserción valoración ST correcta', oid_cliente2,
            oid_solucion,SYSDATE, 3,'Servicio de muy buena calidad', true);

            oid_valst := seq_valoracionesst.currval;          

PRUEBAS_VALORACIONES_ST.actualizar('Prueba 79, actualización valoración ST correcta', 
            oid_valst, oid_cliente2, oid_solucion,SYSDATE, 4,'Servicio de muy buena calidad', true);

PRUEBAS_VALORACIONES_ST.eliminar('Prueba 80, eliminación valoración producto', oid_valst, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE PRESUPUESTOS
****************************************/


PRUEBAS_PRESUPUESTOS.insertar('Prueba 81, inserción de presupuesto correcta','02/02/2017',
            '05/02/2017', 'ACEPTADO', 20.00, oid_solucion, oid_empleado2, true);
            
            oid_presupuesto := seq_presupuestos.currval;


PRUEBAS_PRESUPUESTOS.actualizar('Prueba 82, actualización de solución correcta', oid_presupuesto,
            '02/02/2017','05/02/2017', 'ACEPTADO', 30.00, oid_solucion, oid_empleado2,
            true);
            
PRUEBAS_PRESUPUESTOS.ELIMINAR('Prueba 83, eliminación de solucion', oid_presupuesto, true);

            
PRUEBAS_PRESUPUESTOS.insertar('Prueba 84, inserción(2) de presupuesto correcta','02/02/2017',
            '05/02/2017', 'ACEPTADO', 20.00, oid_solucion, oid_empleado2, true);
            
            oid_presupuesto := seq_presupuestos.currval;

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE REPARACIONES
****************************************/

PRUEBAS_REPARACIONES.insertar('Prueba 85, inserción de reparación correcta','5/2/2017',
        '12/2/2017', '',oid_presupuesto, oid_empleado2, true);
            
            oid_reparacion := seq_reparaciones.currval;


PRUEBAS_REPARACIONES.actualizar('Prueba 86, actualización de solución correcta', oid_reparacion,
           '5/2/2017', '12/2/2017', '',oid_presupuesto, oid_empleado2, true);
            
PRUEBAS_REPARACIONES.ELIMINAR('Prueba 87, eliminación de reparacion', oid_reparacion, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE FOTOMATONES
****************************************/

PRUEBAS_FOTOMATONES.insertar('Prueba 88, inserción de fotomatón correcta',
            'Tiene uno de los apoyos dañado', true);
            
            oid_fotomaton1 := seq_fotomatones.currval;
            
PRUEBAS_FOTOMATONES.insertar('Prueba 89, inserción(2) de fotomatón correcta',
            'Tiene uno de los apoyos dañado', true);
            
            oid_fotomaton2 := seq_fotomatones.currval;
            
PRUEBAS_FOTOMATONES.actualizar('Prueba 90, actualización de fotomatón correcta',
            oid_fotomaton2, 'Tiene uno de los apoyos dañado. Pantalla dañada.', 
            true);
            
            oid_fotomaton2 := seq_fotomatones.currval;
PRUEBAS_FOTOMATONES.eliminar('Prueba 91, eliminación de fotomatón',
            oid_fotomaton2, 
            true);
            
/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE SEMINARIOS
****************************************/

PRUEBAS_SEMINARIOS.insertar('Prueba 92, inserción de seminario correcta',
            'Seminario sobre luz ','20/03/2018','Local',20,10, 7.99, true);
            
            oid_seminario1 := seq_seminarios.currval;
            
PRUEBAS_SEMINARIOS.insertar('Prueba 93, inserción de seminario(2) correcta',
            'Seminario sobre luz ','20/03/2018','Local',20,10, 8.99, true);
            
            oid_seminario2 := seq_seminarios.currval;

PRUEBAS_SEMINARIOS.insertar('Prueba 94, inserción de seminario(3) correcta',
            'Seminario sobre luz ','20/03/2018','Local',20,20, 7.99, true);
            
            oid_seminario3 := seq_seminarios.currval;
            
PRUEBAS_SEMINARIOS.insertar('Prueba 95, inserción de seminario correcta',
            'Seminario sobre luz ','20/03/2018','Local',20,10, 8.99, true);
            
            oid_seminario2 := seq_seminarios.currval;
            
PRUEBAS_SEMINARIOS.actualizar('Prueba 96, actualización de seminario correcta',
            oid_seminario2,'Seminario sobre impresion','20/03/2018','Local',20,10, 0,
            true);
            
            oid_seminario2 := seq_seminarios.currval;
            
PRUEBAS_SEMINARIOS.eliminar('Prueba 97, eliminación de seminario', oid_seminario2, 
            true);
            
/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE ALQUILERES
****************************************/

PRUEBAS_ALQUILERES.insertar('Prueba 98, inserción de alquiler correcta',
            '2/2/2018',  '7/2/2018', null,  'El usuario lo devuelve en buen estado',
            oid_cliente2, oid_fotomaton1, true);
            
            oid_alquiler := seq_alquileres.currval;
            
PRUEBAS_ALQUILERES.insertar('Prueba 99, inserción(2) de alquiler incorrecta (fechas no válidas)',
            '2/2/2018',  '7/2/2018', null,  'El usuario lo devuelve en buen estado',
            oid_cliente2, oid_fotomaton1, false);
                        
PRUEBAS_ALQUILERES.actualizar('Prueba 100, actualización de alquiler correcta',
            oid_alquiler, '2/2/2018',  '7/2/2018', '7/2/1018',  
            'El usuario lo devuelve en buen estado', oid_cliente2, oid_fotomaton1, 
            true);
            
            
PRUEBAS_ALQUILERES.eliminar('Prueba 101, eliminación de alquiler', oid_alquiler, 
            true);
            
/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE INSCRIPCIONES
****************************************/

PRUEBAS_INSCRIPCIONES.insertar('Prueba 102, inserción de inscripción correcta',
            oid_cliente2, oid_seminario1,SYSDATE, true);
            
            oid_inscripcion := seq_inscripciones.currval;

PRUEBAS_INSCRIPCIONES.insertar('Prueba 103, inserción de inscripción incorrecta  
            (plazas no disponibles)', oid_cliente2, oid_seminario3,SYSDATE, false);
            
                       
PRUEBAS_INSCRIPCIONES.actualizar('Prueba 104, actualización de inscripción correcta',
            oid_inscripcion, oid_cliente2, oid_seminario1,SYSDATE - 1, true);
            
            
PRUEBAS_INSCRIPCIONES.eliminar('Prueba 105, eliminación de inscripción', 
            oid_inscripcion, true);

/**************************************** 
 PRUEBAS DE LAS OPERACIONES SOBRE COBROS
****************************************/

PRUEBAS_COBROS.insertar('Prueba 106, inserción de cobro correcta',
            SYSDATE,10, 'PENDIENTE', true);
            
            oid_cobro := seq_cobros.currval;
            
PRUEBAS_COBROS.actualizar('Prueba 107, actualización de cobro correcta',oid_cobro,
            SYSDATE, 10, 'REALIZADO', true);
            
            
PRUEBAS_COBROS.eliminar('Prueba 108, eliminación de cobro', 
            oid_cobro, true);
            
END;


