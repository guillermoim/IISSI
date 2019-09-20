<?php

function consultarEmpleado($conexion,$dato,$pass) {
	// 		SENTENCIA SELECT PARA CONTAR CUANTOS USUARIOS HAY
	// 		CON DICHO EMAIL Y PASS

	$consulta = 'SELECT COUNT(*) AS TOTAL FROM PERSONAS NATURAL JOIN EMPLEADOS
					WHERE :dato = usuario
					AND :pass = contrasena';
	// UTILIZA EL MÉTODO "PREPARE" DEL OBJETO PDO
	$stmt = $conexion->prepare($consulta);
	$stmt->bindParam(':dato', $dato);
	$stmt->bindParam(':pass', $pass);
	$stmt->execute();
	// RETORNE EL RESULTADO DEL MÉTODO "FETCHCOLUMN"
	return $stmt->fetch()['TOTAL'];

}

?>
