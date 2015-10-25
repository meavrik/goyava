package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenResidents extends PanelScreen 
	{
		private var _listScreen:List;
		private var _allArr:Array;
		
		public function ScreenResidents() 
		{
			super();

			title = "רשימת תושבים"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_listScreen = new List();
			_listScreen.dataProvider = new ListCollection( []);
			_listScreen.setSize(this.width, stage.stageHeight - this.y);
			
			var arr:Array = GlobalDataProvider.residentsDataProvier.itemsArr;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				//_listScreen.dataProvider.addItem( { text:arr[i].name+ " " + arr[i].address, thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2) } );
				_listScreen.dataProvider.addItem( { text:arr[i].name } );
			}
			
			_listScreen.isSelectable = false;
			
			_listScreen.itemRendererFactory = function():IListItemRenderer
			 {
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				
				renderer.labelField = "text";
				renderer.iconSourceField = "thumbnail";
				
				var label:Label = new Label();
				label.text = "כתובת";
				label.styleNameList.add(Label.ALTERNATE_NAME_DETAIL);
				label.move(35, 55);

				renderer.addChild(label);
				 var messageButton:Button = new Button();
				messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
				messageButton.move(UiGenerator.getInstance().fieldWidth-180, 10);
				messageButton.setSize(80, 60);
				messageButton.addEventListener(Event.TRIGGERED, onMessageClick);
				renderer.addChild(messageButton);
				 
				var phoneButton:Button = new Button();
				phoneButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
				phoneButton.setSize(80, 60);
				phoneButton.move(UiGenerator.getInstance().fieldWidth-270, 10);
				phoneButton.addEventListener(Event.TRIGGERED, onPhoneClick);
				renderer.addChild(phoneButton);
				
				trace("index = " +  renderer.index);
				 
				return renderer;
			 };
			 
			addChild(_listScreen);
		}
		
		private function onMessageClick(e:Event):void 
		{
			
		}
		
		private function onPhoneClick(e:Event):void 
		{
			
		}
		
	}

}