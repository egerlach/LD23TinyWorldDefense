package sprites 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
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
		private var cargo:FlxGroup;
		
		public function Ship(X:Number=0, Y:Number=0) 
		{
			super(X, Y, shipImage);
			maxSpeed = 1000;
			velocity = new FlxPoint();
			cargo = new FlxGroup(1);
			FlxG.state.add(cargo);
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
			
			if (hasCargo())
			{
				var c:FlxSprite = getCargo();
				c.x = x + height - 0.75 * height * Math.sin((angle + 90.0) / 180.0 * Math.PI);
				c.y = y + height/2 + 0.75 * height * Math.cos((angle + 90.0) / 180.0 * Math.PI);
				c.angle = angle;
			}
			
			super.update();
		}
		
		public function hasCargo():Boolean
		{
			return cargo.countLiving() > 0;
		}
		
		public function getCargo():Powerup
		{
			return cargo.getFirstAlive() as Powerup;
		}
		
		public function grabCargo(p:Powerup):void
		{
			cargo.add(p);
		}
		
		public function dropCargo(w:World):void
		{
			var p:Powerup = getCargo();
			w.addPowerup(p);
			cargo.remove(p);
		}
	}

}