// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.menu.MenuUtils

package common.menu {
import flash.text.TextFormat;
import flash.text.TextField;

import common.CommonUtils;
import common.Localization;

import mx.utils.StringUtil;

import flash.display.Sprite;
import flash.utils.Dictionary;
import flash.geom.Rectangle;
import flash.display.DisplayObject;
import flash.display.MovieClip;

import basic.ButtonPromptContainer;

import flash.geom.ColorTransform;

import fl.motion.Color;

import flash.filters.DropShadowFilter;
import flash.filters.ColorMatrixFilter;
import flash.display.DisplayObjectContainer;
import flash.geom.Point;

import common.Animate;

public class MenuUtils {

	private static const PI:Number = Math.PI;//3.14159265358979
	private static var s_truncator:String;
	private static var s_truncatorLocale:String = "";
	private static var s_thousandsSeparator:String;
	private static var s_thousandsSeparatorLocale:String = "";
	private static var s_decimalSeparator:String = ".";
	private static const m_matchHtmlLineBreaks:RegExp = /(?i)\s*<br[^>]*>\s*/g;
	public static const TINT_COLOR_BLACK:int = 0;
	public static const TINT_COLOR_GREY:int = 1;
	public static const TINT_COLOR_LIGHT_GREY:int = 2;
	public static const TINT_COLOR_NEARLY_WHITE:int = 3;
	public static const TINT_COLOR_WHITE:int = 4;
	public static const TINT_COLOR_RED:int = 5;
	public static const TINT_COLOR_LIGHT_RED:int = 6;
	public static const TINT_COLOR_DARKER_GREY:int = 7;
	public static const TINT_COLOR_MEDIUM_GREY:int = 8;
	public static const TINT_COLOR_REAL_RED:int = 9;
	public static const TINT_COLOR_ULTRA_DARK_GREY:int = 10;
	public static const TINT_COLOR_MEDIUM_GREY_3:int = 11;
	public static const TINT_COLOR_GREY_DARK_2:int = 12;
	public static const TINT_COLOR_GREY_DARK_3:int = 13;
	public static const TINT_COLOR_GREEN:int = 14;
	public static const TINT_COLOR_GREEN_LIGHT:int = 15;
	public static const TINT_COLOR_COLOR_GREY_GOTY:int = 16;
	public static const TINT_COLOR_MEDIUM_GREY_GOTY:int = 17;
	public static const TINT_COLOR_SUPER_LIGHT_GREY:int = 18;
	public static const TINT_COLOR_GREYBG:int = 19;
	public static const TINT_COLOR_YELLOW:int = 20;
	public static const TINT_COLOR_YELLOW_LIGHT:int = 21;
	public static const TINT_COLOR_MAGENTA_DARK:int = 22;
	private static const MENU_METER_TO_PIXEL:Number = (1 / 0.00364583);//274.285965061454


	public static function setupText(t:TextField, string:String, fontSize:int = 28, fontStyle:String = "$medium", fontColor:String = "#ebebeb", _arg_6:Boolean = false):void {
		var _local_7:TextFormat;
		if (string == null) {
			string = "";
		}

		if (ControlsMain.isVrModeActive()) {
			if (((fontStyle == MenuConstants.FONT_TYPE_LIGHT) || (fontStyle == MenuConstants.FONT_TYPE_NORMAL))) {
				fontStyle = MenuConstants.FONT_TYPE_MEDIUM;
			}

		}

		if (_arg_6) {
			t.htmlText = (t.htmlText + (((((((('<font face="' + fontStyle) + '" color="') + fontColor) + '" size="') + fontSize) + '">') + string) + "</font>"));
		} else {
			t.htmlText = (((((((('<font face="' + fontStyle) + '" color="') + fontColor) + '" size="') + fontSize) + '">') + string) + "</font>");
			_local_7 = new TextFormat();
			_local_7.color = MenuConstants.ColorNumber(fontColor);
			_local_7.font = fontStyle;
			_local_7.size = fontSize;
			t.defaultTextFormat = _local_7;
		}

	}

	public static function setTextColor(t:TextField, textColor:int):void {
		t.textColor = textColor;
		var _local_3:TextFormat = new TextFormat();
		_local_3.color = textColor;
		t.defaultTextFormat = _local_3;
	}

	public static function setupTextUpper(t:TextField, text:String, fontSize:int = 28, fontStyle:String = "$medium", fontColor:String = "#ebebeb", _arg_6:Boolean = false):void {
		if (text == null) {
			text = "";
		}

		setupText(t, text.toUpperCase(), fontSize, fontStyle, fontColor, _arg_6);
	}

	public static function setupProfileName(t:TextField, text:String, fontSize:int = 28, fontStyle:String = "$medium", fontColor:String = "#ebebeb", _arg_6:Boolean = false):void {
		if (text == null) {
			text = "";
		}

		setupText(t, text, fontSize, fontStyle, fontColor, _arg_6);
		CommonUtils.changeFontToGlobalIfNeeded(t);
		truncateTextfieldWithCharLimit(t, 1, MenuConstants.PLAYERNAME_MIN_CHAR_COUNT, fontColor);
		shrinkTextToFit(t, t.width, -1);
	}

	public static function convertToEscapedHtmlString(_arg_1:String):String {
		if (((_arg_1 == "") || (_arg_1 == null))) {
			return (_arg_1);
		}

		var _local_2:XML = new XML((("<p><![CDATA[" + _arg_1) + "]]></p>"));
		return (_local_2.toXMLString());
	}

	public static function removeHtmlLineBreaks(_arg_1:String):String {
		m_matchHtmlLineBreaks.lastIndex = 0;
		return (_arg_1.replace(m_matchHtmlLineBreaks, " "));
	}

	public static function truncateTextfield(t:TextField, _arg_2:int, fontColor:String = "#ebebeb", _arg_4:Boolean = false):Boolean {
		return (truncateTextfieldWithCharLimit(t, _arg_2, 0, fontColor, _arg_4));
	}

	public static function truncateTextfieldWithCharLimit(t:TextField, _arg_2:int, _arg_3:int = 0, fontColor:String = "#ebebeb", useGlobalFont:Boolean = false):Boolean {
		var _local_10:int;
		var _local_11:int;
		var _local_12:String;
		var _local_13:int;
		var _local_14:Boolean;
		var _local_15:String;
		var _local_16:String;
		var _local_17:String;
		if (((_arg_2 <= 0) || (t.length <= 0))) {
			return (false);
		}

		if (useGlobalFont) {
			CommonUtils.changeFontToGlobalFont(t);
		}

		var _local_6:TextFormat = t.getTextFormat();
		if (((fontColor) && (!(fontColor == "")))) {
			_local_6.color = MenuConstants.ColorNumber(fontColor);
		}

		var _local_7:Boolean = t.wordWrap;
		var _local_8:Boolean = t.multiline;
		if (((!(_local_8)) || (_arg_2 == 1))) {
			t.wordWrap = true;
		}

		t.multiline = true;
		var _local_9:Boolean;
		if (t.numLines > _arg_2) {
			_local_10 = t.getLineIndexOfChar((t.length - 1));
			if (_local_10 >= _arg_2) {
				_local_11 = (t.getLineOffset(_arg_2) + t.getLineLength(_arg_2));
				if (_local_11 < 0) {
					_local_11 = 0;
				}

				_local_12 = t.text;
				_local_13 = _local_12.length;
				if (((s_truncator == null) || (!(s_truncatorLocale == ControlsMain.getActiveLocale())))) {
					s_truncator = Localization.get("UI_TEXT_TRUNCATOR");
					s_truncatorLocale = ControlsMain.getActiveLocale();
				}

				_local_14 = false;
				while ((((!(_local_14)) && (_local_11 > 0)) && (_local_13 > _arg_3))) {
					t.text = "";
					_local_11--;
					_local_15 = _local_12.charAt(_local_11);
					while (((_local_11 > 0) && (((_local_15 == " ") || (_local_15 == "\n")) || (_local_15 == "\r")))) {
						_local_11--;
						_local_15 = _local_12.charAt(_local_11);
					}

					_local_16 = _local_12.substring(0, (_local_11 + 1));
					_local_13 = _local_16.length;
					_local_17 = (_local_16 + s_truncator);
					t.text = _local_17;
					t.setTextFormat(_local_6);
					_local_10 = t.getLineIndexOfChar((t.length - 1));
					_local_14 = (_local_10 < _arg_2);
				}

				_local_9 = true;
			}

		}

		t.wordWrap = _local_7;
		t.multiline = _local_8;
		return (_local_9);
	}

	public static function truncateMultipartTextfield(t:TextField, text:String, _arg_3:String, _arg_4:String, _arg_5:uint = 1, fontColor:String = "#ebebeb", useGlobalFont:Boolean = false):void {
		var _local_12:int;
		var _local_13:int;
		var _local_14:String;
		var _local_15:String;
		var _local_16:String;
		var _local_17:Boolean;
		var _local_18:RegExp;
		var _local_19:String;
		var _local_20:String;
		var _local_21:int;
		var _local_22:int;
		if (((text.length <= _arg_5) && (_arg_3.length <= _arg_5))) {
			return;
		}

		var _local_8:int = 1;
		if (useGlobalFont) {
			CommonUtils.changeFontToGlobalFont(t);
		}

		var _local_9:TextFormat = t.getTextFormat();
		if (((fontColor) && (!(fontColor == "")))) {
			_local_9.color = MenuConstants.ColorNumber(fontColor);
		}

		var _local_10:Boolean = t.wordWrap;
		var _local_11:Boolean = t.multiline;
		if (((!(_local_11)) || (_local_8 == 1))) {
			t.wordWrap = true;
		}

		t.multiline = true;
		if (t.numLines > _local_8) {
			_local_12 = t.getLineIndexOfChar((t.length - 1));
			if (_local_12 >= _local_8) {
				_local_13 = (t.getLineOffset(_local_8) + t.getLineLength(_local_8));
				if (_local_13 < 0) {
					_local_13 = 0;
				}

				_local_14 = t.text;
				t.text = "";
				t.htmlText = text;
				text = t.text;
				t.htmlText = _arg_3;
				_arg_3 = t.text;
				_local_15 = text;
				_local_16 = _arg_3;
				if (((s_truncator == null) || (!(s_truncatorLocale == ControlsMain.getActiveLocale())))) {
					s_truncator = Localization.get("UI_TEXT_TRUNCATOR");
					s_truncatorLocale = ControlsMain.getActiveLocale();
				}

				_local_17 = false;
				while ((!(_local_17))) {
					_local_18 = /\S\s*$/;
					if (text.length > _arg_3.length) {
						text = text.substr(0, (text.length - 1));
						_local_21 = text.search(_local_18);
						if (_local_21 > 0) {
							text = text.substring(0, (_local_21 + 1));
						}

						_local_15 = (text + s_truncator);
					} else {
						_arg_3 = _arg_3.substr(0, (_arg_3.length - 1));
						_local_22 = _arg_3.search(_local_18);
						if (_local_22 > 0) {
							_arg_3 = _arg_3.substring(0, (_local_22 + 1));
						}

						_local_16 = (_arg_3 + s_truncator);
					}

					_local_19 = ((_local_15 + _arg_4) + _local_16);
					_local_20 = convertToEscapedHtmlString(_local_19);
					t.htmlText = _local_20;
					t.setTextFormat(_local_9);
					_local_12 = t.getLineIndexOfChar((t.length - 1));
					_local_17 = (_local_12 < _local_8);
					if (((text.length <= _arg_5) && (_arg_3.length <= _arg_5))) {
						_local_17 = true;
					}

				}

			}

		}

		t.wordWrap = _local_10;
		t.multiline = _local_11;
	}

	public static function truncateHTMLField(_arg_1:TextField, _arg_2:String, _arg_3:Sprite = null, _arg_4:Boolean = false):void {
		if (_arg_4) {
			_arg_1.htmlText = (('<font face="$global">' + _arg_2) + "</font>");
		} else {
			_arg_1.htmlText = _arg_2;
		}

		if (((s_truncator == null) || (!(s_truncatorLocale == ControlsMain.getActiveLocale())))) {
			s_truncator = Localization.get("UI_TEXT_TRUNCATOR");
			s_truncatorLocale = ControlsMain.getActiveLocale();
		}

		var _local_5:int = getLastVisibleCharacter(_arg_1, _arg_3);
		if (_local_5 == -1) {
			_arg_1.htmlText = "";
			return;
		}

		var _local_6:String = _arg_1.text;
		var _local_7:String = _local_6.substr((_local_5 + 1));
		_local_7 = StringUtil.trim(_local_7);
		if (_local_7.length <= 0) {
			return;
		}

		var _local_8:String = truncateHTMLText(_arg_2, _local_5, s_truncator, 3);
		if (_arg_4) {
			_arg_1.htmlText = (('<font face="$global">' + _local_8) + "</font>");
		} else {
			_arg_1.htmlText = _local_8;
		}

	}

	public static function truncateHTMLText(htmlString:String, strLength:int, truncateString:String, truncatePadding:int):String {
		var strippedString:String;
		var currentlyOpenTags:Dictionary;
		var contentIndex:int;
		var needsTruncation:Boolean;
		var char:String;
		var finishTag:Function = function (_arg_1:String):void {
			isInsideTag = false;
			needsTagFinish = false;
			var _local_2:* = (_arg_1.charAt(1) == "/");
			var _local_3:Boolean = ((!(_local_2)) && (!(_arg_1.charAt((_arg_1.length - 2)) == "/")));
			var _local_4:Boolean = ((!(_local_2)) && (!(_local_3)));
			var _local_5:* = "";
			if (_local_3) {
				_local_5 = _arg_1.substring(1, (_arg_1.length - 1));
			} else {
				if (_local_2) {
					_local_5 = _arg_1.substring(2, (_arg_1.length - 1));
				}

			}

			var _local_6:Number = 0;
			if (currentlyOpenTags[_local_5] != undefined) {
				_local_6 = currentlyOpenTags[_local_5];
			}

			if (needsTruncation == false) {
				strippedString = (strippedString + _arg_1);
				if (_local_5 == "br") {
					contentIndex = (contentIndex + 1);
				}

				if (_local_3) {
					currentlyOpenTags[_local_5] = (_local_6 + 1);
				} else {
					if (_local_2) {
						currentlyOpenTags[_local_5] = (_local_6 - 1);
						if (currentlyOpenTags[_local_5] <= 0) {
							delete currentlyOpenTags[_local_5];
						}

					}

				}

			} else {
				if (((_local_2) && (_local_6 > 0))) {
					currentlyOpenTags[_local_5] = (_local_6 - 1);
					if (currentlyOpenTags[_local_5] <= 0) {
						delete currentlyOpenTags[_local_5];
					}

					strippedString = (strippedString + _arg_1);
				}

			}

		};
		strLength = (strLength - truncatePadding);
		var needsTagFinish:Boolean;
		var isInsideTag:Boolean;
		strippedString = "";
		var currentTag:String = "";
		currentlyOpenTags = new Dictionary();
		var truncateAdded:Boolean;
		contentIndex = 0;
		var i:int;
		while (i < htmlString.length) {
			needsTruncation = (contentIndex >= strLength);
			if (contentIndex == strLength) {
				truncateAdded = true;
				strippedString = (strippedString + truncateString);
				contentIndex = (contentIndex + 1);
			}

			if (needsTagFinish) {
				(finishTag(currentTag));
				currentTag = "";
			}

			char = htmlString.charAt(i);
			if (char == "<") {
				isInsideTag = true;
			} else {
				if (char == ">") {
					needsTagFinish = true;
				}

			}

			if (((!(isInsideTag)) && (!(needsTruncation)))) {
				strippedString = (strippedString + char);
				contentIndex = (contentIndex + 1);
			} else {
				if (isInsideTag) {
					currentTag = (currentTag + char);
				}

			}

			i = (i + 1);
		}

		if (!truncateAdded) {
			strippedString = (strippedString + truncateString);
		}

		if (needsTagFinish) {
			(finishTag(currentTag));
		}

		return (strippedString);
	}

	public static function getLastVisibleCharacter(_arg_1:TextField, _arg_2:Sprite = null):int {
		var _local_8:int;
		var _local_9:int;
		var _local_10:int;
		var _local_11:Boolean;
		var _local_12:Rectangle;
		var _local_3:Rectangle = _arg_1.getBounds(_arg_1);
		if (_arg_2 != null) {
			_arg_2.graphics.clear();
			_arg_2.graphics.lineStyle(1, 0);
			_arg_2.graphics.drawRect(_local_3.x, _local_3.y, _local_3.width, _local_3.height);
		}

		var _local_4:int = -1;
		var _local_5:int = -1;
		var _local_6:Rectangle;
		var _local_7:int;
		while (_local_7 < _arg_1.numLines) {
			_local_8 = _arg_1.getLineOffset(_local_7);
			_local_9 = _arg_1.getLineLength(_local_7);
			_local_10 = _local_8;
			while (_local_10 < (_local_8 + _local_9)) {
				_local_11 = false;
				_local_12 = _arg_1.getCharBoundaries(_local_10);
				if (_local_12 != null) {
					_local_12.x = (_local_12.x + _local_3.x);
					_local_12.y = (_local_12.y + _local_3.y);
					_local_12.height = (_local_12.height + 5);
					if (_local_3.containsRect(_local_12)) {
						if (((_local_6 == null) || (_local_7 > _local_5))) {
							_local_11 = true;
						}

						if (((_local_7 == _local_5) && (_local_12.x > _local_6.x))) {
							_local_11 = true;
						}

					}

					if (_local_11) {
						_local_5 = _local_7;
						_local_4 = _local_10;
						_local_6 = _local_12;
					}

					if (_arg_2 != null) {
						_arg_2.graphics.lineStyle(1, 0xCCCCCC);
						_arg_2.graphics.drawRect(_local_12.x, _local_12.y, _local_12.width, _local_12.height);
					}

				}

				_local_10++;
			}

			_local_7++;
		}

		if (((!(_arg_2 == null)) && (!(_local_6 == null)))) {
			_arg_2.graphics.lineStyle(1, 0xFF00);
			_arg_2.graphics.drawRect(_local_6.x, _local_6.y, _local_6.width, _local_6.height);
		}

		return (_local_4);
	}

	public static function setupTextAndShrinkToFit(t:TextField, text:String, fontSize:int = 28, fontStyle:String = "$medium", maxWidth:Number = 0, maxHeight:Number = 0, _arg_7:Number = 9, fontColor:String = "#ebebeb", _arg_9:Boolean = false):Boolean {
		var _local_14:TextFormat;
		var _local_10:TextFormat = t.getTextFormat();
		var _local_11:String = _local_10.font;
		var _local_12:int = int(_local_10.size);
		var _local_13:* = (t.text.length > 0);
		setupText(t, text, fontSize, fontStyle, fontColor, _arg_9);
		_local_10 = t.getTextFormat();
		if (((_local_13) && (_local_10.font == _local_11))) {
			_local_14 = new TextFormat();
			_local_14.size = _local_12;
			t.setTextFormat(_local_14);
		}

		return (shrinkTextToFit(t, maxWidth, maxHeight, _arg_7));
	}

	public static function setupTextAndShrinkToFitUpper(t:TextField, text:String, fontSize:int = 28, fontStyle:String = "$medium", _arg_5:Number = 0, _arg_6:Number = 0, _arg_7:Number = 9, fontColor:String = "#ebebeb", _arg_9:Boolean = false):Boolean {
		if (text == null) {
			text = "";
		}

		return (setupTextAndShrinkToFit(t, text.toUpperCase(), fontSize, fontStyle, _arg_5, _arg_6, _arg_7, fontColor, _arg_9));
	}

	public static function shrinkTextToFit(t:TextField, maxWidth:Number, maxHeight:Number, _arg_4:Number = 9, _arg_5:int = -1, _arg_6:Number = 0):Boolean {
		var _local_10:int;
		_arg_4 = Math.max(_arg_4, 1);
		if (maxWidth > 0) {
			maxWidth = Math.max(1, (maxWidth - 5));
		}

		if (maxHeight > 0) {
			maxHeight = Math.max(1, (maxHeight - 5));
		}

		var _local_7:TextFormat = t.getTextFormat();
		var _local_8:TextFormat = new TextFormat();
		_local_8.size = _local_7.size;
		var _local_9:Boolean;
		while ((!(_local_9))) {
			_local_9 = true;
			_local_10 = int(_local_8.size);
			if (((maxWidth > 0) && (t.textWidth > maxWidth))) {
				_local_9 = false;
			} else {
				if (((maxHeight > 0) && (t.textHeight > maxHeight))) {
					_local_9 = false;
				} else {
					if (((_arg_5 > 0) && (t.numLines > _arg_5))) {
						_local_9 = false;
					}

				}

			}

			if (!_local_9) {
				if (_local_10 <= _arg_4) {
					return (false);
				}

				_local_8.size = (_local_10 - 1);
				if (_arg_6 != 0) {
					_local_8.leading = ((_local_10 - 1) * _arg_6);
				}

				t.setTextFormat(_local_8);
			}

		}

		return (true);
	}

	public static function setBold(_arg_1:Boolean, _arg_2:TextField):void {
		var _local_3:TextFormat = _arg_2.getTextFormat();
		_local_3.font = ((_arg_1) ? MenuConstants.FONT_TYPE_BOLD : MenuConstants.FONT_TYPE_NORMAL);
		_arg_2.setTextFormat(_local_3);
	}

	public static function getTimeString(_arg_1:Number):String {
		var _local_2:Number = Math.abs(_arg_1);
		var _local_3:int = int(Math.floor((_local_2 / 60)));
		var _local_4:Number = (_local_2 - (_local_3 * 60));
		var _local_5:* = "";
		if (_local_3 < 10) {
			_local_5 = (_local_5 + "0");
		}

		_local_5 = (_local_5 + _local_3.toString());
		var _local_6:* = "";
		if (_local_4 < 10) {
			_local_6 = (_local_6 + "0");
		}

		_local_6 = (_local_6 + _local_4.toFixed(3));
		var _local_7:String = ((_local_5 + ":") + _local_6);
		if (_arg_1 < 0) {
			((_local_7 + "-") + _local_7);
		}

		return (_local_7);
	}

	public static function removeWhiteSpaces(_arg_1:String, _arg_2:Boolean = false):String {
		var _local_3:RegExp = ((_arg_2) ? /^\s*|\s*$/gim : /[\s\r\n]+/gim);
		return (_arg_1.replace(_local_3, ""));
	}

	public static function useDarkInlineButtonPrompts(_arg_1:TextField):void {
		var _local_9:Boolean;
		var _local_10:int;
		var _local_11:int;
		var _local_12:int;
		var _local_13:String;
		var _local_2:* = '<IMG SRC="btn';
		var _local_3:* = '<IMG SRC="dark_btn';
		var _local_4:* = "key";
		var _local_5:String = _arg_1.htmlText;
		if (_local_5.length < _local_2.length) {
			return;
		}

		var _local_6:* = "";
		var _local_7:int;
		var _local_8:int;
		while (_local_8 >= 0) {
			_local_9 = false;
			_local_8 = _local_5.indexOf(_local_2, _local_7);
			if (_local_8 >= 0) {
				_local_10 = (_local_8 + _local_2.length);
				_local_11 = _local_5.indexOf('"', _local_10);
				if (_local_11 > _local_10) {
					_local_12 = (_local_11 - _local_10);
					_local_13 = _local_5.substr(_local_10, _local_12);
					_local_9 = (_local_13.indexOf(_local_4) >= 0);
				}

				if (!_local_9) {
					_local_6 = (_local_6 + _local_5.substr(_local_7, (_local_8 - _local_7)));
					_local_6 = (_local_6 + _local_3);
				}

				_local_7 = (_local_8 + _local_2.length);
			} else {
				if (_local_6.length > 0) {
					_local_6 = (_local_6 + _local_5.substr(_local_7));
				}

			}

		}

		if (_local_6.length > 0) {
			_arg_1.htmlText = _local_6;
		}

	}

	public static function centerContained(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):void {
		var _local_6:Number = Math.min(1, getFillAspectScale(_arg_2, _arg_3, _arg_4, _arg_5));
		var _local_7:Number = (_arg_2 * _local_6);
		var _local_8:Number = (_arg_3 * _local_6);
		_arg_1.scaleX = (_arg_1.scaleY = _local_6);
		_arg_1.x = ((_arg_4 - _local_7) / 2);
		_arg_1.y = ((_arg_5 - _local_8) / 2);
	}

	public static function centerFill(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number = 1):void {
		var _local_7:Number = ((_arg_2 * (_arg_4 / _arg_2)) * _arg_6);
		var _local_8:Number = ((_arg_3 * (_arg_5 / _arg_3)) * _arg_6);
		_arg_1.scaleX = ((_arg_4 / _arg_2) * _arg_6);
		_arg_1.scaleY = ((_arg_5 / _arg_3) * _arg_6);
		_arg_1.x = ((_arg_4 - _local_7) / 2);
		_arg_1.y = ((_arg_5 - _local_8) / 2);
	}

	public static function centerFillAspect(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):void {
		var _local_6:Number = getFillAspectScale(_arg_2, _arg_3, _arg_4, _arg_5);
		var _local_7:Number = (_arg_2 * _local_6);
		var _local_8:Number = (_arg_3 * _local_6);
		_arg_1.scaleX = (_arg_1.scaleY = _local_6);
		_arg_1.x = ((_arg_4 - _local_7) / 2);
		_arg_1.y = ((_arg_5 - _local_8) / 2);
	}

	public static function getFillAspectScale(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number {
		return (Math.min((_arg_3 / _arg_1), (_arg_4 / _arg_2)));
	}

	public static function centerFillAspectFull(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number = 1):void {
		var _local_7:Number = (getFillAspectScaleFull(_arg_2, _arg_3, _arg_4, _arg_5) * _arg_6);
		var _local_8:Number = (_arg_2 * _local_7);
		var _local_9:Number = (_arg_3 * _local_7);
		_arg_1.scaleX = (_arg_1.scaleY = _local_7);
		_arg_1.x = ((_arg_4 - _local_8) / 2);
		_arg_1.y = ((_arg_5 - _local_9) / 2);
	}

	public static function getFillAspectScaleFull(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number {
		return (Math.max((_arg_3 / _arg_1), (_arg_4 / _arg_2)));
	}

	public static function centerFillAspectHeight(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number = 1):void {
		var _local_7:Number = ((_arg_5 / _arg_3) * _arg_6);
		var _local_8:Number = (_arg_2 * _local_7);
		var _local_9:Number = (_arg_3 * _local_7);
		_arg_1.scaleX = (_arg_1.scaleY = _local_7);
		_arg_1.x = ((_arg_4 - _local_8) / 2);
		_arg_1.y = ((_arg_5 - _local_9) / 2);
	}

	public static function setStateIndicatorBgSize(_arg_1:MovieClip, _arg_2:String):void {
		_arg_1.header.autoSize = "right";
		_arg_1.header.htmlText = _arg_2;
		var _local_3:int = _arg_1.indicatorBg.width;
		_arg_1.indicatorBg.width = ((_local_3 + _arg_1.header.width) + 3);
	}

	public static function scaleProportionalByWidth(_arg_1:DisplayObject, _arg_2:Number):void {
		scaleProportional(_arg_1, _arg_2, _arg_1.width);
	}

	public static function scaleProportionalByHeight(_arg_1:DisplayObject, _arg_2:Number):void {
		scaleProportional(_arg_1, _arg_2, _arg_1.height);
	}

	public static function scaleProportional(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number):void {
		var _local_4:Number = (_arg_2 / _arg_3);
		_arg_1.scaleX = (_arg_1.scaleX * _local_4);
		_arg_1.scaleY = (_arg_1.scaleY * _local_4);
	}

	public static function parsePrompts(_arg_1:Object, _arg_2:Object, _arg_3:Sprite, _arg_4:Boolean = false, _arg_5:Function = null):Object {
		var _local_6:ButtonPromptContainer;
		var _local_8:Boolean;
		if (((_arg_2 == null) && ((_arg_1 == null) || (_arg_1.buttonprompts == null)))) {
			return (null);
		}

		if (((((!(_arg_1 == null)) && (!(_arg_1.buttonprompts == null))) && (!(_arg_2 == null))) && (!(_arg_2.buttonprompts == null)))) {
			if (((_arg_1.controllerType == _arg_2.controllerType) && (_arg_1.buttonprompts.length == _arg_2.buttonprompts.length))) {
				_local_8 = isDataEqual(_arg_1.buttonprompts, _arg_2.buttonprompts);
				if (_local_8) {
					return (_arg_2);
				}

			}

		}

		while (_arg_3.numChildren > 0) {
			_local_6 = (_arg_3.getChildAt(0) as ButtonPromptContainer);
			if (_local_6 != null) {
				_local_6.onUnregister();
			}

			_arg_3.removeChildAt(0);
		}

		if (_arg_1 == null) {
			return (null);
		}

		if (_arg_1.buttonprompts == null) {
			return (null);
		}

		_local_6 = new ButtonPromptContainer(_arg_1, _arg_4, _arg_5);
		_arg_3.addChild(_local_6);
		var _local_7:Object = {};
		_local_7.buttonprompts = _arg_1.buttonprompts;
		return (_local_7);
	}

	public static function setupIcon(_arg_1:MovieClip, _arg_2:String, _arg_3:uint, _arg_4:Boolean, _arg_5:Boolean, _arg_6:uint = 0xFFFFFF, _arg_7:Number = 1, _arg_8:Number = 0, _arg_9:Boolean = false):void {
		var _local_10:ColorTransform = new ColorTransform();
		if (_arg_9) {
			_local_10.color = _arg_6;
			if (((!(_arg_1.icons_cutout == null)) || (!(_arg_1.icons_cutout == undefined)))) {
				_arg_1.icons.gotoAndStop(1);
				_arg_1.frame.visible = false;
				_arg_1.bg.visible = false;
				_arg_1.icons_cutout.visible = true;
				_arg_1.icons_cutout.gotoAndStop(_arg_2);
				_arg_1.icons_cutout.transform.colorTransform = _local_10;
			}

			return;
		}

		_local_10.color = _arg_3;
		if (((!(_arg_1.icons_cutout == null)) || (!(_arg_1.icons_cutout == undefined)))) {
			_arg_1.icons_cutout.visible = false;
			_arg_1.icons_cutout.gotoAndStop(1);
		}

		_arg_1.frame.visible = _arg_4;
		_arg_1.frame.transform.colorTransform = _local_10;
		_arg_1.icons.gotoAndStop(_arg_2);
		_arg_1.icons.transform.colorTransform = _local_10;
		_arg_1.bg.visible = _arg_5;
		_arg_1.bg.rotation = _arg_8;
		if (_arg_5) {
			_local_10.color = _arg_6;
			_local_10.alphaMultiplier = _arg_7;
			_arg_1.bg.transform.colorTransform = _local_10;
		}

	}

	public static function setTintColor(_arg_1:Object, _arg_2:int, _arg_3:Boolean = true):void {
		var _local_4:Number;
		if (!_arg_3) {
			_local_4 = _arg_1.alpha;
		}

		var _local_5:Color = new Color();
		_local_5.setTint(MenuConstants.COLOR_GREY_ULTRA_LIGHT, 1);
		switch (_arg_2) {
			case TINT_COLOR_BLACK:
				_local_5.setTint(MenuConstants.COLOR_BLACK, 1);
				break;
			case TINT_COLOR_GREY:
				_local_5.setTint(MenuConstants.COLOR_GREY_DARK, 1);
				break;
			case TINT_COLOR_LIGHT_GREY:
				_local_5.setTint(MenuConstants.COLOR_GREY_LIGHT, 1);
				break;
			case TINT_COLOR_NEARLY_WHITE:
				_local_5.setTint(MenuConstants.COLOR_GREY_ULTRA_LIGHT, 1);
				break;
			case TINT_COLOR_WHITE:
				_local_5.setTint(MenuConstants.COLOR_WHITE, 1);
				break;
			case TINT_COLOR_RED:
				_local_5.setTint(MenuConstants.COLOR_RED, 1);
				break;
			case TINT_COLOR_LIGHT_RED:
				_local_5.setTint(MenuConstants.COLOR_RED, 1);
				break;
			case TINT_COLOR_REAL_RED:
				_local_5.setTint(MenuConstants.COLOR_RED, 1);
				break;
			case TINT_COLOR_DARKER_GREY:
				_local_5.setTint(MenuConstants.COLOR_GREY_ULTRA_DARK, 1);
				break;
			case TINT_COLOR_MEDIUM_GREY:
				_local_5.setTint(MenuConstants.COLOR_GREY_MEDIUM, 1);
				break;
			case TINT_COLOR_ULTRA_DARK_GREY:
				_local_5.setTint(MenuConstants.COLOR_GREY_ULTRA_DARK, 1);
				break;
			case TINT_COLOR_MEDIUM_GREY_3:
				_local_5.setTint(MenuConstants.COLOR_GREY_MEDIUM, 1);
				break;
			case TINT_COLOR_GREY_DARK_2:
				_local_5.setTint(MenuConstants.COLOR_GREY_DARK, 1);
				break;
			case TINT_COLOR_GREY_DARK_3:
				_local_5.setTint(MenuConstants.COLOR_GREY_DARK, 1);
				break;
			case TINT_COLOR_GREEN:
				_local_5.setTint(MenuConstants.COLOR_GREEN, 1);
				break;
			case TINT_COLOR_GREEN_LIGHT:
				_local_5.setTint(MenuConstants.COLOR_YELLOW, 1);
				break;
			case TINT_COLOR_COLOR_GREY_GOTY:
				_local_5.setTint(MenuConstants.COLOR_GREY, 1);
				break;
			case TINT_COLOR_MEDIUM_GREY_GOTY:
				_local_5.setTint(MenuConstants.COLOR_GREY_MEDIUM, 1);
				break;
			case TINT_COLOR_SUPER_LIGHT_GREY:
				_local_5.setTint(MenuConstants.COLOR_GREY_LIGHT, 1);
				break;
			case TINT_COLOR_GREYBG:
				_local_5.setTint(MenuConstants.COLOR_GREY_LIGHT, 1);
				break;
			case TINT_COLOR_YELLOW:
				_local_5.setTint(MenuConstants.COLOR_YELLOW, 1);
				break;
			case TINT_COLOR_YELLOW_LIGHT:
				_local_5.setTint(MenuConstants.COLOR_YELLOW, 1);
				break;
			case TINT_COLOR_MAGENTA_DARK:
				_local_5.setTint(MenuConstants.COLOR_RED, 1);
				break;
		}

		_arg_1.transform.colorTransform = _local_5;
		if (!_arg_3) {
			_arg_1.alpha = _local_4;
		}

	}

	public static function removeTint(_arg_1:Object):void {
		_arg_1.transform.colorTransform = new Color();
	}

	public static function setColor(_arg_1:DisplayObject, _arg_2:uint, _arg_3:Boolean = true, _arg_4:Number = 1):void {
		var _local_5:Number = _arg_1.alpha;
		var _local_6:ColorTransform = new ColorTransform();
		_local_6.color = _arg_2;
		_local_6.alphaMultiplier = ((_arg_3) ? _arg_4 : _local_5);
		_arg_1.transform.colorTransform = _local_6;
	}

	public static function removeColor(_arg_1:DisplayObject):void {
		_arg_1.transform.colorTransform = new ColorTransform();
	}

	public static function getRandomColor():uint {
		return (Math.random() * 0xFFFFFF);
	}

	public static function hexToMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number):Array {
		var _local_4:Array = [];
		_local_4 = _local_4.concat([(((_arg_1 & 0xFF0000) >>> 16) / 0xFF), 0, 0, 0, _arg_2]);
		_local_4 = _local_4.concat([0, (((_arg_1 & 0xFF00) >>> 8) / 0xFF), 0, 0, _arg_2]);
		_local_4 = _local_4.concat([0, 0, ((_arg_1 & 0xFF) / 0xFF), 0, _arg_2]);
		_local_4 = _local_4.concat([0, 0, 0, _arg_3, 0]);
		return (_local_4);
	}

	public static function addDropShadowFilter(_arg_1:*):void {
		var _local_2:TextField = (_arg_1 as TextField);
		if (((_local_2 == null) && (ControlsMain.isVrModeActive()))) {
			return;
		}

		_arg_1.filters = [new DropShadowFilter(2, 45, 0, 0.5, 2, 2, 1, 1)];
	}

	public static function removeDropShadowFilter(_arg_1:*):void {
		removeFilters(_arg_1);
	}

	public static function removeFilters(_arg_1:*):void {
		_arg_1.filters = [];
	}

	public static function addColorFilter(_arg_1:DisplayObjectContainer, _arg_2:Array):void {
		var _local_4:ColorMatrixFilter;
		if (((_arg_2.length > 0) && (ControlsMain.isVrModeActive()))) {
			return;
		}

		var _local_3:Array = [];
		var _local_5:int;
		while (_local_5 < _arg_2.length) {
			_local_4 = new ColorMatrixFilter(_arg_2[_local_5]);
			_local_3.push(_local_4);
			_local_5++;
		}

		_arg_1.filters = _local_3;
	}

	public static function setColorFilter(_arg_1:Sprite, _arg_2:String = ""):void {
		var _local_4:ColorMatrixFilter;
		var _local_5:ColorMatrixFilter;
		if (ControlsMain.isVrModeActive()) {
			return;
		}

		var _local_3:Array = [];
		switch (_arg_2) {
			case "selected":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DEFAULT);
				_local_3.push(_local_4);
				break;
			case "available":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DEFAULT);
				_local_3.push(_local_4);
				break;
			case "locked":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DEFAULT);
				_local_3.push(_local_4);
				break;
			case "masterylocked":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_4);
				break;
			case "shop":
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_5);
				break;
			case "download":
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_5);
				break;
			case "update":
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_5);
				break;
			case "downloading":
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_5);
				break;
			case "installing":
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_5);
				break;
			case "completed":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DEFAULT);
				_local_3.push(_local_4);
				break;
			case "notcompleted":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_4);
				break;
			case "objectivecompleted":
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_5);
				break;
			case "failed":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_4);
				break;
			case "desaturated":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DESATURATED);
				_local_3.push(_local_4);
				break;
			case "markedforremoval":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_BW);
				_local_3.push(_local_4);
				_local_5 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DARKENED);
				_local_3.push(_local_5);
				break;
			case "unknown":
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_NOT_OWNED);
				_local_3.push(_local_4);
				break;
			default:
				_local_4 = new ColorMatrixFilter(MenuConstants.COLOR_MATRIX_DEFAULT);
				_local_3.push(_local_4);
		}

		_arg_1.filters = _local_3;
	}

	public static function trySetCacheAsBitmap(_arg_1:DisplayObject, _arg_2:Boolean):void {
		if (_arg_1 == null) {
			return;
		}

		if (((_arg_2) && (ControlsMain.isVrModeActive()))) {
			_arg_2 = false;
		}

		_arg_1.cacheAsBitmap = _arg_2;
	}

	public static function formatNumber(_arg_1:Number, _arg_2:Boolean = true, _arg_3:uint = 0):String {
		var _local_9:String;
		if (((s_thousandsSeparator == null) || (!(s_thousandsSeparatorLocale == ControlsMain.getActiveLocale())))) {
			s_thousandsSeparator = Localization.get("UI_NUMBER_SEPARATOR_THOUSANDS");
			s_decimalSeparator = Localization.get("UI_NUMBER_SEPARATOR_DECIMALS");
			s_thousandsSeparatorLocale = ControlsMain.getActiveLocale();
		}

		var _local_4:int = s_thousandsSeparator.length;
		if (_local_4 < 1) {
			return (String(_arg_1));
		}

		var _local_5:* = (_arg_1 < 0);
		_arg_1 = ((_arg_1 < 0) ? -(_arg_1) : _arg_1);
		var _local_6:Number = _arg_1;
		_arg_1 = (_arg_1 >> 0);
		_local_6 = (_local_6 - _arg_1);
		var _local_7:String = String(_arg_1);
		var _local_8:Number = ((_local_7.length - 1) % 3);
		while (_local_8 < (_local_7.length - 1)) {
			_local_7 = ((_local_7.substr(0, (_local_8 + 1)) + s_thousandsSeparator) + _local_7.substr((_local_8 + 1)));
			_local_8 = (_local_8 + (3 + _local_4));
		}

		if (_arg_3 > 0) {
			_arg_3 = Math.min(20, _arg_3);
			_local_9 = _local_6.toFixed(_arg_3);
			_local_7 = ((_local_7 + s_decimalSeparator) + _local_9.substr(2));
		}

		_local_7 = ((_local_5) ? ("-" + _local_7) : _local_7);
		if (_arg_2) {
			_local_7 = (('<font face="$global">' + _local_7) + "</font>");
		}

		return (_local_7);
	}

	public static function getRandomInRange(_arg_1:Number, _arg_2:Number, _arg_3:Boolean = true):Number {
		if (!_arg_3) {
			return ((Math.random() * (_arg_2 - _arg_1)) + _arg_1);
		}

		return (Math.round(((Math.random() * (_arg_2 - _arg_1)) + _arg_1)));
	}

	public static function getRandomBoolean():Boolean {
		return (Math.random() >= 0.5);
	}

	public static function roundDecimal(_arg_1:Number, _arg_2:int):Number {
		var _local_3:Number = Math.pow(10, _arg_2);
		return (Math.round((_local_3 * _arg_1)) / _local_3);
	}

	public static function getPointsOnCircleEdge(_arg_1:Number, _arg_2:int, _arg_3:Number = 0):Array {
		var _local_5:Point;
		_arg_3 = toRadians(_arg_3);
		var _local_4:Array = [];
		var _local_6:int;
		while (_local_6 < _arg_2) {
			_local_4[_local_6] = Point.polar(_arg_1, ((((_local_6 / _arg_2) * PI) * 2) + _arg_3));
			_local_6++;
		}

		return (_local_4);
	}

	public static function toDegrees(_arg_1:Number):Number {
		return (actualRadians(_arg_1) * (180 / PI));
	}

	public static function toRadians(_arg_1:Number):Number {
		return (actualDegrees(_arg_1) * (PI / 180));
	}

	public static function actualDegrees(_arg_1:Number):Number {
		return (denominate(_arg_1, 360));
	}

	public static function actualRadians(_arg_1:Number):Number {
		return (denominate(_arg_1, (PI * 2)));
	}

	public static function denominate(_arg_1:Number, _arg_2:Number):Number {
		var _local_3:Number = _arg_1;
		while (_local_3 >= _arg_2) {
			_local_3 = (_local_3 - _arg_2);
		}

		while (_local_3 < -(_arg_2)) {
			_local_3 = (_local_3 + _arg_2);
		}

		return (_local_3);
	}

	public static function toPixel(_arg_1:Number):Number {
		return (MENU_METER_TO_PIXEL * _arg_1);
	}

	public static function shuffleArray(_arg_1:Array):Array {
		var _local_3:*;
		var _local_4:int;
		var _local_2:int = _arg_1.length;
		while (_local_2) {
			_local_4 = int(Math.floor((Math.random() * _local_2--)));
			_local_3 = _arg_1[_local_2];
			_arg_1[_local_2] = _arg_1[_local_4];
			_arg_1[_local_4] = _local_3;
		}

		return (_arg_1);
	}

	public static function createRefPointItem(lineLength:Number = 20, color:int = 0xFF00FF):Sprite {
		var s:Sprite = new Sprite();
		var _local_4:* = s;
		with (_local_4) {
			graphics.beginFill(color, 0.8);
			graphics.drawRect(0, 0, 10, 10);
			graphics.endFill();
			graphics.lineStyle(0.5, color);
			graphics.lineTo(lineLength, 0);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, lineLength);
		}

		return (s);
	}

	public static function highlitePulsate(clip:Sprite, start:Boolean):void {
		Animate.kill(clip);
		if (start) {
			clip.alpha = 0;
			Animate.delay(clip, 2, function ():void {
				highlitePulsateGo(clip, clip.scaleX, clip.scaleY);
			});
		}

	}

	private static function highlitePulsateGo(clip:Sprite, origScaleX:Number, origScaleY:Number):void {
		clip.alpha = 1;
		Animate.legacyTo(clip, 0.5, {
			"alpha": 0,
			"scaleX": (origScaleX + 0.2),
			"scaleY": (origScaleY + 0.2)
		}, Animate.SineInOut, function ():void {
			highlitePulsateDelay(clip, origScaleX, origScaleY);
		});
	}

	private static function highlitePulsateDelay(clip:Sprite, origScaleX:Number, origScaleY:Number):void {
		clip.scaleX = origScaleX;
		clip.scaleY = origScaleY;
		Animate.delay(clip, 2, function ():void {
			highlitePulsateGo(clip, clip.scaleX, clip.scaleY);
		});
	}

	public static function pulsate(_arg_1:Sprite, _arg_2:Boolean):void {
	}

	private static function pulsateFadeIn(_arg_1:Sprite):void {
		Animate.legacyTo(_arg_1, 2, {"alpha": 0.5}, Animate.SineInOut, pulsateFadeOut, _arg_1);
	}

	private static function pulsateFadeOut(_arg_1:Sprite):void {
		Animate.legacyTo(_arg_1, 2, {"alpha": 0}, Animate.SineInOut, pulsateFadeIn, _arg_1);
	}

	public static function getEaseType(_arg_1:String):int {
		var _local_2:int;
		switch (_arg_1) {
			case "Linear":
				_local_2 = Animate.Linear;
				break;
			case "SineIn":
				_local_2 = Animate.SineIn;
				break;
			case "SineOut":
				_local_2 = Animate.SineOut;
				break;
			case "SineInOut":
				_local_2 = Animate.SineInOut;
				break;
			case "ExpoIn":
				_local_2 = Animate.ExpoIn;
				break;
			case "ExpoOut":
				_local_2 = Animate.ExpoOut;
				break;
			case "ExpoInOut":
				_local_2 = Animate.ExpoInOut;
				break;
			case "BackIn":
				_local_2 = Animate.BackIn;
				break;
			case "BackOut":
				_local_2 = Animate.BackOut;
				break;
			case "BackInOut":
				_local_2 = Animate.BackInOut;
				break;
			default:
				_local_2 = Animate.Linear;
		}

		return (_local_2);
	}

	public static function isDataEqual(_arg_1:Object, _arg_2:Object):Boolean {
		var _local_3:int;
		var _local_4:int;
		var _local_5:String;
		var _local_6:int;
		var _local_7:String;
		if (((_arg_1 == null) || (_arg_2 == null))) {
			return (_arg_1 == _arg_2);
		}

		if (((_arg_1 is Number) && (_arg_2 is Number))) {
			return (_arg_1 == _arg_2);
		}

		if (((_arg_1 is Boolean) && (_arg_2 is Boolean))) {
			return (_arg_1 == _arg_2);
		}

		if (((_arg_1 is String) && (_arg_2 is String))) {
			return (_arg_1 == _arg_2);
		}

		if (((_arg_1 is Array) && (_arg_2 is Array))) {
			if (_arg_1.length == _arg_2.length) {
				_local_3 = 0;
				while (_local_3 < _arg_1.length) {
					if (!isDataEqual(_arg_1[_local_3], _arg_2[_local_3])) {
						return (false);
					}

					_local_3++;
				}

				return (true);
			}

			return (false);
		}

		if (((_arg_1 is Object) && (_arg_2 is Object))) {
			_local_4 = 0;
			for (_local_5 in _arg_1) {
				_local_4++;
				if (!isDataEqual(_arg_1[_local_5], _arg_2[_local_5])) {
					return (false);
				}

			}

			_local_6 = 0;
			for (_local_7 in _arg_2) {
				if (++_local_6 > _local_4) {
					return (false);
				}

			}

			return (_local_4 == _local_6);
		}

		return (false);
	}


}
}//package common.menu

