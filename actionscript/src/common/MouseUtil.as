// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.MouseUtil

package common {
import flash.display.Sprite;
import flash.events.MouseEvent;

import common.menu.MenuConstants;

public class MouseUtil {

	public static const MODE_DISABLE:int = 0;
	public static const MODE_ONOVER_SELECT_ONUP_CLICK:int = 1;
	public static const MODE_ONOVER_HOVER_ONUP_SELECT:int = 2;
	public static const MODE_ONOVER_HOVER_ONUP_SELECTCLICK:int = 3;
	public static const MODE_WHEEL_IGNORE:int = 0;
	public static const MODE_WHEEL_GROUP:int = 1;


	public static function getModeFromName(_arg_1:String):int {
		if (_arg_1 == "disable") {
			return (MODE_DISABLE);
		}

		if (_arg_1 == "onover-select-onup-click") {
			return (MODE_ONOVER_SELECT_ONUP_CLICK);
		}

		if (_arg_1 == "onover-hover-onup-select") {
			return (MODE_ONOVER_HOVER_ONUP_SELECT);
		}

		if (_arg_1 == "onover-hover-onup-selectclick") {
			return (MODE_ONOVER_HOVER_ONUP_SELECTCLICK);
		}

		return (-1);
	}

	public static function getWheelModeFromName(_arg_1:String):int {
		if (_arg_1 == "ignore") {
			return (MODE_WHEEL_IGNORE);
		}

		if (_arg_1 == "group-prev-next") {
			return (MODE_WHEEL_GROUP);
		}

		return (-1);
	}

	public static function handleMouseUp(_arg_1:int, _arg_2:Sprite, _arg_3:Function, _arg_4:MouseEvent):void {
		Log.mouse(_arg_2, _arg_4);
		_arg_4.stopImmediatePropagation();
		if (_arg_1 == MODE_ONOVER_SELECT_ONUP_CLICK) {
			doClick(_arg_2, _arg_3, _arg_4);
		} else {
			if (_arg_1 == MODE_ONOVER_HOVER_ONUP_SELECT) {
				doSelect(_arg_2, _arg_3, _arg_4);
			} else {
				if (_arg_1 == MODE_ONOVER_HOVER_ONUP_SELECTCLICK) {
					doSelect(_arg_2, _arg_3, _arg_4);
					doClick(_arg_2, _arg_3, _arg_4);
				}

			}

		}

	}

	public static function handleMouseRollOver(_arg_1:int, _arg_2:Sprite, _arg_3:Function, _arg_4:MouseEvent):void {
		_arg_4.stopImmediatePropagation();
		if (_arg_1 == MODE_ONOVER_SELECT_ONUP_CLICK) {
			doSelect(_arg_2, _arg_3, _arg_4);
		} else {
			if (((_arg_1 == MODE_ONOVER_HOVER_ONUP_SELECT) || (_arg_1 == MODE_ONOVER_HOVER_ONUP_SELECTCLICK))) {
				doHover(_arg_2, _arg_3, _arg_4, true);
			}

		}

	}

	public static function handleMouseRollOut(_arg_1:int, _arg_2:Sprite, _arg_3:Function, _arg_4:MouseEvent):void {
		_arg_4.stopImmediatePropagation();
		if (((_arg_1 == MODE_ONOVER_HOVER_ONUP_SELECT) || (_arg_1 == MODE_ONOVER_HOVER_ONUP_SELECTCLICK))) {
			doHover(_arg_2, _arg_3, _arg_4, false);
		}

	}

	private static function doClick(_arg_1:Sprite, _arg_2:Function, _arg_3:MouseEvent):void {
		var _local_4:int;
		if (_arg_1["_nodedata"]) {
			_local_4 = (_arg_1["_nodedata"]["id"] as int);
			(_arg_2("onElementClick", _local_4));
		}

	}

	private static function doSelect(_arg_1:Sprite, _arg_2:Function, _arg_3:MouseEvent):void {
		var _local_4:Function;
		var _local_5:int;
		if (("isSelected" in _arg_1)) {
			_local_4 = (_arg_1["isSelected"] as Function);
			if (((!(_local_4 == null)) && (_local_4() == true))) {
				return;
			}

		}

		if (_arg_1["_nodedata"]) {
			_local_5 = (_arg_1["_nodedata"]["id"] as int);
			(_arg_2("onElementSelect", _local_5));
		}

	}

	private static function doHover(_arg_1:Sprite, _arg_2:Function, _arg_3:MouseEvent, _arg_4:Boolean):void {
		var _local_5:int;
		var _local_6:Array;
		if (_arg_1["_nodedata"]) {
			_local_5 = (_arg_1["_nodedata"]["id"] as int);
			_local_6 = [_local_5, _arg_4];
			(_arg_2("onElementHover", _local_6));
		}

	}

	public static function handleMouseWheel(_arg_1:int, _arg_2:Sprite, _arg_3:Function, _arg_4:MouseEvent):void {
		if (_arg_1 == MODE_WHEEL_IGNORE) {
			return;
		}

		_arg_4.stopImmediatePropagation();
		if (_arg_1 == MODE_WHEEL_GROUP) {
			doWheelGroupPrevNext(_arg_2, _arg_3, _arg_4);
		}

	}

	private static function doWheelGroupPrevNext(_arg_1:Sprite, _arg_2:Function, _arg_3:MouseEvent):void {
		var _local_4:Function;
		var _local_5:int;
		if (_arg_3.delta == 0) {
			return;
		}

		if (("isWheelDelayActive" in _arg_1)) {
			_local_4 = (_arg_1["isWheelDelayActive"] as Function);
			if (((!(_local_4 == null)) && (_local_4() == true))) {
				return;
			}

			startWheelDelay(_arg_1);
		}

		if (_arg_1["_nodedata"]) {
			_local_5 = (_arg_1["_nodedata"]["id"] as int);
			if (_arg_3.delta > 0) {
				(_arg_2("onGroupPrev", _local_5));
			} else {
				(_arg_2("onGroupNext", _local_5));
			}

		}

	}

	private static function startWheelDelay(obj:Sprite):void {
		var setWheelDelayActiveFunc:Function;
		if (("setWheelDelayActive" in obj)) {
			setWheelDelayActiveFunc = (obj["setWheelDelayActive"] as Function);
			if (setWheelDelayActiveFunc != null) {
				(setWheelDelayActiveFunc(true));
				Animate.delay(obj, MenuConstants.WheelScrollTime, function (_arg_1:Sprite):void {
					var _local_2:Function = (_arg_1["setWheelDelayActive"] as Function);
					if (_local_2 != null) {
						(_local_2(false));
					}

				}, obj);
			}

		}

	}


}
}//package common

