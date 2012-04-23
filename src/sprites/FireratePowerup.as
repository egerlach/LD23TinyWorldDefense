package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class FireratePowerup extends Powerup 
	{
		[Embed(source="../../assets/fireRatePowerup.png")]
		public const image:Class;
		private static const colour:uint = 0xffdb00db;
		public function FireratePowerup() 
		{
			super(colour, image);
		}
		
		override public function addToWorld(w:World):void
		{
			w.ship.shotTime *= 0.8;
		}

	}

}