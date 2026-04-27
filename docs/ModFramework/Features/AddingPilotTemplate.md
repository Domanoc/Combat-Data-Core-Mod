# ModFramework - Adding a new pilot template

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_database.lua" in the create function.

## Requirements
- Set the name to something that will be unique, as this can be used to find the reference later and across other mods that use the framework.
- 1 Sprite
There is currently no support for custom sprite sizes in the framework. So for best results provide the sprites in the sizes as listed.
    - Small sprite (184x46)   
    This is a sprite sheet with 4 frames of (46x46)   
    First frame is a idle/neutral expression.   
    Second frame is a surprised/scared expression.   
    Third frame is a in the zone expression.   
    Fourth frame is a cybernetic version of the pilot.
    The sprite is used by pilots that reference to this template
    The sprite can be in color.   
    The sprite should have a transparent background.

## Code example
```lua
--load the mod framework
Mod = require("ModFrameworkModule")

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

Mod.Database.AddPilotTemplate({
    Name = "EMOTICON",
    Level = 1,
    LevelExperience = 0,
    Skill = 42,
    Reaction = 30,
    Vitality = 10,
    StressResistance = 5,
    Voice = "male_hispanic",
    Sprite = modFilepath.."sprites\\example_pilot.png"
})
```

## Notes
There is no option to add new voices/sounds to the game.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)