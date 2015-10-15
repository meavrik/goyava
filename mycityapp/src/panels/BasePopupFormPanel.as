package panels 
{
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class BasePopupFormPanel extends BasePopupPanel 
	{
		
		public function BasePopupFormPanel() 
		{
			super();
			
		}
		
		protected function showInvalidMessage(content:DisplayObject,message:String):void
		{
			var label:Label = new Label();
			label.text = message;
	 
			Callout.show( label, content);
		}
		
	}

}