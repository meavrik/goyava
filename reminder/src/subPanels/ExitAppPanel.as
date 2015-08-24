package subPanels 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.events.FeathersEventType;
	import flash.desktop.NativeApplication;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	/**
	 * ...
	 * @author Avrik
	 */
	public class ExitAppPanel extends SubPanel 
	{
		private var _yesButn:Button;
		private var _noButn:Button;
		private var _messageLabel:Label;
		
		public function ExitAppPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = TextLocaleHandler.getText(TextsConsts.ExitAppTitle);
			
			this._messageLabel = new Label();
			this._messageLabel.text = TextLocaleHandler.getText(TextsConsts.ExitAppMessage);
			this._messageLabel.y = 20;
			this._messageLabel.styleNameList.add( Label.ALTERNATE_STYLE_NAME_HEADING);
			this._messageLabel.wordWrap = true;
			this._messageLabel.addEventListener(FeathersEventType.CREATION_COMPLETE, onLabelReady);
			addChild(this._messageLabel);
			
			this._yesButn = new Button();
			this._yesButn.addEventListener(Event.TRIGGERED, onYesClick);
			this._yesButn.label = TextLocaleHandler.getText(TextsConsts.ExitAppYesButtonLabel);
			
			this._yesButn.width = 150;
			addChild(this._yesButn);
			
			this._noButn = new Button();
			this._noButn.addEventListener(Event.TRIGGERED, onNoClick);
			this._noButn.label = TextLocaleHandler.getText(TextsConsts.ExitAppNoButtonLabel);
			
			this._noButn.width = 150;
			addChild(this._noButn);
		}
		
		private function onLabelReady(e:Event):void 
		{
			this._yesButn.move(5, this._messageLabel.bounds.bottom + 20);
			this._noButn.move(160, this._messageLabel.bounds.bottom + 20);
		}
		
		private function onNoClick(e:Event):void 
		{
			closeMe();
		}
		
		private function onYesClick(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
		override public function dispose():void 
		{
			if (_yesButn)
			{
				_yesButn.removeFromParent(true);
				_yesButn = null;
			}
			
			if (_noButn)
			{
				_noButn.removeFromParent(true);
				_noButn = null;
			}
			super.dispose();
		}
		
	}

}