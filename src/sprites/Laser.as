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
	public class Laser extends FlxSprite 
	{
		public var life:Number;
		
		public function Laser(from:FlxPoint, to:FlxPoint, Life:Number)
		{
			var top:Number = FlxU.min(from.y, to.y);
			var bottom:Number = FlxU.max(from.y, to.y);
			var left:Number = FlxU.min(from.x, to.x);
			var right:Number = FlxU.max(from.x, to.x);
			
			super(left, top);
			
			makeGraphic(FlxU.max(right - left, 1), FlxU.max(bottom - top, 1), 0x00000000);
			drawLine(from.x - left, from.y - top, to.x - left, to.y - top, LaserPowerup.colour, 2);
			life = Life;
		}
		
		override public function update():void
		{
			life -= FlxG.elapsed;
			if (life < 0) kill();
				
			super.update();
		}
		
	}

}