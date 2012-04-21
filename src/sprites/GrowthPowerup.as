package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class GrowthPowerup extends Powerup 
	{
		
		public function GrowthPowerup() 
		{
			super(FlxG.GREEN);
		}
		
		override public function addToWorld(w:World):void
		{
			w.growthTime *= 0.9;
		}
		
	}

}