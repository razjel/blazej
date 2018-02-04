/**
 * Created by Szczepan Czaicki, s.czaicki@getprintbox.com
 * Date: 15.04.2015
 *
 * Copyright (c) 2013, Printbox www.getprintbox.com
 * All rights reserved.
 */
package com.utils
{
import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.core.FlexGlobals;
import mx.core.UIComponent;
import mx.utils.MatrixUtil;

import spark.components.Application;

public class DebugUtil
	{
		public static var cTopLayerUIC:UIComponent = new UIComponent();

		private static function addTopLayer():void
		{
			Application(FlexGlobals.topLevelApplication).systemManager.addChild(cTopLayerUIC);
		}

		private static function remTopLayer():void
		{
			cTopLayerUIC.parent.removeChild(cTopLayerUIC);
		}


		public static function clearGraphics():void
		{
			cTopLayerUIC.graphics.clear();
		}

		public static function setSquareLineStyle(thickness:Number = 0, color:uint = 0, alpha:Number = 1.0):void
		{
			cTopLayerUIC.graphics.lineStyle(thickness, color, alpha, false, LineScaleMode.NORMAL, CapsStyle.SQUARE,
			                                JointStyle.MITER, 3);
		}

		/**
		 * Draws border around object passed as argument. If bounds aren't specified than function takes
		 * bounds from object. If bounds are specified, than function will draw border around coordinates of this
		 * bounds, treating them as if they were in the same coordinate space as object.
		 *
		 * This function doesn't set line and fill properties, it must be done manually by accessing
		 * <code>cTopLayerUIC.graphics</code> property.
		 *
		 * @param object object around bounds are drawn, used also as coordinate space origin for bounds
		 * @param bounds custom bounds which will be used instead of object bounds
		 */
		public static function drawBounds(object:DisplayObject, bounds:Rectangle = null):void
		{
			if (!object)
				return;

			if (!cTopLayerUIC.parent)
				addTopLayer();

			if (!bounds)
				bounds = object.getBounds(object);

			var computedMatrix:Matrix = MatrixUtil.getConcatenatedComputedMatrix(object, cTopLayerUIC.parent);
			var globalBounds:Rectangle = getTransformedRect(bounds, computedMatrix);

			cTopLayerUIC.graphics.moveTo(globalBounds.x, globalBounds.y);
			cTopLayerUIC.graphics.lineTo(globalBounds.right, globalBounds.y);
			cTopLayerUIC.graphics.lineTo(globalBounds.right, globalBounds.bottom);
			cTopLayerUIC.graphics.lineTo(globalBounds.x, globalBounds.bottom);
			cTopLayerUIC.graphics.lineTo(globalBounds.x, globalBounds.y);
		}

		public static function getTransformedRect(rect:Rectangle, matrix:Matrix):Rectangle
		{
			var points:Vector.<Point> = new Vector.<Point>();
			points.push(rect.topLeft);
			points.push(new Point(rect.right, rect.top));
			points.push(rect.bottomRight);
			points.push(new Point(rect.left, rect.bottom));

			var topLeft:Point = new Point(int.MAX_VALUE, int.MAX_VALUE);
			var bottomRight:Point = new Point(int.MIN_VALUE, int.MIN_VALUE);
			for each (var point:Point in points)
			{
				point = matrix.transformPoint(point);
				topLeft.x = Math.min(topLeft.x, point.x);
				topLeft.y = Math.min(topLeft.y, point.y);
				bottomRight.x = Math.max(bottomRight.x, point.x);
				bottomRight.y = Math.max(bottomRight.y, point.y);
			}

			var bounds:Rectangle = new Rectangle();
			bounds.topLeft = topLeft;
			bounds.bottomRight = bottomRight;
			return bounds;
		}
	}
}