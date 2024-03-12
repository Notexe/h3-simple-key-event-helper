// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.AnimateLegacy

package common {
import flash.external.ExternalInterface;
import flash.text.TextField;
import flash.display.MovieClip;

public class AnimateLegacy {

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
	private static var PropertiesMap:Object = {
		"x": 1,
		"y": 2,
		"z": 3,
		"alpha": 4,
		"scaleX": 5,
		"scaleY": 6,
		"rotation": 7,
		"rotationX": 8,
		"rotationY": 9,
		"frames": 10,
		"intAnimation": 11
	};


	public static function to(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		kill(_arg_1);
		addTo.apply(Animate, [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6].concat(_args));
	}

	public static function from(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		kill(_arg_1);
		addFrom.apply(Animate, [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6].concat(_args));
	}

	public static function offset(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		kill(_arg_1);
		addOffset.apply(Animate, [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6].concat(_args));
	}

	public static function fromTo(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:Object, _arg_6:int, _arg_7:Function = null, ..._args):void {
		kill(_arg_1);
		addFromTo.apply(Animate, [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7].concat(_args));
	}

	public static function addTo(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		start.apply(Animate, [false, _arg_1, _arg_2, _arg_3, null, _arg_4, _arg_5, null, null, _arg_6].concat(_args));
	}

	public static function addFrom(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		start.apply(Animate, [false, _arg_1, _arg_2, _arg_3, _arg_4, null, _arg_5, null, null, _arg_6].concat(_args));
	}

	public static function addOffset(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:int, _arg_6:Function = null, ..._args):void {
		start.apply(Animate, [true, _arg_1, _arg_2, _arg_3, null, _arg_4, _arg_5, null, null, _arg_6].concat(_args));
	}

	public static function addFromTo(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:Object, _arg_6:int, _arg_7:Function = null, ..._args):void {
		start.apply(Animate, [false, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, null, null, _arg_7].concat(_args));
	}

	public static function addFromToExtended(_arg_1:Object, _arg_2:Number, _arg_3:Number, _arg_4:Object, _arg_5:Object, _arg_6:int, _arg_7:String, _arg_8:String, _arg_9:Function = null, ..._args):void {
		start.apply(Animate, [false, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9].concat(_args));
	}

	public static function legacyTo(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:int, _arg_5:Function = null, ..._args):void {
		kill(_arg_1);
		addTo.apply(Animate, [_arg_1, _arg_2, 0, _arg_3, _arg_4, _arg_5].concat(_args));
	}

	public static function legacyFrom(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:int, _arg_5:Function = null, ..._args):void {
		kill(_arg_1);
		addFrom.apply(Animate, [_arg_1, _arg_2, 0, _arg_3, _arg_4, _arg_5].concat(_args));
	}

	public static function kill(_arg_1:Object):void {
		ExternalInterface.call("StopAllAnimations", _arg_1);
	}

	public static function complete(_arg_1:Object):void {
		ExternalInterface.call("CompleteAllAnimations", _arg_1);
	}

	public static function delay(_arg_1:Object, _arg_2:Number, _arg_3:Function, ..._args):void {
		var _local_5:Function = wrapCallback.apply(Animate, [_arg_3, _arg_1].concat(_args));
		ExternalInterface.call("StartAnimation", _arg_1, _local_5, 0, 0, _arg_2, 0, 0, 0);
	}

	private static function start(offset:Boolean, target:Object, duration:Number, startDelay:Number, varsFrom:Object, varsTo:Object, easing:int, intAniPrefix:String, intAniPostfix:String, callback:Function, ...args):void {
		var key:String;
		var count:Number;
		var i:int;
		var anim:Object;
		var propId:* = undefined;
		var callAnim:Object;
		var finalCallback:Function;
		var propID:int;
		var initValue:Number;
		var targetValue:Number;
		var isIntAnimation:Boolean;
		var wrapped:Function;
		var animationCalls:Array = [];
		var combinedKeys:Object = {};
		collectKeys(varsFrom, combinedKeys);
		collectKeys(varsTo, combinedKeys);
		for (key in combinedKeys) {
			anim = {
				"propID": int,
				"initValue": Number,
				"targetValue": Number
			};
			propId = getPropID(target, key);
			if (propId != null) {
				if (!((key == "intAnimation") && (((varsFrom == null) || (varsTo == null)) || (offset)))) {
					anim.propID = propId;
					anim.initValue = getValueFromVars(target, key, varsFrom);
					anim.targetValue = getValueFromVars(target, key, varsTo);
					if (((((offset) && (varsFrom == null)) && (!(varsTo == null))) && (!(varsTo[key] == null)))) {
						anim.targetValue = (anim.initValue + anim.targetValue);
					}

					animationCalls.push(anim);
				}

			}

		}

		count = animationCalls.length;
		i = 0;
		while (i < animationCalls.length) {
			callAnim = animationCalls[i];
			finalCallback = function ():void {
			};
			count--;
			if (count == 0) {
				wrapped = wrapCallback.apply(Animate, [callback, target].concat(args));
				finalCallback = wrapped;
			}

			propID = (callAnim["propID"] as int);
			initValue = (callAnim["initValue"] as Number);
			targetValue = (callAnim["targetValue"] as Number);
			isIntAnimation = (propID == PropertiesMap["intAnimation"]);
			if (isIntAnimation) {
				ExternalInterface.call("StartAnimation", target, finalCallback, initValue, targetValue, duration, startDelay, propID, easing, intAniPrefix, intAniPostfix);
			} else {
				ExternalInterface.call("StartAnimation", target, finalCallback, initValue, targetValue, duration, startDelay, propID, easing);
			}

			i = (i + 1);
		}

	}

	private static function wrapCallback(callback:Function, thisObject:Object, ...args):Function {
		var wrapped:Function;
		if (callback == null) {
			return (function ():void {
			});
		}

		if (((!(args == null)) && (args.length > 0))) {
			wrapped = function ():void {
				callback.apply(thisObject, args);
			};
		} else {
			wrapped = function ():void {
				callback.apply(thisObject);
			};
		}

		return (wrapped);
	}

	private static function getPropID(_arg_1:Object, _arg_2:String):* {
		if (_arg_2 == "frames") {
			return (PropertiesMap["frames"]);
		}

		if (_arg_2 == "width") {
			return (PropertiesMap["scaleX"]);
		}

		if (_arg_2 == "height") {
			return (PropertiesMap["scaleY"]);
		}

		if (((_arg_2 == "intAnimation") && (_arg_1 is TextField))) {
			return (PropertiesMap["intAnimation"]);
		}

		if (_arg_1[_arg_2] != null) {
			return (PropertiesMap[_arg_2]);
		}

		return (null);
	}

	private static function getInitialValueFromTarget(_arg_1:Object, _arg_2:String):* {
		var _local_3:MovieClip;
		if (_arg_2 == "frames") {
			_local_3 = (_arg_1 as MovieClip);
			return (_local_3.currentFrame);
		}

		if (_arg_2 == "width") {
			return (_arg_1.scaleX);
		}

		if (_arg_2 == "height") {
			return (_arg_1.scaleY);
		}

		if (_arg_1[_arg_2] != null) {
			return (_arg_1[_arg_2] as Number);
		}

		return (null);
	}

	private static function convertArgsToAnimValue(_arg_1:Object, _arg_2:String, _arg_3:Number):Number {
		if (_arg_2 == "width") {
			return (_arg_1.scaleX * (_arg_3 / _arg_1.width));
		}

		if (_arg_2 == "height") {
			return (_arg_1.scaleY * (_arg_3 / _arg_1.height));
		}

		return (_arg_3);
	}

	private static function getValueFromVars(_arg_1:Object, _arg_2:String, _arg_3:Object):Number {
		if (((!(_arg_3 == null)) && (!(_arg_3[_arg_2] == null)))) {
			return (convertArgsToAnimValue(_arg_1, _arg_2, _arg_3[_arg_2]));
		}

		return (getInitialValueFromTarget(_arg_1, _arg_2));
	}

	private static function collectKeys(_arg_1:Object, _arg_2:Object):void {
		var _local_3:String;
		if (((_arg_1 == null) || (_arg_2 == null))) {
			return;
		}

		for (_local_3 in _arg_1) {
			_arg_2[_local_3] = true;
		}

	}


}
}//package common

