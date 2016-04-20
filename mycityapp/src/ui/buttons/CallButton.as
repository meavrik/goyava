package ui.buttons 
{
	import assets.AssetsHelper;
	import feathers.controls.Label;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.GoButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class CallButton extends GoButton 
	{
		
		public function CallButton(func:Function, type:int = 0) 
		{
			super();
			
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, type == 0?1:6));
			butn.addEventListener(Event.TRIGGERED, func);

			addChild(butn);
		}
		
	}

}