package progress 
{
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.events.FeathersEventType;
	import starling.animation.DelayedCall;
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
		private var _canFinish:Boolean;
		
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

			//repeatCall = Starling.juggler.repeatCall(onRepeatCall, .02, 100)
		}
		
		private function onRepeatCall():void 
		{
			if (value < 90 || _canFinish)
			{
				value++;
			}
		}
		
		public function doComplete():void
		{
			_canFinish = true;
			//if (repeatCall) repeatCall.advanceTime(1)
		}
		
		override protected function draw():void 
		{
			super.draw();
			
			move((this.stage.stageWidth - width) / 2, (this.stage.stageHeight - (height + 150)));
			
			_label.move((width - _label.width) / 2, -30);
		}

		override public function set value(value:Number):void 
		{
			if (value > this._value)
			{
				super.value = value;
				
				_label.text = value+"% loaded";
			}
			
			
			if (value >= 100)
			{
				Starling.juggler.remove(repeatCall);
				repeatCall = null;
				
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
		}
		
		override public function get value():Number 
		{
			return super.value;
		}
			

		
	}

}