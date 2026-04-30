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
Mod = require("ModFramework")

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

--An example for creating a modded pilot template
Mod.Database.AddPilotTemplate({
	Name = "EMOTICON",		 --The name of the pilot, also used as a value to lookup the reference, Recommended to use full uppercase as this is what the game does.
	Level = 1,				 --The level of the pilot.
	LevelExperience = 0,	 --The amount of experience in the current level.
	Skill = 42,				 --The skill stat of the pilot (0-100).
	Reaction = 30,			 --The reaction stat of the pilot (0-100).
	Vitality = 10,			 --The vitality stat of the pilot (0-100).
	StressResistance = 5,	 --The stress resistance stat of the pilot (0-100).
	Voice = "male_hispanic", --The voice used by the pilot.
	SpritePath = modFilepath.."sprites\\example_pilot.png" --The filepath for the pilot sprite sheet. (expected 184x46 pixels, 4 frames)
})
```

## Notes
There is no option to add new voices/sounds to the game.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)