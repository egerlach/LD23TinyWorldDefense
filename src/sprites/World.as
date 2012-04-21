package sprites 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class World extends FlxSprite 
	{
		private var baseSize:uint = 2; // Ceiling of square root of boxes
		private var boxes:uint = 4;
		public var growthTime:Number = 10; // seconds
		private var growthTimer:Number = 0;
		private var powerups:FlxGroup;
		private var forcePlacePowerups:Boolean = false;
		
		public function World() 
		{
			super(0, 0);
			powerups = new FlxGroup();
			FlxG.state.add(powerups);
			makeSprite(baseSize);
			immovable = true;
		}
		
		public function makeSprite(size:Number):void
		{
			var slotsWidth:Number = size * Powerup.size + (size - 1.0) * 2.0;
			var radius:Number = Math.ceil(Math.sqrt(slotsWidth * slotsWidth * 2) / 2);
			
			var circle:Shape = new Shape();
			circle.graphics.lineStyle(1, 0x999999, 1);
			circle.graphics.drawCircle(radius+2, radius+2, radius);
			
			var circleBitmap:BitmapData = new BitmapData(circle.width+4, circle.height+4, true, 0);
			circleBitmap.draw(circle);
			
			//offset = new FlxPoint(radius, radius);
			x = -(radius + 1);
			y = -(radius + 1);
			pixels = circleBitmap;
			placePowerups(radius);
		}
		
		public function addPowerup(p:Powerup):void
		{
			p.angle = 0;
			forcePlacePowerups = true;
			p.addToWorld(this);
			powerups.add(p);
		}
		
		public function placePowerups(radius:Number):void
		{
			var topLeft:FlxPoint = new FlxPoint();
			topLeft.x = topLeft.y = (((Math.SQRT2 * radius) - radius) / 2) / Math.SQRT2;
			topLeft.x += x - offset.x - 2;
			topLeft.y += y - offset.y - 2;
			var index:uint = 1;
			for each (var p:Powerup in powerups.members)
			{
				if (p != null)
				{
					var size:Number = Math.ceil(Math.sqrt(index));
					var coords:FlxPoint = new FlxPoint();
					
					if (index == size * size)
					{
						coords.x = size;
						coords.y = size;
					}
					else if ( index <= size * (size-1))
					{
						coords.x = size;
						coords.y = index - (size-1) * (size-1);
					}
					else
					{
						coords.x = index - size * (size-1);
						coords.y = size;
					}
						
					p.x = topLeft.x + coords.x * Powerup.size + (coords.x - 1) * 2.0;
					p.y = topLeft.y + coords.y * Powerup.size + (coords.y - 1) * 2.0;
					index += 1;
				}
			}
		}
		
		override public function update():void
		{
			growthTimer += FlxG.elapsed;
			if (growthTimer > growthTime)
			{
				boxes += 1;
				if (Math.sqrt(boxes) > baseSize)
					baseSize += 1;
				growthTimer = 0;
				makeSprite(baseSize);
			} else if (Math.sqrt(boxes + 1) > baseSize)
			{
				var size:Number = baseSize + (growthTimer / growthTime);
				makeSprite(size);
			} else if (forcePlacePowerups)
			{
				makeSprite(baseSize);
			}
			forcePlacePowerups = false;
			super.update();
		}
		
		public function powerupsFull():Boolean
		{
			return powerups.countLiving() >= boxes;
		}
		
	}

}