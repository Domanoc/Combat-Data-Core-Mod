# ModFramework - Adding a safety object

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_content_safety.lua" in the create function, for when adding items to a new game.

## Code example
```lua
---One time script when the game is started
---@param q game_obj_content_safety
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--This function is run every time the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we don't want to add new items on loaded saves we return the function here.
		return
	end

	--load needed types
	local baseSafety = Mod.Types.BaseSafety

	--If we want to add a base safety we can use the Mod.Types.BaseSafety references to add the correct one
	Mod.Engineering.AddSafety(baseSafety)
	Mod.Engineering.AddSafety(baseSafety)
end
```

## Notes
This can also be used in other places. Depending on you mods requirements.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)