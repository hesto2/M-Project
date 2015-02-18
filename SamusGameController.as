
package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.*;
	import Assets.Environment.*
	
	
	public class SamusGameController extends MovieClip
	{
		public var player1:Character;
		public var level;
		private var environmentArray:Array;
		private var playerArray:Array;

		
		public function GameController()
		{
			
		}
		
		public function startGame()
		{
			
			//Define Constants
			C.STAGE_WIDTH = mcGameStage.width;
			C.STAGE_HEIGHT = mcGameStage.height;
			initializePlayers();
			C.STAGE = mcGameStage;
			
			initializeEnvironment();
			C.PLAYERS = playerArray;
			C.LEVEL = mcBackground;
			
			
			
			//player.gotoAndPlay("runRight");
			mcGameStage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			trace("Initializing Game");
			trace("Stage Height: " + mcGameStage.height);
			trace("Stage Width: " + mcGameStage.width);
			trace(mcGameStage.getType);
		}	
		public function resetGame()
		{
			trace("RESTARTING GAME");
			mcGameStage.removeChild(player1);
		
			startGame();
			
		}
			
		private function update(evt:Event)
		{
			/********************
			  Handle User Input
			********************/
			
			for(var i:int = 0;i<playerArray.length;i++)
			{
				playerArray[i].move();
			}
			/********************
			 Handle Game Logic
			********************/
			for(var i:int = 0;i<environmentArray.length;i++)
			{
				environmentArray[i].move();
			}
			
			
			
			/*****************
			  Handle Display
			*****************/
			
		}
		
		
		private function reportKeyDown(event:KeyboardEvent)
		{
			var key = String.fromCharCode(event.charCode);
			//Reset Function
			key = key.toLowerCase();
			if(key == 'r')
			{
				resetGame();
			}
			else if(key == "[")
			{

				trace("debugging");
				
			}
			
			player1.onKeyDown(key);
		
		}
		private function reportKeyUp(event:KeyboardEvent)
		{
			var key = String.fromCharCode(event.charCode);
			key = key.toLowerCase();
			player1.onKeyUp(key);
			
		}
		
		//INITIALIZE ELEMENTS
		private function initializeEnvironment(){
			environmentArray = new Array();
			
			var platform1 = new xPlatform(0,30,1,0);
			platform1.y -= 100;
			mcBackground.addChild(platform1);
			
			environmentArray.push(platform1);
			
		}
		private function initializePlayers(){
			playerArray = new Array();
			player1 = new Character();
			player1.x = player1.width;
			player1.y = C.STAGE_HEIGHT - (2*player1.height);
			mcGameStage.addChild(player1);
			
			playerArray.push(player1);
			
		}
		
	}
}
	


