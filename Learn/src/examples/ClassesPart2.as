/**
 * Created by Błażej on 15.09.2016.
 */
package examples
{
public class ClassesPart2
{
	public function execute(input:String):void
	{
		var stalker:ProtossCreature = new ProtossCreature(80);
		stalker.shield = 80;
		var roach:ZergCreature = new ZergCreature(120);
		roach.hpPerSec = 0.5;

		sayTotalHp(stalker);
		sayTotalHp(roach);
	}

	public function sayTotalHp(creature:Creature):void
	{
		trace(creature.getTotalHealth());
	}

}
}

class Creature
{
	protected var _hp:Number;

	public function Creature(hp:Number)
	{
		_hp = hp;
	}

	public function getTotalHealth():Number
	{
		return _hp;
	}
}

class ProtossCreature extends Creature
{
	public var shield:Number;


	public function ProtossCreature(hp:Number)
	{
		super(hp);
	}

	override public function getTotalHealth():Number
	{
		return _hp + shield;
	}
}

class ZergCreature extends Creature
{
	public var hpPerSec:Number;


	public function ZergCreature(hp:Number)
	{
		super(hp);
	}
}

