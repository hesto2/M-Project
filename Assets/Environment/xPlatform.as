package Assets.Environment {
	
	import flash.display.MovieClip;
	
	
	public class xPlatform extends MovieClip {
		
		private var speed:int;
		private var currentCount:int = 0;
		private var direction:int;
		private var orientation:int;
		private var distance:int;
		
		public function xPlatform(speed:int, distance:int,startDirection:int,orientation:int) {
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
	}
	
}
