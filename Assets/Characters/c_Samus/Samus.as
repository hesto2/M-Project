package Assets.Characters.c_Samus{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.C;

	
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
		var baseSpeed = 12;
			//Shooting
		var currentBullet = false;
		var shootCooldown = 15;
		var currentShootWait = 0;
		
		
		////////////
		//Movement//
		////////////
		
		
	//Function that is called every frame
		override protected function customMove()
		{
			//bulletShot();
			if(running && down && !ball)
			{
				morphToBall();
			}
			if(ball)
			{
				moveBall();
			}
			
			
		}
		
		public function morphToBall()
		{
			if(!ball)
			{
				ball = true;
				runSpeed = ballSpeed;
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
		
	/*
	//Shoot Function
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
		public function bulletShot()
		{
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
		*/
		private function moveBall()
		{
			
			
			if(up)
			{
				up = false;
				runSpeed = baseSpeed;
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
	//Animations
		override protected function initialAnimate()
		{
			
		}
		override protected  function runAnimate()
		{
			if(ball)
			{
				if(direction ==1 && currentLabel != "rightBall")
				{
					this.gotoAndPlay("rightBall");
				}
				else if(direction ==-1 && currentLabel != "leftBall"){
					this.gotoAndPlay("leftBall");
				}
				
				
				return;
			}
			if(right && !left && !down && !btnAttack && !btnShoot){
					if(this.currentLabel!="runRight")
						{
							this.gotoAndPlay("runRight");						
							this.direction = 1;
							
						}
						
				}
				
				//Run Left
				else if(left && !right && !down && !btnAttack && !btnShoot){
					if(this.currentLabel!="runLeft")
						{
							this.gotoAndPlay("runLeft");
							this.direction = -1;
							
						}
						
				}
				
					
				else if(right && btnShoot && !left && !up  && !down && !btnAttack){
					if(this.currentLabel!="rightShoot")
						{
							this.gotoAndPlay("rightShoot");						
							this.direction = 1;
							
						}
						
				}
				
				
			
				else if(left && btnShoot && !right && !up && !down && !btnAttack){
					if(this.currentLabel!="leftShoot")
						{
							this.gotoAndPlay("leftShoot");
							this.direction = -1;
							
						}
					}
				
				else if(right && up && btnShoot && !left && !down && !btnAttack){
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
					}
				
				
			
				else if(left && up && btnShoot &&  !right && !down && !btnAttack){
					if(this.currentLabel!="leftRunShootUp")
						{
							this.gotoAndPlay("leftRunShootUp");
							this.direction = -1;
							
						}
						
				}
				
				else
				{
					if(direction == 1 && this.currentLabel !="idleRight")
					{
						this.gotoAndPlay("idleRight");
					}
					else if(direction == -1 && this.currentLabel !="idleLeft")
					{
						this.gotoAndPlay("idleLeft");
					}
				}
				
		}
		override protected  function jumpAnimate()
		{
			if(runJumping)
			{
				if(jumpDirection == 1 && this.currentLabel !="rightRunJump"){
						this.gotoAndPlay("rightRunJump");
					}
				else if(jumpDirection == -1 && this.currentLabel !="leftRunJump"){
					this.gotoAndPlay("leftRunJump");
				}
			}
			
			if(jumpDirection == 1 && !runJumping){
					this.gotoAndPlay("rightJump");
			}
			else if(jumpDirection == -1 && !runJumping)
			{
				this.gotoAndPlay("leftJump");
			}
			
		}
		override protected  function fallAnimate()
		{
			if(!ball && !runJumping)
			{
				if(jumpDirection == 1){
						this.gotoAndPlay("rightJumpIdle");
				}
				else if(jumpDirection == -1)
				{
					this.gotoAndPlay("leftJumpIdle");
				}
			}
		}
		override protected  function landAnimate()
		{
			if(!ball)
			{
				if(jumpDirection == 1){
					this.gotoAndPlay("rightGroundLand");
				}
				else if(jumpDirection ==-1){
					this.gotoAndPlay("leftGroundLand");
				}
			}
		}

	}
	
}




