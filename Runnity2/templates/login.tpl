{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister" style="text-align: center">
		<p>Hey!, tienes que hacer login para acceder a esta página</p>
	</div>

	<div class="span-24 column content">
		<div class="content404">
			<form action="login.php" method="POST">
				<div class="span-1 loginContainer">
					<div class="loginContainerData">
						<div class="span-1 loginSpaceFirst">
						<p>Nombre de usuario / email</p>
						<input type="text" name="username" class="inputLoginPage">
						<p>Contraseña</p>
						<input type="password" name="password" class="inputLoginPage">
						<input type="hidden" name="url" value="{$url}" />
						<input class="buttonNoLogin" type="submit" name="action" value="Entrar" />
						</div>
						<div class="span-1 loginSpace">
						<p class="loginRegisterLink">¿Aún no estás registrado?</p>
						<a class="loginRegisterLink" href="/registro">Regístrate aquí</a>
						</div>

					</div>
				</div>
			</form>
		</div>
	</div>
</div>

{include file="footer.tpl"} 