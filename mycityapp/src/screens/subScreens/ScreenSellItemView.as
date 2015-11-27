package screens.subScreens 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Entity;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import flash.events.ErrorEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import helpers.FormatHelper;
	import progress.WaitPreloader;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenSellItemView extends PanelScreen
	{
		private var _dataProvider:Object;
		private var _firstData:Object;
		private var _label:Label;
		private var _label2:Label;
		private var _imageLoader:ImageLoader;
		private var _preloader:WaitPreloader;
		
		public function ScreenSellItemView(firstData:Object) 
		{
			super();
			this._firstData = firstData;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setSize(stage.stageWidth, stage.stageHeight / 2);
			var size:Number = stage.stageWidth / 2 - 10;;
			var quad:Quad = new Quad(size, size/2, 0xcccccc);
			addChild(quad);
			quad.x = quad.y = 5;
			
			_imageLoader = new ImageLoader();
			_imageLoader.width = _imageLoader.height = size
			_imageLoader.height = size / 2;
			//_imageLoader.verticalAlign = ImageLoader.VERTICAL_ALIGN_TOP;
			//_imageLoader.scaleContent = false;
			addChild(_imageLoader);
			_imageLoader.move(5, 5);
			
			_label = new Label();
			_label.move(_imageLoader.bounds.right + 10, _imageLoader.y);
			_label.setSize(this.stage.stageWidth - _label.x, _imageLoader.bounds.height);
			addChild(_label);
			
			_label2 = new Label();
			_label2.y = 100;
			
			this.footerFactory = customFooterFactory;
			
			title = _firstData.name;
			_label.text = _firstData.name+" ב" + FormatHelper.getMoneyFormat(_firstData.price, GlobalDataProvider.currencySign) + "\n";
			_label.styleNameList.add(Label.ALTERNATE_NAME_HEADING);

			if (_firstData.description)
			{
				_label.text += _firstData.description + "\n";
			}
			
			_preloader = new WaitPreloader();
			_preloader.x = _imageLoader.width / 2;
			_preloader.y = _imageLoader.height / 2;
			addChild(_preloader);
			//_label2.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
			_label2.text = "עודכן ב" + FormatHelper.getDate(_firstData.created);
			
			Entity.load(SellItemEntity, _firstData.id, onLoadDataComplete, onLoadDataError)
		}
		
		private function onLoadDataError(message:String):void 
		{
			
		}
		
		private function onLoadDataComplete(entity:SellItemEntity):void 
		{
			/*try
			{
				var arr:Array = entity.pictures;
				if (arr)
				{
					var bmdata:BitmapData = BitmapEncoder.decodeByteArray(arr[0])
					
					var img:Image = new Image(Texture.fromBitmapData(bmdata))

					addChild(img);
				}s
			}
			catch (err:Error)
			{
				Logger.logError("add picture error " + err.message);
			}*/
			
			_imageLoader.addEventListener(Event.COMPLETE, onImageLoadComplete);
			_imageLoader.addEventListener(ErrorEvent.ERROR, onImageLoadError);
			_imageLoader.source = AssetsHelper.SERVER_ASSETS_URL + "secondhand/table1.jpg";
			
		}
		
		private function onImageLoadError(e:Event):void 
		{
			_imageLoader.removeEventListener(Event.COMPLETE, onImageLoadComplete);
			_imageLoader.removeEventListener(ErrorEvent.ERROR, onImageLoadError);
			if (_preloader)
			{
				_preloader.removeFromParent(true);
			}
		}
		
		private function onImageLoadComplete(e:Event):void 
		{
			_imageLoader.removeEventListener(Event.COMPLETE, onImageLoadComplete);
			_imageLoader.removeEventListener(ErrorEvent.ERROR, onImageLoadError);
			if (_preloader)
			{
				_preloader.removeFromParent(true);
			}
		}
		
		protected function customFooterFactory():Header 
		{
			var butnWidth:Number = (this.stage.stageWidth - 20) / 3;
			
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
			header.leftItems = new <DisplayObject>[_label2];
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
		
		override public function dispose():void 
		{
			if (_imageLoader)
			{
				_imageLoader.removeFromParent(true);
				_imageLoader = null;
			}
			super.dispose();
		}
		
		
	}

}