# ModFramework - Adding a new weapon type

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_database.lua" in the create function

## Requirements
- Set the name to something that will be unique, as this can be used to find the reference later and across other mods that use the framework.
- 3 Sprites 
There is currently no support for custom sprite sizes in the framework. So for best results provide the sprites in the sizes as listed.
    - Small sprite (56x24)   
    The sprite is used in the production screen and in the inventory.   
    The sprite can be in color.   
    The sprite should have a transparent background.
    - Big sprite (398x134)   
    The sprite is when the weapon is placed in the engineer screen.   
    The sprite can be in color.   
    The sprite should have a transparent background.
    - Huge sprite (398x134)   
    This should be an alternative version for the big sprite, used when the weapon is made +Sized/Huge.   
    The sprite can be in color.   
    The sprite should have a transparent background.

## Code example
```lua
--load the mod framework
Mod = require("ModFrameworkModule")

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

--load needed types
local componentSizes = Mod.Types.ComponentSizes
local weaponTypes = Mod.Types.WeaponTypes

Mod.Database.AddWeapon({
    Name = 			    "example_weapon",	  --The name of the mech, used to find its references
    Description = {							  --the description text for a weapon. used when the weapon is added to the main slot in engineering.
        --Data that represents a string that will be localized. Its recommended to be in english for code readability
        --The other actual values will be pulled from the mods localization files
        --Use the GenerateLocalizationFiles() function to generate the mods localization files in development
        LocalizedDefaultValue = "Description text for this weapon."
    },
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
    WeaponType =	    weaponTypes.Kinetic,  --the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)
    FireRate =		    400,				  --the base fire rate. higher values offer a faster rate, 600 with full fire speed points will fill the fire speed bar completely
    Weight = 		    48,					  --the base weight of the weapon
    Accuracy = 		    5.0,				  --the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
    EnergyCost = 		5,					  --the base energy cost of the weapon
    Damage = 		    10,					  --the base damage value of the weapon
    Penetration = 	    1,					  --the base penetration value of the weapon
    ProjectileSpeed =   24,					  --the base projectile speed of the weapon
    IsEnergyBuffed =    false,				  --whether the energy cost boost damage output, for energy weapons this is an additional increase on their native bonus.
    BlueLength =        0,					  --the range of a blue weapon, default is 750
    SpriteSmall =       modFilepath.."sprites\\example_weapon_small.png",	--the small sprite for the weapon
    SpriteBig = 	    modFilepath.."sprites\\example_weapon_big.png",		--the big sprite for the weapon
    SpriteHuge = 	    modFilepath.."sprites\\example_weapon_huge.png",		--the huge sprite for the weapon
})
```

## Notes
The IsResearched, CanBeConstructed and GiveFreeItem flags will determines how this weapon is used by the framework.
- IsResearched = false, will expect that the weapon will be added to a research to unlock this.
- IsResearched = true, will enable the weapon from the game start provided CanBeConstructed = true is also set.
- CanBeConstructed = false, will not create a listing in the shop for this weapon.
- GiveFreeItem = true, will trigger a free weapon when a research unlocks this.

This type has [localization](../Localization.md) support.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)