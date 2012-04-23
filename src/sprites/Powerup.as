package sprites 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class Powerup extends FlxSprite 
	{
		public static const size:Number = 8.0;
		
		public function Powerup(colour:uint, image:Class = null)
		{
			super(0, 0, image);
			
			if (image == null)
			{
				setupGraphics(colour);
			}
		}
		
		public function setupGraphics(colour:uint):void
		{
			makeGraphic(size, size, colour);
		}
		
		public function addToWorld(w:World):void {}
		public function addToShip(s:Ship):void {}
		
		public static function getPowerup():Powerup
		{
			const types:Array = [FireratePowerup, GrowthPowerup, MaxHealthPowerup, FullHealthPowerup, ShieldPowerup, LaserPowerup]; // Can't define this in a static constant, has to go here
			var Definition:Class = FlxU.getRandom(types) as Class;
			var instance:* = new Definition();
			
			return instance;
		}
		
		public function goFlying():void
		{
			velocity.x = Math.random() * 200 - 100;
			velocity.y = Math.random() * 200 - 100;
			angularVelocity = Math.random() * 360 - 180;
		}
	}

}