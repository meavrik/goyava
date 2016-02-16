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
		static public const MAIN_MENU_ICONS:String = "mainMenuIcons";
		static public const GIFT_ANIMATION:String = "gift_animation";
		static public const BUTTON_ICONS2:String = "buttonIcons2";
		
		[Embed(source = "../../bin/mainMenuIcons.png")]
		private var MAIN_MENU_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/mainMenuIcons.xml", mimeType="application/octet-stream")]
		private var MAIN_MENU_ICONS_XML:Class;
		
		[Embed(source = "../../bin/buttonIcons.png")]
		private var BUTTON_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/buttonIcons.xml", mimeType="application/octet-stream")]
		private var BUTTON_ICONS_XML:Class;
		
		[Embed(source = "../../bin/buttonIcons2.png")]
		private var BUTTON_ICONS2_IMAGE:Class;
		[Embed(source = "../../bin/buttonIcons2.xml", mimeType="application/octet-stream")]
		private var BUTTON_ICONS2_XML:Class;
		
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
			var menuAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new MAIN_MENU_ICONS_IMAGE(), false), XML(new MAIN_MENU_ICONS_XML()));
			_assetManager.addTextureAtlas(MAIN_MENU_ICONS, menuAtlas);
		
			var buttonsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new BUTTON_ICONS_IMAGE(), false), XML(new BUTTON_ICONS_XML()));
			_assetManager.addTextureAtlas(BUTTON_ICONS, buttonsAtlas);
			
			var buttonsAtlas2:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new BUTTON_ICONS2_IMAGE(), false), XML(new BUTTON_ICONS2_XML()));
			_assetManager.addTextureAtlas(BUTTON_ICONS2, buttonsAtlas2);
			
			var giftAnimationAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new GIFT_ANIMATION_IMAGE(), false), XML(new GIFT_ANIMATION_XML()));
			_assetManager.addTextureAtlas(GIFT_ANIMATION, giftAnimationAtlas);
			
		}
		
		public function getTextureByFrame(assetName:String, index:int):Texture 
		{
			var iconsAtlas:TextureAtlas = assetManager.getTextureAtlas(assetName);
			if (index < iconsAtlas.getTextures().length)
			{
				return iconsAtlas.getTextures()[index];
			} else
			{
				Logger.logError(this, "now such frame (" + index + ") in asset!");
				return Texture.empty(10, 10);
			}
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}

		
	}

}