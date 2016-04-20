package panels 
{
	import feathers.controls.Label;
	import feathers.controls.Panel;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class QuitPanel extends Panel 
	{
		
		public function QuitPanel() 
		{
			super();
			title = "זהו?";
			
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var label:Label = new Label();
			label.text = "אתה בטוח שאתה רוצה לצאת?";
			addChild(label);
		}
		
	}

}