package progress 
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class WaitPreloader extends Sprite 
	{
		[Embed(source="loading-icon-57600.png")]
		private var PreloaderMC:Class
		private var _preloaderImg:Image;
		
		public function WaitPreloader() 
		{
			super();
			this._preloaderImg = new Image(Texture.fromBitmap(new PreloaderMC()));
			addChild(this._preloaderImg);
			
			alignPivot();
			var tween:Tween = new Tween(this,30);
			tween.rotateTo(180, "deg");
			tween.repeatCount = 0;
			Starling.juggler.add(tween);
		}
		
		override public function dispose():void 
		{
			this._preloaderImg.texture.dispose();
			this._preloaderImg.removeFromParent(true);
			super.dispose();
		} 
		
	}

}