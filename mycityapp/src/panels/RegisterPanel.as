package panels 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Player;
	import data.GlobalDataProvider;
	import entities.MessageEntity;
	import entities.enum.MessageTypeEnum;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import flash.geom.Rectangle;
	import log.Logger;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import ui.UiGenerator;
	import ui.buttons.CloseButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class RegisterPanel extends Panel 
	{
		static public const RESTORE_LOGIN:String = "restoreLogin";
		private var _nameInput:TextInput;
		private var _addressInput:TextInput;
		//private var _loginButton:Button;
		private var _detailsInput:TextInput;
		private var _mailInput:TextInput;
		private var _loginBackButton:Button;
		private var _isCityzenCB:Check;
		private var _phoneInput:TextInput;
		
		public function RegisterPanel() 
		{
			super();
			title = "ברוך הבא לאבן יהודה"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			this.headerFactory = customHeaderFactory
			
			var rect:Rectangle = new Rectangle(10, 0, stage.stageWidth - 80, 30);
			//var label1:GLabel = new GLabel(rect);
			var label1:Label = new Label();
			label1.text = "הזן מספר פרטים מזהים והיכנס למערכת";
			label1.setSize(rect.width, rect.height);
			addChild(label1);
			
			_addressInput = new TextInput();
			_addressInput.prompt = "כתובת";
			_addressInput.setSize(UiGenerator.getInstance().fieldWidth/2-10, UiGenerator.getInstance().fieldHeight);
			_addressInput.move(0, label1.bounds.bottom + 10);
			addChild(_addressInput);
			
			_nameInput = new TextInput();
			_nameInput.move(_addressInput.bounds.right+10, _addressInput.bounds.y);
			_nameInput.prompt = "שם תושב*";
			_nameInput.setSize(UiGenerator.getInstance().fieldWidth/2-10, UiGenerator.getInstance().fieldHeight);
			addChild(_nameInput);
			
			_mailInput = new TextInput();
			_mailInput.move(0, _addressInput.bounds.bottom + 10);
			_mailInput.prompt = "דוא''ל";
			_mailInput.restrict = "a-z";
			_mailInput.setSize(UiGenerator.getInstance().fieldWidth/2-10, UiGenerator.getInstance().fieldHeight);
			addChild(_mailInput);
			
			_phoneInput = new TextInput();
			_phoneInput.restrict = "0-9";
			_phoneInput.move(_mailInput.bounds.right+10, _mailInput.y);
			_phoneInput.prompt = "טלפון";
			_phoneInput.setSize(UiGenerator.getInstance().fieldWidth/2-10, UiGenerator.getInstance().fieldHeight);
			addChild(_phoneInput);
			
			
			var loginButn:Button = new Button();
			loginButn.addEventListener(Event.TRIGGERED, onLoginClick);
			loginButn.label = "כניסה";
			loginButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			loginButn.move(0, _phoneInput.bounds.bottom + 10);
			loginButn.setSize(UiGenerator.getInstance().fieldWidth, 120);
			loginButn.iconPosition = Button.ICON_POSITION_RIGHT
			loginButn.horizontalAlign = Button.HORIZONTAL_ALIGN_RIGHT;
			addChild(loginButn);
			
			
			//var label2:GLabel = new GLabel(rect);
			var label2:Label = new Label();
			label2.move(0,loginButn.bounds.bottom + 10);
			label2.text = "או פשוט התחבר בעזרת הפייסבוק";
			label2.setSize(rect.width, rect.height);
		
			//label2.x = this.width - label2.textRendererProperties.textWidth;
			addChild(label2);
			
			
			var loginFBButn:Button = new Button();
			loginFBButn.addEventListener(Event.TRIGGERED, onLoginClick);
			loginFBButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			loginFBButn.label = "כניסה בעזרת";
			loginFBButn.move(0, label2.bounds.bottom + 10);
			loginFBButn.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 7));
			//loginFBButn.iconPosition = Button.ICON_POSITION_RIGHT
			loginFBButn.horizontalAlign = Button.HORIZONTAL_ALIGN_RIGHT;
			loginFBButn.paddingRight = 2;
			loginFBButn.iconOffsetX = 2;
			loginFBButn.setSize(UiGenerator.getInstance().fieldWidth, 120);
			addChild(loginFBButn);
			
			_isCityzenCB = new Check();
			_isCityzenCB.label = "אני תושב העיר";
			_isCityzenCB.iconPosition = Check.ICON_POSITION_RIGHT;
			_isCityzenCB.move(stage.stageWidth - 300, loginFBButn.bounds.bottom + 10);
			_isCityzenCB.isSelected = true;
			addChild(_isCityzenCB);
		}
		
		private function register_triggeredHandler():void 
		{
			
		}
		
		private function onLoginBackClick(e:Event):void 
		{
			if (_mailInput.text)
			{
				//dispatchEventWith(RESTORE_LOGIN)
				Player.loginWithEmail(_mailInput.text, onLoginBackComplete, onLoginFail);
			}
			else
			{
				var label:Label = new Label();
				label.text = "אנא הזן כתובת דוא''ל";
				Callout.show( label, _mailInput);
			}
		}
		
		private function onLoginBackComplete():void 
		{
			trace("onLoginBackComplete ");
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onLoginClick(e:Event):void 
		{
			if (_nameInput.text)
			{
				_nameInput.isEnabled = false;
				_mailInput.isEnabled = false;
				_addressInput.isEnabled = false;
				//_detailsInput.isEnabled = false;
				isEnabled = false;
				//_loginButton.isEnabled = false;
			
				GlobalDataProvider.myUserData.name = _nameInput.text;
				GlobalDataProvider.myUserData.address = _addressInput.text;
				GlobalDataProvider.myUserData.email = _mailInput.text;
				GlobalDataProvider.myUserData.phoneNumber = _phoneInput.text;
				//GlobalDataProvider.myUserData.details = _detailsInput.text;
				GlobalDataProvider.myUserData.score = 10;
				GlobalDataProvider.myUserData.save(onLoginSuccess, onLoginFail);
				
				if (_isCityzenCB.isSelected)
				{
					var messageEntity:MessageEntity = new MessageEntity();
					messageEntity.createNewMessage(GlobalDataProvider.myUserData.id, GlobalDataProvider.myUserData.name, "ברוך הבא", "מברך אותך על הצארפותך לקהילה", MessageTypeEnum.SYSTEM);
					messageEntity.save(null, null);
				}
			} else
			{
				var label:Label = new Label();
				label.text = "בשביל להצטרף הנך חייב להכניס שם למערכת";
				Callout.show( label, _nameInput);
			}
		}
		
		/*protected function customFooterFactory():Header 
		{
			var footer:Header = new Header();
			var loginButton:Button = new Button();
			loginButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON)
			loginButton.label = "הצטרף";
			loginButton.addEventListener(Event.TRIGGERED, onLoginClick);
			addChild(loginButton);
			footer.rightItems = new <DisplayObject>[loginButton];
			
			var loginBackButton:Button = new Button();
			loginBackButton.label = "התחבר";
			loginBackButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			loginBackButton.addEventListener(Event.TRIGGERED, onLoginBackClick);
			addChild(loginBackButton);
			footer.leftItems = new <DisplayObject>[loginBackButton];
			
			return footer
		}
		
		
		
		private function onHelpClick(e:Event):void 
		{
			
		}*/
		
		private function onLoginFail(message:String):void 
		{
			//_loginButton.isEnabled = true;
			Logger.logError("Login fail " + message);
		}
		
		private function onLoginSuccess():void 
		{
			Logger.logEvent("Login Success ");
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function customHeaderFactory():Header 
		{
			var header:Header = new Header();
			/*var helpButton:Button = new Button();
			//helpButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			helpButton.label = "?";
			helpButton.addEventListener(Event.TRIGGERED, onHelpClick);*/
			
			var closeButton:CloseButton = new CloseButton(onCloseClick);
			
			//header.leftItems = new <DisplayObject>[helpButton];
			header.leftItems = new <DisplayObject>[closeButton];
			return header
		}
		
		private function onCloseClick(e:Event):void 
		{
			removeFromParent(true);
		}
		
	}

}