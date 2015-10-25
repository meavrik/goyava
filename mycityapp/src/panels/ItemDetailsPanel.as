package panels 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import helpers.FormatHelper;
	import starling.display.Image;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ItemDetailsPanel extends BasePopupPanel
	{
		private var _dataProvider:Object;
		
		public function ItemDetailsPanel(dataProvider:Object) 
		{
			super();
			this._dataProvider = dataProvider;
			
			title = this._dataProvider.name;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var label:Label = new Label();
			label.move(0, 20);
			label.setSize(this.width - 30, 150);
			label.text = "מחיר : " + FormatHelper.getMoneyFormat(this._dataProvider.price, GlobalDataProvider.currencySign);
			label.text += "\n";
			label.text += "פרטים נוספים : " + this._dataProvider.details;
			label.text += "\n";
			label.text += "\n";
			//label.text += "פרטי התקשרות : " + this._dataProvider.phone;
			//label.text += "\n";
			//label.text += "דוא''ל : " + this._dataProvider.email;
			//label.text += "\n";
			//label.text += "\n";
			label.text += "הועלתה ב : " + FormatHelper.getDate(this._dataProvider.created);

			addChild(label);
			
			var butnWidth:Number = (this.width - 50) / 3;
			
			var callButton:Button = new Button();
			callButton.label = "התקשר";
			callButton.move(0, label.bounds.bottom+10);
			callButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
			callButton.setSize(butnWidth, 60);
			callButton.iconPosition = Button.ICON_POSITION_RIGHT;
			callButton.iconOffsetX = 20;
			callButton.addEventListener(Event.TRIGGERED, onCallClick);
			addChild(callButton);
			
			var mailButton:Button = new Button();
			mailButton.label = "דוא''ל";
			mailButton.setSize(butnWidth, 60);
			mailButton.iconPosition = Button.ICON_POSITION_RIGHT;
			mailButton.iconOffsetX = 20;
			mailButton.move(callButton.bounds.right + 10, callButton.y);
			mailButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
			mailButton.addEventListener(Event.TRIGGERED, onMailClick);
			//callButton.setSize(UiGenerator.getInstance().fieldHeight-20, UiGenerator.getInstance().fieldHeight-20);
			addChild(mailButton);
			
			var messageButton:Button = new Button();
			messageButton.label = "הודעה";
			messageButton.setSize(butnWidth, 60);
			messageButton.iconPosition = Button.ICON_POSITION_RIGHT;
			messageButton.iconOffsetX = 20;
			messageButton.move(mailButton.bounds.right + 10, callButton.y);
			messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
			messageButton.addEventListener(Event.TRIGGERED, onMessageClick);
			//callButton.setSize(UiGenerator.getInstance().fieldHeight-20, UiGenerator.getInstance().fieldHeight-20);
			addChild(messageButton);
			
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