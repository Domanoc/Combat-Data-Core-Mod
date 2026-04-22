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
---@param item ResearchData the dataset for the new research item
---@return number? resNumber the number for the research as found in the debug view (F6) of the research screen (upper left white number)
function Research.AddResearch(item)
	local checkPosition = Private.GetResearchByPosition(item.Position);
	if(checkPosition ~= nil) then
		local message = "Trying to set the new research to a position that is already ocupied.\n";
		message = message.."Check if the correct position was given, or if a another mod in the load order assigned the position.\n\n";
		message = message.."Debug info:\nResearch name: "..item.Name.."\nDesired position: "..item.Position;
		Common.ShowError(message);
		return nil;
	end

	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;

	--Copy the array to the working set
	local mres = {};
	mres = obj_research_panel.mres;
	--get the count of researches and increase it by 1
	local researchCount = obj_research_panel.number_of_res + 1;

	--index for the new item, +1 because lua arrays start with 1
	local resNumber = researchCount;
	local researchIndex = researchCount + 1;
	local newResearch = mres[researchIndex];
	newResearch[ResearchIndexes.Position] = item.Position; 					 --position number on the research tree. You can see positions in the game with f6 (debug mode)
	newResearch[ResearchIndexes.Link_1] = -4; 								 --link 1
	newResearch[ResearchIndexes.Link_2] = -4; 								 --link 2
	newResearch[ResearchIndexes.Link_3] = -4; 								 --link 3
	newResearch[ResearchIndexes.Condition] = item.Condition;			     --condition (0-closed, 1-opened, 2-researching, 3-researched)
	newResearch[ResearchIndexes.RequiredDays] = item.RequiredDays; 	      	 --required days
	newResearch[ResearchIndexes.RequiredStaff] = item.RequiredStaff;         --require science staff
	newResearch[ResearchIndexes.IconType] = item.ReseachIcon.IconType;		 --research icon type (0-combat, 1-production, 2-passability)
	newResearch[ResearchIndexes.IconSubtype] = item.ReseachIcon.IconSubType; --research icon subtype (see left column in the game in research menu)
	newResearch[ResearchIndexes.Description] = item.Description;			 --research text

	if(item.PrerequisiteResearchResNumber ~= -4) then
		local prerequisiteIndex = item.PrerequisiteResearchResNumber + 1;
		if (prerequisiteIndex ~= nil) then
			local prerequisiteResearch = mres[prerequisiteIndex];
			if(prerequisiteResearch == nil) then
				local message = "Trying to set the prerequisite research but the prerequisite reference was nil.\n";
				message = message.."Check if the correct res number was given. Found in the debug view (F6) of the research screen (upper left white number)\n\n";
				message = message.."Debug info:\nResearch name: "..item.Name.."\nPrerequisite res number: "..item.PrerequisiteResearchResNumber;
				Common.ShowError(message);
			elseif(prerequisiteResearch[Types.ResearchIndexes.Link_1] == -4)  then
				prerequisiteResearch[Types.ResearchIndexes.Link_1] = resNumber;
			elseif(prerequisiteResearch[Types.ResearchIndexes.Link_2] == -4)  then
				prerequisiteResearch[Types.ResearchIndexes.Link_2] = resNumber;
			elseif(prerequisiteResearch[Types.ResearchIndexes.Link_3] == -4)  then
				prerequisiteResearch[Types.ResearchIndexes.Link_3] = resNumber;
			else
				local message = "Trying to set the prerequisite research but the prerequisite already has 3 linked researches.\n";
				message = message.."Check if the correct res number was given, or rearange the research tree so there are no more that 3 unlocks per research.\n";
				message = message.."Each research res number can be found in the debug view (F6) of the research screen (upper left white number).\n\n";
				message = message.."Debug info:\nResearch name: "..item.Name.."\nPrerequisite res number: "..item.PrerequisiteResearchResNumber;
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
	obj_research_panel.number_of_res = researchCount;

	---@type ModdedComponent[]
	local unlockedComponents = {};
	for _, value in ipairs(item.UnlockedComponents) do
		if(value ~= nil) then
			table.insert(unlockedComponents, value);
		end
	end

	---@type ModdedResearch
	local moddedResearch = {
		Index = researchIndex,
		InitialCondition = item.Condition,
		Name = item.Name,
		ResNumber = resNumber,
		UnlockedComponents = unlockedComponents
	}
	table.insert(Storage.ModdedResearchList, moddedResearch);

	return resNumber;
