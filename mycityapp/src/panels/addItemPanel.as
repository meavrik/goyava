package panels 
{
	import com.gamua.flox.Flox;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import data.GlobalDataProvider;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import media.CameraHelper;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class AddItemPanel extends BasePopupFormPanel 
	{
		private var _itemNameLabel:TextInput;
		private var _addButton:Button;
		private var _priceLabel:TextInput;
		private var _detailsLabel:TextInput;
		//private var _imageLoader:ImageLoader;
		private var _phoneLabel:TextInput;
		private var _mailLabel:TextInput;
		private var _cameraHelper:CameraHelper;
		private var uploadImgButton:Button;
		private var _img1:Image;
		private var _img2:Image;
		private var uploadImgButton2:Button;
		private var _img1BitmapData:BitmapData;
		
		public function AddItemPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "הוספת פריט חדש";
			var fieldHeight:Number = UiGenerator.getInstance().fieldHeight
			var fieldWidth:Number = UiGenerator.getInstance().fieldWidth;
			
			_itemNameLabel = new TextInput();
			_itemNameLabel.move(10, 20);
			_itemNameLabel.prompt = "שם הפריט";
			_itemNameLabel.setSize(fieldWidth, fieldHeight);
			addChild(_itemNameLabel);
			
			var currencyLabel:Label = new Label();
			currencyLabel.text = GlobalDataProvider.currencySign;
			currencyLabel.move(10, _itemNameLabel.bounds.bottom + fieldHeight / 2);
			addChild(currencyLabel);
			
			_priceLabel = new TextInput();
			_priceLabel.move(40, _itemNameLabel.bounds.bottom + 10);
			_priceLabel.prompt = "מחיר";
			_priceLabel.setSize(fieldWidth / 2 - 35, fieldHeight);
			_priceLabel.restrict = "0-9"
			addChild(_priceLabel);
			
			uploadImgButton = new Button();
			uploadImgButton.label = "הוסף תמונה";
			uploadImgButton.move(10, _priceLabel.bounds.bottom + 10);
			uploadImgButton.setSize(fieldWidth / 2 - 5, fieldWidth / 2);
			uploadImgButton.addEventListener(Event.TRIGGERED, onUploadPhotoClick1);
			uploadImgButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addChild(uploadImgButton);
			
			uploadImgButton2 = new Button();
			uploadImgButton2.label = "הוסף תמונה";
			uploadImgButton2.move(_priceLabel.bounds.right + 10, _priceLabel.bounds.bottom + 10);
			uploadImgButton2.setSize(fieldWidth / 2 - 5, fieldWidth / 2);
			uploadImgButton2.addEventListener(Event.TRIGGERED, onUploadPhotoClick2);
			uploadImgButton2.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addChild(uploadImgButton2);
			
			_detailsLabel = new TextInput();
			_detailsLabel.move(10, uploadImgButton.bounds.bottom + 10);
			_detailsLabel.prompt = "פרטים נוספים";
			_detailsLabel.setSize(fieldWidth, fieldHeight * 2);
			addChild(_detailsLabel);
			
			_phoneLabel = new TextInput();
			_phoneLabel.move(10, _detailsLabel.bounds.bottom + 20);
			_phoneLabel.setSize(fieldWidth / 2 - 5, fieldHeight);
			_phoneLabel.prompt = "טלפון";
			_phoneLabel.restrict = "0-9"
			addChild(_phoneLabel);
			
			_mailLabel = new TextInput();
			_mailLabel.move(_phoneLabel.bounds.right + 10, _phoneLabel.bounds.top);
			_mailLabel.setSize(fieldWidth / 2 - 5, fieldHeight);
			_mailLabel.prompt = "דוא''ל";
			addChild(_mailLabel);
			
			_addButton = new Button();
			_addButton.label = "פרסם פריט למכירה";
			addChild(_addButton);
			_addButton.setSize(UiGenerator.getInstance().buttonWidth, UiGenerator.getInstance().buttonHeight);
			_addButton.move(10, _mailLabel.bounds.bottom + 10);
			_addButton.addEventListener(Event.TRIGGERED, onAddClick);
			
			this.width = this.stage.stageWidth - 20;
		}
		
		
		private function onUploadPhotoClick1(e:Event):void 
		{
			browseImages(onImg1SelectComplete)
		}
		
		private function onUploadPhotoClick2(e:Event):void 
		{
			browseImages(onImg2SelectComplete)
		}
		
		private function browseImages(callbackFunc:Function):void 
		{
			if( CameraRoll.supportsBrowseForImage)
			{
				_cameraHelper = new CameraHelper(stage, uploadImgButton.bounds);
				_cameraHelper.addEventListener(Event.COMPLETE, callbackFunc);
				_cameraHelper.browseForImage();
			}
			else
			{
				Flox.logError( "Image browsing is not supported on this device.");
			}
		}
		
		private function onImg1SelectComplete(e:Event):void 
		{
			if (_img1)
			{
				_img1.removeFromParent(true);
			}
			
			_img1 = new Image(Texture.fromBitmap(_cameraHelper.bitmap));
			_img1BitmapData = _cameraHelper.bitmap.bitmapData;
			uploadImgButton.addChild(_img1);
			
			
			var url_request:URLRequest = new URLRequest();
			url_request.url = "http://urika.avrik.com/";
			url_request.contentType = "binary/octet-stream";
			url_request.method = URLRequestMethod.POST;
			//url_request.data = myByteArray;
			url_request.data = _img1BitmapData.getPixels(new Rectangle(0, 0, 100, 100));
			/*url_request.requestHeaders.push(
			 new URLRequestHeader('Cache-Control', 'no-cache'));*/

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			// attach complete/error listeners
			loader.load(url_request);
		}
		
		private function onImg2SelectComplete(e:Event):void 
		{
			if (_img2)
			{
				_img2.removeFromParent(true);
			}
			_img2 = new Image(Texture.fromBitmap(_cameraHelper.bitmap));
			uploadImgButton2.addChild(_img2);
		}
		
		private function onAddClick(e:Event):void 
		{
			if (isValid())
			{
				//GlobalData.commonData.addSecondHand(_itemNameLabel.text, parseFloat(_priceLabel.text), _phoneLabel.text, _mailLabel.text, _detailsLabel.text);
				//var byteArr:ByteArray = _img1BitmapData.getPixels(new Rectangle(0, 0, _img1BitmapData.width, _img1BitmapData.height));
				GlobalDataProvider.secondHandDataProvier.addItem(_itemNameLabel.text, parseFloat(_priceLabel.text), _phoneLabel.text, _mailLabel.text, _detailsLabel.text);
				
				closeMe();
			}
		}
		
		private function isValid():Boolean 
		{
			if (!_itemNameLabel.text.length)
			{
				showInvalidMessage(_itemNameLabel, "אנא מלא את שם הפריט");
				return false;
			}
			
			if (!_priceLabel.text.length)
			{
				showInvalidMessage( _priceLabel, "אנא ציין מחיר");
				return false;
			}
			
			/*if (!_phoneLabel.text.length && !_mailLabel.text.length)
			{
				showInvalidMessage( _phoneLabel, "ואיך יצרו איתך קשר?");
				return false;
			}*/
			
			return true;
		}
		
		
		

		
	}

}