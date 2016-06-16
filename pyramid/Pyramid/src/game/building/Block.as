package game.building 
{
	import assets.AssetsHelper;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import usefull.SuperSprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Block extends SuperSprite 
	{
		
		public function Block() 
		{
			super();
		}
		
		
		

		
		override protected function init():void 
		{
			super.init();
			
			var img:Image = AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.CUBE_TEXTURES);
			addChild(img);
		}
		
		
		public function move(xx:Number, yy:Number):void 
		{
			this.x = xx + 4;
			this.y = yy - 3;
		}
		
		
		public function startSlide():void
		{
			var tween:Tween = new Tween(this,3);
			tween.repeatCount = 0;
			tween.reverse = true;
			tween.animate("x", 0);
			Starling.juggler.add(tween);
		}
		
	}

}