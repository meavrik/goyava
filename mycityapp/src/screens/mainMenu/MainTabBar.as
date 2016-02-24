package screens.mainMenu 
{
	import assets.AssetsHelper;
	import feathers.controls.Label;
	import feathers.controls.TabBar;
	import feathers.controls.ToggleButton;
	import starling.core.RenderSupport;
	import starling.display.Image;
	import starling.display.Sprite;
	import ui.ItemCounter;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainTabBar extends TabBar 
	{
		private var _counters:Vector.<ItemCounter>;
		
		public function MainTabBar() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			
			
			
		}
		
		override protected function draw():void 
		{
			super.draw();
			
			_counters = new Vector.<ItemCounter>;
			var counter:ItemCounter;
			
			for each (var item:ToggleButton in activeTabs) 
			{
				counter = new ItemCounter();
				item.addChild(counter);
				_counters.push(counter)
			}
			updateCounter(2, 3);
		}
		
		public function updateCounter(tabIndex:int, num:int):void
		{
			_counters[tabIndex].count = num;
		}
		
		
	}

}