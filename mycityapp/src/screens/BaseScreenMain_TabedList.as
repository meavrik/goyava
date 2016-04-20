package screens 
{
	import starling.display.Sprite;
	import ui.buttons.CallButton;
	/**
	 * ...
	 * @author Avrik
	 */
	public class BaseScreenMain_TabedList extends BaseScreenMain 
	{
		
		public function BaseScreenMain_TabedList() 
		{
			super();
			
		}
		
		
		protected function setNewListItemData(text:String, subText:String, eventName:String, ac:Sprite = null):Object
		{
			return { 	label: text,
						accessory: ac,
						event: eventName,
						subText: subText
					};
		}
		
		
		protected function getPhoneButton(numStr:String=""):CallButton
		{
			var phoneButton:CallButton = new CallButton(onPhoneClick);
			phoneButton.scaleX = phoneButton.scaleY = .8;
			return phoneButton
		}
		
		private function onPhoneClick():void 
		{
			
		}
		
	}

}