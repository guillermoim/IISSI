<?php
	session_start();

	include_once('header.php');

?>


<p>

	<?php echo 'Lo sentimos se ha producido la siguiente excepcion'.$_SESSION['excepcion']; ?>
</p>

<?php include_once('footer.php'); ?>
