

--------------------------------------------
--Documentation for used mod functions -----
--------------------------------------------
--Added this file to give the IDE info on what the mod functions return and use for params
---Game is made in GameMaker
---See the gamemaker documentation for the implementation of the global functions
--example: variable_global_set, ds_map_add, sprite_add
--the exposed functions can be found in the list_of_functions.txt file

---@type table<string, string>
mod_info = mod_info
---This function returns an array with the variable names from a struct.
---@type fun(id: number) : table
struct_get_names = struct_get_names

---This function gets the unique identifying index for a game asset from its name.
---@type fun(name: string): any
asset_get_index = asset_get_index
---This function creates a pop-up message box which displays the given string and a button marked "Ok" to close it.
---@type fun(message: string|number)
show_message = show_message
---With this function you can create a new instance of the specified object at any given point within the room and at the depth specified.
---@type fun(x: number, y: number, depth: number, obj: any): any
instance_create_depth = instance_create_depth
---With this function you can check if a key is pressed, as input it uses virtual key codes
---@type fun(virtualKey: number)
keyboard_check_pressed = keyboard_check_pressed
---This function is used to create a surface and will return the index of the surface which should be stored in a variable for future function calls.
---@type fun(width: number, height: number)
surface_create = surface_create
---With this function you set all further drawing to the target surface rather than the screen and in this way you can tell GameMaker to only draw specific things to the specified surface.
---@type fun(surface_id: number)
surface_set_target = surface_set_target
---This function resets all further drawing from the target surface back to the screen.
---@type fun()
surface_reset_target = surface_reset_target
---This function will save a surface to disc using the given filename. The surface must be saved as a *.png format file.
---@type fun(surface_id: number, fname: string)
surface_save = surface_save
---When you are working with surfaces, you should always use this function whenever you are finished using them.
---@type fun(surface_id: number)
surface_free = surface_free
---Returns true once, the moment you click, Doesn’t repeat if you hold the button
---@type fun(numb:number):boolean
mouse_check_button_pressed = mouse_check_button_pressed
---Returns true while you click, repeats every frame if you hold the button
---@type fun(numb:number):boolean
mouse_check_button = mouse_check_button
---Gets the mouse position x in window/screen coordinates, (0,0) = top-left of the window
---@type fun():number
window_mouse_get_x = window_mouse_get_x
---Gets the mouse position y in window/screen coordinates, (0,0) = top-left of the window
---@type fun():number
window_mouse_get_y = window_mouse_get_y
---This function returns a random integer value within the given range (both inclusive).
---@type fun(x1:number, x2:number): number
irandom_range = irandom_range






---With this function you can set the value of a given global variable.
---@type fun(key: string, value: any)
variable_global_set = variable_global_set
---With this function you can get the value from a given named global variable
---@type fun(key: string): value: any
variable_global_get = variable_global_get