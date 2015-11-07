package
{
	import feathers.themes.ComponentsExplorerWeb;
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Main extends Sprite 
	{
		[SWF(width = "960", height = "640", frameRate = "60", backgroundColor = "#4a4137")]
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Entry point
			// New to AIR? Please read *carefully* the readme.txt files!
			
			var starling:Starling = new Starling(Application, stage, new Rectangle(0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight));
			/* starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
               removeChild(_background);
            })*/
			starling.start();
			
			
			
			//var mapTest:MapTest = new MapTest();
			//addChild(mapTest);
		}

		
		private function deactivate(e:flash.events.Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}