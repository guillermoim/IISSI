<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Dismafoto - <?php echo $titulo?></title>
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/funciones.js" language="javascript" type="text/javascript"></script>
</head>
<body>
	<header>
		<div class="columnas upper">
			<div class="col-8">
				<h1>Dismafoto</h1>
			</div>
			<div class="col-2">
				<?php
				 if(isset($_SESSION['login'])){?>
					<a href="logout.php">Salir</a>
				<?php
					}else{?>
					<a href="login.php">Entrar</a>
					<a href="form_clientes.php">Alta cliente</a>
				<?php
					} ?>
			</div>
		</div>

		<nav class="columnas">
			<a class="col-3" href="productos.php">INICIO</a>
			<a class="col-3" href="contacto.php">CONTACTO</a>
			<a class="col-3" href="who.php">¿QUIENES SOMOS?</a>
		</nav>
	</header>

	<div id="wrapper">
