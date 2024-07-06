// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.CalcUtil

package common {
import flash.geom.Point;
import flash.geom.Rectangle;

public class CalcUtil {


	public static function getCenterPosOffsetForScaledBound(_arg_1:Rectangle, _arg_2:Number):Point {
		var _local_3:Number = _arg_1.width;
		var _local_4:Number = _arg_1.height;
		var _local_5:Number = (_arg_1.width * _arg_2);
		var _local_6:Number = (_arg_1.height * _arg_2);
		var _local_7:Number = (_local_5 - _local_3);
		var _local_8:Number = (_local_6 - _local_4);
		var _local_9:Number = (_arg_1.x + (_arg_1.width / 2));
		var _local_10:Number = (_arg_1.y + (_arg_1.height / 2));
		var _local_11:Number = ((0 - _local_9) / _local_3);
		var _local_12:Number = ((0 - _local_10) / _local_4);
		var _local_13:Number = (_local_11 * _local_7);
		var _local_14:Number = (_local_12 * _local_8);
		return (new Point(_local_13, _local_14));
	}

	public static function createScalingAnimationParameters(_arg_1:Point, _arg_2:Point, _arg_3:Rectangle, _arg_4:Number, _arg_5:Number):Object {
		var _local_17:Number;
		var _local_18:Number;
		var _local_6:Number = 1.04;
		var _local_7:Number = ((Math.abs(_arg_2.x) > 0.001) ? _arg_2.x : 1);
		var _local_8:Number = ((Math.abs(_arg_2.y) > 0.001) ? _arg_2.y : 1);
		var _local_9:Number = (1 / _local_7);
		var _local_10:Number = (1 / _local_8);
		var _local_11:Number = _arg_3.width;
		var _local_12:Number = _arg_3.height;
		if (((_local_11 > 0) && (_local_12 > 0))) {
			_local_17 = ((_local_11 + (_arg_4 * _local_9)) / _local_11);
			_local_18 = ((_local_12 + (_arg_5 * _local_10)) / _local_12);
			_local_6 = Math.min(_local_17, _local_18);
		}

		var _local_13:Point = CalcUtil.getCenterPosOffsetForScaledBound(_arg_3, _local_6);
		var _local_14:Number = (_arg_1.x + (_local_13.x * _local_7));
		var _local_15:Number = (_arg_1.y + (_local_13.y * _local_8));
		var _local_16:Object = {
			"scaleX": (_local_6 * _local_7),
			"scaleY": (_local_6 * _local_8),
			"x": _local_14,
			"y": _local_15
		};
		return (_local_16);
	}


}
}//package common

