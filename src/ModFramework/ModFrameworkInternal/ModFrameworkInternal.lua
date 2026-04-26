------------------------------------------------------------------------------
--- INTERNAL MODFRAMEWORK FUNCTIONS ------------------------------------------
------------------------------------------------------------------------------

---Access to the Common functions.
---@class ModFrameworkInternal
local ModFrameworkInternal = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Common functions.
ModFrameworkInternal.Common = Common

local Types = require("ModFrameworkTypes")
---Access to Types used by the framework.
ModFrameworkInternal.Types = Types

------------------------------------------------------------------------------

local Battle = require("ModFrameworkInternalBattle")
---Access to the internal functions for the Battle.
ModFrameworkInternal.Battle = Battle

local ComponentShop = require("ModFrameworkInternalComponentShop")
---Access to the functions for the Component shop.
ModFrameworkInternal.ComponentShop = ComponentShop

local Engineering = require("ModFrameworkInternalEngineering")
---Access to the internal functions for the Engineering tab.
ModFrameworkInternal.Engineering = Engineering

local Hanger = require("ModFrameworkInternalHanger")
---Access to the internal functions for the Hanger tab.
ModFrameworkInternal.Hanger = Hanger

local Production = require("ModFrameworkInternalProduction")
---Access to the internal functions for the Production tab.
ModFrameworkInternal.Production = Production

local Research = require("ModFrameworkInternalResearch")
---Access to the internal functions for the Research tab.
ModFrameworkInternal.Research = Research

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Registers the framework and loaded mods.
function ModFrameworkInternal.RegisterFramework()
	for index, path in pairs(mod_info) do
		local loadOrderId = tonumber(index:match("^(%d+)"))
		local modFileId = tonumber(index:match("(%d+)$"))

		if (loadOrderId ~= nil and modFileId == 2) then
			local normalizedPath = path:gsub("/","\\")
			local name = normalizedPath:match("mods\\([^\\]+)")
			local modPath = normalizedPath:gsub("obj_database.lua","")
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

	--Set a variable that mods can check before trying to load the framework
	variable_global_set("IsModFrameworkLoaded", true);
end

------------------------------------------------------------------------------
--- EXPORT MODFRAMEWORK INTERNALS --------------------------------------------
------------------------------------------------------------------------------

return ModFrameworkInternal