--------------------------------------------
--Documentation for used mod functions -----
--------------------------------------------
--Added this file to give the IDE info on what the mod functions return and use for params

---A reference handle to the gamemaker ds_map data structure, stores key and value pairs.
---@alias ds_map userdata

---@type any
mod_info = mod_info;
---This function is used to create a new, empty DS map and will return a Handle to it which is then used to access the data structure in all other DS map functions.
---@type fun(): ds_map
ds_map_create = ds_map_create;
---This function should be used to add sets of key/value pairs into the specified DS map.
---@type fun(map: ds_map, key: string, value: any)
ds_map_add = ds_map_add;
---With this function you can retrieve all of the keys that a DS map contains.
---@type fun(id: ds_map) : table
ds_map_keys_to_array = ds_map_keys_to_array;
---With this function you can get the value from a specified key.
---@type fun(id: ds_map, key: string) : any|nil
ds_map_find_value = ds_map_find_value;
---This function returns an array with the variable names from a struct.
---@type fun(id: table) : table
struct_get_names = struct_get_names;
---With this function you can set the value of a given global variable.
---@type fun(key: string, value: any)
variable_global_set = variable_global_set;
---With this function you can get the value from a given named global variable
---@type fun(key: string): value: any
variable_global_get = variable_global_get;
---This function will add an image as a sprite
---@type fun(filepath: string, number_of_images: number, removeback: boolean, smooth: boolean, xorig: number, yorig: number): value: number
sprite_add = sprite_add;
---This function will merge the sprite indexed in argument 1 ("ind2") with that which is indexed in argument 0 ("ind1").
---@type fun(ind1: number, ind2: number)
sprite_merge = sprite_merge;
---This function will return the index of a newly created sprite that is a duplicate (copy) of the one input as the "index" argument.
---@type fun(index: number) :number|-1
sprite_duplicate = sprite_duplicate;
---This function will delete a sprite from the game, freeing any memory that was reserved for it.
---@type fun(index: number)
sprite_delete = sprite_delete;
---This function gets the unique identifying index for a game asset from its name.
---@type fun(name: string): any
asset_get_index = asset_get_index;
---This function creates a pop-up message box which displays the given string and a button marked "Ok" to close it.
---@type fun(message: string)
show_message = show_message;
---With this function you can create a new instance of the specified object at any given point within the room and at the depth specified.
---@type fun(x: number, y: number, depth: number, obj: any): any
instance_create_depth = instance_create_depth;
--------------------------------------------
--------------------------------------------