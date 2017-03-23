/**
 * Created by Błażej on 23.09.2016.
 */
package logic
{
import flash.utils.Dictionary;

import model.Model;
import model.consts.UnitType;

public class InitDataAction
{
	public static function init()
	{
		var stalker:HeroStats = new HeroStats;
		stalker.healthPoint = 80;
		stalker.maxHealthPoint = 80;
		stalker.shield = 80;
		stalker.maxShield = 80;
		stalker.armor = 1;
		stalker.armorShield = 0;
		stalker.race = 'Protoss';
		stalker.type = [UnitType.ARMORED, UnitType.MECHANIC];
		stalker.space = "Ground";
		stalker.damage = 10;
		stalker.bonusDamage = new Dictionary();
		stalker.bonusDamage[UnitType.ARMORED] = 4;
		stalker.bonusDamage[UnitType.BIOLOGICAL] = 0;
		stalker.bonusDamage[UnitType.LIGHT] = 0;
		stalker.bonusDamage[UnitType.MASSIVE] = 0;
		stalker.bonusDamage[UnitType.MECHANIC] = 0;
		stalker.damageUpgradeLevel = 0;
		stalker.armorUpgradeLevel = 0;
		stalker.damageMeleeUpgradeLevel = 0;
		stalker.shieldUpgradeLevel = 0;
		stalker.damageUpgradeConverter = 1;
		stalker.damageMeleeUpgradeConverter = 0;
		stalker.damageTypeUpgradeConverter = 0;
		stalker.armorUpgradeConverter = 1;
		stalker.shieldUpgradeConverter = 1;
		stalker.attackAmount = 1;
		stalker.attackSpeed = 1030;
		stalker.previousAttackTime = 0;
		stalker.range = 6;
		stalker.movementSpeed = 4130;
		stalker.heroName = "stalker";
		stalker.imageUrl = "C:/Users/Błażej/Desktop/Programowanie i nauka/Stalker.png";

		var roach:HeroStats = new HeroStats;
		roach.healthPoint = 145;
		roach.maxHealthPoint = 145;
		roach.shield = 0;
		roach.maxShield = 0;
		roach.armor = 1;
		roach.armorShield = 0;
		roach.race = 'Zerg';
		roach.type = [UnitType.ARMORED, UnitType.BIOLOGICAL];
		roach.space = "Ground";
		roach.damage = 16;
		roach.bonusDamage = new Dictionary();
		roach.bonusDamage[UnitType.ARMORED] = 0;
		roach.bonusDamage[UnitType.BIOLOGICAL] = 0;
		roach.bonusDamage[UnitType.LIGHT] = 0;
		roach.bonusDamage[UnitType.MASSIVE] = 0;
		roach.bonusDamage[UnitType.MECHANIC] = 0;
		roach.damageUpgradeLevel = 0;
		roach.armorUpgradeLevel = 0;
		roach.damageMeleeUpgradeLevel = 0;
		roach.shieldUpgradeLevel = 0;
		roach.damageUpgradeConverter = 1;
		roach.damageMeleeUpgradeConverter = 0;
		roach.damageTypeUpgradeConverter = 0;
		roach.armorUpgradeConverter = 1;
		roach.attackAmount = 1;
		roach.attackSpeed = 1430;
		roach.previousAttackTime = 0;
		roach.range = 4;
		roach.movementSpeed = 3150;
		roach.heroName = "roach";
		roach.imageUrl = "C:/Users/Błażej/Desktop/Programowanie i nauka/Roach.png";

		var marauder:HeroStats = new HeroStats;
		marauder.healthPoint = 125;
		marauder.maxHealthPoint = 125;
		marauder.shield = 0;
		marauder.maxShield = 0;
		marauder.armor = 1;
		marauder.armorShield = 0;
		marauder.race = 'Terran';
		marauder.type = [UnitType.ARMORED, UnitType.BIOLOGICAL];
		marauder.space = "Infantry";
		marauder.damage = 5;
		marauder.bonusDamage = new Dictionary();
		marauder.bonusDamage[UnitType.ARMORED] = 5;
		marauder.damageUpgradeLevel = 0;
		marauder.armorUpgradeLevel = 0;
		marauder.damageMeleeUpgradeLevel = 0;
		marauder.shieldUpgradeLevel = 0;
		marauder.damageUpgradeConverter = 1;
		marauder.damageTypeUpgradeConverter = 1;
		marauder.damageMeleeUpgradeConverter = 0;
		marauder.armorUpgradeConverter = 1;
		marauder.attackAmount = 2;
		marauder.attackSpeed = 1700;
		marauder.previousAttackTime = 0;
		marauder.range = 6;
		marauder.movementSpeed = 3150;
		marauder.heroName = "marauder";
		marauder.imageUrl = "C:/Users/Błażej/Desktop/Programowanie i nauka/Marauder.png";
		
		Model.hero1 = stalker;
		Model.hero2 = roach
		;

	}
}
}
