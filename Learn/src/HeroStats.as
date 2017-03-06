/**
 * Created by Błażej on 21.09.2016.
 */
package
{
import flash.utils.Dictionary;

public class HeroStats
{

	public var healthPoint:Number;
	public var maxHealthPoint:Number;
	public var shield:Number;
	public var maxShield:Number;
	public var armor:Number;
	public var armorShield:Number;
	public var race:String;
	public var type:Array;
	public var space:String;
	public var damage:Number;
	public var typeDamage:Number;
	public var bonusDamage:Dictionary;
	public var attackAmount:Number;
	public var attackSpeed:Number;
	public var previousAttackTime:Number;
	public var range:Number;
	public var movementSpeed:Number;
	public var damageUpgradeLevel:Number;
	public var armorUpgradeLevel:Number;
	public var damageMeleeUpgradeLevel:Number;
	public var shieldUpgradeLevel:Number;
	public var damageUpgradeConverter:Number;
	public var armorUpgradeConverter:Number;
	public var shieldUpgradeConverter:Number;
	public var damageTypeUpgradeConverter:Number;
	public var damageMeleeUpgradeConverter:Number;
	public var heroName:String;
	public var imageUrl:String;
	public var counter:Number = 2;

	public function HeroStats()
	{
	}
}
}
