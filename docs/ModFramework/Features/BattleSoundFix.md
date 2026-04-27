# ModFramework - Battle sound fix

The framework fixes the sound tables used during battle. 

These tables need expanding when modded weapons are added or else the user will run into nil reference errors,

It does this based on the amount of weapon types that are registered in [game_obj_database](../../src/ModFramework/GameClassDefinitions/game_obj_database.lua).weapon_stat. this ensures that even non framework mods are accounted for.

---
#### [Back to overview](../Overview.md)
---
##### [Home](../../../readme.md)
