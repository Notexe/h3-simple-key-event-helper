// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.CommonUtils

package common {
import flash.external.ExternalInterface;
import flash.display.FrameLabel;
import flash.display.MovieClip;
import flash.text.TextFormat;
import flash.text.TextField;

public class CommonUtils {

	public static const PLATFORM_PC:String = "pc";
	public static const PLATFORM_ORBIS:String = "orbis";
	public static const PLATFORM_PS5:String = "ps5";
	public static const PLATFORM_DURANGO:String = "durango";
	public static const PLATFORM_SCARLETT:String = "scarlett";
	public static const PLATFORM_STADIA:String = "stadia";
	public static const PLATFORM_IZUMO:String = "izumo";
	public static const CONTROLLER_TYPE_PS4:String = "ps4";
	public static const CONTROLLER_TYPE_PS5:String = "ps5";
	public static const CONTROLLER_TYPE_XBOXONE:String = "xboxone";
	public static const CONTROLLER_TYPE_XBOXSERIESX:String = "xboxseriesx";
	public static const CONTROLLER_TYPE_STADIA:String = "stadia";
	public static const CONTROLLER_TYPE_SWITCHPRO:String = "nspro";
	public static const CONTROLLER_TYPE_SWITCHJOYCON:String = "nsjc";
	public static const CONTROLLER_TYPE_PC:String = "pc";
	public static const CONTROLLER_TYPE_KEY:String = "key";
	public static const CONTROLLER_TYPE_OCULUSVR:String = "oculusvr";
	public static const CONTROLLER_TYPE_OPENVR:String = "openvr";
	public static const MENU_ACCEPTFACEDOWN_CANCELFACERIGHT:int = 0;
	public static const MENU_ACCEPTFACERIGHT_CANCELFACEDOWN:int = 1;
	private static var platformType:String = null;


	public static function isWindowsXBox360ControllerUsed():Boolean {
		return (ExternalInterface.call("CommonUtilsIsWindowsXBox360ControllerUsed"));
	}

	public static function isDualShock4TrackpadAlternativeButtonNeeded():Boolean {
		return (ExternalInterface.call("CommonUtilsIsDualShock4TrackpadAlternativeButtonNeeded"));
	}

	public static function isPCVRControllerUsed(_arg_1:String = null):Boolean {
		if (_arg_1 == null) {
			_arg_1 = ControlsMain.getControllerType();
		}

		return ((_arg_1 == CONTROLLER_TYPE_OCULUSVR) || (_arg_1 == CONTROLLER_TYPE_OPENVR));
	}

	public static function getPlatformString():String {
		if (platformType == null) {
			platformType = ExternalInterface.call("CommonUtilsGetPlatformString");
		}

		return (platformType);
	}

	public static function hasFrameLabel(_arg_1:MovieClip, _arg_2:String):Boolean {
		var _local_5:FrameLabel;
		var _local_3:Boolean = ExternalInterface.call("CommonUtilsGetEnableCommonUtilsDebug");
		if (!_local_3) {
			return (true);
		}

		var _local_4:int;
		while (_local_4 < _arg_1.currentLabels.length) {
			_local_5 = _arg_1.currentLabels[_local_4];
			if (_local_5.name == _arg_2) {
				return (true);
			}

			_local_4++;
		}

		return (false);
	}

	public static function changeFontToGlobalFont(_arg_1:TextField):void {
		var _local_2:TextFormat = _arg_1.defaultTextFormat;
		_arg_1.setTextFormat(new TextFormat("$global", _local_2.size, _local_2.color, _local_2.bold, _local_2.italic, _local_2.underline, _local_2.url, _local_2.target, _local_2.align, _local_2.leftMargin, _local_2.rightMargin, _local_2.indent, _local_2.leading));
	}

	public static function changeFontToGlobalIfNeeded(_arg_1:TextField):Boolean {
		var _local_2:TextFormat;
		if (ExternalInterface.call("GlobalFontNeededToDisplayString", _arg_1.text, _arg_1.defaultTextFormat.font)) {
			_local_2 = _arg_1.defaultTextFormat;
			_arg_1.setTextFormat(new TextFormat("$global", _local_2.size, _local_2.color, _local_2.bold, _local_2.italic, _local_2.underline, _local_2.url, _local_2.target, _local_2.align, _local_2.leftMargin, _local_2.rightMargin, _local_2.indent, _local_2.leading));
			return (true);
		}

		return (false);
	}

	public static function gotoFrameLabelAndStop(_arg_1:MovieClip, _arg_2:String):void {
		if (hasFrameLabel(_arg_1, _arg_2)) {
			_arg_1.gotoAndStop(_arg_2);
		} else {
			trace((((((("Movie clip " + _arg_1.name) + " has no frame label '") + _arg_2) + "'. Staying at frame ") + _arg_1.currentLabel) + "."));
		}

	}

	public static function gotoFrameLabelAndPlay(_arg_1:MovieClip, _arg_2:String):void {
		if (hasFrameLabel(_arg_1, _arg_2)) {
			_arg_1.gotoAndPlay(_arg_2);
		} else {
			trace((((((("Movie clip " + _arg_1.name) + " has no frame label '") + _arg_2) + "'. Staying at frame ") + _arg_1.currentLabel) + "."));
		}

	}

	public static function getActiveTextLocaleIndex():int {
		return (ExternalInterface.call("CommonUtilsGetActiveTextLocaleIndex"));
	}

	public static function getUIOptionValue(_arg_1:String):Boolean {
		return (ExternalInterface.call("CommonUtilsGetUIOptionValue", _arg_1));
	}

	public static function getUIOptionValueNumber(_arg_1:String):Number {
		return (ExternalInterface.call("CommonUtilsGetUIOptionValue", _arg_1));
	}

	public static function getSubtitleSize():Number {
		return (ExternalInterface.call("CommonUtilsGetSubtitleSize"));
	}

	public static function getSubtitleBGAlpha():Number {
		return (ExternalInterface.call("CommonUtilsGetSubtitleBGAlpha"));
	}


}
}//package common

