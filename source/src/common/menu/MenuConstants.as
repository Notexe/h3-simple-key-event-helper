// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.menu.MenuConstants

package common.menu {
public class MenuConstants {

	public static var BaseWidth:int = 1920;
	public static var BaseHeight:int = 1080;
	public static var GridUnitWidth:int = 176;
	public static var GridUnitHeight:int = 176;
	public static var MenuWidth:int = 1759;
	public static var MenuHeight:int = 967;
	public static var CollapsableContainerElementOffsetY:int = 2;
	public static var MenuTileScaleFactor:Number = 0.665;
	public static var MenuTileLargeScaleFactor:Number = 1.057;
	public static var MenuTileSmallScaleFactor:Number = 1.117;
	public static var ItemTileLargeScaleFactor:Number = 1.057;
	public static var ItemTileSmallScaleFactor:Number = 1.077;
	public static var TimeIndicatorScaleFactor:Number = 1.62;
	public static var ScrollingList_VR_ExtendWidth:Number = (MenuConstants.GridUnitWidth * 2);
	public static const DIFFICULTY_MODE_NORMAL:String = "normal";
	public static const DIFFICULTY_MODE_PRO1:String = "pro1";
	public static const PLAYERNAME_MIN_CHAR_COUNT:uint = 16;
	public static const PLAYER_MULTIPLAYER_DELIMITER:String = " & ";
	public static const SPLASH_HINT_TYPE_GLOBAL:int = 0;
	public static const SPLASH_HINT_TYPE_TUTORIAL:int = 1;
	public static const SPLASH_HINT_TYPE_CONTROLLER:int = 2;
	public static var MenuTileLargeWidth:int = 703;
	public static var MenuTileLargeHeight:int = 527;
	public static var MenuTileSmallWidth:int = 351;
	public static var MenuTileSmallHeight:int = 263;
	public static var MenuTileTallWidth:int = 351;
	public static var MenuTileTallHeight:int = 527;
	public static var ItemTileLargeWidth:int = 703;
	public static var ItemTileLargeHeight:int = 263;
	public static var ItemTileSmallWidth:int = 351;
	public static var ItemTileSmallHeight:int = 263;
	public static var ItemTileTallWidth:int = 351;
	public static var ItemTileTallHeight:int = 527;
	public static var ButtonTileWidth:int = 351;
	public static var ButtonTileHeight:int = 175;
	public static var ButtonTileLargeWidth:int = 351;
	public static var ButtonTileLargeHeight:int = 175;
	public static var MapInfoTileImageWidth:int = 373;
	public static var MapInfoTileImageHeight:int = 275;
	public static var HeadlineImageWidth:int = 345;
	public static var HeadlineImageHeight:int = 169;
	public static var CategoryElementWidth:int = 351;
	public static var CategoryElementHeight:int = 65;
	public static var CategoryTileWidth:int = 351;
	public static var CategoryTileHeight:int = 527;
	public static var DifficultySelectionTileImageWidth:int = 877;
	public static var DifficultySelectionTileImageHeight:int = 373;
	public static var MenuTileWidth:int = 406;
	public static var MenuTileHeight:int = 202;
	public static var MenuElementWidth:int = 406;
	public static var MenuElementHeight:int = 32;
	public static var ListElementLeaderboardWidth:int = 1055;
	public static var ListElementLeaderboardHeight:int = 65;
	public static var MessageContainerWidth:int = 1018;
	public static var MessageContainerHeight:int = 814;
	public static var redBottomWidth:int = 1920;
	public static var redBottomHeight:int = 123;
	public static var ValueIndicatorHeight:int = 63;
	public static var OptionsListElementSliderWidth:int = 170;
	public static var OptionsListElementSliderHeight:int = 10;
	public static var ElusiveContractsBriefingHeight:int = 900;
	public static const COLOR_MATRIX_DEFAULT:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_DESATURATED:Array = [0.464418, 0.383922, 0.05166, 0, -2.65, 0.194418, 0.653922, 0.05166, 0, -2.65, 0.194418, 0.383922, 0.32166, 0, -2.65, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_SATURATED:Array = [1.10371, -0.0914099999999999, -0.0123, 0, 35, -0.04629, 1.05859, -0.0123, 0, 35, -0.04629, -0.0914099999999999, 1.1377, 0, 35, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_DARKENED:Array = [0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_DARK:Array = [0.24, 0, 0, 0, 0, 0, 0.24, 0, 0, 0, 0, 0, 0.24, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_STENCIL:Array = [0.6, 1, 0.11, 0, 0, 0.6, 1, 0.11, 0, 0, 0.6, 1, 0.11, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_INVERTED:Array = [-1, 0, 0, 0, 0xFF, 0, -1, 0, 0, 0xFF, 0, 0, -1, 0, 0xFF, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_BW:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_BW_LOW_CONTRAST:Array = [0.13887, 0.27423, 0.0369, 0, 34.925, 0.13887, 0.27423, 0.0369, 0, 34.925, 0.13887, 0.27423, 0.0369, 0, 34.925, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_GRAYSCALE:Array = [0.5, 0.5, 0.5, 0, 0, 0.5, 0.5, 0.5, 0, 0, 0.5, 0.5, 0.5, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_RED:Array = [0.345098039215686, 0, 0, 0, 0, 0, 0.0509803921568627, 0, 0, 0, 0, 0, 0.0705882352941176, 0, 0, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_PRO1:Array = [0.1543, 0.3047, 0.041, 0, -8.25, 0.1543, 0.3047, 0.041, 0, -8.25, 0.1543, 0.3047, 0.041, 0, -8.25, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_DARKENED_DESATURATED:Array = [0.640472, 0.316888, 0.04264, 0, -5, 0.160472, 0.796888, 0.04264, 0, -5, 0.160472, 0.316888, 0.52264, 0, -5, 0, 0, 0, 1, 0];
	public static const COLOR_MATRIX_NOT_OWNED:Array = [0.13887, 0.27423, 0.0369, 0, 34.925, 0.13887, 0.27423, 0.0369, 0, 34.925, 0.13887, 0.27423, 0.0369, 0, 34.925, 0, 0, 0, 1, 0];
	public static var HiliteTime:Number = 0.1;
	public static var PressTime:Number = 0.05;
	public static var ScrollTime:Number = 0.3;
	public static var WheelScrollTime:Number = 0.1;
	public static var TabsHoverScrollTime:Number = 0.6;
	public static var ChallengeEdgeScrollTime:Number = 0.45;
	public static var SwipeOutTime:Number = 0.1;
	public static var SwipeInTime:Number = 0.3;
	public static var PageOpenTime:Number = 0.3;
	public static var PageCloseTime:Number = 0.1;
	public static var HeadlineElementXPos:Number = 80;
	public static var HeadlineElementYPos:Number = 804;
	public static const HistoryBarXPos:Number = 37;
	public static const HistoryBarYPos:Number = 48;
	public static const HistoryBarTextHeight:Number = 38;
	public static var TabsLineUpperYPos:int = 55;
	public static var TabsLineMidYPos:int = 89;
	public static var TabsLineLowerYPos:int = 155;
	public static var SimpleButtonTileScrollingListContainerHeight:int = 85;
	public static var SimpleButtonTileScrollingListContainerYPos:int = 700;
	public static var UserLineUpperYPos:int = 957;
	public static var UserLineLowerYPos:int = 0x0400;
	public static const TabsPromptsXOffset:int = 10;
	public static var TabsPromptsYOffset:int = -39;
	public static var TabsBgOffsetYPos:int = 33;
	public static var ProfileElementXPos:int = (MenuConstants.BaseWidth - ((MenuConstants.MenuTileSmallWidth + 2) + MenuConstants.menuXOffset));
	public static var ProfileElementYPos:int = (MenuConstants.ButtonPromptsYPos + 15);
	public static var MultiplayerElementXPos:int = (MenuConstants.ProfileElementXPos - (MenuConstants.MenuTileSmallWidth + 2));
	public static var MultiplayerElementYPos:int = MenuConstants.ProfileElementYPos;
	public static var ButtonPromptsYPos:int = 958;
	public static const ButtonPromptsXOffset:int = 30;
	public static var ValueIndicatorYOffset:int = 132;
	public static var OverrideValueIndicatorYOffset:int = 69;
	public static var NewIndicatorYOffset:int = 28;
	public static var InPlaylistIndicatorOffset:int = 28;
	public static var VRIndicatorXOffset:int = 36;
	public static var VRIndicatorYOffset:int = 36;
	public static const VRNotebookMapZOffset:Number = 50;
	public static const ItemCountIndicatorYOffset:int = 20;
	public static const ItemCountIndicatorXOffset:int = 28;
	public static var TimeIndicatorHeaderYOffset:int = -20;
	public static var MenuElementRootRow:Number = 1;
	public static var MenuElementRootCol:Number = 0;
	public static var MenuElementRootNRow:Number = 3;
	public static var MenuElementRootNCol:Number = 10;
	public static var MenuElementRootMaskPad:int = 20;
	public static var MenuElementRootPivotBottomOffset:int = 0;
	public static var tileGap:int = 1;
	public static var tileBorder:int = 0;
	public static var tileImageBorder:int = 5;
	public static var dialsGap:int = 24;
	public static var menuXOffset:int = 80;
	public static var menuYOffset:int = 56;
	public static var categoryYOffset:int = 83;
	public static var headerXOffset:int = 28;
	public static var tileIconXOffset:int = 32;
	public static var escalationLevelIconXOffset:int = 59;
	public static var outbreakLevelIconXOffset:int = 59;
	public static var perksIconXOffset:int = 59;
	public static var perksIconYOffset:int = 37;
	public static var verticalScrollGapLeft:int = 0;
	public static var verticalScrollGapRight:int = 26;
	public static const MODAL_CONTENT_SPACE_Y:int = 10;
	public static const MenuElementBackgroundAlpha:Number = 0.5;
	public static const MenuElementSelectedAlpha:Number = 1;
	public static const MenuElementDeselectedAlpha:Number = 0.5;
	public static const MenuFrameEndScreenBackgroundAlpha:Number = 0.8;
	public static const COLOR_WHITE:int = 0xFFFFFF;
	public static const COLOR_GREY_ULTRA_LIGHT:int = 0xEBEBEB;
	public static const COLOR_GREY_LIGHT:int = 0xD2D2D2;
	public static const COLOR_GREY:int = 0xBDBDBD;
	public static const COLOR_GREY_MEDIUM:int = 0x929292;
	public static const COLOR_GREY_DARK:int = 0x464646;
	public static const COLOR_GREY_ULTRA_DARK:int = 0x212121;
	public static const COLOR_BLACK:int = 0;
	public static const COLOR_RED:int = 0xFA000E;
	public static const COLOR_YELLOW:int = 0xFFC900;
	public static const COLOR_TURQUOISE:int = 65487;
	public static const COLOR_GREEN:int = 4325197;
	public static const COLOR_BLUE:int = 2168555;
	public static const COLOR_PURPLE:int = 0x7F007F;
	public static const COLOR_DARK_RED:int = 0x1F0000;
	public static const COLOR_MENU_TABS_BACKGROUND:int = 2305594;
	public static const COLOR_MENU_SOLID_BACKGROUND:int = 2961464;
	public static const COLOR_MENU_BUTTON_TILE_DESELECTED:int = 1054236;
	public static const COLOR_MENU_CONTRACT_SEARCH_GREY:int = 5527389;
	public static const COLOR_END_SCREEN_BACKGROUND:int = 1647147;
	public static const COLOR_COMMON:int = 10724518;
	public static const COLOR_UNCOMMON:int = 4225610;
	public static const COLOR_RARE:int = 7049389;
	public static const COLOR_LEGENDARY:int = 6440820;
	public static var FontColorWhite:String = ColorString(COLOR_WHITE);
	public static var FontColorGreyUltraLight:String = ColorString(COLOR_GREY_ULTRA_LIGHT);
	public static var FontColorGreyLight:String = ColorString(COLOR_GREY_LIGHT);
	public static var FontColorGrey:String = ColorString(COLOR_GREY);
	public static var FontColorGreyMedium:String = ColorString(COLOR_GREY_MEDIUM);
	public static var FontColorGreyDark:String = ColorString(COLOR_GREY_DARK);
	public static var FontColorGreyUltraDark:String = ColorString(COLOR_GREY_ULTRA_DARK);
	public static var FontColorBlack:String = ColorString(COLOR_BLACK);
	public static var FontColorRed:String = ColorString(COLOR_RED);
	public static var FontColorYellow:String = ColorString(COLOR_YELLOW);
	public static var FontColorTurquoise:String = ColorString(COLOR_TURQUOISE);
	public static var FontColorGreen:String = ColorString(COLOR_GREEN);
	public static var FontColorBlue:String = ColorString(COLOR_BLUE);
	public static var FontColorPurple:String = ColorString(COLOR_PURPLE);
	public static const FONT_TYPE_LIGHT:String = "$light";
	public static const FONT_TYPE_NORMAL:String = "$normal";
	public static const FONT_TYPE_MEDIUM:String = "$medium";
	public static const FONT_TYPE_BOLD:String = "$bold";
	public static const FONT_TYPE_GLOBAL:String = "$global";
	public static const INTERACTIONPROMPTSIZE_SMALL:int = 10;
	public static const INTERACTIONPROMPTSIZE_MEDIUM:int = 15;
	public static const INTERACTIONPROMPTSIZE_LARGE:int = 20;
	public static const INTERACTIONPROMPTSIZE_XLARGE:int = 25;
	public static const INTERACTIONPROMPTSIZE_XXLARGE:int = 30;
	public static const INTERACTIONPROMPTSIZE_XXXLARGE:int = 35;
	public static const INTERACTIONPROMPTSIZE_DEFAULT:int = INTERACTIONPROMPTSIZE_SMALL;//10
	public static const INTERACTIONPROMPTSIZE_FORCEDONSMALLDISPLAY:int = INTERACTIONPROMPTSIZE_LARGE;//20
	public static const InteractionIndicatorFontSpecs:Array = [];
	public static const KEYCODE_ENTER:uint = 13;
	public static const KEYCODE_ESC:uint = 27;
	public static const KEYCODE_TAB:uint = 9;
	public static const KEYCODE_F1:uint = 112;
	public static const KEYCODE_RIGHT:uint = 39;
	public static const KEYCODE_DOWN:uint = 40;
	public static const KEYCODE_A:uint = 65;

	{
		InteractionIndicatorFontSpecs[INTERACTIONPROMPTSIZE_SMALL] = {
			"fontSizeLabel": 14,
			"fontSizeDesc": 11,
			"yOffsetLabelSolo": -10,
			"yOffsetLabel": -16,
			"yOffsetDesc": -1,
			"fScaleIndividual": 1,
			"fScaleGroup": 1
		};
		InteractionIndicatorFontSpecs[INTERACTIONPROMPTSIZE_MEDIUM] = {
			"fontSizeLabel": 14,
			"fontSizeDesc": 14,
			"yOffsetLabelSolo": -10,
			"yOffsetLabel": -18,
			"yOffsetDesc": -3,
			"fScaleIndividual": 1,
			"fScaleGroup": 1
		};
		InteractionIndicatorFontSpecs[INTERACTIONPROMPTSIZE_LARGE] = {
			"fontSizeLabel": 18,
			"fontSizeDesc": 18,
			"yOffsetLabelSolo": -13,
			"yOffsetLabel": -22,
			"yOffsetDesc": -3,
			"fScaleIndividual": 1,
			"fScaleGroup": 1
		};
		InteractionIndicatorFontSpecs[INTERACTIONPROMPTSIZE_XLARGE] = {
			"fontSizeLabel": 18,
			"fontSizeDesc": 18,
			"yOffsetLabelSolo": -13,
			"yOffsetLabel": -22,
			"yOffsetDesc": -3,
			"fScaleIndividual": 1.1,
			"fScaleGroup": 1.15
		};
		InteractionIndicatorFontSpecs[INTERACTIONPROMPTSIZE_XXLARGE] = {
			"fontSizeLabel": 18,
			"fontSizeDesc": 18,
			"yOffsetLabelSolo": -13,
			"yOffsetLabel": -22,
			"yOffsetDesc": -3,
			"fScaleIndividual": 1.25,
			"fScaleGroup": 1.3
		};
		InteractionIndicatorFontSpecs[INTERACTIONPROMPTSIZE_XXXLARGE] = {
			"fontSizeLabel": 18,
			"fontSizeDesc": 18,
			"yOffsetLabelSolo": -13,
			"yOffsetLabel": -22,
			"yOffsetDesc": -3,
			"fScaleIndividual": 1.35,
			"fScaleGroup": 1.4
		};
	}


	public static function StringToDifficultyConst(_arg_1:String):String {
		if (_arg_1.toLowerCase() == DIFFICULTY_MODE_PRO1) {
			return (DIFFICULTY_MODE_PRO1);
		}

		return (DIFFICULTY_MODE_NORMAL);
	}

	public static function ColorString(_arg_1:int):String {
		return ("#" + _arg_1.toString(16));
	}

	public static function ColorNumber(_arg_1:String):int {
		return (int(("0x" + _arg_1.substr(1))));
	}

	public static function GetColorByName(_arg_1:String):int {
		if (_arg_1 == "black") {
			return (COLOR_BLACK);
		}

		if (_arg_1 == "red") {
			return (COLOR_RED);
		}

		if (_arg_1 == "yellow") {
			return (COLOR_YELLOW);
		}

		if (_arg_1 == "turquoise") {
			return (COLOR_TURQUOISE);
		}

		if (_arg_1 == "green") {
			return (COLOR_GREEN);
		}

		if (_arg_1 == "blue") {
			return (COLOR_BLUE);
		}

		if (_arg_1 == "purple") {
			return (COLOR_PURPLE);
		}

		return (COLOR_WHITE);
	}


}
}//package common.menu

