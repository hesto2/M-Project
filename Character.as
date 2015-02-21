package  {
	
	import flash.display.MovieClip;
	import CarterCollisionKit;
	import Assets.Environment.*;
	import Game.C;
	
	public class Character extends MovieClip {
		
		//Stats
		public var health = 100;
		
		
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
		public var keyShoot = ".";
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
		
		//Cooldown
		protected var jumpCooldown = 2;
		protected var currentJumpCooldown = 0;
		//States
		protected var running:Boolean = true;
		protected var jumping:Boolean;
		protected var falling:Boolean;
		protected var runJumping:Boolean = false;
			//Higher number means the jump goes from start to finish quicker
		protected var jumpSpeedLimit:int = 30 //Default: 30
			//Higher number means the jump reaches higher
		protected var jumpHeight = 120; //Default: 120
			//Higher number means jump goes up slower
		protected var jumpSpeedUp = 10; //Default: 10
			//Higher number means jump falls slower
		protected var jumpSpeedDown = 65 ; //Default: 65		
			//the current speed of the jump
		protected var jumpSpeed:Number = jumpSpeedLimit;
			//1 = right & -1 = left
		protected var jumpDirection;
			//Jump Horizontal Speed
		protected var jumpXSpeed = runSpeed*.85;
		protected var terminalVelocity = 20;
		
		public var collisions;
		public var collisionObjects;
		public var collisionCheck = new CarterCollisionKit();
		
		public function Character() {
			initialAnimate();
		}
		
		public function move(){
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
			collisions = collisionCheck.checkCollision(this,C.LEVEL,true);
			collisionObjects = collisions.objects;
			collisions = collisions.hits;
			for(var i:uint=0;i<collisions.length;i++){
				switch(collisions[i])
				{
					case "BR":
						cBR = true;
						break;
					case "TR":
						cTR = true;
						break;
					case "BL":
						cBL = true;
						break;
					case "TL":
						cTL = true;
						break;
					case "MT":
						cMT = true;
						break;
					case "ML":
						cML = true;
						break;
					case "MR":
						cMR = true;
						break;
					case "MB":
						cMB = true;
						break;
				}
			}
			
			
			
			//If you aren't jumping and you aren't above any ground, fall
			if(!cMB && !jumping){
				fall();
			}
			
			
		}
		public function onGround(){
			if(right ){
				run("right",runSpeed);
			}
			if(left){
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
						direction = -1;
						this.x --;
						break;
					case "right":
						if(cMR || (cBR && !cMB) ||(this.x >= C.STAGE_WIDTH))
						{
							return;
						}
						direction = 1;
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
				jumpSpeed =5;
			}
		}
		
		public function checkEnvironment()
		{
			//Interact with environment objects
			
			for(var i:uint=0;i<collisionObjects.length;i++)
			{
				onHit(collisionObjects[i],collisions[i]);
			}
		}
		public function onHit(object,point){
			
			//xPlatform
			if(object is xPlatform)
			{
				var platform:xPlatform = object;
				
				//Carried by platform
				if(point == "MB")
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
				if(point =="ML" || point == "MR")
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
		
	}
	
	
}
