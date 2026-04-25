------------------------------------------------------------------------------
--- INTERNAL PRODUCTION FUNCTIONS --------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Production tab.
---@class ModFrameworkProduction
local Production = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")
---Access to the private functions in this file.
local Private = {}

---The size of the production tab items is always 96 pixels (width & height)
local icon_pixel_size = 96

---The current page for the weapons
local weaponPage = 0
---The maximium page for the weapons
local maxweaponPage = 1

---Flag indicating if the shop icons need to be rearranged
local isShopUpdateNeeded = true

---Flag indicating if the shop components are stored
local areShopComponentsStored = false

---Flag indicating if the modded weapon descriptions are set
local isWeaponDescComplete = false

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Use in the create function of obj_component_shop.lua
---
---Fixes the empty references in the comp_wep table
function Production.FixShopWeaponList()
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_wep = obj_component_shop.comp_wep
	local newCompWep = {}

	--the comp_wep has a lot of empty entries we will remove them to reduce modding complexity
	for i = 1, 12, 1 do
		table.insert(newCompWep, comp_wep[i])
	end

	--return the updated table
	obj_component_shop.comp_wep = newCompWep
end

---Use in the create function of obj_component_shop.lua
---
---Fixes the empty references in the list_weapon table
function Production.FixContentWeaponList()
	if(Common.IsLoadedGame()) then
		--This issue is only present on new games
		return
	end
	local obj_content_weapons = Common.GetObjContentWeapons()

	--Copy the array to the working set
	local list_weapon = obj_content_weapons.list_weapon
	local newListWep = {}

	--the comp_wep has a lot of empty entries we will remove them to reduce modding complexity
	for _, value in pairs(list_weapon) do
		if (value ~= -4) then
			table.insert(newListWep, value)
		end
	end

	--return the updated table
	obj_content_weapons.list_weapon = newListWep
end

---Use in the load_game_post_event function of obj_database.lua
---
---This Fixes the missing production sprites after loading a modded game
---Modded sprite data is not saved so we need to fix this after load
function Production.SetModdedSprites()
	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local hanger_mass = obj_component_shop.hanger_mass

	--Hanger identifiers
	local hangerTableIndexes = {
		component_type = 2,
		item_index = 3,
		logo = 5,
		logo_index = 11
	}

	--We step through the hanger/production items to find our modded items
	for _, hangar in ipairs(hanger_mass) do
		local componentType = hangar[hangerTableIndexes.component_type]
		local itemIndex = hangar[hangerTableIndexes.item_index]

		for _, modded_item in ipairs(Storage.ModdedComponentList) do
			if(componentType == modded_item.ComponentType and itemIndex == modded_item.Index) then
				--When the reference matches the modded element we set the relevant mod sprite to the logo and logo index.
				hangar[hangerTableIndexes.logo] = modded_item.Sprite
				hangar[hangerTableIndexes.logo_index] = modded_item.Sprite
			end
		end
	end

	--send array back
	obj_component_shop.hanger_mass = hanger_mass
end

---Use in the draw_top_menu function of obj_database.lua
---
---The modded weapon descriptions need to be set in the ini output
function Production.SetModdedWeaponDescriptions()
	local obj_weapon_test = Common.GetObjWeaponTest()

	--We check if the ini has been loaded or if the update is complete
	if(obj_weapon_test.load_ini == false or isWeaponDescComplete == true) then
		return
	end

	--Copy the array to the working set
	local weaponDescriptions = obj_weapon_test.weapon_description

	for _, component in ipairs(Storage.ModdedComponentList) do
		if(component.ComponentType == Types.ComponentTypes.Weapon) then
			local descriptionIndex = component.Index + 1
			weaponDescriptions[descriptionIndex] = component.WeaponDescription
		end
	end

	--return new data
	obj_weapon_test.weapon_description = weaponDescriptions

	--we only need to run this once so we set the flag to true
	isWeaponDescComplete = true
end

