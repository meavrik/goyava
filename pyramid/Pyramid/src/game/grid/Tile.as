package game.grid 
{
	import assets.AssetsHelper;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import usefull.SuperSprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Tile extends SuperSprite 
	{
		private var _ypos:int;
		private var _xpos:int;
		
		public function Tile(xpos:int,ypos:int) 
		{
			super();
			this._xpos = xpos;
			this._ypos = ypos;
			
		}
		
		override protected function init():void 
		{
			super.init();
			
			
			var img:Image = AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.GRID_TEXTURES);
			addChild(img);
			
			
			this.x = (this._xpos * (img.bounds.width - 30)) + ((10 - _ypos) * (img.bounds.width / 2-16));
			this.y = this._ypos * (img.bounds.height);
			
			
		}
		
		
		
		
		
	}

}