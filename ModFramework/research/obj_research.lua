
---One time script when the game is started
---@param q game_obj_research
function create(q)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	--While q currently holds only default values we only need to store the reference for later use.
	Internal.Research.StoreResearchReference(q)
end

---Runs before research_done
---@param q game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number of the research that is completed, the number for the research as found in the debug (F6) of the research screen (upper left white number)
function research_done_before(q,res_number)
end

---Runs if research is done and when loading the game
---@param q game_obj_research the full reference to the game_research_item that is completed
---@param res_number number the number of the research that is completed, the number for the research as found in the debug (F6) of the research screen (upper left white number)
function research_done(q, res_number)
	Internal.Research.ProcessResearchCompletion(q, res_number)
	Internal.ComponentShop.RequestShopUpdate()
end