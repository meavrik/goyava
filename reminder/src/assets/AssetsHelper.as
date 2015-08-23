package assets 
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author Avrik
	 */
	public class AssetsHelper 
	{
		static public const TIME_ICONS:String = "timeIcons";
		static public const SKINS_TEXTURES:String = "skinsTextures";
		static public const BUTTON_ICONS:String = "buttonIcons";
		
		[Embed(source = "../../bin/icons.png")]
		private var ICONS_IMAGE:Class;
		[Embed(source = "../../bin/icons.xml", mimeType="application/octet-stream")]
		private var ICONS_XML:Class;
		
		[Embed(source = "../../bin/skins.png")]
		private var SKINS_IMAGE:Class;
		[Embed(source = "../../bin/skins.xml", mimeType="application/octet-stream")]
		private var SKINS_XML:Class;
		
		[Embed(source = "../../bin/buttonIcons.png")]
		private var BUTTON_ICONS_IMAGE:Class;
		[Embed(source = "../../bin/buttonIcons.xml", mimeType="application/octet-stream")]
		private var BUTTON_ICONS_XML:Class;
		
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
			var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ICONS_IMAGE(), false), XML(new ICONS_XML()));
			_assetManager.addTextureAtlas(TIME_ICONS, atlas);
			
			var skinsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SKINS_IMAGE(), false), XML(new SKINS_XML()));
			_assetManager.addTextureAtlas(SKINS_TEXTURES, skinsAtlas);
			
			var buttonsAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new BUTTON_ICONS_IMAGE(), false), XML(new BUTTON_ICONS_XML()));
			_assetManager.addTextureAtlas(BUTTON_ICONS, buttonsAtlas);
		}
		
		public function getTextureByFrame(assetName:String, index:int):Texture 
		{
			var iconsAtlas:TextureAtlas = AssetsHelper.getInstance().assetManager.getTextureAtlas(assetName);
			return iconsAtlas.getTextures()[index];
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}

		
	}

}