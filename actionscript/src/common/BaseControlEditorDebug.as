// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.BaseControlEditorDebug

package common {
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Rectangle;
import flash.geom.Point;
import flash.display.LineScaleMode;
import flash.display.JointStyle;
import flash.display.CapsStyle;
import flash.display.BitmapData;

public class BaseControlEditorDebug {

	private static var s_selectionWidget:Sprite;
	private static var s_selectionWidgetStage:Stage;
	private static var s_selectionArrowWidget:Sprite;
	private static var s_selectionArrowWidgetStage:Stage;
	private static var s_containerWidget:Sprite;
	private static var s_containerWidgetStage:Stage;


	public static function setSelectionWidget(_arg_1:BaseControl, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Sprite {
		if (s_selectionWidget != null) {
			unsetSelectionWidget(s_selectionWidget);
		}

		if (((_arg_1 == null) || (_arg_1.stage == null))) {
			return (null);
		}

		s_selectionWidget = new Sprite();
		s_selectionWidget.name = "EditorSelectionWidgetNode";
		drawSelectionWidget(s_selectionWidget, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
		s_selectionWidgetStage = _arg_1.stage;
		s_selectionWidgetStage.addChild(s_selectionWidget);
		return (s_selectionWidget);
	}

	public static function unsetSelectionWidget(_arg_1:Sprite):void {
		if (((_arg_1 == null) || (!(s_selectionWidget == _arg_1)))) {
			return;
		}

		s_selectionWidgetStage.removeChild(s_selectionWidget);
		s_selectionWidget = null;
		s_selectionWidgetStage = null;
	}

	public static function setSelectionArrowWidget(_arg_1:BaseControl, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Sprite {
		if (s_selectionArrowWidget != null) {
			unsetSelectionArrowWidget(s_selectionArrowWidget);
		}

		if (((_arg_1 == null) || (_arg_1.stage == null))) {
			return (null);
		}

		var _local_8:Number = 0;
		var _local_9:Rectangle = new Rectangle(_local_8, _local_8, (_arg_1.stage.stageWidth - _local_8), (_arg_1.stage.stageHeight - _local_8));
		if (isObjectInBounds(_local_9, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7)) {
			return (null);
		}

		s_selectionArrowWidget = new Sprite();
		s_selectionArrowWidget.name = "EditorSelectionArrowWidgetNode";
		drawSelectionArrowWidget(s_selectionArrowWidget, _local_9, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
		s_selectionArrowWidgetStage = _arg_1.stage;
		s_selectionArrowWidgetStage.addChild(s_selectionArrowWidget);
		return (s_selectionArrowWidget);
	}

	public static function unsetSelectionArrowWidget(_arg_1:Sprite):void {
		if (((_arg_1 == null) || (!(s_selectionArrowWidget == _arg_1)))) {
			return;
		}

		s_selectionArrowWidgetStage.removeChild(s_selectionArrowWidget);
		s_selectionArrowWidget = null;
		s_selectionArrowWidgetStage = null;
	}

	public static function setContainerWidget(_arg_1:BaseControl, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Sprite {
		if (s_containerWidget != null) {
			unsetContainerWidget(s_containerWidget);
		}

		if (((_arg_1 == null) || (_arg_1.stage == null))) {
			return (null);
		}

		s_containerWidget = new Sprite();
		s_containerWidget.name = "EditorContainerWidgetNode";
		drawContainerWidget(s_containerWidget, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
		s_containerWidgetStage = _arg_1.stage;
		s_containerWidgetStage.addChild(s_containerWidget);
		return (s_containerWidget);
	}

	public static function unsetContainerWidget(_arg_1:Sprite):void {
		if (((_arg_1 == null) || (!(s_containerWidget == _arg_1)))) {
			return;
		}

		s_containerWidgetStage.removeChild(s_containerWidget);
		s_containerWidget = null;
		s_containerWidgetStage = null;
	}

	private static function returnARGB(_arg_1:uint, _arg_2:uint):uint {
		var _local_3:uint;
		_local_3 = (_local_3 + (_arg_2 << 24));
		return (_local_3 + _arg_1);
	}

	private static function isObjectInBounds(_arg_1:Rectangle, _arg_2:BaseControl, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):Boolean {
		var _local_9:Point = new Point((_arg_2.x + _arg_7), (_arg_2.y + _arg_8));
		var _local_10:Point = _arg_2.parent.localToGlobal(_local_9);
		var _local_11:Point = _arg_2.parent.globalToLocal(new Point(0, 0));
		var _local_12:Sprite = new Sprite();
		_arg_2.parent.addChild(_local_12);
		_local_12.x = _local_11.x;
		_local_12.y = _local_11.y;
		var _local_13:Point = _local_12.localToGlobal(new Point(_arg_3, _arg_4));
		_arg_2.parent.removeChild(_local_12);
		var _local_14:Rectangle = new Rectangle(_local_10.x, _local_10.y, Math.max(1, Math.abs(_local_13.x)), Math.max(1, Math.abs(_local_13.y)));
		if (_local_13.x < 0) {
			_local_14.x = (_local_14.x - _local_14.width);
		}

		if (_local_13.y < 0) {
			_local_14.y = (_local_14.y - _local_14.height);
		}

		return (_arg_1.intersects(_local_14));
	}

	private static function drawSelectionWidget(_arg_1:Sprite, _arg_2:BaseControl, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):void {
		var _local_9:* = 0xFF00;
		var _local_10:int;
		var _local_11:* = 53247;
		var _local_12:Number = 2;
		var _local_13:Number = 4;
		var _local_14:Number = 30;
		var _local_15:Point = new Point((_arg_2.x + _arg_7), (_arg_2.y + _arg_8));
		var _local_16:Point = _arg_2.parent.localToGlobal(_local_15);
		var _local_17:Point = _arg_2.parent.globalToLocal(new Point(0, 0));
		var _local_18:Sprite = new Sprite();
		_arg_2.parent.addChild(_local_18);
		_local_18.x = _local_17.x;
		_local_18.y = _local_17.y;
		var _local_19:Point = _local_18.localToGlobal(new Point(_arg_3, _arg_4));
		_arg_2.parent.removeChild(_local_18);
		var _local_20:Number = Math.floor((_local_12 / 2));
		_arg_1.graphics.lineStyle(_local_12, _local_10, 1, true, LineScaleMode.NONE, null, JointStyle.MITER);
		_arg_1.graphics.drawRect((_local_20 * 2), (_local_20 * 2), (_local_19.x - (_local_12 * 2)), (_local_19.y - (_local_12 * 2)));
		_arg_1.graphics.lineStyle(_local_12, _local_9, 1, true, LineScaleMode.NONE, null, JointStyle.MITER);
		_arg_1.graphics.drawRect(_local_20, _local_20, (_local_19.x - _local_12), (_local_19.y - _local_12));
		_arg_1.graphics.endFill();
		var _local_21:Point = new Point((_local_19.x * _arg_5), (_local_19.y * _arg_6));
		_arg_1.graphics.lineStyle((_local_13 + 2), _local_10, 0.8, false, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER);
		_arg_1.graphics.moveTo((_local_21.x - _local_14), _local_21.y);
		_arg_1.graphics.lineTo((_local_21.x + _local_14), _local_21.y);
		_arg_1.graphics.moveTo(_local_21.x, (_local_21.y - _local_14));
		_arg_1.graphics.lineTo(_local_21.x, (_local_21.y + _local_14));
		_arg_1.graphics.lineStyle(_local_13, _local_11, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER);
		_arg_1.graphics.moveTo((_local_21.x - _local_14), _local_21.y);
		_arg_1.graphics.lineTo((_local_21.x + _local_14), _local_21.y);
		_arg_1.graphics.moveTo(_local_21.x, (_local_21.y - _local_14));
		_arg_1.graphics.lineTo(_local_21.x, (_local_21.y + _local_14));
		_arg_1.x = _local_16.x;
		_arg_1.y = _local_16.y;
	}

	private static function drawSelectionArrowWidget(_arg_1:Sprite, _arg_2:Rectangle, _arg_3:BaseControl, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number):void {
		var _local_12:Number;
		var _local_10:* = 53247;
		var _local_11:int;
		_local_12 = 4;
		var _local_13:Number = (_local_12 + 2);
		var _local_14:Number = 50;
		var _local_15:Number = 15;
		var _local_16:Number = 20;
		var _local_17:Point = new Point((_arg_3.x + _arg_8), (_arg_3.y + _arg_9));
		var _local_18:Point = _arg_3.parent.localToGlobal(_local_17);
		var _local_19:Point = _arg_3.parent.globalToLocal(new Point(0, 0));
		var _local_20:Sprite = new Sprite();
		_arg_3.parent.addChild(_local_20);
		_local_20.x = _local_19.x;
		_local_20.y = _local_19.y;
		var _local_21:Point = _local_20.localToGlobal(new Point(_arg_4, _arg_5));
		_arg_3.parent.removeChild(_local_20);
		var _local_22:Point = new Point((_local_18.x + (_local_21.x * _arg_6)), (_local_18.y + (_local_21.y * _arg_7)));
		var _local_23:Point = new Point(Math.max((_arg_2.x + _local_16), Math.min(_local_22.x, (_arg_2.width - _local_16))), Math.max((_arg_2.y + _local_16), Math.min(_local_22.y, (_arg_2.height - _local_16))));
		var _local_24:Point = new Point((_local_22.x - _local_23.x), (_local_22.y - _local_23.y));
		_local_24.normalize(1);
		var _local_25:Number = Math.atan2(_local_24.y, _local_24.x);
		_arg_1.graphics.lineStyle(_local_13, _local_11, 0.8, false, LineScaleMode.NONE, null, JointStyle.MITER);
		_arg_1.graphics.moveTo(_local_23.x, _local_23.y);
		_arg_1.graphics.lineTo((_local_23.x + (_local_24.x * -(_local_14))), (_local_23.y + (_local_24.y * -(_local_14))));
		_arg_1.graphics.moveTo(_local_23.x, _local_23.y);
		_arg_1.graphics.lineTo(((_local_23.x - (_local_15 * Math.cos(_local_25))) + (_local_15 * Math.sin(_local_25))), ((_local_23.y - (_local_15 * Math.cos(_local_25))) - (_local_15 * Math.sin(_local_25))));
		_arg_1.graphics.moveTo(_local_23.x, _local_23.y);
		_arg_1.graphics.lineTo(((_local_23.x - (_local_15 * Math.cos(_local_25))) - (_local_15 * Math.sin(_local_25))), ((_local_23.y + (_local_15 * Math.cos(_local_25))) - (_local_15 * Math.sin(_local_25))));
		_arg_1.graphics.lineStyle(_local_12, _local_10, 1, true, LineScaleMode.NONE, null, JointStyle.MITER);
		_arg_1.graphics.moveTo(_local_23.x, _local_23.y);
		_arg_1.graphics.lineTo((_local_23.x + (_local_24.x * -(_local_14))), (_local_23.y + (_local_24.y * -(_local_14))));
		_arg_1.graphics.moveTo(_local_23.x, _local_23.y);
		_arg_1.graphics.lineTo(((_local_23.x - (_local_15 * Math.cos(_local_25))) + (_local_15 * Math.sin(_local_25))), ((_local_23.y - (_local_15 * Math.cos(_local_25))) - (_local_15 * Math.sin(_local_25))));
		_arg_1.graphics.moveTo(_local_23.x, _local_23.y);
		_arg_1.graphics.lineTo(((_local_23.x - (_local_15 * Math.cos(_local_25))) - (_local_15 * Math.sin(_local_25))), ((_local_23.y + (_local_15 * Math.cos(_local_25))) - (_local_15 * Math.sin(_local_25))));
		_arg_1.x = 0;
		_arg_1.y = 0;
	}

	private static function drawContainerWidget(_arg_1:Sprite, _arg_2:BaseControl, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):void {
		var _local_9:* = 0xCCCCCC;
		var _local_10:int;
		var _local_11:* = 0xFFFFFF;
		var _local_12:int = 4;
		var _local_13:int = 4;
		var _local_14:Number = 2;
		var _local_15:Number = 4;
		var _local_16:Number = 30;
		var _local_17:Point = new Point((_arg_2.x + _arg_7), (_arg_2.y + _arg_8));
		var _local_18:Point = _arg_2.parent.localToGlobal(_local_17);
		var _local_19:Point = _arg_2.parent.globalToLocal(new Point(0, 0));
		var _local_20:Sprite = new Sprite();
		_arg_2.parent.addChild(_local_20);
		_local_20.x = _local_19.x;
		_local_20.y = _local_19.y;
		var _local_21:Point = _local_20.localToGlobal(new Point(_arg_3, _arg_4));
		_arg_2.parent.removeChild(_local_20);
		var _local_22:BitmapData = new BitmapData((_local_12 + _local_13), (_local_12 + _local_13));
		var _local_23:Rectangle = new Rectangle(0, 0, _local_12, _local_12);
		var _local_24:Rectangle = new Rectangle(0, 0, (_local_12 + _local_13), (_local_12 + _local_13));
		var _local_25:Rectangle = new Rectangle(_local_13, _local_13, _local_12, _local_12);
		var _local_26:uint = returnARGB(_local_9, 0xFF);
		_local_22.fillRect(_local_24, 0);
		_local_22.fillRect(_local_23, _local_26);
		_local_22.fillRect(_local_25, _local_26);
		_arg_1.graphics.lineStyle(0);
		_arg_1.graphics.beginBitmapFill(_local_22);
		_arg_1.graphics.drawRect(0, 0, _local_21.x, _local_14);
		_arg_1.graphics.drawRect(0, 0, _local_14, _local_21.y);
		_arg_1.graphics.drawRect((_local_21.x - _local_14), 0, _local_14, _local_21.y);
		_arg_1.graphics.drawRect(0, (_local_21.y - _local_14), _local_21.x, _local_14);
		_arg_1.graphics.endFill();
		var _local_27:Point = new Point((_local_21.x * _arg_5), (_local_21.y * _arg_6));
		_arg_1.graphics.lineStyle((_local_15 + 2), _local_10, 0.8, false, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER);
		_arg_1.graphics.moveTo((_local_27.x - _local_16), (_local_27.y - _local_16));
		_arg_1.graphics.lineTo((_local_27.x + _local_16), (_local_27.y + _local_16));
		_arg_1.graphics.moveTo((_local_27.x + _local_16), (_local_27.y - _local_16));
		_arg_1.graphics.lineTo((_local_27.x - _local_16), (_local_27.y + _local_16));
		_arg_1.graphics.moveTo((_local_27.x - _local_16), _local_27.y);
		_arg_1.graphics.lineTo((_local_27.x + _local_16), _local_27.y);
		_arg_1.graphics.moveTo(_local_27.x, (_local_27.y - _local_16));
		_arg_1.graphics.lineTo(_local_27.x, (_local_27.y + _local_16));
		_arg_1.graphics.lineStyle(_local_15, _local_11, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER);
		_arg_1.graphics.moveTo((_local_27.x - _local_16), (_local_27.y - _local_16));
		_arg_1.graphics.lineTo((_local_27.x + _local_16), (_local_27.y + _local_16));
		_arg_1.graphics.moveTo((_local_27.x + _local_16), (_local_27.y - _local_16));
		_arg_1.graphics.lineTo((_local_27.x - _local_16), (_local_27.y + _local_16));
		_arg_1.graphics.moveTo((_local_27.x - _local_16), _local_27.y);
		_arg_1.graphics.lineTo((_local_27.x + _local_16), _local_27.y);
		_arg_1.graphics.moveTo(_local_27.x, (_local_27.y - _local_16));
		_arg_1.graphics.lineTo(_local_27.x, (_local_27.y + _local_16));
		_arg_1.x = _local_18.x;
		_arg_1.y = _local_18.y;
	}


}
}//package common

