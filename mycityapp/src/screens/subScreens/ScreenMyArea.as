package screens.subScreens 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Player;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import events.GlobalEventController;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import log.Logger;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.UiGenerator;
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenMyArea extends ScreenSubScreenMenu 
	{
		private var nameInput:TextInput;
		private var mailInput:TextInput;
		private var addressInput:TextInput;
		private var phoneInput:TextInput;
		private var _listItem:Object;
		private var _list:GroupedList;
		private var _saveButn:Button;
		private var _logoutButn:Button;
		
		public function ScreenMyArea() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "האזור האישי";
			footerFactory = customFooterFactory;
			headerFactory = customHeaderFactory;
			
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			var fieldWidth:Number = stage.stageWidth / 2 - 10;
			nameInput = new TextInput();
			nameInput.move(stage.stageWidth / 2 + 5, 20);
			nameInput.prompt = "שם";
			nameInput.text = GlobalDataProvider.myUserData.name;
			nameInput.setSize(fieldWidth, UiGenerator.getInstance().fieldHeight);
			addChild(nameInput);
			
			addressInput = new TextInput();
			addressInput.prompt = "כתובת";
			addressInput.text = GlobalDataProvider.myUserData.address;
			addressInput.setSize(fieldWidth, UiGenerator.getInstance().fieldHeight);
			addressInput.move(nameInput.bounds.x, nameInput.bounds.bottom + 10);
			addChild(addressInput);
			
			phoneInput = new TextInput();
			phoneInput.prompt = "טלפון";
			phoneInput.text = GlobalDataProvider.myUserData.phoneNumber;
			phoneInput.setSize(fieldWidth, UiGenerator.getInstance().fieldHeight);
			phoneInput.move(10, 20);
			addChild(phoneInput);
			
			mailInput = new TextInput();
			mailInput.prompt = "דוא''ל";
			mailInput.text = GlobalDataProvider.myUserData.email;
			mailInput.setSize(fieldWidth, UiGenerator.getInstance().fieldHeight);
			mailInput.move(phoneInput.bounds.x, phoneInput.bounds.bottom + 10);
			addChild(mailInput);
			
			var toggle:ToggleSwitch = new ToggleSwitch();
			toggle.onText = "מופעל";
			toggle.offText = "כבוי";
			toggle.showThumb = true;

			toggle.move(10, addressInput.bounds.bottom + 10);
			toggle.setSize(120, UiGenerator.getInstance().buttonHeight);
			addChild(toggle);
			
			_list = new GroupedList();
			_list.itemRendererProperties.labelField = "text";
			_list.itemRendererProperties.accessoryField = "accessory";
			_list.itemRendererProperties.iconField = "icon";
			
			_listItem = [ { header: "קבוצות שלי", children:[ ] }, { header: "מודעות שלי", children:[ ] }, ];
			_listItem.icon = new ToggleSwitch();
			
			_list.dataProvider = new HierarchicalCollection(_listItem);
			_list.isSelectable = false;

			_list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.labelField = "text";
				renderer.accessoryField = "accessory";
				
				var deleteButn:Button = new Button();
				deleteButn.label = "הסר";
				deleteButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON);
				deleteButn.move(stage.stageWidth - 100, 10);
				deleteButn.addEventListener(Event.TRIGGERED, onDeleteButnClick);
				renderer.addChild(deleteButn);
				
				var editButn:Button = new Button();
				editButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
				editButn.label = "ערוך";
				editButn.move(stage.stageWidth - 190, 10);
				editButn.addEventListener(Event.TRIGGERED, onEditButnClick);
				renderer.addChild(editButn);
				renderer.itemIndex ++;
				
				return renderer;
			};
			
			_list.move(5, toggle.bounds.bottom + 10);
			//_list.setSize(this.width, this.height - _list.bounds.top);
			_list.setSize(this.stage.stageWidth -10, this.stage.stageHeight - _list.bounds.top);
			this.addChild(_list);
			
			AppDataLoader.getInstance().addEventListener(AppDataLoader.GROUPS_DATA_LOADED, onGroupsLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.SELLITEMS_DATA_LOADED, onSellItemsLoaded);
			
			showMySellItemsList();
			showMyGroupsList();
		}
		
		private function onSellItemsLoaded(e:Event):void
		{
			showMySellItemsList();
		}
		
		private function onGroupsLoaded(e:Event):void 
		{
			showMyGroupsList();
		}
		
		private function showMyGroupsList():void
		{
			_list.dataProvider.data[0].children = [];
			for (var i:int = 0; i < GlobalDataProvider.myGroups.length ; i++)
			{
				_list.dataProvider.data[0].children[i] = { text:GlobalDataProvider.myGroups[i].name, data:GlobalDataProvider.myGroups[i] };
			}
			_list.dataProvider.updateItemAt(0);
		}
		
		private function showMySellItemsList():void
		{
			_list.dataProvider.data[1].children = [];
			for (var j:int = 0; j < GlobalDataProvider.mySellItems.length; j++) 
			{
				_list.dataProvider.data[1].children[j] = { text:GlobalDataProvider.mySellItems[j].name, data:GlobalDataProvider.mySellItems[j] };
			}
			_list.dataProvider.updateItemAt(1);
		}
		
		private function onEditButnClick(e:Event):void 
		{
			
		}
		
		private function onDeleteButnClick(e:Event):void 
		{
			var renderer:DefaultGroupedListItemRenderer = Button(e.currentTarget).parent as DefaultGroupedListItemRenderer;
			var index:int = renderer.itemIndex;
			_list.isEnabled = false;
			
			var sellItem:SellItemEntity = _list.dataProvider.data[1].children[index].data;
			//trace("data =" + sellItem.name);
			
			Entity.destroy(SellItemEntity, sellItem.id , onDeleteComplete, onDeleteError);
			//GlobalDataProvider.sellItems.splice(GlobalDataProvider.sellItems.indexOf(sellItem), 1);
			AppDataLoader.getInstance().loadSellItemsData();
		}
		
		private function onDeleteError(message:String):void 
		{
			Logger.logError("on Delete Error : " + message);
			_list.isEnabled = true;
		}
		
		private function onDeleteComplete():void 
		{
			Logger.logInfo("on Delete Complete");
			_list.isEnabled = true;
			
			var alert:Alert = Alert.show("המוצר הוסר בהצלחה", "עשית זאת!", new ListCollection(
			[
				{ label: "סבבה" },
				//{ label: "Cancel" }
			]));
			alert.width = this.width - 40;
			//showListData();
			showMySellItemsList();
			AppDataLoader.getInstance().loadSellItemsData();
		}
		
		override protected function customHeaderFactory():Header 
		{
			var header:Header = super.customHeaderFactory();
			_logoutButn = new Button();
			_logoutButn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON);
			_logoutButn.label = "התנתק";
			//_logoutButn.x = 10;
			//_logoutButn.setSize(this.stage.stageWidth - 20,  UiGenerator.getInstance().buttonHeight);
			_logoutButn.addEventListener(Event.TRIGGERED, onLogoutClick);
			
			header.rightItems = new <DisplayObject>[_logoutButn];
			return header;
		}
		
		private function onLogoutClick(e:Event):void 
		{
			Player.logout();
			GlobalEventController.getInstance().dispatchEventWith(GlobalEventController.RELOAD_APP);
		}
		
		private function customFooterFactory():Header
		{
			var footer:Header = new Header();
			_saveButn = new Button();
			_saveButn.label = "שמור שינוים";
			_saveButn.width = this.stage.stageWidth - 40;
			_saveButn.addEventListener(Event.TRIGGERED, onSaveChangesClick);
			footer.centerItems = new <DisplayObject>[_saveButn];
			
			return footer;
		}
		
		private function onSaveChangesClick(e:Event):void 
		{
			GlobalDataProvider.myUserData.email = mailInput.text;
			GlobalDataProvider.myUserData.address = addressInput.text;
			GlobalDataProvider.myUserData.name = nameInput.text;
			GlobalDataProvider.myUserData.phoneNumber = phoneInput.text;
			GlobalDataProvider.myUserData.save(null, null);
			
			var alert:Alert = Alert.show("השינויים נשמרו בהצלחה",null, new ListCollection(
			[
				{ label: "סבבה" },
			]));
			alert.width = this.width - 40;
		}
		
	}

}