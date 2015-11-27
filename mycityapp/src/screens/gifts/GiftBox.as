package screens.gifts 
{
	import assets.AssetsHelper;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GiftBox extends Sprite 
	{
		private var _img:Image;
		private var _butn:Button;
		private var _mc:MovieClip;
		private var tween:Tween;
		
		public function GiftBox() 
		{
			super();
			//this._img = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 30));
			this._mc = new MovieClip(AssetsHelper.getInstance().assetManager.getTextureAtlas(AssetsHelper.GIFT_ANIMATION).getTextures(), 25);
			addChild(_mc);
			
			
			_mc.scaleX = _mc.scaleY = 0;
			_mc.loop = false;
			_mc.alignPivot();
			
			_butn = new Button(Texture.empty(100, 100))
			_butn.alignPivot();
			_butn.addEventListener(Event.TRIGGERED, onClick);
			addChild(_butn);
		}
		
		public function play():void
		{
			/*_mc.addEventListener(Event.COMPLETE, onAnimationComplete);
			_mc.play();
			Starling.juggler.add(_mc);*/
			_mc.play();
			_mc.loop = false;
			tween = new Tween(_mc, 1, Transitions.EASE_OUT_ELASTIC);
			tween.scaleTo(1);
			tween.onComplete = onGrowComplete;
			Starling.juggler.add(tween);
		}
		
		private function onGrowComplete():void 
		{
			/*tween = new Tween(_mc, .5);
			tween.reverse = true;
			tween.repeatCount = 0;
			tween.moveTo(_mc.x, _mc.y + 20);
			Starling.juggler.add(tween);*/
		}
		
		private function onClick(e:Event):void 
		{
			trace("1111");
			dispatchEventWith(Event.SELECT);
		}
		
	}

}