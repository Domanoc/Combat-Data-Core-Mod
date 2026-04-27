# ModFramework - Battle sound fix

A list of framework sprite wrapper functions. These function are made catch errors that are thrown when invalid data is passed to the game. This focusses mainly on incorrect sprite references.

When confronted with invalid data it wil provide a error message box with relevant debug info.


### Note:
All functions expect the framework to be loaded in the file. recommended is the create function.
```lua
--load the mod framework as a global for use within this file
Mod = require("ModFrameworkModule")
```

### AddSprite
```lua
Mod.Common.AddSprite(filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
```
### MergeSprite
```lua
Mod.Common.MergeSprite(firstSpriteIndex, secondSpriteIndex)
```
### DeleteSprite
```lua
Mod.Common.DeleteSprite(spriteIndex)
```
### ReplaceSprite
```lua
Mod.Common.ReplaceSprite(spriteIndex, filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
```

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
