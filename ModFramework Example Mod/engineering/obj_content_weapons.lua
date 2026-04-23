
---One time script when the game is started
---@param q any
function create(q)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--This function is run everytime the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we dont want to add new items on loaded saves we return the function here.
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