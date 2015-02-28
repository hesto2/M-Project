package  Assets.Characters {
	
	import flash.display.MovieClip;
	import Utilities.Collision_Detection.*;
	import Assets.Environment.*;
	import Assets.Characters.c_Samus.bullet;
	import Game.C;
	
	public class Character extends MovieClip {
		
		public var playerName;
		//Stats
		public var health = 100;
		public var currentHealth = 100;
		
		public var runSpeed = 12;
		//Keys Down/Up
		public var direction = 1;
		public var up:Boolean;
		public var down:Boolean;
		public var left:Boolean;
		public var right:Boolean;
		public var btnShoot:Boolean;
		public var btnAttack:Boolean;
		
		//Key Configuration
		public var keyLeft = "a";
		public var keyRight = "d";
		public var keyUp = "w";
		public var keyDown = "s";
		public var keyShoot = "v";
		public var keyAttack = ",";
		public var cRight = Boolean;
		public var cLeft = Boolean;
		public var cUp = Boolean;
		public var cDown = Boolean;
		
		//Collisions
		public var cBR:Boolean;
		public var cTR:Boolean;
		public var cTL:Boolean;
		public var cBL:Boolean;
		public var cMT:Boolean;
		public var cMR:Boolean;
		public var cML:Boolean;
		public var cMB:Boolean;
		public var debug = C.DEBUG;
		//Cooldown
		public var jumpCooldown = 2;
		public var currentJumpCooldown = 0;
		//States
		public var running:Boolean = true;
		public var jumping:Boolean;
		public var falling:Boolean;
		public var runJumping:Boolean = false;
			//Higher number means the jump goes from start to finish quicker
		public var jumpSpeedLimit:int = 30 //Default: 30
			//Higher number means the jump reaches higher
		public var jumpHeight = 120; //Default: 120
			//Higher number means jump goes up slower
		public var jumpSpeedUp = 10; //Default: 10
			//Higher number means jump falls slower
		public var jumpSpeedDown = 65 ; //Default: 65		
			//the current speed of the jump
		public var jumpSpeed:Number = jumpSpeedLimit;
			//1 = right & -1 = left
		public var jumpDirection;
			//Jump Horizontal Speed
		public var jumpXSpeed = runSpeed*.85;
		public var terminalVelocity = 20;
		
		public var collisions;
		public var collisionObjects;
		var collisionCheck = new CarterCollisionKit();
		
		//Damage States
		public var vulnerable = true;
		public var recoveryTime = 10;
		public var recoveryCount = 0;
		public var dead= false;
		
		
		public function Character() {
			initialAnimate();
		}
		
		public function move(){
			if(dead){
				return;
			}
			updateCollisions();
			checkEnvironment();
			customMove();
			if(running)
			{
				runAnimate();
				onGround();
				
			}
			if(jumping){
				
				jump();
				jumpMoveX();
				
			}
			if(currentJumpCooldown > 0)
			{
				currentJumpCooldown--;
			}
			if(!vulnerable)
			{
				if(recoveryCount == 0)
				{
					vulnerable = true;
					if(!this.visible){this.visible = true};
				}
				else
				{
					recoveryCount--;
					invulnerableAnimate();
				}
			}
			//Add status check function
			if(this.currentHealth <=0 && !dead)
				{
					this.visible=true;
					this.dead = true;
					this.dieAnimate();
				}
				
		}
		
		
		
		
		
		
		public function onKeyDown(key:String):void
		{
			
			switch(key)
			{
				
				case keyRight:
					right = true;
					direction = 1;
					break;
				case keyLeft:
					left = true;
					direction = -1;
					break;
				case keyUp:
					up = true;
					break;
				case keyDown:
					down = true;
					break;
				case keyAttack:
					btnAttack = true;
					break;
				case keyShoot:
					btnShoot = true;
					break;
				
			}
			
		}
		
		public function onKeyUp(key:String):void
		{
			
			switch(key)
			{	
				case keyRight:
					right = false
					break;
				case keyLeft:
					left = false;
					break;
				case keyUp:
					up = false;
					break;
				case keyDown:
					down = false;
					break;
				case keyAttack:
					btnAttack = false;
					break;
				case keyShoot:
					btnShoot = false;
					break;
			}
			
		}
		
		
		
		public function updateCollisions(){
			cBR = false;
			cTR = false;
			cBL = false;
			cTL = false;
			cMT = false;
			cML = false;
			cMB = false;
			cMR = false;
			collisions = collisionCheck.checkCollision(this,C.LEVEL);
			collisionObjects = collisions.objects;
			if(collisions.rightHit)
			{
				cMR = true;
			}
			if(collisions.leftHit)
			{
				cML = true;
			}
			if(collisions.topHit)
			{
				cMT = true;
			}
			if(collisions.bottomHit)
			{
				cMB = true;
			}
			if(collisions.rightHit && collisions.topHit)
			{
				cTR = true;
			}
			if(collisions.rightHit && collisions.bottomHit)
			{
				cBR = true;
			}
			if(collisions.leftHit&& collisions.topHit)
			{
				cTL = true;
			}
			if(collisions.leftHit && collisions.bottomHit)
			{
				cBL = true;
			}
			
			
			
			//If you aren't jumping and you aren't above any ground, fall
			if(!cMB && !jumping){
				fall();
			}
			
			
		}
		public function onGround(){
			if(right ){
				direction = 1;
				run("right",runSpeed);
			}
			if(left){
				direction = -1;
				run("left",runSpeed);
			}
			if(up){
				jump();
			}
			if(down){
				run("down",runSpeed);
			}
		}
		
		
		public function run(input,speed){
			
			var count = 0;

			while((count < speed))
			{
				updateCollisions();
				
				switch(input){
					case "left":
						if(cML || (cBL && !cMB) ||(this.x <= 0))
						{
							return;
						}
						
						this.x --;
						break;
					case "right":
						if(cMR || (cBR && !cMB) ||(this.x >= C.STAGE_WIDTH))
						{
							return;
						}
						
						this.x ++;
						break;
					case "up":
						if(cMT || (cTL && !cML) || (cTR && !cMR) || (this.y <= 0))
						{
							return;
						}
						this.y--;
						return;
					case "down":
						if(cMB || (cBL && !cML) || (cBR && !cMR) || (this.y >= C.STAGE_HEIGHT))
						{
							return;
						}
						this.y++
						break;
						
				}
				count++;
			}
				
		}
		public function jumpMoveX()
		{
			if(right ){
				run("right",runSpeed);
			}
			if(left){
				run("left",runSpeed);
			}
			if(!up && !falling){
				//Make them jump slower if they are holding the jump button
				//ADD FUTURE CODE TO ALTER JUMP HEIGHT HERE
				jump();
			}
			if(down){
				fall();
			}
		}
		
		public function jump():void
		{
			
			if(currentJumpCooldown >0)
			{
				return;
			}
			//if main isn't already jumping
			if(!jumping)
			{
				if(right||left)
				{
					runJumping = true;
				}
				running = false;
				jumpDirection = direction;
				jumpAnimate();
				if(jumpDirection == 0)
					jumpDirection = -1;
				//then start jumping
				jumping = true;
				jumpSpeed = jumpSpeedLimit*-1;
				var i = 0;
				while(!cMT && /*!cTL  && !cTR &&*/ i > jumpSpeed)
				{
					updateCollisions();
					this.y-=1;
					i--;
				}			
			} 
			else 
			{
				//Continue jumping if already in the air
				
				//Going Up
				if(jumpSpeed < 0)
				{
					jumpAnimate();
					jumpSpeed *= 1 - jumpSpeedLimit/jumpHeight
					if(jumpSpeed > -jumpSpeedLimit/jumpSpeedUp)
					{
						jumpSpeed *= -1;
					}
					i = 0;
					while(!cMT && !cTL && !cTR && i > jumpSpeed)
					{
						updateCollisions();
						this.y-=1;
						i--;
					}
				}
				else{
					falling = true;
				}
				//Going Down
				if((jumpSpeed >= 0 && jumpSpeed <= jumpSpeedLimit )|| falling)
				{
					fallAnimate();
					if(jumpSpeed < terminalVelocity)
					{
						jumpSpeed *= 1 + jumpSpeedLimit/jumpSpeedDown
					}
					
					var jCount = 0;
					while(!cMB && ( jCount < jumpSpeed))
					{
						updateCollisions();
						this.y += 1;
						jCount++;
					}
				}

				
				//if main hits the floor, then stop jumping
				if(cMB)
				{
					landAnimate();
					currentJumpCooldown = jumpCooldown;
					jumpSpeed=0;
					jumping = false;
					falling = false;
					running = true;
					runJumping = false;
					
				}
			}
		}
		
		public function fall(){
			if(!falling)
			{
				jumping = true;
				falling = true;
				jumpDirection = direction;
				jumpSpeed =4.5;
			}
		}
		
		public function checkEnvironment()
		{
			//Interact with environment objects
			for(var i:uint=0;i<collisionObjects.length;i++)
			{
				onHit(collisionObjects[i]);
			}
			
		}
		public function onHit(object:collisionObject){
			
			//xPlatform
			if(object.dObject is xPlatform)
			{
				var platform:xPlatform = object.dObject;
				
				//Carried by platform
				if(object.bottomHit)
				{
					//X Direction
					if(platform.getOrientation() == 0 && !left && !right)
					{
						if(platform.getDirection() >0)
						{
							this.run("right",platform.getSpeed());
						}
						else
						{
							this.run("left",platform.getSpeed());
						}
					}
					
					//Y Direction
					else if(platform.getOrientation() == 1)
					{
						if(platform.getDirection() >0)
						{
							this.run("down",platform.getSpeed());
						}
						else
						{
							this.run("up",platform.getSpeed());
						}
					}
				}
				
				
				//Pushed by platform
				if(object.leftHit || object.rightHit)
				{
					if(platform.getDirection() > 0)
					{
						this.run("right",platform.getSpeed());
					}
					else
					{
						this.run("left",platform.getSpeed());
					}
				}
			}
		}
		
		public function takeHit(sender)
		{
			if(sender is bullet && this.vulnerable)
			{
				var pBullet:bullet = sender;
				this.currentHealth -= pBullet.power;
				trace(this.playerName + " hit by bullet from " +pBullet.owner.playerName);
				vulnerable = false;
				recoveryCount = recoveryTime;
				onHitAnimate();
			}
			
		}
		//THESE FUNCTIONS CALLED BY CHILD CLASS
		
		protected function initialAnimate()
		{
			
		}
		protected function customMove()
		{
			
		}
		protected function runAnimate()
		{
			
		}
		protected function jumpAnimate()
		{
			
		}
		protected function fallAnimate()
		{
			
		}
		protected function landAnimate()
		{
			
		}
		protected function dieAnimate()
		{
			
		}
		protected function enterAnimate()
		{
			
		}
		protected function victoryAnimate()
		{
			
		}
		protected function onHitAnimate()
		{
			
		}
		protected function invulnerableAnimate()
		{
			//Blink to indicate invulnerable state
			if(this.visible){this.visible = false}
			else{this.visible this.visible= true};
		}
		//Getters and setters
		public function isJumping()
		{
			return this.jumping;
		}

	}
	
	
}
