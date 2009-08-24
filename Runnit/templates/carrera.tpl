{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column raceTitle">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="calendario.php">Calendario ></a></li>
						<li><a href="carrera.php" class="selected">detalle de carrera</a></li>
					</ul>
				</div>
				
				<div class="span-16 first">
					<div class="span-1 first calendar">
						<div class="month monthRace">AGO</div>
						<div class="day dayRace">01</div>
					</div>
					<div class="span-14 last">
						<p class="raceTitle">{$data.name}</p>
						<p class="raceDetailsTitle">{$data.event_location} | {$data.distance_text} | <b>{$data.num_users} usuarios van</b>, <a href="" class="special">apúntate</a></p>
					</div>
				</div>
			</div>
			
			<img src="media/run/{$data.big_picture}" class="carrera">
			
			<div class="span-16 raceContent">
			
				<div class="span-6 first">
					<div class="span-6 boxrace last">
						<h3 class="blue">Datos técnicos</h3>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Distancia:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.distance_text},</b> <a href="#map2Container" class="special">ver mapa</a></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Categorias:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.category}</b></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Premios:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.awards}</b></p></div>
						</div>
					</div>
					<div class="span-6 boxrace last">
						<h3 class="blue">Inscripciones</h3>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Precio:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.inscription_price}</b></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Presencial:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.inscription_location}</b></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p class="textRace">E-mail:</p></div>
							<div class="span-4 last distanceInfo"><p><a href="" class="special">{$data.inscription_email}</a></p></div>
						</div>
						<div class="span-6 databox noborder">
							<div class="span-2 last distance"><p class="textRace">Web:</p></div>
							<div class="span-4 last distanceInfo"><p><a href="" class="special">{$data.inscription_web}</a></p></div>
						</div>						
					</div>
				</div>

				<div class="span-10 last">
					<div class="marginDescription"><h3 class="blue">Descripción</h3></div>
					<div class="marginDescription">
						<p class="textRace">{$data.description}</p>
					</div>	
				</div>	
					
				<div id="map2Container" class="span-16 boxraceMap">
					<div class="marginDescription margin10"><h3 class="blue">Mapa del recorrido</h3></div>
					<div class="mapStyle marginDescription">
						<div id="map2"><img src="http://maps.google.com/staticmap?size=610x250&maptype=mobile&markers={$data.start_point_lat},{$data.start_point_lon},greens%7C{$data.end_point_lat},{$data.end_point_lon},bluem&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA"></div>
					</div>
				</div>
					
				<div class="span-16 marginDescription">
					<div class="marginDescription"><h3 class="blue">Comentarios[3]</h3><h5>publicar un comentario</h5></div>			
						<div class="column span-16 first racesComment">				
							<div class="column span-3 first image">
								<img src="img/user.jpg"/>	
							</div>
							<div class="column span-12 last commentBox">
								<div class="nameUser"><a class="nameRace" href="#">JCorrea,</a> hace 3 dias</div>
								<p class="textRace">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu fringilla purus. Quisque est tellus, ullamcorper ullamcorper sodales Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu fringilla purus. Quisque est tellus, ullamcorper ullamcorper sodales dolor sit amet, consectetur adipiscing elit. Duis eu fringilla purus. Quisque est tellus, ullamcorper ullamcorper.dolor sit amet!sssssssssssssssssssssssss ssssssssssssssssssssssssssssssssssssssssssssssssss</p>
							</div>
						</div>
						
						<div class="column span-16 first racesComment">				
							<div class="column span-3 first image">
								<img src="img/user.jpg"/>	
							</div>
							<div class="column span-12 last commentBox">
								<div class="nameUser"><a class="nameRace" href="#">JCorrea,</a> hace 3 dias</div>
								<p class="textRace">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu fringilla purus. Quisque est tellus, ullamcorper ullamcorper sodales Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu fringilla purus. Quisque est tellus, ullamcorper ullamcorper sodales dolor sit amet, consectetur adipiscing elit. Duis eu fringilla purus. Quisque est tellus, ullamcorper ullamcorper.dolor sit amet!sssssssssssssssssssssssss ssssssssssssssssssssssssssssssssssssssssssssssssss</p>
							</div>
						</div>
				</div>
				
				<!-- PARA AÑADIR COMENTARIOS -->
				<div class="span-16 boxraceMap">
					<div class="marginDescription commentArea">
						<div class="span-14 titleComents">Anímate y publica tu comentario</div>
						<textarea name="textarea2" id="commentTextArea" class="span-15 textArea"></textarea>
						<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Publicar comentario"/>
					</div>
				</div>
				
			</div>				
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<div><h2 class="newsTitle">Localización</h2></div>
					<div id="map" class="mapStyle">
					<img src="http://maps.google.com/staticmap?size=270x152&maptype=mobile&markers={$data.start_point_lat},{$data.start_point_lon},greens%7C{$data.end_point_lat},{$data.end_point_lon},bluem&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA">
					</div>
				</div>
			</div>
	
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">En las mismas fechas</h2>
				</div>
				<div class="events">
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
							<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
						</div>
					</div>
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="carrera.php" class="nameRace">XVII Media Marathon de Madrid</a>
							<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
						</div>
					</div>
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="carrera.php" class="nameRace">XXVI Carrera del Rock’n’Roll</a>
							<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
						</div>
					</div>
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="carrera.php" class="nameRace">XV Cross popular “Ascenso a l...</a>
							<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
						</div>
					</div>
					<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Ver tu calendario completo"/>
				</div>
			</div>
		
			
			<div class="span-8 moreRaces">
				<div class="events"> 
					<h2 class="newsTitle">Últimos valientes</h2>	
					{foreach key=id item=person from=$runners}
    				{if $person eq false}
    					<div class="span-8 races">No hay valientes.</div> 
    				{else}					
    					<div class="races">
    						<div class="column first image">
    							<img src="media/avatar/{$person.avatar}"/>	
    						</div>
    						<div class="column last">
    							<div class="detailsUser">
    								<div class="nameUser"><a class="nameRace" href="#">{$person.username}</a></div>
    								<div class="raceUserDetails"> dice que va a ir a esta carrera</div>
    							</div>
    							<div><p class="runnersNumber"><a href="">apúntate con él</a></p></div>
    						</div>
    					</div>
        			{/if}
        		    {foreachelse}
        		        <div class="span-8 races">No hay valientes.</div>    
        		    {/foreach}					
				</div>
			</div>	
		</div>
	</div>
</div>

{include file="footer.tpl"} 