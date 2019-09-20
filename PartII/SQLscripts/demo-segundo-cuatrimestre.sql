--inserción de COMUNIDADES, PROVINCIAS Y MUNICIPIOS
CALL insertar_comunidad('ANDALUCIA');
CALL insertar_comunidad('COMUNIDAD-DE-MADRID');

CALL insertar_provincia('SEVILLA', 1);
CALL insertar_provincia('MALAGA', 1);
CALL insertar_provincia('JAEN', 1);
CALL insertar_provincia('MADRID', 2);

CALL insertar_municipio('CAMAS', 1);
CALL insertar_municipio('MARBELLA', 2);
CALL insertar_municipio('ANDUJAR', 3);
CALL insertar_municipio('MADRID', 4);
CALL insertar_municipio('ALCALÁ-DE-HENARES', 4);

--inserción de PRODUCTOS
--CALL insertar_producto('TINTA CANON BCI-1421 AMARILLA', 'CONSUMIBLES', 129.99, 'BCI-1421Y', 100.00, 100, 1);
CALL insertar_producto('CÁMARA CANON D40', 'CÁMARAS', 399.99, '83R3JKNQF8', 300.00, 100, 1);
CALL insertar_producto('TINTA CANON CYAN', 'CONSUMIBLES', 129.99, 'CLI-521M', 100.00, 100, 1);
CALL insertar_producto('TINTA CANON BCI-1421 AMARILLA', 'CONSUMIBLES', 129.99, 'BCI-1421Y', 100.00, 100, 1);
CALL insertar_producto('TINTA EPSON 40404040', 'CONSUMIBLES', 12.99, '40404040', 10.00, 100, 1);
CALL insertar_producto('PAPEL CANON 348EQF934', 'PAPELES', 12.99, '348EQF934', 10.00, 100, 1);
CALL insertar_producto('FOTOMATON DISMAFOTO', 'OTROS', 1349.90, '20180206', 700.00, 100, 1);
CALL insertar_producto('IMPRESORA EPSON', 'IMPRESORAS', 400.90, 'RZ001A', 200.00, 100, 1);


select * from empleados natural join personas;

--insertar empleado

CALL insertar_empleado('nombre', 'apellidos', '954010203', 'empleado1@empleado.com', 'empleado', 'password', '12345678901234',
                                '20/04/2001', null, 1200.01, 'ALMACEN', 'domicilio');
                                
--insertar CLIENTE PROFESIONAL
CALL insertar_cliente_profesional('Cliente1','Infante', '95467631', 'email1@us.es', 'usuario1', 'contraseña', '12344321K', 1);

select * from documentosiae;

