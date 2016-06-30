package
{
	import feathers.utils.ScreenDensityScaleFactorManager;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	//import starling.events.Event;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		//[SWF(width = "960", height = "640", frameRate = "60", backgroundColor = "#4a4137")]
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			
			
			var viewPort:Rectangle = RectangleUtil.fit(
				//new Rectangle(0, 0, 960, 640), 
				new Rectangle(0, 0, 1280, 720), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.SHOW_ALL);
			viewPort.y = 0;
			_starling = new Starling(AppEntry, stage, viewPort, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			_starling.start();
			new ScreenDensityScaleFactorManager(this._starling);
			
			
			
			
			// Entry point
			// New to AIR? Please read *carefully* the readme.txt files!
			
			//_starling = new Starling(AppEntry, stage, null, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			_starling.supportHighResolutions = true;
			/* starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
               removeChild(_background);
            })*/
			//_starling.start();
			
			//var mapTest:MapTest = new MapTest();
			//addChild(mapTest);
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}

		private function stage_resizeHandler(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;

			var viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch (error:Error) { }
		}
		
		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop(true);
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}

		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}
		
	}
	
}