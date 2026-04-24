------------------------------------------------------------------------------
--- ENGINEERING FUNCTIONS ----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Engineering tab.
---@class ModFrameworkEngineering
local Engineering = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the private functions in this file.
local Private = {}

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Adds a component of type mech to engineering
---@param mech_number number the index of the mech in the database.
---@param name string? the name of the new mech. Or nil for a random default name.
function Engineering.AddMech(mech_number, name)
	local obj_content_mechs = Common.GetObjContentMechs()

	--Copy the array to the working set
	local list_mech = obj_content_mechs.list_mech

	local arraySize = #list_mech
	local itemIndex = arraySize + 1
	local addedMech = Private.AddMechItemInstance()
	addedMech.my_num = 			arraySize
	addedMech.mech_number = 	mech_number
	addedMech.new_module = 		false
	if(name ~= nil) then
		addedMech.mech_name = 	name
	end
	list_mech[itemIndex] = addedMech

	--return new data
	obj_content_mechs.list_mech = list_mech
	obj_content_mechs.number_of_items = #list_mech
end

---Adds a component of type weapon to engineering
---@param weapon_number number the index of the weapon in the database.
---@param huge boolean if the weapon is huge/+sized or not.
function Engineering.AddWeapon(weapon_number, huge)
	local obj_content_weapons = Common.GetObjContentWeapons()

	--Copy the array to the working set
	local list_weapon = obj_content_weapons.list_weapon

	local array_size = #list_weapon
	local itemIndex = array_size + 1
	local added_weapon = Private.AddWeaponItemInstance()
	added_weapon.my_num = 			array_size
	added_weapon.weapon_number = 	weapon_number
	added_weapon.size_huge = 		huge
	added_weapon.new_module = 		true
	list_weapon[itemIndex] = added_weapon

	--return new data
	obj_content_weapons.list_weapon = list_weapon
	obj_content_weapons.number_of_items = #list_weapon
end

---Adds a component of type solenoid to engineering
---@param solenoid_number number the index of the solenoid in the database.
function Engineering.AddSolenoid(solenoid_number)
	local obj_content_solenoid = Common.GetObjContentSolenoid()

	--Copy the array to the working set
	local list_solenoid = obj_content_solenoid.list_solenoid

	local number_of_items = obj_content_solenoid.number_of_items + 1
	local obj_solenoid_item = asset_get_index("obj_solenoid_item")
	list_solenoid[number_of_items] = instance_create_depth(0, 0, 0, obj_solenoid_item)
	local added_solenoid = list_solenoid[number_of_items]
	added_solenoid.my_num = 			number_of_items - 1
	added_solenoid.solenoid_number = 	solenoid_number
	added_solenoid.start_x = 			1506
	added_solenoid.start_y = 			266

	--return new data
	obj_content_solenoid.list_solenoid = list_solenoid
	obj_content_solenoid.number_of_items = number_of_items
end

---Adds a component of type reactor to engineering
---@param reactor_number number the index of the reactor in the database.
function Engineering.AddReactor(reactor_number)
	local obj_content_reactor = Common.GetObjContentReactor()

	--Copy the array to the working set
	local list_reactor = obj_content_reactor.list_reactor

	local number_of_items = obj_content_reactor.number_of_items + 1
	local obj_reactor_item = asset_get_index("obj_reactor_item")
	list_reactor[number_of_items] = instance_create_depth(0, 0, 0, obj_reactor_item)
	local added_reactor = list_reactor[number_of_items]
	added_reactor.my_num = 			number_of_items - 1
	added_reactor.reactor_number = 	reactor_number
	added_reactor.start_x = 		8
	added_reactor.start_y = 		266

	--return new data
	obj_content_reactor.list_reactor = list_reactor
	obj_content_reactor.number_of_items = number_of_items
end

---Adds a component of type weapon to engineering
---@param magnet_number number the index of the magnet in the database.
function Engineering.AddMagnet(magnet_number)
	local obj_content_magnet = Common.GetObjContentMagnet()

	--Copy the array to the working set
	local list_magnet = obj_content_magnet.list_magnet

	local number_of_items = obj_content_magnet.number_of_items + 1
	local obj_magnet_item = asset_get_index("obj_magnet_item")
	list_magnet[number_of_items] = instance_create_depth(0, 0, 0, obj_magnet_item)
	local added_magnet = list_magnet[number_of_items]
	added_magnet.my_num = 			number_of_items - 1
	added_magnet.magnet_number = 	magnet_number
	added_magnet.start_x = 			8
	added_magnet.start_y = 			266

	--return new data
	obj_content_magnet.list_magnet = list_magnet
	obj_content_magnet.number_of_items = number_of_items
end

---Create a new obj_mech_item instance
---@return game_obj_mech_item objMechItem the new obj_mech_item instance
function Private.AddMechItemInstance()
	local obj_mech_item = asset_get_index("obj_mech_item")
	return instance_create_depth(0, 0, 0, obj_mech_item)
end

---Create a new obj_weapon_item instance
---@return game_obj_weapon_item objMechItem the new obj_weapon_item instance
function Private.AddWeaponItemInstance()
	local obj_weapon_item = asset_get_index("obj_weapon_item")
	return instance_create_depth(0, 0, 0, obj_weapon_item)
end

------------------------------------------------------------------------------
--- EXPORT ENGINEERING -------------------------------------------------------
------------------------------------------------------------------------------

return Engineering