// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.DebugDraw

package common {
import flash.utils.getQualifiedClassName;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.utils.getQualifiedSuperclassName;
import flash.utils.getDefinitionByName;
import flash.display.DisplayObjectContainer;

public class DebugDraw {

	private static const DEBUG_NODE_NAME:String = "debugDrawSprite";
	private static const DEBUG_NODE_MARK:String = "debugDrawMark";
	private static var ms_colorTable:Array = null;
	private static var ms_colorTableIndex:int = 0;
	public static var DIALOG_CLASS_NAMES:Array = ["View", "Modal", "TextField", "MenuImageLoader", "DlcMissingInfo"];


	public static function treeByClassNames(root:DisplayObject, typeNames:Array, continousUpdate:Boolean = false):void {
		if (root == null) {
			Log.xerror(Log.ChannelDebug, "DebugDraw.treeByClassNames: root is null");
			return;
		}

		generateColorTable();
		var frameCounter:OnFrameCountAction = new OnFrameCountAction(root, 100, continousUpdate, function ():void {
			treeBy(root, function (_arg_1:DisplayObject):void {
				var _local_2:* = getQualifiedClassName(_arg_1);
				var _local_3:* = 0;
				while (_local_3 < typeNames.length) {
					if (_local_2.search(typeNames[_local_3]) != -1) {
						Log.xinfo(Log.ChannelDebug, ("DebugDraw.treeByClassNames: adding node with typeName " + _local_2));
						displayObject(_arg_1);
						return;
					}

					_local_3++;
				}

			});
		});
	}

	public static function treeByMarkedNodes(root:DisplayObject, continousUpdate:Boolean = false):void {
		if (root == null) {
			Log.xerror(Log.ChannelDebug, "DebugDraw.treeByMarkedNodes: root is null");
			return;
		}

		generateColorTable();
		var frameCounter:OnFrameCountAction = new OnFrameCountAction(root, 100, continousUpdate, function ():void {
			treeBy(root, function (_arg_1:DisplayObject):void {
				if (_arg_1.hasOwnProperty(DEBUG_NODE_MARK)) {
					displayObject(_arg_1);
				}

			});
		});
	}

	public static function treeAllSprites(root:DisplayObject, continousUpdate:Boolean = false):void {
		if (root == null) {
			Log.xerror(Log.ChannelDebug, "DebugDraw.treeAllSprites: root is null");
			return;
		}

		generateColorTable();
		var frameCounter:OnFrameCountAction = new OnFrameCountAction(root, 100, continousUpdate, function ():void {
			treeBy(root, function (_arg_1:DisplayObject):void {
				if ((_arg_1 is Sprite)) {
					displayObject(_arg_1);
				}

			});
		});
	}

	public static function treeByCustomView(root:DisplayObject, viewName:String = "View", continousUpdate:Boolean = false):void {
		if (root == null) {
			Log.xerror(Log.ChannelDebug, "DebugDraw.treeByCustomView: root is null");
			return;
		}

		generateColorTable();
		var frameCounter:OnFrameCountAction = new OnFrameCountAction(root, 100, continousUpdate, function ():void {
			treeBy(root, function (_arg_1:DisplayObject):void {
				var _local_5:*;
				var _local_2:* = getQualifiedClassName(_arg_1);
				if (_local_2.search(viewName) != -1) {
					Log.xinfo(Log.ChannelDebug, ("DebugDraw.treeByCustomView: class name matched for drawing " + _local_2));
					displayObject(_arg_1);
					return;
				}

				var _local_3:* = _arg_1;
				var _local_4:* = "";
				_local_4 = getQualifiedSuperclassName(_arg_1);
				while (_local_4 != "Object") {
					if (_local_4.search(viewName) != -1) {
						Log.xinfo(Log.ChannelDebug, ("DebugDraw.treeByCustomView: superclass name matched for drawing " + _local_4));
						displayObject(_arg_1);
						return;
					}

					_local_5 = (getDefinitionByName(_local_4) as Class);
					if (_local_5.prototype == null) break;
					_local_4 = getQualifiedSuperclassName(_local_5.prototype);
					if (_local_4 == null) break;
				}

			});
		});
	}

	private static function treeBy(rootNode:DisplayObject, nodeAction:Function):void {
		ms_colorTableIndex = 0;
		if (rootNode.parent != null) {
			walkTreeActionDF(rootNode.parent, function (_arg_1:DisplayObject):void {
				if (((_arg_1.name == DEBUG_NODE_NAME) && (!(_arg_1.parent == null)))) {
					Log.xinfo(Log.ChannelDebug, ((("DebugDraw.treeBy: cleanup - removing debug node (" + getQualifiedClassName(_arg_1)) + ") from parent ") + _arg_1.parent));
					_arg_1.parent.removeChild(_arg_1);
				}

			});
		}

		walkTreeActionDF(rootNode, nodeAction);
	}

	public static function displayObject(_arg_1:DisplayObject, _arg_2:uint = 0):void {
		if (_arg_2 == 0) {
			_arg_2 = ms_colorTable[ms_colorTableIndex];
			updateColorTableIndex();
		}

		var _local_3:Sprite = new Sprite();
		_local_3.name = DEBUG_NODE_NAME;
		_local_3.graphics.beginFill(_arg_2, 0.2);
		_local_3.graphics.lineStyle(1, 0xFFFFFF, 1);
		_local_3.graphics.drawRect(0, 0, _arg_1.width, _arg_1.height);
		_local_3.graphics.endFill();
		_local_3.x = _arg_1.x;
		_local_3.y = _arg_1.y;
		_arg_1.parent.addChild(_local_3);
	}

	private static function walkTreeActionDF(_arg_1:DisplayObject, _arg_2:Function):void {
		var _local_5:DisplayObject;
		var _local_6:DisplayObjectContainer;
		var _local_7:int;
		var _local_3:Array = [];
		_local_3.push(_arg_1);
		var _local_4:Array = [];
		while (_local_3.length > 0) {
			_local_5 = _local_3.shift();
			_local_4.push(_local_5);
			_local_6 = (_local_5 as DisplayObjectContainer);
			if (_local_6 != null) {
				_local_7 = 0;
				while (_local_7 < _local_6.numChildren) {
					_local_3.push(_local_6.getChildAt(_local_7));
					_local_7++;
				}

			}

		}

		while (_local_4.length > 0) {
			_local_5 = _local_4.pop();
			(_arg_2(_local_5));
		}

	}

	private static function generateColorTable():void {
		var _local_2:int;
		var _local_3:int;
		var _local_4:int;
		var _local_5:int;
		var _local_6:int;
		if (ms_colorTable != null) {
			return;
		}

		ms_colorTable = [];
		var _local_1:int = 32;
		while (_local_1 <= 0xFF) {
			_local_2 = 0;
			while (_local_2 < 7) {
				_local_3 = (_local_1 & ((_local_2 >= 3) ? 0xFF : 0));
				_local_4 = (_local_1 & ((((_local_2 + 1) % 4) >= 2) ? 0xFF : 0));
				_local_5 = (_local_1 & (((_local_2 % 2) == 0) ? 0xFF : 0));
				_local_6 = (((_local_3 << 16) | (_local_4 << 8)) | _local_5);
				ms_colorTable.push(_local_6);
				_local_2++;
			}

			if (((_local_1 < 0xFF) && ((_local_1 * 2) > 0xFF))) {
				_local_1 = 0xFF;
			} else {
				_local_1 = (_local_1 * 2);
			}

		}

		ms_colorTable.reverse();
	}

	private static function updateColorTableIndex():void {
		ms_colorTableIndex++;
		if (ms_colorTableIndex >= ms_colorTable.length) {
			ms_colorTableIndex = 0;
		}

	}


}
}//package common

