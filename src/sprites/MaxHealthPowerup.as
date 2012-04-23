package sprites 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class MaxHealthPowerup extends Powerup 
	{
		[Embed(source="../../assets/maxHealthPowerup.png")]
		public const image:Class;
		private const colour:uint = FlxG.RED;
		
		public function MaxHealthPowerup() 
		{
			super(colour, image);
		}
		
		override public function addToWorld(w:World):void
		{
			w.addMaxHealth();
		}
		
	}

}