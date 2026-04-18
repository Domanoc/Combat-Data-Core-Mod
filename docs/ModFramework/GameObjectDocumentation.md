# ModFramework - GameObject documentation

The framework provides the lua class types for most gameobjects. 

This is an ongoing project and the provided documentation should not be considered law. The mod creator should do its own testing when using gameobjects. As not all fields are set at every point in the game.

One important note is that the game uses gamemaker structs, ds maps and ds grids. These are seen in lua as numbers but can be interacted with differently.

### Gamemaker struct
Is a reference handle to the gamemaker struct data structure. When provided with the correct gameobject documentation type, it can be navigated using the standard lua methods.

### DS MAP
Its a reference handle to the gamemaker ds_map data structure, stores key and value pairs.
Lua sees ds maps as a number and you cant access the contents directly as you can with the gamemaker structs

To work with ds maps use functions like: ds_map_exists, ds_map_create, ds_map_destroy, ds_map_add, ds_map_copy, ds_map_find_value, ds_map_keys_to_array

### DS GRID
Its a reference handle to the gamemaker ds_grid data structure. Its a dynamic 2D data structure used to store values in a grid (rows and columns).
Lua sees ds maps as a number and you cant access the contents directly as you can with the gamemaker structs

To work with ds maps use functions like: 
ds_grid_create, ds_grid_write, ds_grid_read, ds_grid_set, ds_grid_get

### Where to get it
The documentation files are included in the "[ModTemplate](../../src/ModTemplate/)" and "[ModFramework Example Mod](../../src/ModFramework%20Example%20Mod/)"   
Or you can view then in the repo [here](../../src/ModFramework/GameClassDefinitions/)


---
#### [Back to overview](./Overview.md)
---
##### [Home](../../readme.md)
