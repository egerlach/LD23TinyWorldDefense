package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class FireratePowerup extends Powerup 
	{
		private static const colour:uint = 0xffdb00db;
		public function FireratePowerup() 
		{
			super(colour);
		}
		
		override public function addToWorld(w:World):void
		{
			w.ship.shotTime *= 0.8;
		}

	}

}