<?php /* Smarty version 2.6.26, created on 2009-09-04 17:24:19
         compiled from /Users/jatorre/workspace/runnit/templates/email_registro.tpl */ ?>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Aviso</title>
	<?php echo '
	<style type="text/css">
<!--
body {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #333333;
}

h1{
	margin-left: 20px;
	margin-top: 20px;
	font-family: "Arial";
	font-size: 19px;
	font-weight: bold;
	color: #336699;
}

.title{
	margin-left: 20px;
	margin-top: 30px;
	margin-bottom: 30px;
	font-family: "Arial";
	font-size: 14px;
	color: #666666;
}

.contacta{
	margin-top: 30px;
	margin-bottom: 30px;
	font-family: "Arial";
}

p{
	margin-left: 20px;
	font-family: "Arial";
	font-size: 12px;
	color: #666666;
	line-height: 0px;
}

a{
	color: #336699;
	font-weight: bold;
}

-->
	</style>
	'; ?>

</head>
<body>

<h1>Bienvenido a Runnity <?php echo $this->_tpl_vars['name']; ?>
</h1>

<p class="title">Estamos encantados de que formes partes de Runnity</p>

<p>Ya puedes inscribirte a las carreras y activar tu alerta de proximidad por email. Sólo tienes que ir a tu página de usuario <a href="">http://runnity.com/user/<?php echo $this->_tpl_vars['username']; ?>
?</a> y rellenar el formulario.</p>

<p>Además, como usuario de runnity.com serás el primero en enterarte de las novedades y las mejoras que vayamos haciendo y podrás compartir tus 
opiniones o experiencias en las carreras, con los demás usuarios.</p>

<p class="contacta">Si tienes alguna duda o sugerencia, no dudes en <a href="#">contactar con nosotros</a></p>

<p class="title">¡Suerte en tus próximas carreras!</p>


</body>
</html>