--------------------------
--PRODUCTION--------------
--------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage");
---Access to the Common functions.
local Common = require("ModFrameworkCommon");
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes");

---Access to the functions for the Production tab.
local Production = {};

--The size of the production tab items is always 96 pixels (width & height)
local icon_pixel_size = 96;

---Use in the create function of obj_component_shop.lua
---
---Adds the known modded component to the production tab where applicable
---
function Production.AddModdedComponents()
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.CanBeConstructed) then
			if (component.ComponentType == Types.ComponentTypes.Mech) then
				Production.AddMech(component);
			elseif (component.ComponentType == Types.ComponentTypes.Weapon) then
				Production.AddWeapon(component);
			elseif (component.ComponentType == Types.ComponentTypes.Solenoid) then
				Production.AddSolenoid(component);
			end
		end
	end
end

---Adds a component of type mech to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Production.AddMech(component)

	local mech_number = component.Index;
	local component_size = component.ComponentSize;
	local researched = component.IsResearched;

	local obj_component_shop = Common.GetObjComponentShop();

	--Copy the array to the working set
	local comp_mech = {};
	comp_mech = obj_component_shop.comp_mech;

	local array_size = #comp_mech;
	local mech_location_x = obj_component_shop.mech_start_x + icon_pixel_size * (array_size % 5);
	local mech_location_y = obj_component_shop.mech_start_y + icon_pixel_size * (array_size // 5);

	local obj_component = asset_get_index("obj_component");
	local component_item_index = array_size + 1;
	local added_mech_component = instance_create_depth(mech_location_x, mech_location_y, -500, obj_component);
	added_mech_component.comp_type = Types.ComponentTypes.Mech;	--mech
	added_mech_component.comp_data_type = mech_number;		--number in database
	added_mech_component.logo = -4; 						--auto assign based on obj_database info
	added_mech_component.size = component_size;				--number of slots used in construction
	added_mech_component.researched = researched;			--true for researched or false for not
	comp_mech[component_item_index] = added_mech_component;

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = component_item_index,
	};

	--send array back
	obj_component_shop.comp_mech = comp_mech;
end

---Adds a component of type weapon to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Production.AddWeapon(component)

	local weapon_number = component.Index;
	local component_size = component.ComponentSize;
	local researched = component.IsResearched;

	local obj_component_shop = asset_get_index("obj_component_shop");

	--Copy the array to the working set
	local comp_wep = {};
	comp_wep = obj_component_shop.comp_wep;

	local array_size = #comp_wep;
	local empty_vanilla_weapons = 99 - 12;							--The vanilla weapon array is 99 items but only 12 weapons are used.
	local producible_weapons = array_size - empty_vanilla_weapons;	--number of producible weapons, vanilla is 12 but there are a total of 99 vanilla weapons in comp_wep, so must reduce it.
	local weapon_location_x = obj_component_shop.weapon_start_x + icon_pixel_size * (producible_weapons // 3);
	local weapon_location_y = obj_component_shop.weapon_start_y + icon_pixel_size * (producible_weapons % 3);

	local obj_component = asset_get_index("obj_component");
	local component_item_index = array_size + 1;
	local added_weapon_component = instance_create_depth(weapon_location_x, weapon_location_y, -500, obj_component);
	added_weapon_component.comp_type = Types.ComponentTypes.Weapon;	--weapon
	added_weapon_component.comp_data_type = weapon_number;		--number in database
	added_weapon_component.logo = -4; 							--auto assign based on obj_database info
	added_weapon_component.size = component_size;				--number of slots used in construction
	added_weapon_component.researched = researched;				--true for researched or false for not
	comp_wep[component_item_index] = added_weapon_component;

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = component_item_index,
	};

	--send array back
	obj_component_shop.comp_wep = comp_wep;
end

---Adds a component of type solenoid to the production tab
---@param component ModdedComponent the modded mech component that gets added to the production tab
function Production.AddSolenoid(component)

	local solonoid_number = component.Index;
	local component_size = component.ComponentSize;
	local researched = component.IsResearched;

	local obj_component_shop = Common.GetObjComponentShop();

	--Copy the array to the working set
	local comp_solenoid = {};
	comp_solenoid = obj_component_shop.comp_solenoid;

	local row = 2; 		--row 3 as its a 0 based index, solonoids are in row 3 of the reactor box
	local column = 4 	--column 5 as its a 0 based index, solonoids start at column 5 of the reactor box
	local column_offset = column * icon_pixel_size;
	local array_size = #comp_solenoid;
	local solenoid_location_x = obj_component_shop.reactor_start_x + column_offset + icon_pixel_size * array_size;
	local solenoid_location_y = obj_component_shop.reactor_start_y + icon_pixel_size * row;

	local obj_component = asset_get_index("obj_component");
	local component_item_index = array_size + 1;
	local added_solenoid_component = instance_create_depth(solenoid_location_x, solenoid_location_y, -500, obj_component);
	added_solenoid_component.comp_type = Types.ComponentTypes.Solenoid;	--solenoid
	added_solenoid_component.comp_data_type = solonoid_number;		--number in database
	added_solenoid_component.logo = -4; 							--auto assign based on obj_database info
	added_solenoid_component.size = component_size;					--number of slots used in construction
	added_solenoid_component.researched = researched;				--true for researched or false for not
	comp_solenoid[component_item_index] = added_solenoid_component;

	--Add the newly modded shop component to the parent component. So we can find the reference later.
	component.ShopComponent = {
		Index = component_item_index,
	};

	--send array back
	obj_component_shop.comp_solenoid = comp_solenoid;
end

return Production;