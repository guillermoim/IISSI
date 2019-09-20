<?php
include_once('gestion_query_BD.php');


function obtener_productos_filtered($conn, $page_num, $page_size, $keyword){


	$query = "SELECT * FROM PRODUCTOS
							WHERE NOMBRE LIKE '%".$keyword."%'
							OR FAMILIA LIKE '%".$keyword."%'
							OR NUMREFERENCIA LIKE '%".$keyword."%'";

	$productos = paginatedQuery($conn, $query, $page_num, $page_size);
	return $productos;
}

function total_productos_filtered($conn, $keyword){
	$query = "SELECT * FROM PRODUCTOS
							WHERE NOMBRE LIKE '%".$keyword."%'
							OR FAMILIA LIKE '%".$keyword."%'
							OR NUMREFERENCIA LIKE '%".$keyword."%'";
	return totalQuery($conn, $query);
}


function obtener_productos($conn, $page_num, $page_size){
	$query = 'SELECT * FROM PRODUCTOS';
	$productos = paginatedQuery($conn, $query, $page_num, $page_size);
	return $productos;
}

function total_productos($conn){
	$query = 'SELECT * FROM PRODUCTOS';
	return totalQuery($conn, $query);
}

?>
