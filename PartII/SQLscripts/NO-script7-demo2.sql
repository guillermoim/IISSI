DECLARE
oid_cliente1 SMALLINT;
oid_cliente2 SMALLINT;
oid_mun SMALLINT;
oid_pro SMALLINT;
oid_com SMALLINT;
oid_iae SMALLINT;
oid_fotomaton SMALLINT;
oid_alquiler SMALLINT;
oid_cobro1 SMALLINT;
BEGIN
borrar_todas_tablas();

insertar_comunidad('ANDALUCIA');
oid_com := seq_comunidades.currval;

insertar_provincia('SEVILLA', oid_com);
oid_pro := seq_provincias.currval;

insertar_municipio('CAMAS', oid_pro);
oid_mun := seq_municipios.currval;

insertar_cliente_profesional('Cliente1','Infante', '95467631', 'email1@us.es', 'usuario1', 'contraseña', '12344321K', oid_mun);
oid_cliente1:=seq_personas.currval;
oid_iae:=seq_docsiae.currval;

insertar_cliente_profesional('Guillermo','Infante', '95467631', 'email2@us.es', 'usuario2', 'contraseña', '01244321K', oid_mun);
oid_cliente2:=seq_personas.currval;

aceptar_doc_iae(oid_iae);

insertar_fotomaton('Se encuentra en perfecto estado.');
oid_fotomaton:=seq_fotomatones.currval;

--insertar_envio('DHL',10, '12343414132', oid_pedido1);

insertar_alquiler('20/10/2017', '25/10/2017', 'Nada', oid_cliente1, oid_fotomaton);
oid_alquiler:=seq_alquileres.currval;

cerrar_alquiler(oid_alquiler, '25/10/2017');

--salta trigger fechas alquiler.
--insertar_alquiler('21/10/2017', '25/10/2017', 'Nada', oid_cliente1, oid_fotomaton);

END;
