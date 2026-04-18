# ModFramework - Localization

#### [Back to overview](../Overview.md)
---

The ModFramework allows the mod to support localization for the users. 
- The localization is integrated in the games language selection.
- And there is support for localization mods

## How does it work
The ModFramework looks for the current set language file by the game. Then when it processes a localization string it will try and match it with a language file in the current mods localization folder. If it cannot find the file or value it will fallback to the default value in code.

#### Example:
The "ModFramework Example Mod" adds a weapon, weapons have a localized string value for the weapon description.

While adding the weapon this localized string value is passed like this.   
**Note:** Other localized string can always be recognized by the "LocalizedDefaultValue" param
```lua
Description = {
    LocalizedDefaultValue = "Description text for this weapon."
},
```

When the framework adds the weapon to the game it will check the folder "..\ModFramework Example Mod\localization\" for a language file that matches the current language setting of the game. in our example its will be "loc_english.ini"   
**Note:** If the game localization where set to another language we would look for a localization file in our mod with the same name as the setting

In the mods localization file it will look up the value. For our example we find the following in the file.
```
[WeaponDescription]
example_weapon="Description text for this weapon."
```
- [WeaponDescription] explains that the values will be for weapon description
- example_weapon references to the weapon reference name that was given
- "Description text for this weapon." is the value for the this language

Since we have a localization file with the value we where looking for the framework will take this value an use it in the game.

## How to implement localization
When making a mod using the ModFramework we can generate the needed localization files. Its recommended to do this as a last step of development.

In your mods "obj_database.lua" add the following to the create function.
```lua
function create(q,v_modid)
	Mod = require("ModFrameworkModule")
	Mod.Common.GenerateLocalizationFiles()
    --other code
end
```

This will flag the framework to generate the needed localization files. This flag needs to be set before any items are added by the framework. else they are skipped.

After adding the code, start the game with a new save with a your mod and the ModFramework in the load order. At start a message will popup to show you localization files are generated.   
**Note:** Its recommended to start a new save to allow all the code to run. Else code that is skipped on loaded saves might cause the generation to miss records.

After the game is loaded, go to the folder "..\%YourModHere%\localization\" and you will find the generated files. The files are populated with the default values provided by your mod.

After this you can remove the added code to stop the generation.

Now you can edit the generated files with the correct translations.

### Auto generated files
The "GenerateLocalizationFiles" feature will generate the following files:
- loc_english.ini
- loc_french.ini
- loc_german.ini
- loc_polish.ini
- loc_portuguese_brazil.ini
- loc_russian.ini
- loc_spanish.ini
- loc_chinese.ini
    - There is an official chinese translation file and a modded "chs.ini" both targeting the same language. The framework will reroute both to use the generated "loc_chinese.ini"
- loc_italian.ini
    - part of the "Italian Translation mod"
- japanese.ini
    - part of the "Japanese Translation mod"

## How to update localization
When you already have localization files but you added new items you can add the "GenerateLocalizationFiles" function to the code again. The files will not be overridden, the missing values will be appended. Any values that are no longer in use need to be manually deleted by the mod creator.

## What happens if the mod localization files are missing
The ModFramework will fallback on the default value given

### Example:
When adding a weapon the default value is the the value provided here. It is recommended to provide this value in english for code readability.
```lua
Description = {
    LocalizedDefaultValue = "Description text for this weapon."
},
```

## Translation automation
Since most of us aren't proficient in 10+ languages, we will rely on machine translations. To do this a google sheets helper is created. [Link](https://docs.google.com/spreadsheets/d/13wb9_rPZf27vFe1PY_t9NN6-AvjeLWDUAeQIDTYuZnY/copy)

- To use it copy the "loc_english.ini" contents to Cell A2.
- Set the output language using the dropdown.
- Copy all the result rows.
- Past in the localization file that you are targeting.

If you are using machine translation is best to mention it to the users.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)