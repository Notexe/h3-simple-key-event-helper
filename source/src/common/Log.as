// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.Log

package common {
import flash.events.MouseEvent;
import flash.utils.getQualifiedClassName;

public class Log {

	public static const ChannelMem:String = "Memory";
	public static const ChannelVideo:String = "Video";
	public static const ChannelImage:String = "Image";
	public static const ChannelLoca:String = "Loca";
	public static const ChannelScale:String = "Scaling";
	public static const ChannelMouse:String = "Mouse";
	public static const ChannelDebug:String = "Debug";
	public static const ChannelModal:String = "ModalDialog";
	public static const ChannelAni:String = "Animation";
	public static const ChannelContainer:String = "Container";
	public static const ChannelButtonPrompt:String = "ButtonPrompt";
	public static const ChannelCommon:String = "Common";
	public static const ChannelMenuFrame:String = "MenuFrame";


	public static function error(_arg_1:String, _arg_2:Object, _arg_3:String):void {
		logMessage("ERROR", _arg_1, _arg_2, _arg_3);
	}

	public static function xerror(_arg_1:String, _arg_2:String):void {
		error(_arg_1, null, _arg_2);
	}

	public static function warning(_arg_1:String, _arg_2:Object, _arg_3:String):void {
		logMessage("warning", _arg_1, _arg_2, _arg_3);
	}

	public static function xwarning(_arg_1:String, _arg_2:String):void {
		warning(_arg_1, null, _arg_2);
	}

	public static function info(_arg_1:String, _arg_2:Object, _arg_3:String):void {
		logMessage("info", _arg_1, _arg_2, _arg_3);
	}

	public static function xinfo(_arg_1:String, _arg_2:String):void {
		info(_arg_1, null, _arg_2);
	}

	public static function mouse(_arg_1:Object, _arg_2:MouseEvent, _arg_3:String = null):void {
		var _local_4:* = "event null";
		if (_arg_2) {
			_local_4 = (((("type: " + _arg_2.type) + " - target: ") + ((_arg_2.target == null) ? "<none>" : _arg_2.target.name)) + ((_arg_3 == null) ? "" : (" - " + _arg_3)));
		}

		logMessage("info", ChannelMouse, _arg_1, _local_4);
	}

	public static function debugData(_arg_1:Object, _arg_2:Object):void {
		var _local_3:int;
		debugDataRecursive(_local_3, _arg_2, _arg_1);
	}

	private static function debugDataRecursive(_arg_1:int, _arg_2:Object, _arg_3:Object):void {
		var _local_5:String;
		var _local_6:int;
		var _local_4:* = "Key";
		if (_arg_1 > 0) {
			_local_4 = ">";
			_local_6 = 0;
			while (_local_6 < (_arg_1 + 1)) {
				_local_4 = ("--" + _local_4);
				_local_6++;
			}

		}

		for (_local_5 in _arg_2) {
			info(ChannelDebug, _arg_3, ((((("| " + _local_4) + " : ") + _local_5) + ": ") + _arg_2[_local_5]));
			debugDataRecursive((_arg_1 + 1), _arg_2[_local_5], _arg_3);
		}

	}

	public static function dumpData(_arg_1:Object, _arg_2:Object):void {
		var _local_3:int;
		var _local_4:* = "";
		_local_4 = dumpDataRecursive(_local_4, _arg_2, false);
		info(ChannelDebug, _arg_1, _local_4);
	}

	private static function dumpDataRecursive(_arg_1:String, _arg_2:Object, _arg_3:Boolean):String {
		var _local_5:*;
		var _local_6:*;
		if (_arg_2 == null) {
			return (_arg_1 + "null");
		}

		if (_arg_3) {
			_arg_1 = (_arg_1 + "[");
		} else {
			_arg_1 = (_arg_1 + "{");
		}

		var _local_4:Boolean = true;
		for (_local_5 in _arg_2) {
			if (!_local_4) {
				_arg_1 = (_arg_1 + ",");
			}

			_local_6 = _arg_2[_local_5];
			if (!_arg_3) {
				_arg_1 = (_arg_1 + (('"' + _local_5) + '":'));
			}

			if (_local_6 == null) {
				_arg_1 = (_arg_1 + "null");
			} else {
				if (((_local_6 is Number) || (_local_6 is Boolean))) {
					_arg_1 = (_arg_1 + _local_6);
				} else {
					if ((_local_6 is String)) {
						_arg_1 = (_arg_1 + (('"' + _local_6) + '"'));
					} else {
						if ((_local_6 is Array)) {
							_arg_1 = dumpDataRecursive(_arg_1, _local_6, true);
						} else {
							if ((_local_6 is Object)) {
								_arg_1 = dumpDataRecursive(_arg_1, _local_6, false);
							} else {
								_arg_1 = (_arg_1 + (('"' + _local_6) + '"'));
							}

						}

					}

				}

			}

			_local_4 = false;
		}

		if (_arg_3) {
			_arg_1 = (_arg_1 + "]");
		} else {
			_arg_1 = (_arg_1 + "}");
		}

		return (_arg_1);
	}

	private static function logMessage(_arg_1:String, _arg_2:String, _arg_3:Object, _arg_4:String):void {
		if (!ControlsMain.isLogChannelEnabled(_arg_2)) {
			return;
		}

		if (_arg_3) {
			trace(((((((((_arg_1 + " | ") + _arg_2) + " | ") + getQualifiedClassName(_arg_3)) + "(") + _arg_3.name) + "): ") + _arg_4));
		} else {
			trace(((((_arg_1 + " | ") + _arg_2) + ": ") + _arg_4));
		}

	}


}
}//package common

