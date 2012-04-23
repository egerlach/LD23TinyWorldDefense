package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import sprites.FireratePowerup;
	import sprites.FullHealthPowerup;
	import sprites.GrowthPowerup;
	import sprites.LaserPowerup;
	import sprites.MaxHealthPowerup;
	import sprites.ShieldPowerup;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class InstructionsState extends FlxState 
	{
		public var runningY:Number = 15;
		public var textX:Number = 15;

		override public function create():void
		{
			addText(textX, runningY, 640 - textX, "The Tiny Homeworld is under attack by fierce aliens!");
			addText(textX, runningY, 640 - textX, "It's time for you to hop in your spaceship to help them defend themselves!");
			addText(textX, runningY, 640 - textX, "Gather powerups and bring them back to the Homeworld to increase their ability to defend themselves, or blast the aliens out of the sky yourself.");
			addPowerup(runningY, new FireratePowerup(), " - Increase your rate of fire");
			addPowerup(runningY, new GrowthPowerup(), " - Increase the rate of new slots for powerups");
			addPowerup(runningY, new ShieldPowerup(), " - Increase the rechargins sheild capacity of the Homeworld");
			addPowerup(runningY, new MaxHealthPowerup(), " - Increase the maximum health of the Homeworld");
			addPowerup(runningY, new FullHealthPowerup(), " - Restore the Homeworld to full health");
			addPowerup(runningY, new LaserPowerup(), " - Increases the rate of fire of the Homeworld's lasers");
			addText(textX, runningY, 640 - textX, "The red, blue, yellow, and green bars at the top of the screen respectively represent the health, shield strength, laser recharge, and powerup slots of the Homeworld.");
			
			var b:FlxButton = new FlxButton(FlxG.width / 2, FlxG.height - 20, "PLAY", clickPlay);
			b.x = (FlxG.width - b.width) / 2;
			add(b);
		}

		public function clickPlay():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayState());
		}

		public function addText(x:Number, y:Number, width:Number, text:String):void
		{
			var t:FlxText = new FlxText(x, y, width, text);
			t.setFormat(null, 16, 0xffffff, "left");
			runningY += t.height + 10;
			add(t);
		}
		
		public function addPowerup(y:Number, sprite:FlxSprite, text:String):void
		{
			sprite.x = textX;
			sprite.y = y + 7;
			add(sprite);
			addText(textX + sprite.width, y, 640 - textX - sprite.width, text);
		}
	}

}