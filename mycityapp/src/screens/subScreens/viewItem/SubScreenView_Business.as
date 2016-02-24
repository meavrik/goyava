package screens.subScreens.viewItem 
{
	import assets.AssetsHelper;
	import entities.BusinessEntity;
	import entities.SellItemEntity;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import flash.events.ErrorEvent;
	import progress.WaitPreloader;
	import screens.components.ImageLoaderComponent;
	import starling.display.Quad;
	import starling.events.Event;
	/**
	 * ...
	 * @author Avrik
	 */
	public class SubScreenView_Business extends SubScreenView 
	{
		private var _dataProvider:BusinessEntity;
		private var _imgLoader:ImageLoaderComponent;
		private var _label:Label;
		
		public function SubScreenView_Business(dataProvider:BusinessEntity) 
		{
			super();
			this._dataProvider = dataProvider;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			title = _dataProvider.name;
			
			_imgLoader = new ImageLoaderComponent("http://www.ishi-moto.co.il/images/GalB_20140607_11370138_4.jpg");
			addChild(_imgLoader);
			_imgLoader.init();
			
			if (_dataProvider.description)
			{
				_label = new Label();
				_label.move(10, _imgLoader.bounds.bottom + 5);
				_label.text = _dataProvider.address;
				_label.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
				addChild(_label);
				_label.text += _dataProvider.description + "\n";
			}
		}
		
		override public function dispose():void 
		{
			if (_imgLoader)
			{
				_imgLoader.removeFromParent(true);
				_imgLoader = null;
			}
			
			super.dispose();
		}
		
	}

}