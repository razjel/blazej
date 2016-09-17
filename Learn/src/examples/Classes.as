/**
 * Created by Błażej on 15.09.2016.
 */
package examples
{
public class Classes
{
	public function execute(input:String):void
	{
		var stalker:Creature = new Creature();
		stalker.dmg = 15;
		stalker.speed = 115;
		stalker.hp = 160;
		//stalker.countHitsToKill();

		var roach:Creature = new Creature();
		roach.dmg = 13;
		roach.speed = 120;
		roach.hp = 120;
		roach.countHitsToKill(stalker.hp);

		var marines:Creature = new Creature();
		marines.dmg = 10;
		marines.speed = 150;
		marines.hp = 50;
		//marines.countHitsToKill();

		var simpleCreature:Object =
		{
			dmg: 20,
			speed: 200,
			hp: 350,
			ability: "fly"
		};


		var result:Number = calcDmgPerMin(stalker.dmg);
		trace(result); // 75
		var resultClass:Number = calcDmgPerMinForClass(stalker);
		trace(resultClass); // 75

		calcAndSaveDmgPerMin(stalker.dmgPerMin, stalker.dmg);
		trace(stalker.dmgPerMin); // 0
		calcAndSaveDmgPerMinForClass(stalker);
		trace(stalker.dmgPerMin); // 75			
	}

	private function calcDmgPerMin(creatureDmg:Number):Number
	{
		return creatureDmg * 5;
	}

	private function calcDmgPerMinForClass(creature:Creature):Number
	{
		return creature.dmg * 5;
	}

	private function calcAndSaveDmgPerMin(creatureDmgPerMin:Number, creatureDmg:Number):void
	{
		creatureDmgPerMin = creatureDmg * 5;
	}

	private function calcAndSaveDmgPerMinForClass(creature:Creature):void
	{
		creature.dmgPerMin = creature.dmg * 5;
	}

}
}

class Creature
{
	public var dmg:Number;
	public var speed:Number;
	public var hp:Number;

	public var dmgPerMin:Number = 0;
	
	public function Creature(dmg:Number = 0, speed:Number = 0, hp:Number = 0, dmgPerMin:Number = 0)
	{
		this.dmg = dmg;
		this.speed = speed;
		this.hp = hp;
		this.dmgPerMin = dmgPerMin;
	}

	public function countHitsToKill(enemyHP:Number):void
	{
		trace(enemyHP / dmg);
	}
}