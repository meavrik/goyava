package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import starling.display.Image;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenResidents extends ScreenSubMain 
	{
		private var _listScreen:List;
		private var _allArr:Array;
		private var _searchInput:AutoComplete;
		
		public function ScreenResidents() 
		{
			super();

			title = "רשימת תושבים"
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this._searchInput = new AutoComplete();
			this._searchInput.autoCompleteDelay = .1;
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT);
			this._searchInput.prompt = "מצא תושב";
			this._searchInput.setSize(this.width - 10, UiGenerator.getInstance().fieldHeight);
			this._searchInput.move(5, 10);
			this._searchInput.addEventListener(Event.OPEN, onAutoCompleteOpen);
			this._searchInput.addEventListener(Event.CLOSE, onAutoCompleteClose);
			this._searchInput.addEventListener(Event.CHANGE, onAutoCompleteChange);
			this.addChild(this._searchInput);
			
			
			
			_listScreen = new List();
			_listScreen.dataProvider = new ListCollection( []);
			_listScreen.move(0, this._searchInput.bounds.bottom + 10);
			_listScreen.setSize(this.width, stage.stageHeight - 350);
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
				messageButton.move(stage.stageWidth-100, 10);
				messageButton.setSize(80, 60);
				messageButton.addEventListener(Event.TRIGGERED, onMessageClick);
				renderer.addChild(messageButton);
				 
				var phoneButton:Button = new Button();
				phoneButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
				phoneButton.setSize(80, 60);
				phoneButton.move(stage.stageWidth-190, 10);
				phoneButton.addEventListener(Event.TRIGGERED, onPhoneClick);
				renderer.addChild(phoneButton);
				
				return renderer;
			 };
			 
			addChild(_listScreen);
			
			
			var arr:Array = GlobalDataProvider.commonEntity.residents;
			var autoCompleteArr:Vector.<String> = new Vector.<String>;
			for (var i:int = 0; i < arr.length; i++) 
			{
				_listScreen.dataProvider.addItem( { text:arr[i].name, index:i} );
				autoCompleteArr.push(arr[i].name);
			}
			
			this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
		}
		
		override protected function draw():void 
		{
			super.draw();
		}
		
		private function onAutoCompleteChange(e:Event):void 
		{
			if (_searchInput.text == "")
			{
				showFullList()
			}
		}
		
		private function showFullList():void
		{
			_listScreen.dataProvider.removeAll();
			
			//var arr:Array = GlobalDataProvider.residentsDataProvier.itemsArr;
			var arr:Array = GlobalDataProvider.commonEntity.residents;
			for (var i:int = 0; i < arr.length; i++) 
			{
				_listScreen.dataProvider.addItem( { text:arr[i].name } );
			}
		}
		
		private function onAutoCompleteClose(e:Event):void 
		{
			
			//var arr:Array = GlobalDataProvider.residentsDataProvier.itemsArr;
			var arr:Array = GlobalDataProvider.commonEntity.residents;
			
			if (_searchInput.text != "")
			{
				_listScreen.dataProvider.removeAll();
				for (var i:int = 0; i < arr.length; i++) 
				{
					if (_searchInput.text == arr[i].name)
					{
						_listScreen.dataProvider.addItem( { text:arr[i].name } );
					}
				}
			}
			
			if (!_listScreen.dataProvider.length)
			{
				showFullList();
			}
		}
		
		private function onAutoCompleteOpen(e:Event):void 
		{
			
		}
		
		private function onMessageClick(e:Event):void 
		{
			
		}
		
		private function onPhoneClick(e:Event):void 
		{
			
		}
		
	}

}