/**
 * Created by Błażej on 23.09.2016.
 */
package logic
{
import model.Model;

public class InitDataAction
{
	public static function init()
	{
		var reaper:HeroStats = new HeroStats;
		reaper.healthPoint = 250;
		reaper.maxHealthPoint = 250;
		reaper.damage = 50;
		reaper.heroName = "Reaper";
		var solider:HeroStats = new HeroStats;
		solider.healthPoint = 200;
		solider.maxHealthPoint = 200;
		solider.damage = 15;
		solider.heroName = "Solider";

		Model.hero1 = reaper;
		Model.hero2 = solider;

	}
}
}
