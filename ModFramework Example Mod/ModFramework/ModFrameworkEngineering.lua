------------------------------------------------------------------------------
--- ENGINEERING FUNCTIONS ----------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Engineering tab.
---@class ModFrameworkEngineering
local Engineering = {}

---Access to the private functions in this file.
---@class ModFrameworkEngineeringPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")

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
	addedMech.my_num = arraySize
	addedMech.mech_number = mech_number
	addedMech.new_module = true
	if(name ~= nil) then
		addedMech.mech_name = name
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

	local arraySize = #list_weapon
	local itemIndex = arraySize + 1
	local addedWeapon = Private.AddWeaponItemInstance()
	addedWeapon.my_num = arraySize
	addedWeapon.weapon_number = weapon_number
	addedWeapon.size_huge = huge
	addedWeapon.new_module = true
	list_weapon[itemIndex] = addedWeapon

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

	local arraySize = #list_solenoid
	local itemIndex = arraySize + 1
	local addedSolenoid = Private.AddSolenoidItemInstance()
	addedSolenoid.my_num = arraySize
	addedSolenoid.solenoid_number = solenoid_number
	addedSolenoid.new_module = true
	list_solenoid[itemIndex] = addedSolenoid

	--return new data
	obj_content_solenoid.list_solenoid = list_solenoid
	obj_content_solenoid.number_of_items = #list_solenoid
end

---Adds a component of type reactor to engineering
---@param reactor_number number the index of the reactor in the database.
function Engineering.AddReactor(reactor_number)
	local obj_content_reactor = Common.GetObjContentReactor()

	--Copy the array to the working set
	local list_reactor = obj_content_reactor.list_reactor

	local arraySize = #list_reactor
	local itemIndex = arraySize + 1
	local addedReactor = Private.AddReatorItemInstance()
	addedReactor.my_num = arraySize
	addedReactor.reactor_number = reactor_number
	addedReactor.new_module = true
	list_reactor[itemIndex] = addedReactor

	--return new data
	obj_content_reactor.list_reactor = list_reactor
	obj_content_reactor.number_of_items = #list_reactor
end

---Adds a component of type weapon to engineering
---@param magnet_number number the index of the magnet in the database.
function Engineering.AddMagnet(magnet_number)
	local obj_content_magnet = Common.GetObjContentMagnet()

	--Copy the array to the working set
	local list_magnet = obj_content_magnet.list_magnet

	local arraySize = #list_magnet
	local itemIndex = arraySize + 1
	local addedMagnet = Private.AddMagnetItemInstance()
	addedMagnet.my_num = arraySize
	addedMagnet.magnet_number = magnet_number
	addedMagnet.new_module = true
	list_magnet[itemIndex] = addedMagnet

	--return new data
	obj_content_magnet.list_magnet = list_magnet
	obj_content_magnet.number_of_items = #list_magnet
end

---Create a new obj_mech_item instance
---@return game_obj_mech_item objMechItem the new obj_mech_item instance
function Private.AddMechItemInstance()
	local obj_mech_item = asset_get_index("obj_mech_item")
	return instance_create_depth(0, 0, 0, obj_mech_item)
end

---Create a new obj_weapon_item instance
---@return game_obj_weapon_item objWeaponItem the new obj_weapon_item instance
function Private.AddWeaponItemInstance()
	local obj_weapon_item = asset_get_index("obj_weapon_item")
	return instance_create_depth(0, 0, 0, obj_weapon_item)
end

---Create a new obj_solenoid_item instance
---@return game_obj_solenoid_item objSolenoidItem the new obj_solenoid_item instance
function Private.AddSolenoidItemInstance()
	local obj_solenoid_item = asset_get_index("obj_solenoid_item")
	return instance_create_depth(0, 0, 0, obj_solenoid_item)
end

---Create a new obj_reactor_item instance
---@return game_obj_reactor_item objReactorItem the new obj_reactor_item instance
function Private.AddReatorItemInstance()
	local obj_reactor_item = asset_get_index("obj_reactor_item")
	return instance_create_depth(0, 0, 0, obj_reactor_item)
end

---Create a new obj_magnet_item instance
---@return game_obj_magnet_item objReactorItem the new obj_magnet_item instance
function Private.AddMagnetItemInstance()
	local obj_magnet_item = asset_get_index("obj_magnet_item")
	return instance_create_depth(0, 0, 0, obj_magnet_item)
end

------------------------------------------------------------------------------
--- EXPORT ENGINEERING -------------------------------------------------------
------------------------------------------------------------------------------

return Engineering