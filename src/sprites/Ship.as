package sprites 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPath;
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
		public var bullets:FlxGroup;
		public var shotTime:Number = 1;
		public var shotSpeed:Number = 500;
		public var shotTimer:Number;
		public var world:World;
		public var respawning:Boolean = false;
		
		[Embed(source="../../assets/powerup_get.mp3")]
		public var powerupPickupSound:Class;
		[Embed(source="../../assets/powerup_drop.mp3")]
		public var powerupDropSound:Class;
		[Embed(source="../../assets/ship_appear.mp3")]
		public var appearSound:Class;
		[Embed(source="../../assets/ship_explode.mp3")]
		public var explodeSound:Class;
		[Embed(source="../../assets/ship_bullet.mp3")]
		public var bulletSound:Class;
		
		public function Ship(X:Number, Y:Number) 
		{
			super(X, Y, shipImage);
			maxSpeed = 500;
			velocity = new FlxPoint();
			cargo = new FlxGroup(1);
			bullets = new FlxGroup();
			FlxG.state.add(cargo);
			FlxG.state.add(bullets);
			shotTimer = 0;
			respawning = true;
			solid = false;
		}
		
		override public function update():void
		{
			var thrust:Point = new Point();
			shotTimer -= FlxG.elapsed;
			
			if (pathSpeed > 0)
			{
				super.update();
				return;
			}
			
			if (respawning)
			{
				FlxG.play(appearSound);
				visible = true;
				flicker(3);
				respawning = false;
			}
			
			if (!flickering) solid = true;
			
			if (FlxG.keys.LEFT)
				angle -= 5;
			if (FlxG.keys.RIGHT)
				angle += 5;
			if (FlxG.keys.UP)
			{
				thrust = Point.polar(5, (angle - 90) / 180.0 * Math.PI);
			}
			else if (FlxG.keys.DOWN)
			{
				thrust = Point.polar( -5, (angle - 90) / 180.0 * Math.PI);
			}
			else 
			{
				thrust.x = -velocity.x * 0.02;
				thrust.y = -velocity.y * 0.02;
			}
			if (FlxG.keys.SPACE && shotTimer <= 0)
			{
				fireBullet();
				shotTimer = shotTime;
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
				c.x = getMidpoint().x;
				c.y = getMidpoint().y;
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
			FlxG.play(powerupPickupSound);
			cargo.add(p);
			p.addToShip(this);
		}
		
		public function dropCargo(w:World):void
		{
			if (!hasCargo())
				return;
			
			FlxG.play(powerupDropSound);
			var p:Powerup = getCargo();
			w.addPowerup(p);
			cargo.remove(p);
		}
		
		public function fireBullet():void
		{
			var b:Bullet = bullets.recycle(Bullet) as Bullet;
			
			b.reset(getMidpoint().x, getMidpoint().y);
			
			b.angle = angle;
			b.life = 5;
			b.setSpeed(shotSpeed);
			b.setColour(FlxG.BLUE);
			
			FlxG.play(bulletSound);
		}
		
		public function kaboom():void
		{
			visible = false;
			solid = false;
			respawning = true;
			
			var path:FlxPath = new FlxPath;
			path.addPoint(getMidpoint());
			path.addPoint(world.getMidpoint());
			followPath(path, 100);
			
			FlxG.play(explodeSound);
		}
	}

}