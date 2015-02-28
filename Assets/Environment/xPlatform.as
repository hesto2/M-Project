package Assets.Environment {
	
	import flash.display.MovieClip;
	import Game.C;
	
	public class xPlatform extends MovieClip {
		
		private var speed:int;
		private var currentCount:int = 0;
		private var direction:int;
		private var orientation:int;
		private var distance:int;

		
		public function xPlatform(speed:int=0, distance:int=0,startDirection:int=0,orientation:int=0) {
			// constructor code
			this.speed = speed;
			this.distance = distance;
			this.direction = startDirection;
			this.orientation = orientation;
		}
		public function move()
		{	
			
			
			switch(orientation)
			{
				//Move Horizontally
				case 0:
					if(currentCount <= distance)
					{
						this.x += speed*direction;
						currentCount++;
					}
					else
					{
						currentCount = 0;
						direction *= -1;
					}
					
					break;
				//Move Vertically
				case 1:
					if(currentCount <= distance)
					{
						this.y += speed*direction;
						currentCount++;
					}
					else
					{
						currentCount = 0;
						direction *= -1;
					}
					break;
			}
		}
		
		public function getSpeed()
		{
			return this.speed;
		}
		public function getCurrentCount()
		{
			return this.currentCount;
		}
		public function getDistance()
		{
			return this.distance
		}
		public function getDirection()
		{
			return this.direction;
		}
		public function getOrientation()
		{
			return this.orientation;
		}
		
		public function setSpeed(val:int)
		{
			this.speed = val;
		}
		public function setCurrentCount(val:int)
		{
			this.currentCount= val;
		}
		public function setDistance(val:int)
		{
			this.distance = val;
		}
		public function setDirection(val:int)
		{
			this.direction = val;
		}
		public function setOrientation(val:int)
		{
			this.orientation = val;
		}

	}
	
}