---Use in the draw_top_menu function of obj_database.lua
---
---Stores the shop components references
function Production.StoreShopComponents()
	--if the components are stored skip
	if (areShopComponentsStored == true) then
		return
	end

	local obj_component_shop = Common.GetObjComponentShop()
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_beacon)
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_city_parts)
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_engineer)
	table.insert(Storage.AllShopComponents, obj_component_shop.comp_rocket)
	Private.StoreShopComponents(obj_component_shop.comp_cabin)
	Private.StoreShopComponents(obj_component_shop.comp_injector)
	Private.StoreShopComponents(obj_component_shop.comp_kernel)
	Private.StoreShopComponents(obj_component_shop.comp_lr_armor_end)
	Private.StoreShopComponents(obj_component_shop.comp_lr_armor_middle)
	Private.StoreShopComponents(obj_component_shop.comp_magnet)
	Private.StoreShopComponents(obj_component_shop.comp_mech)
	Private.StoreShopComponents(obj_component_shop.comp_motor)
	Private.StoreShopComponents(obj_component_shop.comp_piston)
	Private.StoreShopComponents(obj_component_shop.comp_reactor)
	Private.StoreShopComponents(obj_component_shop.comp_safety)
	Private.StoreShopComponents(obj_component_shop.comp_solenoid)
	Private.StoreShopComponents(obj_component_shop.comp_wep)

	local obj_database = Common.GetObjDatabase()
	for _, component in pairs(obj_component_shop.comp_wep) do
		local weaponData = obj_database.weapon_stat[component.comp_data_type + 1]
		local weaponType = ds_map_find_value(weaponData, "type")
		if (weaponType == Types.WeaponTypes.White) then
			table.insert(Storage.WeaponsComponents.kineticWeapons, component)
		elseif (weaponType == Types.WeaponTypes.Red) then
			table.insert(Storage.WeaponsComponents.missileWeapons, component)
		elseif (weaponType == Types.WeaponTypes.Blue) then
			table.insert(Storage.WeaponsComponents.energyWeapons, component)
		elseif (weaponType == Types.WeaponTypes.Yellow) then
			table.insert(Storage.WeaponsComponents.thermalWeapons, component)
		end
	end

	--we only need to run this once so we set the flag to true
	areShopComponentsStored = true
end

function Production.RearrangeShopComponents()
	--if the components are set skip
	if (isShopUpdateNeeded == false) then
		return
	end

	for _, value in pairs(Storage.AllShopComponents) do
		value.researched = true;
		value.x = 0
		value.y = 0
	end

	Private.ArrangeWeaponComponents()

	--18 slots under additional
