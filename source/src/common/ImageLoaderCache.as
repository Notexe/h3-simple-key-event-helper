// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.ImageLoaderCache

package common {
public class ImageLoaderCache {

	private static var s_instance:ImageLoaderCache;

	private var m_imageRegister:Object = {};


	public static function getGlobalInstance():ImageLoaderCache {
		if (s_instance == null) {
			s_instance = new (ImageLoaderCache)();
		}

		return (s_instance);
	}


	public function registerLoadImage(_arg_1:String, _arg_2:Function = null, _arg_3:Function = null):void {
		var _local_4:ImageLoader_internal = (this.m_imageRegister[_arg_1] as ImageLoader_internal);
		if (_local_4 == null) {
			_local_4 = new ImageLoader_internal();
			_local_4.loadImage(_arg_1);
			this.m_imageRegister[_arg_1] = _local_4;
		}

		_local_4.m_referenceCount++;
		if (_local_4.isLoading()) {
			if (_arg_2 != null) {
				_local_4.m_successCallbacks.push(_arg_2);
			}

			if (_arg_3 != null) {
				_local_4.m_failedCallbacks.push(_arg_3);
			}

		} else {
			if (_local_4.m_failed) {
				if (_arg_3 != null) {
					(_arg_3());
				}

			} else {
				if (_arg_2 != null) {
					(_arg_2(_local_4.m_bitmapData));
				}

			}

		}

	}

	public function unregisterLoadImage(_arg_1:String, _arg_2:Function = null, _arg_3:Function = null):void {
		var _local_5:int;
		var _local_6:int;
		var _local_4:ImageLoader_internal = (this.m_imageRegister[_arg_1] as ImageLoader_internal);
		_local_4.m_referenceCount--;
		if (_local_4.m_referenceCount <= 0) {
			_local_4.cancelAndClearImage();
			this.m_imageRegister[_arg_1] = null;
			return;
		}

		if (_local_4.isLoading()) {
			if (_arg_2 != null) {
				_local_5 = _local_4.m_successCallbacks.indexOf(_arg_2);
				_local_4.m_successCallbacks.splice(_local_5, 1);
			}

			if (_arg_3 != null) {
				_local_6 = _local_4.m_failedCallbacks.indexOf(_arg_3);
				_local_4.m_failedCallbacks.splice(_local_6, 1);
			}

		}

	}


}
}//package common

import flash.display.Loader;


import flash.display.BitmapData;
import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.IOErrorEvent;


class ImageLoader_internal extends Loader {

	public var m_referenceCount:int = 0;
	public var m_successCallbacks:Vector.<Function> = new Vector.<Function>();
	public var m_failedCallbacks:Vector.<Function> = new Vector.<Function>();
	/*private*/
	internal var m_isLoading:Boolean = false;
	public var m_failed:Boolean = false;
	public var m_bitmapData:BitmapData = null;
	/*private*/
	internal var m_rid:String;
	/*private*/
	internal var m_toLoadUrl:String = null;


	public function isLoading():Boolean {
		return (this.m_isLoading);
	}

	public function loadImage(_arg_1:String):void {
		if (this.m_isLoading) {
			this.cancel();
		}

		this.ClearImage();
		this.m_failed = false;
		this.m_isLoading = true;
		this.triggerRequestAsyncLoad(_arg_1);
	}

	/*private*/
	internal function callCallbacks():void {
		var _local_1:Function;
		for each (_local_1 in this.m_successCallbacks) {
			(_local_1(this.m_bitmapData));
		}

		this.m_successCallbacks.length = 0;
		this.m_failedCallbacks.length = 0;
	}

	/*private*/
	internal function callFailedCallbacks():void {
		var _local_1:Function;
		for each (_local_1 in this.m_failedCallbacks) {
			(_local_1());
		}

		this.m_successCallbacks.length = 0;
		this.m_failedCallbacks.length = 0;
	}

	/*private*/
	internal function triggerRequestAsyncLoad(_arg_1:String):void {
		this.m_toLoadUrl = ("img://" + _arg_1);
		ExternalInterface.call("RequestAsyncLoad", this.m_toLoadUrl, this);
	}

	public function cancel():void {
		if (this.m_isLoading) {
			this.close();
			this.ClearImage();
			this.closeRequest();
			this.callFailedCallbacks();
		}

	}

	public function cancelAndClearImage():void {
		if (this.m_isLoading) {
			this.cancel();
		} else {
			this.ClearImage();
		}

	}

	public function onResourceReady(_arg_1:String):void {
		if (this.m_toLoadUrl != _arg_1) {
			return;
		}

		this.RegisterLoaderListeners();
		var _local_2:URLRequest = new URLRequest(_arg_1);
		this.load(_local_2);
	}

	public function onResourceFailed(_arg_1:String):void {
		if (this.m_toLoadUrl != _arg_1) {
			return;
		}

		this.m_failed = true;
		this.closeRequest();
		this.callFailedCallbacks();
	}

	/*private*/
	internal function onLoadingComplete(_arg_1:Event):void {
		var _local_3:Bitmap;
		this.closeRequest();
		var _local_2:DisplayObject = content;
		if ((_local_2 is Bitmap)) {
			_local_3 = (_local_2 as Bitmap);
			this.m_bitmapData = _local_3.bitmapData;
		}

		this.callCallbacks();
	}

	/*private*/
	internal function onLoadFailed(_arg_1:IOErrorEvent):void {
		this.m_failed = true;
		this.closeRequest();
		this.callFailedCallbacks();
	}

	/*private*/
	internal function closeRequest():void {
		this.m_rid = null;
		this.m_toLoadUrl = null;
		this.m_isLoading = false;
		this.m_bitmapData = null;
		ExternalInterface.call("CloseAsyncRequest", this);
		this.UnregisterLoaderListeners();
	}

	/*private*/
	internal function RegisterLoaderListeners():void {
		this.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadingComplete);
		this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
	}

	/*private*/
	internal function UnregisterLoaderListeners():void {
		this.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadingComplete);
		this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
	}

	/*private*/
	internal function ClearImage():void {
		this.m_bitmapData = null;
		this.unload();
	}


}


