package ui.buttons 
{
	import assets.AssetsHelper;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.GoButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class SaveButton extends GoButton 
	{
		
		public function SaveButton(func:Function) 
		{
			super();
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 3));
			butn.addEventListener(Event.TRIGGERED, func);
			addChild(butn);
		}
		
	}

}