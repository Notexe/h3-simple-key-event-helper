// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.Animate

package common {
import flash.external.ExternalInterface;
import flash.display.DisplayObject;

public class Animate {

	public static var Linear:int = 0;
	public static var SineIn:int = 1;
	public static var SineOut:int = 2;
	public static var SineInOut:int = 3;
	public static var ExpoIn:int = 4;
	public static var ExpoOut:int = 5;
	public static var ExpoInOut:int = 6;
	public static var BackIn:int = 7;
	public static var BackOut:int = 8;
	public static var BackInOut:int = 9;
	private static var To:int = 1;
	private static var From:int = 2;
	private static var Offset:int = 3;
	private static var FromTo:int = 4;
	private static var AddTo:int = 5;
	private static var AddFrom:int = 6;
	private static var AddOffset:int = 7;
	private static var AddFromTo:int = 8;
	private static var AddFromToExtended:int = 9;
	private static var Kill:int = 10;
	private static var Complete:int = 11;
	private static var Delay:int = 12;


	public static function to(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", To, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _args);
	}

	public static function from(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", From, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _args);
	}

	public static function offset(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", Offset, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _args);
	}

	public static function fromTo(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:Object, _arg_6:int, _arg_7:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", FromTo, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _args);
	}

	public static function addTo(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", AddTo, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _args);
	}

	public static function addFrom(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", AddFrom, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _args);
	}

	public static function addOffset(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", AddOffset, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _args);
	}

	public static function addFromTo(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:Object, _arg_6:int, _arg_7:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", AddFromTo, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _args);
	}

	public static function addFromToExtended(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:Object, _arg_6:int, _arg_7:String, _arg_8:String, _arg_9:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", AddFromToExtended, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _args);
	}

	public static function legacyTo(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Object, _arg_4:int, _arg_5:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", To, _arg_1, _arg_2, 0, _arg_3, _arg_4, _arg_5, _args);
	}

	public static function legacyFrom(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Object, _arg_4:int, _arg_5:Function = null, ..._args):void {
		ExternalInterface.call("AnimateNative", From, _arg_1, _arg_2, 0, _arg_3, _arg_4, _arg_5, _args);
	}

	public static function kill(_arg_1:Object):void {
		ExternalInterface.call("AnimateNative", Kill, _arg_1);
	}

	public static function complete(_arg_1:Object):void {
		ExternalInterface.call("AnimateNative", Complete, _arg_1);
	}

	public static function delay(_arg_1:Object, _arg_2:Number, _arg_3:Function, ..._args):void {
		ExternalInterface.call("AnimateNative", Delay, _arg_1, _arg_2, _arg_3, _args);
	}


}
}//package common

