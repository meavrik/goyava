package assets 
{
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

		static public const CUBE_TEXTURES:String = "cube_textures";
		static public const GRID_TEXTURES:String = "grid_textures";


		[Embed(source = "../../bin/cube.png")]
		private var CUBE_IMAGE:Class;
		[Embed(source = "../../bin/cube.xml", mimeType="application/octet-stream")]
		private var CUBE_XML:Class;
		
		[Embed(source = "../../bin/grid.png")]
		private var GRID_IMAGE:Class;
		[Embed(source = "../../bin/grid.xml", mimeType="application/octet-stream")]
		private var GRID_XML:Class;
		

		
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
			var cubeAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new CUBE_IMAGE(), false), XML(new CUBE_XML()));
			_assetManager.addTextureAtlas(CUBE_TEXTURES, cubeAtlas);
		
			var gridAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new GRID_IMAGE(), false), XML(new GRID_XML()));
			_assetManager.addTextureAtlas(GRID_TEXTURES, gridAtlas);	
		}
		
		public function getTextureByFrame(assetName:String, index:int=0):Texture 
		{
			var iconsAtlas:TextureAtlas = assetManager.getTextureAtlas(assetName);
			if (index < iconsAtlas.getTextures().length)
			{
				var texture:Texture = iconsAtlas.getTextures()[index];
				return texture;
			} else
			{
				return Texture.empty(10, 10);
			}
		}
		
		public function getImageFromTexture(assetName:String, index:int=0,scaleFactor:Number=1):Image 
		{
			var img:Image = new Image(getTextureByFrame(assetName, index));
			if (scaleFactor != 1)
			{
				img.scaleX = img.scaleY = scaleFactor;
			}
			
			return img;
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}
	}

}