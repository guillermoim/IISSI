<?php
	session_start();

	include_once('gestionUsuariosBD.php');
	include_once('gestion_BD.php');

	if(isset($_REQUEST["submit"])){
		$dato = $_REQUEST["dato"];
		$pass = $_REQUEST["pass"];
		$con = crearConexionBD();
		$numUsuarios = consultarUsuario($con, $dato, $pass);
		if ($numUsuarios > 0){
			$oid_p = obtener_oid($con, $dato);
			$tipoCliente = obtener_tipoCliente($con, $oid_p);
			if($tipoCliente != 'EMPRESA'){
				$estadoIAE = obtener_estado_IAE($con, $oid_p);
				if($estadoIAE == 'ACEPTADO'){
					$email = obtener_mail($con, $dato);
					$_SESSION['login'] = array('email' => $email, 'oid_p' => $oid_p);
					header('Location: productos.php');
				}else{
					$_SESSION['error_login'] = 'Su petición para darse de alta como
														cliente profesional aún no ha sido tramitada.';
					header('Location: login.php');
				}
			}else{
				$email = obtener_mail($con, $dato);
				$_SESSION['login'] = array('email' => $email, 'oid_p' => $oid_p);
				header('Location: productos.php');
			}
		}else{
			$_SESSION['error_login'] = 'Los datos que ha introducido no son correctos.';
			header('Location: login.php');
		}
		cerrarConexionBD($con, $dato, $pass);

	}else{
		header('Location: error_login.html');
	}

?>
