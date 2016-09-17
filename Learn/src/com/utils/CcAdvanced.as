/*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License
 * in root directory in mlib_license.txt file or at
 * http://www.mozilla.org/MPL/
 */

/**
 * Created by Szczepan Czaicki
 * e-mail: s.czaicki@hiddendata.co
 * Date: 14.05.12
 * Time: 12:30
 */
package com.utils
{

import com.junkbyte.console.Cc;
import com.junkbyte.console.KeyBind;
import com.junkbyte.console.addons.displaymap.DisplayMapAddon;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

/**
 * Some of base classes placed in ExternalLibs were modified, to improve console. Here are listed changes:
 * - Console.as - function set visible - now always changes visible property on mainPanel
 * - CommandLine.as - added getter for scope and function restore
 */
public class CcAdvanced
{                                                                                                             
	private static const TEMPORARY_STORE:String = "temporary_store";
	private static var NO_PROP:NoProp;

	public static var app:DisplayObjectContainer;
	private static var _tracing:Boolean;
	private static var _inited:Boolean;
	private static var _origin:String = 'junkbyte_console_origin';
	//-------------------------  focus  -----------------------------
	private static var _lastFocus:*;
	//-------------------------  prop  -----------------------------
	private static var _isWatchingProp:Boolean;
	[ArrayElementType("String")]
	private static var _watchingPropNames:Array;
	private static var _watchingPropValues:Dictionary;
	//-------------------------  drawing border  -----------------------------
	private static var _drawingScopeBorder:Boolean;
	private static var _oldScope:*;

	/**
	 * Console must be initialized with instance of starting class, because some functions needs reference to top
	 * display object without making dependencies with flex.
	 * @param mainApp instance of main application
	 */
	public static function init(mainApp:DisplayObjectContainer):void
	{
		if (!_inited)
		{
			NO_PROP = new NoProp();
			Cc.config.commandLineAllowed = true;
			Cc.config.commandLineAutoScope = true;
			Cc.config.tracing = true;
			Cc.config.style.menuFont = "Consolas";
			Cc.config.style.traceFont = "Consolas";
			Cc.startOnStage(DisplayObject(mainApp), '`');
//				CommandLineAutoFocusAddon.registerToConsole(Cc.instance);
			DisplayMapAddon.addToMenu();
			Cc.setRollerCaptureKey('r');
			Cc.store('main', mainApp);
			app = mainApp;
			Cc.commandLine = true;

			//-------------------------  keyBinds  -----------------------------
			Cc.bindKey(new KeyBind('q', false, true), showPanel, ['f']);
			Cc.bindKey(new KeyBind('w', false, true), showPanel, ['m']);
			Cc.bindKey(new KeyBind('e', false, true), showPanel, ['cl']);
			Cc.bindKey(new KeyBind('r', false, true), showPanel, ['ro']);
			Cc.bindKey(new KeyBind('a', false, true), fastRestore);
			Cc.bindKey(new KeyBind('s', false, true), fastStore);
			Cc.bindKey(new KeyBind('d', false, true), toggleDrawingScopeBorder);
			//-------------------------  slash commands  -----------------------------
			var desc:String;
			Cc.addSlashCommand('debug', debug,
			                   'Function on which one can catch breakpoint and analyze object in scope');
			Cc.addSlashCommand('a', a, 'Returns object from object in current scope. Works if scope is ' +
			                   'Array, ArrayList, ArrayCollection or any Vector');
			Cc.addSlashCommand('as', a_s,
			                   'Returns object from object in current scope and sets scope to returned ' +
			                   'object. Works if scope is Array, ArrayList, ArrayCollection or any Vector');
			Cc.addSlashCommand('al', al,
			                   'List all objects in current scope. Works if scope is any type of object, ' +
			                   'which can be iterated using for each loop');
			Cc.addSlashCommand('traceDisp', traceDisp, 'Traces variables which describes display');
			Cc.addSlashCommand('watchProp', watchProp, 'Start watching property of object in scope. ' +
			                   'If scope changes, same property will be checked in new object');
			Cc.addSlashCommand('unwatchProp', unwatchProp, 'Stop watching property.');
			Cc.addSlashCommand('watchFocus', watchFocus,
			                   'Start monitoring focused object and logs if focus is changed');
			Cc.addSlashCommand('unwatchFocus', unwatchFocus, 'Stop monitoring focus');
			Cc.addSlashCommand('traceFocus', traceFocus, 'Traces currently focused object');
			Cc.addSlashCommand('traceXml', traceXml, 'Display xml property of object');
			Cc.addSlashCommand('watchKeyDown', watchKeyDown, 'Start monitoring keydown on application stage');
			Cc.addSlashCommand('unwatchKeyDown', unwatchKeyDown, 'Stop monitoring keydown');
			Cc.addSlashCommand('mouseEnb', mouseEnb, 'Sets mouseChildren and mouseEnabled to true');
			Cc.addSlashCommand('mouseDis', mouseDis, 'Sets mouseChildren and mouseEnabled to false');
			desc = 'Stores current scope under the name: "' + TEMPORARY_STORE + '"';
			Cc.addSlashCommand('fs', fastStore, desc);
			Cc.addSlashCommand('fastStore', fastStore, desc);
			desc = 'Set scope to object store under the name: "' + TEMPORARY_STORE + '"';
			Cc.addSlashCommand('fr', fastRestore, desc);
			Cc.addSlashCommand('fastRestore', fastRestore, desc);
			Cc.addSlashCommand('throwError', throwError,
			                   'Throws new Error, if params are specified, they are passed as Error message');
			Cc.addSlashCommand('border', toggleDrawingScopeBorder,
			                   'Turns on or off drawing border around object currently in scope');
			Cc.addSlashCommand('upProp', upProperty,
			                   'Traces value of property passed as parameter, on each object from current' +
			                   'scope to root of application.');
			Cc.addSlashCommand('upPropFull', upPropertyFull,
			                   'Traces value of property passed as parameter, on each object from current' +
			                   'scope to root of application. Displays full name of objects.');
			Cc.addSlashCommand('style', getCompStyle,
			                   'Return values of component styles');
			Cc.addSlashCommand("svar", _svar, "(name=value) Save variable");
			//-------------------------  slash commands for displaying panels  -----------------------------
			Cc.addSlashCommand('s', showPanel, 'Shows or hides one of console panels. Define which one using its ' +
			                   'name in console menu. Panels which can be used: "f", "m", "cl", "ro"');

			_inited = true;
		}
	}

	// ==============================================================
	// =====================				 shortcuts				====================
	// ==============================================================
	private static function showPanel(panel:String):void
	{
		switch (panel)
		{
			case 'f':
				Cc.fpsMonitor = !Cc.fpsMonitor;
				break;
			case 'm':
				Cc.memoryMonitor = !Cc.memoryMonitor;
				break;
			case 'cl':
				Cc.commandLine = !Cc.commandLine;
				break;
			case 'ro':
				Cc.displayRoller = !Cc.displayRoller;
				break;
		}
	}

	// ==============================================================
	// =====================				 slash functions				====================
	// ==============================================================
	//-------------------------  function for catching breakpoint  -----------------------------
	private static function debug():void
	{
		var scope:Object = getScope();
		var stop:int = 1;
	}

	//-------------------------  accessing array  -----------------------------
	private static function a(number:String = null):void
	{
		arrayCore(number ? parseInt(number) : 0, false);
	}

	private static function a_s(number:String = null):void
	{
		arrayCore(number ? parseInt(number) : 0, true);
	}

	private static function arrayCore(idx:int, changeScope:Boolean):void
	{
		var scope:Object = getScope();
		var obj:Object;
		if (scope is Array || scope is Vector)
			obj = scope[idx];
		else if (scope is ArrayList)
			obj = ArrayList(scope).source[idx];
		else if (scope is ArrayCollection)
			obj = ArrayCollection(scope).getItemAt(idx);
		setScope(obj, changeScope);
	}

	private static function al(prop:String = null):void
	{
		var scope:Object = getScope();
		var tab:Object;
		if (scope is ArrayList || scope is ArrayCollection)
			tab = scope.source;
		else
			tab = scope;
		for each (var obj:* in tab)
		{
			setScope(prop ? obj[prop] : obj, false);
		}
	}

	//-------------------------  trace display properties  -----------------------------
	private static function traceDisp():void
	{
		var scope:Object = getScope()
		ls;
		var props:Array = ['x', 'y', 'width', 'height', 'alpha', 'visible', 'includeInLayout', 'scaleX', 'scaleY',
		                   'scaleZ', 'rotation', 'rotationX', 'rotationY', 'rotationZ', 'minWidth', 'minHeight',
		                   'maxWidth', 'maxHeight', 'measuredWidth', 'measuredHeight', 'measuredMinWidth',
		                   'measuredMinHeight', 'explicitWidth', 'explicitHeight', 'explicitMinWidth',
		                   'explicitMinHeight', 'explicitMaxWidth', 'explicitMaxHeight', 'percentWidth',
		                   'percentHeight']
		var len:int = props.length;
		for (var i:int = 0; i < len; i++)
		{
			if (scope.hasOwnProperty(props[i]))
				Cc.log(props[i] + "=" + scope[props[i]])
		}
		le
	}

	//-------------------------  focus  -----------------------------
	private static function watchFocus():void
	{
		app.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		traceFocus()
	}

	private static function unwatchFocus():void
	{
		app.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private static function onEnterFrame(evt:Event = null):void
	{
		if (_lastFocus != app.stage.focus)
		{
			traceFocus()
			_lastFocus = app.stage.focus
		}
	}

	private static function traceFocus():void
	{
		ls
		Cc.log("focus=" + app.stage.focus)
		le
	}

	//-------------------------  watch prop  -----------------------------
	private static function watchProp(props:String = null):void
	{
		if (_isWatchingProp)
			unwatchProp();
		if (!props)
		{
			ls;
			Cc.log("You must specify property names");
			le;
		}
		else
		{
			_isWatchingProp = true;
			if (_watchingPropNames)
				_watchingPropNames.length = 0;
			for (var key:* in _watchingPropValues)
				delete _watchingPropValues[key];
			_watchingPropNames = props.split(" ");
			_watchingPropValues = new Dictionary();
			app.addEventListener(Event.ENTER_FRAME, onWatchPropEnterFrame);
		}
	}

	private static function unwatchProp():void
	{
		_isWatchingProp = false;
		app.removeEventListener(Event.ENTER_FRAME, onWatchPropEnterFrame);
	}

	private static function onWatchPropEnterFrame(evt:Event = null):void
	{
		var scope:Object = getScope();
		var propsToLog:Array = [];
		var anyChange:Boolean;
		for each (var propName:String in _watchingPropNames)
		{
			var dispPropName:String = propName
			var newPropValue:*;
			var scopePart:Object = scope;
			var propPart:String;
			var propParts:Array = propName.split(".");
			var loopBroken:Boolean;
			var len:int = propParts.length - 1;
			for (var i:int = 0; i < len; i++)
			{
				propPart = propParts[i];
				if (propPart in scopePart)
				{
					if (scopePart[propPart] == null)
					{
						newPropValue = "null";
						loopBroken = true;
						break;
					}
					else
					{
						scopePart = scopePart[propPart];
					}
				}
				else
				{
					newPropValue = NO_PROP;
					loopBroken = true;
					break;
				}
			}
			if (loopBroken)
			{
				var notNullPartNames:Array = [];
				for (var j:int = 0; j < i + 1; j++)
					notNullPartNames.push(propParts[j]);
				dispPropName = notNullPartNames.join(".");
			}

			if (newPropValue != NO_PROP)
			{
				propPart = propParts[i];
				if (propPart in scopePart)
					newPropValue = scopePart[propPart] == null ? 'null' : '"' + scopePart[propPart] + '"';
				else
					newPropValue = NO_PROP;
			}

			if (_watchingPropValues[propName] != newPropValue)
			{
				anyChange = true;
				_watchingPropValues[propName] = newPropValue;
				propsToLog.push(dispPropName + '=' + newPropValue);
			}
		}
		if (anyChange)
		{
			ls;
			Cc.log(propsToLog);
			le;
		}
	}

	//-------------------------  xml  -----------------------------
	private static function traceXml():void
	{
		var scope:Object = getScope()
		if (scope.hasOwnProperty('xml'))
		{
			ls
			Cc.log(scope['xml'])
			le
		}
	}

	//-------------------------  keyDown  -----------------------------
	private static function watchKeyDown():void
	{
		app.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private static function unwatchKeyDown():void
	{
		app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private static function onKeyDown(evt:KeyboardEvent):void
	{
		ls;
		var keyChars:Array = [];
		if (evt.ctrlKey)
			keyChars.push('ctrl')
		if (evt.altKey)
			keyChars.push('alt')
		if (evt.shiftKey)
			keyChars.push('shift')
		var keyFound:Boolean = false;
		for (var i:int = 1; i < 13; i++)
		{
			if (evt.keyCode == Keyboard['F' + i])
			{
				keyChars.push('F' + i);
				keyFound = true;
				break;
			}
		}
		if (!keyFound && evt.charCode != 0)
			keyChars.push(String.fromCharCode(evt.charCode));
		Cc.log('keyDown char="' + keyChars.join(" + ") + '" code="' + evt.charCode + '"');
		le;
	}

	//-------------------------  mouse events  -----------------------------
	private static function mouseEnb():void
	{
		var scope:Object = getScope()
		if (scope.hasOwnProperty('mouseChildren'))
			scope['mouseChildren'] = true
		if (scope.hasOwnProperty('mouseEnabled'))
			scope['mouseEnabled'] = true
	}

	private static function mouseDis():void
	{
		var scope:Object = getScope()
		if (scope.hasOwnProperty('mouseChildren'))
			scope['mouseChildren'] = false
		if (scope.hasOwnProperty('mouseEnabled'))
			scope['mouseEnabled'] = false
	}

	//-------------------------  store/restore  -----------------------------
	private static function fastStore():void
	{
		store(TEMPORARY_STORE, getScope());
	}

	private static function fastRestore():void
	{
		setScope(restore(TEMPORARY_STORE), true);
	}

	private static function _svar(message:String):void
	{
		var tab:Array = message.split("=");
		if ((tab[0] as String).match(/\s/))
		{
			ls;
			Cc.log("var name can't have whitespace");
			le;
		}
		else
		{
			store(tab[0], tab[1]);
		}
	}

	//-------------------------  throw error  -----------------------------
	/**
	 * Error have to be thrown with delay, other wise console will catch exception and it won't be dispatched in
	 * application.
	 * @param msg message of error
	 */
	private static function throwError(msg:String = 'null'):void
	{
		setTimeout(function (msg:String = null):void { throwErrorNested1(msg); }, 1, msg);
	}

	private static function throwErrorNested1(msg:String = 'null'):void { throwErrorNested2(msg); }

	private static function throwErrorNested2(msg:String = 'null'):void { throwErrorNested3(msg); }

	private static function throwErrorNested3(msg:String = 'null'):void { throw new Error(msg); }

	//-------------------------  drawing scope border  -----------------------------
	private static function toggleDrawingScopeBorder():void
	{
		if (_drawingScopeBorder)
		{
			app.removeEventListener(Event.ENTER_FRAME, watchScope);
			_drawingScopeBorder = false;
			DebugUtil.clearGraphics();
			_oldScope = null;
		}
		else
		{
			app.addEventListener(Event.ENTER_FRAME, watchScope);
			drawBorder();
			_drawingScopeBorder = true;
		}
	}

	private static function watchScope(evt:Event = null):void
	{
		drawBorder();
	}

	private static function drawBorder():void
	{
		DebugUtil.clearGraphics();
		_oldScope = getScope();
		if (_oldScope is DisplayObject && _oldScope.parent)
		{
			DebugUtil.clearGraphics();
			DebugUtil.setSquareLineStyle(5, 0x00A2E8);
			DebugUtil.drawBounds(_oldScope);
		}
	}

	//-------------------------  up property  -----------------------------
	public static function upPropertyFull(props:String):void
	{
		upPropertyCore(props, true);
	}

	public static function upProperty(props:String):void
	{
		upPropertyCore(props, false);
	}

	private static function upPropertyCore(props:String, fullName:Boolean):void
	{
		var p:Object = getScope();
		var value:*;
		ls;
		var texts:Array = [];
		var row:Array;
		var splittedProps:Array = props.split(" ");
		while (p && 'parent' in p)
		{
			row = [];
			for each (var prop:String in splittedProps)
			{
				try
				{
					value = getValue(p, prop);
				}
				catch (err:Error)
				{
					value = '#error#';
				}
				if (fullName)
					row.push(p);
				row.push(prop + ":");
				row.push(value);
			}
			texts.push(row);
			try
			{
				p = p.parent;
			}
			catch (err:Error)
			{
				break;
			}
		}
		Cc.log("\n" + toStringWithEqualColumns(texts));
		le;
	}

	// ==============================================================
	// =====================				 get styles				====================
	// ==============================================================
	private static function getCompStyle(props:String):void
	{
		ls;
		var scope:Object = getScope();
		var styles:Array = props.split(" ");
		for each (var styleName:String in styles)
		{
			try
			{
				Cc.log(styleName + ": " + scope.getStyle(styleName));
			}
			catch (error:Error)
			{
				Cc.log(styleName + ": " + error.toString());
			}
		}
		le;
	}


	// ==============================================================
	// =====================				 helpers				====================
	// ==============================================================
	public static function getScope():Object
	{
		if (!('scope' in Cc.instance.cl))
			trace("property scope was added by Razjel to CommandLine class, so it might not work if external " +
			      "libs were updated");
		return Cc.instance.cl['scope']
	}

	public static function setScope(value:Object, changeScope:Boolean):void
	{
		Cc.instance.cl.setReturned(value, changeScope);
	}

	private static function get ls():Boolean
	{
		_tracing = Cc.config.tracing
		Cc.config.tracing = true
		return true
	}

	private static function get le():Boolean
	{
		Cc.config.tracing = _tracing
		Cc.setViewingChannels(' * ')
		return true
	}

	// ==============================================================
	// =====================				 additional API				====================
	// ==============================================================
	public static function store(name:String, obj:Object, strong:Boolean = false):void
	{
		Cc.instance.store(name, obj, strong);
	}

	public static function restore(name:String):*
	{
		return Cc.instance.cl.restore(name);
	}

	//---------------------------------------------------------------
	//
	//      functions from other utils
	//
	//---------------------------------------------------------------

	public static function getValue(obj:Object, propPath:String):*
	{
		if (!propPath) return obj;
		if (obj is int || obj is Number || obj is Boolean)
			throw new Error("bad type");
		if (!obj) return null;
		var props:Array = propPath.split('.');
		var len:int = props.length;
		for (var i:int = 0; i < len; i++)
			obj = obj[props[i]];
		return obj;
	}

	public static function toStringWithEqualColumns(texts:Array, withBorder:Boolean = false):String
	{
		var lengths:Array = [];
		for each (var row:Array in texts)
		{
			while (lengths.length < row.length)
				lengths.push(0);

			var len:int = row.length;
			for (var i:int = 0; i < len; i++)
				lengths[i] = Math.max(lengths[i], String(row[i]).length);
		}

		var rows:Array = [];
		var rowTextLength:int;
		if (withBorder)
		{
			for each (var txtLen:int in lengths)
				rowTextLength += txtLen + 2;
			rowTextLength--;
			rows.push(addAppendingChars("", rowTextLength + 2, "-"));
		}

		var rowStr:String;
		for each (var row:Array in texts)
		{
			rowStr = "";
			var len:int = row.length;
			if (withBorder)
				rowStr += "|";
			for (var i:int = 0; i < len; i++)
			{
				rowStr += addAppendingChars(row[i], lengths[i] + 1, " ");
				if (withBorder)
					rowStr += "|";
			}
			rows.push(rowStr);
			if (withBorder)
				rows.push(addAppendingChars("", rowTextLength + 2, "-"));
		}
		return rows.join("\n");
	}

	public static function addAppendingChars(string:String, totalLength:int = 2, char:String = "0",
	                                         trim:Boolean = false):String
	{
		if (string == null)
			string = "";

		if (string.length >= totalLength)
		{
			if (trim)
				return string.substr(0, totalLength)
			else
				return string;
		}
		else
		{
			while (string.length < totalLength)
				string = string + char;
		}
		return string;
	}

}
}

class NoProp
{
	public function toString():String
	{
		return "no_prop";
	}
}
