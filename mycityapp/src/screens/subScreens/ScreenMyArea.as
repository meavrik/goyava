package screens.subScreens 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import log.Logger;
	import starling.events.Event;
	import ui.UiGenerator;
	/**
	 * ...
	 * @author Avrik
	 */
	//public class ScreenMyArea extends ScreenSubMain 
	public class ScreenMyArea extends ScreenSubScreenMenu 
	{
		private var nameInput:TextInput;
		private var addressInput:TextInput;
		
		private var _listItem:Object;
		private var _list:GroupedList;
		
		public function ScreenMyArea() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = "האזור האישי";
			
			headerStyleName = Header.TITLE_ALIGN_PREFER_LEFT;
			
			nameInput = new TextInput();
			nameInput.move(10, 10);
			nameInput.prompt = GlobalDataProvider.userPlayer.name;
			nameInput.setSize(UiGenerator.getInstance().fieldWidth / 2, UiGenerator.getInstance().fieldHeight);
			addChild(nameInput);
			
			addressInput = new TextInput();
			addressInput.prompt = GlobalDataProvider.userPlayer.address;
			addressInput.setSize(UiGenerator.getInstance().fieldWidth / 2, UiGenerator.getInstance().fieldHeight);
			addressInput.move(10, nameInput.bounds.bottom + 10);
			addChild(addressInput);
			
			var nameLabel:Label = new Label();
			nameLabel.text = ":שם";
			nameLabel.move(nameInput.bounds.right + 20, nameInput.bounds.top + 20);
			addChild(nameLabel);
			
			var addressLabel:Label = new Label();
			addressLabel.text = ":כתובת";
			addressLabel.move(addressInput.bounds.right + 20, addressInput.bounds.top + 20);
			addChild(addressLabel);
			
			var toggle:ToggleSwitch = new ToggleSwitch();
			toggle.onText = "מופעל";
			toggle.offText = "כבוי";
			toggle.move(10, addressInput.bounds.bottom + 10);
			toggle.setSize(120, UiGenerator.getInstance().buttonHeight);
			addChild(toggle);
			
			_list = new GroupedList();
			_list.itemRendererProperties.labelField = "text";
			_list.itemRendererProperties.accessoryField = "accessory";
			_list.itemRendererProperties.iconField = "icon";
			//_list.clipContent = false;
			//_list.autoHideBackground = true;
			
			_listItem =[
				 {
					header: "קבוצות שלי",
					children:[ ]
				 },
				 {
					 header: "מודעות שלי",
					 children:[ ]
				 },
			]
			
			_listItem.icon = new ToggleSwitch();
			//_listItem.accessory = new ToggleSwitch();
			
			_list.dataProvider = new HierarchicalCollection(_listItem);
			_list.isSelectable = false;

			_list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.labelField = "text";
				renderer.accessoryField = "accessory";
				// renderer.iconSourceField = "thumbnail";
				var deleteButn:Button = new Button();
				deleteButn.label = "הסר";
				deleteButn.move(stage.stageWidth-130, 10);
				deleteButn.addEventListener(Event.TRIGGERED, onDeleteButnClick);
				renderer.addChild(deleteButn);
				renderer.itemIndex ++;
				return renderer;
			};
			
			_list.move(5, toggle.bounds.bottom + 10);
			//_list.setSize(this.width, this.height - _list.bounds.top);
			_list.setSize(this.stage.stageWidth -10, this.stage.stageHeight-_list.bounds.top);
			 
			this.addChild( _list );
			
			showListData();
		}
		
		private function showListData():void
		{
			/*if (_list.dataProvider.data)
			{
				_list.dataProvider.removeAll();
			}*/
			for (var i:int = 0; i <GlobalDataProvider.userPlayer.myGroups.length ; i++) 
			{
				_list.dataProvider.data[0].children[i] = GlobalDataProvider.userPlayer.myGroups[i]
				_list.dataProvider.data[0].icon=new ToggleSwitch();
			}
			
			for (var j:int = 0; j < GlobalDataProvider.userPlayer.mySales.length; j++) 
			{
				_list.dataProvider.data[1].children[j] = GlobalDataProvider.userPlayer.mySales[j].name;
				_list.dataProvider.data[1].accessory = new ToggleSwitch();
			}
		}
		
		private function onDeleteButnClick(e:Event):void 
		{
			var renderer:DefaultGroupedListItemRenderer = Button(e.currentTarget).parent as DefaultGroupedListItemRenderer;
			var index:int = renderer.itemIndex;
			_list.isEnabled = false;
			//trace("INDEX =" + index);
			//trace("ID =" + GlobalDataProvider.userPlayer.mySales[index].id);
			var id:String = GlobalDataProvider.userPlayer.mySales[index].id;
			Entity.destroy(SellItemEntity,id , onDeleteComplete, onDeleteError);
			
			GlobalDataProvider.commonEntity.removeSellItemByIndex(id);
			GlobalDataProvider.commonEntity.save(null, null);
			GlobalDataProvider.userPlayer.mySales.splice(index, 1);
			GlobalDataProvider.userPlayer.save(null, null);
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
			showListData();
		}
		
	}

}