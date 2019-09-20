<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión
     * #	de clientes de la capa de acceso a datos
     * #==========================================================#
     */

 function insertar_cliente_empresa($conexion,$usuario) {

	// LLamar a procedimiento de la BD que inserta
	// cliente de tipo en empresa en la BD

	try{
		$consulta = 'CALL INSERTAR_CLIENTE_EMPRESA(:nombre, :apellidos, :telefono, :email,
						:usuario, :contrasena, :nif, :empresa, :oid_mun)';
		$stmt = $conexion->prepare($consulta);

		$stmt->bindParam(':nombre',$usuario["nombre"]);
		$stmt->bindParam(':apellidos',$usuario["apellidos"]);
		$stmt->bindParam(':telefono',$usuario["telefono"]);
		$stmt->bindParam(':email', $usuario["email"]);
		$stmt->bindParam(':usuario',$usuario["usuario"]);
		$stmt->bindParam(':contrasena',$usuario["pass"]);
		$stmt->bindParam(':empresa',$usuario["empresa"]);
		$stmt->bindParam(':nif',$usuario["nif"]);
		$stmt->bindParam(':oid_mun', $oid_mun);
		$stmt->execute();

		return true;

	}catch(PDOException $e){
		//Capturar la excepción y redirigir a vista de excepción
		$_SESSION['excepcion'] = $e->GetMessage();
		//echo "error de la conexión" . $e->GetMessage();
		header("Location: excepcion.php");

	}

}

function insertar_cliente_profesional($conexion,$usuario) {
	// LLamar a procedimiento de la BD que inserta
	// cliente de tipo profesional en la BD

	try{
		$consulta = 'CALL INSERTAR_CLIENTE_PROFESIONAL(:nombre, :apellidos, :telefono, :email,
						:usuario, :contrasena, :nif, :oid_mun)';
		$stmt = $conexion->prepare($consulta);
		
		$stmt->bindParam(':nombre',$usuario['nombre']);
		$stmt->bindParam(':apellidos',$usuario["apellidos"]);
		$stmt->bindParam(':telefono',$usuario["telefono"]);
		$stmt->bindParam(':email', $usuario["email"]);
		$stmt->bindParam(':usuario',$usuario["usuario"]);
		$stmt->bindParam(':contrasena',$usuario["pass"]);
		$stmt->bindParam(':nif',$usuario["nif"]);
		$stmt->bindParam(':oid_mun', $oid_mun);
		$stmt->execute();

		return true;

	}catch(PDOException $e){
		$_SESSION['excepcion'] = $e->GetMessage();
		//Capturar la excepción y redirigir a vista de excepción
		header("Location: excepcion.php");
	}

}



// Esta función sirve para el inicio de sesión,
//sirve para ~contar número de usuarios que hay con el email/nombre de usuario igual al que se pasa
//como parametro
function consultarUsuario($conexion,$dato,$pass) {
	// 		SENTENCIA SELECT PARA CONTAR CUANTOS USUARIOS HAY
	// 		CON DICHO EMAIL Y PASS

	$consulta = 'SELECT COUNT(*) AS TOTAL FROM PERSONAS NATURAL JOIN CLIENTES WHERE (:dato = email OR :dato = usuario)
					AND :pass = contrasena';
	// UTILIZA EL MÉTODO "PREPARE" DEL OBJETO PDO
	$stmt = $conexion->prepare($consulta);
	$stmt->bindParam(':dato', $dato);
	$stmt->bindParam(':pass', $pass);
	$stmt->execute();
	// RETORNE EL RESULTADO DEL MÉTODO "FETCHCOLUMN"
	return $stmt->fetch()['TOTAL'];

}

//Función que dado un mail o un nombre de un usuario devuelva el mail
function obtener_mail($conn, $dato){
	$query = 'SELECT email FROM PERSONAS WHERE (:dato = email OR :dato = usuario)';
	$stmt = $conn->prepare($query);
	$stmt->bindParam(':dato', $dato);
	$stmt->execute();
	$aux= $stmt->fetch();
	$email = $aux['EMAIL'];
	return $email;
}

//Función que dado un email o un nombre de usuario devuelva un oid_p de cliente;
function obtener_oid($conn, $dato){
	$query1 = 'SELECT OID_P FROM PERSONAS WHERE (:dato = email OR :dato = usuario)';
	$stmt1 = $conn->prepare($query1);
	$stmt1->bindParam(':dato', $dato);
	$stmt1->execute();
	$aux1= $stmt1->fetch();
	$oid_p = $aux1['OID_P'];
	return $oid_p;
}

//Funcion que dado un oid_p devuelve el tipo de cliente
function obtener_tipoCliente($conn, $oid_p){
	$query = 'SELECT tipoCliente AS TIPO FROM CLIENTES WHERE (:oid_p = oid_p)';
	$stmt = $conn->prepare($query);
	$stmt->bindParam(':oid_p', $oid_p);
	$stmt->execute();
	$aux = $stmt->fetch();
	$tipoCliente = $aux['TIPO'];
	return $tipoCliente;
}

//Esta función sirve para consultar el estado IAE
//Si el usuario es un cliente profesional
function obtener_estado_IAE($conn, $oid_p){
	$query = 'SELECT estado FROM documentosIAE WHERE (:oid_p = oid_p)';
	$stmt = $conn->prepare($query);
	$stmt->bindParam(':oid_p', $oid_p);
	$stmt->execute();
	$aux = $stmt->fetch();
	$estado = $aux['ESTADO'];

	return $estado;

}

//TODO: Hacer una funcion-validación de un nombre de usuario, email, etc.
