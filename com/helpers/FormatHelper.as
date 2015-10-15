package helpers 
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.DateTimeNameStyle;
	import flash.globalization.DateTimeStyle;
	import flash.globalization.LocaleID;
	import flash.globalization.NumberFormatter;
	/**
	 * ...
	 * @author Avrik
	 */
	public class FormatHelper 
	{
		
		
		static public function getDate(time:Number):String 
		{
			var dateFormat:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
			dateFormat.setDateTimeStyles(DateTimeStyle.MEDIUM, DateTimeStyle.NONE);
			
			var date:Date = new Date();
			date.setTime(time);
			
			return dateFormat.format(date);
		}
		
		static public function getMoneyFormat(value:Number, currencySign:String):String 
		{
			var format:NumberFormatter = new NumberFormatter(LocaleID.DEFAULT);
			format.fractionalDigits = 0;
			
			return format.formatNumber(value) + currencySign;
		}
		
	}

}