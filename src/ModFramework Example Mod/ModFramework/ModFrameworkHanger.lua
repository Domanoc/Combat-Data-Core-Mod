------------------------------------------------------------------------------
--- HANGER FUNCTIONS -----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Hanger tab.
---@class ModFrameworkHanger
local Hanger = {}

---Access to the private functions in this file.
---@class ModFrameworkHangerPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Add a new pilot to the hanger
---@param pilotData PilotData dataset for adding a new pilot
function Hanger.AddPilot(pilotData)
    table.insert(Storage.PilotDataQueue, pilotData)
end

------------------------------------------------------------------------------
--- EXPORT HANGER ------------------------------------------------------------
------------------------------------------------------------------------------

return Hanger