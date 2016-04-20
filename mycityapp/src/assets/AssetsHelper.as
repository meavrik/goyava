package assets 
{
	import com.gamua.flox.Flox;
	import log.Logger;
	import starling.display.Image;
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
		static public const LOGIN_FRAMES:String = "loginFrames";
		static public const TAB_ICONS:String = "tabIcons";

		
		[Embed(source = "../../bin/mainMenuIcons.png")]
		private var MAIN_MENU_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/mainMenuIcons.xml", mimeType="application/octet-stream")]
		private var MAIN_MENU_ICONS_XML:Class;
		
		[Embed(source = "../../bin/buttonIcons.png")]
		private var BUTTON_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/buttonIcons.xml", mimeType="application/octet-stream")]
		private var BUTTON_ICONS_XML:Class;
		
		[Embed(source = "../../bin/tabIcons.png")]
		private var TAB_BUTTON_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/tabIcons.xml", mimeType="application/octet-stream")]
		private var TAB_BUTTON_ICONS_XML:Class;
		
		[Embed(source = "../../bin/loginPath.png")]
		private var LOGIN_IMAGE:Class;
		[Embed(source = "../../bin/loginPath.xml", mimeType="application/octet-stream")]
		private var LOGIN_XML:Class;
		
		
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
			
			var tabIconsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new TAB_BUTTON_ICONS_IMAGE(), false), XML(new TAB_BUTTON_ICONS_XML()));
			_assetManager.addTextureAtlas(TAB_ICONS, tabIconsAtlas);
			
			var loginAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new LOGIN_IMAGE(), false), XML(new LOGIN_XML()));
			_assetManager.addTextureAtlas(LOGIN_FRAMES, loginAtlas);

			
		}
		
		public function getTextureByFrame(assetName:String, index:int):Texture 
		{
			var iconsAtlas:TextureAtlas = assetManager.getTextureAtlas(assetName);
			if (index < iconsAtlas.getTextures().length)
			{
				var texture:Texture = iconsAtlas.getTextures()[index];
				return texture;
			} else
			{
				Logger.logError(this, "now such frame (" + index + ") in asset!");
				return Texture.empty(10, 10);
			}
		}
		
		public function getImageFromTexture(assetName:String, index:int,scaleFactor:Number=1):Image 
		{
			var img:Image = new Image(getTextureByFrame(assetName, index));
			img.scaleX = img.scaleY = scaleFactor;
			return img;
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}

		
	}

}