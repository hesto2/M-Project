package Assets.Characters.c_Samus{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.C;
	import Assets.Characters.Character;
	import Utilities.Collision_Detection.CarterCollisionKit;
	
	public class bullet extends MovieClip{
		
		public var xStart;
		public var yStart;
		public var owner;
		public var bulletSpeed = 20;
		public var power = 50;
		public var gameStage;
		public var xDirection;
		public var yDirection;
		public var colliding = false;
		public var inactive = false;
		public var collisionObject;
		private var collisions;
		private var collisionCheck = new CarterCollisionKit(2,2);
		
		public function bullet(character) 
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
			owner = character;
			this.x = xStart;
			this.y = yStart;
			this.gotoAndPlay("samusBullet");
			trace("bullet Created");
		}
		
		public function moveBullet():Boolean
		{
			
			var count = 0;
			while(count < bulletSpeed &&!colliding)
			{
				updateCollisions();
				this.x += 1 * xDirection;
				this.y += 1 * yDirection;
				count++;
			}
			
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
		private function updateCollisions()
		{
			
			
			//Check for player collisions
			collisions = collisionCheck.checkCollision(this,C.STAGE);
			var objects = collisions.objects;
			for(var i:uint=0;i<objects.length;i++)
			{
				var object = objects[i];
				if(object.dObject is Assets.Characters.Character && object.dObject != owner)
				{
					trace("Character Found");
					if(object.dObject.vulnerable)
					{
						hitCharacter(object.dObject);
					}
				}
			}
			
			//Check for environment Collisions
			collisions = collisionCheck.checkCollision(this,C.LEVEL);
			objects = collisions.objects;
			if(objects.length>0)
			{
				trace("Collision with: " + objects.dObject);
				colliding = true;

			}
			if(colliding){
				this.gotoAndPlay("impact");
			}
			
		}
		private function hitCharacter(character)
		{
			colliding = true;
			character.takeHit(this);
			
		}
		
		public function removeBullet()
		{
			C.STAGE.removeChild(this);
		}
		
		
		
		
		
	}
}