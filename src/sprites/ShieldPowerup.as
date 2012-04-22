package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class ShieldPowerup extends Powerup 
	{
		
		public function ShieldPowerup() 
		{
			super(World.shieldColour);
		}
		
		override public function addToWorld(w:World):void
		{
			w.addShield();
		}
		
	}

}