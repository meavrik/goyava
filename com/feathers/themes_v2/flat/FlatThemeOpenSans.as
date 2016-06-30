/*
Copyright (c) 2014 FlashDaily.net

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package feathers.themes_v2.flat
{
	import feathers.themes_v2.BaseFlatTheme;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * 
	 * Flat Theme 2.0.1 theme for mobile/desktop Feathers apps.
	 *
	 */
	public class FlatThemeOpenSans extends feathers.themes_v2.BaseFlatTheme
	{
		/**
		 * @private
		 */
		[Embed(source="/../assets/FlatTheme.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		/**
		 * @private
		 */
		[Embed(source="/../assets/FlatTheme_atlas.png")]
		protected static const ATLAS_BITMAP:Class;
		
		[Embed(source="/../../assets/fonts/OpenSans-Regular.ttf",fontFamily="OpenSansRegular",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const FONT_EMBED_1:Class;
		
		
		[Embed(source="/../../assets/fonts/OpenSans-Bold.ttf",fontFamily="OpenSansBold",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const FONT_EMBED_2:Class;
		
		[Embed(source="/../../assets/fonts/OpenSans-Regular.ttf",fontFamily="OpenSansRegular",fontWeight="normal",unicodeRange="U+0030-U+0039",mimeType="application/x-font",embedAsCFF="false")]
		protected static const FONT_EMBED_3_NUMBER:Class;

		protected static const THEME_FONT_NAME_REGULAR:String = "OpenSansRegular";
		protected static const THEME_FONT_NAME_BOLD:String = "OpenSansBold";

		/**
		 * Constructor.
		 */
		public function FlatThemeOpenSans(scaleToDPI:Boolean = true)
		{
			super(scaleToDPI,THEME_FONT_NAME_REGULAR,THEME_FONT_NAME_BOLD);
			this.initialize();
			this.dispatchEventWith(Event.COMPLETE);
		}

		/**
		 * @private
		 */
		override protected function initialize():void
		{
			var atlasBitmapData:BitmapData = Bitmap(new ATLAS_BITMAP()).bitmapData;
			var atlasTexture:Texture = Texture.fromBitmapData(atlasBitmapData, false);
			atlasTexture.root.onRestore = this.atlasTexture_onRestore;
			atlasBitmapData.dispose();
			this.atlas = new TextureAtlas(atlasTexture, XML(new ATLAS_XML()));

			super.initialize();
		}

		/**
		 * @private
		 */
		protected function atlasTexture_onRestore():void
		{
			var atlasBitmapData:BitmapData = Bitmap(new ATLAS_BITMAP()).bitmapData;
			this.atlas.texture.root.uploadBitmapData(atlasBitmapData);
			atlasBitmapData.dispose();
		}
	}
}
