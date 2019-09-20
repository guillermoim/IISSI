<?php
	session_start();

	include_once('gestion_BD.php');
	include_once('gestionUsuariosBD.php');

	if(isset($_SESSION['form_cliente'])){
		$usuario = $_SESSION['form_cliente'];
		unset($_SESSION['form_cliente']);
		unset($_SESSION['errores']);
	}else{
		header("Location: form_clientes.php");
	}

	$con = crearConexionBD();
	$result = "";

	if($usuario['tipoCliente'] == 'EMPRESA')
		$result = insertar_cliente_empresa($con, $usuario);
	else
		$result = insertar_cliente_profesional($con, $usuario);

	cerrarConexionBD($con);

	$titulo = 'Exito cliente';
?>
<?php include_once('header.php'); ?>

<h1>¡Has sido dado de alta correctamente!</h1>
<p>Por favor, pulse <a href="login.php">aquí</a> para iniciar sesión.</p>



<?php include_once('footer.php'); ?>
