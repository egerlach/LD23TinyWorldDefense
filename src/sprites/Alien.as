package sprites 
{
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class Alien extends FlxSprite 
	{
		[Embed(source = "../../assets/alien.png")]
		private var alienImage:Class;
		private var destination:FlxPoint;
		private var speed:Number;
		private var shotTime:Number = 5;
		private var shotTimer:Number;
		private var destinationAngle:Number;
		
		public function Alien(X:Number, Y:Number, Destination:FlxPoint, Speed:Number)
		{
			super(X, Y, alienImage);
			flicker(2);
			solid = false;
			destination = Destination;
			speed = Speed;
			shotTimer = shotTime;
		}
		
		override public function update():void
		{	
			if (flickering)
			{
				super.update();
				return;
			}

			if (FlxU.getDistance(destination, getMidpoint()) < 200)
			{
				velocity = new FlxPoint();
				shotTimer -= FlxG.elapsed;
			}
			else
			{
				destinationAngle = FlxU.getAngle(getMidpoint(), destination);
				velocity.copyFromFlash(Point.polar(speed, (destinationAngle - 90) / 180.0 * Math.PI));
			}
			
			solid = true;
			
			super.update();
		}
		
		public function checkShot():Bullet
		{
			if (shotTimer < 0)
			{
				var b:Bullet = new Bullet();
				b.x = getMidpoint().x;
				b.y = getMidpoint().y;
				b.life = 100;
				b.angle = destinationAngle;
				b.setSpeed(50);
				b.setColour(FlxG.RED);
				
				shotTimer = shotTime;
				
				return b;
			}
			
			return null;
		}
	}
}