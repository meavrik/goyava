package progress 
{
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.events.FeathersEventType;
	import starling.animation.IAnimatable;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MainProgressBar extends ProgressBar 
	{
		private var _label:Label;
		private var repeatCall:IAnimatable;
		
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
			
			repeatCall = Starling.juggler.repeatCall(onRepeatCall, .05, 100);
		}
		
		private function onRepeatCall():void 
		{
			if (value < 90)
			{
				value++;
			}
		}
		
		override public function render(support:RenderSupport, parentAlpha:Number):void 
		{
			super.render(support, parentAlpha);
			
			move((this.stage.stageWidth - width) / 2, (this.stage.stageHeight - (height+50)));
			
			_label.move((width-_label.width)/2, -30);
		}
		

		override public function set value(value:Number):void 
		{
			if (value >= 100)
			{
				Starling.juggler.remove(repeatCall);
				repeatCall = null;
			}
			
			if (value > this._value)
			{
				super.value = value;
				
				_label.text = value+"% loaded";
			}
			
			
		}
		
		override public function get value():Number 
		{
			return super.value;
		}
			

		
	}

}