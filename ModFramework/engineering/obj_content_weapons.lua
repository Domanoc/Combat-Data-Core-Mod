
---One time script when the game is started
---@param q any
function create(q)--one time script when save is loaded
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	Internal.Production.FixContentWeaponList()
end