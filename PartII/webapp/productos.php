<?php
session_start();
unset($_SESSION['errores']);
$titulo = 'Productos';
include_once("header.php"); ?>
	<script>
		$(document).ready(function(){

				//Capturamos el evento provocado por pulsar en el boton empty
				$("#empty").click(function(){

					//LLamada AJAX con JQuery, pasándole el valor de la provincia
					$.get("accion_carrito.php", {vaciar: $("#empty").val()},
						//Funcion callback, se ejecutará en el retorno de la llamada AJAX
						function(data){
						});
				});

				//Capturamos el evento provocado por pulsar en el boton de Añadir producto
				$("div button").click(function(){

					//LLamada AJAX con JQuery, pasándole el valor del id y de la cantidad
					$.get("accion_carrito.php", {
						id: $(this).parent().find("input[name='id']").val(),
						cantidad: $(this).parent().find("input[name='cantidad']").val(),
						precio: $(this).parent().find("input[name='precio']").val()},
						//Funcion callback, se ejecutará en el retorno de la llamada AJAX
						function(data){
						});
				});


		});

	</script>

<?php

	include_once('gestionProductosBD.php');
	include_once('gestion_BD.php');



	if(!isset($_SESSION['carrito']))
		$_SESSION['carrito'] = array();

	$conn = crearConexionBD();

	$page_num = isset($_GET["page_num"])?(int)$_GET["page_num"]:1;
	$page_size = isset($_GET["page_size"])?(int)$_GET["page_size"]:10;

	if($page_num<1) $page_num = 1;
	if($page_size<1) $page_size = 10;
	if(isset($_REQUEST['keyword'])){
		$keyword = $_REQUEST['keyword'];
		$total = total_productos_filtered($conn, $keyword);
	}else{
		$total = total_productos($conn);
	}
	$total_pages = ($total/$page_size);
	if($total % $page_size > 0) $total_pages++;
	if($page_num > $total_pages) $page_num = 1;

	if(isset($_REQUEST['keyword'])){
		$keyword = $_REQUEST['keyword'];
		unset($_REQUEST['keyword']);
		$productos = obtener_productos_filtered($conn, $page_num, $page_size, $keyword);
	}else{
		$productos = obtener_productos($conn, $page_num, $page_size);
	}

	?>


	<div class="columnas">
			<div class="col-3 tags">
				<br>
				<br>
				<br>
				<br>
				<h3>Filtros populares</h3>
				<br>
				<ul>
					<br>
					<li><a href="productos.php?keyword=CÁMARAS">Cámaras</a></li>
					<li><a href="productos.php?keyword=CONSUMIBLES">Consumibles</a></li>
					<li><a href="productos.php?keyword=IMPRESORAS">Impresoras</a></li>
					<li><a href="productos.php?keyword=ACCESORIOS">Accesorios</a></li>
					<li><a href="productos.php?keyword=SUBLIMACION">Sublimación</a></li>
					<li><a href="productos.php?keyword=PAPELES">Papeles</a></li>
					<li><a href="productos.php?keyword=OTROS">Otros</a></li>

				</ul>

			</div>

		<div class="col-7 carrito">

			<img src="images/cross.png" alt="cruz.png">
			<a href="#" id="empty" class="opt_carrito">Vaciar carrito</a>
			<!-- <button id="empty" type="submit" name="vaciar" value="vaciar">Vaciar Carrito</button> -->
			<img src="images/carrito.png" alt="carrito.png">
			<a href="mostrar_carrito.php" class="opt_carrito">Mostrar carrito</a>

		</div>
		<div class="col-7">
			<form action="productos.php" class="buscador">
				<span>Buscar: </span>
				<input type="text" name="keyword" placeholder="Introduce parámetro de búsqueda...">
				<button type="submit">Buscar</button>
			</form>
		</div>



		<div class="col-7 paginacion">

	<?php
	for($page = 1; $page <= $total_pages; $page++){
		if($page == $page_num){ // página actual
		?>

			<span class="current"> <?=$page?></span>

		<?php
		}else{ //resto de páginas
		?>
			<a href="productos.php?page_num=<?=$page?>&page_size=<?=$page_size?>" class=""> <?=$page?> </a>
		<?php  }
		}
	?>

		<form method="get" action="productos.php" >
			<input type="hidden" name="page_num" id="page_num" value="<?=$page_num?>"/>
			Mostrando
			<input type="number" name="page_size" id="page_size" min="1" max="<?=$total?>" value="<?=$page_size?>"
			autofocus="autofocus">
			entradas de <?=$total?>
			<input type="submit" value="Cambiar">
		</form>

		</div>

		<table id="tabla_productos" class="col-7">
			<!-- <tr>
				<th>Número Referencia </th>
				<th>Precio</th>
			</tr>
			-->
			<?php

				foreach ($productos as $item){
			 ?>
			 <tr>
			 	<td><img class="imgprod" src="images/<?=$item['NUMREFERENCIA']?>.jpg" alt="camara.jpeg"></td>
			 	<td class="proddesc" colspan="2" >
			 			Nombre: <?=$item['NOMBRE']?><br>
			 			Numero de referencia: <?=$item['NUMREFERENCIA']?> <br>
			 			Precio unitario: <?=$item['PRECIO']?> EUR <br>
			 	</td>
			 	<td>
			 	<div>
			 		<input type="hidden" name="id" value="<?=$item['OID_PR']?>"/>
			 		<input type="hidden" name="precio" value="<?=$item['PRECIO']?>"/>
					<input class="units" type="number" min="1" name="cantidad" value="1"/>
					<button name="enviar" value="añadir">Añadir</button>
			 	</div>
				</td>
			 </tr>
			 <?php } ?>
		</table>
	</div>


<?php include_once('footer.php') ?>
