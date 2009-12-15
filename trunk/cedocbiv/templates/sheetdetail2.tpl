{include file="header.tpl"}

<div class="content">
	<div class="news-body">
		
		<div class="titleID">
			<div class="span-1 detailTitleID">{$Ident[0].UnitID}</div> 
			<div class="detailTitle"><p>{$Ident[0].NameAuthorYearString}</p></div>
		</div>
		
		<div class="containerDetails">
			{if ($Units.LatitudeDecimal != '' || $Units.LongitudeDecimal != '') || $Units.coords != ''}
				<div class="MapResult" id="map"></div>
			{/if}
			<p class="detailTaxon">{$Ident[0].HigherTaxon}</p> 
			<p class="detailInfo"><b>{$smarty.const.PUBLICAT}</b> {$Units.created_when}</p>
			<p class="detailInfo"><b>{$smarty.const.ETIQUETA}</b> {$Ident[1].NameAuthorYearString}</p> 
			<p class="detailInfo"><b>{$smarty.const.GUARDAT}</b> {$Ident[0].NameAuthorYearString}</p> 
			<p class="detailInfo"><b>{$smarty.const.LOCALITAT}</b> {$Units.LocalityText}</p> 
			<p class="detailInfo"><b>{$smarty.const.PAIS}</b> {$Units.CountryName}</p> 
			<p class="detailInfo"><b>{$smarty.const.ALTITUD}</b> {$Units.AltitudeLowerValue} - {$Units.AltitudeUpperValue}</p> 
			<p class="detailInfo"><b>{$smarty.const.RECOL}</b> {$Agents.GatheringAgentsText}</p> 
			<p class="detailInfo"><b>{$smarty.const.HABITAT}</b> {$Units.BiotopeText}</p> 
			<!-- 	  meter CollectorNumber -->
			<p class="detailInfo"><b>{$smarty.const.DATAREC}</b> 25-05-1985</p> 
			<p class="detailInfo"><b>{$smarty.const.COL}</b> {$Units.ProjectTitle}</p> 
			<p class="detailInfo"><b>{$smarty.const.FEN}</b> {$Units.Phenology}</p> 
			{if $Images}
			<div>
			<p class="detailInfo">{$smarty.const.IMG}</p>
			{foreach key=UnitID item=Image from=$Images.imagenes}
				<a href="{$Image.ImageURI}">{$Image.ImageURI}</a><br />
			{/foreach}
			</div>
			{/if}
		</div>
	</div>
	
</div>

{if ($Units.LatitudeDecimal != '' || $Units.LongitudeDecimal != '') || $Units.coords != ''}

{literal}<script src="http://maps.google.com/maps?file=api&v=2&key={/literal}{$smarty.const.MAPS_API_KEY}{literal}" type="text/javascript"></script>{/literal}

{literal}
<script type="text/javascript">
	//<![CDATA[
	var map;
	if (GBrowserIsCompatible()) {
	map = new GMap2(document.getElementById("map"));
	map.setMapType(G_PHYSICAL_MAP);
	map.addControl(new GSmallMapControl());
	//map.addControl(new GMapTypeControl());
	map.setCenter(new GLatLng(39,-3), 4);
	geoXml = new GGeoXml("{/literal}{$smarty.const.SERVER_URL}{literal}sheetdetailKml.php?UnitID={/literal}{$Ident[0].UnitID}{literal}", function() {
		
	if (geoXml.loadedCorrectly()) {
		geoXml.gotoDefaultViewport(map);
		{/literal}{if $isUtm eq false}{literal}
		    map.setZoom(map.getZoom()-6);
		{/literal}{/if}{literal}
	}
		
	});
	map.addOverlay(geoXml);
	}
	//]]>
</script>
{/literal}

{/if}

{include file="footer.tpl"}