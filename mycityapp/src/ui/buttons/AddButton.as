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
	public class AddButton extends GoButton 
	{
		
		public function AddButton(func:Function) 
		{
			super();
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
			butn.addEventListener(Event.TRIGGERED, func);
			addChild(butn);
		}
		
	}

}