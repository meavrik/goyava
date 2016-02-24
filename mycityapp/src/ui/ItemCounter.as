package ui 
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Graphics;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ItemCounter extends Sprite 
	{
		private var _count:int
		private var _label:TextField;
		
		public function ItemCounter() 
		{
			super();
			
			var g:Graphics = new Graphics(this);
			g.beginFill(0x482C00);
			//g.lineStyle(1, 0xffffff);
			g.drawCircle(20, 20, 20);
			g.endFill();
			
			_label = new TextField(40, 40,"");
			//_label.hAlign = HAlign.CENTER;
			//_label.vAlign = VAlign.CENTER;
			_label.alignPivot();
			_label.fontSize = 25;
			//_label.autoScale = true;
			_label.color = 0xffffff;
			_label.x = 20;
			_label.y = 20;
			addChild(_label);
			this.visible = false;
		}
		
		public function get count():int 
		{
			return _count;
		}
		
		public function set count(value:int):void 
		{
			_count = value;
			
			if (_count)
			{
				if (!this.visible)
				{
					this.visible = true;
					var tween:Tween = new Tween(this, .5, Transitions.EASE_OUT_BOUNCE);
					this.scaleX = this.scaleY = .1;
					tween.scaleTo(1);
					Starling.juggler.add(tween);
				}
				
				_label.text = value.toString();
			} else
			{
				this.visible = false;
			}
			
		}
		
	}

}