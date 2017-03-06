/**
 * Created by Błażej on 23.09.2016.
 */
package model
{
import flash.utils.getTimer;

import logic.Actions;

import overwatch.views.BattleGround;

public class Model
{
	public static var startBattle: Boolean = false;
	public static var lastLoopTime:uint;
	public static var hero1:HeroStats;
	public static var hero2:HeroStats;
	public static var view:BattleGround;
	public static var timeStart:uint;
}
}
