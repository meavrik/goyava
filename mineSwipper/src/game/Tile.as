package game 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Tile extends Sprite 
	{
		public var nearTilesArr:Vector.<Tile>;
		private var _counter:int = 0;
		
		static public const BOOOM:String = "booom";
		
		public static var TILE_SIZE:Number = 40;

		private var _mine:Boolean;
		
		private var _ypos:int;
		private var _xpos:int;
		private var _contentPH:Sprite
		private var mineImage:Quad;
		private var _counterTF:TextField;
		private var _flagTF:TextField;
		private var empty:Boolean = true;
		private var quad:Quad;
		private var quad2:Quad;
		private var _isOpen:Boolean;
		private var _flagged:Boolean;
		private var touchTime:Date;
		private var _timer:Timer;
		private var _placedNow:Boolean;
		
		public function Tile(xpos:int, ypos:int) 
		{
			super();
			_contentPH = new Sprite();
			addChild(_contentPH);
			_contentPH.alignPivot();
			alignPivot();
			this._xpos = xpos;
			this._ypos = ypos;
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToSTage);
		}
		
		private function onAddedToSTage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToSTage);
			init()
		}
		
		private function init():void 
		{
			TILE_SIZE = Math.round(stage.stageWidth / 10);
			
			quad = new Quad(TILE_SIZE, TILE_SIZE, 0x999999);
			_contentPH.addChild(quad);
			
			quad2 = new Quad(TILE_SIZE-4, TILE_SIZE-4, 0xcccccc);
			quad2.x = quad2.y = 2;
			_contentPH.addChild(quad2);
			
			var textFormat:TextFormat = new TextFormat("Verdana", TILE_SIZE/2);
			_counterTF = new TextField(TILE_SIZE, TILE_SIZE);
			_counterTF.format = textFormat;
			_flagTF = new TextField(TILE_SIZE, TILE_SIZE, "X");
			_flagTF.format = textFormat;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					_timer = new Timer(200, 1)
					_timer.addEventListener(TimerEvent.TIMER, onTimerPass);
					_timer.start();
				}
 
				else if(touch.phase == TouchPhase.ENDED)
				{
					_contentPH.scaleX = _contentPH.scaleY = 1;
					if (!flagged && !_placedNow)
					{
						open();
					} 
					
					_placedNow = false;
					
				}
			}
		}
		
		private function onTimerPass(e:TimerEvent):void 
		{
			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER, onTimerPass);
				_timer.stop();
				_timer = null;
			}
			
			if (!_isOpen) {
				_contentPH.scaleX = _contentPH.scaleY = 1.5;
				this.parent.addChild(this);
					
				flagged = !flagged
				_placedNow = true;
			}
		}
		
		
		private function onClick(e:Event):void 
		{
			
		}
		
		public function setPosition():void 
		{
			x = xpos * TILE_SIZE;
			y = ypos * TILE_SIZE;
		}
		
		public function get mine():Boolean 
		{
			return _mine;
		}
		
		public function set mine(value:Boolean):void 
		{
			_mine = value;
			if (value)
			{
				mineImage = new Quad(TILE_SIZE-20, TILE_SIZE-20, 0);
				mineImage.x = 10;
				mineImage.y = 10;
				
			}
			empty = !value;
		}
		
		
		public function setCounter():void
		{
			for each (var item:Tile in nearTilesArr) 
			{
				if (!item.mine)
				{
					item.counter++;
				}
			}
		}
		
		public function open():void 
		{
			if (!_isOpen && !_flagged)
			{
				flagged = false;
				_isOpen = true;
				quad2.removeFromParent();
				
				if (empty)
				{
					
					for each (var item:Tile in nearTilesArr) 
					{
						if (!item.mine)
						{
							item.open();
						}
					}
				} else
				{
					_contentPH.addChild(_counterTF);
					if (mineImage)
					{
						_contentPH.addChild(mineImage);
						dispatchEventWith(BOOOM);
					}
				}
			}
		}
		
		public function get xpos():int 
		{
			return _xpos;
		}
		
		public function get ypos():int 
		{
			return _ypos;
		}
		
		public function get counter():int 
		{
			return _counter;
		}
		
		public function set counter(value:int):void 
		{
			_counter = value;
			_counterTF.text = value.toString();
			
			if (empty)
			{
				empty = value?false:true;
			}
		}
		
		public function get flagged():Boolean 
		{
			return _flagged;
		}
		
		public function set flagged(value:Boolean):void 
		{
			_flagged = value;
			
			if (_flagged)
			{
				_contentPH.addChild(_flagTF);
				
			} else
			{
				_flagTF.removeFromParent();
			}
		}
		
	}

}