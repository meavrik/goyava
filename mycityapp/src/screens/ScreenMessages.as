package screens 
{
	import com.gamua.flox.Query;
	import data.GlobalDataProvider;
	import entities.MessageEntity;
	import screens.enums.ScreenEnum;
	import starling.events.Event;
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMessages extends BaseScreenList 
	{
		
		public function ScreenMessages() 
		{
			super();
			
			title = "מרכז ההודעות שלי"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			trace("ownerId === " + GlobalDataProvider.myUserData.ownerId);
			//this.loadPageData(MessageEntity, "ownerId == ?", GlobalDataProvider.myUserData.ownerId);
			
			var query:Query = new Query(MessageEntity, "toUserId == ?", GlobalDataProvider.myUserData.ownerId);
			query.find(onDataComplete, onLoadDataError);
		}
		
		override protected function onItemClick(e:Event):void 
		{
			super.onItemClick(e);
			dispatchEventWith(ScreenEnum.VIEW_MESSAGE_SCREEN, false, _selectedItemData);
		}
		
		
	}

}