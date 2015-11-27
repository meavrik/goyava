package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.Radio;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenResidents extends ScreenSubMain 
	{
		private var _list:List;
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
			
			this.footerFactory = customFooterFactory;
			
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
			
			var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;
			
			var index:int = 0;
			_list = new List();
			_list.dataProvider = new ListCollection( []);
			_list.move(0, this._searchInput.bounds.bottom + 10);
			_list.setSize(this.width,this.height-160);
			_list.isSelectable = false;
			_list.itemRendererFactory = function():IListItemRenderer
			 {
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();

				renderer.labelField = "text";
				renderer.iconSourceField = "thumbnail";

				var label:Label = new Label();
				label.text = GlobalDataProvider.commonEntity.residents[index].address//"כתובת";
				label.styleNameList.add(Label.ALTERNATE_NAME_DETAIL);
				//label.move(35, 55);
				label.move(100, 55);

				renderer.addChild(label);
				 var messageButton:Button = new Button();
				messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
				messageButton.move(stage.stageWidth-100, 10);
				messageButton.setSize(80, 60);
				messageButton.addEventListener(Event.TRIGGERED, onMessageClick);
				renderer.addChild(messageButton);
				 
				var phoneButton:Button = new Button();
				phoneButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
				phoneButton.setSize(80, 60);
				phoneButton.move(stage.stageWidth-190, 10);
				phoneButton.addEventListener(Event.TRIGGERED, onPhoneClick);
				renderer.addChild(phoneButton);
				
				
				renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_LEFT; 
				renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				//renderer.index++;
				index++;
				return renderer;
			 };
			 
			addChild(_list);
			
			_list.itemRendererProperties.iconSourceFunction = function(item:Object):String
			{
				return "https://graph.facebook.com/v2.2/665289619/picture?type=square";
			}
			
			
			
			var arr:Array = GlobalDataProvider.commonEntity.residents;
			var autoCompleteArr:Vector.<String> = new Vector.<String>;
			for (var i:int = 0; i < arr.length; i++) 
			{
				_list.dataProvider.addItem( { text:arr[i].name, index:i} );
				autoCompleteArr.push(arr[i].name);
			}
			
			this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
		}
		
		private function accessorySourceFunction(item:Object):Check 
		{
			var chkbox:Check = new Check();
			return chkbox;
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
			_list.dataProvider.removeAll();
			
			//var arr:Array = GlobalDataProvider.residentsDataProvier.itemsArr;
			var arr:Array = GlobalDataProvider.commonEntity.residents;
			for (var i:int = 0; i < arr.length; i++) 
			{
				_list.dataProvider.addItem( { text:arr[i].name } );
			}
		}
		
		private function onAutoCompleteClose(e:Event):void 
		{
			
			//var arr:Array = GlobalDataProvider.residentsDataProvier.itemsArr;
			var arr:Array = GlobalDataProvider.commonEntity.residents;
			
			if (_searchInput.text != "")
			{
				_list.dataProvider.removeAll();
				for (var i:int = 0; i < arr.length; i++) 
				{
					if (_searchInput.text == arr[i].name)
					{
						_list.dataProvider.addItem( { text:arr[i].name } );
					}
				}
			}
			
			if (!_list.dataProvider.length)
			{
				showFullList();
			}
		}
		
		private function customFooterFactory():Header
		{
			var footer:Header = new Header();
			var sendAllButn:Button = new Button();
			sendAllButn.label = "שלח הודעה לחברים נבחרים";
			sendAllButn.x = 10;
			sendAllButn.setSize(this.stage.stageWidth - 20,  UiGenerator.getInstance().buttonHeight);
			sendAllButn.addEventListener(Event.TRIGGERED, onSendSelectedMessageClick);
			addChild(sendAllButn);
			footer.rightItems = new <DisplayObject>[sendAllButn];
			return footer;
		}
		
		private function onSendSelectedMessageClick(e:Event):void 
		{
			
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