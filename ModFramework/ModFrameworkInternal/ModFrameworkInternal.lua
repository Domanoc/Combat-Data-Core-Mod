------------------------------------------------------------------------------
--- INTERNAL MODFRAMEWORK FUNCTIONS ------------------------------------------
------------------------------------------------------------------------------

---Access to the Common functions.
---@class ModFrameworkInternal
local Module = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

local Battle = require("ModFrameworkInternalBattle")
---Access to the internal functions for the Battle.
Module.Battle = Battle

local ComponentShop = require("ModFrameworkInternalComponentShop")
---Access to the functions for the Component shop.
Module.ComponentShop = ComponentShop

local Engineering = require("ModFrameworkInternalEngineering")
---Access to the internal functions for the Engineering tab.
Module.Engineering = Engineering

local Production = require("ModFrameworkInternalProduction")
---Access to the internal functions for the Production tab.
Module.Production = Production

local Research = require("ModFrameworkInternalResearch")
---Access to the internal functions for the Research tab.
Module.Research = Research

------------------------------------------------------------------------------

---Registers the framework and loaded mods.
function Module.RegisterFramework()
	for index, path in pairs(mod_info) do
		local loadOrderId = tonumber(index:match("^(%d+)"))
		local modFileId = tonumber(index:match("(%d+)$"))

		if (loadOrderId ~= nil and modFileId == 2) then
			local name = path:match("mods\\([^\\]+)")
			local modPath = path:gsub("obj_database.lua","")
			---@type ModRegistration
			local mod = {
				LoadOrderId = loadOrderId,
				Name = name,
				Path = modPath,
			}
			table.insert(Storage.ModRegistrations, mod)

			if (name == "ModFramework" and loadOrderId ~= 1) then
				Common.ShowError("The ModFramework was not first in the mod load order. This can lead to issues.")
			end
		end
	end

	local language = variable_global_get("language_file"):gsub("/","\\"):match("^.+\\(.+)$")
	Storage.SelectedLanguage = language
end

------------------------------------------------------------------------------
--- EXPORT MODFRAMEWORK INTERNALS --------------------------------------------
------------------------------------------------------------------------------

return Module