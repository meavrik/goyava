package feathers.themes
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//import feathers.examples.componentsExplorer.MainDemo;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;

	public class ComponentsExplorerWeb extends MovieClip
	{
		public function ComponentsExplorerWeb()
		{

			
			// IPAD 3
			DeviceCapabilities.dpi = 264;
			DeviceCapabilities.screenPixelWidth = 1400;//2048;
			DeviceCapabilities.screenPixelHeight = 1050;//1536;

			// IPHONE
			
			DeviceCapabilities.dpi = 326;
			DeviceCapabilities.screenPixelWidth = 960;
			DeviceCapabilities.screenPixelHeight = 640;			
		
			
			addEventListener(Event.ADDED_TO_STAGE, onA2S);
			
		}
		
		private function onA2S(e:Event):void {

			start();
			
		}
		
		private var _starling:Starling;
		
		/*private function start():void
		{
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			this._starling = new Starling(MainDemo, this.stage);
			
			this._starling.enableErrorChecking = false;
			
			this._starling.start();
		}*/
		

	}
}