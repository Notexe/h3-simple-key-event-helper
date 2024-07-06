// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.InputTextFieldSpecialCharacterHandler

package common {
import flash.text.TextField;
import flash.events.Event;
import flash.events.KeyboardEvent;

import common.menu.MenuConstants;

public class InputTextFieldSpecialCharacterHandler {

	private const HIGH_EVENT_PRIORITY:int = 1001;

	private var m_inputTextField:TextField = null;
	private var m_selectAllCharacterInputTriggered:Boolean = false;
	private var m_previousText:String;
	private var m_previousSelectionBegin:int = -1;
	private var m_previousSelectionEnd:int = -1;

	public function InputTextFieldSpecialCharacterHandler(_arg_1:TextField) {
		this.m_inputTextField = _arg_1;
	}

	public function onUnregister():void {
		this.setActive(false);
		this.m_inputTextField = null;
	}

	public function setActive(_arg_1:Boolean):void {
		if (_arg_1) {
			this.m_inputTextField.addEventListener(Event.CHANGE, this.onTextInputChange, false, this.HIGH_EVENT_PRIORITY, true);
			this.m_inputTextField.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, this.HIGH_EVENT_PRIORITY, true);
		} else {
			this.m_inputTextField.removeEventListener(Event.CHANGE, this.onTextInputChange, false);
			this.m_inputTextField.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
		}

	}

	private function onKeyDown(_arg_1:KeyboardEvent):void {
		this.m_selectAllCharacterInputTriggered = false;
		if ((((_arg_1.ctrlKey) && (_arg_1.altKey)) && (_arg_1.keyCode == MenuConstants.KEYCODE_A))) {
			this.m_selectAllCharacterInputTriggered = true;
			this.m_previousText = this.m_inputTextField.text;
			this.m_previousSelectionBegin = this.m_inputTextField.selectionBeginIndex;
			this.m_previousSelectionEnd = this.m_inputTextField.selectionEndIndex;
		}

	}

	private function onTextInputChange(_arg_1:Event):void {
		this.handleSelectAllPlusCharacterInputBug();
	}

	private function handleSelectAllPlusCharacterInputBug():void {
		var _local_4:String;
		var _local_5:String;
		if (!this.m_selectAllCharacterInputTriggered) {
			return;
		}

		this.m_selectAllCharacterInputTriggered = false;
		var _local_1:String = this.m_inputTextField.text;
		var _local_2:int = (this.m_previousSelectionEnd - this.m_previousSelectionBegin);
		var _local_3:int = (this.m_inputTextField.maxChars - (this.m_previousText.length - _local_2));
		if (_local_3 > 0) {
			_local_4 = this.m_previousText.substr(0, this.m_previousSelectionBegin);
			_local_5 = _local_1.substr(0, _local_3);
			_local_4 = (_local_4 + _local_5);
			_local_4 = (_local_4 + this.m_previousText.substr(this.m_previousSelectionEnd));
			this.m_inputTextField.text = _local_4;
			this.m_inputTextField.setSelection((this.m_previousSelectionBegin + _local_5.length), (this.m_previousSelectionBegin + _local_5.length));
		} else {
			this.m_inputTextField.text = this.m_previousText;
			this.m_inputTextField.setSelection(this.m_previousSelectionBegin, this.m_previousSelectionBegin);
		}

	}


}
}//package common

