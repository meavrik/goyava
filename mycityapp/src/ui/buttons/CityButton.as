package ui.buttons 
{
	import assets.AssetsHelper;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.GoButton;
	import ui.ItemCounter;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class CityButton extends GoButton 
	{
		private var _messagesCounter:ItemCounter
		
		public function CityButton(func:Function) 
		{
			super();
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 9));
			butn.addEventListener(Event.TRIGGERED, func);
			addChild(butn);
		}
		
	}

}