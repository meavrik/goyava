package components 
{
	import feathers.controls.AutoComplete;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class MyAutoComplete extends AutoComplete 
	{
		
		public function MyAutoComplete() 
		{
			super();
			this.list.styleNameList = AutoComplete.INVALIDATION_FLAG_LIST_FACTORY;
		}
		
		
		
	}

}