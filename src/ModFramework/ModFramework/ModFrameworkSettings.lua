------------------------------------------------------------------------------
--- SETTINGS FUNCTIONS -------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Settings functions.
---@type ModFrameworkSettings
local Settings = {}

---Access to the private functions in this file.
---@class ModFrameworkSettingsPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Register a boolean setting for the mod.
---
---Settings are stored per mod.
---Will override settings with the same name.
---@param settingsName string The name of the setting
---@param default boolean The default value
function Settings.RegisterBooleanSetting(settingsName, default)
	local modName = Common.GetModName()
	local defaults = Private.GetModDefaultSettings(modName)

	if (defaults == nil) then
		---@type ModDefaultSettingData
		local newDefaults = {
			ModName = modName,
			DefaultSettingsData = {
				{ SettingsName = settingsName, SettingsValue = default, SettingType = "boolean" }
			}
		}
		table.insert(Storage.ModDefaultData, newDefaults)
		return
	end

	for _, setting in ipairs(defaults.DefaultSettingsData) do
		if (setting.SettingsName == settingsName) then
			setting.SettingsValue = default
			setting.SettingType = "boolean"
			return
		end
	end

	---@type DefaultSettingData
	local newDefault = {
		SettingsName = settingsName,
		SettingsValue = default,
		SettingType = "boolean"
	}
	table.insert(defaults.DefaultSettingsData, newDefault)
end

---Gets the mod default settings
---@param modName string The mod name to look for.
---@return ModDefaultSettingData? value The value if found, nil otherwise.
function Private.GetModDefaultSettings(modName)
	for _, value in ipairs(Storage.ModDefaultData) do
		if (value.ModName == modName) then
			return value
		end
	end

	return nil
end

------------------------------------------------------------------------------
--- EXPORT SETTINGS ----------------------------------------------------------
------------------------------------------------------------------------------

return Settings