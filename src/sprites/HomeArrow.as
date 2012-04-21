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
		
		public function HomeArrow(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, arrowImage);
		}
		
		override public function update():void
		{
			var p:FlxPoint = getMidpoint();
			x = FlxG.camera.x;
			y = FlxG.camera.y;
			super.update();
		}
		
		public function pointToHome(world:World):void
		{
			angle = FlxU.getAngle(getMidpoint(), world.getMidpoint());
		}
		
	}

}