# Simple Key Event Helper

Adds a helper entitytemplate for developers who wish to add custom key bindings into their mod.

[Install](https://hitman-resources.netlify.app/smf-install-link/https://github.com/Notexe/h3-simple-key-event-helper/releases/latest/download/mod.framework.zip) | [Download](https://github.com/Notexe/h3-simple-key-event-helper/releases/latest/download/mod.framework.zip)

---

## Usage

This helper mod allows you to setup custom keybinds which you can then use to fire pins in your mod. Please reference this mod in the "requirements" section in your mod's manifest like so:

```json
"requirements": [
  "Notex.SimpleKeyEventHelper"
]
```

There are two methods of using this mod:

1. First method: With this method you can just use the `m_sModifierKeyName` and `m_sKeyName` properties in the `SimpleKeyEventHelper` entity to configure the keybind.
2. Second method: This method involves using a dynamic object entity referenced in a property called `m_pDataProvider` in the `SimpleKeyEventHelper` entity. The second method can be used if you wish to provide customisability options in your SMF mod without having to use duplicated entity.json or entity.patch.json files.

### First method

SimpleKeyEventHelper entity:

```json
{
	"parent": null,
	"name": "SimpleKeyEventHelper",
	"factory": "[assembly:/Templates/UI/Controls/simplekeyeventhelper.template?/SimpleKeyEventHelper.entitytemplate].pc_entitytype",
	"blueprint": "[assembly:/Templates/UI/Controls/simplekeyeventhelper.template?/SimpleKeyEventHelper.entitytemplate].pc_entityblueprint",
	"properties": {
		"m_sModifierKeyName": {
			"type": "ZString",
			"value": "None"
		},
		"m_sKeyName": {
			"type": "ZString",
			"value": "F7"
		}
	},
	"events": {
		"Pressed": {},
		"Down": {},
		"Up": {}
	}
}
```

### Second method

SimpleKeyEventHelper entity:

```json
{
	"parent": null,
	"name": "SimpleKeyEventHelper",
	"factory": "[assembly:/Templates/UI/Controls/simplekeyeventhelper.template?/SimpleKeyEventHelper.entitytemplate].pc_entitytype",
	"blueprint": "[assembly:/Templates/UI/Controls/simplekeyeventhelper.template?/SimpleKeyEventHelper.entitytemplate].pc_entityblueprint",
	"properties": {
		"m_pDataProvider": {
			"type": "SEntityTemplateReference",
			"value": "cafe4e160a2ca171"
		}
	},
	"events": {
		"Pressed": {},
		"Down": {},
		"Up": {}
	}
}
```

Dynamic Object entity:

```json
{
	"parent": "cafe22132fb215d4",
	"name": "DynamicObject",
	"factory": "[modules:/zdynamicobjectentity.class].pc_entitytype",
	"blueprint": "[modules:/zdynamicobjectentity.class].pc_entityblueprint",
	"properties": {
		"m_pJSONResource": {
			"type": "ZRuntimeResourceID",
			"value": "[assembly:/your/path/here.json].pc_json"
		}
	}
}
```

JSON file:

```json
{
	"modifier": "None", // Possible options are: None, Alt and Control
	"key": "F2" // Possible values can be found here (ones with uint not string. "Example: F2 : uint = 113"): https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/ui/Keyboard.html
}
```

### Properties and pins

#### Properties

-   `m_bEnabled`: bool (defaults to true)
-   `m_sModifierKeyName`: ZString (defaults to None)
-   `m_sKeyName`: ZString (defaults to empty)
-   `m_pDataProvider`: SEntityTemplateReference (defaults to null)

See JSON example above for possible m_sModifierKeyName and m_sKeyName values

#### Input pins

-   `Enable`: void (Enables keybinds)
-   `Disable`: void (Disables keybinds)

#### Output pins

-   `Pressed`: void (Fires on key pressed down and repeats if held for over a second)
-   `Down`: void (Fires on key pressed down)
-   `Up`: void (Fires on key released)
