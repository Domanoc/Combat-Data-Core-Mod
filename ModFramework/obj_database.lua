
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

	-- you can change sprites with this
	local engineringSprite = asset_get_index("spr_back_shop")
	sprite_replace(engineringSprite, currentFilePath.."sprites\\spr_back_shop.png", 1, false, false, 0, 0)

	--TODO LIST
	--For existing mods::

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

	--Improve the production slot selection for new items

	--Review documetation

	--localization???
end

---saving system deletes the file and creates new one before saving new info
---@param q any
function save_game_pre_event(q)
end

function save_game_post_event(q)
end

function load_game_pre_event(q)
end

function load_game_post_event(q)
	Internal.Production.SetModdedSprites()
end

---The draw call thay runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	Internal.Production.SetModdedWeaponDescriptions()
	Internal.Research.FixModdedResearch()

	local keys = Mod.Types.VirtualKeys
	if keyboard_check_pressed(keys.F9) then
		Mod.Common.ShowMessage("Unlocking all Research.")
		Mod.Research.UnlockAllResearch()
    end

	if keyboard_check_pressed(keys.F10) then		
		local obj_component_shop = Mod.Common.GetObjComponentShop()

		local comp_beacon = 			obj_component_shop.comp_beacon
		local comp_cabin = 				obj_component_shop.comp_cabin
		local comp_city_parts = 		obj_component_shop.comp_city_parts
		local comp_engineer = 			obj_component_shop.comp_engineer
		local comp_injector = 			obj_component_shop.comp_injector
		local comp_kernel = 			obj_component_shop.comp_kernel
		local comp_lr_armor_end = 		obj_component_shop.comp_lr_armor_end
		local comp_lr_armor_middle = 	obj_component_shop.comp_lr_armor_middle
		local comp_magnet = 			obj_component_shop.comp_magnet
		local comp_mech = 				obj_component_shop.comp_mech
		local comp_motor = 				obj_component_shop.comp_motor
		local comp_piston = 			obj_component_shop.comp_piston
		local comp_reactor = 			obj_component_shop.comp_reactor
		local comp_rocket = 			obj_component_shop.comp_rocket
		local comp_safety = 			obj_component_shop.comp_safety
		local comp_solenoid = 			obj_component_shop.comp_solenoid
		local comp_wep = 				obj_component_shop.comp_wep

		Mod.Common.DumpObjToMessage(comp_wep)
    end
end

function draw_debug(q)
end