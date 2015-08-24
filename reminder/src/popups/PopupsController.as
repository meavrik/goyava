package popups 
{
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import starling.display.DisplayObject;
	
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
			PopUpManager.addPopUp(popUp, isModal);
		}
		
		public static function removeCurrentPopup(dispose:Boolean = false):void
		{
			if (_currentPopup)
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