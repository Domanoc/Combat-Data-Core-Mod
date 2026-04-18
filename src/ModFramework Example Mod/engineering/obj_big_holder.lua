
---One time script when the game is started
---construction table in the engineering menu
---module's id is in "cur_item"
---most submenus are inside obj_small_holder
---@param q game_obj_big_holder
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
end

---saves mech blueprint event. uses "data/f_mech_construction_slot"
---@param q any
function save_mech(q)
end

---loads mech blueprint event. uses "data/f_mech_construction_slot"
---@param q any
function load_mech(q)
end

---inside mouse_check_button_pressed(mb_left)
---@param q any
function activate_menu(q)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_mech
function draw_mechs(q,cur_item)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_reactor
function draw_reactors(q,cur_item)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_weapon
function draw_weapons(q,cur_item)
end