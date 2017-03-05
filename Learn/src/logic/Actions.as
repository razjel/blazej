/**
 * Created by Błażej on 23.09.2016.
 */
package logic
{
import flash.utils.getTimer;

import model.Model;

import model.Model;

import model.Model;

import model.Model;

import model.Model;
import model.UnitType;
import model.UnitType;

public class Actions
{
	public function Actions()
	{

	}

	public static function get model():*
	{
		return Model;
	}


	public static function mainLoop():void
	{
		var t:uint = getTimer();
		Model.lastLoopTime = t;
		if (Model.startBattle && Model.hero1.healthPoint > 0 && Model.hero2.healthPoint > 0)
		{
			test(t, Model.hero2, Model.hero1)
			test(t, Model.hero1, Model.hero2)
			Model.view.update();
		}
	}

	public static function test(time:uint, attackingHero:HeroStats, defendingHero:HeroStats):void
	{
		var attackTime:uint = time - Model.timeStart;
		if (attackTime >= attackingHero.previousAttackTime + attackingHero.attackSpeed)
		{
			attackingHero.typeDamage = 0;
			for (var i:Number = 0; i < defendingHero.type.length; i++)
			{
				attackingHero.typeDamage = Math.max(attackingHero.typeDamage, attackingHero.bonusDamage[defendingHero.type[i]]);
			}
			trace(defendingHero.healthPoint, defendingHero.shield, defendingHero.heroName);
			for (var a:Number = 0; a < attackingHero.attackAmount; a++)
			{
				if (defendingHero.shield > 0)
				{
					attackingHero.counter++;
					if (defendingHero.armorShield >= attackingHero.damage && attackingHero.counter == 3)
						if (attackingHero.counter == 3)
						{
							defendingHero.shield += -1;
							attackingHero.counter = 0;
						}
						else break
					else
					{
						defendingHero.shield = defendingHero.shield + defendingHero.armorShield + defendingHero.shieldUpgradeConverter*defendingHero.shieldUpgradeLevel -
						attackingHero.damage - attackingHero.typeDamage - attackingHero.damageMeleeUpgradeConverter*attackingHero.damageMeleeUpgradeLevel -
						attackingHero.damageUpgradeConverter*attackingHero.damageUpgradeLevel - attackingHero.damageTypeUpgradeConverter*attackingHero.damageUpgradeLevel;
						if (defendingHero.shield < 0)
						{
							var bonusDamage:int = defendingHero.shield;
							defendingHero.shield = 0;
							defendingHero.healthPoint = Math.max(0, defendingHero.healthPoint + defendingHero.armor + bonusDamage);
						}
					}
				}
				else
				{
					attackingHero.counter++;
					if (defendingHero.armor >= attackingHero.damage)
					{
						if (attackingHero.counter == 3)
						{
							defendingHero.healthPoint += -1;
							attackingHero.counter = 0;
						}
						else break
					}
					else
					{
						defendingHero.healthPoint = Math.max(0, defendingHero.healthPoint + defendingHero.armor - attackingHero.damage - attackingHero.typeDamage +
						defendingHero.armorUpgradeConverter*defendingHero.armorUpgradeLevel - attackingHero.damageMeleeUpgradeConverter*attackingHero.damageMeleeUpgradeLevel -
						attackingHero.damageUpgradeConverter*attackingHero.damageUpgradeLevel - attackingHero.damageTypeUpgradeConverter*attackingHero.damageUpgradeLevel);

					}
				}
				attackingHero.previousAttackTime = attackingHero.previousAttackTime + attackingHero.attackSpeed;
			}

		}
	}


	import flash.utils.getTimer;


	public static function startBattle():void
	{
		if (Model.hero1.healthPoint >= 0, Model.hero2.healthPoint >= 0)
		{
			Model.timeStart = getTimer();
			Model.startBattle = true;
			Model.hero1.healthPoint = Model.hero1.maxHealthPoint;
			Model.hero1.shield = Model.hero1.maxShield;
			Model.hero2.healthPoint = Model.hero2.maxHealthPoint;
			Model.hero2.shield = Model.hero2.maxShield;
		}
	}
}
}
/*
for (var i:Number = 0; i <= 3; i++)
{
	upgradeDamage = 
}
 */


