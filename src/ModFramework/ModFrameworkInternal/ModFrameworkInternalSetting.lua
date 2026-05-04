------------------------------------------------------------------------------
--- INTERNAL SETTINGS FUNCTIONS ----------------------------------------------
------------------------------------------------------------------------------

---Access to the internal functions for the Settings.
---@class ModFrameworkInternalSave
local InternalSettings = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalSavePrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the json converter
local lunaJson = require("lunajson")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Settings functions.
local Settings = require("ModFrameworkSettings")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

InternalSettings.RegisterBooleanSetting = Settings.RegisterBooleanSetting
InternalSettings.UpdateBooleanSetting = Settings.UpdateBooleanSetting
InternalSettings.GetBooleanSettingValue = Settings.GetBooleanSettingValue

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Adds the mod setting data to the save file
function InternalSettings.SaveData()
	local obj_content_hangar = Common.GetObjContentHanger()
	local json = lunaJson.encode(Storage.ModSettingData)
	ds_grid_set(obj_content_hangar.data_map_level, 0, 0, json)
end

---Loads the mod setting data from the save file back into storage
function InternalSettings.LoadData()
	local obj_content_hangar = Common.GetObjContentHanger()
	local json = ds_grid_get(obj_content_hangar.data_map_level, 0, 0)
	local ok, jsonData = pcall(lunaJson.decode, json)
	if not ok then
		--We cannot parse the data so we will parse an empty set
		jsonData = {}
	end

	---@cast jsonData JsonModSettingData[]
	Private.ParseModSettingData(jsonData)
end

---Parse the json data and set a valid dataset to storage.
---The result will be a mix of valid json data and the default values if needed.
---@param jsonData JsonModSettingData[] The Json data that gets parsed.
function Private.ParseModSettingData(jsonData)
	---@type ModSettingData[]
	local parsedData = {}

	for _, defaults in ipairs(Storage.ModDefaultData) do
		local modName = defaults.ModName
		---@type ModSettingData
		local parsedModSetting = {
			ModName = modName,
			SettingsData = {}
		}

		local modData = Private.FindModInJsonData(modName, jsonData)
		if (modData ~= nil) then
			--When we find json data we apply the parsed data
			local parsedSettings = Private.ParseSettingDataJson(modData.SettingsData, defaults.DefaultSettingsData)
			parsedModSetting.SettingsData = parsedSettings
		else
			--When there is no json data we create a copy of the default values
			for _, default in ipairs(defaults.DefaultSettingsData) do
				---@type SettingData
				local setting = {
					SettingsName = default.SettingsName,
					SettingsValue = default.SettingsValue
				}
				table.insert(parsedModSetting.SettingsData, setting)
			end
		end

		--Add the setting to the return
		table.insert(parsedData, parsedModSetting)
	end

	Storage.ModSettingData = parsedData
end

---Parse the json setting data and return a valid setting dataset.
---@param jsonData JsonSettingData[] The Json data that gets parsed.
---@param defaults DefaultSettingData[] The default setting values.
---@return SettingData[] parsedData The parsed data for the settings, has the values from the json when valid, the defaults otherwise.
function Private.ParseSettingDataJson(jsonData, defaults)
	---@type SettingData[]
	local parsedData = {}

	for _, default in ipairs(defaults) do
		local settingName = default.SettingsName
		---@type SettingData
		local parsedSetting = {
			SettingsName = settingName,
			SettingsValue = default.SettingsValue
		}

		local jsonSetting = Private.FindSettingInJsonData(settingName, jsonData, default)
		if (jsonSetting ~= nil) then
			--A valid value was found so override the default value
			parsedSetting.SettingsValue = jsonSetting.SettingsValue
		end

		--Add the setting to the return
		table.insert(parsedData, parsedSetting)
	end

	--Return the updated defaults
	return parsedData
end

---Finds the settings data by mod name in the json data.
---@param name string The name of the mod.
---@param jsonData JsonModSettingData[] The json data that will be searched.
---@return JsonModSettingData? value The value if found, nil otherwise.
function Private.FindModInJsonData(name, jsonData)
	for _, value in ipairs(jsonData) do
		if (value.ModName == name) then
			return value
		end
	end
	return nil
end

