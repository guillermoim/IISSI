<?php 

	session_start();

	if(isset($_SESSION['form_cliente'])) {
		$nuevoUsuario['nombre'] = $_REQUEST['nombre'];
		$nuevoUsuario['apellidos'] = $_REQUEST['apellidos'];
		$nuevoUsuario['telefono'] = $_REQUEST['telefono'];
		$nuevoUsuario['email'] = $_REQUEST['email'];
		$nuevoUsuario['usuario'] = $_REQUEST['usuario'];
		$nuevoUsuario['pass'] = $_REQUEST['pass'];
		$nuevoUsuario['confirmpass'] = $_REQUEST['confirmpass'];
		$nuevoUsuario['tipoCliente'] = $_REQUEST['tipoCliente'];
		$nuevoUsuario['empresa'] = $_REQUEST['empresa'];
		$nuevoUsuario['nif'] = $_REQUEST['nif'];
		//$nuevoUsuario['municipio']  = $_REQUEST['municipio'];
	}else{
		Header("Location: form_clientes.php");
	}

	$_SESSION['form_cliente'] = $nuevoUsuario;

	$errores = validarCliente($nuevoUsuario);
	
	if(count($errores) > 0){
		$_SESSION['errores'] = $errores;
		Header("Location: form_clientes.php");
	}else
		Header("Location: exito_cliente.php");



	function validarCliente($nuevoUsuario){
		//Validación del nombre no vacío
		if($nuevoUsuario['nombre'] == "" )
			$errores[] = "<p>El nombre no puede estar vacío</p>";
		//Validación de los apellidos no vacíos
		if($nuevoUsuario['apellidos'] == "")
			$errores[] = "<p>Los apellidos no pueden estar vacío</p>";

		//Validacion del telefono
		if($nuevoUsuario['telefono'] == "")
			$errores[] = "<p>El teléfono no puede estar vacío</p>";
		else if(!preg_match("/^[0-9]*$/", $nuevoUsuario['telefono'])){
			$errores[] = "<p>El teléfono debe estar formado por dígitos</p>";
		}

		//Validación del email *******
		if($nuevoUsuario['email']== ""){ 
			$errores[] = "<p>El email no puede estar vacío</p>";
		}else if(!filter_var($nuevoUsuario["email"], FILTER_VALIDATE_EMAIL)){
			$errores[] = "<p>El email es incorrecto: ".$nuevoUsuario["email"].".</p>";
		}

		//Validación del usuario ******
		if($nuevoUsuario['usuario'] == "")
			$errores[] = "<p>El usuario no puede estar vacío.</p>";

		//Validación de la contraseña
		if(!isset($nuevoUsuario["pass"]) || strlen($nuevoUsuario["pass"])>16){
			$errores [] = "<p>Contraseña no válida: debe tener como máximo 16 caracteres.</p>";
		}else if(!preg_match("/[a-z]+/", $nuevoUsuario["pass"]) || 
			!preg_match("/[A-Z]+/", $nuevoUsuario["pass"]) || !preg_match("/[0-9]+/", $nuevoUsuario["pass"])){
			$errores[] = "<p>Contraseña no válida: debe contener letras mayúsculas y minúsculas y dígitos.</p>";
		}else if($nuevoUsuario["pass"] != $nuevoUsuario["confirmpass"]){
			$errores[] = "<p>La confirmación de contraseña no coincide con la contraseña.</p>";
		}

		//Validación del tipoCliente
		if($nuevoUsuario['tipoCliente'] != 'EMPRESA' && $nuevoUsuario['tipoCliente'] != 'PROFESIONAL')
			$errores[] = "<p>El tipo cliente debe ser EMPRESA o PROFESIONAL.</p>";
		
		//Validación de la empresa
		if($nuevoUsuario['tipoCliente'] == 'EMPRESA' && $nuevoUsuario['empresa'] == "")
			$errores[] = "<p>El tipo cliente es EMPRESA, el campo de empresa no puede estar vacío.</p>";

		//Validación del NIF
		if($nuevoUsuario['tipoCliente'] == 'EMPRESA' && !preg_match("/[0-9]{7}[A-Z]/", $nuevoUsuario["nif"]))
			$errores[] = "<p>El NIF debe ser acorde al formato de las empresas.</p>";

		if($nuevoUsuario['tipoCliente'] == 'PROFESIONAL' && !preg_match("/[0-9]{8}[A-Z]/", $nuevoUsuario["nif"]))
			$errores[] = "<p>El NIF debe ser acorde al DNI.</p>";


		//Validación del documento IAE
		if($nuevoUsuario['tipoCliente'] == 'PROFESIONAL' && (!isset($_FILES['docIAE']) || 
						($_FILES['docIAE']['error'] != UPLOAD_ERR_OK))) {
			$errores[] = "<p>Se debe aportar documento IAE.</p>";
		}else{
			if(substr($_FILES['docIAE']['name'], -3) != 'pdf')
				$errores[] = "<p>El documento IAE debe estar en formato PDF.</p>";
			else{
				$nuevaRuta = $_SERVER['DOCUMENT_ROOT']."/dismafoto/files/".$nuevoUsuario['nif'].'.pdf';
				if(!move_uploaded_file($_FILES['docIAE']['tmp_name'], $nuevaRuta))
					$errores[] = "<p>Error al mover el archivo.</p>";
			}
		}

		//Validación del municipio
		return $errores;
	}

	



?>