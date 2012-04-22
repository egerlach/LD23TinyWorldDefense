package sprites 
{
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class HealthHUD extends HUD 
	{	
		public function HealthHUD(Value:Number, MaxValue:Number)
		{
			super(250, 10, Value, MaxValue, 0xffff0000);
		}
	}
}