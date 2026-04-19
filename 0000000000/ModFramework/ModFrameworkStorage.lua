--------------------------
--Storage-----------------
--------------------------

---Access to the Storage of mod framework variables.
local Storage = {};

---A list of the modded components. So we can reference them later.
---@type modded_component[]
Storage.ModdedComponentList = {};

---We keep a list of all the researches the game has active. So we can reference them later.
---@type game_obj_research[]
Storage.LoadedResearchList = {};

---We keep a list of the modded researches. So we can reference them later.
---@type modded_research_item[]
Storage.ModdedResearchList = {};

return Storage;