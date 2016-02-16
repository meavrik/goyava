package panels 
{
	import assets.AssetsHelper;
	import com.gamua.flox.AuthenticationType;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import data.GlobalDataProvider;
	import entities.enum.MessageTypeEnum;
	import entities.MessageEntity;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Radio;
	import feathers.controls.TextInput;
	import feathers.core.ToggleGroup;
	import feathers.data.ListCollection;
	import feathers.skins.StyleNameFunctionStyleProvider;
	import log.Logger;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import ui.buttons.CloseButton;
	import ui.UiGenerator;
	
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
			
			_addressInput = new TextInput();
			_addressInput.prompt = "כתובת";
			_addressInput.setSize(UiGenerator.getInstance().fieldWidth/2-10, UiGenerator.getInstance().fieldHeight);
			//_addressInput.move(0, _nameInput.bounds.y);
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
			
			/*var group:ButtonGroup = new ButtonGroup();
			group.buttonInitializer = function( button:Button, item:Object ):void
			{
				button.label = item.label;
				// button.labelOffsetY = -50;
				 //button.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
				button.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 7));
				//button.iconPosition = Button.ICON_POSITION_BOTTOM
				button.iconPosition = Button.ICON_POSITION_LEFT
			};
			
			//group.direction = ButtonGroup.DIRECTION_HORIZONTAL
			group.customButtonStyleName = Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON;
			group.dataProvider = new ListCollection(
			 [
				 { label: "התחבר", triggered: onLoginClick },
				 { label: "כנס", triggered: onLoginClick },
				 //{ label: "אורח", triggered: register_triggeredHandler },
			 ]);
			 addChild( group );
			group.setSize(UiGenerator.getInstance().fieldWidth, 250);
			group.move(0, _phoneInput.bounds.bottom+10);*/
			
			
			var loginButn:Button = new Button();
			loginButn.addEventListener(Event.TRIGGERED, onLoginClick);
			loginButn.label = "כניסה";
			loginButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			loginButn.move(0, _phoneInput.bounds.bottom + 10);
			loginButn.setSize(UiGenerator.getInstance().fieldWidth, 120);
			addChild(loginButn);
			
			var loginFBButn:Button = new Button();
			loginFBButn.addEventListener(Event.TRIGGERED, onLoginClick);
			loginFBButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			//loginFBButn.label = "התחבר";
			loginFBButn.move(0, loginButn.bounds.bottom + 10);
			loginFBButn.setSize(UiGenerator.getInstance().fieldWidth, 120);
			loginFBButn.defaultIcon=new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 7));
			loginFBButn.iconPosition = Button.ICON_POSITION_LEFT;
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
			trace("111111");
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
		
		/*protected function customHeaderFactory():Header 
		{
			var header:Header = new Header();
			var helpButton:Button = new Button();
			//helpButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			helpButton.label = "?";
			helpButton.addEventListener(Event.TRIGGERED, onHelpClick);
			
			var closeButton:CloseButton = new CloseButton(onCloseClick);
			
			//header.leftItems = new <DisplayObject>[helpButton];
			header.leftItems = new <DisplayObject>[closeButton];
			return header
		}*/
		
		private function onCloseClick(e:Event):void 
		{
			removeFromParent(true);
		}
		
	}

}