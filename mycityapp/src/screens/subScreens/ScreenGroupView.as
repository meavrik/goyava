package screens.subScreens 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import entities.GroupEntity;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import panels.MessagePanelSend;
	import popups.PopupsController;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import ui.UiGenerator;
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenGroupView extends PanelScreen
	{
		private var _friendsList:GroupedList;
		private var _dataProvider:GroupEntity;
		private var _joinButton:Button;
		private var _detailLabel:Label;
		private var _commonData:Object;
		
		public function ScreenGroupView(commonData:Object)
		{
			super();
			_commonData = commonData;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this.footerFactory = customFooterFactory;
			
			_detailLabel = new Label();
			_detailLabel.wordWrap = true;
			_detailLabel.move(5, 10);
			_detailLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			_detailLabel.setSize(this.stage.stageWidth-10, 50);
			addChild(_detailLabel)
			
			_joinButton = new Button();
			
			_joinButton.x = 10;
			_joinButton.setSize(this.stage.stageWidth - 20,  UiGenerator.getInstance().buttonHeight);
			//_joinButton.label = "בקש להצטרף";
			//_joinButton.addEventListener(Event.TRIGGERED, onJoinClick);
			_joinButton.isEnabled = false;
			
			_friendsList = new GroupedList();
			
	 
			 this._friendsList.dataProvider = new HierarchicalCollection(
				[
					{
						header: "חברים בקבוצה",
						children:[]
					},
				]);
				
				
			_friendsList.move(5, _detailLabel.bounds.bottom);
			_friendsList.itemRendererProperties.iconSourceFunction = function(item:Object):String
			{
				return "https://graph.facebook.com/v2.2/665289619/picture?type=square";
			}
			
			setSize(stage.stageWidth, stage.stageHeight / 2);
			_friendsList.setSize(this.stage.stageWidth - 10, this.height - _friendsList.y-180);
			
			if (_commonData)
			{
				title = _commonData.name;
				Entity.load(GroupEntity, _commonData.id, onLoadDataComplete, onLoadDataFail);
			}
		}
		
		private function onLoadDataFail(message:String):void 
		{
			Flox.logInfo("onLoadDataFail " +message);
		}
		
		private function onLoadDataComplete(groupData:GroupEntity):void 
		{
			this._dataProvider = groupData;
			_detailLabel.text = this._dataProvider.description;
			var isPartOfTheGroup:Boolean;
			var txt:String;
			title = "(" + _dataProvider.members.length + ")" + groupData.name;
			
			
			var indexCount:int = 0;
			_friendsList.itemRendererFactory = function():IGroupedListItemRenderer
			 {
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.labelField = "text";
				renderer.height = 60;
				trace("index == " + _dataProvider.members[indexCount].id);

				renderer.data = _dataProvider.members[indexCount];
				renderer.itemIndex = indexCount;
				indexCount++;
				 
				var messageButton:Button = new Button();
				messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
				messageButton.move(stage.stageWidth-100, 5);
				messageButton.setSize(80, 50);
				messageButton.addEventListener(Event.TRIGGERED, onMessageClick);
				renderer.addChild(messageButton);
				 
				var phoneButton:Button = new Button();
				phoneButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
				phoneButton.setSize(80, 50);
				phoneButton.move(stage.stageWidth-190, 5);
				phoneButton.addEventListener(Event.TRIGGERED, onPhoneClick);
				renderer.addChild(phoneButton);
				
				return renderer;
			 };
			
			
			
			
			
			
			
			
			for (var i:int = 0; i < _dataProvider.members.length; i++) 
			{
				var item:Object = _dataProvider.members[i];
				if (item.name)
				{
					txt = item.name;
					if (item.id == groupData.ownerId)
					{
						txt = item.name + " - מנהל הקבוצה";
					}
					this._friendsList.dataProvider.data[0].children.push( { text:txt } );
				}
				
				if (item.id == GlobalDataProvider.userPlayer.id)
				{
					
					isPartOfTheGroup = true;
				}
			}
			
			if (isPartOfTheGroup)
			{
				_joinButton.label = "שלח הודעה לכולם";
				_joinButton.addEventListener(Event.TRIGGERED, onSendAllMessageClick);
			} else
			{
				_joinButton.label = "בקש להצטרף";
				_joinButton.addEventListener(Event.TRIGGERED, onJoinClick);
			}
			
			_joinButton.isEnabled = true;
			addChild(_friendsList);
		}
		
		
		
		private function onPhoneClick(e:Event):void 
		{
			
		}
		
		private function onMessageClick(e:Event):void 
		{
			var renderer:DefaultGroupedListItemRenderer = Button(e.currentTarget).parent as DefaultGroupedListItemRenderer;
			//trace("AAAAAAAAAA === " + renderer.itemIndex);
			//trace("AAAAAAAAAA === " + renderer.data.name);
			var messagePanel:MessagePanelSend = new MessagePanelSend(_dataProvider.members[renderer.itemIndex].id,_dataProvider.members[renderer.itemIndex].name);
			PopupsController.addPopUp(messagePanel);
		}
		
		private function onSendAllMessageClick(e:Event):void 
		{
			//var messagePanel:MessagePanelSend = new MessagePanelSend();
			//PopupsController.addPopUp(messagePanel);
		}
		
		protected function customFooterFactory():Header 
		{
			//addChild(_joinButton);
			var footer:Header = new Header()
			footer.rightItems = new <DisplayObject>[_joinButton];
			return footer
		}
		
		private function onJoinClick(e:Event):void 
		{
			this._dataProvider.addMeToGroup();
			_joinButton.isEnabled = false;
			var alert:Alert = Alert.show("הבקשה נשלחה", "הקבוצה", new ListCollection(
			[
				{ label: "סבבה" },
				//{ label: "Cancel" }
			]));
			alert.width = this.width - 40;
			alert.addEventListener(Event.CLOSE, alert_closeHandler);
			
			GlobalDataProvider.userPlayer.myGroups.push(this._dataProvider.name);
			GlobalDataProvider.userPlayer.save(null, null);
		}
		
		private function alert_closeHandler(e:Event):void 
		{
			
		}
		
	}

}