// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.DateTimeUtils

package common {
import flash.utils.getTimer;
import flash.external.ExternalInterface;

public class DateTimeUtils {

	private static const DEFAULT_MONTH_ABBREVIATIONS:Array = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
	private static const DEFAULT_DATE_ABBREVIATION_FORMAT:String = "{MONTH} {DAY}, {YEAR}";
	private static var m_isInitialized:Boolean = false;
	private static var m_serverUTCTimeAtStartup:Date;
	private static var m_localUTCTimeAtStartup:Number;
	private static var s_currentLocale:String;
	private static var s_monthAbbreviationArray:Array;
	private static var s_dateAbbreviationFormat:String;


	public static function initializeUtcClock(_arg_1:Date):void {
		m_serverUTCTimeAtStartup = _arg_1;
		m_localUTCTimeAtStartup = getTimer();
		m_isInitialized = true;
	}

	public static function getUTCClockNow():Date {
		var _local_3:String;
		var _local_1:Number = getTimer();
		if (!m_isInitialized) {
			_local_3 = ExternalInterface.call("CommonUtilsGetServerTimeAsAs3Date");
			DateTimeUtils.initializeUtcClock(DateTimeUtils.parseUTCTimeStamp(_local_3));
		}

		var _local_2:Date = new Date();
		_local_2.setTime((m_serverUTCTimeAtStartup.getTime() + (_local_1 - m_localUTCTimeAtStartup)));
		return (_local_2);
	}

	public static function parseUTCTimeStamp(_arg_1:String):Date {
		var _local_2:Array = _arg_1.split(",");
		var _local_3:Date = new Date(0);
		if (_local_2.length == 6) {
			_local_3.setUTCFullYear(_local_2[0], _local_2[1], _local_2[2]);
			_local_3.setUTCHours(_local_2[3], _local_2[4], _local_2[5]);
		} else {
			trace(((("DateTimeUtils: Warning, parseUTCTimeStamp() failed, invalid date string " + _arg_1) + " ") + _local_2));
		}

		return (_local_3);
	}

	public static function parseSqlUTCTimeStamp(_arg_1:String):Date {
		var _local_2:Array = _arg_1.split("T");
		if (_local_2.length != 2) {
			trace(("DateTimeUtils: Warning, parseSqlUTCTimeStamp() failed, invalid date string: " + _arg_1));
		}

		var _local_3:Array = _local_2[0].split("-");
		if (_local_3.length != 3) {
			trace(("DateTimeUtils: Warning, parseSqlUTCTimeStamp() failed, invalid ymd string: " + _local_2[0]));
		}

		var _local_4:Array = _local_2[1].split(":");
		if (_local_4.length != 3) {
			trace(("DateTimeUtils: Warning, parseSqlUTCTimeStamp() failed, invalid hms string: " + _local_2[1]));
		}

		var _local_5:Array = _local_4[2].split(".");
		if (_local_5.length != 2) {
			trace(("DateTimeUtils: Warning, parseSqlUTCTimeStamp() failed, invalid hms string: " + _local_5[2]));
		}

		var _local_6:Date = new Date(0);
		var _local_7:int = (_local_3[1] - 1);
		_local_6.setUTCFullYear(_local_3[0], _local_7, _local_3[2]);
		_local_6.setUTCHours(_local_4[0], _local_4[1], _local_5[0]);
		return (_local_6);
	}

	public static function parseLocalTimeStamp(_arg_1:String):Date {
		var _local_2:Array = _arg_1.split(",");
		var _local_3:Date = new Date(0);
		if (_local_2.length == 6) {
			_local_3.setFullYear(_local_2[0], _local_2[1], _local_2[2]);
			_local_3.setHours(_local_2[3], _local_2[4], _local_2[5]);
		} else {
			trace("DateTimeUtils: Warning, parseTimeStamp() failed, invalid date string");
		}

		return (_local_3);
	}

	public static function parseUTCMilliseconds(_arg_1:Number):Date {
		var _local_2:Date = new Date();
		_local_2.setTime(_arg_1);
		return (_local_2);
	}

	public static function formatDurationHHMMSS(_arg_1:Number):String {
		var _local_2:Number = Math.floor((_arg_1 / 1000));
		var _local_3:Number = Math.floor((_local_2 / ((60 * 60) * 24)));
		if (_local_3 >= 4) {
			_local_2 = (_local_2 - (_local_3 * ((60 * 60) * 24)));
		}

		var _local_4:Number = Math.floor((_local_2 / (60 * 60)));
		_local_2 = (_local_2 - (_local_4 * (60 * 60)));
		var _local_5:Number = (Math.floor((_local_2 / 60)) % 60);
		_local_2 = (_local_2 - (_local_5 * 60));
		var _local_6:Number = (_local_2 % 60);
		var _local_7:String = ((_local_3 == 0) ? "" : ((_local_3 + " ") + Localization.get("UI_DIALOG_DAYS")));
		var _local_8:String = ((_local_4 == 0) ? "00:" : (padLeft(_local_4.toString(), "0", 2) + ":"));
		var _local_9:String = (((_local_4 == 0) && (_local_5 == 0)) ? "00:" : (padLeft(_local_5.toString(), "0", 2) + ":"));
		var _local_10:String = padLeft(_local_6.toString(), "0", 2);
		return ((_local_3 >= 4) ? _local_7 : ((_local_8 + _local_9) + _local_10));
	}

	public static function formatDateToLocalTimeZone(_arg_1:Date):String {
		updateLocalization();
		var _local_2:Date = getTimezoneCorrectedUTCTime(_arg_1);
		var _local_3:String = padLeft(_local_2.getUTCDate().toString(), "0", 2);
		var _local_4:String = s_monthAbbreviationArray[_local_2.getUTCMonth()];
		var _local_5:String = _local_2.getUTCFullYear().toString();
		var _local_6:String = padLeft(_local_2.getUTCHours().toString(), "0", 2);
		var _local_7:String = padLeft(_local_2.getUTCMinutes().toString(), "0", 2);
		return ((((((_local_3 + _local_4) + _local_5) + " - ") + _local_6) + ":") + _local_7);
	}

	public static function formatDateToLocalTimeZoneLocalized(_arg_1:Date):String {
		updateLocalization();
		var _local_2:Date = getTimezoneCorrectedUTCTime(_arg_1);
		var _local_3:String = padLeft(_local_2.getUTCDate().toString(), "0", 2);
		var _local_4:String = s_monthAbbreviationArray[_local_2.getUTCMonth()];
		var _local_5:String = _local_2.getUTCFullYear().toString();
		return (formatLocalizedAbbeviateDate(_local_3, _local_4, _local_5));
	}

	public static function formatDateToLocalTimeZoneHM(_arg_1:Date):String {
		var _local_2:Date = getTimezoneCorrectedUTCTime(_arg_1);
		var _local_3:String = padLeft(_local_2.getUTCHours().toString(), "0", 2);
		var _local_4:String = padLeft(_local_2.getUTCMinutes().toString(), "0", 2);
		return ((_local_3 + ":") + _local_4);
	}

	public static function formatLocalDateLocalized(_arg_1:Date):String {
		updateLocalization();
		var _local_2:String = padLeft(_arg_1.getDate().toString(), "0", 2);
		var _local_3:String = s_monthAbbreviationArray[_arg_1.getMonth()];
		var _local_4:String = _arg_1.getFullYear().toString();
		return (formatLocalizedAbbeviateDate(_local_2, _local_3, _local_4));
	}

	public static function formatLocalDateHM(_arg_1:Date):String {
		var _local_2:String = padLeft(_arg_1.getHours().toString(), "0", 2);
		var _local_3:String = padLeft(_arg_1.getMinutes().toString(), "0", 2);
		return ((_local_2 + ":") + _local_3);
	}

	public static function getNowInLocalTime():Date {
		var _local_1:Date;
		var _local_2:Date;
		var _local_3:Number;
		var _local_4:Number;
		var _local_5:Number;
		var _local_6:Number;
		var _local_7:Date;
		if (CommonUtils.getPlatformString() == CommonUtils.PLATFORM_ORBIS) {
			_local_1 = new Date();
			_local_2 = new Date();
			_local_2.setHours(0, 0, 0, 0);
			_local_3 = (_local_1.timezoneOffset - _local_2.timezoneOffset);
			_local_4 = (_local_1.timezoneOffset - (2 * _local_3));
			_local_5 = (((_local_4 * 2) * 60) * 1000);
			_local_6 = (_local_1.getTime() + _local_5);
			_local_7 = new Date(_local_6);
			return (_local_7);
		}

		return (new Date());
	}

	private static function getTimezoneCorrectedUTCTime(_arg_1:Date):Date {
		var _local_2:Number = _arg_1.getTime();
		if (CommonUtils.getPlatformString() == CommonUtils.PLATFORM_ORBIS) {
			_local_2 = (_local_2 + ((_arg_1.timezoneOffset * 60) * 1000));
		} else {
			_local_2 = (_local_2 - ((_arg_1.timezoneOffset * 60) * 1000));
		}

		return (new Date(_local_2));
	}

	private static function padLeft(_arg_1:String, _arg_2:String, _arg_3:uint):String {
		while (_arg_1.length < _arg_3) {
			_arg_1 = (_arg_2 + _arg_1);
		}

		return (_arg_1);
	}

	private static function formatLocalizedAbbeviateDate(_arg_1:String, _arg_2:String, _arg_3:String):String {
		var _local_4:String = s_dateAbbreviationFormat;
		_local_4 = _local_4.replace("{DAY}", _arg_1);
		_local_4 = _local_4.replace("{MONTH}", _arg_2);
		_local_4 = _local_4.replace("{YEAR}", _arg_3);
		return (_local_4);
	}

	private static function updateLocalization():void {
		var _local_1:String = ControlsMain.getActiveLocale();
		if ((((!(_local_1 == s_currentLocale)) || (s_dateAbbreviationFormat == null)) || (s_monthAbbreviationArray == null))) {
			s_currentLocale = _local_1;
			s_monthAbbreviationArray = Localization.get("UI_MONTH_ABBREVIATIONS").split(",");
			s_dateAbbreviationFormat = Localization.get("UI_DATE_ABBREVIATION_FORMAT");
			if (((s_monthAbbreviationArray == null) || (!(s_monthAbbreviationArray.length == 12)))) {
				s_monthAbbreviationArray = DEFAULT_MONTH_ABBREVIATIONS;
			}

			if (((s_dateAbbreviationFormat == null) || (s_dateAbbreviationFormat.length == 0))) {
				s_dateAbbreviationFormat = DEFAULT_DATE_ABBREVIATION_FORMAT;
			}

		}

	}


}
}//package common

