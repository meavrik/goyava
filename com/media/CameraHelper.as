package media 
{
	import com.gamua.flox.Flox;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import flash.media.MediaPromise;
	import flash.utils.IDataInput;
	import starling.display.Stage;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Avrik
	 */
	public class CameraHelper extends EventDispatcher
	{
		private var _bitmap:Bitmap;
		private var dataSource:IDataInput;
		private var _loader:Loader;
		private var _stage:Stage;
		private var _imgBounds:Rectangle;
		
		public function CameraHelper(stage:Stage,imgBounds:Rectangle) 
		{
			this._imgBounds = imgBounds;
			this._stage = stage;
		}
		
		public function browseForImage():void 
		{
			
			var cameraRoll:CameraRoll = new CameraRoll();
			cameraRoll.addEventListener( MediaEvent.SELECT, imageSelected );
			//cameraRoll.addEventListener( Event.CANCEL, browseCanceled );
			//cameraRoll.addEventListener( ErrorEvent.ERROR, mediaError );
			cameraRoll.browseForImage();
		}
		
		private function imageSelected(e:MediaEvent):void 
		{
			trace( "Media selected..." );      
			var imagePromise:MediaPromise = e.data;
			dataSource = imagePromise.open();

			/*if( imagePromise.isAsync )
			{
				trace( "Asynchronous media promise." );
				var eventSource:IEventDispatcher = dataSource as IEventDispatcher;            
				eventSource.addEventListener( flash.events.Event.COMPLETE, onMediaLoaded );         
			}
			else
			{
				trace( "Synchronous media promise." );
				readMediaData();
			}*/
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			_loader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR, onImageLoadedError);
			_loader.loadFilePromise(imagePromise);
		}
		
		private function onImageLoadedError(e:ErrorEvent):void 
		{
			Flox.logError("onImageLoadedError " + e.text);
		}
		
		private function onImageLoaded(event:flash.events.Event):void 
		{
			Flox.logInfo("onImageLoaded success!!");
			
			var isPortrait:Boolean;
			var bitmapData:BitmapData = Bitmap(event.currentTarget.content).bitmapData;
			if(bitmapData.height > bitmapData.width){
				isPortrait = true;
			} else 
			{
				isPortrait = false;
			}
			
			_bitmap = new Bitmap(bitmapData);
			//Calculate the scaling ratio to apply to the image.
			/*var ratio:Number;
			if(isPortrait){
				ratio = Math.min(_stage.stageHeight / bitmapData.width, _stage.stageWidth / bitmapData.height);
				ratio = Math.min(ratio, 1);
				bitmap.width = bitmapData.width * ratio;
				bitmap.height = bitmapData.height * ratio;
				bitmap.rotation=-90;
				bitmap.y=bitmap.height;
			} else 
			{
				ratio = Math.min(_stage.stageHeight / bitmapData.height, _stage.stageWidth / bitmapData.width);
				ratio=Math.min(ratio,1);
				bitmap.width = bitmapData.width * ratio;
				bitmap.height = bitmapData.height * ratio;
			}*/
			
			
			//var newSize:Number = 300;
			
			var scale:Number = _imgBounds.width / bitmapData.width;
			if (scale > 1) scale = 1;
			trace("SCALE === " + scale);
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);

			var smallBMD:BitmapData = new BitmapData(bitmapData.width * scale, bitmapData.height * scale, true, 0x000000);
			smallBMD.draw(bitmapData, matrix, null, null, null, true);

			_bitmap = new Bitmap(smallBMD, PixelSnapping.NEVER, true);
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onImageLoaded);
			_loader.contentLoaderInfo.removeEventListener(ErrorEvent.ERROR, onImageLoadedError);
			dispatchEvent(new starling.events.Event(starling.events.Event.COMPLETE));
		}
		

		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
	}

}