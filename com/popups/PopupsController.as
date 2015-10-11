package popups 
{
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class PopupsController
	{
		private static var _currentPopup:DisplayObject;
		
		public static function addPopUp(popUp:DisplayObject, isModal:Boolean = true):void
		{
			_currentPopup = popUp
			_currentPopup.addEventListener(Event.CLOSE, onPopupClose);
			PopUpManager.addPopUp(popUp, isModal);
		}
		
		static private function onPopupClose(e:Event):void 
		{
			var popup:DisplayObject = e.currentTarget as DisplayObject;
			popup.removeEventListener(Event.CLOSE, onPopupClose);
			
			removeCurrentPopup();
		}
		
		public static function removeCurrentPopup(dispose:Boolean = false):void
		{
			if (_currentPopup && PopUpManager.isPopUp(_currentPopup))
			{
				PopUpManager.removePopUp(_currentPopup, dispose);
				_currentPopup = null;
			}
			
		}
		
		static public function removePopUp(popUp:DisplayObject):void 
		{
			if (popUp == _currentPopup)
			{
				removeCurrentPopup();
			}
		}
		
		static public function get currentPopup():DisplayObject 
		{
			return _currentPopup;
		}
	

		
	}

}