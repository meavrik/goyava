package screens 
{
	import assets.AssetsHelper;
	import data.GlobalDataProvider;
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
	import screens.enums.ScreenEnum;
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
			
			this._list = new GroupedList();
			this._list.dataProvider = new HierarchicalCollection(
			[
				{
					header: "הניקוד שלי : " +GlobalDataProvider.userPlayer.score,
					children:
					[
						//{ label: "כל תרומה לקהילה מוסיפה לך ניקוד בהתאם"},
					]
				},
				{
					header: "קהילת אבן יהודה",
					children:
					[
						{ label: "(" + GlobalDataProvider.commonEntity.sellItems.length + ")" + " יד שניה" , event: ScreenEnum.SECOND_HAND_SCREEN, texture:StandardIcons.listDrillDownAccessoryTexture },
						{ label: "(" + GlobalDataProvider.commonEntity.groups.length + ")" + " קבוצות", event: ScreenEnum.GROUPS_SCREEN },
						{ label: "(" + GlobalDataProvider.commonEntity.residents.length + ")" + " תושבים", event: ScreenEnum.RESIDENTS_SCREEN },
						{ label: "ארועים", event: ScreenEnum.EVENTS_SCREEN },
						{ label: "אבדות ומציאות", event: ScreenEnum.LOST_AND_FOUND },
					]
				},
				{
					header: "שרותים",
					children:
					[
						{ label: "המועצה", event: ScreenEnum.COMUNITY_SCREEN },
						{ label: "מתנס", event: ScreenEnum.MATNAS_SCREEN },
						{ label: "חינוך", event: ScreenEnum.EDUCATION_SCREEN },
						{ label: "בריאות", event: ScreenEnum.MATNAS_SCREEN },
						{ label: "תחבורה", event: ScreenEnum.MATNAS_SCREEN },
						{ label: "מי שרונים", event: ScreenEnum.COMUNITY_SCREEN },
					]
				},
				{
					header: "עסקים",
					children:
					[
						{ label: "בתי עסק", event: ScreenEnum.BUSINESS_SCREEN },
						{ label: "אנשי מקצוע", event: ScreenEnum.BUSINESS_SCREEN },
						{ label: "נדל''ן", event: ScreenEnum.REALESTATE_SCREEN },
					]
				},
				{
					header: "כללי",
					children:
					[
						{ label: "טלפונים", event: ScreenEnum.COMUNITY_SCREEN },
						{ label: "מפה", event: ScreenEnum.MAP_SCREEN },
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
				renderer.iconSourceFunction = itemRendererAccessorySourceFunction;
				
				renderer.selectableField = "";
				renderer.selectableFunction = null
				//renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_LEFT; 
		
				renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_RIGHT

				return renderer;
			};
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			
			//this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChild(this._list);
			
			this._list.setSize(this.stage.stageWidth, this.stage.stageHeight - this._list.bounds.top - 160);
			
			_emergencyCallButton = new Button();
			_emergencyCallButton.styleNameList.add( Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON );
			_emergencyCallButton.label = "התקשר לקב''ט : " + PHONE_NUMBER;
			_emergencyCallButton.move(10, this._list.bounds.bottom + 10);
			_emergencyCallButton.setSize(this.stage.stageWidth - 20, 60);
			_emergencyCallButton.addEventListener(Event.TRIGGERED, onEmergancyCallClick);
			addChild(_emergencyCallButton);
			
			UiGenerator.getInstance().buttomPanelHeight = this.height;
			
			

			/*var sprite:PanelScreen = new PanelScreen();
			addChild(sprite);
			sprite.title = "test";
			
			
			
			drawers = new Drawers();
			drawers.content = sprite
			drawers.setSize(300, 50);
			 //drawers.bottomDrawer = screen;
			// drawers.move(100, 200);
			//drawers.bottomDrawerToggleEventType = Event.OPEN;
			this.addChild( drawers )
			
			drawers.bottomDrawer = new ScreenSellItemAdd();*/
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
				
				var settingsButton:Button = new Button();
				//settingsButton.styleNameList.add(Button.);
				settingsButton.height = 60;
				settingsButton.label = "0";
				settingsButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 1));
				//settingsButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
				header.leftItems = new <DisplayObject>
				[
					settingsButton
				];
				
			return header;
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