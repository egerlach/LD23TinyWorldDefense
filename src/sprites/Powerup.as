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
		
		public function Powerup(colour:uint) 
		{
			super(0, 0);
			setupGraphics(colour);
		}
		
		public function setupGraphics(colour:uint):void
		{
			makeGraphic(size, size, colour);
		}
		
		public function addToWorld(w:World):void {}
		public function addToShip(s:Ship):void {}
		
		public static function getPowerup():Powerup
		{
			const types:Array = [FireratePowerup, GrowthPowerup, MaxHealthPowerup, FullHealthPowerup, ShieldPowerup]; // Can't define this in a static constant, has to go here
			var Definition:Class = FlxU.getRandom(types) as Class;
			var instance:* = new Definition();
			
			return instance;
		}
	}

}