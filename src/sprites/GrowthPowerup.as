package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class GrowthPowerup extends Powerup 
	{
		private static const colour:uint = FlxG.GREEN;
		
		public function GrowthPowerup() 
		{
			super(colour);
		}
		
		override public function addToWorld(w:World):void
		{
			w.growthTime *= 0.9;
		}
		
	}

}