
---One time script when the game is started
---@param q game_obj_research
function create(q)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--While q currently holds only default values we only need to store the reference for later use.
	Mod.Research.StoreResearchReference(q);
end

---Runs before research_done
---@param q game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number of the research that is completed, the number for the research as found in the debug (F6) of the research screen (upper left white number)
function research_done_before(q,res_number)
end;

---Runs if research is done and when loading the game
---@param q game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number of the research that is completed, the number for the research as found in the debug (F6) of the research screen (upper left white number)
function research_done(q, res_number)
	Mod.Research.ProcessResearchCompletion(q, res_number);
end