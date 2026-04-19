----------------------------
-- INTERNAL MOD FUNCTIONS --
----------------------------
local Module = {};

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage");
---Access to the Common functions.
local Common = require("ModFrameworkCommon");
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes");
---Access to the functions for the Engineering tab.
local Engineering = require("ModFrameworkEngineering");
---Access to the private functions in this file.
local Private = {};

---Use in the create function of obj_battle_map.lua
---if we add new mod weapons we need to recreate the sound tables
---else we will be hit with an out of range error when the weapon is used
---so we get the stored amount of weapons from the database
---and recreate the 2 sound tables
---@param obj_battle_map game_obj_battle_map the reference to the "obj_battle_map"
function Module.FixAudioTable(obj_battle_map)
	local obj_database = Common.GetObjDatabase();
	local amount_of_weapons = #obj_database.weapon_stat;

	--recreate: main_data_sound
	local main_data_sound = {};
	for i = 1, amount_of_weapons, 1 do
		main_data_sound[i] = {};
		for j = 1, 2, 1 do
			main_data_sound[i][j] = 0.0;
		end
	end

	--recreate: weapon_data_sound
	local weapon_data_sound = {};
	for i = 1, amount_of_weapons, 1 do
		weapon_data_sound[i] = {};
		for j = 1, 4, 1 do
			weapon_data_sound[i][j] = 0.0;
		end
	end

	--return the new sound tables
	obj_battle_map.main_data_sound = main_data_sound;
    obj_battle_map.weapon_data_sound = weapon_data_sound;
	--We update main_sounds_amount as some mods,
	--use this a a starting point to update the sound table.
	--Amount seems to based on a 0 based index so 1 less that the amount_of_weapons
	obj_battle_map.main_sounds_amount = #main_data_sound - 1;
end

local fix_research = true;
---Use in the draw_top_menu function of obj_database.lua
---
---In the event the mod is added to an existing save the newly added mod research is all defaulted to 0 days remaining and condition 0 (closed).
---To fix this we need to validate the research states to see if its a valid state through gameplay or if its a state from loading into an existing save
function Module.FixModdedResearch()
	local obj_weapon_test = Common.GetObjWeaponTest();
	local is_ini_loaded = obj_weapon_test.load_ini;

	--We can only fix the research after all the loading is done. so we can piggyback on the load flag for obj_weapon_test
	if(is_ini_loaded == true and fix_research == false) then
		--We only need to run this once per game load.
		return;
	end

	fix_research = false;
	for _, moddedResearch in ipairs(Storage.ModdedResearchList) do
		local research = Storage.LoadedResearchList[moddedResearch.index];

		if(moddedResearch.initial_condition ~= Types.ResearchConditions.Closed and research.condition == Types.ResearchConditions.Closed) then
			--special condition since this modded research item is set to condition other than closed on mod load we need force it back to initial condition if it was closed.
			--all other states should be fine: 
			--condition 1: it would mean the player stopped the research from continuing.
			--condition 2: it would mean the player started the research.
			--condition 3: it is already been completed.

			research.condition = moddedResearch.initial_condition;
			research.require_days = research.require_days_max;
		elseif(research.condition == Types.ResearchConditions.Closed and research.require_days ~= research.require_days_max) then
			--Condition 0 (closed) -> research has never been started/unlocked it should have the default require_days values

			research.require_days = research.require_days_max;
		elseif(research.condition == Types.ResearchConditions.Opened and research.require_days == 0)  then
			--Condition 1 (opened) -> it should have days remaining between 1 and require_days_max, 0 should be excluded as it would have moved to the condition 3
			--We only care about the case where require_days is at 0 since this would indicate a newly added research that was set to opened because the linked research was completed before.

			research.require_days = research.require_days_max;
		end

		--condition 2 (researching) -> should be a valid state, we can't conclude if the number of days remaining is correct other than it should be less or equal to the max value.
		--condition 3 (researched) -> require_days should be 0
		--both these conditions shouldn't need our attention as they are most likely part of normal gameplay
	end
end

local update_weapon_desc = true;
---Use in the draw_top_menu function of obj_database.lua
---
---We need to update the weapon descriptions in the draw call since the ini isn't loaded in the create function
---however we only need to update once so we set the update_weapon_desc to false after the update to prevent repeat function spamming
function Module.FixWeaponDescriptions()
	local obj_weapon_test = Common.GetObjWeaponTest();
	if(obj_weapon_test.load_ini == false) then
		return;
	end

	---
	if(update_weapon_desc == false) then
		return;
	end

	--Copy the array to the working set
	local weaponDescriptions = {};
	weaponDescriptions = obj_weapon_test.weapon_description;

	for _, component in ipairs(Storage.ModdedComponentList) do
		if(component.component_type == Types.ComponentTypes.weapon) then
			local descriptionIndex = component.index + 1;
			weaponDescriptions[descriptionIndex] = component.WeaponDescription;
		end
	end

	--return new data
	obj_weapon_test.weapon_description = weaponDescriptions;

	update_weapon_desc = false;
