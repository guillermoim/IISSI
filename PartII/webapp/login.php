<?php

	session_start();
	$titulo = 'Login';
	include_once('header.php');
?>
	<div class="login">
		<?php
			if(isset($_SESSION['error_login'])){
				echo "<p class='error_login'>".$_SESSION['error_login']."</p>";
				unset($_SESSION['error_login']);
		} ?>
		<form action="accion_login.php">
			Email o nombre de usuario:<br> <input type="text" name="dato"><br>
			Contraseña:<br> <input type="password" name="pass" name="pass"><br>
			<input type="submit" name="submit" value="Aceptar"><br>
		</form>
	</div>
</body>
</html>