---Finds the setting by name in the json data.
---@param name string The name of the setting.
---@param jsonData JsonSettingData[] The json data that will be searched.
---@param default DefaultSettingData The default data to compare against.
---@return SettingData? value The value if found, nil otherwise.
function Private.FindSettingInJsonData(name, jsonData, default)
	for _, jsonValue in ipairs(jsonData) do
		--TODO: Check if value is in an allowed range
		if (jsonValue.SettingsName == name and
			jsonValue.SettingsValue ~= nil and
			type(jsonValue.SettingsValue) == default.SettingType) then

			---@type SettingData SettingData
			local value = {
				SettingsName = jsonValue.SettingsName,
				SettingsValue = jsonValue.SettingsValue
			}
			return value
		end
	end
	return nil
end

------------------------------------------------------------------------------
--- SETTINGS MENU ------------------------------------------------------------
------------------------------------------------------------------------------

---Loads the needed menu sprites, so we can draw the settings menu.
---
---Used in the create function of obj_database.lua
function InternalSettings.LoadMenuSprites()
	local modPath = Common.GetModPathByName("ModFramework")
	Storage.SpriteSettingsMenu = Common.AddSprite(modPath.."sprites\\ModFrameworkMenu.png", 1, false, false, 0, 0)
	Storage.SpriteSettingsMenuBackground = Common.AddSprite(modPath.."sprites\\ModFrameworkSettingsMenuBackground.png", 1, false, false, 0, 0)
	Storage.SpriteSettingsMenuLabel = Common.AddSprite(modPath.."sprites\\Label.png", 3, false, false, 0, 0)
	Storage.SpriteSettingsMenuButton = asset_get_index("spr_button_medium")
	Storage.SpriteSettingsMenuSwitch = asset_get_index("spr_circuits_switcher")

	Storage.SettingsMenuTitleText = Common.GetLocalizedString("SettingsMenu", "SettingsMenu", { LocalizedDefaultValue = "MODFRAMEWORK MENU" })
end

---Draws the settings menu and buttons.
function InternalSettings.DrawMenu()
	local modSettingCount = #Storage.ModSettingData
	if (modSettingCount < 1) then
		return
	end

	local obj_button_engineering = Common.GetObjButtonEngineering()
	local game_obj_big_holder = Common.GetObjBigHolder()

	if (obj_button_engineering.activated == true and
		game_obj_big_holder.cur_item == 0) then

		Private.DrawButtonMenu()
		Private.DrawOpenMenuButton()

		Private.DrawSettingsMenu()
	else
		Storage.IsSettingsMenuOpen = false
	end
end

---Draws the menu and title for the settings menu button.
function Private.DrawButtonMenu()
	local menuX = 1434
	local menuY = 160
	local textOffsetX = 170
	local textOffsetY = 18

	draw_sprite_ext(Storage.SpriteSettingsMenu, 0, menuX, menuY, 2, 2, 0, 16777215, 1)

	draw_set_color(make_colour_rgb(218, 172, 57))
	draw_set_halign(1)
	draw_text_transformed(menuX + textOffsetX, menuY + textOffsetY, Storage.SettingsMenuTitleText, 2, 2, 0)
end

---Draws the settings menu button.
function Private.DrawOpenMenuButton()
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local sprite = Storage.SpriteSettingsMenuButton
	local buttonX = 1572
	local buttonY = 224
	local buttonWidth = 54
	local buttonHeight = 34
	local subImage = 0

	if (Storage.IsSettingsMenuOpen == true) then
		subImage = 3
	end

	if (mx > buttonX and
		mx < (buttonX + buttonWidth) and
		my > buttonY and
		my < (buttonY + buttonHeight)) then
		if (Storage.IsSettingsMenuOpen == false) then
			subImage = subImage + 1
		end

		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			Storage.IsSettingsMenuOpen = not Storage.IsSettingsMenuOpen
			subImage = subImage + 1
		end
	end

	draw_sprite_ext(sprite, subImage, buttonX, buttonY, 2, 2, 0, 16777215, 1)
end

---comment
function Private.DrawSettingsMenu()
	if (Storage.IsSettingsMenuOpen == false) then
		return
	end
	local modSettingCount = #Storage.ModSettingData
	if (modSettingCount < 1) then
		return
	end

	local SelectedModSettings = Storage.ModSettingData[Storage.CurrentSettingsMenuIndex]
	local titleY = 224
	local pageButtonsY = 231
	local startSettingsY = 284
	local settingsHeight = 45

	--Draw the background
	draw_sprite_ext(Storage.SpriteSettingsMenuBackground, 0, 574, 210, 2, 2, 0, 16777215, 1)

	if (modSettingCount > 1) then
		Private.DrawButton(Storage.SpriteShopButtonLeft, 588, pageButtonsY, Private.PreviousMod)
		Private.DrawButton(Storage.SpriteShopButtonRight, 618, pageButtonsY, Private.NextMod)
	end
	Private.DrawLabel(650, titleY, SelectedModSettings.ModName, 29)

	local i = 0
	for _, setting in ipairs(SelectedModSettings.SettingsData) do
		local y = startSettingsY + (i * settingsHeight)
		if (type(setting.SettingsValue) == "boolean") then
			Private.AddBooleanSetting(y, setting)
		end
		i = i + 1
	end
