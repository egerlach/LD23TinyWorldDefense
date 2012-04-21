package sprites 
{
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class Bullet extends FlxSprite 
	{
		public var life:Number;
		
		public function Bullet(X:Number = 0, Y:Number = 0, Angle:Number = 0 , Speed:Number = 0, Colour:uint = 0xffffffff, Life:Number = 0)
		{
			super(X, Y);
			angle = Angle;
			life = Life;
			setSpeed(Speed);
			setColour(Colour);
		}
		override public function update():void
		{
			life -= FlxG.elapsed;
			if (life < 0)
				kill();
		}
		
		public function setSpeed(speed:Number):void
		{
			velocity.copyFromFlash(Point.polar(speed, (angle - 90) / 180.0 * Math.PI));
		}
		public function setColour(colour:uint):void
		{
			makeGraphic(4, 4, colour);
		}
		
	}

}