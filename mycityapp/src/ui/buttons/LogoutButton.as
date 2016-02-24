package ui.buttons 
{
	import assets.AssetsHelper;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LogoutButton extends Sprite 
	{
		
		public function LogoutButton(func:Function) 
		{
			super();
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 8));
			butn.addEventListener(Event.TRIGGERED, func);
			addChild(butn);
		}
		
	}

}