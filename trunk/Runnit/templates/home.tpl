{include file="header.tpl"} 

<script type="text/javascript" src="js/swfobject.js"></script>
{literal}
<script type="text/javascript">
swfobject.embedSWF("flash/runnitHomeMap.swf", "runnityHomeMap", "939", "364", "9.0.0", "flash/expressInstall.swf");
</script>
{/literal}


<!-- IMPORTANT RACE AND NEXT RACES -->
	<div class="span-24 raceContainer" id="race">
		<div class="span-24 title">
			<p class="titlePage"><b>Runnity</b> es un punto de encuentro entre <b><a href="carrera.php">carreras</a></b> y <b>atletas.</b></p>
			<p class="subtitlePage"><b>Utiliza el mapa, <a href="">busca</a>, o <a href="">regístrate</a> </b> para recibir alertas vía e-mail de las próximas carreras cerca de dónde vives</p>
		</div>
		<div class="span-24 map" id="runnityHomeMap">
			<h1>Necesitas Flash para poder ver el mapa</h1>
			<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>			
		</div>
	</div>	
	<!-- MORE RACES -->
	<div class="column first span-16 moreRaces">
		<div> 
			<div>
				<h2 class="column span-16 first newsTitle">
					<div class="first span-11">
						<div class="column first">Más carreras en Madrid, <a href="#" class="seeAll">ver todas.</a></div>
						<!--<div id="containerStates" class="column last">
							<form class="form" method="get" action="">
								<input type="text" disabled="" class="fauxselect s4 state" id="category" value="Madrid" name="category"/>
								<select id="select" class="s4 hidden" onchange="javascript:updateField('category',this);" name="cat">
									<option selected="selected" value="">Madrid</option>
									<option value="">Murcia</option>
									<option value="">Ciudad Real</option>
									<option value="">Valencia</option>
									<option value="">Barcelona</option>
									<option value="">Lerida</option>
									<option value="">Tarragona</option>
									<option value="">Gerona</option>
								</select>
							</form>
						</div>-->
					</div>
					<div class=" last span-5 feed">
						<div class="column fisrt span-4 feedText">suscríbete</div>
						<div class="column span-1 imgFeed last">
							<a href="#"><img src="/img/feed.jpg" alt="Feed"/></a>
						</div>
					</div>
				</h2>
			</div>		
		</div>
		{foreach key=id item=race from=$nextRaces}
			{if $race eq "false"}
				<div class="span-8 races">No hay proximas carreras.</div> 
			{else}
				{if }
				
				<div class="column span-8 first races">
					<div class="column first image">
						<img src="media/run/{$race.id}_small.jpg" alt="Foto de la carrera {$race.name}"/>	
					</div>
					<div class="column span-5 last">
						<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">{$race.name}</a></div>
						<div class="raceDateDetails">
							<div class="raceDetailsStyle"> <b>{$race.event_date}</b> | {$race.province_name} | {$race.event_location}</div>
							<p class="runnersNumber">{$race.num_users} van</p>
						</div>
					</div>
				</div>		
			{/if}
	    {foreachelse}
	        <div class="span-8 races">No hay proximas carreras.</div> 
	    {/foreach}			
		
	</div>
	
	
	<!-- USERS -->	
	<div class="column last span-8 moreRaces">
		<div> 
			<h2 class="newsTitle">Últimos valientes</h2>
		</div>
			{foreach key=id item=person from=$runners}
				{if $person eq "false"}
					<div class="span-8 races">No hay valientes.</div> 
				{else}
					<div class="span-8 races">
						<div class="column first image">
							<img src="img/user.jpg" alt="userImage"/>	
						</div>
						<div class="column span-5 last">
							<div class="detailsUser">
								<div class="nameUser"><a class="nameRace" href="#">{$person.username}</a></div>
								<div class="raceUserDetails"> dice que va a ir a </div>
								<div class="raceUserDetails"> <b>{$person.run_name}</b> </div>
							</div>
							<p class="runnersNumber">{$person.num_participants} van, <a href="">apúntate con él</a></p>
						</div>
					</div>
				{/if}
		    {foreachelse}
		        <div class="span-8 races">No hay valientes.</div>    
		    {/foreach}
		</div>
		
		
	<!-- PROMINENT -->
	<div class="span-24 prominent">
		
		<div class="column span-8 first">
			<div class="titleImportant">AL FÍN UN MODO DE VER CON DETALLE LOS RECORRIDOS DE LAS CARRERAS MEDIANTE GOOGLE MAPS</div>
			<div class="contentImportant">Además podrás comentar las distintas pruebas y conocer las opiniones de los demás.</div>
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Mira la carrera destacada" /></div>
		</div>
		
		
		<div class="column span-8">
			<div class="titleImportant">CREA Y COMPARTE TU PROPIO CALENDARIO DE CARRERAS. ES GRATIS, FÁCIL Y RÁPIDO</div>
			<div class="contentImportant">Así, podrás saber si van tus compañeros de rodaje, aquel que te pasó en el último sprint o el que siempre lo gana todo.</div>
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Regístrate ahora" onclick="showRegisterBox()"/></div>
		</div>
		
		<div class="column span-8 last">
			<div class="titleImportant">¿CONOCES ALGUNA CARRERA QUE NO ESTÁ EN RUNNY? ENTONCES DINOSLO!</div>
			<div class="contentImportant">Entre todos conseguiremos crear la mejor red de carreras nacionales y disfrutar aún más del mundo del running.</div>
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Ayúdanos con tu carrera" onclick="showContactBox()"/></div>
		</div>
	</div>

	<!-- SOCIAL LINKS -->
	<div class="span-24 socialLinks">	
		<div class="column span-16 first">
			<div> 
				<h2 class="newsTitle">Síguenos en...</h2>
			</div>
			<div class="column span-3 first">
				<a href="#">
					<img src="/img/tuenti.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3">
				<a href="#">
					<img src="/img/facebook.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-4 last">
				<a href="#">
					<img src="/img/twitter.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3 last">
				<a href="#">
					<img src="/img/flickr.jpg" alt="socialNetworks"/>
				</a>
			</div>
		</div>
		<div class="column span-8 last">
			<div> 
				<h2 class="newsTitle">Lo último en twitter</h2>
			</div>
			<div class="twitterContent">
				<div class="column span-2 first">
					<img id="profile">
				</div>
				<div class="column span-6 tweet last" id="tweets">					
				</div>
			</div>
		</div>
	</div>
	
</div>

{include file="footer.tpl"} 