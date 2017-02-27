package examples
{
public class Basics
{
	
	public function Basics()
	{
		var bool:Boolean = false;
		var numIn:int = 23;
		var num:Number = 3.123;
		var str:String = "ala ma kota";
		var obj:Object = {
			ala: "kot"
		};
		var tab:Array = [num, numIn, 123, "asdf", {}];
		tab.push(12341);
		tab.unshift("poczatek");
		tab.pop();
		tab.shift();
		tab.splice(2, 10, null);
		trace(tab);
		trace("drugi element: " + tab[1]);


		if (str == "ala ma psa")
		{
			trace("pies");
		}
		else if (str == "ala ma slonia")
		{
			trace("slon");
		}
		else
		{
			trace("inne zwierze")
		}

		switch (str)
		{
			case "ala ma psa":
				trace("pies");
				break;

			case "ala ma slonia":
				trace("slon")
				break;

			default:
				trace("inne zwierze");
		}

		for (var i:int; i < tab.length; i++)
		{
			trace(i + ". " + tab[i]);
		}

		while (false)
		{
		trace("while");
		}

		do
		{
			trace("do while");
		}
		while (false)


	}
}
}