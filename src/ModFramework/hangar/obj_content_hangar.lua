
---One time script when the game is started
---@param q game_obj_content_hangar
---@param v_modid string
function create(q,v_modid)
end

---every game tick if we are in the hangar menu and battle is not active
---@param q game_obj_content_hangar
function step_activated(q)
end

---when all conditions are met to spawn a giant (red sword)
---@param q game_obj_content_hangar
function spawn_giant_red(q)
end

---when all conditions are met to spawn a giant (gold sword)
---@param q game_obj_content_hangar
function spawn_giant_gold(q)
end

---when all conditions are met to launch a nuke
---@param q game_obj_content_hangar
function nuke_landed(q)
end

---check when placing city
---@param q game_obj_content_hangar
function place_city(q,q_p)
	--q_p = 1, if q_p = 0 can't place city on that cell
	--mx = mouse_x
	--my = mouse_y
	--ds_grid_get(data_map_biom,mx,my) for checking bioms
end

---skip day button
---if not defending city
---@param q game_obj_content_hangar
function skip_day_start(q)
end

---if not defending city
---@param q game_obj_content_hangar
function skip_day_end(q)
end

---after battle info
---@param q game_obj_content_hangar
function draw_battle_log(q)
end

---@param q game_obj_content_hangar
function draw_calendar(q)
end

---@param q game_obj_content_hangar
function draw_map(q)
end

---@param q game_obj_content_hangar
function draw_personal(q)
end

---@param q game_obj_content_hangar
function draw_battle_windowed(q)
end

---@param q game_obj_content_hangar
function draw_battle_fullscreen(q)
end
