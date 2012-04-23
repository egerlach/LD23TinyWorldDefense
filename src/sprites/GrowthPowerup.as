package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class GrowthPowerup extends Powerup 
	{
		[Embed(source="../../assets/growthPowerup.png")]
		public const image:Class;
		private static const colour:uint = FlxG.GREEN;
		
		public function GrowthPowerup() 
		{
			super(colour, image);
		}
		
		override public function addToWorld(w:World):void
		{
			w.growthTime *= 0.9;
		}
		
	}

}