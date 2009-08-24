{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column raceTitle">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="/">Inicio ></a></li>
						<li><a href="#" class="selected">Resultados de tu búsqueda</a></li>
						<li><a href="#" class="selected">"<b>{$smarty.request.q}</b>"</a></li>
					</ul>
				</div>
			</div>
			
			<div class="span-16 raceContent1">
				<h2 class="newsTitle3">Resultados de tu búsqueda ({$count})</h2>
				<div class="raceSearchFirst">
					<div class="searchPanel">
						<div class="labels">
							<div class="searchlabel">Localidad, nombre, etc...</div>
							<div class="searchlabel searchlabel2">Distancia mín / max (metros)</div>
						</div>
						<form id="searchForm" method="GET">
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch2"><span><input type="text" name="distancia_min" id="inputsearch2"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch3"><span><input type="text" name="distancia_max" id="inputsearch3"></span></label>
							</div>
							<div class="buttonSearch"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Buscar"/></div>
						</form>
					</div>
					<div class="pagination countAgo countAgo2">
						<div class="pagination">
							
							    {if $offset > 0}
							        <a href="?offset={math equation="max(x-20,0)" x=$offset}">Previous</a>
							        <div class="column btnJoin"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="<"/></div>
							    {/if}
							    {if $offset < $count-20}
							        <a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}">Next</a>
							        <div class="column"><input class="fg-button ui-state-default ui-corner-all" type="submit" value=">"/></div>	
                                {/if}
							        
							    
							
						</div>
						<div class="column pagination">viendo del <b>{math equation="min(x*20,1)" x=$offset} al {math equation="min((x+1)*20,1)" x=$offset}</b> de {$count}</div>			
					</div>
				</div>
				<div class="dates">
					<a href="carrera.php" class="nameRace">Resultado</a>
				</div>
        		{foreach key=id item=race from=$results}
        			{if $race eq "false"}
        				<div class="span-9 races"><p class="noResults">No hay resultados para la búsqueda.</p></div> 
        			{else}
        				<div class="raceDetails" id="raceDetails">
        					<div class="column span-1 first date">
        						<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
        						<div class="day">{$race.event_date|substr:8:2}</div>
        					</div>
        					<div class="column span-6 last nextRaceComment">
        						<a href="carrera.php?id={$race.id}" class="nameRace">{$race.name}</a>
        						<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        					</div>
        				</div>        			
        			{/if}
            	    {foreachelse}
            	        <div class="span-9 races"><p class="noResults">No hay resultados para la búsqueda.</p></div> 
            	    {/foreach}
				<div class="raceSearchLast">
					<div class="searchPanel">
						<div class="pagination countAgo">
						<div class="pagination">
						    {if $offset > 0}
						        <a href="?offset={math equation="max(x-20,0)" x=$offset}">Previous</a>
						        <div class="column btnJoin"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="<"/></div>
						    {/if}
						    {if $offset < $count-20}
						        <a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}">Next</a>
						        <div class="column"><input class="fg-button ui-state-default ui-corner-all" type="submit" value=">"/></div>	
                            {/if}
						</div>
							<div class="column pagination">viendo del <b>{math equation="min(x*20,1)" x=$offset} al {math equation="min((x+1)*20,c)" x=$offset c=$count}</b> de {$count}</div>
					</div>
					</div>
				</div>
			</div>	
						
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">

			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">Próximas carreras</h2>
				</div>	
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq "false"}
            				<div class="span-8 races">No hay proximas carreras.</div> 
            			{else}		    				    
        					<div class="raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
        							<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
        							<div class="day">{$race.event_date|substr:8:2}</div>
        						</div>
        						<div class="column span-6 last nextRaceComment">
        							<a href="carrera.php?id={$race.id}" class="nameRace">{$race.name}</a>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
            			{/if}
                	    {foreachelse}
                	        <div class="span-8 races">No hay proximas carreras.</div> 
                	    {/foreach}					
				</div>				
			</div>		
		</div>
	</div>
</div>

{include file="footer.tpl"} 