package screens.subScreens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import helpers.FormatHelper;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenSellItemView extends PanelScreen
	{
		private var _dataProvider:Object;
		private var _label:Label;
		
		public function ScreenSellItemView() 
		{
			super();
			
			_label = new Label();
			_label.move(10, 20);
		}
		
		public function set itemData(value:Object):void 
		{
			this._dataProvider = value;
			title = this._dataProvider.name;
			
			_label.text = "מחיר : " + FormatHelper.getMoneyFormat(this._dataProvider.price, GlobalDataProvider.currencySign);
			_label.text += "\n";
			_label.text += "פרטים נוספים : " + this._dataProvider.description;
			_label.text += "\n";
			_label.text += "\n";
			_label.text += "הועלתה ב : " + FormatHelper.getDate(this._dataProvider.created);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addChild(_label);
			setSize(stage.stageWidth, stage.stageHeight/3);
			_label.setSize(this.stage.stageWidth - 20, 150);
			
			this.headerFactory = customHeaderFactory;
		}
		
		
		protected function customHeaderFactory():Header 
		{
			var butnWidth:Number = (this.stage.stageWidth - 50) / 3;
			
			var header:Header = new Header()

			var callButton:Button = new Button();
			callButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
			callButton.addEventListener(Event.TRIGGERED, onCallClick);
			
			var mailButton:Button = new Button();
			mailButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
			mailButton.addEventListener(Event.TRIGGERED, onMailClick);
			
			var messageButton:Button = new Button();
			messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
			messageButton.addEventListener(Event.TRIGGERED, onMessageClick);

			header.rightItems = new <DisplayObject>[callButton,mailButton,messageButton];
			return header
		}
		
		private function onCallClick(e:Event):void 
		{
			const callURL:String = "tel:" + this._dataProvider.phone;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
		private function onMessageClick(e:Event):void 
		{
			const callURL:String = "sms:" + this._dataProvider.phone;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
		private function onMailClick(e:Event):void 
		{
			const callURL:String = "mailto:" + this._dataProvider.email;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
		
		
	}

}