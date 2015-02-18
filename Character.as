﻿package  {
	
	import flash.display.MovieClip;
	import CarterCollisionKit;
	import Game.C;
	
	public class Character extends MovieClip {
		
		public var runSpeed = 12;
		//Keys Down/Up
		public var direction = 1;
		public var up:Boolean;
		public var down:Boolean;
		public var left:Boolean;
		public var right:Boolean;
		public var btnJump:Boolean;
		public var btnShoot:Boolean;
		
		//Key Configuration
		public var keyLeft = "a";
		public var keyRight = "d";
		public var keyUp = "w";
		public var keyDown = "s";
		public var keyJump = ",";
		public var keyShoot = ".";
		public var cRight = Boolean;
		public var cLeft = Boolean;
		public var cUp = Boolean;
		public var cDown = Boolean;
		
		//Collisions
		private var cBR:Boolean;
		private var cTR:Boolean;
		private var cTL:Boolean;
		private var cBL:Boolean;
		private var cMT:Boolean;
		private var cMR:Boolean;
		private var cML:Boolean;
		private var cMB:Boolean;
		
		//Cooldown
		protected var jumpCooldown = 2;
		protected var currentJumpCooldown = 0;
		//States
		private var running:Boolean = true;
		private var jumping:Boolean;
		private var falling:Boolean;
		var runJumping:Boolean = false;
			//Higher number means the jump goes from start to finish quicker
		var jumpSpeedLimit:int = 30 //Default: 30
			//Higher number means the jump reaches higher
		var jumpHeight = 120; //Default: 120
			//Higher number means jump goes up slower
		var jumpSpeedUp = 10; //Default: 10
			//Higher number means jump falls slower
		var jumpSpeedDown = 65 ; //Default: 65		
			//the current speed of the jump
		var jumpSpeed:Number = jumpSpeedLimit;
			//1 = right & -1 = left
		var jumpDirection;
			//Jump Horizontal Speed
		var jumpXSpeed = runSpeed*.85;
		
		private var collisions;
		private var collisionObjects;
		public var collisionCheck = new CarterCollisionKit();
		
		public function Character() {
			
		}
		
		public function move(){
			updateCollisions();
			if(running)
			{
				onGround();
			}
			if(jumping){
				
				jump();
					//jumpMoveX();
				
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
			if(!cMB && !jumping){
				fall();
				fall();
				fall();
			}
			
			
		}
		public function onGround(){
			if(right ){
				run("right");
			}
			if(left){
				run("left");
			}
			if(up){
				run("up");
			}
			if(down){
				run("down");
			}
		}
		
		
		public function run(input){
			
			var count = 0;

			while((count < runSpeed))
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
						if(!jumping)
							jump();
						return;
					case "down":
						if(cMB || (cBL && !cML) || (cBR && !cMR) || (this.y >= C.STAGE_HEIGHT))
						{
							return;
						}
						//this.y++;
						break;
						
				}
				count++;
			}
				
		}
		function jump():void
		{
			if(currentJumpCooldown >0)
			{
				return;
			}
			//if main isn't already jumping
			if(!jumping)
			{
				jumpDirection = direction;
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
				
				/*
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
				}*/
				
				
			} 
			else 
			{
				//Continue jumping if already in the air
				
				//Going Up
				if(jumpSpeed < 0)
				{
					
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
					jumpSpeed *= 1 + jumpSpeedLimit/jumpSpeedDown
					/*if(jumpDirection == 1 && !runJumping){
					this.gotoAndPlay("rightJumpIdle");
					}
					else if(jumpDirection == -1 && !runJumping){
					this.gotoAndPlay("leftJumpIdle");
					}*/
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
						/*
						if(jumpDirection == 1){
							this.gotoAndPlay("rightGroundLand");
						}
						else if(jumpDirection ==-1){
							this.gotoAndPlay("leftGroundLand");
						}*/
					currentJumpCooldown = jumpCooldown;
					jumping = false;
					falling = false;
					running = true;
					runJumping = false;
					
				}
			}
		}
		public function fall(){
			jumping = true;
			falling = true;
			jumpSpeed = 1;
		}
		
	}
	
}
