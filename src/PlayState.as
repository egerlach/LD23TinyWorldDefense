package
{
	import org.flixel.*;
	import sprites.Ship;
	import sprites.World;

	public class PlayState extends FlxState
	{
		private var ship:Ship;
		private var world:World;

		override public function create():void
		{
			ship = new Ship();
			add(ship);
			
			world = new World(50, 50);
			add(world);
			
			FlxG.camera.follow(ship, FlxCamera.STYLE_TOPDOWN);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}

