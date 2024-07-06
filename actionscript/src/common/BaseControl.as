// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.BaseControl

package common {
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.external.ExternalInterface;
import flash.events.Event;

public class BaseControl extends Sprite {

	public var m_bounds:Rectangle;
	private var m_editorSelectionWidget:Sprite = null;
	private var m_editorSelectionArrowWidget:Sprite = null;
	private var m_editorContainerWidget:Sprite = null;
	public var CallEntity:Function;

	public function BaseControl() {
		this.m_bounds = new Rectangle();
		var _local_1:Boolean = ExternalInterface.call("CommonUtilsGetBoundsChangeDebug");
		if (_local_1) {
			addEventListener(Event.ENTER_FRAME, this.onEnterFrameHandler);
		}

	}

	public function onEnterFrameHandler():void {
		var _local_1:Rectangle = getBounds(this);
		if (((((!(this.m_bounds.x == _local_1.x)) || (!(this.m_bounds.y == _local_1.y))) || (!(this.m_bounds.width == _local_1.width))) || (!(this.m_bounds.height == _local_1.height)))) {
			this.m_bounds = _local_1;
		}

	}

	public function onAttached():void {
	}

	public function onChildrenAttached():void {
	}

	public function updateBounds():void {
		this.m_bounds = getBounds(this);
		this.sendBounds(this.m_bounds);
	}

	public function onEditorSelected(_arg_1:Boolean, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):void {
		if (this.m_editorSelectionWidget != null) {
			BaseControlEditorDebug.unsetSelectionWidget(this.m_editorSelectionWidget);
			this.m_editorSelectionWidget = null;
		}

		if (this.m_editorSelectionArrowWidget != null) {
			BaseControlEditorDebug.unsetSelectionArrowWidget(this.m_editorSelectionArrowWidget);
			this.m_editorSelectionArrowWidget = null;
		}

		if (_arg_1) {
			this.m_editorSelectionWidget = BaseControlEditorDebug.setSelectionWidget(this, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
			this.m_editorSelectionArrowWidget = BaseControlEditorDebug.setSelectionArrowWidget(this, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
		}

	}

	public function onEditorContainerSelected(_arg_1:Boolean, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):void {
		if (this.m_editorContainerWidget != null) {
			BaseControlEditorDebug.unsetContainerWidget(this.m_editorContainerWidget);
			this.m_editorContainerWidget = null;
		}

		if (_arg_1) {
			this.m_editorContainerWidget = BaseControlEditorDebug.setContainerWidget(this, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
		}

	}

	public function clearMatrix3D():void {
		transform.perspectiveProjection = null;
		transform.matrix3D = null;
	}

	public function getContainer():Sprite {
		return (this);
	}

	public function onSetConstrained(_arg_1:Boolean):void {
	}

	public function onSetSize(_arg_1:Number, _arg_2:Number):void {
	}

	public function onSetViewport(_arg_1:Number, _arg_2:Number, _arg_3:Number):void {
	}

	public function onSetVisible(_arg_1:Boolean):void {
	}

	public function onMouseEnabled(_arg_1:Boolean):void {
		this.mouseEnabled = _arg_1;
		this.mouseChildren = _arg_1;
	}

	protected function print(_arg_1:*):void {
		if (this.CallEntity != null) {
			this.CallEntity(1, (_arg_1 as String));
		}

	}

	protected function sendEventWithValue(_arg_1:String, _arg_2:*):void {
		if (this.CallEntity != null) {
			this.CallEntity(2, _arg_1, _arg_2);
		}

	}

	protected function sendEvent(_arg_1:String):void {
		if (this.CallEntity != null) {
			this.CallEntity(2, _arg_1);
		}

	}

	protected function getProperty(_arg_1:String):* {
		if (this.CallEntity != null) {
			return (this.CallEntity(3, _arg_1));
		}

		return (null);
	}

	protected function sendBounds(_arg_1:Rectangle):void {
		if (this.CallEntity != null) {
			this.CallEntity(4, _arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
		}

	}


}
}//package common

