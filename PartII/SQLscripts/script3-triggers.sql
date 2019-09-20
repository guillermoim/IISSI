/*
 * Triggers no asociados a secuencias.
 */
CREATE OR REPLACE TRIGGER check_nif_clientes
BEFORE
INSERT OR UPDATE 
ON clientes
FOR EACH ROW
BEGIN
 IF :NEW.tipoCliente = 'EMPRESA'
 THEN
    IF(NOT REGEXP_LIKE(:NEW.nif,'^\d{7}[A-Z]$', 'i'))
    THEN    
        raise_application_error(-20600, 'El NIF de la empresa debe tener un formato correcto.');
    END IF;
 ELSE
    IF(NOT REGEXP_LIKE(:NEW.nif,'^\d{8}[A-Z]$','i'))
    THEN    
        raise_application_error(-20600, 'El NIF de un cliente profesional debe tener un formato correcto.');
    END IF;
 END IF;
END;
/

CREATE OR REPLACE TRIGGER check_personas
BEFORE
INSERT OR UPDATE 
ON personas 
FOR EACH ROW
BEGIN
    IF(NOT REGEXP_LIKE(:NEW.telefono,'^\d*$', 'i'))
        THEN  
        raise_application_error(-20600, 'El teléfono debe contener sólo dígitos.');
    END IF;
END;
 /

CREATE OR REPLACE TRIGGER crear_iae_cliente_profesional
AFTER
INSERT 
ON clientes
FOR EACH ROW
BEGIN
    IF :NEW.tipoCliente = 'PROFESIONAL'
    THEN
        INSERT INTO documentosIAE(OID_P,estado ) values(:NEW.OID_P, 'ESPERA');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_iae_aceptado
BEFORE 
INSERT
ON pedidos
FOR EACH ROW
DECLARE
    cliente clientes%rowtype;
    docIAE documentosIAE%rowtype;
