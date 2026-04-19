--------------------------
--ENGINEERING-------------
--------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon");

---Access to the functions for the Engineering tab.
local Engineering = {};

---Adds a component of type mech to engineering
---@param mech_number number the index of the mech in the database.
---@param name string|nil the name of the new mech. Or nil for a random default name.
function Engineering.AddMech(mech_number, name)
	local obj_content_mechs = Common.GetObjContentMechs();

	--Copy the array to the working set
	local list_mech = {};
	list_mech = obj_content_mechs.list_mech;

	local number_of_items = obj_content_mechs.number_of_items + 1;
	local obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	local added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	mech_number;
	if(name ~= nil) then
		added_mech.mech_name = 	name
	end
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	0;

	--return new data
	obj_content_mechs.list_mech = list_mech;
	obj_content_mechs.number_of_items = number_of_items;
end

---Adds a component of type weapon to engineering
---@param weapon_number number the index of the weapon in the database.
---@param huge boolean if the weapon is huge/+sized or not.
function Engineering.AddWeapon(weapon_number, huge)
	local obj_content_weapons = Common.GetObjContentWeapons();

	--Copy the array to the working set
	local list_weapon = {};
	list_weapon = obj_content_weapons.list_weapon;

	local number_of_items = obj_content_weapons.number_of_items + 1;
	local obj_weapon_item = asset_get_index("obj_weapon_item");
	list_weapon[number_of_items] = instance_create_depth(0, 0, 0, obj_weapon_item);
	local added_weapon = list_weapon[number_of_items];
	added_weapon.my_num = 			number_of_items - 1;
	added_weapon.weapon_number = 	weapon_number;
	added_weapon.start_x = 			8;
	added_weapon.start_y = 			266;
	added_weapon.size_huge = 		huge;

	--return new data
	obj_content_weapons.list_weapon = list_weapon;
	obj_content_weapons.number_of_items = number_of_items;
end

---Adds a component of type solenoid to engineering
---@param solenoid_number number the index of the solenoid in the database.
function Engineering.AddSolenoid(solenoid_number)
	local obj_content_solenoid = Common.GetObjContentSolenoid();

	--Copy the array to the working set
	local list_solenoid = {};
	list_solenoid = obj_content_solenoid.list_solenoid;

	local number_of_items = obj_content_solenoid.number_of_items + 1;
	local obj_solenoid_item = asset_get_index("obj_solenoid_item");
	list_solenoid[number_of_items] = instance_create_depth(0, 0, 0, obj_solenoid_item);
	local added_solenoid = list_solenoid[number_of_items];
	added_solenoid.my_num = 			number_of_items - 1;
	added_solenoid.solenoid_number = 	solenoid_number;
	added_solenoid.start_x = 			1506;
	added_solenoid.start_y = 			266;

	--return new data
	obj_content_solenoid.list_solenoid = list_solenoid;
	obj_content_solenoid.number_of_items = number_of_items;
end

---Adds a component of type reactor to engineering
---@param reactor_number number the index of the reactor in the database.
function Engineering.AddReactor(reactor_number)
	local obj_content_reactor = Common.GetObjContentReactor();

	--Copy the array to the working set
	local list_reactor = {};
	list_reactor = obj_content_reactor.list_reactor;

	local number_of_items = obj_content_reactor.number_of_items + 1;
	local obj_reactor_item = asset_get_index("obj_reactor_item");
	list_reactor[number_of_items] = instance_create_depth(0, 0, 0, obj_reactor_item);
	local added_reactor = list_reactor[number_of_items];
	added_reactor.my_num = 			number_of_items - 1;
	added_reactor.reactor_number = 	reactor_number;
	added_reactor.start_x = 		8;
	added_reactor.start_y = 		266;

	--return new data
	obj_content_reactor.list_reactor = list_reactor;
	obj_content_reactor.number_of_items = number_of_items;
end

---Adds a component of type weapon to engineering
---@param magnet_number number the index of the magnet in the database.
function Engineering.AddMagnet(magnet_number)
	local obj_content_magnet = Common.GetObjContentMagnet();

	--Copy the array to the working set
	local list_magnet = {};
	list_magnet = obj_content_magnet.list_magnet;

	local number_of_items = obj_content_magnet.number_of_items + 1;
	local obj_magnet_item = asset_get_index("obj_magnet_item");
	list_magnet[number_of_items] = instance_create_depth(0, 0, 0, obj_magnet_item);
	local added_magnet = list_magnet[number_of_items];
	added_magnet.my_num = 			number_of_items - 1;
	added_magnet.magnet_number = 	magnet_number;
	added_magnet.start_x = 			8;
	added_magnet.start_y = 			266;

	--return new data
	obj_content_magnet.list_magnet = list_magnet;
	obj_content_magnet.number_of_items = number_of_items;
end

return Engineering;