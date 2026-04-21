--------------------------
-- GLOBAL MOD FUNCTIONS --
--------------------------
local Module = {};

local Types = require("ModFrameworkTypes");
---Access to Types used by the framework.
Module.Types = Types;

local Common = require("ModFrameworkCommon");
---Access to the Common functions.
Module.Common = Common;

local Engineering = require("ModFrameworkEngineering");
---Access to the functions for the Engineering tab.
Module.Engineering = Engineering;

local Production = require("ModFrameworkProduction");
---Access to the functions for the Production tab.
Module.Production = Production;

local Research = require("ModFrameworkResearch");
---Access to the functions for the Research tab.
Module.Research = Research;

local Battle = require("ModFrameworkBattle");
---Access to the functions for the Battle.
Module.Battle = Battle;

local Database = require("ModFrameworkDatabase");
---Access to the functions for the Database.
Module.Database = Database;

return Module;

--Hello