package ui 
{
	import starling.display.Stage;
	/**
	 * ...
	 * @author Avrik
	 */
	public class UiGenerator 
	{
		private static var _instance:UiGenerator = new UiGenerator();
		private var _fieldHeight:Number;
		private var _fieldWidth:Number;
		private var _buttonHeight:Number;
		private var _buttonWidth:Number;
		
		public static function getInstance():UiGenerator
		{
			return _instance
		}
		
		public function UiGenerator() 
		{
			
		}
		
		public function init(stage:Stage):void
		{
			_fieldHeight = Math.round(stage.stageHeight / 15);
			_fieldWidth = stage.stageWidth - 60;
			
			_buttonHeight = Math.round(stage.stageHeight / 15);
			_buttonWidth = stage.stageWidth - 60;
		}
		
		public function get fieldHeight():Number 
		{
			return _fieldHeight;
		}
		
		public function get fieldWidth():Number 
		{
			return _fieldWidth;
		}
		
		public function get buttonHeight():Number 
		{
			return _buttonHeight;
		}
		
		public function get buttonWidth():Number 
		{
			return _buttonWidth;
		}
		
	}

}