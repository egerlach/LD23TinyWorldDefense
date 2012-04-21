package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class tiny_world_defense extends FlxGame
	{
		public function tiny_world_defense()
		{
			super(320,240,MenuState,2);
		}
	}
}
