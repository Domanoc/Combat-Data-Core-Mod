
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)

	--Make sure the paths in mod_info all use the same slashes style
	for index, path in pairs(mod_info) do
		mod_info[index] = path:gsub("/","\\");
	end

	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("obj_database.lua","");

	--Add current mod path to the package.path
	--This ensures we can load the mod framework in every file in every mod
	local mod_framework = current_file_path .. "ModFramework\\?.lua";
	package.path = package.path .. ";" .. mod_framework

	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal");

	--Register the framework
	Internal.RegisterFramework();

	local values = {};

	for i = 0, 149, 1 do
		table.insert(values, i);
	end
	local message = table.concat(values, "|");
	show_message(message);

	--TODO LIST
	--For existing mods::

	--Show example of research modding and adding
	--Moving existing research
	--Relinking existing research
	--Adding unlocks to existing research

	--Show example of mech modding and adding


	--Show example of weapon modding and adding
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
	Internal.LoadModdedSpritesOnProductionItems();
end

---The draw call thay runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	Internal.FixWeaponDescriptions();
	Internal.FixModdedResearch();
	
	local keys = Mod.Types.VirtualKeys;
	if keyboard_check_pressed(keys.F9) then
		Mod.Common.ShowMessage("Unlocking all Research.");
		Mod.Research.UnlockAllResearch();
    end
end

function draw_debug(q)
end