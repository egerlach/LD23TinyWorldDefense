package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{

			var t:FlxText;
			var b:FlxButton;

			t = new FlxText(0,FlxG.height/2-100,FlxG.width,"Tiny World Defense");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			b = new FlxButton(FlxG.width / 2, FlxG.height - 200, "PLAY", clickPlay);
			b.x = (FlxG.width - b.width) / 2;
			add(b);
			
			b = new FlxButton(FlxG.width / 2, FlxG.height - 250, "Instructions", clickInstructions);
			b.x = (FlxG.width - b.width) / 2;
			add(b);

			FlxG.mouse.show();
		}

		public function clickPlay():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayState());
		}
		
		public function clickInstructions():void
		{
			FlxG.switchState(new InstructionsState());
		}
	}

}

