<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>{$titulo_pagina}</title>
	
	<link rel="shortcut icon" href="../img/favicon.ico"/>

	<link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print">
	<link rel="stylesheet" type="text/css" href="/css/menu.css">	
	<link rel="stylesheet" type="text/css" href="/css/floating.css">	
	<link rel="stylesheet" type="text/css" href="/css/contact.css">	
	<link rel="stylesheet" href="/css/layout.css" type="text/css" media="screen, projection">
	<link rel="alternate" type="application/rss+xml" title="Próximas carreras en runnity.com RSS feed" href="http://www.runnity.com/rss.php" />
	
	<!-- Import JS source files -->
	<script src='/js/jquery-1.3.2.min.js' type='text/javascript'></script>
	<script src='/js/jquery.simplemodal.js' type='text/javascript'></script>
	<script src='/js/autoresize.jquery.min.js' type='text/javascript'></script>	
	
	<!-- Contact Form JS and CSS files -->
	<script src='/js/init.js' type='text/javascript'></script>
	<link type='text/css' href='/css/login.css' rel='stylesheet' media='screen'>
	<link type='text/css' href='/css/register.css' rel='stylesheet' media='screen'>
	

	<link type='text/css' href='/css/botones.css' rel='stylesheet' media='screen'>
	<script src="/js/corner.js" type="text/javascript"></script>
	
	<link type="text/css" href="/css/jquery-ui.css" rel="Stylesheet" />	
	<script type="text/javascript" src="/js/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/ui_demos.js"></script>

	
	{literal}
	<script type="text/javascript">
	$(function(){
		//all hover and click logic for buttons
		$(".fg-button:not(.ui-state-disabled)")
		.hover(
			function(){ 
				$(this).addClass("ui-state-hover"); 
			},
			function(){ 
				$(this).removeClass("ui-state-hover"); 
			}
		)
		.mousedown(function(){
				$(this).parents('.fg-buttonset-single:first').find(".fg-button.ui-state-active").removeClass("ui-state-active");
				if( $(this).is('.ui-state-active.fg-button-toggleable, .fg-buttonset-multi .ui-state-active') ){ $(this).removeClass("ui-state-active"); }
				else { $(this).addClass("ui-state-active"); }	
		})
		.mouseup(function(){
			if(! $(this).is('.fg-button-toggleable, .fg-buttonset-single .fg-button,  .fg-buttonset-multi .fg-button') ){
				$(this).removeClass("ui-state-active");
			}
		});
	});
	</script>

	{/literal}
	
	<script type="text/javascript" src="js/DD_roundies.uicornerfix.js"></script>
	
	{literal}
	<script type="text/javascript">
		$.uicornerfix('6px');
	</script>
	{/literal}


</head>

<body>

