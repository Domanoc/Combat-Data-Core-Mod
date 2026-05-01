# ModFramework - Accessing the framework
#### [Back to overview](./Overview.md)
---

## How

If you are using on of the mod files provided by the Mod Template or the Example mod then you can access the framework by adding the following function call in your mod files create function.   
**Note:** recommended to be the first function call in the create function.

```lua
--load the mod framework as a global for use within this file
Mod = GetModFramework()
```

After that you can can access the framework by using the global Mod variable.

## Why like this?

Simply accessing the framework with a normal require has the risk of failing when the framework wasn't loaded. To prevent this the following function is provided in all Mod Example and Mod Template files.

If your mod file doesn't have the function you can copy it an paste it on the top of your file.

```lua
---Gets the ModFramework.
---Makes sure the require exception is handled is the framework cant be found.
---
---When the framework cant be found, a message is shown and then the game is close by forcing an error. This to prevent error message spam.
---@return ModFramework
function GetModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
    local ok, mod = pcall(require, "ModFramework")
    if (not ok or isLoaded ~= true) then
        local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " ..caller.." line: "..info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check and correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
    end
    return mod
end
```

## What does it do?

It makes a call to get the ModFramework and checks the response, if it fails it will show a message. In the message the user will be informed the ModFramework was not found. and after closing the message the game is forced to close by causing an error.   
**Note:** causing the error is beneficial for the user experience, otherwise every action that would have been done in the framework would cause an error message. This might even be on every frame.



---
#### [Back to overview](./Overview.md)
---
##### [Home](../../readme.md)