end

---Move a research to a new position in the tree, this keeps any present links
---@param resNumber number the number for the research as found in the debug view (F6) of the research screen (upper left white number)
---@param position ResearchPosition position number on the research tree where to move the research to
function Research.MoveResearch(resNumber, position)
	local checkPosition = Private.GetResearchByPosition(position);
	if(checkPosition ~= nil) then
		local message = "Trying to move a research to a position that is already ocupied.\n";
		message = message.."Check if the correct position was given, or if a another mod in the load order assigned the position.\n\n";
		message = message.."Debug info:\nResearch res number: "..resNumber.."\nDesired position: "..position;
		Common.ShowError(message);
		return;
	end

	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;

	--Copy the array to the working set
	local mres = {};
	mres = obj_research_panel.mres;

	local research = mres[resNumber + 1];
	if(research == nil) then
		local message = "Trying to move a research but the reference was nil.\n";
			message = message.."Check if the correct res number was given. Found in the debug view (F6) of the research screen (upper left white number)\n\n";
			message = message.."Debug info:\nResearch res number: "..resNumber.."\nDesired position: "..position;
			Common.ShowError(message);
		return;
	end

	mres[resNumber + 1][ResearchIndexes.Position] = position;

	--send array back
	obj_research_panel.mres = mres;
end

---Change the prerequisite of a research to a new target
---@param resNumber number the number for the research that gets its prerequisite changed
---@param newPrerequisiteResNumber number the res number of the research that gets set as prerequisite
function Research.ChangePrerequisite(resNumber, newPrerequisiteResNumber)

	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;

	--Copy the array to the working set
	local mres = {};
	mres = obj_research_panel.mres;

	local research = mres[resNumber + 1];
	if(research == nil) then
		local message = "Trying to change the prerequisite of a research but the reference was nil.\n";
			message = message.."Check if the correct res number was given. Found in the debug view (F6) of the research screen (upper left white number)\n\n";
			message = message.."Debug info:\nResearch res number: "..resNumber;
			Common.ShowError(message);
		return;
	end

	local prerequisite = mres[newPrerequisiteResNumber + 1];
	if(prerequisite == nil) then
		local message = "Trying to change the prerequisite of a research but the prerequisite reference was nil.\n";
			message = message.."Check if the correct res number was given. Found in the debug view (F6) of the research screen (upper left white number)\n\n";
			message = message.."Debug info:\nPrerequisite research res number: "..newPrerequisiteResNumber;
			Common.ShowError(message);
		return;
	end

	--unlink
	local previousPrerequisiteIndex = Private.GetResearchByLink(resNumber);
	if(previousPrerequisiteIndex ~= nil) then
		local previousPrerequisite = mres[previousPrerequisiteIndex];
		if (previousPrerequisite[ResearchIndexes.Link_1] == resNumber) then
			previousPrerequisite[ResearchIndexes.Link_1] = -4; --unset
		elseif (previousPrerequisite[ResearchIndexes.Link_2] == resNumber) then
			previousPrerequisite[ResearchIndexes.Link_2] = -4; --unset
		elseif (previousPrerequisite[ResearchIndexes.Link_3] == resNumber) then
			previousPrerequisite[ResearchIndexes.Link_3] = -4; --unset
		end
	end

	if(prerequisite[ResearchIndexes.Link_1] == -4)  then
		prerequisite[Types.ResearchIndexes.Link_1] = resNumber;
	elseif(prerequisite[ResearchIndexes.Link_2] == -4)  then
		prerequisite[Types.ResearchIndexes.Link_2] = resNumber;
	elseif(prerequisite[ResearchIndexes.Link_3] == -4)  then
		prerequisite[Types.ResearchIndexes.Link_3] = resNumber;
	else
		local message = "Trying to set the prerequisite research but the prerequisite already has 3 linked researches.\n";
		message = message.."Check if the correct res number was given, or rearange the research tree so there are no more that 3 unlocks per research.\n";
		message = message.."Each research res number can be found in the debug view (F6) of the research screen (upper left white number).\n\n";
		message = message.."Debug info:\nResearch res number: "..resNumber.."\nPrerequisite res number: "..newPrerequisiteResNumber;
		Common.ShowError(message);
	end

	--send array back
	obj_research_panel.mres = mres;
