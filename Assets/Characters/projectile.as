package Assets.Characters{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.C;
	import Assets.Characters.Character;
	import Utilities.Collision_Detection.CarterCollisionKit;
	
	public class projectile extends MovieClip{
		
		public var xStart;
		public var yStart;
		public var owner;
		public var bulletSpeed;
		public var power;
		public var gameStage;
		public var xDirection;
		public var yDirection;
		public var colliding = false;
		public var inactive = false;
		public var collisionObject;
		protected var collisions;
		
		protected var collisionCheck = new CarterCollisionKit(2,2);
		
		public function projectile(character) 
		{
			initProjectile(character);
			
		}
		public function initProjectile(character){
			
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
			projectileAnimate();
		}
		public function moveBullet():Boolean
		{
			customMove();
			
			//Update location
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
					removeBullet();
				}
				trace("bullet removed");
				return false;
			}
			else
			{
				return true;
			}
		}
		protected function updateCollisions()
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
				impactAnimate();
			}
			
		}
		protected function hitCharacter(character)
		{
			colliding = true;
			character.takeHit(this);
			
		}
		
		public function removeBullet()
		{
			inactive = true;
			C.STAGE.removeChild(this);
		}
		public function customMove(){
			
		}
		public function projectileAnimate()
		{
			
		}
		
		public function impactAnimate(){
			
		}
		
		
	}
}