BEGIN
    SELECT * INTO cliente FROM clientes WHERE :NEW.OID_P = OID_P;
    IF cliente.tipoCliente = 'PROFESIONAL'
    THEN
        SELECT * INTO docIAE FROM documentosIAE WHERE :NEW.OID_P = OID_P;
        IF docIAE.estado <> 'ACEPTADO'
        THEN
            raise_application_error(-20600, 'Para realizar una compra, 
            un cliente profesional debe tener su documento IAE aceptado.');
        END IF;
    END IF;

END check_iae_aceptado;
/


CREATE OR REPLACE TRIGGER check_producto_adquirido
BEFORE
INSERT 
ON valoracionesProductos
FOR EACH ROW
DECLARE
    counter SMALLINT;
BEGIN
    SELECT count(*) INTO counter FROM pedidos natural join 
        lineasDePedido WHERE oid_p = :NEW.OID_P AND OID_PR = :NEW.OID_PR;
    IF NOT counter > 0
    THEN
        raise_application_error(-20603, 'El cliente debe haber comprado el producto para poder valorarlo.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER asociar_pago_pedido
AFTER
UPDATE
OF estado ON pedidos
FOR EACH ROW
BEGIN
    IF :NEW.estado='ALMACEN'
    THEN
        insertar_cobro_pedido(:NEW.importeTotal*0.997, :NEW.oid_pe);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_pedido_pagado
BEFORE
INSERT
ON envios
FOR EACH ROW
DECLARE
    f_estado cobros.estado%type;
BEGIN
    SELECT estado INTO f_estado FROM cobros natural 
        join cobrosPedidos WHERE oid_pe = :NEW.oid_pe;
    IF f_estado = 'PENDIENTE'
    THEN
        raise_application_error(-20600, 'El pedido debe haber sido pagado para poder asociar un envío.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER actualizar_stock
AFTER
INSERT OR DELETE OR UPDATE
ON lineasDePedido
FOR EACH ROW
DECLARE
    cantidadActual productos.stock%type;
BEGIN
    
    IF INSERTING
    THEN
        SELECT stock INTO cantidadActual FROM productos WHERE oid_pr = :NEW.oid_pr;
        UPDATE productos SET stock = (cantidadActual - :NEW.cantidad) 
        WHERE oid_pr = :NEW.oid_pr;
    END IF;
    
    IF DELETING
    THEN
        SELECT stock INTO cantidadActual FROM productos WHERE oid_pr = :OLD.oid_pr;
        UPDATE productos SET stock = (cantidadActual + :OLD.cantidad) 
        WHERE oid_pr = :OLD.oid_pr;
    END IF;
    IF UPDATING
    THEN
        SELECT stock INTO cantidadActual FROM productos WHERE oid_pr = :NEW.oid_pr;
        UPDATE productos SET stock = (cantidadActual + :OLD.cantidad
        - :NEW.cantidad) WHERE oid_pr = :NEW.oid_pr;    
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_stock_disponible
BEFORE
INSERT
ON lineasDePedido
FOR EACH ROW
DECLARE
    f_stock productos.stock%type;
BEGIN
    SELECT stock INTO f_stock FROM productos WHERE oid_pr = :NEW.oid_pr;
    IF f_stock = 0 OR :NEW.cantidad > f_stock
    THEN
        raise_application_error(-20603, 'No hay artículos disponibles de este producto.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER generar_factura_automatica
AFTER
UPDATE
ON cobros
FOR EACH ROW 
DECLARE
    counter SMALLINT;
    pedido cobrosPedidos.oid_pe%type;
BEGIN
    SELECT COUNT(*) INTO counter FROM cobrosPedidos WHERE OID_COB = :NEW.OID_COB;
    IF :NEW.estado = 'REALIZADO' AND counter>0
    THEN
        SELECT OID_PE INTO pedido FROM cobrosPedidos WHERE oid_cob = :NEW.OID_COB;
        insertar_factura(pedido);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER paga_envio
BEFORE
INSERT
ON  envios
FOR EACH ROW
DECLARE
    importePedido pedidos.importeTotal%type;
    counter INTEGER;
BEGIN
    SELECT count(*) INTO counter FROM envios WHERE :NEW.oid_ENV = oid_ENV;
    IF counter > 0 AND importePedido > 350
    THEN
        :NEW.paga := 'EMPRESA';
    ELSE
        :NEW.paga := 'CLIENTE';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER crear_pago_envio
AFTER
INSERT
ON envios
FOR EACH ROW
BEGIN
    insertar_cobro_envio(:NEW.importe,:NEW.oid_pe);
END;
/

CREATE OR REPLACE TRIGGER cambiar_estado_enviado
AFTER
INSERT
ON  envios
FOR EACH ROW
BEGIN
    UPDATE pedidos SET estado = 'ENVIADO' WHERE oid_p = :NEW.OID_PE; 
END;
/

CREATE OR REPLACE TRIGGER crear_cobro_pres
AFTER
UPDATE
OF estado ON presupuestos
FOR EACH ROW
BEGIN
    
    IF :NEW.estado = 'ACEPTADO'
    THEN
        insertar_cobro_presupuesto(:NEW.importe, :NEW.oid_pre);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_plazas_disponibles
BEFORE
INSERT
ON inscripciones
FOR EACH ROW
DECLARE
    f_plazas INTEGER;
    f_asistentes INTEGER;
    f_fechaSem DATE;
BEGIN
    SELECT plazas, asistentes, fecha INTO f_plazas,f_asistentes, f_fechasem 
        FROM seminarios where oid_sem = :NEW.OID_SEM;
    IF f_plazas - f_asistentes = 0
    THEN
        raise_application_error(-2600, 'No hay plazas disponibles para este seminario.');
    END IF;
    IF :NEW.fechaIns >= f_fechaSem
    THEN
        raise_application_error(-2600, 'Este semniario ya se ha tenido lugar.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER crear_cobro_inscripcion
AFTER
INSERT
ON inscripciones
FOR EACH ROW
DECLARE
    seminario seminarios%rowtype;
BEGIN
    SELECT * INTO seminario FROM seminarios 
        WHERE :NEW.OID_SEM = OID_SEM;
    IF seminario.precio <> NULL AND seminario.precio > 0
    THEN
        insertar_cobro_inscripcion(seminario.precio, :NEW.oid_sem);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_disponiblidad_alquiler
BEFORE 
INSERT
ON alquileres
FOR EACH ROW
DECLARE
counter1 INTEGER;
counter2 INTEGER;
counter3 INTEGER;
BEGIN
    SELECT count(*) INTO counter1 FROM alquileres WHERE oid_fot = :NEW.OID_FOT
    AND :NEW.salida >= salida AND :NEW.salida <= devPrev;
    
    SELECT count(*) INTO counter2 FROM alquileres WHERE oid_fot = :NEW.OID_FOT
    AND :NEW.devPrev >= salida AND :NEW.devPrev <= devPrev;
    
    SELECT count(*) INTO counter3 FROM alquileres WHERE oid_fot = :NEW.OID_FOT
    AND :NEW.devPrev <= salida AND :NEW.devPrev >= devPrev;
    
    IF counter1 <> 0 OR counter2 <> 0 OR counter3 <> 0 
    THEN
        raise_application_error(-20600, 'Fechas no disponibles para el alquiler 
        del fotomatón ' || :NEW.OID_FOT);
    END IF;
    
END;
/


CREATE OR REPLACE TRIGGER crear_cobro_alquiler
AFTER 
INSERT
ON alquileres
FOR EACH ROW
DECLARE
    dias INTEGER;
    importeDiario CONSTANT NUMBER(9,2) := 75.00;
BEGIN
    dias := :NEW.devPrev - :NEW.salida;
    IF dias < 4
    THEN 
        raise_application_error(-20600, 'La duración mínima del alquiler son 4 días');
    ELSE
        insertar_cobro_alquiler(importeDiario * dias, :NEW.oid_alq);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER crear_recargo_alquiler
AFTER
UPDATE
OF devEfectiva ON alquileres
FOR EACH ROW
DECLARE
    dias INTEGER;
    importeDiario CONSTANT NUMBER(9,2) := 100.00;
BEGIN
    dias:= :NEW.devEfectiva - :NEW.devPrev;
    IF dias > 0
    THEN
        insertar_cobro_alquiler(importeDiario * dias, :NEW.oid_alq);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_empleado_presupuesto
BEFORE
INSERT 
ON presupuestos
FOR EACH ROW
DECLARE
    empleado empleados%rowtype;
BEGIN
    SELECT * INTO empleado FROM empleados WHERE oid_p = :NEW.oid_p;
    IF NOT (empleado.tipoEmpleado = 'SERVICIOTECNICO')
    THEN
         raise_application_error(-20600, 'El empleado debe trabajar en el Servicio Técnico');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_empleado_reparacion
BEFORE
INSERT 
ON reparaciones
FOR EACH ROW
DECLARE
    empleado empleados%rowtype;
BEGIN
    SELECT * INTO empleado FROM empleados WHERE oid_p = :NEW.oid_p;
    IF NOT (empleado.tipoEmpleado = 'SERVICIOTECNICO')
    THEN
         raise_application_error(-20600, 'El empleado debe trabajar en el Servicio Técnico');
    END IF;
END;
/
