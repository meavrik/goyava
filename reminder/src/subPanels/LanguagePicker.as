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
	import starling.textures.Texture;
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
			
			var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;
			
			 var item:Language;
			 
			 var img:Texture = AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0);
			 
			  listProperties.itemRendererFactory = function():IListItemRenderer
			 {
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "text";
				renderer.iconSourceField = "thumbnail";
				//renderer.accessorySourceFunction  = itemRendererAccessorySourceFunction;
				renderer.styleNameList.add( Button.ICON_POSITION_LEFT );
				renderer.index++;
				return renderer;
			 };
			 
			 
			 
			 for (var i:int = 0; i < LocaleManager.getInstance().langs.length; i++) 
			 {
				 item = LocaleManager.getInstance().langs[i];
				 dataProvider.addItem( { text:item.name, code:item.code, thumbnail:img } );
				
				if (item.code == UserGlobal.userPlayer.locale)
				{
					selectedIndex = i;
				}
			 }
			 
			
			 
			customButtonStyleName = Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON
			 
			 addEventListener(Event.CHANGE, onLangChange);
		}
		
		
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 9)
		}
		
		
		
		override public function validate():void 
		{
			super.validate();
			
			button.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 6 + selectedIndex));
			button.label = "";
		}
		
		private function onLangChange(e:Event):void 
		{
			Flox.logInfo("onLangChange : " + selectedItem.code);
			UserGlobal.userPlayer.locale = selectedItem.code;
			UserGlobal.userPlayer.save(null, null);
			MainApp.getInstance().refreshApp();
		}
		
	}

}