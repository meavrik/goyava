package subPanels 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Flox;
	import feathers.controls.Button;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import locale.Language;
	import locale.LocaleManager;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class LanguagePicker extends PickerList 
	{
		
		public function LanguagePicker() 
		{
			super();

			setSize(100, 100);
			dataProvider = new ListCollection( [ ]);

			 var item:Language;
			 for (var i:int = 0; i < LocaleManager.getInstance().langs.length; i++) 
			 {
				 item = LocaleManager.getInstance().langs[i];
				 dataProvider.addItem( { text:item.name, code:item.code } );

				if (item.code == UserGlobal.userPlayer.locale)
				{
					selectedIndex = i;
				}
			 }
			 
			 listProperties.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 //renderer.iconSourceField = "thumbnail";
				 return renderer;
			 };
			 
			customButtonStyleName = Button.ALTERNATE_NAME_QUIET_BUTTON
			
			 
			 //refreshButtonProperties();
			/* var img:Image = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.TIME_ICONS, 10));
			 _langPicker.buttonFactory = function():Button
			 {
				 var button:Button = new Button();
				 button.defaultIcon = img;
				 return button;
			 };*/
			 
		}
		
		override public function validate():void 
		{
			super.validate();
			
			 button.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.TIME_ICONS, 10));

		}
		
	}

}