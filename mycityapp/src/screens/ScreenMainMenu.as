package screens 
{
	import assets.AssetsHelper;
	import data.AppDataLoader;
	import data.GlobalDataProvider;
	import feathers.controls.Button;
	import feathers.controls.Drawers;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import panels.MessagePanelView;
	import popups.PopupsController;
	import screens.enums.ScreenEnum;
	import screens.gifts.GiftBox;
	import screens.mainMenu.MainMenuList;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.buttons.CallButton;
	import ui.buttons.ProfileButton;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ScreenMainMenu extends PanelScreen 
	{
		[Embed(source = "../../bin/mainView.png")]
		private var MainViewPng:Class
		
		private const PHONE_NUMBER:String = "050-12345697";

		private var drawers:Drawers;
		private var _messagesButton:Button;
		
		private var _groupObject:Object;
		private var _usersObject:Object;
		private var _seconHandObject:Object;
		private var _bgImage:Image;
		private var _footer:Header;
		private var _insideMenu:MainMenuList;
		private var _header:Header;
		private var _profileButton:ProfileButton;
		
		private var _emergencyCallMainButton:CallButton;
		private var _emergencyCallButton:CallButton;
		private var _emergencyCallButton2:CallButton;
		private var _callOpen:Boolean;
		
		public function ScreenMainMenu() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_footer = new Header();
			
			_header = new Header();
			_profileButton = new ProfileButton(profileButtonClick);
			/*_profileButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
			_profileButton.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 5));
			_profileButton.scaleX = _profileButton.scaleY = .7;*/
			//_profileButton.addEventListener(Event.TRIGGERED, profileButtonClick);
			_header.leftItems = new <DisplayObject>[_profileButton];

			var bgImg:Bitmap = new MainViewPng();
			_bgImage = new Image(Texture.fromBitmap(bgImg));
			var factor:Number = stage.stageWidth / _bgImage.width;
			addChild(_bgImage);
			_bgImage.width = stage.stageWidth;
			_bgImage.height *= factor;
			
			var welcomeText:String = "בוקר טוב ";
			title = welcomeText + GlobalDataProvider.myUserData.name;
			
			this.headerFactory = this.customHeaderFactory;
			//this.footerFactory = this.customFooterFactory;
			
			AppDataLoader.getInstance().addEventListener(AppDataLoader.MY_MESSAGES_LOADED, onMessagesLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.GROUPS_DATA_LOADED, onGroupsLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.USERS_DATA_LOADED, onUsersLoaded);
			AppDataLoader.getInstance().addEventListener(AppDataLoader.SELLITEMS_DATA_LOADED, onSellItemLoaded);
			
			var dataObj:Object = 
				[ {
					header: "במושבה",
					children:
					[
						addNewDataItem("עסקים במושבה", ScreenEnum.BUSINESS_SCREEN, 10),
						addNewDataItem("אנשי מקצוע באזור", ScreenEnum.BUSINESS_SCREEN, 11),
						addNewDataItem("מתנס : צהרונים, חוגים וארועים", ScreenEnum.MATNAS_SCREEN, 5),
						addNewDataItem("בתי ספר וגנים", ScreenEnum.EDUCATION_SCREEN, 6),
						addNewDataItem("בריאות", ScreenEnum.MATNAS_SCREEN, 7),
						addNewDataItem("תחבורה", ScreenEnum.MATNAS_SCREEN, 14),
						addNewDataItem("נדל''ן", ScreenEnum.REALESTATE_SCREEN, 5),
					]	
					
				},
				{
					header: "בקהילה",
					children:
					[
						_usersObject = addNewDataItem("תושבים", ScreenEnum.RESIDENTS_SCREEN, 2),
						_seconHandObject = addNewDataItem("יד שניה", ScreenEnum.SECOND_HAND_SCREEN, 0,5),
						_groupObject = addNewDataItem("קבוצות", ScreenEnum.GROUPS_SCREEN, 1,2),
						addNewDataItem("ארועים", ScreenEnum.EVENTS_SCREEN, 3,1),
						addNewDataItem("אבדות ומציאות", ScreenEnum.LOST_AND_FOUND_SCREEN, 4),
						addNewDataItem("התנדבות בקהילה", ScreenEnum.LOST_AND_FOUND_SCREEN, 17),
					]
				},
				{
					header: "אישי",
					children:
					[
						addNewDataItem("הטבות ומבצעים עבורך", ScreenEnum.MATNAS_SCREEN, 16),
						addNewDataItem("הודעות", ScreenEnum.MATNAS_SCREEN, 15),
						addNewDataItem("מפה", ScreenEnum.MAP_SCREEN, 14),
					]
				},
				/*{
					header: "שימושי",
					children:
					[
						addNewDataItem("המועצה", ScreenEnum.COMUNITY_SCREEN, 5),
						addNewDataItem("טלפונים", ScreenEnum.COMUNITY_SCREEN, 14),
						addNewDataItem("מפה", ScreenEnum.MAP_SCREEN, 15),
					]
				}*/]
			
			this._insideMenu = new MainMenuList(dataObj);
			this._insideMenu.move(0, _bgImage.bounds.bottom);
			addChild(_insideMenu);
			
			_emergencyCallMainButton = new CallButton(onEmergancyCallClick, 1);
			_emergencyCallMainButton.x = stage.stageWidth - _emergencyCallMainButton.width-20;
			_emergencyCallMainButton.y = stage.stageHeight-_emergencyCallMainButton.height-150;
			addChild(_emergencyCallMainButton);
		}
		
		private function addNewDataItem(text:String, eventName:String, iconIndex:Number,count:int=0):Object 
		{
			return { 	label: text,
						count:count,
						event: eventName, 
						thumbnail:AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.MAIN_MENU_ICONS, iconIndex)
						};
		}
		
		private function onSellItemLoaded(e:Event):void 
		{
			_seconHandObject.label = "(" + GlobalDataProvider.sellItems.length + ")" + " יד שניה"
			this._insideMenu.update(0);
		}
		
		private function onGroupsLoaded(e:Event):void 
		{
			_groupObject.label = "(" + GlobalDataProvider.groups.length + ")" + " קבוצות";
			this._insideMenu.update(1);
		}
		
		private function onUsersLoaded(e:Event):void 
		{
			_usersObject.label = "(" + GlobalDataProvider.users.length + ")" + " תושבים"
			this._insideMenu.update(2);
		}
		
		private function onMessagesLoaded(e:Event):void 
		{
			//_messagesButton.label = GlobalDataProvider.myMessages.length?GlobalDataProvider.myMessages.length.toString():"";
			//_messagesButton.isEnabled = GlobalDataProvider.myMessages.length?true:false;
			//_profileButton.label = GlobalDataProvider.myMessages.length?GlobalDataProvider.myMessages.length.toString():"";
			if (GlobalDataProvider.myMessages.length)
			{
				_profileButton.messageCounter = GlobalDataProvider.myMessages.length;
			}
		}
		
		private function showGift(position:Number):void
		{
			var giftBox:GiftBox = new GiftBox();
			
			giftBox.y = -100;
			addChild(giftBox);
			giftBox.x = stage.stageWidth / 4 - giftBox.width / 2 + position;
			
			giftBox.play();
		}
		
		private function onEmergancyCall2Click(e:Event):void 
		{
			const callURL:String = "tel:" + PHONE_NUMBER;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);
		}
		
		private function onEmergancyCallClick(e:Event):void 
		{
			/*const callURL:String = "tel:" + PHONE_NUMBER;
			var targetURL:URLRequest = new URLRequest(callURL);
			navigateToURL(targetURL);*/
			
			
			dispatchEventWith(ScreenEnum.VIEW_MAIN_PHONE_CALLS);
			
			/*_callOpen = !_callOpen;

			var target1:Point
			var target2:Point
			var transition:String;
			if (_callOpen)
			{
				target1 = new Point(_emergencyCallMainButton.x - 120, _emergencyCallMainButton.y - 20);
				target2 = new Point(_emergencyCallMainButton.x - 20, _emergencyCallMainButton.y - 120);
				transition=Transitions.EASE_OUT_BACK;
				addChild(_emergencyCallButton2);
				addChild(_emergencyCallButton);
				addChild(_emergencyCallMainButton);
			} else
			{
				transition=Transitions.EASE_IN_BACK;
				target1 = new Point(_emergencyCallMainButton.x, _emergencyCallMainButton.y);
				target2 = new Point(_emergencyCallMainButton.x, _emergencyCallMainButton.y);
			}
				
			var tween:Tween = new Tween(_emergencyCallButton, .4,transition);
			tween.moveTo(target1.x, target1.y);
			Starling.juggler.add(tween);
			
			tween= new Tween(_emergencyCallButton2, .4,transition);
			tween.moveTo(target2.x, target2.y);
			Starling.juggler.add(tween);*/
			
			
			

		}
		
		private function customFooterFactory():Header
		{
			return _footer;
		}
		
		private function customHeaderFactory():Header
		{
			return _header;
		}
		
		public function focus():void 
		{
			/*if (_list)
			{
				_list.selectedItem = null;
			}*/
			_insideMenu.focus();
		}
		
		private function onMessagesClick(e:Event):void 
		{
			PopupsController.addPopUp(new MessagePanelView());
		}
		
		private function profileButtonClick(e:Event):void 
		{
			dispatchEvent(new Event(ScreenEnum.MY_AREA_SCREEN));
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
	}

}