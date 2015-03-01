
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
	// import the Color class.
	import fl.motion.Color;

	
	public class SamusGameController extends MovieClip
	{
		public var player1;
		public var player2;
		private var environmentArray:Array;
		private var playerArray:Array;
		private var level = "level1";

		
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
			C.LEVEL = mcLevel;
			
			
			
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
			mcGameStage.removeChild(player2);
			while(C.LEVEL.numChildren >0)
			{
				C.LEVEL.removeChildAt(0);
			}
			
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
			//checkPlayerStatus();
			
			
			
			/*****************
			  Handle Display
			*****************/
			
			updateDisplayBoxes();
			
			
		}
		
		
		private function reportKeyDown(event:KeyboardEvent)
		{
			
			var key = String.fromCharCode(event.charCode);
			//Reset Function
			if(event.keyCode == 38 ){
				key = "aup";
			}
			else if(event.keyCode == 40){
				key = "adown";
			}
			else if(event.keyCode == 37){
				key = "aleft";
			}
			else if(event.keyCode == 39){
				key = "aright";
			}
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
			player2.onKeyDown(key);
			
		}
		private function reportKeyUp(event:KeyboardEvent)
		{
			var key = String.fromCharCode(event.charCode);
			if(event.keyCode == 38 ){
				key = "aup";
			}
			else if(event.keyCode == 40){
				key = "adown";
			}
			else if(event.keyCode == 37){
				key = "aleft";
			}
			else if(event.keyCode == 39){
				key = "aright";
			}
			key = key.toLowerCase();
			player1.onKeyUp(key);
			player2.onKeyUp(key);
			
		}
		
		//INITIALIZE ELEMENTS
		private function initializeEnvironment(){
			environmentArray = new Array();
			mcLevel.gotoAndPlay(level);
			
			var platform1 = new xPlatform(10,30,1,0);
			platform1.y -=5;
			platform1.x += 50;
			mcLevel.addChild(platform1);
			environmentArray.push(platform1);
			
			var platform2 = new xPlatform(10,30,-1,0);
			platform2.y -=5;			
			platform2.x += C.STAGE_WIDTH;
			platform2.x -= 200;
			mcLevel.addChild(platform2);
			environmentArray.push(platform2);
			
		}
		private function initializePlayers(){
			playerArray = new Array();
			player1 = new Samus("Player1");
			//player1 = new Character();
			player1.x +=250;
			player1.y = C.STAGE_HEIGHT - (6*player1.height);
			mcGameStage.addChild(player1);
			
			playerArray.push(player1);
			
			
			player2 = new Samus("Player2");
			//player1 = new Character();
			player2.keyLeft = "aleft";
			player2.keyRight = "aright";
			player2.keyUp = "aup";
			player2.keyDown = "adown";
			player2.keyShoot = ".";
			player2.direction = -1;
			
			
			player2.x = C.STAGE_WIDTH - 250;
			player2.y = C.STAGE_HEIGHT - (6*player2.height);
			mcGameStage.addChild(player2);
			// create a Color object
			var c:Color = new Color();
			// set the color of the tint and set the multiplier/alpha
			c.setTint(0x0000ff, 0.25);
			// apply the tint to the colorTransform property of the
			// desired MovieClip/DisplayObject
			player2.transform.colorTransform = c;
			playerArray.push(player2);
			
		}
		public function getChildrenOf(target):Array
		{
		   var children:Array = [];

		   for (var i:uint = 0; i < target.numChildren; i++)
				children.push(target.getChildAt(i));
			  
			  
		   return children;
		}	
		public function checkPlayerStatus()
		{
			for(var i=0;i<playerArray.length;i++)
			{
				var player = playerArray[i];
				if(player.currentHealth <=0)
				{
					player.dieAnimate();
				}
			}
		}
		public function updateDisplayBoxes()
		{
		
			p1Health.text = String(player1.currentHealth);
			p2Health.text = String(player2.currentHealth);
		}
	}
}
	


