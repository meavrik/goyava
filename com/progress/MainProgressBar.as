package progress 
{
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.events.FeathersEventType;
	import starling.core.RenderSupport;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainProgressBar extends ProgressBar 
	{
		private var _label:Label;
		
		public function MainProgressBar() 
		{
			super();
			
			minimum = 0;
			maximum = 100;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_label = new Label();
			_label.text = "loading...";
			
			addChild(_label);
		}
		
		override public function render(support:RenderSupport, parentAlpha:Number):void 
		{
			super.render(support, parentAlpha);
			
			move((this.stage.stageWidth - width) / 2, (this.stage.stageHeight - height) / 2);
			
			_label.move((width-_label.width)/2, -30);
		}
		
		override public function get value():Number 
		{
			return super.value;
		}
		
		override public function set value(value:Number):void 
		{
			super.value = value;
			
			_label.text = value+"% loaded";
		}
		
	}

}