end

---Add a boolean setting to the settings menu.
---@param startY number The starting y position.
---@param setting SettingData The boolean setting that is added.
function Private.AddBooleanSetting(startY, setting)
	local startX = 614
	local switchOffsetY = 18
	local subImage = 0
	if setting.SettingsValue == false then
		subImage = 1
	end

	draw_sprite_ext(Storage.SpriteSettingsMenuSwitch, subImage, startX, startY + switchOffsetY, 2, 2, 0, 16777215, 1)

	local switchWidth = 36
	local LabelX = startX + switchWidth
	Private.DrawLabel(LabelX, startY, setting.SettingsName, 29)
	Private.BooleanButtonHandler(startX, startY, setting)
end

---Handles the boolean button operation for the setting.
---@param startX number The starting x position.
---@param startY number The starting y position.
---@param setting SettingData The boolean setting that is set by the button.
function Private.BooleanButtonHandler(startX, startY, setting)
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local buttonOffsetX = 34
	local buttonWidth = 64
	local buttonHeight = 36
	local buttonMinX = startX - buttonOffsetX
	local buttonMaxX = startX + buttonWidth - buttonOffsetX
	local buttonMinY = startY
	local buttonMaxY = startY + buttonHeight

	if (mx > buttonMinX and
		mx < buttonMaxX and
		my > buttonMinY and
		my < buttonMaxY) then
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			setting.SettingsValue = not setting.SettingsValue
		end
	end
end

---Draws a settings label
---@param startX number The starting x position.
---@param startY number The starting y position.
---@param label string The label text to draw.
---@param maxSegments number The max amount of segments to use.
---@return number endX The ending position for x.
function Private.DrawLabel(startX, startY, label, maxSegments)
	local textOffsetY = 4
	local subImage = 0
	local textWidth = string_width(label) * 2 --2x scaling
	local padding = 24
	local segmentWidth = 24
	local segmentAmount = math.ceil((textWidth + (padding * 2)) / segmentWidth) - 1

	--Set the limit
	if segmentAmount > maxSegments then
		segmentAmount = maxSegments
	end

	segmentAmount = maxSegments

	for i = 0, segmentAmount, 1 do
		if (i == segmentAmount) then
			subImage = 2
		elseif i > 0 then
			subImage = 1
		end

		local x = startX + (i * segmentWidth)
		draw_sprite_ext(Storage.SpriteSettingsMenuLabel, subImage, x, startY, 2, 2, 0, 16777215, 1)
	end

	draw_set_color(make_colour_rgb(218, 172, 57))
	draw_set_halign(0)
	draw_text_transformed(startX + padding, startY + textOffsetY, label, 2, 2, 0)

	return startX + (segmentAmount * segmentWidth)
end

---Draws a button and listens for mouse left button press.
---@param image number The index of the image.
---@param x number The x coordinate where to draw.
---@param y number The y coordinate where to draw.
---@param func fun() The action on mouse left button press.
function Private.DrawButton(image, x, y, func)
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local isButtonDown
	if (mx > x and mx < x + 22 and my > y and my < y + 24) then
		isButtonDown = 1
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			func()
		end
	else
		isButtonDown = 0
	end
	draw_sprite(image, isButtonDown, x, y)
end

---Select the previous mod settings.
function Private.PreviousMod()
	Storage.CurrentSettingsMenuIndex = Storage.CurrentSettingsMenuIndex - 1
	if (Storage.CurrentSettingsMenuIndex < 1) then
		Storage.CurrentSettingsMenuIndex = #Storage.ModSettingData
	end
end

---Select the next mod settings.
function Private.NextMod()
	Storage.CurrentSettingsMenuIndex = Storage.CurrentSettingsMenuIndex + 1
	if (Storage.CurrentSettingsMenuIndex > #Storage.ModSettingData) then
		Storage.CurrentSettingsMenuIndex = 1
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL SETTINGS -------------------------------------------------
------------------------------------------------------------------------------

return InternalSettings