<div class="container">

	<!-- LOGIN WINDOW -->
	<div id="loginWindow" style='display:none'>
		<div class="column span-5 first loginColumn">
			<h2 id="loginTitle" class="loginTitle">Accede a tu cuenta</h2>
			<div id="loginForm" class="loginForm">
			<form id="FormularioLogin" method="GET">
				<div>
					<div class="inputTitle">e-mail</div>
					<div class="inputBlue">
						<label class="roundblue" for="login1"><span><input type="text" name="login1" id="emailLogin"/></span></label>
					</div>
				</div>
				<div id="passForm">
					<div class="inputTitle">contraseña</div>
					<div class="inputBlue">
						<label class="roundblue" for="login2"><span><input type="password" name="login2" id="passwordLogin"/></span></label>
					</div>
				</div>
				<div class="forgetFind">
					<div class="forgetPass"><a id="forgetLink" href="javascript: void sendPassword()">¿olvidaste tu contraseña?</a></div>
					<div class="loginButton"><input id="submitLogin" class="fg-button ui-state-default ui-corner-all" type="submit" value="Entrar" onclick="javascript: void login()"/></div>	
				</div>	
				<div class="first">
					<img id="checking" class="column first registerImage" src="../img/ajax-loader.gif" style="display:none">
					<div class="column last errorMessage" id="error_msg"></div>
				</div>
			</form>
			</div>
		</div>
		
		<div id="separatorLogin" class="column span-1 separator">
			<img src="/img/separator.jpg" alt="separator">
		</div>
		
		<div id="registerLogin" class="column span-5 last registerLogin">
			<h3>¿Aún no estas registrado?</h3>
			<div class="registerText">Regístrate ahora y disfruta de todas las ventajas de runnit! Es grátis y tardarás un par de minutos.</div>
			<div class="registroLoginButton"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Crea tu cuenta" onclick="javascript: void $.modal.close();showRegisterBox()"/></div>
		</div>
	</div>
	
	<!-- REGISTER -->
	<div id="registerWindow" style='display:none'>
		<h2 id="registerTitle" class="registerTitle">Crea tu cuenta en runnit!</h2>
		<div id="registerForm">
		<form id="FormularioRegister" method="GET">
			<div class="column first registerLeft">
				<div class="margin10">
					<div class="inputTitle">nombre de usuario</div>
					<div class="inputBlue">
						<label class="roundblue" for="register1"><span><input type="text" name="popup_register1" id="popup_register1" onchange="checkUsername()"/></span></label>
					</div>
				</div>
				<div class="margin10">
					<div class="inputTitle">nombre y apellidos</div>
					<div class="inputBlue">
						<label class="roundblue" for="register2"><span><input type="text" name="popup_register2" id="popup_register2"  /></span></label>
					</div>
				</div>
				<div class="margin10">
					<div class="inputTitle">contraseña</div>
					<div class="inputBlue">
						<label class="roundblue" for="register3"><span><input type="password" name="popup_register3" id="popup_register3" /></span></label>
					</div>
				</div>
				<div class="margin10">
					<div class="inputTitle">email</div>
					<div class="inputBlue">
						<label class="roundblue" for="register4"><span><input type="text" name="popup_register4" id="popup_register4" /></span></label>
					</div>
				</div>
				<div class="margin10 rightButton"><input class="fg-button ui-state-default ui-corner-all" type="submit" onclick="javascript: void registerUser()" value="Crear mi cuenta"/></div>
			</div>
		</form>
			<div class="column last registerRight">
				<div class="usernameCheck">
					<img style='display:none' id="registerImage" class="column registerImage first">
					<div id="answer" class="column answerStyle last"></div>
					<div id="result" class="resultRegister"></div>
				</div>	
				<div id="alert1" class="divalert1"><p>Así te conocerán los demás usuarios</p></div>
				<div id="alert2" class="divalert2"><p>5 o más caracteres</p></div>
				<div id="alert3" class="divalert3"><p>Para recibir alertas y notificaciones</p></div>
				<div id="registerError" class="registerError"></div>
			</div>
		</div>
		<div id="conditions" class="column conditions phraseGray MarginTopPlus">
			Hacer click en “Crear mi cuenta” implica haber aceptado los <a href="" class="terms">términos y condiciones del servicio.</a>	
		</div>
	</div>
	
	<!-- CONTACT -->
	<div id="contactWindow" style='display:none'>
		<h2 class="registerTitle">Sugerencias, dudas... escríbenos!</h2>
		<div>
			<div class="margin10 contactArea">
				<div class="inputTitle">Nombre</div>
				<div class="inputBlue">
					<label class="roundblue" for="register1"><span><input type="text" name="register1" id="contact1"/></span></label>
				</div>
			</div>
			<div class="margin10 contactArea">
				<div class="inputTitle">Email</div>
				<div class="inputBlue">
					<label class="roundblue" for="register2"><span><input type="text" name="register2" id="contact2"/></span></label>
				</div>
			</div>
			<div class="margin10 contactArea">
				<div class="inputTitle">Mensaje</div>
				<textarea name="textarea1" id="message" rows="3" cols="60" class="contactTextArea"></textarea>
			</div>
			
			<div class="margin10 contactArea">
				<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Enviar mensaje"/>
			</div>

		</div>			
	</div>
	
	<!-- LOGOUT WINDOW -->
	<div id="logoutWindow" style='display:none'>
		<h2 class="registerTitle">¿Quieres salir de Runnity?</h2>
		<div>
			<div class="column span-4 first logoutButton"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Si, seguro" onclick="logout()"/></div>
			<div class="column span-1 last"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="No, voy a seguir" onclick="$.modal.close();"/></div>
		</div>
	</div>
	
	<!-- HEADER -->
	<div class="span-24 header">
		<div class="span-6 loginImage">
			{if $smarty.session}
				<div id="loginBox" class="loginRun">
					<a class="blackLogin" href="./usuario.php">{$smarty.session.user.username}</a> | <a id="logoutRef" class="hrefText" href="javascript: void alertLogout()">Salir</a>
				</div>
			{else}
				<div id="loginBox" class="accessLogin">
					<a href="javascript: void showLoginBox()" class="hrefText">accede a tu cuenta</a>
					<a class="normalText"> ó </a>
					<a href="javascript: void showRegisterBox()" class="hrefText">registrate</a>
				</div>
			{/if}
		</div>
 
 		<a href="index.php"><div class="span-6 first headerImage"></div></a>
		<div class="span-18 last">
			<div class="searchCont">
				<div class="searchC">
					<form id="searchForm" action="searchresults.php" method="get">
						<div class="buttonSearch">
							<label class="roundsearch" for="inputsearch"><span><input type="text" id="inputsearch" name="q"></span></label>
						</div>
						<div class="buttonSearch"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Buscar"/></div>
					</form>
				</div>
			</div>
			<div class="span-18 last horizontalcssmenu">
			<ul id="cssmenu1">
				<li><a {if $section eq "home"} class="current"{/if} href="index.php">HOME</a> <a class="separator">|</a> </li>
				<li><a {if $section eq "searchresults"} class="current"{/if} href="searchresults.php">BUSCAR</a> <a class="separator">|</a> </li>
				<li><a {if $section eq "about"} class="current"{/if} href="about.php">SOBRE NOSOTROS</a> <a class="separator">|</a> </li>
				<li><a {if $section eq "blog"} class="current"{/if} href="/blog">BLOG</a> <a class="separator">|</a> </li>
				<li><a {if $section eq "contacto"} class="current"{/if} href="javascript: void showContactBox()">CONTACTO</a> </li>
			</ul>
			</div>
		</div>
	</div>