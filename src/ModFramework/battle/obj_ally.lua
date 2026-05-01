
---Triggers per mech that is created in battle
---@param q game_obj_ally
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
	--Set a default value for OverrideSelected
	q.OverrideSelected = true
	Internal.Battle.RegisterAlly(q)
end

---Triggers per mech per frame even when the battle is paused
---@param q game_obj_ally
function step_before_ai(q)
	Internal.Battle.OverrideSelection(q)
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after step_before_ai
---if not overheated and not time x2, after command set, before behavior. if battle not on pause
---@param q game_obj_ally
function command(q)
	--[[
	command=""; will turn off regular AI
	states: avoid,move,wait,defence
	]]
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after command
---Bullet creation script
---@param q game_obj_ally
function shoot(q)
	--dist_to_en>16 and shoot_in_melee>= 61 will turn off bullet creation
end

---Triggers per mech per frame even when the battle is paused
---Triggers after shoot
---@param q game_obj_ally
function step_after_ai(q)
	Internal.Battle.OverrideSelection(q)
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after step_after_ai
---end_step after rotation code, if battle not on pause
---@param q game_obj_ally
function rotation(q)
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after rotation
---@param q game_obj_ally
function draw(q)
	Internal.Battle.OverrideSelection(q)
end