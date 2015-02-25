
package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.*;
	import Assets.Characters.*;
	import Assets.Characters.c_Samus.*;
	import Assets.Environment.*;
	
	
	public class SamusGameController extends MovieClip
	{
		public var player1;
		public var player2;
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
			//Print out all objects on stage
			var obstacleList = getChildrenOf(C.STAGE)
			for(var i:uint=0; i<obstacleList.length;i++)
			{
				trace("Stage Obstacle " + i +": " + obstacleList[i]);
				if(obstacleList[i] is Assets.Characters.Character)
				{
					trace("CHARACTER FOUND");
				}
			}
			obstacleList = getChildrenOf(C.LEVEL)
			for(var i:uint=0; i<obstacleList.length;i++)
			{
				trace("Level Obstacle " + i +": " + obstacleList[i]);

			}
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
			for(var i:int = 0;i<environmentArray.length;i++)
			{
				environmentArray[i].move();
			}
			for(var i:int = 0;i<playerArray.length;i++)
			{
				playerArray[i].move();
			}
			/********************
			 Handle Game Logic
			********************/
			
			
			
			
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
			else if (key == "]")
			{
				if(C.DEBUG)
				{
					C.DEBUG = false;
				}
				else{
					C.DEBUG = true;
				}
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
			
			var platform1 = new xPlatform(10,30,1,0);
			platform1.y -= 0;
			mcBackground.addChild(platform1);
			
			environmentArray.push(platform1);
			
		}
		private function initializePlayers(){
			playerArray = new Array();
			player1 = new Samus();
			//player1 = new Character();
			player1.x = player1.width;
			player1.y = C.STAGE_HEIGHT - (6*player1.height);
			mcGameStage.addChild(player1);
			
			playerArray.push(player1);
			
			player2 = new Samus();
			//player1 = new Character();
			player2.x = C.STAGE_WIDTH - 450;
			player2.y = C.STAGE_HEIGHT - (6*player2.height);
			mcGameStage.addChild(player2);
			
			playerArray.push(player2);
			
		}
		public function getChildrenOf(target):Array
		{
		   var children:Array = [];

		   for (var i:uint = 0; i < target.numChildren; i++)
				children.push(target.getChildAt(i));
			  
			  
		   return children;
		}		
	}
}
	


