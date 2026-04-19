--------------------------
--RESEARCH              --
--------------------------

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

---Access to the functions for the Research tab.
local Research = {};

---Use in the create function of obj_research.lua
---
---Used to store the games research items for later use.
---@param item game_obj_research the research item to be stored
function Research.StoreResearchReference(item)
	table.insert(Storage.LoadedResearchList, item);
end

local fix_research = true;
---Use in the draw_top_menu function of obj_database.lua
---
---In the event the mod is added to an existing save the newly added mod research is all defaulted to 0 days remaining and condition 0 (closed).
---To fix this we need to validate the research states to see if its a valid state through gameplay or if its a state from loading into an existing save
function Research.FixModdedResearch()
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

---Adds a research item to the tech tree
---@param item research_item_data The dataset for the new research item
function Research.AddResearch(item)
	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;

	--Copy the array to the working set
	local mres = {};
	mres = obj_research_panel.mres;
	--get the count of researches and increase it by 1
	local research_count = obj_research_panel.number_of_res + 1;

	--index for the new item, +1 because lua arrays start with 1
	local researchItemIndex = research_count + 1;
	mres[researchItemIndex][ResearchIndexes.position] = item.Position; 					  --position number on the research tree. You can see positions in the game with f6 (debug mode)
	mres[researchItemIndex][ResearchIndexes.link_1] = -4; 								  --link 1
	mres[researchItemIndex][ResearchIndexes.link_2] = -4; 								  --link 2
	mres[researchItemIndex][ResearchIndexes.link_3] = -4; 								  --link 3
	mres[researchItemIndex][ResearchIndexes.condition] = item.Condition;			      --condition (0-closed, 1-opened, 2-researching, 3-researched)
	mres[researchItemIndex][ResearchIndexes.required_days] = item.RequiredDays; 	      --required days
	mres[researchItemIndex][ResearchIndexes.required_staff] = item.RequiredStaff;         --require science staff
	mres[researchItemIndex][ResearchIndexes.icon_type] = item.ReseachIcon.IconType;		  --research icon type (0-combat, 1-production, 2-passability)
	mres[researchItemIndex][ResearchIndexes.icon_subtype] = item.ReseachIcon.IconSubType; --research icon subtype (see left column in the game in research menu)
	mres[researchItemIndex][ResearchIndexes.description] = item.Description;			  --research text
	
	if(item.PrerequisiteResearchPosition ~= -4) then
		local prerequisiteIndex = Private.GetResearchByPosition(item.PrerequisiteResearchPosition);
		if (prerequisiteIndex ~= nil) then
			local prerequisiteResearch = mres[prerequisiteIndex];
			if(prerequisiteResearch[Types.ResearchIndexes.link_1] == -4) then
				prerequisiteResearch[Types.ResearchIndexes.link_1] = research_count;
			elseif(prerequisiteResearch[Types.ResearchIndexes.link_2] == -4)  then
				prerequisiteResearch[Types.ResearchIndexes.link_2] = research_count;
			elseif(prerequisiteResearch[Types.ResearchIndexes.link_3] == -4)  then
				prerequisiteResearch[Types.ResearchIndexes.link_3] = research_count;
			else
				local message = "Trying to set the prerequisite research for research '"..item.Name.."'. but the prerequisite already has 3 linked researches.\n\n";
				message = message.."Rearange the research tree so there are no more that 3 unlocks per research."
				Common.ShowError(message);
			end
		end
	end
	
	--add research sprite
	local tmp_sprite = Common.AddSprite(item.SpritePath, 0, false, false, 0, 0);--research sprite
	local researchSpriteIndex = variable_global_get("research_items_spr");	--get the current sprite

	local researh_sprites = -1;
    if (researchSpriteIndex ~= -4) then
    	researh_sprites = sprite_duplicate(researchSpriteIndex);
    else
        researchSpriteIndex = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(researchSpriteIndex);
    end
    Common.MergeSprite(researh_sprites, tmp_sprite);				--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);		--update the sprite variable
	Common.DeleteSprite(tmp_sprite);								--delete only tmp_sprite. researh_sprites still contains id

	--send array back
	obj_research_panel.mres = mres;
	obj_research_panel.number_of_res = research_count;

	---@type modded_component[]
	local unlockedComponents = {};
	for _, value in ipairs(item.UnlockedComponents) do
		if(value ~= nil) then
			table.insert(unlockedComponents, value);
		end
	end

	---@type modded_research_item
	local modded_research = {
		index = researchItemIndex,
		initial_condition = item.Condition,
		name = item.Name,
		res_number = researchItemIndex - 1,
		UnlockedComponents = unlockedComponents
	}
	table.insert(Storage.ModdedResearchList, modded_research);
end

---Use in the research_done function of obj_research.lua
---
---Processes the completion event for the modded research
---@param completedResearch game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number for the research as found in the debug (F6) of the research screen (upper left white number)
function Research.ProcessResearchCompletion(completedResearch, res_number)
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

---Gets the mres research item by its position value
---@param position number|nil the position value to look for
---@return number|nil researchItem returns the found research item index or nil otherwise
function Private.GetResearchByPosition(position)
	if (position == nil) then
		return nil;
	end

	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;
	for index, researchItem in ipairs(obj_research_panel.mres) do
		if (researchItem[ResearchIndexes.position] == position) then
			return index;
		end
	end
	return nil;
end

--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

local UnlockAllResearch = true;
function Research.UnlockAllResearch()
	if (UnlockAllResearch == false) then
		return;
	end

	for _, research in ipairs(Storage.LoadedResearchList) do
		if(research.condition ~= Types.ResearchConditions.Researched) then
			research.condition = Types.ResearchConditions.Researching;
			research.require_days = 1;
		end
	end
end

return Research;