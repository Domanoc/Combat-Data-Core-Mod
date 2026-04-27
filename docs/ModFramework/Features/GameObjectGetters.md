# ModFramework - GameObjects getters

#### [Back to overview](../Overview.md)
---

A list of framework gameobject wrapper get functions. These functions provide a typed return so your IDE knows what kind of variable it gets.

This can help to ease the pain of not knowing what is inside a game object. However please note that the state of object can vary during gameplay. And some object might not be able to be retrieved at all points in the game.


### Note:
All functions expect the framework to be loaded in the file. Recommended place to load is the create function.
```lua
--load the mod framework as a global for use within this file
Mod = require("ModFrameworkModule")
```

### GetObjDatabase
returns the [game_obj_database](../../../src/ModFramework/GameClassDefinitions/game_obj_database.lua) variable
```lua
---Gets the reference for "obj_database"
Mod.Common.GetObjDatabase()
```
### GetObjComponentShop
returns the [game_obj_component_shop](../../../src/ModFramework/GameClassDefinitions/game_obj_component_shop.lua) variable
```lua
---Gets the reference for "obj_component_shop"
Mod.Common.GetObjComponentShop()
```
### GetObjComponent
returns the [game_obj_component](../../../src/ModFramework/GameClassDefinitions/game_obj_component.lua) variable
```lua
---Gets the reference for "obj_component"
Mod.Common.GetObjComponent()
```
### GetObjWeaponTest
returns the [game_obj_weapon_test](../../../src/ModFramework/GameClassDefinitions/game_obj_weapon_test.lua) variable
```lua
---Gets the reference for "obj_weapon_test"
Mod.Common.GetObjWeaponTest()
```
### GetObjResearchPanel
returns the [game_obj_research_panel](../../../src/ModFramework/GameClassDefinitions/game_obj_research_panel.lua) variable
```lua
---Gets the reference for "obj_research_panel"
Mod.Common.GetObjResearchPanel()
```
### GetObjContentCabins
returns the [game_obj_content_cabins](../../../src/ModFramework/GameClassDefinitions/game_obj_content_cabins.lua) variable
```lua
---Gets the reference for "obj_content_cabins"
Mod.Common.GetObjContentCabins()
```
### GetObjContentMotors
returns the [game_obj_content_motors](../../../src/ModFramework/GameClassDefinitions/game_obj_content_motors.lua) variable
```lua
---Gets the reference for "obj_content_motors"
Mod.Common.GetObjContentMotors()
```
### GetObjContentMechs
returns the [game_obj_content_mechs](../../../src/ModFramework/GameClassDefinitions/game_obj_content_mechs.lua) variable
```lua
---Gets the reference for "obj_content_mechs"
Mod.Common.GetObjContentMechs()
```
### GetObjContentWeapons
returns the [game_obj_content_weapons](../../../src/ModFramework/GameClassDefinitions/game_obj_content_weapons.lua) variable
```lua
---Gets the reference for "obj_content_weapons"
Mod.Common.GetObjContentWeapons()
```
### GetObjContentReactor
returns the [game_obj_content_reactor](../../../src/ModFramework/GameClassDefinitions/game_obj_content_reactor.lua) variable
```lua
---Gets the reference for "obj_content_reactor"
Mod.Common.GetObjContentReactor()
```
### GetObjContentPiston
returns the [game_obj_content_piston](../../../src/ModFramework/GameClassDefinitions/game_obj_content_piston.lua) variable
```lua
---Gets the reference for "obj_content_piston"
Mod.Common.GetObjContentPiston()
```
### GetObjContentInjector
returns the [game_obj_content_injector](../../../src/ModFramework/GameClassDefinitions/game_obj_content_injector.lua) variable
```lua
---Gets the reference for "obj_content_injector"
Mod.Common.GetObjContentInjector()
```
### GetObjContentKernel
returns the [game_obj_content_kernel](../../../src/ModFramework/GameClassDefinitions/game_obj_content_kernel.lua) variable
```lua
---Gets the reference for "obj_content_kernel"
Mod.Common.GetObjContentKernel()
```
### GetObjContentSafety
returns the [game_obj_content_safety](../../../src/ModFramework/GameClassDefinitions/game_obj_content_safety.lua) variable
```lua
---Gets the reference for "obj_content_safety"
Mod.Common.GetObjContentSafety()
```
### GetObjContentMagnet
returns the [game_obj_content_magnet](../../../src/ModFramework/GameClassDefinitions/game_obj_content_magnet.lua) variable
```lua
---Gets the reference for "obj_content_magnet"
Mod.Common.GetObjContentMagnet()
```
### GetObjContentSolenoid
returns the [game_obj_content_solenoid](../../../src/ModFramework/GameClassDefinitions/game_obj_content_solenoid.lua) variable
```lua
---Gets the reference for "obj_content_solenoid"
Mod.Common.GetObjContentSolenoid()
```
### GetObjContentPilots
returns the [game_obj_content_pilots](../../../src/ModFramework/GameClassDefinitions/game_obj_content_pilots.lua) variable
```lua
---Gets the reference for "obj_content_pilots"
Mod.Common.GetObjContentPilots()
```

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
