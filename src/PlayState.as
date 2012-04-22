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
		private var alienSpeed:Number = 25;
		private var alienTimer:Number;
		private var scoreText:FlxText;
		public var difficulty:Number = 0.75;
		private var difficultyRate:Number = 0.02;

		override public function create():void
		{
			scoreText = new FlxText(10, 10, 200, "0");
			scoreText.scrollFactor = new FlxPoint;
			scoreText.setFormat(null, 16, 0xffffff, "left");
			add(scoreText);
			
			ship = new Ship(-25, -25);
			add(ship);
			
			world = new World();
			add(world);
			
			ship.world = world;
			
			arrow = new HomeArrow(FlxG.width - 50, 50);
			add(arrow);

			powerups = new FlxGroup();
			add(powerups);
			
			aliens = new FlxGroup();
			add(aliens);
			
			alienBullets = new FlxGroup;
			add(alienBullets);
			
			alienTimer = alienRate;
			
			for (var i:int = 0; i < 50; i++)
				generatePowerup();
				
			FlxG.camera.follow(ship);
			
			FlxG.watch(world, 'shield');
			FlxG.watch(world, 'laserTimer');
			
			FlxG.worldBounds = new FlxRect( -1000, -1000, 2000, 2000);
		}
		
		override public function update():void
		{
			alienTimer -= FlxG.elapsed;
			
			if (alienTimer < 0)
				generateAlien();
			
			FlxG.overlap(ship, powerups, grabCargo);
			FlxG.overlap(aliens, ship.bullets, shotAlien);
			FlxG.overlap(ship, aliens, shipDestroyed);
			FlxG.overlap(ship, alienBullets, shipDestroyed);
			FlxG.overlap(world, alienBullets, worldHit);

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
			
			world.fireLaser(aliens);
			
			arrow.pointToHome(ship, world);
			super.update();
			
			difficulty += difficultyRate * FlxG.elapsed;
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
			aliens.add(new Alien(location.x, location.y, world.getMidpoint(), alienSpeed * difficulty));
			alienTimer = alienRate / difficulty;
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
			FlxG.score += 1;
			scoreText.text = FlxG.score.toString();
		}		
		
		public function shipDestroyed(s:Ship, o:FlxBasic):void
		{
			ship.kaboom();
			if (o is Bullet)
				o.kill();
		}
		
		public function worldHit(w:World, b:Bullet):void
		{
			var hit:uint = w.hit(1);
			b.kill();
			FlxG.camera.flash(hit == World.SHIELD ? World.shieldColour :0xffff0000, 0.1, null, true);
			if (!w.alive)
			{
				FlxG.camera.shake(0.01, 2);
				ship.kill();
			}
			
		}

	}
}

