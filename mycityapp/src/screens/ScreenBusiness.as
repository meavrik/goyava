package screens 
{
	import entities.BusinessEntity;
	import feathers.controls.Button;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenBusiness extends BaseScreenListSearch
	{
		public function ScreenBusiness() 
		{
			super();
			
			title = "עסקים בעיר";
			
		}
		
		override protected function getIconUrl():String 
		{
			return "http://www.ynet.co.il/PicServer4/2015/07/17/6175935/16821140100092640360no.jpg";
			//return "http://www.ishi-moto.co.il/images/GalB_20140607_11370138_4.jpg";
		}
		override protected function initialize():void 
		{
			super.initialize();
			
			this._searchInput.prompt = "חפש עסק";
			this.loadPageData(BusinessEntity)
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			
			dispatchEventWith(ScreenEnum.BUSINESS_ITEM_VIEW_SCREEN, false, _selectedItemData)
		}
		
		private function onContactButnClick(e:Event):void 
		{
			var contactButn:Button = e.currentTarget as Button;
			const callURL:String = "tel:" + contactButn.label;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
	}

}