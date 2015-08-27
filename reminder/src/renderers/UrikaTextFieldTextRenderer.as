package renderers 
{
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.text.TextFormat;
	import starling.core.RenderSupport;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class UrikaTextFieldTextRenderer extends TextFieldTextRenderer 
	{
		
		public function UrikaTextFieldTextRenderer() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			//trace("AA");
			text = "Hello";
			//textField.textColor = 0x000000;
			
			//textFormat = new TextFormat("Arial", 20, 0);
			
		}
		
	}

}