// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.Localization

package common {
import flash.external.ExternalInterface;

public class Localization {


	public static function get(_arg_1:String):String {
		if (_arg_1 == null) {
			Log.xerror(Log.ChannelCommon, "Localization.get Error: key = null");
			return ("");
		}

		return (ExternalInterface.call("LocalizationGet", _arg_1));
	}


}
}//package common

