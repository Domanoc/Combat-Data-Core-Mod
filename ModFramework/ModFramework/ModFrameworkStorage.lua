------------------------------------------------------------------------------
--- STORAGE ------------------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
---@class ModFrameworkStorage
local Storage = {}

------------------------------------------------------------------------------


---@type string the language file setting that is seleced, example "loc_english.ini"
Storage.SelectedLanguage = ""

---A list of the registered mods
---@type ModRegistration[]
Storage.ModRegistrations = {}

---A list of the modded components. So we can reference them later.
---@type ModdedComponent[]
Storage.ModdedComponentList = {}

---We keep a list of all the researches the game has active. So we can reference them later.
---@type game_obj_research[]
Storage.LoadedResearchList = {}

---We keep a list of the modded researches. So we can reference them later.
---@type ModdedResearch[]
Storage.ModdedResearchList = {}

---We keep a list of the shop components. So we can reference them later.
---@type game_obj_component[]
Storage.AllShopComponents = {}

---We keep a list of the shop weapon components. So we can reference them later.
---@class WeaponsComponents
---@field kineticWeapons game_obj_component[] kinetic weapons
---@field missileWeapons game_obj_component[] missile weapons
---@field energyWeapons game_obj_component[] energy weapons
---@field thermalWeapons game_obj_component[] thermal weapons
local WeaponsComponents = {
    kineticWeapons = {},
    missileWeapons = {},
    energyWeapons = {},
    thermalWeapons = {}
}
Storage.WeaponsComponents = WeaponsComponents

---The reference to a left button
---@type number
Storage.SpriteShopButtonLeft = -1

---The reference to a right button
---@type number
Storage.SpriteShopButtonRight = -1

------------------------------------------------------------------------------
--- EXPORT STORAGE -----------------------------------------------------------
------------------------------------------------------------------------------

return Storage