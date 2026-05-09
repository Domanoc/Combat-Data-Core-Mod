---@meta

---See the gamemaker documentation for further details on the functions

---This function returns the length of a vector formed by the specified components [x1,y1] and [x2,y2]. 
---@param x1 number The x coordinate of the first component of the vector.
---@param y1 number The y coordinate of the first component of the vector.
---@param x2 number The x coordinate of the second component of the vector.
---@param y2 number The y coordinate of the second component of the vector.
---@return number distance
function point_distance(x1, y1, x2, y2) end


---This function returns the direction of a vector formed by the specified components [x1,y1] and [x2,y2] in relation to the fixed x/y coordinates of the room.
---@param x1 number The x coordinate of the first component of the vector.
---@param y1 number The y coordinate of the first component of the vector.
---@param x2 number The x coordinate of the second component of the vector.
---@param y2 number The y coordinate of the second component of the vector.
---@return number direction
function point_direction(x1, y1, x2, y2) end

---This function is used to get the x component of a position "len" pixels from the starting point and in direction "dir". 
---
---If you imagine a circle around your instance, and then imagine a point anywhere on that circle, 
---to move to that point we need to move the object so many pixels in that direction... 
---so this function (when used with lengthdir_y()) gets the position of that point on the circle to be used in code by the instance.
---@param len number The length away of the point to return.
---@param dir number The direction of the point to return.
---@return number x The x coordinate in the direction and at the length given
function lengthdir_x(len, dir) end

---This function is used to get the x component of a position "len" pixels from the starting point and in direction "dir". 
---
---If you imagine a circle around your instance, and then imagine a point anywhere on that circle, 
---to move to that point we need to move the object so many pixels in that direction... 
---so this function (when used with lengthdir_x()) gets the position of that point on the circle to be used in code by the instance.
---@param len number The length away of the point to return.
---@param dir number The direction of the point to return.
---@return number y The y coordinate in the direction and at the length given
function lengthdir_y(len, dir) end

---You can use this function to check and see if the calling instance would collide with any instance flagged as solid in your game.
---Now, it should be noted that for this to work, the instance running the code must have a valid collision mask (either for the sprite itself, or through the mask_index)
---and it will only register collisions with those solid flagged instances that also have a valid mask. 
---The function itself basically works by taking the instance and testing for collisions with only solid flagged instances when placed at the position specified by the x/y arguments. 
---The collision checking can be either precise or based on the bounding box of the instance, depending on what kind of collision mask has been selected.
---
---Note that the given x/y coordinates will be floored to the nearest integer before the check is performed.
---@param x number The x position to check.
---@param y number The y position to check.
---@return boolean free
function place_free(x, y) end