/**
 * Created by razjel on 10.08.2017.
 */
package
{
public class Variables
{
	public static var lastLoopTime:uint = 0;
	public static var startTime:uint;
	[Bindable]
	public static var exerciseName:Array = ["Ready"];
	[Bindable]
	public static var exerciseDuration:Array = [5];
	[Bindable]
	public static var repeatingNumber:Number = 0;
	[Bindable]
	public static var displayNumber:Number = 5;
	[Bindable]
	public static var displayDoneExercise:String = "Ready";
	[Bindable]
	public static var displayNextExercise:String;
	/*[ArrayElementType("ExerciseData")]*/
	public static var exercises:Array = [];
	[Bindable]
	public static var visibleMenu:Boolean = true;
	[Bindable]
	public static var nowBreak:Boolean = false;
	[Bindable]
	public static var breakDuration:Number = 0;
	[Bindable]
	public static var amountOfExercises:Number = 0;
	[Bindable]
	public static var partName:Array;
	[Bindable]
	public static var repeatNumber:Number;
	[Bindable]
	public static var breakBetweenRepeatsDuration:Number;
	[Bindable]
	public static var nowOpenPart:Number = 0;
	public static var menuView:Menu;
}
}

