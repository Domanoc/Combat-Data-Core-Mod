---@meta

---Access to the Settings functions.
---@class ModFrameworkSettings
local Settings = {}

---Register a boolean setting for the mod.
---
---Settings are stored per mod.
---Will override settings with the same name.
---@param settingsName string The name of the setting.
---@param default boolean The default value.
function Settings.RegisterBooleanSetting(settingsName, default) end

---comment
---@param settingsName string The name of the setting.
---@param value boolean The value to be set.
function Settings.UpdateBooleanSetting(settingsName, value) end

return Settings
