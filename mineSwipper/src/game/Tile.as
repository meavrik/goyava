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
		static public const OPEN:String = "open";

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
			quad = new Quad(GameCommon.TILE_WIDTH, GameCommon.TILE_HEIGHT, 0x999999);

			_contentPH.addChild(quad);
			
			quad2 = new Quad(GameCommon.TILE_WIDTH-2, GameCommon.TILE_HEIGHT-2, 0xcccccc);
			quad2.x = quad2.y = 1;
			_contentPH.addChild(quad2);
			
			var textFormat:TextFormat = new TextFormat("Arial", GameCommon.TILE_WIDTH / 2);
			textFormat.bold = true;
			_counterTF = new TextField(GameCommon.TILE_WIDTH, GameCommon.TILE_HEIGHT);
			_counterTF.format = textFormat;
			_flagTF = new TextField(GameCommon.TILE_WIDTH, GameCommon.TILE_HEIGHT, "X");
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
			x = xpos * GameCommon.TILE_WIDTH;
			y = ypos * GameCommon.TILE_HEIGHT;
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
				mineImage = new Quad(GameCommon.TILE_WIDTH-20, GameCommon.TILE_WIDTH-20, 0);
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
						return
					}
				}
				
				dispatchEventWith(OPEN);
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
			
			switch (value) {
					case 1:
						_counterTF.format.color = 0x0000ff;
						break;
					case 2:
						_counterTF.format.color = 0x00ff00;
						break;
					case 3:
						_counterTF.format.color = 0xff0000;
						break;
			}
			
			
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