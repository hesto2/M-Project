package Assets.Characters.c_Samus{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import Game.C;
	import Assets.Characters.Character;
	import Assets.Characters.projectile;
	import Utilities.Collision_Detection.CarterCollisionKit;
	
	public class bullet extends projectile{
		

		
				
		public function bullet(character:Samus) 
		{
			super(character);
			this.bulletSpeed = 20;
			this.power = 9;
			
		}
		
		override public function customMove()
		{
			
		}
		override public function projectileAnimate()
		{
			this.gotoAndPlay("samusBullet");
		}
		override public function impactAnimate(){
			this.gotoAndPlay("impact");
		}
		
		
		
	}
}