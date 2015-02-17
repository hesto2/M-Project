package  {
	import flash.display.MovieClip;
	import flash.geom.*;
	import testPoint;

	public class CarterCollisionKit {
	
		
		private var cornerTR:Point;
		private var cornerTL:Point;
		private var cornerBR:Point;
		private var cornerBL:Point;
		private var middleT:Point;
		private var middleB:Point;
		private var middleL:Point;
		private var middleR:Point;
		private var obstacleList:Array;
		private var subject;
		private var testPointy:testPoint;
		private var debug:Boolean;
		private var tlPoint:testPoint = new testPoint();
		private var trPoint:testPoint = new testPoint();
		private var blPoint:testPoint = new testPoint();
		private var brPoint:testPoint = new testPoint();
		private var mlPoint:testPoint = new testPoint();
		private var mtPoint:testPoint = new testPoint();
		private var mrPoint:testPoint = new testPoint();
		private var mbPoint:testPoint = new testPoint();
		private var pointList:Array;
		private var pointDisplay:Array;
		private var firstRun = true;
		private var hitList:Array;
		private var pointOrder:Array = new Array("BL","BR","TR","TL","MT","ML","MB","MR");
		
		public function CarterCollisionKit(subject:Object,obstacles:Array,debug:Boolean) 
		{
			this.subject = subject;
			this.debug = debug;
			this.obstacleList = obstacles;
		}

		
		public function checkCollision()
		{	
			hitList = new Array();
			pointList = new Array();

			//Calculate the locations and add them to the array
			cornerBL = new Point(subject.x,subject.y);
			pointList.push(cornerBL);
			cornerBR = new Point(subject.x+subject.width,subject.y);
			pointList.push(cornerBR);
			cornerTR = new Point(subject.x+subject.width,subject.y-subject.height);
			pointList.push(cornerTR);
			cornerTL = new Point(subject.x,subject.y-subject.height);
			pointList.push(cornerTL);
			middleT = new Point(subject.x+(.5*subject.height),subject.y-subject.height);
			pointList.push(middleT);
			middleL = new Point(subject.x, subject.y-(.5*subject.height));
			pointList.push(middleL);
			middleB = new Point(subject.x+(.5*subject.width),subject.y);
			pointList.push(middleB);
			middleR = new Point(subject.x+subject.width, subject.y-(.5*subject.height));
			pointList.push(middleR);

			//Test for hits
			
			for(var i:uint=0; i<obstacleList.length;i++)
			{
					
					for(var ii:uint=0; ii<pointList.length;ii++){
						var hitTest = testHit(obstacleList[i],pointList[ii]);
						if(hitTest){
								hitList.push(ii);
							}
					}
			}
			
			
			
			//DRAW POINTS IF DEBUG IS TRUE			
			if(debug)
			{
				pointDisplay = new Array();
				
				//Remove all points from display
				if(!firstRun){
					for(var ii:uint=0; i<pointDisplay.length;ii++){
						subject.parent.removeChild(pointDisplay[ii]);
					}
				}
				else{
					firstRun=false;
				}
				
				//Render points and add them to the array
				blPoint.setLocation(cornerBL);
				pointDisplay.push(blPoint);
				brPoint.setLocation(cornerBR);
				pointDisplay.push(brPoint);
				trPoint.setLocation(cornerTR);
				pointDisplay.push(trPoint);
				tlPoint.setLocation(cornerTL);
				pointDisplay.push(tlPoint);
				
				mtPoint.setLocation(middleT);
				pointDisplay.push(mtPoint);
				mlPoint.setLocation(middleL);
				pointDisplay.push(mlPoint);
				mbPoint.setLocation(middleB);
				pointDisplay.push(mbPoint);
				mrPoint.setLocation(middleR);
				pointDisplay.push(mrPoint);
				//Add points to display
				for(var i:uint=0; i<pointDisplay.length;i++){
					subject.parent.addChild(pointDisplay[i]);
					if(hitList.indexOf(i) >= 0)
					{
						pointDisplay[i].gotoAndPlay("red");
					}
					else
					{
						pointDisplay[i].gotoAndPlay("green");
					}
				}
			
			}
			for(var i:uint=0;i<hitList.length;i++){
				switch(hitList[i]){
					case 0:
						hitList[i] = "BL";
						break;
					case 1:
						hitList[i] = "BR";
						break;
					case 2:
						hitList[i] = "TR";
						break;
					case 3:
						hitList[i] = "TL";
						break;
					case 4:
						hitList[i] = "MT";
						break;
					case 5:
						hitList[i] = "ML";
						break;
					case 6:
						hitList[i] = "MB";
						break;
					case 7:
						hitList[i] = "MR";
						break;
				}
			}
			return hitList;
		}
		
		public function testHit(a,b:Point){
			
			
			if(a != undefined){

				var hit = a.hitTestPoint(b.x,b.y,true);
				
			}
				
			return hit;
		}
		
	}
	
}
