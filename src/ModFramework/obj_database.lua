
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	Internal.RegisterFramework()
	Internal.ComponentShop.LoadShopSprites()
end

---saving system deletes the file and creates new one before saving new info
---@param q game_obj_database
function save_game_pre_event(q)
end

---@param q game_obj_database
function save_game_post_event(q)
end

---@param q game_obj_database
function load_game_pre_event(q)
end

---Called after the game is loaded
---@param q game_obj_database
function load_game_post_event(q)
	Internal.Production.SetModdedSprites()
end

---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	Internal.Production.SetModdedWeaponDescriptions()
	Internal.Production.StoreShopComponents()
	Internal.ComponentShop.RearrangeShopComponents()
	Internal.ComponentShop.FixRobotComponentBleed()
	Internal.Research.FixModdedResearch()
	Internal.Hanger.ProcessPilotDataQueue()
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end