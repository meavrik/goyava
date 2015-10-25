package screens 
{
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class BaseListScreen extends List 
	{
		
		public function BaseListScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();

			itemRendererFactory = function():IListItemRenderer
			 {
				 var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				 renderer.labelField = "text";
				 //renderer.selectedHoverSkin = renderer.defaultSkin;
				 //renderer.selectedDownSkin = renderer.defaultSkin;
				 //renderer.defaultSelectedSkin = renderer.defaultSkin;
				 //renderer.selectedUpSkin = renderer.defaultSkin;
				 renderer.itemHasSelectable = false;
				 renderer.isQuickHitAreaEnabled = true;
				 //renderer.iconSourceField = "thumbnail";
				 return renderer;
			 };
		}
		
	}

}