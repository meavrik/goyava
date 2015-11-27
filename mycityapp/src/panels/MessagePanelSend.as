package panels 
{
	import entities.MessageEntity;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import log.Logger;
	import starling.events.Event;
	import starling.display.DisplayObject;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MessagePanelSend extends BasePopupPanel 
	{
		private var _messageLabel:TextInput;
		private var _titleLabel:TextInput;
		private var _sendButn:Button;
		private var _toUserId:String;
		private var _toUserName:String;
		
		public function MessagePanelSend(toUserId:String,toUserName:String="") 
		{
			super();
			this._toUserName = toUserName;
			this._toUserId = toUserId;
			title = "כתוב הודעה";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			footerFactory = customFooterFactory;
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			_titleLabel = new TextInput();
			_titleLabel.prompt = "כותרת";
			_titleLabel.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight);
			_titleLabel.move(5, 5);
			addChild(_titleLabel);
			
			_messageLabel = new TextInput();
			_messageLabel.prompt = "תוכן ההודעה";
			_messageLabel.move(_titleLabel.x, _titleLabel.bounds.bottom + 10);
			_messageLabel.setSize(UiGenerator.getInstance().fieldWidth, UiGenerator.getInstance().fieldHeight * 6);
			addChild(_messageLabel);
			
			width = this.stage.stageWidth - 20;
		}
		
		protected function customFooterFactory():Header 
		{
			var footer:Header = new Header();
			_sendButn = new Button();
			_sendButn.label = "שלח";
			_sendButn.x = 10;
			_sendButn.setSize(this.stage.stageWidth - 20,  UiGenerator.getInstance().buttonHeight);
			_sendButn.addEventListener(Event.TRIGGERED, onSendClick);
			addChild(_sendButn);
			footer.rightItems = new <DisplayObject>[_sendButn];
			
			return footer
		}
		
		private function onSendClick(e:Event):void 
		{
			sendMessage();
			
			this.isEnabled = false;
			_sendButn.isEnabled = false;
		}
		
		private function sendMessage():void 
		{
			var messageEntity:MessageEntity = new MessageEntity();
			messageEntity.createNewMessage(this._toUserId, this._toUserName, _titleLabel.text, _messageLabel.text);
			messageEntity.save(onSaveMessageSuccess, onSaveMessageFail);
			
		}
		
		private function onSaveMessageFail():void 
		{
			Logger.logError(this, "save message failed");
			
			_sendButn.isEnabled = true;
		}
		
		private function onSaveMessageSuccess():void 
		{
			var alert:Alert = Alert.show("ההודעה נשלחה בהצלחה",null, new ListCollection(
			[
				{ label: "סבבה" },
			]));
			alert.width = this.width - 40;
			closeMe();
		}
		
		
		
	}

}