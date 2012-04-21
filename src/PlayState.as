package
{
	import flash.geom.Point;
	import org.flixel.*;
	import sprites.Alien;
	import sprites.Bullet;
	import sprites.GrowthPowerup;
	import sprites.HomeArrow;
	import sprites.Powerup;
	import sprites.Ship;
	import sprites.World;

	public class PlayState extends FlxState
	{
		private var ship:Ship;
		private var world:World;
		private var arrow:HomeArrow;
		private var powerups:FlxGroup;
		private var aliens:FlxGroup;
		private var alienBullets:FlxGroup;
		private var alienRate:Number = 5;
		private var alienTimer:Number;

		override public function create():void
		{
			ship = new Ship(-25, -25);
			add(ship);
			
			world = new World();
			add(world);
			
			arrow = new HomeArrow();
			add(arrow);

			powerups = new FlxGroup();
			add(powerups);
			
			aliens = new FlxGroup();
			add(aliens);
			
			alienBullets = new FlxGroup;
			add(alienBullets);
			
			alienTimer = alienRate;
			
			for (var i:int = 0; i < 100; i++)
				generatePowerup();
				
			FlxG.camera.follow(ship);
			
			FlxG.worldBounds = new FlxRect( -1000, -1000, 2000, 2000);
		}
		
		override public function update():void
		{
			alienTimer -= FlxG.elapsed;
			
			if (alienTimer < 0)
				generateAlien();
			
			FlxG.overlap(ship, powerups, grabCargo);
			FlxG.overlap(aliens, ship.bullets, shotAlien);

			if (FlxG.collide(ship, world) && !world.powerupsFull())
			{
				ship.dropCargo(world);
			}
			
			arrow.visible = !world.onScreen();
			
			for each (var a:Alien in aliens.members)
			{
				if (a.alive)
				{
					var b:Bullet = a.checkShot();
					if (b != null)
						alienBullets.add(b);
				}
			}
			
			arrow.pointToHome(ship, world);
			super.update();
		}
		
		public function generatePowerup():void
		{
			var p:Powerup = Powerup.getPowerup();
			p.x = Math.random() * 2000 - 1000;
			p.y = Math.random() * 2000 - 1000;
			
			powerups.add(p);
		}
		
		public function generateAlien():void
		{
			var location:FlxPoint = new FlxPoint();
			location.copyFromFlash(Point.polar(500, Math.random() * Math.PI * 2));
			aliens.add(new Alien(location.x, location.y, world.getMidpoint(), 10));
			alienTimer = alienRate;
		}
		
		public function grabCargo(s:Ship, p:Powerup):void
		{
			if (!ship.hasCargo())
			{
				s.grabCargo(p);
				powerups.remove(p);
			}
		}
		
		public function shotAlien(a:Alien, b:Bullet):void
		{
			a.kill();
			b.kill();
		}
	}
}

