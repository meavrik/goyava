package screens 
{
	import assets.AssetsHelper;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Drawers;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.TabBar;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.skins.StandardIcons;
	import flash.display.Bitmap;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import panels.MessagePanelView;
	import popups.PopupsController;
	import screens.enums.ScreenEnum;
	import screens.gifts.GiftBox;
	import starling.display.DisplayObject;
	import starling.display.Graphics;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMainMenu extends PanelScreen 
	{
		[Embed(source = "../../bin/mainView.png")]
		private var MainViewPng:Class
		
		private const PHONE_NUMBER:String = "050-12345697";
		
		private var _list:GroupedList;
		private var _emergencyCallButton:Button;
		private var drawers:Drawers;
		private var _messagesButton:Button;
		
		private var _groupObject:Object;
		private var _usersObject:Object;
		private var _seconHandObject:Object;
		private var tabs:TabBar;
		private var _bgImage:Image;
		private var group2:ButtonGroup;
		
		
		public var savedVerticalScrollPosition:Number = 0;
		public var savedSelectedIndex:int = -1;
		
		public function ScreenMainMenu() 
		{
			super();
			
		}
		
		public function focus():void 
		{
			if (_list)
			{
				_list.selectedItem = null;
			}
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var bgImg:Bitmap = new MainViewPng();
			_bgImage = new Image(Texture.fromBitmap(bgImg));
			var factor:Number = stage.stageWidth / _bgImage.width;
			addChild(_bgImage);
			_bgImage.width = stage.stageWidth;
			_bgImage.height *= factor;
			
			var welcomeText:String = "בוקר טוב ";
			
			title = welcomeText + GlobalDataProvider.myUserData.name;
			
			this.headerFactory = this.customHeaderFactory;
			this.footerFactory = this.customFooterFactory;
			
			/*tabs = new TabBar();
			 tabs.dataProvider = new ListCollection(
			 [
				 { defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 10) ) },
				 {defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 11))},
				 { defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 12))},
				 { defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 13))},
				 { defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 14))},
			 ]);
			 tabs.selectedIndex = 1;
			 tabs.setSize(stage.stageWidth, 80);
			 tabs.y = 100;
			img.y = tabs.bounds.bottom;
			 tabs.addEventListener( Event.CHANGE, tabs_changeHandler );
			 this.addChild( tabs );*/
			
			showList();
			//addButtons();
			
	 
			AppDataLoader.getInstance().addEventListener(AppDataLoader.MY_MESSAGES_LOADED, onMessagesLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.GROUPS_DATA_LOADED, onGroupsLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.USERS_DATA_LOADED, onUsersLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.SELLITEMS_DATA_LOADED, onSellItemLoaded);
		}
		
		
		
		
		private function addButtons():void
		{
			var header:Header = new Header();
			header.move(0, _bgImage.bounds.bottom);
			header.setSize(this.stage.stageWidth, 50);
			header.title = "קהילת אבן יהודה";
			addChild(header);
			
			var group:ButtonGroup = new ButtonGroup();
			//group.move(5, header.bounds.bottom + 5);
			//group.width = stage.stageWidth/2-10;
			
			group.move(5, header.bounds.bottom + 5);
			group.width = stage.stageWidth-10;
			
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.dataProvider = new ListCollection(
			 [
				 { 	label: "קבוצות",
					defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 10)), 
					triggered:onMenuButtonClick(ScreenEnum.GROUPS_SCREEN)
				 },
				 
				 { label: "תושבים" ,defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 11))},
				 { label: "יד שניה", defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 12)) },
			 ]);
			 

			 group.buttonFactory = function():Button
			 {
				 var button:Button = new Button();
				 button.iconPosition = Button.ICON_POSITION_LEFT;
				 /*var spr:Sprite = new Sprite();
				 var g:Graphics=new Graphics(spr)
				 g.beginFill(0);
				 g.drawCircle(0, 0, 50);
				 g.endFill();*/
				 button.defaultSkin = null;
				// button.setSize(100, 100);
				 return button;
			 };
			this.addChild( group );
	
			group2 = new ButtonGroup();
			group2.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			//group2.move(group.width + 10, group.y);
			//group2.width = stage.stageWidth / 2 - 5;
			
			group2.move(5, group.bounds.bottom+60);
			group2.width = stage.stageWidth-10;
			
			group2.dataProvider = new ListCollection(
			 [
				 { label: "ארועים",defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 13)) },
				 { label: "אבדות ומציאות" ,defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 14))},
				 { label: "ילדים ונוער", defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 15)) },
			 ]);
			 
			group2.buttonFactory = group.buttonFactory;
			group2.addEventListener(FeathersEventType.CREATION_COMPLETE, onGroupComplete);
			this.addChild( group2 );
		}
		
		private function onMenuButtonClick(eventString:String):void 
		{
			this.dispatchEventWith(eventString);
		}
		
		private function onGroupComplete(e:Event):void 
		{
			var header2:Header = new Header();
			header2.move(0, group2.bounds.bottom+5);
			header2.setSize(this.stage.stageWidth, 50);
			header2.title = "שרות לתושב";
			addChild(header2);
			
			var group3:ButtonGroup = new ButtonGroup();
			group3.move(5, header2.bounds.bottom + 5);
			group3.width = stage.stageWidth/2-10;
			group3.dataProvider = new ListCollection(
			 [
				 { label: "המועצה",defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 16)) },
				 { label: "מתנס" ,defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 17))},
				 { label: "חינוך", defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 18)) },
			 ]);
			 
			group3.buttonFactory = group2.buttonFactory;
			this.addChild( group3 );
	 
			var group4:ButtonGroup = new ButtonGroup();
			group4.move(group3.width + 10, group3.y);
			group4.width = stage.stageWidth / 2 - 5;
			group4.dataProvider = new ListCollection(
			 [
				 { label: "ארועים",defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 19)) },
				 { label: "אבדות ומציאות" ,defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 20))},
				 { label: "ילדים ונוער", defaultIcon: new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 21)) },
			 ]);
			 
			group4.buttonFactory = group2.buttonFactory;
			this.addChild( group4 );
			
		}
		
		
		
		
		
		
		
		
		
		private function showList():void 
		{
			_groupObject = { 	label: " קבוצות", event: ScreenEnum.GROUPS_SCREEN,
								thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 10) };
			
			_usersObject = { 	label: " תושבים", event: ScreenEnum.RESIDENTS_SCREEN,
								thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 11) };
			
			_seconHandObject = {label: " יד שניה" , event: ScreenEnum.SECOND_HAND_SCREEN, 
								thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 9) }
			
								
			this._list = new GroupedList();
			this._list.move(0, _bgImage.bounds.bottom);
			this._list.dataProvider = new HierarchicalCollection(
			[
				{
					header: "ניקוד : " +GlobalDataProvider.myUserData.score,
					children:
					[
						//{ label: "כל תרומה לקהילה מוסיפה לך ניקוד בהתאם"},
					]
				},
				{
					header: "קהילת אבן יהודה",
					children:
					[
						_seconHandObject
						,
						_groupObject
						,
						_usersObject
						,
						{ 	label: "ארועים", event: ScreenEnum.EVENTS_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 12)
						},
						{ 	label: "אבדות ומציאות", event: ScreenEnum.LOST_AND_FOUND,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 13)
						},
					]
				},
				{
					header: "שרותים",
					children:
					[
						{ 	label: "המועצה", event: ScreenEnum.COMUNITY_SCREEN ,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 14)
						},
						{ 
							label: "מתנס", event: ScreenEnum.MATNAS_SCREEN, 
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 15) 
						},
						{ 
							label: "חינוך", event: ScreenEnum.EDUCATION_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 16)
						},
						{ 
							label: "בריאות", event: ScreenEnum.MATNAS_SCREEN ,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 17)
						},
						{ 
							label: "תחבורה", event: ScreenEnum.MATNAS_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 18)
						},
						{ 
							label: "מי שרונים", event: ScreenEnum.COMUNITY_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 19)
						},
					]
				},
				{
					header: "עסקים",
					children:
					[
						{ 	
							label: "בתי עסק", event: ScreenEnum.BUSINESS_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 20) 
						},
						{ 	
							label: "אנשי מקצוע", event: ScreenEnum.BUSINESS_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 21) 
						},
						{ 	
							label: "נדל''ן", event: ScreenEnum.REALESTATE_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 22) 
						},
					]
				},
				{
					header: "כללי",
					children:
					[
						{ 
							label: "טלפונים", event: ScreenEnum.COMUNITY_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 23) 
						},
						{ 
							label: "מפה", event: ScreenEnum.MAP_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 24) 
						},
					]
				}
			]);

			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;

			this._list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				//var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				
				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "label";
				
				renderer.iconSourceField = "thumbnail";
				renderer.height = 100;
				renderer.itemIndex++
				renderer.isEnabled = false;

				//renderer.selectableField = "isSelected";
				//renderer.selectableFunction = null
				renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_LEFT; 
		
				renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_RIGHT

				return renderer;
			};
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			
			//this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChild(this._list);
			
			this._list.setSize(this.stage.stageWidth, this.stage.stageHeight - this._list.bounds.top - 160);
		}
		
		private function onSellItemLoaded(e:Event):void 
		{
			_seconHandObject.label = "(" + GlobalDataProvider.sellItems.length + ")" + " יד שניה"
			this._list.dataProvider.updateItemAt(1);
		}
		
		private function onUsersLoaded(e:Event):void 
		{
			_usersObject.label = "(" + GlobalDataProvider.users.length + ")" + " תושבים"
			this._list.dataProvider.updateItemAt(1);
		}
		
		private function onGroupsLoaded(e:Event):void 
		{
			_groupObject.label = "(" + GlobalDataProvider.groups.length + ")" + " קבוצות";
			this._list.dataProvider.updateItemAt(1);
		}
		
		private function onMessagesLoaded(e:Event):void 
		{
			_messagesButton.label = GlobalDataProvider.myMessages.length?GlobalDataProvider.myMessages.length.toString():"";
			_messagesButton.isEnabled = GlobalDataProvider.myMessages.length?true:false;
		}
		
		
		
		private function showGift(position:Number):void
		{
			var giftBox:GiftBox = new GiftBox();
			
			giftBox.y = -100;
			addChild(giftBox);
			giftBox.x = stage.stageWidth / 4 - giftBox.width / 2 + position;
			
			giftBox.play();
		}
		
		private function onEmergancyCallClick(e:Event):void 
		{
			const callURL:String = "tel:" + PHONE_NUMBER;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function customFooterFactory():Header
		{
			var footer:Header = new Header();
			var _emergencyCallButton:Button = new Button();
			_emergencyCallButton.styleNameList.add( Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON );
			_emergencyCallButton.label = "התקשר לקב''ט : " + PHONE_NUMBER;
			_emergencyCallButton.x = 10;
			_emergencyCallButton.setSize(this.stage.stageWidth - 20,  UiGenerator.getInstance().buttonHeight);
			_emergencyCallButton.addEventListener(Event.TRIGGERED, onEmergancyCallClick);
			addChild(_emergencyCallButton);
			footer.rightItems = new <DisplayObject>[_emergencyCallButton];
			return footer;
		}
		
		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout

			var myButton:Button = new Button();
			myButton.styleNameList.add(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			myButton.label = "הגדרות";
			myButton.height = 60;
			myButton.addEventListener(Event.TRIGGERED, myAreaClick);
			header.rightItems = new <DisplayObject>
			[
				myButton
			];
			
			_messagesButton = new Button();
			//settingsButton.styleNameList.add(Button.);
			//var num:int = GlobalDataProvider.userPlayer.myMessages.length;
			//var num:int = GlobalDataProvider.myMessages;
			
			_messagesButton.height = myButton.height;
			//_messagesButton.label = num.toString();
			_messagesButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
			_messagesButton.isEnabled = false;
			_messagesButton.addEventListener(Event.TRIGGERED, onMessagesClick);
			header.leftItems = new <DisplayObject>[_messagesButton];
				
			return header;
		}
		
		private function onMessagesClick(e:Event):void 
		{
			PopupsController.addPopUp(new MessagePanelView());
		}
		
		private function list_changeHandler(event:Event):void
		{
			trace("pick : " + event);
			if (!this._list.selectedItem) return;
			var eventType:String = this._list.selectedItem.event as String;

			this.dispatchEventWith(eventType);

			//save the list's scroll position and selected index so that we
			//can restore some context when this screen when we return to it
			//again later.
			/*this.dispatchEventWith(eventType, false,
			{
				savedVerticalScrollPosition: this._list.verticalScrollPosition
				//savedSelectedIndex: this._list.selectedIndex
			});*/
		}
		
		private function myAreaClick(e:Event):void 
		{
			//PopupsController.addPopUp(new PersonalPanel())
			
			dispatchEvent(new Event(ScreenEnum.MY_AREA_SCREEN));
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
	}

}