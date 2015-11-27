package screens.gifts 
{
	import feathers.controls.Panel;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class GiftsPanel extends Panel 
	{
		private var _gifts:Vector.<GiftBox> = new Vector.<GiftBox>;
		
		public function GiftsPanel() 
		{
			super();
			title = "בחר את המתנה השבועית שלך";
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var giftBox:GiftBox;
			for (var i:int = 0; i < 3; i++) 
			{
				giftBox = new GiftBox();
				giftBox.y = 60;
				giftBox.x = 80 + i * 120;
				giftBox.addEventListener(Event.SELECT, onSelectGift);
				_gifts.push(giftBox);
				addChild(giftBox);
				Starling.juggler.delayCall(playGift, (i + 1) * .2, giftBox);
			}
		}
		
		private function onSelectGift(e:Event):void 
		{
			dispatchEventWith(Event.CLOSE);
		}
		
		private function playGift(giftBox:GiftBox):void
		{
			giftBox.play();
		}
		
	}

}