// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.ObjectUtils

package common {
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class ObjectUtils {


	public static function cloneObject(_arg_1:Object):Object {
		var _local_2:String = JSON.stringify(_arg_1);
		return (JSON.parse(_local_2));
	}

	public static function cloneDeep(_arg_1:Object):* {
		var _local_2:ByteArray = new ByteArray();
		_local_2.writeObject(_arg_1);
		_local_2.position = 0;
		return (_local_2.readObject());
	}

	public static function cloneDictionary(_arg_1:Dictionary):Dictionary {
		var _local_3:Object;
		var _local_2:Dictionary = new Dictionary();
		for (_local_3 in _arg_1) {
			_local_2[_local_3] = _arg_1[_local_3];
		}

		return (_local_2);
	}

	public static function compare(obj1:Object, obj2:Object):Boolean {
		var value1:String;
		var value2:String;
		try {
			value1 = JSON.stringify(obj1);
			value2 = JSON.stringify(obj2);
		} catch (e:Error) {
			trace(("[ERROR] ObjectUtil.compare() - " + e.message));
			return (false);
		}

		return (value1 === value2);
	}


}
}//package common

