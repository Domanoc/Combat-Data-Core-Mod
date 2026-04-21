--------------------------
--RESEARCH              --
--------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage");
---Access to the Common functions.
local Common = require("ModFrameworkCommon");
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes");
---Access to the private functions in this file.
local Private = {};

---Access to the functions for the Research tab.
local Research = {};

---Adds a research item to the tech tree
---@param item ResearchData The dataset for the new research item
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
	local tmpSprite = Common.AddSprite(item.SpritePath, 0, false, false, 0, 0); --research sprite
	local researchSpriteIndex = variable_global_get("research_items_spr");		--get the current sprite
	local researhSprites = -1;
    if (researchSpriteIndex ~= -4) then
    	researhSprites = sprite_duplicate(researchSpriteIndex);
    else
        researchSpriteIndex = asset_get_index("spr_research_items");
        researhSprites = sprite_duplicate(researchSpriteIndex);
    end
    Common.MergeSprite(researhSprites, tmpSprite);				--adds to the end of the subimg
	variable_global_set("research_items_spr", researhSprites);	--update the sprite variable
	Common.DeleteSprite(tmpSprite);								--delete only tmp_sprite. researh_sprites still contains id

	--send array back
	obj_research_panel.mres = mres;
	obj_research_panel.number_of_res = research_count;

	---@type ModdedComponent[]
	local unlockedComponents = {};
	for _, value in ipairs(item.UnlockedComponents) do
		if(value ~= nil) then
			table.insert(unlockedComponents, value);
		end
	end

	---@type ModdedResearch
	local moddedResearch = {
		Index = researchItemIndex,
		InitialCondition = item.Condition,
		Name = item.Name,
		ResNumber = researchItemIndex - 1,
		UnlockedComponents = unlockedComponents
	}
	table.insert(Storage.ModdedResearchList, moddedResearch);
end

---Gets the mres research item by its position value
---@param position number? the position value to look for
---@return number? researchItem returns the found research item index or nil otherwise
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