package ui.buttons 
{
	import assets.AssetsHelper;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.ItemCounter;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ProfileButton extends Sprite 
	{
		private var _messagesCounter:ItemCounter
		
		public function ProfileButton(func:Function) 
		{
			super();
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 5));
			butn.addEventListener(Event.TRIGGERED, func);
			addChild(butn);
			
			_messagesCounter = new ItemCounter();
			addChild(_messagesCounter);
		}
		
		public function set messageCounter(value:int):void
		{
			_messagesCounter.count = 1;
		}
		
	}

}