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
		public var distanceToTarget:Number;
		public static const holdingPatternDistance:Number = 200;
		
		[Embed(source = "../../assets/alien_appear.mp3")]
		public var appearSound:Class;
		
		[Embed(source = "../../assets/alien_bullet.mp3")]
		public var shotSound:Class;

		[Embed(source = "../../assets/alien_explosion.mp3")]
		public var explodeSound:Class;

		public function Alien(X:Number, Y:Number, Destination:FlxPoint, Speed:Number)
		{
			super(X, Y, alienImage);
			flicker(2);
			solid = false;
			destination = Destination;
			speed = Speed;
			shotTimer = shotTime;
			FlxG.play(appearSound);
		}
		
		override public function update():void
		{
			distanceToTarget = FlxU.getDistance(getMidpoint(), destination);
			if (flickering)
			{
				super.update();
				return;
			}

			if (distanceToTarget < holdingPatternDistance)
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
				
				FlxG.play(shotSound);
				
				return b;
			}
			
			return null;
		}
		
		override public function kill():void
		{
			FlxG.score += 1;
			FlxG.play(explodeSound);
			super.kill();
		}
	}
}