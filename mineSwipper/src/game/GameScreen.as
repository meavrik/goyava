package game 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import flash.globalization.DateTimeFormatter;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GameScreen extends PanelScreen 
	{
		
		private var timeCounter:Label;
		private var _dateFormatter:DateTimeFormatter;
		private var list:PickerList;
		
		public function GameScreen() 
		{
			super();
			title = "Mine Swiper";
			
			headerFactory = getCustemHeader;
			_verticalScrollPolicy = PanelScreen.SCROLL_POLICY_OFF;
		}
		
		private function getCustemHeader():Header 
		{
			list = new PickerList();
			
			list.customListStyleName = PickerList.DEFAULT_CHILD_STYLE_NAME_LIST;
			list.dataProvider = new ListCollection(
				 [
					 { text: "beginner" },
					 { text: "intermediate" },
					 { text: "export" }
				 ]);
				 
			 list.listProperties.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				// renderer.iconSourceField = "thumbnail";
				 return renderer;
			 };
			 
			list.labelField = "text";
			list.selectedIndex = -1;
			list.addEventListener( Event.CHANGE, list_changeHandler );
			
			var header:Header = new Header();
			timeCounter = new Label();
			timeCounter.text = "000";
			timeCounter.backgroundSkin = new Quad(80, 40, 0xcccccc);;
			timeCounter.styleName = Label.ALTERNATE_STYLE_NAME_HEADING;
			header.leftItems = new <DisplayObject>[timeCounter];
			header.rightItems = new <DisplayObject>[list];

			return header;
		}
		
		private function list_changeHandler(e:Event):void 
		{
			//list.prompt = list.dataProvider.data[list.selectedIndex].text
			dispatchEvent(new Event(GameEvents.DIFFICULTY_SELECTED, true, list.selectedIndex));
		}
		
		public function setTime(newTime:String):void
		{
			timeCounter.text = newTime
		}
		
	}

}