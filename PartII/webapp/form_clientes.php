<?php
	session_start();

	if(isset($_SESSION['login']))
		header('Location: productos.php');

	include_once('gestion_BD.php');
	include_once('gestionar_direcciones.php');

	// Si no existen datos del formulario en la sesión, se crea una entrada con valores por defecto
	if (!isset($_SESSION['form_cliente'])) {
		$formulario['nombre'] = "";
		$formulario['apellidos'] = "";
		$formulario['telefono'] = "";
		$formulario['email'] =  "";
		$formulario['usuario'] = "";
		$formulario['pass'] = "";
		$formulario['confirmpass'] =  "";
		$formulario['tipoCliente'] = "";
		$formulario['empresa'] =  "";
		$formulario['nif'] =  "";

		$_SESSION['form_cliente'] = $formulario;
	}
	// Si ya existían valores, los cogemos para inicializar el formulario
	else
		$formulario = $_SESSION['form_cliente'];

	// Si hay errores de validación, hay que mostrarlos y marcar los campos (El estilo viene dado y ya se explicará)
	if (isset($_SESSION["errores"]))
		$errores = $_SESSION["errores"];
?>

<?php
	$titulo = 'Alta clientes';
	include_once("header.php");
?>

	<script src="js/funciones.js" language="javascript" type="text/javascript"></script>

	<script>
		$(document).ready(function(){
			//Capturamos el evento provocado por el cambio de valor del campo comunidad
			$("#comunidad").on("input",function(){
				//LLamada AJAX con JQuery, pasándole el valor de la provincia
				$.get("gestionar_direcciones.php", {comunidad: $("#comunidad").val()},
					//Funcion callback, se ejecutará en el retorno de la llamada AJAX
					function(data){
						//Borro los provincias que hubiera antes en el datalist
						$('#provincia').empty();
						//Adjunto la lista de provincias devuelta por la consulta AJAX
						$('#provincia').append(data);

					});
			});

			$("#provincia").on("input", function(){
				//LLamada AJAX con JQuery, pasándole el valor de la provincia
				$.get("gestionar_direcciones.php", {provincia: $("#provincia").val()},
					//Funcion callback, se ejecutará en el retorno de la llamada AJAX
					function(data){
						//Borro los provincias que hubiera antes en el datalist
						$('#municipio').empty();
						//Adjunto la lista de provincias devuelta por la consulta AJAX
						$('#municipio').append(data);

					});
			});

			$("#password").on("keyup", function() {

				passwordColor();
			});

		});

	</script>

	<h1>Formulario de alta de cliente</h1>
	<?php
		// Mostrar los erroes de validación (Si los hay)
		if (isset($errores) && count($errores)>0) {
	    	echo "<div id=\"div_errores\" class='errores' >";
			echo "<h4>Errores en el formulario:</h4>";
    		foreach($errores as $error) echo $error;
    		echo "</div>";
  		}
	?>

	<form action="accion_alta_cliente.php" method="POST" enctype="multipart/form-data"
	onsubmit="return validateForm();">
		<fieldset>
			<legend>Datos personales</legend>

			<!-- nombre -->
			<label for="nombre">Nombre:</label>
			<input type="text" name="nombre" required
				placeholder="Ej: Guillermo" minlength="5" maxlength="50"><br>

			<label for="apellidos">Apellidos:</label>
			<input type="apellidos" name="apellidos" required
				placeholder="Ej: Infante Molina" minlength="5" maxlength="50"><br>

			<label for="telefono">Telefono:</label>
			<input type="text" name="telefono" required
				placeholder="Ej: 954010203" minlength="9" maxlength="9"><br>

			<label for="email">Email:</label>
			<input type="email" name="email" required
				placeholder="Ej: correo@email.com"><br>

			<!-- <label for="notificaciones">¿Desea recibir notificaciones?:</label>
			<input type="checkbox" name="notificaciones"><br> -->

			<label for="usuario">Usuario:</label>
			<input type="text" name="usuario" required
				placeholder="Ej: usuario313"><br>

			<label for="pass">Contraseña:</label>
			<input oninput="passwordValidation();" type="password" name="pass"
				id="password" required placeholder="********">
			<label for="confirmpass">Confirmar contraseña:</label>
			<input oninput="passwordConfirmation();" type="password" name="confirmpass"
				id="confirmpass" required placeholder="********"><br>

		</fieldset>
		<fieldset>
			<legend>Datos de cliente</legend>
			<label for="tipoCliente">Tipo cliente:</label>
			EMPRESA: <input onchange="cambiarTipo()" type="radio" name="tipoCliente" value="EMPRESA" checked>
			PROFESIONAL: <input onchange="cambiarTipo();" type="radio" name="tipoCliente" value="PROFESIONAL"><br>

			<span id="empresa">
				<label for"empresa">Empresa: </label>
				<input type="text" name="empresa" placeholder="Ej: DISMAFOTO S.A."><br>
			</span>

			<label for="nif">NIF:</label>
			<input type="text" id="nif" name="nif" required placeholder="Ej: 2124346E"
			 pattern="^(\d{8}[A-Z])|^([A-Z]\d{8})"><br>

			<span id="iae" style="display: none;">
				<label for="docIAE">Documento acreditativo IAE (formato PDF):</label>
				<input type="file" name="docIAE"><br>
			</span>

			<label for="comunidad">Comunidad:</label>
			<select name="comunidad" id="comunidad" required>
				<option disabled selected value> -- select an option -- </option>
				<?php
					$con = crearConexionBD();
					$comunidades = get_comunidades($con);

					foreach ($comunidades as $comunidad) {
						?>
				<option value="<?=$comunidad['OID_COM']?>"><?=$comunidad['COMUNIDAD']?></option>
						<?php
					}
					cerrarConexionBD($con);
				?>


			</select><br>

			<label for="provincia">Provincia:</label>
			<select name="provincia" id="provincia" required>
			</select><br>

			<label for="municipio">Municipio:</label>
			<select name="municipio" id="municipio" required>
			</select><br>



		</fieldset>

		<input type="submit" name="submit">

	</form>

<?php include_once("footer.php") ?>
