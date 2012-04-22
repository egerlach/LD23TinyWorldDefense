package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class LaserPowerup extends Powerup 
	{
		private static const colour:uint = 0xffdbdb00;
		
		public function LaserPowerup() 
		{
			super(colour);
		}
		
		override public function addToWorld(w:World):void
		{
			w.lasers += 1;
		}
		
	}

}