--	local startX = 20
--	local startY = 485
--	for i = 0, 17, 1 do
--		local x = startX + 97 * (i % 3)
--		local y = startY + 97 * (i // 3)
--		local index = i + 1
--
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--30 slots under mech
--	local startX = 320
--	local startY = 485
--	for i = 0, 29, 1 do
--		local x = startX + 97 * (i % 5)
--		local y = startY + 97 * (i // 5)
--		local index = i + 1
--
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--24 slots under weapons
--	local startX = 1120
--	local startY = 221
--	for i = 0, 23, 1 do
--		local x = startX + 97 * (i // 3)
--		local y = startY + 97 * (i % 3)
--		local index = i + 1
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--8 slots under support
--	local startX = 1120
--	local startY = 595
--	for i = 0, 7, 1 do
--		local x = startX + 97 * (i % 8)
--		local y = startY + 97 * (i // 8)
--		local index = i + 1
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--24 slots under reactors
--	local startX = 1120
--	local startY = 765
--	for i = 0, 23, 1 do
--		local x = startX + 97 * (i % 8)
--		local y = startY + 97 * (i // 8)
--		local index = i + 1
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--we only need to run this once so we set the flag to false
	isShopUpdateNeeded = false
end

---Use in the create function of obj_database.lua
---
---Loads the needed shop sprites, so we can add buttons and rearrange the layout
function Production.LoadShopSprites()
	local modPath = Common.GetModPath("ModFramework");
	Storage.SpriteShopButtonLeft = Common.AddSprite(modPath.."sprites//ShopButtonLeft.png", 2, false, false, 0, 0)
	Storage.SpriteShopButtonRight = Common.AddSprite(modPath.."sprites//ShopButtonRight.png", 2, false, false, 0, 0)

	--We change the shop background sprite to allow better rearranging of the items
	local engineeringSprite = asset_get_index("spr_back_shop")
	sprite_replace(engineeringSprite, modPath.."sprites\\spr_back_shop.png", 1, false, false, 0, 0)

	--The robot sprite was bleeding out of the construction box
	local robotSprite = asset_get_index("spr_engineer_robot")
	sprite_replace(robotSprite, modPath.."sprites\\spr_engineer_robot.png", 1, false, false, 0, 0)
end

function Production.ShopDraw()
	local obj_component_shop = Common.GetObjComponentShop()
	if (obj_component_shop.activated == true) then

		--Buttons for additional
		Private.DrawButton(Storage.SpriteShopButtonLeft, 86, 454, Private.LeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 284, 454, Private.RightButtonPressed)

		--Buttons for mechs
		Private.DrawButton(Storage.SpriteShopButtonLeft, 454, 454, Private.LeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 652, 454, Private.RightButtonPressed)

		--Buttons for weapons
		if (maxweaponPage > 0) then
			Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 174, Private.LeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 174, Private.RightButtonPressed)
		end

		--Buttons for support
		Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 542, Private.LeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 542, Private.RightButtonPressed)

		--Buttons for reactors
		Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 728, Private.LeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 728, Private.RightButtonPressed)
	end
end

function Private.LeftButtonPressed()
	weaponPage = weaponPage - 1
	isShopUpdateNeeded = true
	if (weaponPage < 0) then
		weaponPage = maxweaponPage
	end
end

function Private.RightButtonPressed()
	weaponPage = weaponPage + 1
	isShopUpdateNeeded = true
	if (weaponPage > maxweaponPage) then
		weaponPage = 0
	end
end

---Draws a button and listens for mouse left button press
---@param image number the index of the image
---@param x number the x coordinate where to draw
---@param y number the y coordinate where to draw
---@param func fun() the action on mouse left button press
function Private.DrawButton(image, x, y, func)
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local isButtonDown
	if (mx > x and mx < x + 22 and my > y and my < y + 24) then
		isButtonDown = 1;
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			func()
		end
	else
		isButtonDown = 0
	end
	draw_sprite(image, isButtonDown, x, y)
end

function Private.ArrangeWeaponComponents()

	--24 slots under weapons
	local slots = 24
	local pageWidth = 776
	local startX = 1120 - (pageWidth * weaponPage)
	local startY = 221
	local index = 0
	local cadence = 3

	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.kineticWeapons, index, slots, cadence, startX, startY)
	if (index % cadence ~= 0) then
		index = index + (cadence - (index % cadence))
	end
	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.missileWeapons, index, slots, cadence, startX, startY)
	if (index % cadence ~= 0) then
		index = index + (cadence - (index % cadence))
	end
	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.energyWeapons, index, slots, cadence, startX, startY)
	if (index % cadence ~= 0) then
		index = index + (cadence - (index % cadence))
	end
	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.thermalWeapons, index, slots, cadence, startX, startY)
end

---Arrange components to a grid in vertical columns
---@param array game_obj_component[]
---@param index number
---@param startX number 
---@param startY number
---@return number
function Private.ArrangeLoopVertical(array, index, slots, cadence, startX, startY)
	for _, weapon in ipairs(array) do
		local x = startX + 97 * (index // cadence)
		local y = startY + 97 * (index % cadence)
		local upperBounds = (slots - 1) + (slots * weaponPage)
		local lowerBounds = slots * weaponPage
		if (weapon.researched == false) then
		elseif (index > upperBounds) then
			index = index + 1
		elseif (index < lowerBounds) then
			index = index + 1
		else
			weapon.x = x
			weapon.y = y
			index = index + 1
		end
	end
	return index
end

---Use in the create function of obj_component_shop.lua
---
---Adds the known modded component to the production tab where applicable
function Production.AddModdedComponents()
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.CanBeConstructed) then
			if (component.ComponentType == Types.ComponentTypes.Mech) then
				Private.AddMech(component)
			elseif (component.ComponentType == Types.ComponentTypes.Weapon) then
				Private.AddWeapon(component)
			elseif (component.ComponentType == Types.ComponentTypes.Solenoid) then
				Private.AddSolenoid(component)
			end
		end
	end
end

