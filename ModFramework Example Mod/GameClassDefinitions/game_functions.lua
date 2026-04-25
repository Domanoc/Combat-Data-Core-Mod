---@class ds_map A reference handle to the gamemaker ds_map data structure, stores key and value pairs.

--------------------------------------------
--Documentation for used mod functions -----
--------------------------------------------
--Added this file to give the IDE info on what the mod functions return and use for params
--Game is made in GameMaker
--See the gamemaker documentation for the implimentation of the global functions
--example: variable_global_set, ds_map_add, sprite_add
--the exposed functions can be found in the list_of_functions.txt file

---@type table<string, string>
mod_info = mod_info
---This function is used to create a new, empty DS map and will return a Handle to it which is then used to access the data structure in all other DS map functions.
---@type fun(): ds_map
ds_map_create = ds_map_create
---This function should be used to add sets of key/value pairs into the specified DS map.
---@type fun(map: ds_map, key: string, value: any)
ds_map_add = ds_map_add
---With this function you can retrieve all of the keys that a DS map contains.
---@type fun(id: ds_map) : table
ds_map_keys_to_array = ds_map_keys_to_array
---With this function you can get the value from a specified key.
---@type fun(id: ds_map, key: string) : any|nil
ds_map_find_value = ds_map_find_value
---This function returns an array with the variable names from a struct.
---@type fun(id: number) : table
struct_get_names = struct_get_names
---With this function you can set the value of a given global variable.
---@type fun(key: string, value: any)
variable_global_set = variable_global_set
---With this function you can get the value from a given named global variable
---@type fun(key: string): value: any
variable_global_get = variable_global_get
---This function will add an image as a sprite
---@type fun(filepath: string, number_of_images: number, removeback: boolean, smooth: boolean, xorig: number, yorig: number): value: number
sprite_add = sprite_add
---This function will merge the sprite indexed in argument 1 ("ind2") with that which is indexed in argument 0 ("ind1").
---@type fun(ind1: number, ind2: number)
sprite_merge = sprite_merge
---This function will return the index of a newly created sprite that is a duplicate (copy) of the one input as the "index" argument.
---@type fun(index: number) :number|-1
sprite_duplicate = sprite_duplicate
---This function will delete a sprite from the game, freeing any memory that was reserved for it.
---@type fun(index: number)
sprite_delete = sprite_delete
---This function gets the unique identifying index for a game asset from its name.
---@type fun(name: string): any
asset_get_index = asset_get_index
---This function creates a pop-up message box which displays the given string and a button marked "Ok" to close it.
---@type fun(message: string|number)
show_message = show_message
---With this function you can create a new instance of the specified object at any given point within the room and at the depth specified.
---@type fun(x: number, y: number, depth: number, obj: any): any
instance_create_depth = instance_create_depth
---With this function you can check if a key is pressed, as imput it uses virtual key codes
---@type fun(virtualKey: number)
keyboard_check_pressed = keyboard_check_pressed
---This function is used to create a surface and will return the index of the surface which should be stored in a variable for future function calls.
---@type fun(width: number, height: number)
surface_create = surface_create
---With this function you set all further drawing to the target surface rather than the screen and in this way you can tell GameMaker to only draw specific things to the specified surface.
---@type fun(surface_id: number)
surface_set_target = surface_set_target
---This function can be used to clear the entire screen with a given colour and the alpha component of the destination is set to the value you have set.
---@type fun(col_id: number, alpha: number)
draw_clear_alpha = draw_clear_alpha
---This function draws the given sprite and sub-image at a position.
---@type fun(sprite: number, subimg: number, x: number, y: number)
draw_sprite = draw_sprite
---This function resets all further drawing from the target surface back to the screen.
---@type fun()
surface_reset_target = surface_reset_target
---This function will save a surface to disc using the given filename. The surface must be saved as a *.png format file.
---@type fun(surface_id: number, fname: string)
surface_save = surface_save
---When you are working with surfaces, you should always use this function whenever you are finished using them.
---@type fun(surface_id: number)
surface_free = surface_free
---With this function you can replace a sprite with a new image, loading from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg
---@type fun(ind:number, fname:string, imgnumb:number, removeback:boolean, smooth:boolean, xorig:number, yorig:number)
sprite_replace = sprite_replace
---This function will return the name as a string of the specified sprite. if not found returns "<undefined>"
---@type fun(index: number):string
sprite_get_name = sprite_get_name
---Returns true once, the moment you click, Doesn’t repeat if you hold the button
---@type fun(numb:number):boolean
mouse_check_button_pressed = mouse_check_button_pressed
---Gets the mouse position x in window/screen coordinates, (0,0) = top-left of the window
---@type fun():number
window_mouse_get_x = window_mouse_get_x
---Gets the mouse position y in window/screen coordinates, (0,0) = top-left of the window
---@type fun():number
window_mouse_get_y = window_mouse_get_y