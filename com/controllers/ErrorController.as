package controllers 
{
	import com.gamua.flox.Flox;
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	/**
	 * ...
	 * @author Avrik
	 */
	public class ErrorController 
	{
		public static function showError(from:Object, message:String, refreshFunc:Function=null):void
		{
			Flox.logError(from, message);
			Alert.show("Something went wrong,\nplease try to refresh the application", "Oops..", new ListCollection([ { label: "Refresh" } ]));
			
		}
		
		static public function showNoConnection(refreshFunc:Function=null):void 
		{
			Alert.show("No internet connection", "Oops..", new ListCollection([ { label: "Try again" , triggered: refreshFunc} ]));
		}
		
		/*static private function onRefreshClick(e:Event):void 
		{
			trace("1111111111111111");
			MainApp.getInstance().initNewPlayer();
		}*/
		
	}

}