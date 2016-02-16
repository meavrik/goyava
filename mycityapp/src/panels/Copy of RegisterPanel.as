package panels 
{
	import com.gamua.flox.AuthenticationType;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import data.GlobalDataProvider;
	import entities.enum.MessageTypeEnum;
	import entities.MessageEntity;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.skins.StyleNameFunctionStyleProvider;
	import log.Logger;
	import starling.display.DisplayObject;
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
		
		public function RegisterPanel() 
		{
			super();
			title = "ברוך הבא לאבן יהודה"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			
			_nameInput = new TextInput();
			_nameInput.move(0, 10);
			_nameInput.prompt = "שם תושב*";
			_nameInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(_nameInput);
			
			_addressInput = new TextInput();
			_addressInput.prompt = "כתובת";
			_addressInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			_addressInput.move(0, _nameInput.bounds.bottom + 10);
			addChild(_addressInput);
			
			_detailsInput = new TextInput();
			_detailsInput.prompt = "עוד קצת פרטים עלי";
			_detailsInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight * 2);
			_detailsInput.move(0, _addressInput.bounds.bottom + 20);
			addChild(_detailsInput);
			
			_mailInput = new TextInput();
			_mailInput.move(0, _detailsInput.bounds.bottom + 10);
			_mailInput.prompt = "(דוא''ל (לשם שיחזור חשבון*";
			_mailInput.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(_mailInput);
			
			this.headerFactory = customHeaderFactory;
			this.footerFactory = customFooterFactory;
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
				_detailsInput.isEnabled = false;
				isEnabled = false;
				//_loginButton.isEnabled = false;
			
				GlobalDataProvider.myUserData.name = _nameInput.text;
				GlobalDataProvider.myUserData.address = _addressInput.text;
				GlobalDataProvider.myUserData.details = _detailsInput.text;
				GlobalDataProvider.myUserData.score = 10;
				GlobalDataProvider.myUserData.save(onLoginSuccess, onLoginFail);
				
				
				
				var messageEntity:MessageEntity = new MessageEntity();
				messageEntity.createNewMessage(GlobalDataProvider.myUserData.id, GlobalDataProvider.myUserData.name, "ברוך הבא", "מברך אותך על הצארפותך לקהילה", MessageTypeEnum.SYSTEM);
				messageEntity.save(null, null);
			} else
			{
				var label:Label = new Label();
				label.text = "בשביל להצטרף הנך חייב להכניס שם למערכת";
				Callout.show( label, _nameInput);
			}
		}
		
		protected function customFooterFactory():Header 
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
			
		}
		
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
			var helpButton:Button = new Button();
			//helpButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			helpButton.label = "?";
			helpButton.addEventListener(Event.TRIGGERED, onHelpClick);
			
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