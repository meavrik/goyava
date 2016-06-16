package game.grid 
{
	import assets.AssetsHelper;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Avrik
	 */
	public class Grid extends Sprite
	{
		static public const TILES_ON_X:int = 10;
		static public const TILES_ON_Y:int = 10;
		private var _tiles:Vector.<Tile>
		private var tilePosition:Array;
		
		public function Grid() 
		{
			
		}
		
		public function init():void
		{
			_tiles = new Vector.<Tile>;
			var tile:Tile;
			
			tilePosition = new Array();
			for (var i:int = 0; i < TILES_ON_X; i++) 
			{
				for (var j:int = 0; j < TILES_ON_Y; j++) 
				{
					tilePosition[i] = new Array();
					tile = new Tile(i, j);
					addChild(tile);
					_tiles.push(tile);
					
					tilePosition[i + "_" + j] = tile;
				}
			}
			
		}
		
		public function getTileByPosition(xpos:int=-1, ypos:int=-1):Tile
		{
			
			var xx:int = xpos ==-1?Math.floor(Math.random() * TILES_ON_X):xpos;
			var yy:int = ypos ==-1?Math.floor(Math.random() * TILES_ON_Y):ypos;
			
			return tilePosition[xx + "_" + yy]
		}
		
	}

}