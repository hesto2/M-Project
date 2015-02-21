package{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;

	
	public class Samus extends Character {
		
		
		public function Samus() {
			// constructor code
			
		}
		

		
		//Player Info
		public var playerName = "hesto2";
		var newBullet:bullet;
		
					
			//Morph Ball
		var ball = false;
		var ballSpeed = 15;
			
			//Shooting
		var currentBullet = false;
		var shootCooldown = 15;
		var currentShootWait = 0;
		
		
		////////////
		//Movement//
		////////////
		
		
	//Function that is called every frame
		
		function move(){
		
			 var collisions:Array = cList.checkCollisions();
			
				if(collisions.length == 0)
				{
					leftBumping = false;
					rightBumping = false;
					topBumping = false;
					bottomBumping =false;
					trace("no collision");
				}
				else
				{
					for(var i:uint = 0; i < collisions.length; i++)
						{
							var obj1 = collisions[i].object1;
							var obj2 = collisions[i].object1;
							var angle = collisions[i].angle;
							trace("Collision detected on " + obj1.name + " with " + obj2 + "\n");
							trace("Collision Angle: " + angle);	
							/*for(var x:uint = 0; x <collisions[i].overlapping.length; x++)
							{
								var impact = collisions[i].overlapping[x]
								trace("Overlap: " + collisions[i].overlapping[x]);
								if(impact > this.y)
								{
									trace("X");
									bottomBumping = false;
								}
							}*/
							
							switchCollision(angle);
						}
				}
				trace("Collisions: " + collisions.length);	
			
			if(!bottomBumping && !jumping)
				{
					jumpDirection = direction;
					jumpSpeed = 1;
					jumping = true;
					jump();
				}		
			
			else if(jumping)
			{
				//Continue Jump Sequence
				jump();
				
				//Handle X-Movement
				if(right && !left)
				{
					if(this.x + jumpXSpeed < C.STAGE_WIDTH)
						{											
								this.x += jumpXSpeed;
						}
				}
				else if(left && !right)
				{
					
					if(this.x - jumpXSpeed > 0)
						{											
								this.x -= jumpXSpeed;
						}				
				}
				
				
				
				if(down && !up)
				{
					if(jumpDirection == 1)
					{
						this.gotoAndPlay("rightShootDown");
					}
					else
					{
						this.gotoAndPlay("leftShootDown");
					}
					if (btnShoot)
					{
						shoot();
					}
				}
				
				
				else if(up && !down)
				{
					if(jumpDirection == 1)
					{
						this.gotoAndPlay("rightJumpShootUp");
					}
					else
					{
						this.gotoAndPlay("leftJumpShootUp");
					}	
					if (btnShoot)
					{
						shoot();
					}
				}
				
				else if (btnShoot)
				{
					if(jumpDirection == 1)
					{
						this.gotoAndPlay("rightJumpShoot");
					}
					else
					{
						this.gotoAndPlay("leftJumpShoot");
					}
					shoot();
				}
			}
			
			
			
			//Morph Ball Logic

			else if(ball)
			{
				if(right && !left && !up)
				{
					if(this.currentLabel != "rightBall")
						this.gotoAndPlay("rightBall");
					
					if(this.x + ballSpeed <C.STAGE_WIDTH)
					this.x += ballSpeed;
				}
				else if(left && !right && !up)
				{
					if(this.currentLabel != "leftBall")
						this.gotoAndPlay("leftBall");
					
					if(this.x - ballSpeed > 0)
					this.x -= ballSpeed;
				}
				else if(up)
				{
					if(direction ==1)
					{
						this.gotoAndPlay("rightBallTransformUp");
					}
					else
					{
						this.gotoAndPlay("leftBallTransformUp");
					}
					ball = false;
				}
			}
			
			//Ground Logic
			
			else
			{
				
				//Handle X-Movement on ground
				
				
				//Run Right
				if(right && !left && !down && !btnJump && !btnShoot){
					if(this.currentLabel!="runRight")
						{
							this.gotoAndPlay("runRight");						
							this.direction = 1;
							
						}
						//Check for collision
						if(this.x + runSpeed < C.STAGE_WIDTH)
						{											
								this.x += runSpeed;
						}
				}
				
				//Run Left
				else if(left && !right && !down && !btnJump && !btnShoot){
					if(this.currentLabel!="runLeft")
						{
							this.gotoAndPlay("runLeft");
							this.direction = -1;
							
						}
						//Check for Collision
						if(this.x - runSpeed > 0)
						{
							this. x -= runSpeed;
						}
				}
				
					
				else if(right && btnShoot && !left && !up  && !down && !btnJump){
					if(this.currentLabel!="rightShoot")
						{
							this.gotoAndPlay("rightShoot");						
							this.direction = 1;
							
						}
						//Check for collision
						if(this.x + runSpeed < C.STAGE_WIDTH)
						{											
								this.x += runSpeed;
						}
						shoot();
				}
				
				
			
				else if(left && btnShoot && !right && !up && !down && !btnJump){
					if(this.currentLabel!="leftShoot")
						{
							this.gotoAndPlay("leftShoot");
							this.direction = -1;
							
						}
						//Check for Collision
						if(this.x - runSpeed > 0)
						{
							this. x -= runSpeed;
						}
						shoot();
				}
				
				else if(right && up && !left && !down && !btnJump){
					if(this.currentLabel!="rightRunShootUp")
						{
							this.gotoAndPlay("rightRunShootUp");						
							this.direction = 1;
							
						}
						//Check for collision
						if(this.x + runSpeed < C.STAGE_WIDTH)
						{											
								this.x += runSpeed;
						}						
						if(btnShoot)
						shoot();
				}
				
				
			
				else if(left && up && !right && !down && !btnJump){
					if(this.currentLabel!="leftRunShootUp")
						{
							this.gotoAndPlay("leftRunShootUp");
							this.direction = -1;
							
						}
						//Check for Collision
						if(this.x - runSpeed > 0)
						{
							this. x -= runSpeed;
						}
						if(btnShoot)
						shoot();
				}
				
				
				
				//Run Jump
				
				else if((left && btnJump && !btnShoot && !right && !up && !down)||(right && btnJump && !btnShoot && !left && !up && !down)){
					runJumping = true;
					jump();
				}				
				
				
				else if(btnJump){
					trace("Jump Pressed");
						jump();
				}
				else if(up)
				{
					if(direction == 1)
					{
						this.gotoAndPlay("rightShootUp");
					}
					else
					{
						this.gotoAndPlay("leftShootUp");
					}
					
					if(btnShoot)
						shoot();
				}
				
				//idle shooting
				else if(btnShoot)
				{
					if(direction == 1)
					{
						this.gotoAndPlay("idleRight");
					}
					else
					{
						this.gotoAndPlay("idleLeft");
					}
					shoot();
				}
				
				
				
				else if(down){					
					morphToBall();
				}
				
				//Idle when no key is pressed	
				else {
					
					switch(direction)
					{
						case 1:
							this.gotoAndPlay("idleRight");
							break;
						case -1:
							this.gotoAndPlay("idleLeft");
							break;
					}
				}
			}
			
		//TEMPORARY CODE. FIX LATER
			if(currentBullet)
			{
				if(newBullet.moveBullet())
				{
					newBullet.moveBullet();
				}
				else
				{
					stage.removeChild(newBullet);
					currentBullet = false;
				}
			}
			
			if((currentShootWait > 0) && (currentShootWait < shootCooldown))
			{
				currentShootWait++;
			}
			else
			{
				currentShootWait = -1;
			}
		}
		
		
		
	//Jumping function
		function jump():void
		{
			
			//if main isn't already jumping
			if(!jumping)
			{
				jumpDirection = direction;
				if(jumpDirection == 0)
					jumpDirection = -1;
				//then start jumping
				jumping = true;
				jumpSpeed = jumpSpeedLimit*-1;
				this.y += jumpSpeed;
				
				//Animation
				if(runJumping)
				{
					if(jumpDirection == 1){
						this.gotoAndPlay("rightRunJump");
					}
					else if(jumpDirection == -1){
						this.gotoAndPlay("leftRunJump");
					}
				}
				else
				{
					if(jumpDirection == 1){
						this.gotoAndPlay("rightJump");
					}
					else if(jumpDirection == -1){
						this.gotoAndPlay("leftJump");
					}
				}
				trace("jumping function start " + jumpDirection);
				
			} 
			else 
			{
				//then continue jumping if already in the air
				//crazy math that I won't explain
				
				//Going Up
				if(jumpSpeed < 0)
				{
					
					jumpSpeed *= 1 - jumpSpeedLimit/jumpHeight
					if(jumpSpeed > -jumpSpeedLimit/jumpSpeedUp)
					{
						jumpSpeed *= -1;
					}
				}
				
				//Going Down
				if(jumpSpeed > 0 && jumpSpeed <= jumpSpeedLimit)
				{
					jumpSpeed *= 1 + jumpSpeedLimit/jumpSpeedDown
					if(jumpDirection == 1 && !runJumping){
					this.gotoAndPlay("rightJumpIdle");
					}
					else if(jumpDirection == -1 && !runJumping){
					this.gotoAndPlay("leftJumpIdle");
					}
					
					
				}
				 
				//ADD LOOP TO CHECK FOR BOTTOM COLLISION HERE
				this.y += jumpSpeed;
				
				
				
				if(bottomBumping)
				{
					var count = 0;
					do
					{
						this.y -= 1;
						count++;
						trace("Y pos: " + this.y);
						runCollisionCheck();
					}while(bottomBumping && count < 10);
					this.y++;
				}
				
				//if main hits the floor, then stop jumping
				//of course, we'll change this once we create the level
				if(/*(this.y >= C.STAGE_HEIGHT - (.5 *this.height))||*/(bottomBumping))
					{
						if(jumpDirection == 1){
							this.gotoAndPlay("rightGroundLand");
						}
						else if(jumpDirection ==-1){
							this.gotoAndPlay("leftGroundLand");
						}
					jumping = false;
					runJumping = false;
					//this.y = this.y - (.5 *this.height);
					trace("jumping function end");
				}
			}
		}
		
		
		
	//Morph Ball Function
		
		public function morphToBall()
		{
			if(!ball)
			{
				ball = true;
				if(direction == 1 || direction == 0)
				{
					this.gotoAndPlay("rightBallTransformDown")
				}
				else
				{
					this.gotoAndPlay("leftBallTransformDown");
				}
			}			
		}
	
	//Shoot Functiono
		public function shoot()
		{
			if(currentShootWait < 0)
			{
				newBullet = new bullet(this);
				stage.addChild(newBullet);
				currentBullet = true;
				currentShootWait = 1;
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		//////////////////////
		//Key-Stroke Event Handlers//
		//////////////////////
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
				case keyJump:
					btnJump = true;
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
				case keyJump:
					btnJump = false;
					break;
				case keyShoot:
					btnShoot = false;
					break;
			}
			
		}
		
		/*
		collision info:
		top = -90
		bottom = 90ish
		right = 0
		left = 180
		*/
		
		public function switchCollision(angle:Number)
		{
			
			if((angle <= 45 && angle >= 0) ||(angle <=-135 && angle >= -180))
			{
				rightBumping = true;
				trace("hit r");
			}
			else
			{
				rightBumping =false;
			}
			
			if(angle > 45 && angle <=135)
			{
				//bottom Collision
				bottomBumping = true;
				
				trace("hit b");
			}
			else
			{
				bottomBumping = false;
				
			}
			
			if((angle > 135 && angle <= 180)||( angle >=-45 && angle <= -1 ))
			{
				//left Collision
				leftBumping = true;
				trace("hit l");
			}
			else
			{
				leftBumping = false
			}
			
			if ((angle < -45 && angle > -135))
			{
				//top Collision
				topBumping = true;
				trace("hit t");
			}
			else
			{
				topBumping = false;
			}
			
		}
		
		public function runCollisionCheck()
		{
			var collisions:Array = cList.checkCollisions();
				
				
					for(var i:uint = 0; i < collisions.length; i++)
						{
							
							var angle = collisions[i].angle;
							trace("Potential Collision Angle: " + angle);	
							/*for(var x:uint = 0; x <collisions[i].overlapping.length; x++)
							{
								var impact = collisions[i].overlapping[x]
								trace("Overlap: " + collisions[i].overlapping[x]);
								if(impact > this.y)
								{
									trace("X");
									bottomBumping = false;
								}
							}*/
							
							switchCollision(angle);
						}
		}
		
		
		
	}
	
}




