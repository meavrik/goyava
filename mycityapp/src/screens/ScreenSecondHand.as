package screens 
{
	import assets.AssetsHelper;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.SellItemEntity;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import helpers.FormatHelper;
	import screens.consts.CategoriesConst;
	import screens.enums.ScreenEnum;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */

	public class ScreenSecondHand extends ScreenListSearch 
	{
		public function ScreenSecondHand() 
		{
			super();
			
			title = "לוח יד שניה";
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			//footerFactory = customFooterFactory;
			this._searchInput.prompt = "חפש מוצר";
			
			
		}
		
		override protected function getListItemObject(item:Object):Object 
		{
			var obj:Object = new Object();
			obj.label = item.name+ " " + FormatHelper.getMoneyFormat(item.price, GlobalDataProvider.currencySign);
			
			return obj;
		}
		
		override protected function get getEventString():String 
		{
			return AppDataLoader.SELLITEMS_DATA_LOADED;
		}
		
		override protected function get getDataProviderArr():Vector.<*>
		{
			return GlobalDataProvider.sellItems as Vector.<*>;
		}
		
		override protected function get categoryListArr():Array 
		{
			return CategoriesConst.sellItemsCategories;
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			var sellData:SellItemEntity = GlobalDataProvider.sellItems[_list.selectedItem.index];
			dispatchEventWith(ScreenEnum.SELL_ITEM_VIEW_SCREEN, false, sellData)
		}

		override protected function handleAddClick():void 
		{
			super.handleAddClick();
			dispatchEventWith(ScreenEnum.SELL_ITEM_ADD_SCREEN)
		}
		
		/*protected function customFooterFactory():Header 
		{
			var footer:Header = new Header()
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "צור מודעה חדשה";
			addButton.width = this.stage.stageWidth - 40;
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			footer.centerItems = new <DisplayObject>[addButton];
			return footer
		}*/
	}

}