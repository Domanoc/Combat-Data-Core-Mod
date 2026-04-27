# ModFramework - Adding a new research

#### [Back to overview](../Overview.md)
---

## Recommended usage
use in "obj_research_panel.lua" in the create function.

## Requirements
- Set the name to something that will be unique, as this can be used to find the reference later and across other mods that use the framework.
- 1 Sprite
There is currently no support for custom sprite sizes in the framework. So for best results provide the sprites in the sizes as listed.
    - Small sprite (47x63)   
    The sprite is used in the tech tree.   
    The sprite can be in color.   
    The sprite should have a transparent background.

## Code example
```lua
--load the mod framework
Mod = require("ModFrameworkModule")

--path to the mod folder
local modFilepath = Mod.Common.GetModPath()

--load needed types
local researchIcons = Mod.Types.ResearchIcons
local researchConditions = Mod.Types.ResearchConditions
local componentTypes = Mod.Types.ComponentTypes
local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers

--When we want a research to include an unlock we need to include the references.
--An component that is added as research unlock will, add a copy on completion and or unlock the production of item based on this setting.
--With this function we can get our modded components that we made in "obj_database.lua".
local unlocks = Mod.Common.GetModdedComponents({
    { Name = "example_mech", ComponentType = componentTypes.Mech }
})

--We can create a new research and as a return value we get the new res number to create links with.
local exampleResearchResNumber = Mod.Research.AddResearch({
    Name = "example_research_1",							--the name of the research, used to find its reference
    Position = 40,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
    PrerequisiteResearchResNumber = 						--the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
        baseResearchResNumbers.FIRST_GENERATION_ENGINE,
    Condition = researchConditions.Opened,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
    RequiredDays = 4,										--the required days to complete the research
    RequiredStaff = 10,										--the required available staff to start the research
    ResearchIcon = researchIcons.Research,					--the info on what icon to use
    Description = {											--the description text for the research
        --Data that represents a string that will be localized. Its recommended to be in english for code readability
        --The other actual values will be pulled from the mods localization files
        --Use the GenerateLocalizationFiles() function to generate the mods localization files in development
        LocalizedDefaultValue = "Example Research 1:#Text that will explain what this unlocks."
    },
    SpritePath = 											--path to the sprite used for the research
        modFilepath.."sprites\\example_research.png",
    UnlockedComponents = unlocks							--the components that are unlocked by this research
})
```

## Notes
This type has [localization](../Localization.md) support.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)