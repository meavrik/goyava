package screens 
{
	import assets.AssetsHelper;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import entities.FloxUser;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import panels.MessagePanelSend;
	import popups.PopupsController;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import ui.buttons.MailButton;
	import ui.buttons.MainCallButton;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenResidents extends ScreenSubMain 
	{
		private var _list:List;
		private var _searchInput:AutoComplete;
		private var _sendAllButn:Button;
		private var _footer:Header;
		private var _dataProviderArr:Vector.<FloxUser>;
		
		public function ScreenResidents() 
		{
			super();

			title = "רשימת תושבים"
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			_sendAllButn = new Button();
			_sendAllButn.isEnabled = false;
			
			this.footerFactory = customFooterFactory;
			
			this._searchInput = new AutoComplete();
			this._searchInput.autoCompleteDelay = .1;
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
			this._searchInput.prompt = "מצא תושב";
			this._searchInput.setSize(this.width - 10, UiGenerator.getInstance().fieldHeight);
			this._searchInput.move(5, 10);
			this._searchInput.addEventListener(Event.OPEN, onAutoCompleteOpen);
			this._searchInput.addEventListener(Event.CLOSE, onAutoCompleteClose);
			this._searchInput.addEventListener(Event.CHANGE, onAutoCompleteChange);
			this.addChild(this._searchInput);
			
			var index:int = 0;
			_list = new List();
			_list.dataProvider = new ListCollection( []);
			_list.move(0, this._searchInput.bounds.bottom + 10);
			//_list.isSelectable = false;
			_list.allowMultipleSelection = true;
			_list.itemRendererFactory = function():IListItemRenderer
			 {
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();

				renderer.labelField = "text";
				renderer.iconSourceField = "thumbnail";
				renderer.index = index;
				//renderer.iconOffsetX = 25;

				var label:Label = new Label();
				//label.text = GlobalDataProvider.commonEntity.residents[index].address;
				label.text = _dataProviderArr[index].address;
				label.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);
				//label.move(35, 55);
				label.move(100, 55);
				label.height = 200;
		
				renderer.addChild(label);
				var messageButton:MailButton = new MailButton(onMessageClick);
				messageButton.scaleX = messageButton.scaleY = .8;
				messageButton.x = stage.stageWidth - 100;
				messageButton.y = 10;
				//messageButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 2));
				//messageButton.move(stage.stageWidth - 100, 10);
				//messageButton.setSize(80, 80);
				//messageButton.addEventListener(Event.TRIGGERED, onMessageClick);
				renderer.addChild(messageButton);
				 
				
				var phoneButton:MainCallButton = new MainCallButton(onPhoneClick);
				phoneButton.scaleX = phoneButton.scaleY = .8;
				phoneButton.x = stage.stageWidth - 200;
				phoneButton.y = 10;
				renderer.addChild(phoneButton);
				/*var phoneButton:Button = new Button();
				phoneButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
				phoneButton.setSize(80, 80);
				phoneButton.move(stage.stageWidth - 190, 10);
				phoneButton.addEventListener(Event.TRIGGERED, onPhoneClick);
				renderer.addChild(phoneButton);*/
				
				renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_LEFT; 
				renderer.addEventListener(Event.CHANGE, onSelect);

				index++;
				return renderer;
			 };
			 
			addChild(_list);
			
			_list.itemRendererProperties.iconSourceFunction = function(item:Object):String
			{
				return "https://graph.facebook.com/v2.2/665289619/picture?type=square";
			}
			
			if (GlobalDataProvider.users && GlobalDataProvider.users.length)
			{
				handleListData()
			} else
			{
				showPreloader();
			}
				
			AppDataLoader.getInstance().addEventListener(AppDataLoader.USERS_DATA_LOADED, onUsersLoaded);
			
		}
		
		private function handleListData():void 
		{
			removePreloader();
			_dataProviderArr = new Vector.<FloxUser>;
			_dataProviderArr = _dataProviderArr.concat(GlobalDataProvider.users);
			_dataProviderArr.sort(sortList)
			
			updateList();
		}
		
		private function sortList(itemA:FloxUser, itemB:FloxUser):int 
		{
			if (itemA.name.charAt(0) > itemB.name.charAt(0))
			{
				return 1;
			} else if (itemA.name.charAt(0) < itemB.name.charAt(0))
			{
				return -1;
			}
			return 0;
		}
		
		private function onUsersLoaded(e:Event):void 
		{
			handleListData()
		}
		
		private function updateList():void
		{
			var autoCompleteArr:Vector.<String> = new Vector.<String>;
			
			for (var i:int = 0; i <_dataProviderArr.length; i++) 
			{
				addItemToList(i);
				autoCompleteArr.push(_dataProviderArr[i].name);
			}
			
			this._searchInput.source = new LocalAutoCompleteSource(new ListCollection(autoCompleteArr));
		}
		
		private function addItemToList(index:int):void
		{
			_list.dataProvider.addItem( { text:_dataProviderArr[index].name, index:index, ownerId:_dataProviderArr[index].ownerId } );
		}
		
		private function onSelect(e:Event):void 
		{
			_sendAllButn.isEnabled = _list.selectedItems.length > 0?true:false;
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
			
			for (var i:int = 0; i < _dataProviderArr.length; i++) 
			{
				addItemToList(i);
			}
		}
		
		private function onAutoCompleteClose(e:Event):void 
		{
			if (_searchInput.text != "")
			{
				_list.dataProvider.removeAll();
				for (var i:int = 0; i < _dataProviderArr.length; i++) 
				{
					if (_searchInput.text == _dataProviderArr[i].name)
					{
						//_list.dataProvider.addItem( { text:arr[i].name, id:"123" } );
						addItemToList(i);
					}
				}
			}
			
			if (!_list.dataProvider.length)
			{
				showFullList();
			}
		}
		
		override protected function draw():void 
		{
			super.draw();
			_list.setSize(this.width, this.height - _footer.bounds.height * 2 - _list.bounds.y);
		}
		
		private function customFooterFactory():Header
		{
			_footer = new Header();
			
			_sendAllButn.label = "שלח הודעה לחברים נבחרים";
			//_sendAllButn.x = 10;
			//_sendAllButn.setSize(this.stage.stageWidth - 20,  UiGenerator.getInstance().buttonHeight);
			_sendAllButn.width = this.stage.stageWidth - 40;
			_sendAllButn.addEventListener(Event.TRIGGERED, onSendSelectedMessageClick);
			addChild(_sendAllButn);
			_footer.centerItems = new <DisplayObject>[_sendAllButn];
			
			
			return _footer;
		}
		
		private function onSendSelectedMessageClick(e:Event):void 
		{
			
		}
		
		private function onAutoCompleteOpen(e:Event):void 
		{
			
		}
		
		private function onMessageClick(e:Event):void 
		{
			var renderer:DefaultListItemRenderer = Button(e.currentTarget).parent as DefaultListItemRenderer;
			trace("SEN TO == " + _list.dataProvider.getItemAt(renderer.index).ownerId);
			//var id:String = _list.dataProvider.getItemAt(renderer.index).id;
			var messagePanel:MessagePanelSend = new MessagePanelSend(_list.dataProvider.getItemAt(renderer.index).ownerId, _list.dataProvider.getItemAt(renderer.index).text);
			PopupsController.addPopUp(messagePanel);
		}
		
		private function onPhoneClick():void 
		{
			
		}
		
	}

}