package screens.subScreens.viewItem 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import helpers.FormatHelper;
	import screens.components.ImageLoaderComponent;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.buttons.CallButton;
	import ui.buttons.MailButton;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class SubScreenView_SellItem extends SubScreenView
	{
		private var _dataProvider:SellItemEntity;
		private var _label:Label;
		private var _label2:Label;
		private var _imgLoader:ImageLoaderComponent;
		
		
		public function SubScreenView_SellItem(dataProvider:SellItemEntity) 
		{
			super();
			this._dataProvider = dataProvider;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_imgLoader = new ImageLoaderComponent(AssetsHelper.SERVER_ASSETS_URL + "secondhand/table1.jpg");
			addChild(_imgLoader);
			_imgLoader.init();
			
			_label = new Label();
			_label.move(10, _imgLoader.bounds.bottom + 5);
			addChild(_label);
			
			_label2 = new Label();
			_label2.y = 100;
			
			this.footerFactory = customFooterFactory;
			this.headerFactory = customHeaderFactory
			title = _dataProvider.name;
			_label.text = _dataProvider.name+" ב" + FormatHelper.getMoneyFormat(_dataProvider.price, GlobalDataProvider.currencySign) + "\n";
			_label.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);

			if (_dataProvider.description)
			{
				_label.text += _dataProvider.description + "\n";
			}
			
			//_label2.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
			_label2.text = "עודכן ב" + FormatHelper.getDate(_dataProvider.updatedAt.time);
		}
		
		protected function customHeaderFactory():Header 
		{
			var header:Header = new Header()
			
			
			/*var messageButton:Button = new Button();
			messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
			messageButton.addEventListener(Event.TRIGGERED, onMessageClick);*/

			//header.leftItems = new <DisplayObject>[callButton,mailButton];
			return header
		}
		
		protected function customFooterFactory():Header 
		{
			var header:Header = new Header()

			var callButton:CallButton = new CallButton(onCallClick);
			var mailButton:MailButton = new MailButton(onMailClick);
			
			header.rightItems = new <DisplayObject>[callButton,mailButton];
			header.leftItems = new <DisplayObject>[_label2];
			return header
		}
		
		private function onCallClick(e:Event):void 
		{
			if (this._dataProvider && this._dataProvider.phone)
			{
				const callURL:String = "tel:" + this._dataProvider.phone;
				var targetURL:URLRequest = new URLRequest(callURL);
				navigateToURL(targetURL);
			}
		}
		
		private function onMessageClick(e:Event):void 
		{
			if (this._dataProvider && this._dataProvider.phone)
			{
				const callURL:String = "sms:" + this._dataProvider.phone;
				var targetURL:URLRequest = new URLRequest(callURL);
				navigateToURL(targetURL);
			}
		}
		
		private function onMailClick(e:Event):void 
		{
			if (this._dataProvider && this._dataProvider.email)
			{
				const callURL:String = "mailto:" + this._dataProvider.email;
				var targetURL:URLRequest = new URLRequest(callURL);
				navigateToURL(targetURL);
			}
		}
		
		override public function dispose():void 
		{
			if (_imgLoader)
			{
				_imgLoader.removeFromParent(true);
				_imgLoader = null;
			}
			
			super.dispose();
		}
		
		
	}

}