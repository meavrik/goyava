package game 
{
	import feathers.controls.Alert;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.Timer;
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import flash.utils.Dictionary;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Avrik
	 */
	public class Game extends Sprite 
	{
		static public const TILES_ON_WIDTH:int = 10;
		static public const TILES_ON_HEIGHT:int = 10;

		static public const NEW_GAME_EVENT:String = "newGame";
		
		private var _tiles:Dictionary
		private var _tilesWithMines:Vector.<Tile>;
		
		private var _boardPH:Sprite = new Sprite();
		private var totalMines:int;
		private var _screenUI:GameScreen;
		private var date:Date;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void 
		{
			date = new Date(0, 0, 0, 0, 0, 0, 0);
			date.setSeconds(0,0);
			
			var delayCall:DelayedCall = new DelayedCall(onTimeTimer, 1);
			delayCall.repeatCount = 0;
			Starling.juggler.add(delayCall);
			
			
			_screenUI = new GameScreen();
			_screenUI.width = stage.stageWidth;
			_screenUI.height = stage.stageHeight;
			addChild(_screenUI);
			
			totalMines = TILES_ON_WIDTH * TILES_ON_HEIGHT / 8;
			_screenUI.addChild(_boardPH);
			
			setTiles();
			placeMines();
			
			
			setTilesCounters();
			
			_boardPH.x = (_screenUI.width - _boardPH.width)/2;
			//_boardPH.y = Tile.TILE_SIZE * 3;
			//startTimer();
			
			
		}
		
		private function onTimeTimer():void 
		{
			var newDate:Date = new Date();
			newDate.date = newDate.date-date.date;
			trace("AAAA === " + newDate.seconds);
			_screenUI.setTime(newDate);
		}
		
		private function startTimer():void 
		{
			var delayCall:DelayedCall = new DelayedCall(onTimerTick,10);
			delayCall.repeatCount = 0;
			Starling.juggler.add(delayCall);
		}
		
		private function onTimerTick():void 
		{
			var tween:Tween = new Tween(_boardPH, .5, Transitions.EASE_OUT);
			tween.moveTo(_boardPH.x, _boardPH.y - Tile.TILE_SIZE);
			Starling.juggler.add(tween);
		}
		
		
		
		
		private function setTilesCounters():void 
		{
			for each (var item:Tile in _tilesWithMines) 
			{
				item.setCounter();
			}
		}
		
		
		private function setTiles():void
		{
			_tiles = new Dictionary();
			
			
			for (var i:int = 0; i < TILES_ON_WIDTH; i++) 
			{
				for (var j:int = 0; j < TILES_ON_HEIGHT; j++) 
				{
					setNewTile(i,j);
				}
			}
			
			var tile:Tile
			var nearTilesArr:Vector.<Tile>;
			
			for each (var item:Tile in _tiles) 
			{
				nearTilesArr = new Vector.<Tile>;
				for (var k:int = item.xpos - 1; k < item.xpos + 2; k++)
				{
					for (var l:int =  item.ypos - 1; l < item.ypos + 2; l++) 
					{
						tile = getTileByPosition(k, l);
						if (tile && item != tile)
						{
							nearTilesArr.push(tile);
						}
					}
				}

				item.nearTilesArr = nearTilesArr;
			}
		}
		
		private function setNewTile(xpos:int,ypos:int):void 
		{
			var tile:Tile = new Tile(xpos, ypos);
			tile.setPosition();
			//tile.addEventListener(Tile.TILE_CLICK_MINE_FLAG_EVENT, onTileFlagClick);
			//tile.addEventListener(Tile.TILE_CLICK_OPEN_EVENT, onTileOpenClick);
			tile.addEventListener(Tile.BOOOM, onTileExplode);
			_tiles[xpos + "_" + ypos] = tile;
			_boardPH.addChild(tile);				
		}
		
		private function onTileExplode(e:Event):void 
		{
			Alert.show("BOOOM!!", "",new ListCollection(
			[
				{ label: "Try again", triggered: okEndButton_triggeredHandler }
			]));
		}
		
		private function okEndButton_triggeredHandler(e:Event):void 
		{
			dispatchEventWith(NEW_GAME_EVENT)
		}
		
		private function onTileClick(e:Event):void 
		{
			var tile:Tile = e.currentTarget as Tile;
			tile.open();
		}
		
		private function placeMines():void 
		{
			_tilesWithMines = new Vector.<Tile>;
			var tile:Tile
			for (var i:int = 0; i < totalMines; i++) 
			{
				tile = getRandomEmptyTile();
				tile.mine = true;
				_tilesWithMines.push(tile);
			}
		}
		
		
		private function getRandomEmptyTile():Tile
		{
			var tile:Tile
			var xpos:int;
			var ypos:int;
			
			do
			{
				xpos = Math.floor(Math.random() * TILES_ON_WIDTH);
				ypos = Math.floor(Math.random() * TILES_ON_HEIGHT);
				tile = getTileByPosition(xpos, ypos);
			}
			while (tile.mine);
			
			return tile;
		}
		
		
		private function getTileByPosition(xpos:int, ypos:int):Tile
		{
			var tile:Tile = _tiles[xpos + "_" + ypos];
	
			return tile;
		}
		
	}

}