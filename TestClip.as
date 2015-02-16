package  {
	
	import flash.display.MovieClip;
	import CarterCollisionKit;
	import Game.C;
	
	public class TestClip extends MovieClip {
		
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
		
		private var collisions:Array;
		public var collisionCheck = new CarterCollisionKit(this,getChildrenOf(C.LEVEL),false);
		public function TestClip() {
			
		}
		
		public function move(){
			
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
		
		
		
		
		
		
		public function onKeyDown(key:String):void
		{
			trace(key);
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
		
		public function getChildrenOf(target):Array
		{
		   var children:Array = [];

		   for (var i:uint = 0; i < target.numChildren; i++)
			  if(target.getChildAt(i) != this)
			  {
				children.push(target.getChildAt(i));
			  }
			  
		   return children;
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
			collisions = collisionCheck.checkCollision();
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
		}
		
		public function run(direction){
			var count = 0;

			while((count < runSpeed))
			{
				updateCollisions();
				
				switch(direction){
					case "left":
						if(cML || (this.x <= 0))
						{
							return;
						}
						this.x --;
						break;
					case "right":
						if(cMR || (this.x >= C.STAGE_WIDTH))
						{
							return;
						}
						this.x ++;
						break;
					case "up":
						if(cMT || cTR || cTL || (this.y <= 0))
						{
							return;
						}
						this.y --;
						break;
					case "down":
						if(cMB || cBL || cBR || (this.y >= C.STAGE_HEIGHT))
						{
							return;
						}
						this.y++;
						break;
						
				}
				count++;
			}
				
		}
	}
	
}
