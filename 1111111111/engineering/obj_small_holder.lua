
---One time script when the game is started
---@param q any
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");
end

--in draw event
function submenu_repair(q,buf_mech)	--when menu is open. buf_mech=mech's id
	if keyboard_check_pressed(120) then --F9
		Mod.Common.DumpObjToMessage(q);
    end
end

function submenu_weight(q,cur_item)	--when menu is open. cur_item=installed module's id
	if keyboard_check_pressed(120) then --F9
		Mod.Common.DumpObjToMessage(q);
    end
end

function submenu_elec(q,buf_mech)	--when menu is open. buf_mech=mech's id
	--if mech have a reactor
	if keyboard_check_pressed(120) then --F9
		Mod.Common.DumpObjToMessage(q);
		Mod.Common.DumpObjToMessage(buf_mech);
    end
end

function submenu_defence(q,buf_mech)	--when menu is open. buf_mech=mech's id
	if keyboard_check_pressed(120) then --F9
		Mod.Common.DumpObjToMessage(q);
    end
end

function submenu_program(q,buf_mech)	--when menu is open. buf_mech=mech's id
	if keyboard_check_pressed(120) then --F9
		Mod.Common.DumpObjToMessage(q);
    end
end

function submenu_test(obj_big_holder,mech_test_id)	--when menu is open. mech_test_id= phy mech's id
	if keyboard_check_pressed(120) then --F9
		Mod.Common.DumpObjToMessage(mech_test_id);
    end
	-- inside with(obj_big_holder)
end