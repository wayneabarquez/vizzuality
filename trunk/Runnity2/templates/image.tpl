{include file="header.tpl"}


<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
		<div class="span-1 columnNameUser">
		{if $source eq "run"}
			<p class="nameUserProfile">Foto de {$pictureDetails.belongs_to_name}</p>
		{else}
			<p class="nameUserProfile">Fotos subidas por {$pictureDetails.username}</p>
		{/if}	
		</div>
		{if $source eq "run"}
			<a class="dashboardLink" href="/run/{$pictureDetails.belongs_to_fk}/{$pictureDetails.belongs_to_name|replace:' ':'/'}">volver a la carrera <img src="/img/arrowDash.gif"></a>
		{else}
			<a class="dashboardLink" href="/user/{$pictureDetails.username}">volver a su perfil <img src="/img/arrowDash.gif"></a>
		{/if}	
		<div class="globalContainerUser">	
			<div class="span-1 last imgData">
				<div class="span-1 last upPaginator imagePaginator">
					<p>{$fotoPosition} de {$totalFotos}</b>
					{if $previousFotoId gt 0}
						<span><a href="/image.php?id={$previousFotoId}&source={$smarty.get.source}"><input class="fg-button buttonLeftArrow" type="button"/></a></span>
					{/if}	
					{if $nextFotoId gt 0}
						<span><a href="/image.php?id={$nextFotoId}&source={$smarty.get.source}"><input class="fg-button buttonRightArrow" type="button"/></a></span>
					{/if}
					</p>	
				</div>	
				<div class="span-1 containerImg ">
					<!--HACER CLick EN LA FOTO PARA PASAR A LA SIGUIENTE-->
					{if $nextFotoId gt 0}
					<a href="/image.php?id={$nextFotoId}&source={$smarty.get.source}">
					{/if}
					<img class="targetImg" id="userImg" src="{$pictureDetails.path}">
					{if $nextFotoId gt 0}
					</a>
					{/if}
            		{if $source eq "run"}
            		    <p>ver más fotos de <a href="/run/{$pictureDetails.belongs_to_fk}/{$pictureDetails.belongs_to_name|replace:' ':'/'}">{$pictureDetails.belongs_to_name}</a></p>
            		{else}
            		    <p>ver más fotos de <a href="/user/{$pictureDetails.username}">{$pictureDetails.username}</a></p>            		
            		{/if}					
					
					
				</div>
			</div>
		</div>
	
		<div class="span-1 last columnLong">
			<p class="titulo tituloLeft tituloRight">COMENTARIOS {if !empty($comments)}[{$comments|@count}]{/if}
			<a class="publica" onclick="document.getElementById('commentTextArea').focus();">publicar un comentario</a>
			</p>
			<ol id="update">
			{foreach key=id item=comment from=$comments name=commentloop}
				{if $smarty.foreach.commentloop.iteration==1}		
					<div class="span-1 separatorFirstComment"></div>
				{/if}
				{if $comment}										
				<div id="comment" class="span-1 last">
					<div class="span-1 last avatarBox">
						<img src="/avatar.php?id={$comment.user_id}&type=s"/>	
					</div>
					<div class="span-1 commentBox">
					<div class="nameUser"><a class="name" href="/user/{$comment.username}">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
					<p class="commentUser">{$comment.commenttext}</p>
					</div>
				</div>	
				{else}
					<div class="span-1 separatorFirstComment"></div>
				{/if}
			{/foreach}	
		</ol>						
		</div>
		
		<!-- PARA AÑADIR COMENTARIOS -->
		<div class="span-8" id="flash" align="left"></div>
		<div class="span-1 last boxraceMap">
			<div class="commentArea" id="commentBox">	
			{if $smarty.session.logged}				
				<div class="titleComents">Anímate y publica tu comentario</div>
				<textarea name="textarea2" id="commentTextArea" class="textArea"></textarea>
				<!-- CUIDADO!!! QUE HE COPIPASTEADO DE LA DE CARRERA! -->				
				<input class="fg-button buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction('Picture',{$smarty.request.id},'picture',$('#commentTextArea').val())"/>
			{else}
			<div class="span-1 iconPhrase">
				<img src="/img/slash.gif"/>
			</div>
			<div>
				<p class="noComments">Para realizar comentarios debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
			</div>
			 {/if}
		
			</div>
		</div>		
	</div>


	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">
		<div class="span-1 functionalContainer">
			{if $source eq "run"}
				<p class="titulo tituloLeft tituloColumnRight">MÁS FOTOS DE ESTA CARRERA</p>
			{else}
				<p class="titulo tituloLeft tituloColumnRight">MÁS FOTOS DE {$pictureDetails.username|upper}</p>
			{/if}	
			
			<div class="eventsUsers">
			{if $pictures}
				<div class="avatarContainer">
				{foreach key=id item=picture from=$pictures}
					<a href="/image.php?id={$picture.id}&source={$smarty.get.source}"><img class="avatarPhoto" src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/></a>
				{/foreach}	
				</div>
			{/if}
			</div>
		</div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 