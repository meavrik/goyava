package screens.subScreens 
{
	import data.GlobalDataProvider;
	import entities.GroupEntity;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import screens.consts.CategoriesConst;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenGroupAdd extends ScreenSubScreenMenu 
	{
		private var _itemNameLabel:TextInput;
		private var _detailsLabel:TextInput;
		private var _phoneLabel:TextInput;
		private var _mailLabel:TextInput;
		//private var _addButton:Button;
		private var _categoryPicker:PickerList;
		
		public function ScreenGroupAdd() 
		{
			super();
			title = "קבוצה חדשה";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			footerFactory = customFooterFactory;
			var fieldHeight:Number = UiGenerator.getInstance().fieldHeight;
			var fieldWidth:Number = stage.stageWidth - 20;
			
			_categoryPicker = new PickerList();
	
			_categoryPicker.prompt = "בחר קטגורייה";
			_categoryPicker.listProperties.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 return renderer;
			 };
			 
			_categoryPicker.labelField = "text";
			_categoryPicker.selectedIndex = -1;
			_categoryPicker.setSize(fieldWidth, fieldHeight);
			_categoryPicker.move(10, 10);

			_categoryPicker.dataProvider = new ListCollection([]);
	 
			 for (var i:int = 0; i <CategoriesConst.groupCategories.length; i++) 
			 {
				 _categoryPicker.dataProvider.addItem( { text:CategoriesConst.groupCategories[i], code:i } );
			 };
			 addChild(_categoryPicker)
			 
			 
			_itemNameLabel = new TextInput();
			_itemNameLabel.move(10,_categoryPicker.bounds.bottom+10);
			_itemNameLabel.prompt = "הענק שם לקבוצה";
			_itemNameLabel.setSize(fieldWidth, fieldHeight);
			addChild(_itemNameLabel);
			
			
			_detailsLabel = new TextInput();
			_detailsLabel.move(10, _itemNameLabel.bounds.bottom + 10);
			_detailsLabel.prompt = "פרטי הקבוצה";
			_detailsLabel.setSize(fieldWidth, fieldHeight * 2);
			addChild(_detailsLabel);
			
			_phoneLabel = new TextInput();
			_phoneLabel.move(10, _detailsLabel.bounds.bottom + 20);
			_phoneLabel.setSize(fieldWidth / 2 - 5, fieldHeight);
			_phoneLabel.prompt = "טלפון ליצירת קשר";
			_phoneLabel.text = GlobalDataProvider.myUserData.phoneNumber;
			addChild(_phoneLabel);
			
			_mailLabel = new TextInput();
			_mailLabel.move(_phoneLabel.bounds.right + 10, _phoneLabel.bounds.top);
			_mailLabel.setSize(fieldWidth / 2 - 5, fieldHeight);
			_mailLabel.prompt = "דוא''ל ליצירת קשר";
			_mailLabel.text = GlobalDataProvider.myUserData.email;
			addChild(_mailLabel);
			
			/*_addButton = new Button();
			_addButton.label = "הוסף קבוצה";
			addChild(_addButton);
			_addButton.setSize(UiGenerator.getInstance().buttonWidth, UiGenerator.getInstance().buttonHeight);
			_addButton.move(10, _mailLabel.bounds.bottom + 10);
			_addButton.addEventListener(Event.TRIGGERED, onAddClick);*/
			
			this.width = this.stage.stageWidth - 20;
		}
		
		private function onAddClick(e:Event):void 
		{
			if (isValid())
			{
				var groupEntity:GroupEntity = new GroupEntity();
				//var ordinal:int = GlobalDataProvider.groupsDataProvier.itemsArr?GlobalDataProvider.groupsDataProvier.itemsArr.length:0;
				//var ordinal:int = GlobalDataProvider.commonEntity.groups?GlobalDataProvider.commonEntity.groups.length:0;
				groupEntity.createNewGroup(_itemNameLabel.text, _categoryPicker.selectedItem.text, _detailsLabel.text);
				
				closeMe();
			}
		}
		
		private function isValid():Boolean 
		{
			if (!_categoryPicker.selectedItem)
			{
				showInvalidMessage(_categoryPicker, "בחר קטגוריה");
				return false;
			}
			
			if (!_itemNameLabel.text.length)
			{
				showInvalidMessage(_itemNameLabel, "אנא תן שם לקבוצה");
				return false;
			}
			
			return true;
		}
		
		protected function customFooterFactory():Header 
		{
			var footer:Header = new Header()
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "הוסף קבוצה";
			addButton.x = 10;
			addButton.setSize(this.stage.stageWidth - 20, UiGenerator.getInstance().buttonHeight);
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			footer.rightItems = new <DisplayObject>[addButton];
			return footer
		}
	}
}