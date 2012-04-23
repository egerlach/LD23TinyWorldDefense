package
{
	import flash.geom.Point;
	import org.flixel.*;
	import sprites.Alien;
	import sprites.Bullet;
	import sprites.GrowthPowerup;
	import sprites.HealthHUD;
	import sprites.HomeArrow;
	import sprites.LaserHUD;
	import sprites.Powerup;
	import sprites.ShieldHUD;
	import sprites.Ship;
	import sprites.SlotsHUD;
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
		private var gameOverText:FlxText;
		
		[Embed(source = "../assets/starfield.png")]
		private var starfield:Class;

		override public function create():void
		{
			add(new FlxBackdrop(starfield, -0.1, -0.1, true, true));
			
			var healthHUD:HealthHUD = new HealthHUD(0, 0);
			var shieldHUD:ShieldHUD = new ShieldHUD;
			var laserHUD:LaserHUD = new LaserHUD;
			var slotsHUD:SlotsHUD = new SlotsHUD;
			
			scoreText = new FlxText(10, 10, 200, "0");
			scoreText.scrollFactor = new FlxPoint;
			scoreText.setFormat(null, 16, 0xffffff, "left");
			add(scoreText);
			
			ship = new Ship(-25, -25);
			add(ship);
			
			world = new World(ship, healthHUD, shieldHUD, laserHUD, slotsHUD);
			add(world);
			
			ship.world = world;
			
			arrow = new HomeArrow(FlxG.width - 50, 25);
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
				
			add(healthHUD);
			add(slotsHUD);
			add(shieldHUD);
			add(laserHUD);
			
			FlxG.camera.follow(ship);
			
			FlxG.watch(ship, 'x');
			FlxG.watch(ship, 'y');
			
			FlxG.worldBounds = new FlxRect( -1000, -1000, 2000, 2000);
		}
		
		override public function update():void
		{
			scoreText.text = FlxG.score.toString();
			
			if (!world.alive && FlxG.keys.ENTER)
			{
				FlxG.score = 0;
				FlxG.switchState(new PlayState);
			}
			
			alienTimer -= FlxG.elapsed;
			
			if (FlxG.keys.justPressed("A"))
				generateAlien();
			
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
			
			var explosion:FlxPoint = world.fireLaser(aliens);
			if (explosion != null)
				alienExplosion(explosion.x, explosion.y);
			
			arrow.pointToHome(ship, world);
			super.update();
			
			difficulty += difficultyRate * FlxG.elapsed;
		}
		
		public function generatePowerup():void
		{
			var p:Powerup = Powerup.getPowerup();
			while (FlxU.abs(p.x) < 100)
				p.x = Math.random() * 1500 - 750;
			while (FlxU.abs(p.y) < 100)
				p.y = Math.random() * 1500 - 750;
			
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
			alienExplosion(a.x, a.y);
			a.kill();
			b.kill();
		}		
		
		public function shipDestroyed(s:Ship, o:FlxBasic):void
		{
			add(new Explosion(ship.x, ship.y, 2, 100, 0xff0000ff, 150, 3));
			var droppedCargo:Powerup = ship.kaboom();
			if (droppedCargo != null)
				powerups.add(droppedCargo);
			if (o is Bullet)
				o.kill();
		}
		
		public function worldHit(w:World, b:Bullet):void
		{
			var midpoint:FlxPoint = w.getMidpoint();
			var hit:uint = w.hit(1);
			b.kill();
			FlxG.camera.flash(hit == World.SHIELD ? World.shieldColour :0xffff0000, 0.1, null, true);
			
			if (!w.alive)
			{
				FlxG.camera.shake(0.01, 2);
				FlxG.camera.target = null;
				FlxG.camera.focusOn(midpoint);
				add(new Explosion(w.x, w.y, 10, 30, 0xff999999, 50, 0));
				gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "THE TINY HOMEWORLD HAS BEEN DESTROYED!\nPRESS ENTER TO PLAY AGAIN");
				gameOverText.scrollFactor = new FlxPoint;
				gameOverText.setFormat(null, 16, 0xff597137, "center");
				add(gameOverText);
				ship.kill();
			}
			
		}
		
		public function alienExplosion(x:Number, y:Number):void
		{
			add(new Explosion(x, y, 4, 20, 0xff004900, 100, 2));
		}

	}
}

