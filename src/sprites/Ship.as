package sprites 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class Ship extends FlxSprite 
	{
		[Embed(source = "../../assets/ship.png")]
		private var shipImage:Class;
		
		private var maxSpeed:Number;
		
		public function Ship(X:Number=0, Y:Number=0) 
		{
			super(X, Y, shipImage);
			maxSpeed = 1000;
			velocity = new FlxPoint();
		}
		
		override public function update():void
		{
			var thrust:Point = new Point();
			
			if (FlxG.keys.LEFT)
				angle -= 5;
			if (FlxG.keys.RIGHT)
				angle += 5;
			if (FlxG.keys.UP)
			{
				thrust = Point.polar(5, angle / 180.0 * Math.PI);
			}
			else if (FlxG.keys.DOWN)
			{
				thrust = Point.polar( -5, angle / 180.0 * Math.PI);
			}
			else 
			{
				thrust.x = -velocity.x * 0.02;
				thrust.y = -velocity.y * 0.02;
			}
			
			velocity.x += thrust.x;
			velocity.y += thrust.y;
			
			var p:Point = new Point();
			velocity.copyToFlash(p);
			if (p.length > maxSpeed)
				p.normalize(maxSpeed);
			velocity.copyFromFlash(p);
				
			super.update();
		}
		
	}

}