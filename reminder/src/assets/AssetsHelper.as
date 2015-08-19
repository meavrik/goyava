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
		
		[Embed(source = "../../bin/icons.png")]
		private var ICONS_IMAGE:Class;
		
		[Embed(source = "../../bin/icons.xml", mimeType="application/octet-stream")]
		private var ICONS_XML:Class;
		
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