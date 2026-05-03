
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	Internal.RegisterFramework()
	Internal.ComponentShop.LoadShopSprites()
	Internal.Settings.LoadMenuSprites()

	Internal.Settings.RegisterBooleanSetting("QuickMovePilots", true)
end

---saving system deletes the file and creates new one before saving new info
---@param q game_obj_database
function save_game_pre_event(q)
	Internal.Settings.SaveData()
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
	Internal.Settings.LoadData()
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
	Internal.Settings.DrawMenu()



	local obj_button_engineering = Internal.Common.GetObjButtonEngineering()
	local game_obj_big_holder = Internal.Common.GetObjBigHolder()
	Internal.Common.DrawDebugCursor({{Label= "obj_button_engineering.activated", Value = obj_button_engineering.activated}})
	Internal.Common.DrawDebugCursor({{Label= "game_obj_big_holder.cur_item", Value = game_obj_big_holder.cur_item}})
	Internal.Common.DrawDebugCursor({{Label= "IsSettingsMenuOpen", Value = Internal.Storage.IsSettingsMenuOpen}})
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end