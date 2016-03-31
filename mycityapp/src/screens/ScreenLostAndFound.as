package screens 
{
	import entities.LostAndFoundEntity;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenLostAndFound extends BaseScreenListSearch 
	{
		public function ScreenLostAndFound() 
		{
			super();
			title = "אבדות ומציאות";
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			this._searchInput.prompt = "חפש מוצר";
			assignAddButton();
			
			this.loadPageData(LostAndFoundEntity);
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);

			dispatchEventWith(ScreenEnum.LOST_AND_FOUND_SCREEN, false, _selectedItemData)
		}

		override protected function handleAddClick():void 
		{
			super.handleAddClick();
			dispatchEventWith(ScreenEnum.LOST_FOUND_ITEM_ADD_SCREEN)
		}
		
	}

}