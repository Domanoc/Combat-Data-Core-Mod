
---One time script when the game is started
---@param q game_obj_language
---@param v_modid string
function language(q,v_modid)
	--path to the current file
	local currentFilePath = (mod_info[v_modid]):gsub("language.lua","")

	--Add current mod path to the package.path
	--This ensures we can load the mod framework in every file in every mod
	--We do this in the language.lua since this is the first code that gets run.
	local modFramework = ";"..currentFilePath.."ModFramework\\?.lua"
	local modFrameworkInternal = ";"..currentFilePath.."ModFrameworkInternal\\?.lua"
	package.path = package.path..modFramework..modFrameworkInternal

	--We wait for the rest of the mod registration until obj_database.lua
	--So the translation mods have time to set the language
end