package com.vizzuality.markers
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat; 
	
	public class GenericMarkerIcon extends Sprite
	{
	  [Embed('assets/comment.png')] 
	  private var comment:Class;
	  
	  [Embed('assets/activity.png')] 
	  private var activity:Class;

	  
		public function GenericMarkerIcon(icon:String,texto:String="")
		{
			switch(icon) {
				case "clusterIcon":
					var background2:Sprite = new Sprite();
		 			background2.graphics.beginFill(0x336699,0.45);
		            background2.graphics.drawCircle(0,0,18);
		            background2.graphics.endFill();
		            background2.x=13;
		            background2.y=14;
		            addChild(background2);
		            var whiteCircle:Sprite = new Sprite();
		 			whiteCircle.graphics.beginFill(0xFFFFFF);
		            whiteCircle.graphics.drawCircle(0,0,13);
		            whiteCircle.graphics.endFill();
		            whiteCircle.x=13;
		            whiteCircle.y=14;
		            addChild(whiteCircle);
		             var blueCircle:Sprite = new Sprite();
		 			blueCircle.graphics.beginFill(0x336699);
		            blueCircle.graphics.drawCircle(0,0,11);
		            blueCircle.graphics.endFill();
		            blueCircle.x=13;
		            blueCircle.y=14;
		            addChild(blueCircle);
					break;
				case "commentIcon":
					addChild(new comment());
					break;
				case "activityIcon":
					addChild(new activity());
					break;
			}
			if(texto!="") {

				var tf:TextField = new TextField();
				var format:TextFormat = tf.getTextFormat();
				format.font = 'Arial';
				format.bold=true;
				tf.defaultTextFormat = format;
				tf.text = texto;
				tf.textColor = 0xffffff;

				tf.y = 5;
				if(texto.length>2) {
					tf.x = 3;				
				} else if (texto.length>1) {
					tf.x = 6;
				} else {
					tf.x = 8;
				}
				
				tf.mouseEnabled = false;
				tf.width = tf.textWidth + 4;
				tf.height=20;
				mouseChildren = false;
				addChild(tf);
			}
		}
	}
}