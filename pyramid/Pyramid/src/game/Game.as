package game 
{
	import game.building.Block;
	import game.grid.Grid;
	import game.grid.Tile;
	import starling.display.Sprite;
	import starling.events.Event;
	import usefull.SuperSprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Game extends SuperSprite 
	{
		private var _grid:Grid;
		private var _contentPH:Sprite;
		
		public function Game() 
		{
			super();

		}
		
		override protected function init():void 
		{
			super.init();

			_contentPH = new Sprite();
			addChild(_contentPH);
			
			
			_grid = new Grid();
			_contentPH.addChild(this._grid);
			_grid.init();
			_contentPH.y = stage.stageHeight - _grid.height;
			
			start();
		}
		
		private function start():void 
		{
			var block:Block = getBlock();
			_contentPH.addChild(block);
			
			
			
			var tile:Tile = _grid.getTileByPosition();
			block.move(tile.x, tile.y);
			//block.startSlide();
		}
		
		
		
		private function getBlock():Block 
		{
			return new Block();
		}
		
	}

}