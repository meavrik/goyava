package panels 
{
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import data.GlobalDataProvider;
	import entities.GroupEntity;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.ScrollText;
	import feathers.data.ListCollection;
	import screens.BaseListScreen;
	import starling.events.Event;
	import ui.UiGenerator;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class ViewGroupDetailsPanel extends BasePopupPanel 
	{
		private var _friendsList:BaseListScreen;
		private var _dataProvider:GroupEntity;
		private var _joinButton:Button;
		private var _detailLabel:Label;
		private var _id:int;
		
		//public function GroupDetailsPanel(dataProvider:Object) 
		public function ViewGroupDetailsPanel(id:int) 
		{
			super();
			
			this._id = id
			//this._dataProvider = dataProvider;
			
		}
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			Entity.load(GroupEntity, _id.toString(), onLoadDataComplete, onLoadDataFail);
			
			title = "טוען"//this._dataProvider.name;
			_detailLabel = new Label();
			//label.text = "נפגשים כל יום בשש לשחק כדורגל במגרש ליד ביהס ברחוב ההדרים";
			_detailLabel.text = "";//this._dataProvider.description;
			_detailLabel.wordWrap = true;

			_detailLabel.setSize(this.width - 40, 120);
			_detailLabel.move(5, 10);
			_detailLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			addChild(_detailLabel)
			
			_joinButton = new Button();
			_joinButton.label = "בקש להצטרף";
			_joinButton.move(10, _detailLabel.bounds.bottom+10);
			_joinButton.setSize(UiGenerator.getInstance().buttonWidth, UiGenerator.getInstance().buttonHeight);
			_joinButton.addEventListener(Event.TRIGGERED, onJoinClick);
			addChild(_joinButton);
			
			var listTitle:Label = new Label();
			listTitle.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			listTitle.text = "חברים בקבוצה";
			listTitle.setSize(this.width-40, 30);
			//listTitle.paddingLeft = 100;
			
			listTitle.move(10, _joinButton.bounds.bottom + 10);
			addChild(listTitle);
			_friendsList = new BaseListScreen()
		
			_friendsList.itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 renderer.height = 20;
				 return renderer;
			 };
	 
			 _friendsList.dataProvider = new ListCollection([]);
			 
			_friendsList.move(0, listTitle.bounds.bottom + 10);
			_friendsList.setSize(this.width-40, stage.stageHeight / 2);
			
			addChild(_friendsList);
		}
		
		private function onLoadDataFail():void 
		{
			
		}
		
		private function onLoadDataComplete(data:GroupEntity):void 
		{
			//Flox.logInfo("onLoadDataComplete " + data.name);
			this._dataProvider = data;
			
			title = this._dataProvider.name;
			_detailLabel.text = this._dataProvider.description;
			
			for each (var item:Object in _dataProvider.members) 
			{
				if (item.name)
				{
					_friendsList.dataProvider.addItem( { text:item.name } );
				}
			}
		}
		
		
		
		private function onJoinClick(e:Event):void 
		{
			this._dataProvider.addMeToGroup();
			_joinButton.isEnabled = false;
			var alert:Alert = Alert.show("הבקשה נשלחה", "הקבוצה", new ListCollection(
			[
				{ label: "סבבה" },
				//{ label: "Cancel" }
			]));
			alert.width = this.width - 40;
			alert.addEventListener(Event.CLOSE, alert_closeHandler);
			
			GlobalDataProvider.userPlayer.myGroups.push(this._dataProvider.name);
			GlobalDataProvider.userPlayer.save(null, null);
		}
		
		private function alert_closeHandler(e:Event):void 
		{
			
		}
		
	}

}