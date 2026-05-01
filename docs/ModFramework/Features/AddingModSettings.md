# ModFramework - Adding mod settings
#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_database.lua" in the create function.

## Code example
```lua
--load the mod framework as a global for use within this file
Mod = GetModFramework()

--An example for creating mod settings.
--Settings need to be registered before they can be used.
--The mod should expect that the setting value can change during runtime.
--Settings can be changed by the user in the mod settings menu, and the defaults can be overridden by the user.
Mod.Settings.RegisterBooleanSetting("example_setting_a", false, { LocalizedDefaultValue = "Descriptionfor Setting A" })
Mod.Settings.RegisterBooleanSetting("example_setting_b", true, { LocalizedDefaultValue = "Descriptionfor Setting B" })
Mod.Settings.RegisterBooleanSetting("example_setting_c", false, { LocalizedDefaultValue = "Descriptionfor Setting C" })
Mod.Settings.RegisterBooleanSetting("example_setting_d", true, { LocalizedDefaultValue = "Descriptionfor Setting D" })
```

## Use case example

use in "obj_database.lua" in the draw_top_menu function.

```lua
---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	--The value of a setting can be retrieved like this
	local example_setting_a_value = Mod.Settings.GetBooleanSettingValue("example_setting_a")
	--We can then for example use it to toggle a feature
	if (example_setting_a_value == true) then
		--We can for example show some debug information when toggled.
		Mod.Common.DrawDebugCursor({{ Label = "Show the setting value", Value = example_setting_a_value }})
	end
end
```

## Notes
This has [localization](../Localization.md) support.


---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
