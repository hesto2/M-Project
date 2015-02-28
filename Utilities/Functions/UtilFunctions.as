package  {
	import flash.display;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class UtilFunctions {

		public function UtilFunctions() {
			// constructor code
		}
		
		public static function getChildrenOf(target):Array
		{
		   var children:Array = [];

		   for (var i:uint = 0; i < target.numChildren; i++)
				children.push(target.getChildAt(i));
			  
			  
		   return children;
		}	
		
		public static function removeAllChildren(object:DisplayObjectContainer){
			while(object.numChildren > 0)
			{
				object.removeChildAt(0);
			}
		}
		
	}
	
}
