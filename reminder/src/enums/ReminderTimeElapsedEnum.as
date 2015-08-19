package enums 
{
	/**
	 * ...
	 * @author Avrik
	 */
	public class ReminderTimeElapsedEnum 
	{
		static public const HOURLY:String = "hourly";
		static public const DAILY:String = "daily";
		static public const WEEKLY:String = "weekly";
		static public const MONTHLY:String = "monthly";
		static public const YEARLY:String = "yearly";
		static public const RANDOMLY:String = "randomly";
		
		static public function getNameByIndex(selectedIndex:int):String 
		{
			switch (selectedIndex)
			{
				default:
					return ReminderTimeElapsedEnum.HOURLY;
				case 1:
					return ReminderTimeElapsedEnum.DAILY;
				case 2:
					return ReminderTimeElapsedEnum.WEEKLY;
				case 3:
					return ReminderTimeElapsedEnum.MONTHLY;
				case 4:
					return ReminderTimeElapsedEnum.YEARLY;
				case 5:
					return ReminderTimeElapsedEnum.RANDOMLY;
			}
		}
		
	}

}