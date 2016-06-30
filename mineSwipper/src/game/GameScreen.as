package game 
{
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.DateTimeStyle;
	import flash.globalization.LocaleID;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GameScreen extends PanelScreen 
	{
		private var timeCounter:Label;
		private var _dateFormatter:DateTimeFormatter;
		
		public function GameScreen() 
		{
			super();
			title = "Mine Swiper";
			
			
			headerFactory = getCustemHeader;
			_verticalScrollPolicy = PanelScreen.SCROLL_POLICY_OFF;
			_dateFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
			_dateFormatter.setDateTimePattern("sss");
			_dateFormatter.setDateTimeStyles(DateTimeStyle.NONE, DateTimeStyle.MEDIUM);
		}
		
		private function getCustemHeader():Header 
		{
			var header:Header = new Header();
			timeCounter = new Label();
			timeCounter.text = "0:00";
			timeCounter.styleName = Label.ALTERNATE_STYLE_NAME_HEADING;
			header.leftItems = new <DisplayObject>[timeCounter];

			return header;
		}
		
		public function setTime(newDate:Date):void
		{
			timeCounter.text = _dateFormatter.format(newDate);
		}
		
	}

}