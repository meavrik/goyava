package panels 
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.filesystem.File;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class addItemPanel extends Panel 
	{
		private var _inputLabel:TextInput;
		private var _addButton:Button;
		private var _priceLabel:TextInput;
		private var _commentLabel:TextInput;
		private var _imageLoader:ImageLoader;
		
		public function addItemPanel() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			title = "הוספת פריט חדש";
			var fieldHeight:Number = 60;
			var fieldWidth:Number = this.stage.stageWidth - 60;
			
			_inputLabel = new TextInput();
			_inputLabel.move(10, 20);
			_inputLabel.prompt = "שם הפריט";
			_inputLabel.setSize(fieldWidth, fieldHeight);
			addChild(_inputLabel);
			
			var currencyLabel:Label = new Label();
			currencyLabel.text = "₪";
			currencyLabel.move(10, _inputLabel.bounds.bottom + 25);
			addChild(currencyLabel);
			
			_priceLabel = new TextInput();
			_priceLabel.move(40, _inputLabel.bounds.bottom + 10);
			_priceLabel.prompt = "מחיר";
			_priceLabel.setSize(fieldWidth / 2 - 35, fieldHeight);
			addChild(_priceLabel);
			
			
			
			var uploadImgButton:Button = new Button();
			uploadImgButton.label = "הוסף תמונה";
			uploadImgButton.move(_priceLabel.bounds.right + 10, _priceLabel.bounds.top);
			uploadImgButton.setSize(fieldWidth / 2 - 5, fieldHeight);
			addChild(uploadImgButton);
			
			_commentLabel = new TextInput();
			_commentLabel.move(10, _priceLabel.bounds.bottom + 10);
			_commentLabel.prompt = "פרטים נוספים";
			_commentLabel.setSize(fieldWidth, fieldHeight * 2);
			addChild(_commentLabel);
			
			var phoneLabel:TextInput = new TextInput();
			phoneLabel.move(10, _commentLabel.bounds.bottom + 20);
			phoneLabel.setSize(fieldWidth / 2 - 5, fieldHeight);
			phoneLabel.prompt = "טלפון";
			addChild(phoneLabel);
			
			var mailLabel:TextInput = new TextInput();
			mailLabel.move(phoneLabel.bounds.right + 10, phoneLabel.bounds.top);
			mailLabel.setSize(fieldWidth / 2 - 5, fieldHeight);
			mailLabel.prompt = "דוא''ל";
			addChild(mailLabel);
			
			
			_addButton = new Button();
			_addButton.label = "פרסם פריט למכירה";
			addChild(_addButton);
			_addButton.setSize(fieldWidth, fieldHeight);
			_addButton.move(10, mailLabel.bounds.bottom + 10);
			

			/*_imageLoader = new ImageLoader()
			addChild(_imageLoader);
			
			var cameraRoll:CameraRoll = new CameraRoll();
 
			if( CameraRoll.supportsBrowseForImage )
			{
				cameraRoll.addEventListener( MediaEvent.SELECT, imageSelected );
				//cameraRoll.addEventListener( Event.CANCEL, browseCanceled );
				//cameraRoll.addEventListener( ErrorEvent.ERROR, mediaError );
				cameraRoll.browseForImage();
			}
			else
			{
				trace( "Image browsing is not supported on this device.");
			} */
			
			this.width = this.stage.stageWidth-20;
		}
		
		private function imageSelected(e:MediaEvent):void 
		{
			
		}
		
	}

}