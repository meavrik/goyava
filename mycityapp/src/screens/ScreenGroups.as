package screens 
{
	import entities.GroupEntity;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenGroups extends BaseScreenListSearch 
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
			assignAddButton();
			
			this.loadPageData(GroupEntity)
		}
		
		override protected function handleAddClick():void 
		{
			super.handleAddClick();
			dispatchEventWith(ScreenEnum.ADD_NEW_GROUP_SCREEN);
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			dispatchEventWith(ScreenEnum.VIEW_GROUP_SCREEN, false, _selectedItemData);
		}

		
	}

}