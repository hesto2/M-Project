
package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.*;
	
	public class SamusGameController extends MovieClip
	{
		public var player1:TestClip;
		public var level;
		
		

		
		public function GameController()
		{
			
		}
		
		public function startGame()
		{
			//Define Constants
			C.STAGE_WIDTH = mcGameStage.width;
			C.STAGE_HEIGHT = mcGameStage.height;
			C.LEVEL = mcBackground;
			
			player1 = new TestClip();
			player1.x = player1.width;
			player1.y = C.STAGE_HEIGHT - (2*player1.height);
			mcGameStage.addChild(player1);
		
			
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
			player1.move();
			/*
			xPos.text = String(player1.currentShootWait);
			yPos.text = String(player1.y);
			jumpSpeed.text = String(player1.jumpSpeed);
			*/
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
			
			player1.onKeyDown(key);
		
		}
		private function reportKeyUp(event:KeyboardEvent)
		{
			var key = String.fromCharCode(event.charCode);
			key = key.toLowerCase();
			player1.onKeyUp(key);
			
		}
		
		
	}
}
	


