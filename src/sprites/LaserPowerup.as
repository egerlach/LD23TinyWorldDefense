package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class LaserPowerup extends Powerup 
	{
		[Embed(source="../../assets/laserPowerup.png")]
		public const image:Class;
		public static const colour:uint = 0xffdbdb00;
		
		public function LaserPowerup() 
		{
			super(colour, image);
		}
		
		override public function addToWorld(w:World):void
		{
			w.lasers += 1;
		}
		
	}

}