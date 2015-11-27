package assets 
{
	import com.gamua.flox.Flox;
	import log.Logger;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author Avrik
	 */
	public class AssetsHelper 
	{
		static public const SERVER_ASSETS_URL:String = "http://avrik.com/urika/mycityapp/images/";
		
		
		static public const SKINS_TEXTURES:String = "skinsTextures";
		static public const BUTTON_ICONS:String = "buttonIcons";
		static public const GIFT_ANIMATION:String = "gift_animation";
		

		
		/*[Embed(source = "../../bin/skins.png")]
		private var SKINS_IMAGE:Class;
		[Embed(source = "../../bin/skins.xml", mimeType="application/octet-stream")]
		private var SKINS_XML:Class;*/
		
		[Embed(source = "../../bin/buttonIcons.png")]
		private var BUTTON_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/buttonIcons.xml", mimeType="application/octet-stream")]
		private var BUTTON_ICONS_XML:Class;
		
		
		[Embed(source = "../../bin/giftAnimation.png")]
		private var GIFT_ANIMATION_IMAGE:Class;
		[Embed(source = "../../bin/giftAnimation.xml", mimeType="application/octet-stream")]
		private var GIFT_ANIMATION_XML:Class;
		
		private var _assetManager:AssetManager;
		
		private static var _instance:AssetsHelper = new AssetsHelper();
		public static function getInstance():AssetsHelper
		{
			return _instance;
		}
		
		public function AssetsHelper() 
		{
			_assetManager = new AssetManager();
		}
		
		public function init():void
		{
			//var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ICONS_IMAGE(), false), XML(new ICONS_XML()));
			//_assetManager.addTextureAtlas(TIME_ICONS, atlas);
			
			//var skinsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SKINS_IMAGE(), false), XML(new SKINS_XML()));
			//_assetManager.addTextureAtlas(SKINS_TEXTURES, skinsAtlas);
			
			var buttonsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new BUTTON_ICONS_IMAGE(), false), XML(new BUTTON_ICONS_XML()));
			_assetManager.addTextureAtlas(BUTTON_ICONS, buttonsAtlas);
		
			var giftAnimationAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new GIFT_ANIMATION_IMAGE(), false), XML(new GIFT_ANIMATION_XML()));
			_assetManager.addTextureAtlas(GIFT_ANIMATION, giftAnimationAtlas);
			
			
			//_assetManager.enqueue("http://avrik.com/urika/mycityapp/images/secondhand/table1.jpg");
			//_assetManager.loadQueue(onLoadAssetsProgress);
			
		}
		
		/*private function onLoadAssetsProgress(value:int):void
		{
			var loadedArr:Vector.<String> = _assetManager.getTextureNames();
			
			if (value == 1)
			{
				loadAssetsComplete();
			}
		}
		
		private function loadAssetsComplete():void 
		{
			
		}*/
		
		public function getTextureByFrame(assetName:String, index:int):Texture 
		{
			var iconsAtlas:TextureAtlas = assetManager.getTextureAtlas(assetName);
			if (index < iconsAtlas.getTextures().length)
			{
				return iconsAtlas.getTextures()[index];
			} else
			{
				Logger.logError(this, "now such frame in asset!");
				return Texture.empty(10, 10);
			}
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}

		
	}

}