package
{
	import org.flixel.*;
	import sprites.HomeArrow;
	import sprites.Ship;
	import sprites.World;

	public class PlayState extends FlxState
	{
		private var ship:Ship;
		private var world:World;
		private var arrow:HomeArrow;

		override public function create():void
		{
			ship = new Ship();
			add(ship);
			
			world = new World(50, 50);
			add(world);
			
			arrow = new HomeArrow();
			add(arrow);
			
			FlxG.camera.follow(ship, FlxCamera.STYLE_TOPDOWN);
		}
		
		override public function update():void
		{
			arrow.pointToHome(world);
			super.update();
		}
	}
}

