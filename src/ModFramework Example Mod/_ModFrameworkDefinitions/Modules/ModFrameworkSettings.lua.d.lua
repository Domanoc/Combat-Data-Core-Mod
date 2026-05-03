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

---Update a boolean setting value for the mod.
---@param settingsName string The name of the setting.
---@param value boolean The value to be set.
function Settings.UpdateBooleanSetting(settingsName, value) end

---Get a boolean setting value for the mod.
---@param settingsName string The name of the setting.
---@return boolean value The value of the setting
function Settings.GetBooleanSettingValue(settingsName) end

return Settings
