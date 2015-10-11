package 
{
	import assets.AssetsHelper;
	import com.gamua.flox.Flox;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.TextInput;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import feathers.events.FeathersEventType;
	import flash.text.TextFormat;
	import popups.PopupsController;
	import renderers.UrikaTextFieldTextRenderer;
	import screens.events.ScreenEvent;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import subPanels.DeleteTaskPanel;
	import subPanels.EditTaskPanel;
	import users.UserGlobal;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class BaseListScreen extends PanelScreen 
	{
		private var _defaultEmptyTaskText:String = "Add my first reminder";
		
		private var _addButton:Button;
		protected var _autoCompleteInput:AutoComplete;
		private var _tasksList:List;
		private var _deleteTaskPanel:DeleteTaskPanel;
		private var _editTaskPanel:EditTaskPanel;
		private var _currentPanel:Panel;
		protected var _selectedItem:DefaultListItemRenderer;
		private var editInputTf:TextInput;
		protected var _listArr:Array;
		protected var _currentTaskName:String;
		
		public function BaseListScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addNewReminderkButton();
			addSubPanels()
			addTaskList();
			
			this.y = 90;
			
			/*var label:Label = new Label();
			label.text = _defaultEmptyTaskText;

			Callout.show( label, _addButton, "any", false);*/
		}
		
		public function setFocus():void 
		{
			if (_autoCompleteInput)
			{
				_autoCompleteInput.setFocus();
			}
			
		}
		
		private function handleEmptyTaskList():void
		{
			dispatchEvent(new Event(ScreenEvent.CLEAR));
		}
		
		private function addTaskList():void
		{
			_tasksList = new List();
			_tasksList.isSelectable = false;
			_tasksList.dataProvider = new ListCollection( [ ]);

			_tasksList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "text";
				renderer.iconSourceField = "thumbnail";
				 //renderer.labelOffsetX = -70;
				 //renderer.iconOffsetX = -30;
				renderer.itemHasSkin = true;
				renderer.hasLabelTextRenderer = true;
				 
				 

				 //renderer.skinSourceField = "texture";
				// renderer.skinField = "background";
				renderer.skinFunction = function( item:Object ):DisplayObject
				{
					var index:int = 0;// Math.random() * 2;
					var skin:Image = new Image( AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.SKINS_TEXTURES, index));
					return skin;
				};
				 
				//renderer.width = 50;
				var deleteButn:Button = new Button();
				deleteButn.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 3));
				deleteButn.move(stage.stageWidth - 70, 10);
				deleteButn.setSize(60, 50);
				deleteButn.alpha = .8;
				deleteButn.addEventListener(Event.TRIGGERED, onDeleteItem);
				renderer.addChild(deleteButn);
				 
				var editButn:Button = new Button();
				editButn.defaultIcon = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 4));
				editButn.setSize(60, 50);
				editButn.alpha = .8;
				editButn.move(stage.stageWidth - 140, 10);
				editButn.addEventListener(Event.TRIGGERED, onEditItem);
				renderer.addChild(editButn);

				
				/*renderer.labelFunction = function():ITextRenderer
				 {
					 var labelRender:UrikaTextFieldTextRenderer = new UrikaTextFieldTextRenderer()
					 return labelRender
				 }*/
				
				 
				return renderer;
			};

			//_tasksList.addEventListener(Event.TRIGGERED, listItemTriggered );
			_tasksList.itemRendererProperties.height = 70;
			
			var iconTexture:Texture;
			if (listArr.length)
			{
				for (var i:int = 0; i < listArr.length; i++) 
				{
					if (listArr[i].remindEvery != null)
					{
						iconTexture = AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.TIME_ICONS, listArr[i].remindEvery);
					}
					
					if (iconTexture)
					{
						_tasksList.dataProvider.addItem( { text: listArr[i].name, thumbnail:iconTexture } );
					} else
					{
						_tasksList.dataProvider.addItem( { text: listArr[i].name } );
					}
					
				}
			} else
			{
				handleEmptyTaskList();
			}

			this.addChild(_tasksList);
		}
		
		private function onEditItem(e:Event):void 
		{
			trace("onEditItem");
			var button:Button = e.currentTarget as Button;
			_selectedItem = button.parent as DefaultListItemRenderer
			
			_currentPanel = _editTaskPanel;
			PopupsController.addPopUp(_currentPanel);
			
			_editTaskPanel.editInputTf.text = _selectedItem.label;
		}
		
		private function onDeleteItem(e:Event):void 
		{
			var button:Button = e.currentTarget as Button;
			_selectedItem = button.parent as DefaultListItemRenderer
			_currentPanel = _deleteTaskPanel;
			PopupsController.addPopUp(_currentPanel);
		}
		
		private function addSubPanels():void 
		{
			_deleteTaskPanel = new DeleteTaskPanel();
			_deleteTaskPanel.addEventListener(DeleteTaskPanel.DELETE_ITEN, deleteTask_triggeredHandler);
			_deleteTaskPanel.addEventListener(Event.CANCEL, cancelEditTask_triggeredHandler);

			_editTaskPanel = new EditTaskPanel();
			_editTaskPanel.addEventListener(EditTaskPanel.SAVE_ITEN, saveEditTask_triggeredHandler);
			_editTaskPanel.addEventListener(Event.CANCEL, cancelEditTask_triggeredHandler);
		}
		
		protected function submitNewTask(iconTexture:Texture = null, remindEvery:int = -1, notificationId:int = -1):void
		{
			//_currentTaskName = _autoCompleteInput.text;
				
			/*if (_tasksList.dataProvider.length == 1 && _tasksList.dataProvider.getItemAt(0).text == _defaultEmptyTaskText)
			{
				_tasksList.dataProvider.removeItemAt(0);
			}*/
			
			
			_tasksList.dataProvider.addItemAt( { text: _currentTaskName, thumbnail:iconTexture } , 0);
			_autoCompleteInput.text = "";

			var obj:Object = { id:UserGlobal.userPlayer.currentItemID, name:_currentTaskName };
			if (remindEvery != -1)
			{
				obj.remindEvery = remindEvery;
				
			}
			
			if (notificationId != -1)
			{
				obj.notificationId = notificationId;
			}
			UserGlobal.userPlayer.currentItemID++;
			//listArr.push( { name:taskTitle , remindEvery:_toggleGroup.selectedIndex } );
			listArr.push(obj);
			
			saveTaskList();
			saveNewAutoCompleteSentence(_currentTaskName);
			
			if (_tasksList.dataProvider.length == 1)
			{
				dispatchEvent(new Event(ScreenEvent.ADD_FIRST_ITEM));
			}
		}
		
		private function addNewReminderkButton():void 
		{
			_autoCompleteInput = new AutoComplete()
			_autoCompleteInput.move(10, 10);
			_autoCompleteInput.setSize(stage.stageWidth - 110, 100);
			_autoCompleteInput.verticalAlign = TextInput.VERTICAL_ALIGN_JUSTIFY;
			
			_autoCompleteInput.source= new LocalAutoCompleteSource( new ListCollection(new <String>
			 [
				 "Buy",
				 "Call","Call Dad","Call Mom",
				 "Drive","Daddy",
				 "Sell","Set",
				 "Find","Father",
				 "Go", "Get", "Give",
				 "Have",
				 "Locate",
				 "Meet","Mom","Mommy","Mother",
				 "Order",
				 "Task", "Take","Tell",
				 "Run",
				 "Phone",
			 ]));
			 
			addChild(_autoCompleteInput);
			
			_addButton = new Button();
			_addButton.addEventListener(FeathersEventType.CREATION_COMPLETE, onButtonCreationComplete);
			_addButton.addEventListener(Event.TRIGGERED, onAddTriggred);
			_addButton.setSize(100, 100);
			_addButton.move(stage.stageWidth -110, _autoCompleteInput.y);
			
			var img:Image = new Image(AssetsHelper.getInstance().getTextureByFrame(AssetsHelper.BUTTON_ICONS, 0));
			_addButton.defaultIcon = img;
			addChild(_addButton);
			
			for each (var item:Object in UserGlobal.userPlayer.sentences) 
			{
				LocalAutoCompleteSource(_autoCompleteInput.source).dataProvider.push(item)
			}
		}
		
		private function onButtonCreationComplete(e:Event):void 
		{
			_tasksList.move(0, _autoCompleteInput.y + _autoCompleteInput.height + 10);
			_tasksList.setSize(stage.stageWidth, stage.stageHeight -(this.y + 300));
		}
		
		private function onAddTriggred(e:Event):void 
		{
			if (_autoCompleteInput.text.length > 1)
			{
				_currentTaskName = _autoCompleteInput.text;
				_autoCompleteInput.closeList();
				showPostTaskPanel();
			}
		}
		
		protected function showPostTaskPanel():void
		{
			submitNewTask();
			//PopUpManager.addPopUp(_radioPanel);
		}
		
		private function saveNewAutoCompleteSentence(str:String):void 
		{
			LocalAutoCompleteSource(_autoCompleteInput.source).dataProvider.push(str)
			UserGlobal.userPlayer.sentences.push(str);
			UserGlobal.userPlayer.save(null, null);
		}
		
		private function saveTaskList():void 
		{
			updateArr();
			Flox.logInfo("saveTaskList on player : " + UserGlobal.userPlayer.id);
			UserGlobal.userPlayer.save(onTaskSaveComplete, onTaskSaveError)
		}
		
		private function onTaskSaveError():void 
		{
			Flox.logError(this,"task save error");
		}
		
		private function onTaskSaveComplete():void 
		{
			Flox.logInfo("task list save success");
		}
		
		/*private function listItemTriggered(e:Event):void 
		{
			PopUpManager.addPopUp(_deleteTaskPanel);
		}*/
		
		private function deleteTask_triggeredHandler():void 
		{
			removeSelectedTask();
			PopupsController.removePopUp(_currentPanel);
		}
		
		private function cancelEditTask_triggeredHandler():void 
		{
			PopupsController.removePopUp(_currentPanel);
		}
		
		private function saveEditTask_triggeredHandler():void 
		{
			var newStr:String = _editTaskPanel.editInputTf.text;
			var index:int = getItemIndexByText(_selectedItem.label);
			
			listArr[index].name = newStr;

			_tasksList.dataProvider.removeItemAt(index);
			var item:Object = _tasksList.dataProvider.getItemAt(index);
			_tasksList.dataProvider.addItemAt( { text: newStr,thumbnail:item.thumbnail } , index);

			saveTaskList();
			
			PopupsController.removePopUp(_currentPanel);
		}
		
		public function clearList():void 
		{
			Flox.logInfo("clear task list");
			
			_tasksList.dataProvider.removeAll();
			
			//UserGlobal.userPlayer.tasks = new Array();
			listArr = new Array();
			saveTaskList();
			handleEmptyTaskList();
		}
		
		public function get gotItems():Boolean 
		{
			return _tasksList.dataProvider.length?true:false;
		}
	
		protected function updateArr():void
		{
			
		}

		protected function removeSelectedTask():void 
		{
			Flox.logInfo("remove task :" + _selectedItem.label);
			var index:int = getItemIndexByText(_selectedItem.label);
			listArr.splice(index, 1);
			saveTaskList();
			//_tasksList.dataProvider.removeItem(_selectedItem);
			_tasksList.dataProvider.removeItemAt(_selectedItem.index);
			
			if (!listArr.length)
			{
				handleEmptyTaskList();
			}
		}
		
		protected function getItemIndexByText(name:String):int
		{
			for each (var item:Object in listArr) 
			{
				if (item.name == name)
				{
					return listArr.indexOf(item)
				}
			}
			
			return -1;
		}
		
		public function get autoCompleteInput():AutoComplete 
		{
			return _autoCompleteInput;
		}
		
		public function set listArr(value:Array):void 
		{
			_listArr = value;
			
			updateArr();
		}
		
		public function get listArr():Array 
		{
			return _listArr;
		}
		
		override public function dispose():void 
		{
			_selectedItem = null;
			_currentPanel = null;

			if (_deleteTaskPanel)
			{
				_deleteTaskPanel.removeEventListeners();
				_deleteTaskPanel.removeFromParent(true);
				_deleteTaskPanel = null;
			}
			
			if (_editTaskPanel)
			{
				_editTaskPanel.removeEventListeners();
				_editTaskPanel.removeFromParent(true);
				_editTaskPanel = null;
			}
			
			if (_tasksList)
			{
				_tasksList.removeEventListeners();
				_tasksList.removeFromParent(true);
				_tasksList = null;
			}
			
			if (_autoCompleteInput)
			{
				_autoCompleteInput.removeFromParent(true);
				_autoCompleteInput = null;
			}
			
			if (_addButton)
			{
				_addButton.removeFromParent(true);
				_addButton = null;
			}
			super.dispose();
		}
		
		
		
	}

}