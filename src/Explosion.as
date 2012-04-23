package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	
	/**
	 * ...
	 * @author Eric Gerlach
	 */
	public class Explosion extends FlxEmitter 
	{
		public function Explosion(X:Number, Y:Number, Size:uint, Quantity:uint, Colour:uint, maxSpeed:uint, Lifespan:Number) 
		{
			super(X, Y);
			gravity = 0;
			setRotation(-45, 45);
			setXSpeed( -maxSpeed, maxSpeed);
			setYSpeed( -maxSpeed, maxSpeed);
			
			for (var i:int = 0; i < Quantity; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(Size, Size, Colour);
				particle.exists = false;
				particle.angularVelocity = Math.random() * 10 - 5;
				add(particle);
			}
			
			start(true, Lifespan);
		}
	}
}