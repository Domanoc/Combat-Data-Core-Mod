
---One time script when the game is started
---@param q game_obj_content_magnet
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--This function is run everytime the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we dont want to add new items on loaded saves we return the function here.
		return;
	end

	for i = 0, 2, 1 do
		for o = 1, 10, 1 do
			Mod.Engineering.AddMagnet(i);
		end
	end
end