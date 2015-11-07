package screens 
{
	import data.GlobalDataProvider;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.data.HierarchicalCollection;
	import ui.UiGenerator;
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMyArea extends ScreenSubMain 
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
			
			title = "אני";
			
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
			toggle.setSize(UiGenerator.getInstance().buttonWidth / 2, UiGenerator.getInstance().buttonHeight);
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
					children:
					[
					]
				 },
				 {
					 header: "מודעות שלי",
					 children:
					 [
						// { text: "כלבים" },
					 ]
				 },
			]
			
			
			_listItem.icon = new ToggleSwitch();
			//_listItem.accessory = new ToggleSwitch();
			
			
			_list.dataProvider = new HierarchicalCollection(_listItem);
			
			_list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.labelField = "text";
				renderer.accessoryField = "accessory";
				// renderer.iconSourceField = "thumbnail";
				return renderer;
			};
			 
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
			//list.addEventListener( Event.CHANGE, list_changeHandler );
			
			_list.move(10, toggle.bounds.bottom + 10);
			//_list.setSize(this.width, this.height - _list.bounds.top);
			_list.setSize(this.stage.stageWidth -20, this.stage.stageHeight/2 -_list.y);
			 
			this.addChild( _list );
		}
		
	}

}