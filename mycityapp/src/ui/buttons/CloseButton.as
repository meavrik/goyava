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
	public class CloseButton extends GoButton 
	{
		
		public function CloseButton(func:Function) 
		{
			super();
			var closeButton:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 4));
			closeButton.addEventListener(Event.TRIGGERED, func);
			addChild(closeButton);
		}
		
	}

}