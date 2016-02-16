package screens 
{
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.GroupEntity;
	import screens.consts.CategoriesConst;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenGroups extends ScreenListSearch 
	{
		public function ScreenGroups() 
		{
			super();
			
			title = "חפש אנשים למטרות משותפות"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this._searchInput.prompt = "חפש קבוצה";
		}
		
		private function setNewFooterButton(string:String):void 
		{
			
		}
		
		override protected function handleAddClick():void 
		{
			super.handleAddClick();
			dispatchEventWith(ScreenEnum.ADD_NEW_GROUP_SCREEN);
		}
		
		/*private function onAddClick(e:Event):void 
		{
			dispatchEventWith(ScreenEnum.ADD_NEW_GROUP_SCREEN)
		}
		
		protected function customFooterFactory():Header 
		{
			var footer:Header = new Header()
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "צור קבוצה חדשה";
			//addButton.x = 10;
			//addButton.setSize(this.stage.stageWidth - 20, UiGenerator.getInstance().buttonHeight);
			addButton.width = this.stage.stageWidth - 40;
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			footer.centerItems = new <DisplayObject>[addButton];
			return footer
		}*/

		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			var groupData:GroupEntity = GlobalDataProvider.groups[_list.selectedItem.index];
			dispatchEventWith(ScreenEnum.VIEW_GROUP_SCREEN, false, groupData);
		}
		/*private function onGroupItemClick(e:Event):void 
		{
			var groupData:GroupEntity = GlobalDataProvider.groups[_list.selectedIndex];
			dispatchEventWith(ScreenEnum.VIEW_GROUP_SCREEN, false, groupData);
		}*/
		
		override protected function get getEventString():String 
		{
			return AppDataLoader.GROUPS_DATA_LOADED;
		}
		
		override protected function get getDataProviderArr():Vector.<*>
		{
			return GlobalDataProvider.groups as Vector.<*>;
		}
		
		override protected function get categoryListArr():Array 
		{
			return CategoriesConst.groupCategories;
		}
		
	}

}