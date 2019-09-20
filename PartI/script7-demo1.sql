DECLARE
oid_producto1 SMALLINT;
oid_producto2 SMALLINT;
oid_cliente1 SMALLINT;
oid_cliente2 SMALLINT;
oid_mun SMALLINT;
oid_pro SMALLINT;
oid_com SMALLINT;
oid_iae SMALLINT;
oid_pedido1 SMALLINT;
oid_pedido2 SMALLINT;
oid_cobro1 SMALLINT;
BEGIN
borrar_todas_tablas();

insertar_comunidad('ANDALUCIA');
oid_com := seq_comunidades.currval;

insertar_provincia('SEVILLA', oid_com);
oid_pro := seq_provincias.currval;

insertar_municipio('CAMAS', oid_pro);
oid_mun := seq_municipios.currval;

insertar_producto('CONSUMIBLES', 20.99, '348EQF934', 15, 2, 0);
oid_producto1 := seq_productos.currval;

insertar_producto('CÁMARAS', 400.00, '83R3JKNQF8', 200, 2, 0);
oid_producto2 := seq_productos.currval;

insertar_cliente_profesional('Cliente1','Infante', '95467631', 'email1@us.es', 'usuario1', 'contraseña', '12344321K', oid_mun);
oid_cliente1:=seq_personas.currval;
oid_iae:=seq_docsiae.currval;

insertar_cliente_profesional('Guillermo','Infante', '95467631', 'email2@us.es', 'usuario2', 'contraseña', '01244321K', oid_mun);
oid_cliente2:=seq_personas.currval;

aceptar_doc_iae(oid_iae);

insertar_pedido(oid_cliente1);
oid_pedido1:=seq_pedidos.currval;

--SUSTITUIR valor de la la cantidad para TRIGGER de no disponible...
insertar_linea_pedido(oid_pedido1, oid_producto1, 2);
insertar_linea_pedido(oid_pedido1, oid_producto2, 1);

cerrar_pedido(oid_pedido1);
oid_cobro1:= seq_cobros.currval;

--insertar_envio('DHL',10, '12343414132', oid_pedido1);

marcar_cobro_recibido(oid_cobro1);
END;

