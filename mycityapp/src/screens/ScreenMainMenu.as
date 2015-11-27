package screens 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Query;
	import data.GlobalDataProvider;
	import entities.MessageEntity;
	import feathers.controls.Button;
	import feathers.controls.Drawers;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.skins.StandardIcons;
	import flash.display.Bitmap;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import log.Logger;
	import panels.MessagePanelView;
	import popups.PopupsController;
	import screens.enums.ScreenEnum;
	import screens.gifts.GiftBox;
	import starling.display.DisplayObject;
	import starling.display.Image;
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
		public var savedVerticalScrollPosition:Number = 0;
		public var savedSelectedIndex:int = -1;
		
		public function ScreenMainMenu() 
		{
			super();
			
		}
		
		public function focus():void 
		{
			this._list.selectedItem = null;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var bgImg:Bitmap = new MainViewPng();
			var img:Image = new Image(Texture.fromBitmap(bgImg));
			var factor:Number = stage.stageWidth / img.width;
			addChild(img);
			img.width = stage.stageWidth;
			img.height *= factor;
			
			var welcomeText:String = "בוקר טוב ";
			
			title = welcomeText + GlobalDataProvider.userPlayer.name;
			
			this.headerFactory = this.customHeaderFactory;
			this.footerFactory = this.customFooterFactory;
			
			this._list = new GroupedList();
			this._list.dataProvider = new HierarchicalCollection(
			[
				{
					header: "ניקוד : " +GlobalDataProvider.userPlayer.score,
					children:
					[
						//{ label: "כל תרומה לקהילה מוסיפה לך ניקוד בהתאם"},
					]
				},
				{
					header: "קהילת אבן יהודה",
					children:
					[
						{ 	label: "(" + GlobalDataProvider.commonEntity.sellItems.length + ")" + " יד שניה" , event: ScreenEnum.SECOND_HAND_SCREEN, 
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 9) },
						{ 	label: "(" + GlobalDataProvider.commonEntity.groups.length + ")" + " קבוצות", event: ScreenEnum.GROUPS_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 10)
						},
						{ 	label: "(" + GlobalDataProvider.commonEntity.residents.length + ")" + " תושבים", event: ScreenEnum.RESIDENTS_SCREEN,
							thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 11)
						},
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

			this._list.move(0, img.bounds.bottom);
			
			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			var itemRendererAccessorySourceFunction:Function = this.accessorySourceFunction;

			var sWidth:Number = this.width;
			//this._list.clipContent = false;
			//this._list.autoHideBackground = true;
			//this._list.itemRendererFactory = function():IListItemRenderer
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

				renderer.selectableField = "";
				renderer.selectableFunction = null
				renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_LEFT; 
		
				renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_RIGHT

				return renderer;
			};
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			
			//this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChild(this._list);
			
			this._list.setSize(this.stage.stageWidth, this.stage.stageHeight - this._list.bounds.top - 160);
			
			//var panel:GiftsPanel = new GiftsPanel();
			//PopupsController.addPopUp(panel);
			
			getMyMessages();
		}
		
		private function getMyMessages():void 
		{
			var query:Query = new Query(MessageEntity, "toUserId == ?", GlobalDataProvider.userPlayer.id);
			query.find(
				function onComplete(tracks:Array):void {
					//The tracks array contains all tracks the current player
					//is allowed to see.
					//trace("FOUND MESSAGES FOR rcTpuC0k5YPXS7qL === " + tracks);
					Logger.logInfo("messages found : {0}", tracks);
					
					GlobalDataProvider.myMessages = tracks;
					
					_messagesButton.isEnabled = tracks.length?true:false;
					_messagesButton.label = tracks.length.toString();
				},
				function onError(error:String):void {
					//Something went wrong during the execution of the query.
					//The player's device may be offline.
					Logger.logError(this, "error getting my messages : " + error);
				}
			);
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
			if (!this._list.selectedItem) return;
			var eventType:String = this._list.selectedItem.event as String;

			this.dispatchEventWith(eventType);

			//save the list's scroll position and selected index so that we
			//can restore some context when this screen when we return to it
			//again later.
			this.dispatchEventWith(eventType, false,
			{
				savedVerticalScrollPosition: this._list.verticalScrollPosition
				//savedSelectedIndex: this._list.selectedIndex
			});
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