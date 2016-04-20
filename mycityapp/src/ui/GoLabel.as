package ui 
{
	import feathers.controls.Label;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GoLabel extends Sprite 
	{
		public static var LOCALE:String = "HE";
		
		private var _areaRect:Rectangle;
		private var _tf:TextField;
		private var _text:String;
		public function GoLabel(areaRect:Rectangle=null) 
		{
			super();
			this._areaRect = areaRect;
			//move(this._areaRect.x, this._areaRect.y);
			//setSize(this._areaRect.width, this._areaRect.height);
			_tf = new TextField(_areaRect.width, _areaRect.height, "", "arial", 30);
			//_tf.autoScale = true;
			_tf.autoSize = TextFieldAutoSize.VERTICAL;
			_tf.hAlign = HAlign.RIGHT;

			_tf.x = areaRect.x;
			_tf.y = areaRect.y;
			
			addChild(_tf);
		}
		
		public function move(xx:Number, yy:Number):void 
		{
			this.x = xx;
			this.y = yy;
		}
		
		public function get text():String 
		{
			//return super.text;
			return _text;
		}
		
		public function set text(value:String):void 
		{
			//super.text = value;
			_text = value;
			_tf.text = value;
			if (_areaRect)
			{
				if (LOCALE == "HE")
				{
					//this.x = _areaRect.x + ((width - (this._text.length * 12)) / 2);
				}
			}
			
			trace("WW === " + width);
		}
		
	}

}