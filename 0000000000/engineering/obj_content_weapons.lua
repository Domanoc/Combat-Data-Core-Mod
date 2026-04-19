
---One time script when the game is started
---@param q any
function create(q)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--If its a game loaded from a save we dont add new items.
	if(Mod.Common.IsLoadedGame()) then
		return;
	end

	for i = 1, 11, 1 do
		for o = 1, 8, 1 do
			Mod.Engineering.AddWeapon(i, false);
		end
		for h = 1, 8, 1 do
			Mod.Engineering.AddWeapon(i, true);
		end
	end
end