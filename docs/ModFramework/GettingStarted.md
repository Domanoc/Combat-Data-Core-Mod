# ModFramework - Getting started

In this guide we will explain how to create a new ModFramework mod from scratch. If have some mech engineer modding experience already you can skip this lookup the functions you want to use directly.

## Creating the mod folder
There are several options
- Create a folder and it contents manually
- Copy an existing mod folder
- Or we can use the template "ModTemplate" provided in this repo

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

   When releasing you mod to the steam workshop this file should reflect what you mod does. example if it add or edits mechs you can add the "Mechs" value on a new line.
- readme.txt you can include any readme info for your mod.
- thumbnail.jpg this is the same file as provided by the games example mod. When before releasing your mod to the steam workshop its recommended to edit to reflect your mod.
   Note: the original image is 196by196 but this is not the size limit for steam and a larger image can be included.

-----
##### [Home](../../readme.md)