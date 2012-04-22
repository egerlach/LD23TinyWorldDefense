package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class FullHealthPowerup extends Powerup 
	{
		private static const colour = FlxG.WHITE;
		public function FullHealthPowerup() 
		{
			super(colour);
		}
		
		override public function addToWorld(w:World):void
		{
			w.health = w.maxHealth;
		}
		
	}

}