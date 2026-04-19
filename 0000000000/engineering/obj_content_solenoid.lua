
---One time script when the game is started
---@param q any
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--If its a game loaded from a save we dont add new items.
	if(Mod.Common.IsLoadedGame()) then
		return;
	end

	for i = 1, 10, 1 do
		Mod.Engineering.AddSolenoid(1);
	end
end