end

---Use in the load_game_post_event function of obj_database.lua
---
---This Fixes the missing production sprites after loading a modded game
---Modded sprite data is not saved so we need to fix this after load
function Module.LoadModdedSpritesOnProductionItems()
	local obj_component_shop = Common.GetObjComponentShop();

	--Copy the array to the working set
	local hanger_mass = {};
	hanger_mass = obj_component_shop.hanger_mass;

	--Hanger identifiers
	local hangerTableIndexes = {
		component_type = 2,
		item_index = 3,
		logo = 5,
		logo_index = 11
	};

	--We step through the hanger/production items to find our modded items
	for _, hangar in ipairs(hanger_mass) do
		local componentType = hangar[hangerTableIndexes.component_type];
		local itemIndex = hangar[hangerTableIndexes.item_index];

		for _, modded_item in ipairs(Storage.ModdedComponentList) do
			if(componentType == modded_item.component_type and itemIndex == modded_item.index) then
				--When the reference matches the modded element we set the relevant mod sprite to the logo and logo index.
				hangar[hangerTableIndexes.logo] = modded_item.sprite;
				hangar[hangerTableIndexes.logo_index] = modded_item.sprite;
			end
		end
	end

	--send array back
	obj_component_shop.hanger_mass = hanger_mass;
end

---Use in the draw_weapons function of obj_big_holder.lua
---
---Use in the draw_mechs function of obj_big_holder.lua
---
---Use in the battle_going_start function of obj_battle_map.lua
---
---Updates the given weapon with the modded range if applicable
---@param weapon game_obj_big_holder_weapon the weapon to update
function Module.SetWeaponRange(weapon)
	for _, component in ipairs(Storage.ModdedComponentList) do
		if (component.component_type == Types.ComponentTypes.weapon and component.index == weapon.weapon_number) then
			weapon.blue_length = component.BlueLength;
		end
	end
end

---Use in the create function of obj_research.lua
---
---Used to store the games research items for later use.
---@param item game_obj_research the research item to be stored
function Module.StoreResearchReference(item)
	table.insert(Storage.LoadedResearchList, item);
end

---Use in the research_done function of obj_research.lua
---
---Processes the completion event for the modded research
---@param completedResearch game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number for the research as found in the debug (F6) of the research screen (upper left white number)
function Module.ProcessResearchCompletion(completedResearch, res_number)
	for _, research in ipairs(Storage.ModdedResearchList) do
		if(research.res_number == res_number) then
			Private.ProcessResearchUnlocks(completedResearch, research.UnlockedComponents);
		end
	end
end

---Processes the unlocks and gives the free items if applicable
---@param completedResearch game_obj_research the full reference to the game_research_item that is completed
---@param unlockedComponents modded_component[] the components that are unlocked
function Private.ProcessResearchUnlocks(completedResearch, unlockedComponents)
	for _, component in ipairs(unlockedComponents) do
		if(component.component_type == Types.ComponentTypes.mech) then
			Private.ProcessMechUnlock(component, completedResearch.give_item);
		elseif (component.component_type == Types.ComponentTypes.weapon) then
			Private.ProcessWeaponUnlock(component, completedResearch.give_item);
		elseif (component.component_type == Types.ComponentTypes.solenoid) then
			Private.ProcessSolenoidUnlock(component, completedResearch.give_item);
		end
	end

	--set to false as the items are now given
	completedResearch.give_item = false;
end

---Processes the unlock for a mech type
---@param component modded_component the mech component to process
---@param giveItem boolean true if a free item is given, false otherwise
function Private.ProcessMechUnlock(component, giveItem)
	local component_shop = Common.GetObjComponentShop();
	if (component.ShopComponent ~= nil) then
		local shopComponent = component_shop.comp_mech[component.ShopComponent.index];
		shopComponent.researched = true; --activates the shop component
	end

	if (giveItem == true) then
		Engineering.AddMech(component.index);
	end
end

---Processes the unlock for a weapon type
---@param component modded_component the weapon component to process
---@param giveItem boolean true if a free item is given, false otherwise
function Private.ProcessWeaponUnlock(component, giveItem)
	local component_shop = Common.GetObjComponentShop();
	if (component.ShopComponent ~= nil) then
		local shopComponent = component_shop.comp_wep[component.ShopComponent.index];
		shopComponent.researched = true; --activates the shop component
	end

	if (giveItem == true) then
		Engineering.AddWeapon(component.index, false);
	end
end

---Processes the unlock for a solenoid type
---@param component modded_component the solenoid component to process
---@param giveItem boolean true if a free item is given, false otherwise
function Private.ProcessSolenoidUnlock(component, giveItem)
	local component_shop = Common.GetObjComponentShop();
	if (component.ShopComponent ~= nil) then
		local shopComponent = component_shop.comp_solenoid[component.ShopComponent.index];
		shopComponent.researched = true; --activates the shop component
	end

	if (giveItem == true) then
		Engineering.AddSolenoid(component.index);
	end
end

return Module;