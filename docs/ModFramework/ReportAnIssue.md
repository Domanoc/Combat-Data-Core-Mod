# ModFramework - Report an issue

Clear, detailed issues help fix problems faster. If you're reporting a bug or problem with, please follow the guidelines below. 

When you have read the guidelines you can open an issue here on github. By clicking the "Issues" tab button and then the "New Issue" button.


## 📌 Required Information

### 1. Mod Load Order
List the exact load order of your mods. This is critical because many issues are caused by conflicts.

**Example:**
```text
Mod Load Order:
ModFramework
MyMod
ThatOtherMod
```


---

### 2. Steps to Reproduce
Describe *exactly* how to trigger the issue. Be as specific as possible so others can replicate it.

**Example:**
```text
Start a new game
Added a weapon x to the production queue
Saved and reloaded the game
Sprites in the production queue are now broken
```
---

### 3. Error Messages / Logs
Include any error messages. Copy and paste the full message if possible.

**Example:**
```text
---------------------------
Mech Engineer
---------------------------
...ngineer\mods/MyMod/hangar/obj_pilot_item.lua:17: attempt to compare number with nil
stack traceback:
	...ngineer\mods/MyMod/hangar/obj_pilot_item.lua:17: in field 'new_day_stats_end'
	[string "
..."]:263: in function 'obj_pilot_item_new_day_stats_end'  undefined
---------------------------
OK   
---------------------------
```

### 4. Additional Helpful Info (Optional but Recommended)

- Try is you can reproduce it on a new save
- Include the save file if possible/needed (the save is a text file without an extension)
- If there a lot of mods in the load order try to narrow it down

## ✅ Good Issue Example

```Text
Mod Load Order:
ModFramework
MyMod

Steps to Reproduce:
Start a new game
Added a weapon x to the production queue
Saved and reloaded the game
Sprites in the production queue are now broken

Error Message:
---------------------------
Mech Engineer
---------------------------
...ngineer\mods/MyMod/hangar/obj_pilot_item.lua:17: attempt to compare number with nil
stack traceback:
	...ngineer\mods/MyMod/hangar/obj_pilot_item.lua:17: in field 'new_day_stats_end'
	[string "
..."]:263: in function 'obj_pilot_item_new_day_stats_end'  undefined
---------------------------
OK   
---------------------------
```

## ❌ Poor Issue Example
```text
mod broke pls fix
```


## Final Notes

- Double-check if the issue already exists before posting
- Be concise but complete
- The more detail you provide, the faster the issue can be resolved

Thanks for reading