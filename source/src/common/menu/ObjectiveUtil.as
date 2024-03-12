// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.menu.ObjectiveUtil

package common.menu {
import common.Localization;
import common.CommonUtils;

public class ObjectiveUtil {

	private static const ICON_WEAPON:String = "difficulty";
	private static const ICON_DISGUISE:String = "disguise";


	public static function setupConditionIndicator(_arg_1:Object, _arg_2:Object, _arg_3:Array, _arg_4:String = "#FFFFFF"):void {
		var _local_5:String = (((!(_arg_2.type == "kill")) || (_arg_2.hardcondition)) ? _arg_2.header : ((Localization.get("UI_DIALOG_OPTIONAL") + " ") + _arg_2.header));
		MenuUtils.setupText(_arg_1.header, _local_5, 18, MenuConstants.FONT_TYPE_NORMAL, MenuConstants.FontColorWhite);
		MenuUtils.truncateTextfield(_arg_1.header, 1, MenuConstants.FontColorWhite);
		var _local_6:Array = splitTitle(_arg_2.title);
		MenuUtils.setupText(_arg_1.title, _local_6[0], 24, MenuConstants.FONT_TYPE_MEDIUM, _arg_4);
		var _local_7:String = _arg_1.title.htmlText;
		MenuUtils.truncateTextfield(_arg_1.title, 1, _arg_4);
		if (((!(_arg_1.method == undefined)) && (!(_arg_1.method == null)))) {
			MenuUtils.setupText(_arg_1.method, _local_6[1], 18, MenuConstants.FONT_TYPE_MEDIUM, _arg_4);
			MenuUtils.truncateTextfield(_arg_1.method, 1, _arg_4);
		}

		var _local_8:textTicker = new textTicker();
		_arg_3.unshift({
			"indicatortextfield": _arg_1.title,
			"title": _local_7,
			"textticker": _local_8
		});
		_local_8.startTextTickerHtml(_arg_1.title, _local_7, CommonUtils.changeFontToGlobalIfNeeded);
	}

	private static function splitTitle(_arg_1:String):Array {
		var _local_4:String;
		var _local_5:int;
		var _local_6:String;
		var _local_2:RegExp = /^\s+|\s+$/g;
		var _local_3:int = _arg_1.indexOf(":");
		if (_local_3 >= 0) {
			_local_4 = _arg_1.substr(0, _local_3);
			_local_5 = (_local_3 + 1);
			_local_6 = _arg_1.substr(_local_5, (_arg_1.length - _local_5));
			_local_4 = _local_4.replace(_local_2, "");
			_local_2.lastIndex = 0;
			_local_6 = _local_6.replace(_local_2, "");
			return ([_local_6, _local_4]);
		}

		_arg_1 = _arg_1.replace(_local_2, "");
		return ([_arg_1]);
	}

	private static function createCondition(_arg_1:String):Object {
		if (((!(_arg_1 == ICON_DISGUISE)) && (!(_arg_1 == ICON_WEAPON)))) {
			return (null);
		}

		var _local_2:Object = {};
		if (_arg_1 == ICON_DISGUISE) {
			_local_2["header"] = Localization.get("UI_BRIEFING_CONDITION_DISGUISE");
			_local_2["title"] = Localization.get("UI_BRIEFING_CONDITION_ANY_DISGUISE");
			_local_2["icon"] = ICON_DISGUISE;
		} else {
			_local_2["header"] = Localization.get("UI_BRIEFING_CONDITION_ELIMINATE_WITH");
			_local_2["title"] = Localization.get("UI_BRIEFING_CONDITION_ANY_METHOD");
			_local_2["icon"] = ICON_WEAPON;
		}

		_local_2["type"] = "defaultkill";
		_local_2["hardcondition"] = true;
		return (_local_2);
	}

	public static function prepareConditions(_arg_1:Array, _arg_2:Boolean = true, _arg_3:Boolean = true, _arg_4:Boolean = true):Array {
		var _local_5:Object;
		if (((_arg_1.length == 0) && (_arg_2))) {
			_arg_1.unshift(createCondition(ICON_DISGUISE));
			_arg_1.unshift(createCondition(ICON_WEAPON));
		} else {
			if (((_arg_1.length == 1) && (_arg_1[0].type == "kill"))) {
				if (((_arg_1[0].icon == ICON_WEAPON) && (_arg_4))) {
					_arg_1.unshift(createCondition(ICON_DISGUISE));
				} else {
					if (((_arg_1[0].icon == ICON_DISGUISE) && (_arg_3))) {
						_arg_1.push(createCondition(ICON_WEAPON));
					}

				}

			}

		}

		if (((_arg_1.length == 2) && (_arg_1[0].icon == ICON_DISGUISE))) {
			_local_5 = _arg_1[0];
			_arg_1[0] = _arg_1[1];
			_arg_1[1] = _local_5;
		}

		return (_arg_1);
	}


}
}//package common.menu

