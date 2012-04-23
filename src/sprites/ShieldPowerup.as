package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class ShieldPowerup extends Powerup 
	{
		[Embed(source="../../assets/shieldPowerup.png")]
		public const image:Class;
		public function ShieldPowerup() 
		{
			super(World.shieldColour, image);
		}
		
		override public function addToWorld(w:World):void
		{
			w.addShield();
		}
		
	}

}