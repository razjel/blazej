/**
 * Created by Błażej on 17.09.2016.
 */
package examples
{
import flash.utils.clearInterval;
import flash.utils.clearTimeout;
import flash.utils.setInterval;
import flash.utils.setTimeout;

public class TimeoutExample
{
	public function execute():void
	{
		var intervalId:uint = setInterval(_onInterval, 1000, 123, "ala ma kota");
		var timeoutId:uint = setTimeout(_onTimeout, 5000, intervalId, "123", 12);

		//clearTimeout(timeoutId);
	}

	protected function _onTimeout(intervalId, arg1, arg2)
	{
		trace("timeout, arg1: " + arg1, "arg2: " + arg2);
		clearInterval(intervalId);
	}
	
	protected function _onInterval(arg1, arg2) 
	{
		trace("interval, arg1: " + arg1, "arg2: " + arg2);
	}
}
}
