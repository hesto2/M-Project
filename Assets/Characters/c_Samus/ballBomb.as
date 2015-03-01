package Assets.Characters.c_Samus{

	import Assets.Characters.projectile;
	import Game.C;
	
	public class ballBomb extends projectile{
		
		public var bottom:Boolean = false;
		public var fuse:int = 50;
		public var currentFuse:int = 0;
		
		public function ballBomb(character:Samus) {
			super(character);
			this.bulletSpeed = 10;
			this.power = 7;
			this.yDirection = 1;
			this.y -=20;
		}
		override public function customMove(){
			this.currentFuse ++;
			updateCollisions();
			if(this.fuse == this.currentFuse || colliding){
				impactAnimate();
			}
		}
		override public function projectileAnimate(){
			this.gotoAndPlay("ballBomb");
		}
		override public function impactAnimate(){
			if(this.currentLabel!= "impact"){this.gotoAndPlay("impact");}
		}
		override protected function updateCollisions()
		{
			//Check for player collisions
			this.collisions = collisionCheck.checkCollision(this,C.STAGE);
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
			if(collisions.bottomHit && !bottom)
			{
				trace("Collision with: " + objects.dObject);
				bottom = true;
				this.y-= (.5 * this.height)-7;

			}
			if(colliding){
				impactAnimate();
			}
		}
		override public function moveBullet():Boolean
		{
			customMove();
			
			//Update location
			var count = 0;
			while(count < bulletSpeed &&!colliding && !bottom)
			{
				updateCollisions();				
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
		
	}
	
}
