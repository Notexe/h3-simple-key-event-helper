// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.menu.textTicker

package common.menu {
import flash.display.Sprite;
import flash.text.TextField;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;
import flash.events.Event;
import flash.text.TextFormat;
import flash.utils.getTimer;

public class textTicker {

	private var m_totalFrames:int;
	private var m_deltaTime:Number;
	private var m_prevFrame:Number;
	private var m_currentFrame:Number;
	private var m_frameFactor:Number = 0;
	private var m_frame:int;
	private var m_allValues:Object = {};
	private var m_fakeStage:Sprite;
	private var initDelayValue:Number = 500;
	private var initDelayID:Number;
	private var m_resetDelayValue:Number = 500;
	private var m_resetDelayID:Number;
	private var m_isRunning:Boolean = false;


	public function startTextTicker(_arg_1:TextField, _arg_2:String, _arg_3:Function = null):void {
		var _local_4:Boolean = true;
		this.startTextTickerInternal(_arg_1, _arg_2, _local_4, _arg_3);
	}

	public function startTextTickerHtml(_arg_1:TextField, _arg_2:String, _arg_3:Function = null, _arg_4:Number = 0):void {
		var _local_5:Boolean;
		this.startTextTickerInternal(_arg_1, _arg_2, _local_5, _arg_3, _arg_4);
	}

	public function isRunning():Boolean {
		return (this.m_isRunning);
	}

	private function startTextTickerInternal(_arg_1:TextField, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:Number = 0):void {
		this.m_totalFrames = 0;
		this.m_deltaTime = 0;
		this.m_prevFrame = 0;
		this.m_currentFrame = 0;
		this.m_frameFactor = 0;
		this.m_frame = 0;
		this.m_resetDelayValue = _arg_5;
		this.m_allValues = {};
		this.m_allValues.textfield = _arg_1;
		if (_arg_3) {
			this.m_allValues.textcolor = _arg_1.textColor;
		}

		this.m_allValues.fullString = _arg_2;
		this.m_allValues.onTextChanged = _arg_4;
		if (!this.m_fakeStage) {
			this.m_fakeStage = new Sprite();
		}

		clearTimeout(this.m_resetDelayID);
		clearTimeout(this.initDelayID);
		this.initDelayID = setTimeout(this.initTicker, this.initDelayValue, this.m_allValues);
		this.m_isRunning = true;
	}

	public function stopTextTicker(_arg_1:TextField, _arg_2:String):void {
		this.m_isRunning = false;
		clearTimeout(this.initDelayID);
		if (this.m_fakeStage) {
			this.m_fakeStage.removeEventListener(Event.ENTER_FRAME, this.update);
		}

		_arg_1.scrollH = 0;
		_arg_1.htmlText = _arg_2;
		if (this.m_allValues.onTextChanged != null) {
			this.m_allValues.onTextChanged(this.m_allValues.textfield);
		}

	}

	private function initTicker(_arg_1:Object):void {
		this.m_allValues.textfield.htmlText = this.m_allValues.fullString;
		this.m_allValues.textfield.multiline = false;
		this.m_allValues.textfield.wordWrap = false;
		if (this.m_allValues.textcolor != null) {
			this.m_allValues.textfield.textColor = this.m_allValues.textcolor;
		}

		if (this.m_allValues.onTextChanged != null) {
			this.m_allValues.onTextChanged(this.m_allValues.textfield);
		}

		var _local_2:int = this.m_allValues.textfield.maxScrollH;
		if (this.m_allValues.textfield.maxScrollH <= 0) {
			return;
		}

		var _local_3:String;
		var _local_4:int = -1;
		var _local_5:TextFormat = this.m_allValues.textfield.getTextFormat();
		if (_local_5 != null) {
			_local_3 = _local_5.font;
			_local_4 = ((_local_5.size != null) ? int(_local_5.size) : -1);
		}

		var _local_6:* = "      ";
		if (((!(_local_3 == null)) && (_local_4 > 0))) {
			_local_6 = (((((('<font face="' + _local_3) + '" size="') + _local_4) + '">') + _local_6) + "</font>");
		}

		this.m_allValues.textfield.htmlText = ((this.m_allValues.fullString + _local_6) + this.m_allValues.fullString);
		if (this.m_allValues.textcolor != null) {
			this.m_allValues.textfield.textColor = this.m_allValues.textcolor;
		}

		if (this.m_allValues.onTextChanged != null) {
			this.m_allValues.onTextChanged(this.m_allValues.textfield);
		}

		this.m_totalFrames = (_arg_1.textfield.maxScrollH - _local_2);
		this.goTextTicker();
	}

	private function goTextTicker():void {
		if (this.m_fakeStage) {
			this.m_fakeStage.addEventListener(Event.ENTER_FRAME, this.update);
		}

		this.m_prevFrame = getTimer();
	}

	private function update(_arg_1:Event):void {
		this.m_currentFrame = getTimer();
		this.m_deltaTime = ((this.m_currentFrame - this.m_prevFrame) * 0.001);
		this.m_prevFrame = this.m_currentFrame;
		this.m_frameFactor = (this.m_frameFactor + (100 / (1 / this.m_deltaTime)));
		this.m_frame = Math.ceil(this.m_frameFactor);
		if (this.m_frame > this.m_totalFrames) {
			this.m_frame = this.m_totalFrames;
			this.m_frameFactor = 0;
			if (this.m_resetDelayValue > 0) {
				if (this.m_fakeStage != null) {
					this.m_fakeStage.removeEventListener(Event.ENTER_FRAME, this.update);
				}

				clearTimeout(this.m_resetDelayID);
				this.m_resetDelayID = setTimeout(this.goTextTicker, this.m_resetDelayValue);
			}

		}

		this.m_allValues.textfield.scrollH = this.m_frame;
	}

	public function setTextColor(_arg_1:int):void {
		this.m_allValues.textcolor = _arg_1;
	}


}
}//package common.menu

