# ModFramework - Adding a new mech type

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_database.lua"

## Requirements

- Set the name to something that will be unique, as this can be used to find the reference later and across other mods that use the framework.
- 6 Sprites (2 optional)   
There is currently no support for custom sprite sizes in the framework. So for best results provide the sprites in the sizes as listed.
    - Small sprite (46x49)   
    The sprite is used in the production screen.   
    The sprite can be in color.   
    The sprite should have a transparent background.
    - Big sprite (400x343)   
    The sprite is when the mech is placed in the engineer screen.   
    The sprite can be in color.   
    The sprite should have a transparent background.
    - Battle sprite (100x50)   
    This is a sprite sheet with 2 frames of (50x50)   
    The first frame is an idle state.   
    The second frame is a firing state.
    The sprite is in gray scale.   
    The sprite should have a transparent background.
    - Death sprite (50x50)   
    The sprite is used to show the destroyed/death mech
    The sprite is in gray scale.   
    The sprite should have a transparent background.
    - Melee horizontal sprite (350x50)   
    This Sprite is optional if the mech is marked with "HasMelee = false"
    This is a sprite sheet with 7 frames of (50x50)   
    It should show an animation of an melee attack.   
    The sprite is in gray scale.   
    The sprite should have a transparent background.
    - Melee vertical sprite (350x50)   
    This Sprite is optional if the mech is marked with "HasMelee = false"
    This is a sprite sheet with 7 frames of (50x50)   
    It should show an animation of an melee attack.   
    The sprite is in gray scale.   
    The sprite should have a transparent background.

## Code example
```lua
--load the mod framework
Mod = require("ModFrameworkModule")

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

--load needed types
local mechModules = Mod.Types.MechModules

Mod.Database.AddMech({
    Name = 			   "example_mech",		 --The name of the mech, used to find its references
    ComponentSize =    componentSizes.Large, --The size of the component when constructing it. 1 for single slot or 5 for a full row
    IsResearched = 	   false,				 --Set to true if its pre researched, else false.
    CanBeConstructed = true,				 --Set to true if it can be constructed in the component shop, false otherwise
    GiveFreeItem = 	   true,				 --Set to true to return a free copy when triggered as an unlock
    PriceMetallite =   1000,				 --The amount of metallite needed to produce this mech
    PriceBjorn = 	   1000,				 --The amount of bjorn needed to produce this mech
    PriceMunilon =     1000,				 --The amount of munilon needed to produce this mech
    PriceSkalaknit =   1000,				 --The amount of skalaknit needed to produce this mech
    PriceStaff = 	   10,					 --The amount of staff needed to produce this mech
    ProductionDays =   2,					 --The amount of days it takes to produce this mech
    HeatResist = 	   10,					 --The heat resist value of the mech
    ImpactResist =     10,					 --The impact resist value of the mech
    CurrentResist =    10,					 --The current resist value of the mech
    HasMelee = 	   	   true,				 --Indicates if the mech can use a melee weapon, if true the sprites for vertical and horizontal are expected
    PassiveArmor =     0,					 --The amount of passive armor the mech has
    Weight = 		   60,					 --The base weight of the mech
    Speed = 		   0.4,					 --The base speed of the mech
    ReloadTime = 	   3,					 --The base reload time of the mech
    BattleTime = 	   3,					 --The base battle time of the mech (the length of time it has ammo reserves for to shoot)
    MechCells = {
        --cabin, the game is design for mechs to have only 1 cabin. adding more might result in issues	or unexpected behavior
        {ModuleType = mechModules.Cabin, 	X =   0, Y = 22}
        --reactor, the game is design for mechs to have only 1 reactor. adding more might result in issues	or unexpected behavior
        ,{ModuleType = mechModules.Reactor, X =   0, Y = 15} 
        ,{ModuleType = mechModules.Motor, 	X =   5, Y =  4} --motor 1, you can add more motors.
        ,{ModuleType = mechModules.Motor, 	X =  -5, Y =  4} --motor 2
        ,{ModuleType = mechModules.Motor, 	X =   5, Y =  9} --motor 3
        ,{ModuleType = mechModules.Motor, 	X =  -5, Y =  9} --motor 4
        ,{ModuleType = mechModules.Weapon, 	X =  10, Y = 16} --gun 1, you can add a maximum of 12 guns, the game throws errors when a mech has more
        ,{ModuleType = mechModules.Weapon, 	X = -10, Y = 16} --gun 2
        ,{ModuleType = mechModules.Aux, 	X =   6, Y = 23} --aux 1, you can add more auxiliary slots.
        ,{ModuleType = mechModules.Aux, 	X =  -6, Y = 23} --aux 2
    },
    SpriteSmall = 			modFilepath.."sprites\\example_mech_small.png", 			--The sprite used at the production screen
    SpriteBig = 			modFilepath.."sprites\\example_mech_big.png",				--The paintable mech sprite
    SpriteBattle = 		  	modFilepath.."sprites\\example_mech_battle.png",			--The shoot and idle frames during battle
    SpriteBattleDead = 	  	modFilepath.."sprites\\example_mech_dead.png",				--The death sprite when the mech gets destroyed during battle
    SpriteMeleeVertical = 	modFilepath.."sprites\\example_mech_melee_vertical.png",    --The animation atlas for a vertical melee, optional if the mech has no melee
    SpriteMeleeHorizontal = modFilepath.."sprites\\example_mech_melee_horizontal.png"   --The animation atlas for a horizontal melee,  optional if the mech has no melee
})
```

## Notes
The IsResearched, CanBeConstructed and GiveFreeItem flags will determines how this mech is used by the framework.
- IsResearched = false, will expect that the mech will be added to a research to unlock this.
- IsResearched = true, will enable the mech from the game start provided CanBeConstructed = true is also set.
- CanBeConstructed = false, will not create a listing in the shop for this mech
- GiveFreeItem = true, will trigger a free mech when a research unlocks this.

---
##### [Home](../../../readme.md)