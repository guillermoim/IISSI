<?php 
	
	include_once('gestion_BD.php');

	if(isset($_GET['comunidad'])){
		//Consultar las provincias existentes dada una comunidd
		$con = crearConexionBD();
		$resultado = get_provincias($con, $_GET['comunidad']);
		if($resultado != NULL){
			//Para cada provincia del listado devuelto
			echo "<option disabled selected value> -- seleccionar una opción -- </option>";
			foreach ($resultado as $provincia) {
				//Creamos options con value = oid_pro y label = nombre de la provincia
				//Estas options irán en el datalist de provincias
				echo "<option value='".$provincia['OID_PRO']."'>".$provincia['PROVINCIA']."</option>";
			}
		}
		//Cerramos la conexión y borramos de la sesión la variable "comunidad"
		cerrarConexionBD($con);
		unset($_GET['provincia']);
	}

	if(isset($_GET['provincia'])){
		//Consultar los municipios existentes dada una provincia
		$con = crearConexionBD();
		$resultado = get_municipios($con, $_GET['provincia']);
		if($resultado != NULL){
			//Para cada provincia del listado devuelto
			echo "<option disabled selected value> -- seleccionar una opción -- </option>";
			foreach ($resultado as $municipio) {
				//Creamos options con value = oid_mun y label = nombre de la provincia
				//Estas options irán en el datalist de provincias
				echo "<option value='".$municipio['OID_MUN']."'>".$municipio['MUNICIPIO']."</option>";
			}
		}
		//Cerramos la conexión y borramos de la sesión la variable "comunidad"
		cerrarConexionBD($con);
		unset($_GET['provincia']);
	}

	function get_comunidades($conexion) {
		//Funcion que devuelve todas las comunidades en la BDD
		try{
			$consulta = 'SELECT * FROM comunidades';
			$result = $conexion->query($consulta);
			return $result;
		}catch(PDOException $e){
			//Capturar la excepción y redirigir a vista de excepción
			$_SESSION['excepcion'] = $e->GetMessage();
			//echo "error de la conexión" . $e->GetMessage();
			header("Location: excepcion.php");
		}
	}

	function get_provincias($conexion, $oid_com) {
		//Funcion que devuelve todas las provincias dado un oid_com
		try{
			$consulta = 'SELECT * FROM provincias where :oid_com = oid_com';
			$stmt = $conexion->prepare($consulta);
			$stmt->bindParam(':oid_com', $oid_com);
			$stmt->execute();
			return $stmt;
		}catch(PDOException $e){
			//Capturar la excepción y redirigir a vista de excepción
			$_SESSION['excepcion'] = $e->GetMessage();
			//echo "error de la conexión" . $e->GetMessage();
			header("Location: excepcion.php");
		}
	}

	function get_municipios($conexion, $oid_pro) {
		//Funcion que devuelve todos los municipios dado un oid_pro
		try{
			$consulta = 'SELECT * FROM municipios where :oid_pro = oid_pro';
			$stmt = $conexion->prepare($consulta);
			$stmt->bindParam(':oid_pro', $oid_pro);
			$stmt->execute();
			return $stmt;
		}catch(PDOException $e){
			//Capturar la excepción y redirigir a vista de excepción
			$_SESSION['excepcion'] = $e->GetMessage();
			//echo "error de la conexión" . $e->GetMessage();
			header("Location: excepcion.php");
		}
	}

 ?>