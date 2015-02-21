package Assets.Characters.Samus{
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
		override protected function customMove()
		{
			//bulletShot();
			
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
	//Animations
		override protected function initialAnimate()
		{
			
		}
		override protected  function runAnimate()
		{
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
				
		}
		override protected  function jumpAnimate()
		{
			
		}
		override protected  function fallAnimate()
		{
			
		}
		override protected  function landAnimate()
		{
			
		}
	}
	
}




