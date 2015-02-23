package Utilities.Collision_Detection {
	import flash.display.MovieClip;
	import flash.geom.*;
	import Utilities.Collision_Detection.*;
	import Game.C;

	public class CarterCollisionKit {
	
		
		private var xDensity=10;
		private var yDensity=20;
		private var cornerTR:Point;
		private var cornerTL:Point;
		private var cornerBR:Point;
		private var cornerBL:Point;
		private var middleT:Point;
		private var middleB:Point;
		private var middleL:Point;
		private var middleR:Point;

		private var rightBump:Boolean;
		private var leftBump:Boolean;
		private var topBump:Boolean;
		private var BottomBump:Boolean;
		
		private var obstacleList:Array;
		private var subject;
		private var testPointy:testPoint;
		private var debug:Boolean;
		private var rightSide:Array = new Array();
		private var rightSidePoints:Array = new Array();
		private var leftSide:Array = new Array();
		private var leftSidePoints:Array = new Array();
		private var topSidePoints:Array = new Array();
		private var topSide:Array = new Array();
		private var bottomSide:Array = new Array();
		private var bottomSidePoints:Array = new Array();
		private var tlPoint:testPoint = new testPoint();
		private var trPoint:testPoint = new testPoint();
		private var blPoint:testPoint = new testPoint();
		private var brPoint:testPoint = new testPoint();
		private var mlPoint:testPoint = new testPoint();
		private var mtPoint:testPoint = new testPoint();
		private var mrPoint:testPoint = new testPoint();
		private var mbPoint:testPoint = new testPoint();
		private var multiPoint:testPoint = new testPoint();
		private var pointList:Array;
		private var pointDisplay:Array;
		private var firstRun = true;
		private var hitList:Array;
		private var hitObjects:Array;
		private var pointOrder:Array = new Array("BL","BR","TR","TL","MT","ML","MB","MR");
		
		public function CarterCollisionKit(xDense = null, yDense = null) 
		{
			if(xDense != null)
			{
				xDensity = xDense
			}
			if(yDense != null)
			{
				yDensity = yDense
			}
			//Generate Arrays to hold testPoints
			for(var i:uint=0;i<yDensity;i++)
			{
				rightSidePoints[i] = new testPoint();
				leftSidePoints[i] = new testPoint();
			}
			for(var i:uint=0;i<xDensity;i++)
			{
				topSidePoints[i] = new testPoint();
				bottomSidePoints[i] = new testPoint();
			}
		}

		
		public function checkCollision(subject:Object,obstacles)
		{	
			this.subject = subject;
			this.debug = C.DEBUG;
			this.obstacleList = getChildrenOf(obstacles);
			
			var RightHit = false;
			var LeftHit = false;
			var TopHit = false;
			var BottomHit = false;
			
			hitList = new Array();
			hitObjects = new Array();
			pointList = new Array();

			makePoints();
	
			for(var i:uint=0; i<obstacleList.length;i++)
			{
				var cObject:collisionObject = new collisionObject(obstacleList[i]);
				
				
					//Test Y Points	
					var rightArray:Array = new Array();
					var leftArray:Array = new Array();
					var objectHit = false;
				
					for(var ii:uint=0; ii<yDensity;ii++){
						var hitTest = testHit(obstacleList[i],rightSide[ii]);
						if(hitTest)
						{
							cObject.rightHit = true;
							RightHit=true;
							objectHit = true;
							pointList.push(rightSidePoints[ii]);

						}
						hitTest = testHit(obstacleList[i],leftSide[ii]);
						if(hitTest)
						{
							cObject.leftHit = true;
							LeftHit=true;
							objectHit = true;
							pointList.push(leftSidePoints[ii]);

						}
					}
					
					
					//Test X Points
					var rightArray:Array = new Array();
					var leftArray:Array = new Array();
				
					for(var ii:uint=0; ii<xDensity;ii++){
						var hitTest = testHit(obstacleList[i],topSide[ii]);
						if(hitTest)
						{
							cObject.topHit = true;
							TopHit=true;
							objectHit = true;
							pointList.push(topSidePoints[ii]);

						}
						hitTest = testHit(obstacleList[i],bottomSide[ii]);
						if(hitTest)
						{
							cObject.bottomHit = true;
							BottomHit=true;
							objectHit = true;
							pointList.push(bottomSidePoints[ii]);

						}
					}
					//If object is overlapping, add it to the list of hit objects
					if(objectHit)
					{
						hitObjects.push(cObject);
					}
			}
			
			if(debug)
			{
				for(var i=0;i<pointList.length;i++)
				{
					pointList[i].gotoAndPlay("red");
				}
			}
			return{rightHit:RightHit,leftHit:LeftHit,topHit:TopHit,bottomHit:BottomHit,objects:hitObjects};
		}
		
		public function getChildrenOf(target):Array
		{
		   var children:Array = [];

		   for (var i:uint = 0; i < target.numChildren; i++)
				children.push(target.getChildAt(i));
			  
			  
		   return children;
		}		
		
		public function testHit(a,b:Point){
			if(a != undefined){
				var hit = a.hitTestPoint(b.x,b.y,true);
			}
				
			return hit;
		}
		
		
		
		public function makePoints()
		{
			var count = 0;
			var oWidth = subject.width;
			var oHeight= subject.height;
			var xPos = subject.x;
			var yPos = subject.y;
			
			//Make Vertical Points
			for(var i:uint=0;i<yDensity;i++)
			{
				var rX = xPos+oWidth;
				var rY = yPos-5-((oHeight-5)/yDensity)*i;
				var rPoint = new Point(rX,rY)
				rightSide[i] = rPoint;
							
				var lX = xPos;
				var lY = yPos-5-((oHeight-5)/yDensity)*i;
				var lPoint = new Point(lX,lY)
				leftSide[i] = lPoint;
				
				if(debug)
				{
					rightSidePoints[i].setLocation(rPoint);
					rightSidePoints[i].gotoAndPlay("green");
					subject.parent.addChild(rightSidePoints[i]);
					leftSidePoints[i].setLocation(lPoint);
					leftSidePoints[i].gotoAndPlay("green");
					subject.parent.addChild(leftSidePoints[i]);
				}
			}
			
			for(var i:uint=0;i<xDensity;i++)
			{
				var tX = xPos+5+((oWidth-5)/xDensity)*i;
				var tY = yPos-oHeight;
				var tPoint = new Point(tX,tY)
				topSide[i] = tPoint;
							
				var bX = xPos+5+((oWidth-5)/xDensity)*i;
				var bY = yPos;
				var bPoint = new Point(bX,bY)
				bottomSide[i] = bPoint;
				
				if(debug)
				{
					topSidePoints[i].setLocation(tPoint);
					topSidePoints[i].gotoAndPlay("green");
					subject.parent.addChild(topSidePoints[i]);
					bottomSidePoints[i].setLocation(bPoint);
					bottomSidePoints[i]..gotoAndPlay("green");
					subject.parent.addChild(bottomSidePoints[i]);
				}
			}
		}

	}
	
}
