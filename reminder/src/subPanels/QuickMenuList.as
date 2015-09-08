package subPanels 
{
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import popups.PopupsController;
	import starling.core.RenderSupport;
	import starling.events.Event;
	import texts.TextLocaleHandler;
	import texts.TextsConsts;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class QuickMenuList extends SubPanel 
	{
		private var _list:List;
		
		public function QuickMenuList() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = TextLocaleHandler.getText(TextsConsts.QuickMenuTitle);
			this._list = new List();
			this._list.itemRendererFactory = function():IListItemRenderer
			{
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 return renderer;
			}
			
			_list.dataProvider = new ListCollection( [ 
					//{ text: "Login" }, 
					//{ text: "Change Language" }, 
					//{ text: "Remove ads" } 
					
					
					{ text: TextLocaleHandler.getText(TextsConsts.LoginButtonLabel) }, 
					{ text: TextLocaleHandler.getText(TextsConsts.LanguageButtonLabel) }, 
					{ text: TextLocaleHandler.getText(TextsConsts.RemoveAdsButtonLabel) }
					]);
					
			_list.addEventListener(Event.TRIGGERED, listItemTriggered );
			addChild(this._list);
			
			this.interactionMode
		}
		
		override public function render(support:RenderSupport, parentAlpha:Number):void 
		{
			super.render(support, parentAlpha);
			
			this.y = this.stage.stageHeight - this.bounds.height;
		}
		
		private function listItemTriggered(e:Event):void 
		{
			switch (_list.selectedIndex) 
			{
				case 0:
					PopupsController.addPopUp(new LoginPanel());
					break;
				case 1:
					PopupsController.addPopUp(new LoginPanel());
					break;
				case 2:
					PopupsController.addPopUp(new LoginPanel());
					break;
			}
			
			closeMe();
		}
		
	}

}