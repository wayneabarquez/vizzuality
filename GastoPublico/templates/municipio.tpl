{include file="header.tpl"}

<div id="map"></div>
<div id="layout">
	<div class="left_region_mun">
		<img class="arrow" src="images/white_arrow.png" alt="white arrow">
		<div class="top_information">
			<div class="logo">
				<img src="{$municipio.escudo}" />
			</div>
			<div class="region_data">
				<h1>{$municipio.poblacion}</h1>
				<p class="information">{$municipio.provincia}, {$municipio.habitantes} habitantes</p>
				<p class="web"><a href="{$municipio.web}" target="_blank">{$municipio.web}</a></p>
			</div>
		</div>
		<img class="region" src="{$municipio.foto}">
		<hr color="#E2E3DD" size="1"/>
		<div class="political_data">
			<h2>Alcaldía</h2>
			<div class="political_logo">
				<img src="{$logoPartido}"/>
			</div>
			<div class="political_information">
				<h3>{$municipio.alcalde}</h3>
				<p>ver su <a href="{$municipio.alcalde_voota_link}">biografía en voota</a></p>
			</div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="political_stats">
			<h2>Gasto por tipo de procedimiento</h2>
			<div class="big_chart"></div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="political_stats">
			<h2>Gasto por categorías</h2>
			<div class="big_chart"></div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="more_enterprises">
			<h2>Gasto por categorías</h2>
			<ul>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
			</ul>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="related_regions">
			<span>
				<h2>Municipios relacionados</h2>
				<a href="#">ver mapa</a>
			</span>	
			<ul>
				{foreach key=id item=organismo_lista from=$orga_relacionados name=counter}
					<li><a href="organismo.php?id={$organismo_lista.id}">{$organismo_lista.nombre_admin}</a></li>
		    {/foreach}
			</ul>
		</div>
	</div>
	
	<div class="right_region_mun">
		<span>
			<h3>{if $municipio.num_licitaciones eq 1}{$municipio.num_licitaciones} Obra en el municipio{else}{$municipio.num_licitaciones} Obras en el municipio{/if}</h3>
			<div>
				<p>{$municipio.sum_importe|number_format}€</p>
				<p class="small">GASTO</p>
			</div>
		</span>
		<div class="search_container">
		</div>
		<ul>
			{foreach key=id item=licitacion from=$lista_licitaciones name=counter}
				<li>
					<div class="left_information">
						<div class="work_image">
							<a href="#"><img src="../images/work_fake.png" /></a>
						</div>
						<div class="work_information">
							<a href="obra.php?id={$licitacion.licitacion_id}">{$licitacion.titulo|truncate:120:"..."|lower|capitalize:true}</a>
							<p>{$licitacion.categoria} - Presupuesto de <strong>{$licitacion.importe|number_format}€</strong></p>
						</div>
					</div>
					<div class="right_information">
						<a class="no_likes" href="#">{$licitacion.votes_down}</a>	
						<a class="likes" href="#">{$licitacion.votes_up}</a>
						<a class="comments" href="#">{if $licitacion.num_comentarios eq 1}{$licitacion.num_comentarios} comentario{else}{$licitacion.num_comentarios} comentarios{/if}</a>
					</div>
				</li>
	    {/foreach}
		</ul>
		
		<p class="long"><a href="#">ver más</a></p>
		<p class="long">viendo 6 de {$organismo.num_licitaciones}</p>
		
	</div>
	
</div>

{include file="footer.tpl"}