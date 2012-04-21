package sprites 
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class HomeArrow extends FlxSprite 
	{
		[Embed(source="../../assets/arrow.png")]
		private var arrowImage:Class;
		
		public function HomeArrow(X:Number=50, Y:Number=50, SimpleGraphic:Class=null) 
		{
			super(X, Y, arrowImage);
			scrollFactor = new FlxPoint();
		}
		
		public function pointToHome(ship:Ship, world:World):void
		{
			angle = FlxU.getAngle(ship.getMidpoint(), world.getMidpoint());
		}
		
	}

}