end

---Remove all unlock links (that unlock other researches on completion) on a given research
---@param resNumber number the res numer of the research that has its links cleared
function Research.ClearUnlockLinks(resNumber)

	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;

	--Copy the array to the working set
	local mres = {};
	mres = obj_research_panel.mres;

	local research = mres[resNumber + 1];
	if(research == nil) then
		local message = "Trying to remove all links from a research but the reference was nil.\n";
			message = message.."Check if the correct res number was given. Found in the debug view (F6) of the research screen (upper left white number)\n\n";
			message = message.."Debug info:\nResearch res number: "..resNumber;
			Common.ShowError(message);
		return;
	end

	research[ResearchIndexes.Link_1] = -4;
	research[ResearchIndexes.Link_2] = -4;
	research[ResearchIndexes.Link_3] = -4;

	--send array back
	obj_research_panel.mres = mres;
end

---Add unlocks to an existing research
---@param resNumber number the res number to add unlocks to
---@param unlock ModdedComponent? the component that are unlocked by this research, if a nil value is provided no action is taken
function Research.AddUnlock(resNumber, unlock)
	if (unlock == nil) then
		return;
	end

	--if we have the reference stored get it and add the unlock
 	local moddedResearch = Private.GetModdedResearchByResNumber(resNumber);
	if (moddedResearch ~= nil) then
		table.insert(moddedResearch.UnlockedComponents, unlock);
		return;
	end
	
	--if not we will check if the res number is valid
	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;

	--Copy the array to the working set
	local mres = {};
	mres = obj_research_panel.mres;

	local index = resNumber + 1;
	local research = mres[index];
	if (research == nil) then
		local message = "Trying add an unlock to a research but the reference was nil.\n";
			message = message.."Check if the correct res number was given. Found in the debug view (F6) of the research screen (upper left white number)\n\n";
			message = message.."Debug info:\nResearch res number: "..resNumber;
			Common.ShowError(message);
		return;
	end

	--and with a valid res number we will create a new entry.
	---@type ModdedResearch
	local newModdedResearch = {
		Index = index,
		InitialCondition = research[ResearchIndexes.Condition],
		Name = "NotAFrameWorkResearch_"..resNumber,
		ResNumber = resNumber,
		UnlockedComponents = { unlock }
	}
	table.insert(Storage.ModdedResearchList, newModdedResearch);
end

---Get the modded research by its res number
---@param resNumber number the res number to look for
---@return ModdedResearch? moddedResearch returns the modded research if found or nil otherwise
function Private.GetModdedResearchByResNumber(resNumber)
	for _, moddedResearch in ipairs(Storage.ModdedResearchList) do
		if (moddedResearch.ResNumber == resNumber) then
			return moddedResearch;
		end
	end
	return nil;
end

---Gets the mres research item by its position value
---@param position ResearchPosition? the position value to look for
---@return number? index returns the found research item index or nil otherwise
function Private.GetResearchByPosition(position)
	if (position == nil) then
		return nil;
	end

	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;
	for index, researchItem in ipairs(obj_research_panel.mres) do
		if (researchItem[ResearchIndexes.Position] == position and researchItem[ResearchIndexes.Condition] ~= nil) then
			return index;
		end
	end
	return nil;
end

---Gets the mres research item that is the parent rerequisite for the given res number
---@param resNumber number the res number to look for
---@return number? index returns the found research item index or nil otherwise
function Private.GetResearchByLink(resNumber)
	local obj_research_panel = Common.GetObjResearchPanel();
	local ResearchIndexes = Types.ResearchIndexes;
	for index, researchItem in ipairs(obj_research_panel.mres) do
		local Link_1 = researchItem[ResearchIndexes.Link_1];
		local Link_2 = researchItem[ResearchIndexes.Link_2];
		local Link_3 = researchItem[ResearchIndexes.Link_3];
		if (Link_1 == resNumber or Link_2 == resNumber or Link_3 == resNumber) then
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