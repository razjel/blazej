/**
 * Created by Błażej on 23.09.2016.
 */
package logic
{
import flash.utils.getTimer;

import model.Model;

public class Actions
{
	public function Actions()
	{

	}



	public static function mainLoop():void
	{
		for (var petla:int=1; petla < 100;)
		{
			petla = petla+1;
			if (petla = 99, Model.hero1.healthPoint > 0, Model.hero2.healthPoint > 0)
			{
				Model.hero1.healthPoint = Model.hero1.healthPoint - Model.hero2.damage;
				Model.hero2.healthPoint = Model.hero2.healthPoint - Model.hero1.damage;
				Model.view.update();
				trace("zadałem");
				petla = 1;
			}
		}
		var t:uint = getTimer();
	}
}
}
