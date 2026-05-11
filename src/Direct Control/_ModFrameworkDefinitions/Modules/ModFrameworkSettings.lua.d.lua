---@meta

---Access to the Settings functions.
---@class ModFrameworkSettings
local Settings = {}

---Check if the settings menu is currently opened.
---@return boolean flag True if the settings menu is opened, false otherwise.
function Settings.IsSettingMenuOpen() end

---Check if the settings menu is currently opened for a given mod.
---@param name string The name of the mod to check for.
---@return boolean flag True if the settings menu for the given mod is opened, false otherwise.
function Settings.IsModsSettingsMenuOpen(name) end

---Register a boolean setting for the mod.
---
---Settings are stored per mod.
---Will override settings with the same name.
---@param settingsName string The name of the setting.
---@param default boolean The default value.
---@param description LocalizedString The description text shown in the mod settings menu.
function Settings.RegisterBooleanSetting(settingsName, default, description) end

---Update a boolean setting value for the mod.
---@param settingsName string The name of the setting.
---@param value boolean The value to be set.
function Settings.UpdateBooleanSetting(settingsName, value) end

---Get a boolean setting value for the mod.
---@param settingsName string The name of the setting.
---@return boolean? value The value of the setting if found, nil otherwise.
function Settings.GetBooleanSettingValue(settingsName) end

---Register a key bind setting for the mod.
---
---Settings are stored per mod.
---Will override settings with the same name.
---@param settingsName string The name of the setting.
---@param default number The default value.
---@param description LocalizedString The description text shown in the mod settings menu.
function Settings.RegisterKeyBindSetting(settingsName, default, description) end

---Get a key bind setting value for the mod.
---@param settingsName string The name of the setting.
---@return number? value The value of the setting if found, nil otherwise.
function Settings.GetKeyBindSettingValue(settingsName) end

---Update a bind setting setting value for the mod.
---@param settingsName string The name of the setting.
---@param value number The value to be set.
function Settings.UpdateKeyBindSetting(settingsName, value) end

return Settings
