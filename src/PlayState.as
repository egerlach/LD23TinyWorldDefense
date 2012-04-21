package
{
	import org.flixel.*;
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
					
			for (var i:int = 0; i < 100; i++)
				generatePowerup();
				
			FlxG.camera.follow(ship);
			
			FlxG.worldBounds = new FlxRect( -1000, -1000, 2000, 2000);
		}
		
		override public function update():void
		{
			if (!ship.hasCargo())
			{
				FlxG.overlap(ship, powerups, grabCargo);
			}
			else if (FlxG.collide(ship, world) && !world.powerupsFull())
			{
				ship.dropCargo(world);
			}
			
			
			arrow.pointToHome(ship, world);
			super.update();
		}
		
		public function generatePowerup():void
		{
			var p:Powerup = new GrowthPowerup();
			p.x = Math.random() * 2000 - 1000;
			p.y = Math.random() * 2000 - 1000;
			
			powerups.add(p);
		}
		
		public function grabCargo(s:Ship, p:Powerup):void
		{
			s.grabCargo(p);
			powerups.remove(p);
		}
	}
}

