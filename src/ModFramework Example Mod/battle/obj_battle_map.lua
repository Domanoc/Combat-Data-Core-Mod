
---One time script when the game is started
---@param q game_obj_battle_map
---@param v_modid string
function create(q,v_modid)
end

function battle_end()
end

function battle_logic()
end

---runs while the battle is active
---starts before map creation
---@param q any
function battle_going_start(q)
end

---an alarm that activates if mechs are inside the extraction zone
---@param q any
function map_progression(q)
end

---regular map creation
---one time trigger before the battle start
---@param q any
function creating_map_start(q)
end

---q_pm = obj_ally(mech in the battle),   q_om = obj_mech_item(mech card, contains IDs of all components and settings)
---@param q any
---@param q_pm any obj_ally(mech in the battle)
---@param q_om any obj_mech_item(mech card, contains IDs of all components and settings)
function creating_phy_mechs(q,q_pm,q_om)
end

---@param q any
function creating_map_middle(q)
end

---@param q any
function drawing_surf_gen_map(q)
end

---one time trigger before the battle
---@param q any
function creating_map_end(q)
end

---starts after map creation
---@param q any
function battle_going_end(q)
end

---@param q any
function battle_logic(q)
end

---when battle ends, mechs dead. for regular scout maps
---@param q any
function battle_end_scout_mechs_dead(q)
end

---when battle ends, mechs win. for regular scout maps
---@param q any
function battle_end_scout_win(q)
end

---@param q any
function battle_end(q)
end

---@param q any
function battle_retreat(q)
end

---@param q any
function draw(q)
end

---@param q any
function draw_end(q)
end