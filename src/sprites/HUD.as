package sprites 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class HUD extends FlxSprite 
	{
		public var pixelsPerUnit:Number = 10;
		public var barHeight:Number = 5;
		private var _value:Number;
		private var _maxValue:Number;
		public var colour:uint;
		
		//public var currentBar:FlxSprite;
		
		public function HUD(X:Number, Y:Number, Value:Number, MaxValue:Number, Colour:uint) 
		{
			super(X, Y);
			//currentBar = new FlxSprite;
			scrollFactor = new FlxPoint;
			colour = Colour;
			

			_maxValue = MaxValue;
			_value = Value;
			makeSprite();
		}
		
		public function makeSprite():void
		{
			if (_maxValue <= 0)
			{
				visible = false;
				return;
			}
			
			visible = true;
			
			makeGraphic(pixelsPerUnit * _maxValue, barHeight, colour);
			fill(colour);
			
			var darkenBarWidth:uint = pixelsPerUnit * (_maxValue - _value);
			if (darkenBarWidth > 0)
			{
				var darkenBar:FlxSprite = new FlxSprite;
				darkenBar.makeGraphic(darkenBarWidth, barHeight, 0x7f000000);
				stamp(darkenBar, _value * pixelsPerUnit, 0);
			}
			drawFrame(true);
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(v:Number):void
		{
			_value = FlxU.min(v, _maxValue);
			
			makeSprite();
		}
		
		public function get maxValue():Number
		{
			return _maxValue;
		}
		
		public function set maxValue(v:Number):void
		{
			_maxValue = v;
			makeSprite();
		}
	}

}