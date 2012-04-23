package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class FullHealthPowerup extends Powerup 
	{
		[Embed(source="../../assets/fullHealthPowerup.png")]
		public const image:Class;
		private static const colour:uint = FlxG.WHITE;
		public function FullHealthPowerup() 
		{
			super(colour,image);
		}
		
		override public function addToWorld(w:World):void
		{
			w.health = w.maxHealth;
		}
		
	}

}