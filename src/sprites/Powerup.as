package sprites 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class Powerup extends FlxSprite 
	{
		public static const size:Number = 8.0;
		public static const types:Array = [];
		
		public function Powerup(colour:uint) 
		{
			super(0, 0);
			setupGraphics(colour);
		}
		
		public function setupGraphics(colour:uint):void
		{
			makeGraphic(size, size, colour);
		}
		
		public function addToWorld(w:World):void
		{
		}
	}

}