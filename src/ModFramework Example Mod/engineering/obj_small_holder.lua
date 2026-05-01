
---Gets the ModFramework.
---Makes sure the require exception is handled is the framework cant be found.
---
---When the framework cant be found, a message is shown and then the game is close by forcing an error. This to prevent error message spam.
---@return ModFramework
function GetModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
    local ok, mod = pcall(require, "ModFramework")
    if (not ok or isLoaded ~= true) then
        local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " ..caller.." line: "..info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check an correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
    end
    return mod
end

---One time script when the game is started
---@param q any
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
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