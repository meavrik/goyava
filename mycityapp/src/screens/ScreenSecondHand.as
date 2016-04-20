package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import helpers.FormatHelper;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenSecondHand extends BaseScreenListSearch 
	{
		public function ScreenSecondHand() 
		{
			super();
			
			title = "לוח יד שניה";
		}
		
		override protected function getIconUrl():String 
		{
			return AssetsHelper.SERVER_ASSETS_URL +"secondhand/table1.jpg";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this._searchInput.prompt = "חפש מוצר";
			assignAddButton();
			
			this.loadPageData(SellItemEntity);
		}
		
		override protected function getListItemObject(item:Object):Object 
		{
			var obj:Object = new Object();
			obj.label = item.name+ " " + FormatHelper.getMoneyFormat(item.price, GlobalDataProvider.currencySign);
			
			return obj;
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			dispatchEventWith(ScreenEnum.SELL_ITEM_VIEW_SCREEN, false, _selectedItemData)
		}

		override protected function handleAddClick():void 
		{
			super.handleAddClick();
			dispatchEventWith(ScreenEnum.SELL_ITEM_ADD_SCREEN)
		}
	}

}