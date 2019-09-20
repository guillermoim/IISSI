<?php
session_start();
$titulo = 'Mostrar carrito';
include_once('header.php') ?>

	<script>
		$(document).ready(function(){
				//Capturamos el evento provocado por pulsar en el boton de Eliminar producto
				$("td button[name='eliminar']").click(function(){

					//LLamada AJAX con JQuery, pasándole el valor del id y de la cantidad
					$.get("accion_carrito.php", {
						remove: true,
						id:$(this).parent().parent().find("td[name='id'] input").val()},
						//Funcion callback, se ejecutará en el retorno de la llamada AJAX
						function(data){
							$("div p").empty();
							$("div p").append(data);

						});

					$(this).parent().parent().remove();

				});

		});
	</script>

	<?php

		include_once('funciones_utilidades.php');

		if(!empty($_SESSION['carrito'])){
			$carrito = $_SESSION['carrito'];



	?>


	<table>
		<tr>
			<th>
				Artículo
			</th>
			<th>
				Cantidad
			</th>
			<th>
				Precio
			</th>
		</tr>

		<?php

		$count = (float)0.0;
		$total = number_format($count, 2, ',', '.');

		foreach ($carrito as $id => $item) {
			?>
		<tr>
		<?php
		?>
				<td name='id' value="<?=$id?>">
				<?php
					echo $id."\n";
					echo "<input type='hidden' value='".$id."'";
				?>
				</td>
				<td>
				<?php
					echo $item['cantidad']."\n";
				?>
				</td>
				<td>
					<?php
					echo $item['precio']."\n";
				?>
				</td>

				<td>
					<button name="eliminar">Eliminar</button>
				</td>

		</tr> <?php
				echo "\n" ;
			} ?>

	</table>

	<div>
		<p><?php echo "TOTAL: ".calcPrecioTotal($_SESSION['carrito'])." €"; ?></p>
	</div>

	<a href="accion_finalizar_pedido.php"><button>Tramitar pedido</button></a>

<?php

	}else{

		echo "<p> Su carrito está vacío.</p>";
		echo "Pulse <a href='productos.php'> aquí</a> para comprar.";
}
?>


</body>
</html>
