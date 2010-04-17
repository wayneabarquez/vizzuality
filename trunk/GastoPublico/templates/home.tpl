{include file="header.tpl"}

<div id="map" style="height:384px">
</div>

<div id="layout">
	
	<div class="overMap">
		<h1>Entérate de las obras que hay a tu alrededor y di que te parecen.</h1>
	
		<div class="searchForm">
			<h3>Busca tu municipio y encuentra obras en él</h3>
			<form>
				<input type="text" value="Introduce tu municipio..." id="searchHeader"/>
				<input type="submit" value="" />
				
			</form>
			<p>¿es tu municipio <a href="#">Villaviciosa de Odón, Madrid</a>?</p>
		</div>
	
	</div>
	
	<div class="main_container">
		<div class="left_home">
			<h3>Obras con comentarios recientes</h3>
			<ul>
				<li>
					<div class="left_information">
						<div class="work_image">
							<img src="../images/work_fake.png" alt="Work" />
						</div>
						<div class="work_information">
							<h4>Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</h4>
							<p><a href="#">Villaviciosa de Odón</a> - <strong>431,234€</strong></p>
						</div>
					</div>
					<div class="right_information">
						<a class="likes" href="#"><span>gusta a <strong>1</strong> usuario</span></a>
						<a class="comment" href="#">comenta el primero</a>
					</div>
				</li>
				<li>
					<div class="left_information">
						<div class="work_image">
							<img src="../images/default_work.png" alt="Work" />
						</div>
						<div class="work_information">
							<h4>Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</h4>
							<p><a href="#">Villaviciosa de Odón</a> - <strong>431,234€</strong></p>
						</div>
					</div>
					<div class="right_information">
						<a class="no_like"><span>gusta a 0 usuarios</span></a>
						<a class="comments" href="#">12 comentarios</a>
					</div>
				</li>
				<li class="last">
					<div class="left_information">
						<div class="work_image">
							<img src="../images/work_fake.png" alt="Work" />
						</div>
						<div class="work_information">
							<h4>Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</h4>
							<p><a href="#">Villaviciosa de Odón</a> - <strong>431,234€</strong></p>
						</div>
					</div>
					<div class="right_information">
						<a class="likes" href="#"><span>gusta a <strong>1</strong> usuario</span></a>
						<a class="comment" href="#">comenta el primero</a>
					</div>
				</li>
			</ul>
		</div>
		<div class="right_home">
			<h3>¿Cómo gasta España el dinero en obras?</h3>
			<div class="long">
				<div class="stats left">
					<label>GASTO</label>
					<p class="amount">212,317,321€</p>
				</div>
				<div class="right expensive_chart">
				</div>
			</div>

			<hr size="1" color="#CDCDC7" width="320" style="float:left"/>
			
			<h3>¿Cómo gastan los principales partidos el dinero en obras?</h3>
		
			<div class="longPolitical">
				<div class="political_stats2">
					<div class="expensive_chart2"></div>
					<p class="politicalName">Partido Popular</p>
				</div>
				<div class="political_stats">
					<div class="expensive_chart2"></div>
					<p class="politicalName">PSOE</p>
				</div>
				<div class="political_stats">
					<div class="expensive_chart2"></div>
					<p class="politicalName">Izquierda Unida</p>
				</div>
			</div>
			<p class="long"><a href="#">Más respuestas en stats.gastopublico.es</a></p> 
		</div>
	</div>
</div>

{include file="footer_home.tpl"}