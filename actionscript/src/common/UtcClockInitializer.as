// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.UtcClockInitializer

package common {
import menu3.MenuElementBase;

import flash.external.ExternalInterface;

public dynamic class UtcClockInitializer extends MenuElementBase {

	public function UtcClockInitializer(_arg_1:Object) {
		super(_arg_1);
	}

	override public function onSetData(_arg_1:Object):void {
		var _local_2:String = ExternalInterface.call("CommonUtilsGetServerTimeAsAs3Date");
		Log.xinfo(Log.ChannelCommon, ((("server utctimestamp " + _local_2) + " - parsed: ") + DateTimeUtils.parseUTCTimeStamp(_local_2)));
		DateTimeUtils.initializeUtcClock(DateTimeUtils.parseUTCTimeStamp(_local_2));
	}


}
}//package common

