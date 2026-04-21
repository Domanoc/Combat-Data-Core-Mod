
---One time script when the game is started
---@param q game_obj_content_mechs
---@param v_modid string
function create(q,v_modid) -- one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--If its a game loaded from a save we dont add new items.
	if(Mod.Common.IsLoadedGame()) then
		return;
	end

	local componentTypes = Mod.Types.ComponentTypes;
	local nova_mech = Mod.Common.GetModdedComponent("example_mech", componentTypes.Mech);

	if(nova_mech ~= nil) then
		--add a nova mech on a new save
		Mod.Engineering.AddMech(nova_mech.index, "example_mech");
		Mod.Engineering.AddMech(nova_mech.index, "example_mech");
	end
end