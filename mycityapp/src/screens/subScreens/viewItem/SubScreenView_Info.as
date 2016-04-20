package screens.subScreens.viewItem 
{
	import assets.AssetsHelper;
	import entities.BusinessEntity;
	import entities.SellItemEntity;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import flash.events.ErrorEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import progress.WaitPreloader;
	import screens.components.ImageLoaderComponent;
	import screens.components.ImageLoaderComponent;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import ui.buttons.CallButton;
	import ui.buttons.MailButton;
	/**
	 * ...
	 * @author Avrik
	 */
	public class SubScreenView_Info extends SubScreenView 
	{
		private var _dataProvider:Object;
		private var _imgLoader:ImageLoaderComponent;
		private var _label:Label;
		
		public function SubScreenView_Info(dataProvider:Object) 
		{
			super();
			this._dataProvider = dataProvider;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = _dataProvider.name;
			
			_imgLoader = new ImageLoaderComponent("http://www.ishi-moto.co.il/images/GalB_20140607_11370138_4.jpg");
			addChild(_imgLoader);
			_imgLoader.init();
			
			if (_dataProvider.description)
			{
				_label = new Label();
				_label.move(10, _imgLoader.bounds.bottom + 5);
				_label.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
				addChild(_label);
				_label.text = _dataProvider.description;
			}
			
			this.headerFactory = customHeaderFactory
		}
		
		protected function customHeaderFactory():Header 
		{
			var header:Header = new Header()
			var callButton:CallButton = new CallButton(onCallClick);
			
			header.rightItems = new <DisplayObject>[callButton];
			return header
		}
		
		private function onCallClick(e:Event):void 
		{
			if (this._dataProvider && this._dataProvider.phone)
			{
				const callURL:String = "sms:" + this._dataProvider.phone;
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