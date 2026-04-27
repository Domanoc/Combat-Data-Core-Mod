# ModFramework - Changing Research

### Note:
All functions expect the framework to be loaded in the file. Recommended place to load is the create function.
```lua
--load the mod framework as a global for use within this file
Mod = require("ModFrameworkModule")
```

## Recommended usage
use in "obj_research_panel.lua" in the create function.

## Get modded research
```lua
--We can retrieve the data of a research that was added by the framework, even if it was made by another mod.
--However if loading one from another mod, that mod has to be before this mod in the load order.
--Return will be nil if the object could not be found.
local example = Mod.Common.GetModdedResearch("example_research")
```
## Add an unlock to an existing research
```lua
--load needed types
local componentTypes = Mod.Types.ComponentTypes
local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers

--We can search for a single component to add as an unlock to an existing research
local unlock = Mod.Common.GetModdedComponent("example_weapon", componentTypes.Weapon)
--The existing research can be a base research or one from another mod.
--However if adding one to a research from another mod that mod has to be before this mod in the load order.
Mod.Research.AddUnlock(baseResearchResNumbers.TANK_GUN, unlock)
```
## Move existing research
```lua
--load needed types
local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers

--We can move any research to a new position and it will keep its links.
Mod.Research.MoveResearch(baseResearchResNumbers.ROCKET_LAUNCH, 0)
```
## Relink existing research
```lua
--load needed types
local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers

--We can relink a research to a new prerequisite research.
Mod.Research.ChangePrerequisite(baseResearchResNumbers.PROCESSOR_PROGRAMS, baseResearchResNumbers.REPAIR_SHOP)
```
## Clear all existing links
```lua
--load needed types
local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers

--We can clear the links a research has to make it easier to rearrange the tech tree.
Mod.Research.ClearUnlockLinks(baseResearchResNumbers.NEW_MECH_PLATE)
```

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
