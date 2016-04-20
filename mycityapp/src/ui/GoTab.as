package ui 
{
	import feathers.controls.TabBar;
	import feathers.controls.ToggleButton;
	import feathers.data.ListCollection;
	import starling.events.Event;
	import ui.ItemCounter;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GoTab extends TabBar 
	{
		private var _counters:Vector.<ItemCounter>;
		
		public function GoTab(tabNumber:int) 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_counters = new Vector.<ItemCounter>;
			/*if (!_counters)
			{
				_counters = new Vector.<ItemCounter>;
				var counter:ItemCounter;
				
				for each (var item:ToggleButton in activeTabs) 
				{
					counter = new ItemCounter();
					item.addChild(counter);
					_counters.push(counter)
				}
				//updateCounter(2, 3);
			}*/
			

		}
		
		override public function set dataProvider(value:ListCollection):void 
		{
			super.dataProvider = value;
		}
		
		public function updateCounter(tabIndex:int, num:int):void
		{
			//_counters[tabIndex].count = num;
		}
		
		
	}

}