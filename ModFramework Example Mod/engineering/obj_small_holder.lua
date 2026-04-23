
---One time script when the game is started
---@param q any
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");
end

--in draw event
function submenu_repair(q,buf_mech)	--when menu is open. buf_mech=mech's id
end

function submenu_weight(q,cur_item)	--when menu is open. cur_item=installed module's id
end

function submenu_elec(q,buf_mech)	--when menu is open. buf_mech=mech's id
	--if mech have a reactor
end

function submenu_defence(q,buf_mech)	--when menu is open. buf_mech=mech's id
end

function submenu_program(q,buf_mech)	--when menu is open. buf_mech=mech's id
end

function submenu_test(obj_big_holder,mech_test_id)	--when menu is open. mech_test_id= phy mech's id
	-- inside with(obj_big_holder)
end