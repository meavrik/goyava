package screens 
{
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.data.ListCollection;
	import log.Logger;
	import screens.enums.ScreenEnum;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenGroups extends ScreenSubMain 
	{
		private var _list:BaseListScreen;
		
		public function ScreenGroups() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this.footerFactory = customFooterFactory;
			title = "חפש אנשים למטרות משותפות"
			
			_list = new BaseListScreen()
			_list.dataProvider = new ListCollection( [ ]);
			_list.setSize(this.width, stage.stageHeight - this.y);
			_list.addEventListener(Event.TRIGGERED, onGroupItemClick);
			addChild(_list);

			var arr:Array = GlobalDataProvider.commonEntity.groups;
			if (arr)
			{
				Logger.logInfo("load GROUPS complete " + arr.join(","));
				var item:Object;
				for (var i:int = 0; i < arr.length; i++) 
				{
					item = arr[i];
					if (item && item.name)
					{
						_list.dataProvider.addItem( { text:item.name ,id:item.id } );
					}
				}
			}
		}
		
		private function onAddClick(e:Event):void 
		{
			dispatchEventWith(ScreenEnum.ADD_NEW_GROUP_SCREEN)
		}
		
		protected function customFooterFactory():Header 
		{
			var footer:Header = new Header()
			var addButton:Button = new Button();
			addButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			addButton.label = "צור קבוצה חדשה";
			addButton.x = 10;
			addButton.setSize(this.stage.stageWidth - 20, UiGenerator.getInstance().buttonHeight);
			addButton.addEventListener(Event.TRIGGERED, onAddClick);
			footer.rightItems = new <DisplayObject>[addButton];
			return footer
		}
		
		private function onGroupItemClick(e:Event):void 
		{
			var groupData:Object = GlobalDataProvider.commonEntity.groups[_list.selectedIndex];
			dispatchEventWith(ScreenEnum.VIEW_GROUP_SCREEN, false, groupData);
		}
		
	}

}