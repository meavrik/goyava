package login 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.TextInput;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LoginMainScreen3 extends LoginMainBase 
	{
		private var _addressInput:TextInput;
		private var _phoneInput:TextInput;
		private var _mailInput:TextInput;
		
		public function LoginMainScreen3() 
		{
			super();

		}
		
		override protected function initialize():void 
		{
			super.initialize();

			title = "פרטי התקשרות";
			_nextButton.label = "זהו!";

			_addressInput = new TextInput();
			_addressInput.prompt = "כתובת";
			_addressInput.setSize(stage.stageWidth -80, 100);
			_addressInput.defaultIcon = AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.BUTTON_ICONS, 0, .5);
			_addressInput.move((stage.stageWidth - _addressInput.width) / 2,  _nextButton.bounds.top  - _addressInput.height - FIELDS_GAP);
			addChild(_addressInput);
			
			
			_phoneInput = new TextInput();
			_phoneInput.defaultIcon = AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.BUTTON_ICONS, 2, .5);
			_phoneInput.prompt = "טלפון";
			_phoneInput.setSize(stage.stageWidth -80, 100);
			_phoneInput.move((stage.stageWidth - _phoneInput.width) / 2,  _addressInput.bounds.top  - _phoneInput.height - FIELDS_GAP);
			addChild(_phoneInput);
			
			_mailInput = new TextInput();
			_mailInput.prompt = "דוא''ל*";
			_mailInput.defaultIcon = AssetsHelper.getInstance().getImageFromTexture(AssetsHelper.BUTTON_ICONS, 1, .5);
			_mailInput.setSize(stage.stageWidth -80, 100);
			_mailInput.move((stage.stageWidth - _mailInput.width) / 2,  _phoneInput.bounds.top  - _mailInput.height - FIELDS_GAP);
			addChild(_mailInput);
			
			headerFactory = customHeaderFactory;
		}
		
		override protected function onNextClick(e:Event):void 
		{
			super.onNextClick(e);
			
			GlobalDataProvider.myUserData.address = _addressInput.text;
			GlobalDataProvider.myUserData.email = _mailInput.text;
			GlobalDataProvider.myUserData.phoneNumber = _phoneInput.text;
			GlobalDataProvider.myUserData.save(null, null);
				
			dispatchEventWith(Event.COMPLETE,true);
		}
		
		
	}

}