import flash.events.Event;

import common.Log;

import flash.display.DisplayObject;

class OnFrameCountAction {

	/*private*/
	internal var m_func:Function;
	/*private*/
	internal var m_onNthFrame:int;
	/*private*/
	internal var m_currentFrameCount:int = 0;
	/*private*/
	internal var m_removed:Boolean = false;

	public function OnFrameCountAction(_arg_1:DisplayObject, _arg_2:int, _arg_3:Boolean, _arg_4:Function):void {
		this.m_func = _arg_4;
		this.m_onNthFrame = _arg_2;
		this.m_currentFrameCount = _arg_2;
		if (_arg_3) {
			_arg_1.addEventListener(Event.ENTER_FRAME, this.onFrameUpdate);
			_arg_1.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			Log.xinfo(Log.ChannelDebug, "OnFrameCountAction added to stage");
		} else {
			Log.xinfo(Log.ChannelDebug, "OnFrameCountAction one shot");
			this.m_func();
		}

	}

	/*private*/
	internal function onFrameUpdate(_arg_1:Event):void {
		if (this.m_removed) {
			return;
		}

		this.m_currentFrameCount++;
		if (this.m_currentFrameCount >= this.m_onNthFrame) {
			this.m_currentFrameCount = 0;
			Log.xinfo(Log.ChannelDebug, "OnFrameCountAction calling update");
			this.m_func();
		}

	}

	/*private*/
	internal function onRemovedFromStage(_arg_1:Event):void {
		var _local_2:DisplayObject = (_arg_1.currentTarget as DisplayObject);
		_local_2.removeEventListener(Event.ENTER_FRAME, this.onRemovedFromStage);
		_local_2.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		Log.xinfo(Log.ChannelDebug, "OnFrameCountAction removed from stage");
		this.m_removed = true;
	}


}


