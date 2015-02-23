package{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.C;
	import Assets.Characters.c_Samus.Samus;
	
	public class bullet extends MovieClip{
		
		public var xStart;
		public var yStart;
		public var owner;
		public var bulletSpeed;
		public var bulletPower;
		public var gameStage;
		public var xDirection;
		public var yDirection;
		public var inactive = false;
		
		public function bullet(character:Character) 
		{
			
			//Start point for bullet
			if(character.direction == -1)
			{
				xStart = character.x ;
			}
			else
			{
				xStart = character.x + character.width;
			}
			yStart = character.y - .5*character.height;
			xDirection = character.direction;
			
			C.STAGE.addChild(this);
			
			//Travel direction
			if((character.down) && (character.isJumping()))
			{
				yDirection = 1;
				xDirection = 0;
			}
			
			else if(character.isJumping())
			{
				xDirection = character.jumpDirection;
				
				if(character.up)
				{
					yDirection = -1;
				}
				else if(character.down)
				{
					yDirection = 1;
					xDirection = 0;
				}
				else
				{
					yDirection = 0;
				}
			}
			else if(character.up && !character.right && !character.left)
			{
				yStart -= 20;
				xStart -= 10;
				yDirection = -1;
				xDirection = 0;
			}
			else if(character.up)
			{
				yDirection = -1;
				xDirection = character.direction;
			}
			
			else
			{
				yDirection = 0;
			}
			owner = character.name;
			bulletSpeed = 20;
			bulletPower = 5;
			this.x = xStart;
			this.y = yStart;
			this.gotoAndPlay("samusBullet");
			trace("bullet Created");
		}
		
		public function moveBullet():Boolean
		{
			
			this.x += bulletSpeed * xDirection;
			this.y += bulletSpeed * yDirection;
			
//COLLISION DETECTION GOES HERE
			if(((this.x > C.STAGE_WIDTH) || (this.x < 0)) || ((this.y > C.STAGE_HEIGHT) || (this.y < 0)))
			{
				inactive = true;
				if(!inactive){
					C.STAGE.removeChild(this);
				}
				trace("bullet removed");
				return false;
			}
			else
			{
				return true;
			}
		}
		
		
		
		
		
	}
}