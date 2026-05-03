
---@class ModRegistration Dataset containing the mod registration info.
---@field LoadOrderId number The load order id of the mod.
---@field ModName string The name of the mod, equal to the folder name of the mod.
---@field Path string The filepath to the mod folder.

---@class ModSettingData Dataset containing the settings data for a mod.
---@field ModName string The name of the mod that this data is for.
---@field SettingsData SettingData[] The data entries.

---@class SettingData Dataset containing a key value pair for a setting.
---@field SettingsName string The key name.
---@field SettingsValue boolean|number|string The value.

---@class ModSettingDataJson Dataset containing the json parsed settings data for a mod.
---@field ModName string? The name of the mod that this data is for.
---@field SettingsData SettingDataJson[]? The data entries.

---@class SettingDataJson Dataset containing the json parsed key value pair for a setting.
---@field SettingsName string? The key name.
---@field SettingsValue boolean|number|string|nil The value.

---@class ModDefaultSettingData Dataset containing the default settings data for a mod.
---@field ModName string The name of the mod that this data is for.
---@field DefaultSettingsData DefaultSettingData[] The data entries.

---@class DefaultSettingData Dataset containing a key value pair for a setting default value.
---@field SettingsName string The key name.
---@field SettingsValue boolean|number|string The value.
---@field SettingType "boolean"|"number"|"string" The data type for the setting