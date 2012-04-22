package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class MaxHealthPowerup extends Powerup 
	{
		private const colour:uint = FlxG.RED;
		
		public function MaxHealthPowerup() 
		{
			super(colour);
		}
		
		override public function addToWorld(w:World):void
		{
			w.maxHealth += 1;
			w.health += 1;
		}
		
	}

}