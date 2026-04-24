---@type game_obj_component_shop?
local obj_component_shop = nil;

---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)

	--Make sure the paths in mod_info all use the same slashes style
	for index, path in pairs(mod_info) do
		mod_info[index] = path:gsub("/","\\")
	end

	--path to the current file
	local currentFilePath = (mod_info[v_modid]):gsub("obj_database.lua","")

	--Add current mod path to the package.path
	--This ensures we can load the mod framework in every file in every mod
	local modFramework = ";"..currentFilePath.."ModFramework\\?.lua"
	local modFrameworkInternal = ";"..currentFilePath.."ModFrameworkInternal\\?.lua"
	package.path = package.path..modFramework..modFrameworkInternal

	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")

	--Register the framework
	Internal.RegisterFramework()

	--we change the shop sprite to allow better rearranging of the items
	local engineeringSprite = asset_get_index("spr_back_shop")
	show_message(engineeringSprite)
	sprite_replace(engineeringSprite, currentFilePath.."sprites\\spr_back_shop.png", 1, false, false, 0, 0)

	local robotSprite = asset_get_index("spr_engineer_robot")
	sprite_replace(robotSprite, currentFilePath.."sprites\\spr_engineer_robot.png", 1, false, false, 0, 0)

	obj_component_shop = Mod.Common.GetObjComponentShop();

	--TODO LIST
	--For existing mods::

	--Improve the production slot selection for new items

	--Show example of solenoid modding and adding
	--Support for pilot modding
	--Show example of pilot modding and adding

	--Nice to haves::

	--Support for cabin modding
	--Show example of cabin modding and adding
	--Support for motor modding
	--Show example of motor modding and adding
	--Support for reactor modding
	--Show example of reactor modding and adding

	--Support for magnet modding
	--Show example of magnet modding and adding
	--Support for injector modding
	--Show example of injector modding and adding
	--Support for piston modding
	--Show example of piston modding and adding
	--Support for armor modding
	--Show example of armor modding and adding
	--Support for kernel modding
	--Show example of kernel modding and adding
	--Support for safety modding
	--Show example of safety modding and adding

	--Review documetation

	--resize spr_engineer_robot.png to fit within the component square
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

---The draw call thay runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	Internal.Production.SetModdedWeaponDescriptions()
	Internal.Production.FixShopComponents()
	Internal.Research.FixModdedResearch()

	local keys = Mod.Types.VirtualKeys
	local mouseButtons = Mod.Types.MouseButtons
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	if (obj_component_shop ~= nil and obj_component_shop.activated == true) then
		if keyboard_check_pressed(keys.F10) then
			--Mod.Common.DumpObjToMessage(obj_component_shop)
    	end
		if (mouse_check_button_pressed(mouseButtons.Left)) then
			--show_message("coord: "..mx..","..my)
		end
	end
end

---The draw call thay runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end