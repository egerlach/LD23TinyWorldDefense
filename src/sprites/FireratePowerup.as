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
		
		override public function addToShip(s:Ship):void
		{
			s.shotTime *= 0.8;
		}

	}

}