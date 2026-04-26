# Changelog


## [v0.1] - 2026-xx-xx
### Added
- Added auto rearrange for shop components
- Added auto register shop items on unlock or item registration through the framework
- Added auto fix for battle sound tables
- Added auto registration for weapon descriptions
- Added auto fix for missing weapon indicators on modded weapons in the shop
- Added auto fix to stop the robot engineer from excessively bleeding out of its shop button
- Added auto fix for modded production sprites on load when item was registrated through the framework
- Added auto fix for modding research not having the correct day requirement when added to an existing save
- Added localization support for weapon descriptions and research descriptions
- Added page support for all shop sections when to many items are registered
- Added type documentation on game objects
- Added type documentation on ModFramework functions, types and classes
- Added wrapper functions for sprite actions to safely throw error messages with a crash
- Added wrapper functions for getting gameobjects as a typed return
- Added wrapper function to get the mod path
- Added wrapper function to check if its a loaded game
- Added support to reference mod items from other mods when item was registrated through the framework
- Added framework type classes that contain readable references for game states
- Added framework support to mod:
    - Mechs
    - Weapons
        - Support for extending the range of energy weapons
    - Solenoids
    - Research
        - Support to move existing researches
        - Support to relink existing researches
        - support to add framework handeled unlocks to existing researches
- Added framework support to add to inventory
    - Cabins
    - Motors
    - Mechs
    - Weapons
    - Reactors
    - Injectors
    - Magnets
    - Solenoids
- Added Debug functions
    - Unlock all research next day
    - Unlock all shop components
    - Write the contents of a gamemaker object to a message
    - Write the contents of a gamemaker object to a class definition
    - Write the contents of a gamemaker ds map to a message
    - Write the contents of a table to a message



-----
##### [Home](../../readme.md)