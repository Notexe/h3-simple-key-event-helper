package simplekeyeventhelper {
import common.BaseControl;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.utils.describeType;

public class SimpleKeyEventHelper extends BaseControl {

	private var m_enabled:Boolean = true;
	private var m_modifierKeyName:String = "none";
	private var m_keyName:uint;

	private var m_isKeyDown:Boolean;
	private var m_keyPressHandled:Boolean;

	public function SimpleKeyEventHelper() {
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}

	public function onSetData(object:Object):void {
		if (object.hasOwnProperty("modifier")) {
			m_modifierKeyName = String(object.modifier).toLowerCase();
		}
		if (object.hasOwnProperty("key")) {
			m_keyName = GetKeyCodeFromString(object.key);
		}
	}

	private function onAdded(event:Event):void {
		if (m_enabled) {
			addKeyListeners();
		}
	}

	private function addKeyListeners():void {
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	private function removeKeyListeners():void {
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	private function onKeyDown(event:KeyboardEvent):void {
		if (!m_enabled) return;

		var modifierPressed:Boolean = (m_modifierKeyName == "control" && event.ctrlKey) ||
				(m_modifierKeyName == "alt" && event.altKey) ||
				(m_modifierKeyName == "none" && !event.ctrlKey && !event.altKey);

		if (modifierPressed && event.keyCode == m_keyName) {
			if (!m_isKeyDown) {
				m_isKeyDown = true;
				m_keyPressHandled = false;
			}

			if (!m_keyPressHandled) {
				Send_Down();
				m_keyPressHandled = true;
			}

			Send_Pressed();
		}
	}

	private function onKeyUp(event:KeyboardEvent):void {
		if (!m_enabled) return;

		var modifierPressed:Boolean = (m_modifierKeyName == "control" && event.ctrlKey) ||
				(m_modifierKeyName == "alt" && event.altKey) ||
				(m_modifierKeyName == "none" && !event.ctrlKey && !event.altKey);

		if (modifierPressed && event.keyCode == m_keyName) {
			m_isKeyDown = false;
			Send_Up();
		}
	}

	public function set m_sModifierKeyName(string:String):void {
		m_modifierKeyName = string.toLowerCase();
	}

	public function set m_sKeyName(string:String):void {
		m_keyName = GetKeyCodeFromString(string);
	}

	public function Enable():void {
		m_enabled = true;
		addKeyListeners();
	}

	public function Disable():void {
		m_enabled = false;
		removeKeyListeners();
	}

	private function GetKeyCodeFromString(keyName:String):uint {
		var keyboardInfo:XML = describeType(Keyboard);
		for each (var constant:XML in keyboardInfo.constant) {
			if (constant.@name == keyName.toUpperCase()) {
				return Keyboard[keyName.toUpperCase()];
			}
		}
		throw new Error("Key not supported: " + keyName);
	}

	public function Send_Pressed():void {
		sendEvent("Pressed");
	}

	public function Send_Down():void {
		sendEvent("Down");
	}

	public function Send_Up():void {
		sendEvent("Up");
	}

}
}