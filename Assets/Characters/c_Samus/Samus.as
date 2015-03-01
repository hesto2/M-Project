package Assets.Characters.c_Samus{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.C;
	import Assets.Characters.Character;
	import Assets.Characters.c_samus.ballBomb;
	

	
	public class Samus extends Assets.Characters.Character {
		
		
		public function Samus(playerName) {
			// constructor code
			this.playerName = playerName;
		}	
		//Player Info
		public var bulletCount = 0;
		var newBullet;
		var bulletArray:Array = new Array();
		var bombArray:Array = new Array();
		var bombCount:int = 0;
		var totalShots = 0;
			//Morph Ball
		var ball = false;
		var ballSpeed = 15;
		var baseSpeed = 12;
			//Shooting
		var shootCooldown = 7;
		var currentShootWait = 0;
		
		//bombing
		var bombCooldown = 10;
		var currentBombWait = 0;
		
		////////////
		//Movement//
		////////////
		
		
	//Function that is called every frame
		override protected function customMove()
		{
			
			//bulletShot();
			if(!ball)
			{
				if(btnShoot)
				{
					shoot();
				}
			}
			if(running && down && !ball)
			{
				morphToBall();
			}
			if(ball)
			{
				moveBall();
				
			}
			
			handleBullets();

		
			
			
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
		
	
	//Shoot Function
		public function shoot()
		{

			if(currentShootWait <= 0)
			{	
				totalShots++;
				//If max number of bullets have already been created and added to array then move the first inactive bullet
				newBullet = new Assets.Characters.c_Samus.bullet(this);
				
				bulletArray.push(newBullet);
				
				currentShootWait = 1;
				
				bulletCount++;
			}
		}
		
		public function handleBullets()
		{
			//Handle Bullets
			for(var i:uint=0;i<bulletArray.length;i++)
				{
					if(bulletArray[i].inactive)
					{
						bulletArray.splice(i,1);
						i--;
						continue;
					}
					var moving = bulletArray[i].moveBullet()
					if(!moving)
					{
						bulletArray[i] == null;
						bulletCount--;
					}
					
				}
			//Handle Bombs
			for(var i:uint=0;i<bombArray.length;i++)
				{
					if(bombArray[i].inactive)
					{
						bombArray.splice(i,1);
						i--;
						continue;
					}
					var moving = bombArray[i].moveBullet()
					
					
				}
			if((currentShootWait > 0) && (currentShootWait < shootCooldown))
			{
				currentShootWait++;
			}
			else
			{
				currentShootWait = -1;
			}
			
			if((currentBombWait > 0) && (currentBombWait < bombCooldown))
			{
				currentBombWait++;
			}
			else
			{
				currentBombWait = -1;
			}
			
		}
		
		private function moveBall()
		{
			if(bombCount > 0)
			{
				
			}
			
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
			if(btnShoot){
					dropBomb();
			}
			
		}
		
		private function dropBomb(){
			if(currentBombWait < 1 && bombArray.length <= 2)
			{
				currentBombWait = 1;
				var newBomb = new ballBomb(this);
				bombCount++;
				bombArray.push(newBomb);				
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
			//Shooting in Air Animations
			if(!runJumping || btnShoot)
			{
				if(up && !down && btnShoot)
				{
					if(jumpDirection == 1)
					{
						this.gotoAndPlay("rightJumpShootUp");
					}
					else
					{
						this.gotoAndPlay("leftJumpShootUp");
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
				}
			}
				
			
			
		}
		override protected  function fallAnimate()
		{
			if(!ball && !runJumping || btnShoot)
			{
				if(jumpDirection == 1){
						this.gotoAndPlay("rightJumpIdle");
				}
				else if(jumpDirection == -1)
				{
					this.gotoAndPlay("leftJumpIdle");
				}
				if(down)
				{
					if(jumpDirection == 1)
					{
						this.gotoAndPlay("rightShootDown");
					}
					else
					{
						this.gotoAndPlay("leftShootDown");
					}
				}
				if(up && !down && btnShoot)
				{
					if(jumpDirection == 1)
					{
						this.gotoAndPlay("rightJumpShootUp");
					}
					else
					{
						this.gotoAndPlay("leftJumpShootUp");
					}	
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
		override protected function dieAnimate()
		{
			if(direction ==1)
			{
				if(this.currentLabel != "dieRight"){
					this.gotoAndPlay("dieRight");
				}
			}
			else
			{
				if(this.currentLabel != "dieLeft"){
					this.gotoAndPlay("dieLeft");
				}
			}
		}

	}
	
}




