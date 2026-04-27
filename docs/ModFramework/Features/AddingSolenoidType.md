# ModFramework - Adding a new solenoid type

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_database.lua" in the create function

## Requirements
- Set the name to something that will be unique, as this can be used to find the reference later and across other mods that use the framework.
- 1 Sprite
There is currently no support for custom sprite sizes in the framework. So for best results provide the sprites in the sizes as listed.
    - Small sprite (32x32)   
    The sprite is used in the production screen and in the inventory.   
    The sprite can be in color.   
    The sprite should have a transparent background.

## Code example
```lua
Mod = require("ModFrameworkModule")

Mod.Common.GenerateLocalizationFiles()

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

--load needed types
local componentSizes = Mod.Types.ComponentSizes

Mod.Database.AddSolenoid({
    Name = "example_solenoid",
    ComponentSize =     componentSizes.Small, --The size of the component when constructing it. 1 for single slot or 5 for a full row
    IsResearched = 	    false,				  --Set to true if its pre researched, else false.
    CanBeConstructed =  true,				  --Set to true if it can be constructed in the component shop, false otherwise
    GiveFreeItem = 	    true,				  --Set to true to return a free copy when triggered as an unlock
    PriceMetallite =    1000,				  --The amount of metallite needed to produce this weapon
    PriceBjorn = 	    1000,				  --The amount of bjorn needed to produce this weapon
    PriceMunilon =      1000,				  --The amount of munilon needed to produce this weapon
    PriceSkalaknit =    1000,				  --The amount of skalaknit needed to produce this weapon
    PriceStaff = 	    10,					  --The amount of staff needed to produce this weapon
    ProductionDays =    2,					  --The amount of days it takes to produce this weapon
    Power = 		    2,					  --the power value of the solenoid, lower numbers give more heat resist on reactor
    Induction = 	    0.75,				  --the induction value of the solenoid, any deviation from 1 gives worse energy stats
    Sprite = 		    modFilepath.."sprites\\example_solenoid.png"
})
```

## Notes
The IsResearched, CanBeConstructed and GiveFreeItem flags will determines how this solenoid is used by the framework.
- IsResearched = false, will expect that the solenoid will be added to a research to unlock this.
- IsResearched = true, will enable the solenoid from the game start provided CanBeConstructed = true is also set.
- CanBeConstructed = false, will not create a listing in the shop for this solenoid
- GiveFreeItem = true, will trigger a free solenoid when a research unlocks this.

---
##### [Home](../../../readme.md)