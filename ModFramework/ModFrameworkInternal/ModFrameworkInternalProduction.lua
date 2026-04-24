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

--The size of the production tab items is always 96 pixels (width & height)
local icon_pixel_size = 96

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

local isWeaponDescComplete = false
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

local areComponentsUpdated = false
function Production.FixShopComponents()
	--if the components are set skip
	if (areComponentsUpdated == true) then
		return
	end

	local obj_component_shop = Common.GetObjComponentShop()

	table.insert(Storage.ShopComponents, obj_component_shop.comp_beacon)
	table.insert(Storage.ShopComponents, obj_component_shop.comp_city_parts)
	table.insert(Storage.ShopComponents, obj_component_shop.comp_engineer)
	table.insert(Storage.ShopComponents, obj_component_shop.comp_rocket)
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

	for _, value in pairs(Storage.ShopComponents) do
		value.researched = true;
		value.x = 0
		value.y = 0
	end

	--18 slots under additional
--	local startX = 20
--	local startY = 485
--	for i = 0, 17, 1 do
--		local x = startX + 97 * (i % 3)
--		local y = startY + 97 * (i // 3)
--		local index = i + 1
--
--		Storage.ShopComponents[index].x = x
--		Storage.ShopComponents[index].y = y
--	end

	--30 slots under mech
--	local startX = 320
--	local startY = 485
--	for i = 0, 29, 1 do
--		local x = startX + 97 * (i % 5)
--		local y = startY + 97 * (i // 5)
--		local index = i + 1
--
--		Storage.ShopComponents[index].x = x
--		Storage.ShopComponents[index].y = y
--	end

	--24 slots under weapons
--	local startX = 1120
--	local startY = 221
--	for i = 0, 23, 1 do
--		local x = startX + 97 * (i % 8)
--		local y = startY + 97 * (i // 8)
--		local index = i + 1
--		Storage.ShopComponents[index].x = x
--		Storage.ShopComponents[index].y = y
--	end

	--8 slots under support
--	local startX = 1120
--	local startY = 595
--	for i = 0, 7, 1 do
--		local x = startX + 97 * (i % 8)
--		local y = startY + 97 * (i // 8)
--		local index = i + 1
--		Storage.ShopComponents[index].x = x
--		Storage.ShopComponents[index].y = y
--	end

	--24 slots under reactors
	local startX = 1120
	local startY = 765
	for i = 0, 23, 1 do
		local x = startX + 97 * (i % 8)
		local y = startY + 97 * (i // 8)
		local index = i + 1
		Storage.ShopComponents[index].x = x
		Storage.ShopComponents[index].y = y
	end

	--we only need to run this once so we set the flag to true
	areComponentsUpdated = true
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
		table.insert(Storage.ShopComponents, component)
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL PRODUCTION -----------------------------------------------
------------------------------------------------------------------------------

return Production