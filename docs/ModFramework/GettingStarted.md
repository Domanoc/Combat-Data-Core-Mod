# ModFramework - Getting started

In this guide we will explain how to setup a new ModFramework mod from scratch. If have some mech engineer modding experience already you can skip this and lookup the functions you want to use directly.

## Creating the mod folder
There are several options
- Create a folder and it contents manually
- Copy an existing mod folder
- Or we can use the template "[ModTemplate](../../src/ModTemplate/)" provided in this repo

This guide will assume that we are creating the mod using the "ModTemplate" files.
- Download the template
- Go to your C:\Users\\%USERNAME%\AppData\Local\Mech_Engineer\mods\ folder
- Place the template in the folder and rename it to your mods desired name

## Explaining the contents
Lets go over the contents in your new mod

```text
ModTemplate/
├── GameClassDefinitions/
├── ModFramework/
├── sprites/
├── mod_mech_grid_help.png
├── obj_database.lua
├── info.txt
├── readme.txt
└── thumbnail.jpg
```

- The 2 folders "GameClassDefinitions" and "ModFramework" can be ignored.   
   
   They contain reference files so you IDE (Integrated Development Environment) can understand what types and function are available. You don't have to do anything with the contents. However if your are updating you mod to use a newer version of the ModFramework. Then replace these folders with the ones from the ModTemplate in this repo.
- The "sprites" folder is the place where you can add the mod sprites. If you don't plan on modding sprites it can safely be removed.
- mod_mech_grid_help.png is a helper spite explaining the coordinate system used by the mechs.
- obj_database.lua this is your starting point for programming in your mod
- info.txt contains the info on what your mod does, by default it only has a value for "thumbnail.jpg" as the template provides this.
   
   Other possible values include: Mechs, Weapons, Reactors, Modules, Battles, Global map, City, Textures, Balance, Translation, Gamemode

   When releasing you mod to the steam workshop this file should reflect what you mod does. For example if the mod adds or edits mechs you can add the "Mechs" value on a new line.
- readme.txt you can include any readme info for your mod.
- thumbnail.jpg this is the same file as provided by the games example mod. When before releasing your mod to the steam workshop its recommended to edit to reflect your mod.
   Note: the original image is 196by196 but this is not the size limit for steam and a larger image can be included.

## obj_database.lua
This is the starting point for your code. In here your are able to to interact with the game directly or through the framework. Lets go over what is included in the template

First we have the create function, this function is called by the game on startup. Many of the default mod files have this function. It can be used as an constructor of sorts. The game runs several of these create functions in order of mod load order. When using the mod framework its recommended to check if the Framework is loaded before using it. To do this the function CheckForModFramework() is provided. Last we can load the framework as a global to use throughout the file.   
Note: Global variables are sandboxed to stay within the file itself and cannot be accessed in other files. There are ways to interact across files, the ModFramework is one of them.
```lua
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--Check if the ModFramework can be found
	CheckForModFramework()
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

    --Your code here
end
```

## IDE Setup recommendation
The ModFramework was made using the following setup.
- VScode
- Using the extension "Lua" by "sumneko"
- using the following vscode settings
```json
{
    "Lua.diagnostics.enable": true,
    "Lua.diagnostics.disable": [
        "lowercase-global"
    ],
    "Lua.diagnostics.globals": [],
    "Lua.diagnostics.severity": {
        "undefined-field": "Warning"
    },
}
```

Using this setup will allow you to get type info while you write code. The "ModTemplate" provides the needed definition files for the lua language server to understand the game and framework types and functions.   
Note: The game object documentation is a work in progress don't take the provided documentation as law and do you own testing. Any feedback on this can be provided on this repo.

## The creative process
Now all that remains the the creative process. And to get you going some starting points.

- [Take a look at the functions the framework provides.](./Overview.md)
- Check out the "[ModFramework Example Mod](../../src/ModFramework%20Example%20Mod/)" as it provides basic examples on the framework features.
- Check out what existing mods do.
- Ask your questions on the mech engineer discord in the #mods-discussions
- Finally a [how to steam workshop upload instruction](./UploadingModToSteamWorkshop.md)

Good luck and happy modding.

---
##### [Home](../../readme.md)