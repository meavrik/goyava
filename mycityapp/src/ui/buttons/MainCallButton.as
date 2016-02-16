package ui.buttons 
{
	import assets.AssetsHelper;
	import feathers.controls.Label;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainCallButton extends Sprite 
	{
		
		public function MainCallButton(func:Function,txt:String="") 
		{
			super();
			//var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS2, 0));
			var butn:Button = new Button(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
			/*butn.fontName = "Arial";	
			butn.fontColor = 0xffffff;
			butn.fontSize = 40;*/
			butn.addEventListener(Event.TRIGGERED, func);
			
			
			
			addChild(butn);
			
			if (txt)
			{
				var label:Label = new Label();
				label.text = txt;
				label.width = this.width;
				label.height = this.height;
				//label.alignPivot();
				addChild(label);
			}
			
			//alignPivot();
		}
		
	}

}