package screens.components 
{
	import assets.AssetsHelper;
	import feathers.controls.ImageLoader;
	import flash.events.ErrorEvent;
	import progress.WaitPreloader;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ImageLoaderComponent extends Sprite 
	{
		private var _imageLoader:ImageLoader;
		private var _preloader:WaitPreloader;
		private var _url:String;
		
		public function ImageLoaderComponent(url:String) 
		{
			super();
			this._url = url;
			
			
		}
		
		public function init():void
		{
			var size:Number = stage.stageWidth - 10;
			var quad:Quad = new Quad(size, size/2, 0xcccccc);
			addChild(quad);
			quad.x = quad.y = 5;
			
			_imageLoader = new ImageLoader();
			_imageLoader.width = _imageLoader.height = size
			_imageLoader.height = size / 2;
			addChild(_imageLoader);
			_imageLoader.move(5, 5);
			_imageLoader.addEventListener(Event.COMPLETE, onImageLoadComplete);
			_imageLoader.addEventListener(ErrorEvent.ERROR, onImageLoadError);
			_imageLoader.source = _url;
			
			_preloader = new WaitPreloader();
			_preloader.x = _imageLoader.width / 2;
			_preloader.y = _imageLoader.height / 2;
			addChild(_preloader);
		}
		
		private function onImageLoadError(e:Event):void 
		{
			_imageLoader.removeEventListener(Event.COMPLETE, onImageLoadComplete);
			_imageLoader.removeEventListener(ErrorEvent.ERROR, onImageLoadError);
			if (_preloader)
			{
				_preloader.removeFromParent(true);
			}
		}
		
		private function onImageLoadComplete(e:Event):void 
		{
			_imageLoader.removeEventListener(Event.COMPLETE, onImageLoadComplete);
			_imageLoader.removeEventListener(ErrorEvent.ERROR, onImageLoadError);
			removePreloader()
		}
		
		private function removePreloader():void
		{
			if (_preloader)
			{
				_preloader.removeFromParent(true);
				_preloader = null;
			}
		}
		
		override public function dispose():void 
		{
			removePreloader();
			if (_imageLoader)
			{
				_imageLoader.removeFromParent(true);
				_imageLoader = null;
			}
			
			super.dispose();
		}
		
	}

}