---Adds a component of type mech to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Private.AddMech(component)

	local mech_number = component.Index
	local component_size = component.ComponentSize
	local researched = component.IsResearched

	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_mech = obj_component_shop.comp_mech

	local array_size = #comp_mech
	local mech_location_x = obj_component_shop.mech_start_x + icon_pixel_size * (array_size % 5)
	local mech_location_y = obj_component_shop.mech_start_y + icon_pixel_size * (array_size // 5)

	local component_item_index = array_size + 1
	local added_mech_component = Private.AddComponentInstance(mech_location_x, mech_location_y)
	added_mech_component.comp_type = Types.ComponentTypes.Mech	--mech
	added_mech_component.comp_data_type = mech_number		--number in database
	added_mech_component.logo = -4 						--auto assign based on obj_database info
	added_mech_component.size = component_size				--number of slots used in construction
	added_mech_component.researched = researched			--true for researched or false for not
	comp_mech[component_item_index] = added_mech_component

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = component_item_index,
	}

	--send array back
	obj_component_shop.comp_mech = comp_mech
end

---Adds a component of type weapon to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Private.AddWeapon(component)

	local weapon_number = component.Index
	local component_size = component.ComponentSize
	local researched = component.IsResearched

	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_wep = obj_component_shop.comp_wep

	local array_size = #comp_wep
	local weapon_location_x = obj_component_shop.weapon_start_x + icon_pixel_size * (array_size // 3)
	local weapon_location_y = obj_component_shop.weapon_start_y + icon_pixel_size * (array_size % 3)

	local component_item_index = array_size + 1
	local added_weapon_component = Private.AddComponentInstance(weapon_location_x, weapon_location_y)
	added_weapon_component.comp_type = Types.ComponentTypes.Weapon	--weapon
	added_weapon_component.comp_data_type = weapon_number		--number in database
	added_weapon_component.logo = -4 							--auto assign based on obj_database info
	added_weapon_component.size = component_size				--number of slots used in construction
	added_weapon_component.researched = researched				--true for researched or false for not
	comp_wep[component_item_index] = added_weapon_component

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = component_item_index,
	}

	--send array back
	obj_component_shop.comp_wep = comp_wep
end

---Adds a component of type solenoid to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Private.AddSolenoid(component)

	local solonoid_number = component.Index
	local component_size = component.ComponentSize
	local researched = component.IsResearched

	local obj_component_shop = Common.GetObjComponentShop()

	--Copy the array to the working set
	local comp_solenoid = obj_component_shop.comp_solenoid

	local row = 2 		--row 3 as its a 0 based index, solonoids are in row 3 of the reactor box
	local column = 4 	--column 5 as its a 0 based index, solonoids start at column 5 of the reactor box
	local column_offset = column * icon_pixel_size
	local array_size = #comp_solenoid
	local solenoid_location_x = obj_component_shop.reactor_start_x + column_offset + icon_pixel_size * array_size
	local solenoid_location_y = obj_component_shop.reactor_start_y + icon_pixel_size * row

	local component_item_index = array_size + 1
	local added_solenoid_component = Private.AddComponentInstance(solenoid_location_x, solenoid_location_y)
	added_solenoid_component.comp_type = Types.ComponentTypes.Solenoid	--solenoid
	added_solenoid_component.comp_data_type = solonoid_number		--number in database
	added_solenoid_component.logo = -4 							--auto assign based on obj_database info
	added_solenoid_component.size = component_size					--number of slots used in construction
	added_solenoid_component.researched = researched				--true for researched or false for not
	comp_solenoid[component_item_index] = added_solenoid_component

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = component_item_index,
	}

	--send array back
	obj_component_shop.comp_solenoid = comp_solenoid
end

---Create a new obj_component instance
---@param x number the x coordinate where to draw
---@param y number the y coordinate where to draw
---@return game_obj_component objComponent the new obj_component instance
function Private.AddComponentInstance(x, y)
	local obj_component = Common.GetObjComponent()
	return instance_create_depth(x, y, -500, obj_component)
end

---Store the shop components
---@param array game_obj_component[] the components to store
function Private.StoreShopComponents(array)
	for _, component in pairs(array) do
		table.insert(Storage.AllShopComponents, component)
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL PRODUCTION -----------------------------------------------
------------------------------------------------------------------------------

return Production