package feathers.themes
{
	import starling.textures.Texture;

	public class EmbeddedAssets
	{
		[Embed(source="/../../assets/embed/fb-ico.png")]
		private static const FB_ICON_EMBEDDED:Class;

		[Embed(source="/../../assets/embed/twitter-ico.png")]
		private static const TWITTER_ICON_EMBEDDED:Class;

		[Embed(source="/../../assets/embed/gp-ico2.png")]
		private static const GPLUS_ICON_EMBEDDED:Class;
		
		[Embed(source="/../../assets/embed/air-ico4.png")]
		private static const FB_ICON_BLUE_EMBEDDED:Class;

		public static var FB_ICON_BLUE:Texture;
		public static var FB_ICON:Texture;
		public static var TWITTER_ICON:Texture;
		public static var GPLUS_ICON:Texture;		
		
		public static function initialize():void
		{
			//we can't create these textures until Starling is ready
			
			FB_ICON_BLUE = Texture.fromBitmap(new FB_ICON_BLUE_EMBEDDED());
			FB_ICON = Texture.fromBitmap(new FB_ICON_EMBEDDED());
			TWITTER_ICON = Texture.fromBitmap(new TWITTER_ICON_EMBEDDED());
			GPLUS_ICON = Texture.fromBitmap(new GPLUS_ICON_EMBEDDED());			
		}
	}
}
