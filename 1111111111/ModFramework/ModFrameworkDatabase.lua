--------------------------
--DATABASE              --
--------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage");
---Access to the Common functions.
local Common = require("ModFrameworkCommon");
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes");
---Access to the private functions in this file.
local Private = {};

---Access to the functions for the Database.
local Database = {};

---Adds a new mech to the games obj_database
---@param mechData mech_data dataset for adding a new mech
function Database.AddMech(mechData)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local mech_stat_array = {};
	mech_stat_array = obj_database.mech_stat;

	local mech_index = #mech_stat_array + 1;
	local mech = ds_map_create();
	mech_stat_array[mech_index] = mech;

	--ENGINEERING PRICE
	ds_map_add(mech, "price_metallite",	mechData.price_metallite);
	ds_map_add(mech, "price_bjorn",		mechData.price_bjorn);
	ds_map_add(mech, "price_munilon",	mechData.price_munilon);
	ds_map_add(mech, "price_skalaknit",	mechData.price_skalaknit);
	ds_map_add(mech, "price_staff",		mechData.price_staff);
	ds_map_add(mech, "days",			mechData.production_days);

	--RESISTANCES
	ds_map_add(mech, "heat_resist",		mechData.heat_resist);
	ds_map_add(mech, "impact_resist",	mechData.impact_resist);
	ds_map_add(mech, "current_resist",	mechData.current_resist);

	--STATS
	ds_map_add(mech, "hp", 				1000);  --1000 is the default for all mechs, not sure if the game does something with this value
	ds_map_add(mech, "melee_option",	mechData.has_melee);
	ds_map_add(mech, "armor",			mechData.passive_armor);
	ds_map_add(mech, "weight",			mechData.weight);
	ds_map_add(mech, "speed",			mechData.speed);
	ds_map_add(mech, "reload_time",		mechData.reload_time);
	ds_map_add(mech, "battle_time",		mechData.battle_time);

	--MODULE CELLS
	Private.AddCells(mech, mechData.mech_cells);

	--SPRITES
	--small sprite
	local mech_sprite = Common.AddSprite(mechData.sprite_small, 0, false, false, 23, 49);
	ds_map_add(mech, "sprite_small", mech_sprite);
	--big sprite
	ds_map_add(mech, "sprite_big", Common.AddSprite(mechData.sprite_big, 0, false, false, 200, 343));
	--battle sprite
	ds_map_add(mech, "sprite_battle", Common.AddSprite(mechData.sprite_battle, 2, true, false, 25, 25));
	--dead sprite
	ds_map_add(mech, "sprite_battle_dead", Common.AddSprite(mechData.sprite_battle_dead, 1, true, false, 25, 25));
	--melee vertical
	if(mechData.sprite_battle_melee_ver ~= nil) then
		ds_map_add(mech, "sprite_battle_melee_ver", Common.AddSprite(mechData.sprite_battle_melee_ver, 7, true, false, 25, 25));
	end
	--melee horizontal
	if(mechData.sprite_battle_melee_hor ~= nil) then
		ds_map_add(mech, "sprite_battle_melee_hor", Common.AddSprite(mechData.sprite_battle_melee_hor, 7, true, false, 25, 25));
	end

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type modded_component
	local moddedComponent = {
		component_type = Types.ComponentTypes.mech,
		index = mech_index - 1,
		sprite = mech_sprite,
		name = mechData.name,
		component_size = mechData.component_size,
		researched = mechData.researched,
		CanBeConstructed = mechData.CanBeConstructed,
		BlueLength = 0,
		WeaponDescription = ""
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.mech_stat = mech_stat_array;
end

---Adds the Cell data to the ds_map of the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cells mech_cell[] the cell data array for the mech
function Private.AddCells(mech, cells)
	local aux_number = 0;
	local weapon_number = 0;

	for i = 1, #cells, 1 do
		local cell = cells[i];
		Private.AddCell(mech, i, cell);

		if(cell.moduleType == Types.MechModules.aux) then
			aux_number = aux_number + 1;
		end
		if(cell.moduleType == Types.MechModules.gun) then
			weapon_number = weapon_number + 1;
		end
	end

	ds_map_add(mech, "number_of_aux",	  aux_number);
	ds_map_add(mech, "number_of_weapons", weapon_number);
	ds_map_add(mech, "number_of_cells",   #cells);
end

---Adds a new cell to the ds_map for the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cell_num number the number of the newly added cell
---@param cell mech_cell the data for the cell
function Private.AddCell(mech, cell_num, cell)
	ds_map_add(mech, "cell_"..cell_num, 	cell.moduleType);
	ds_map_add(mech, "cell_x_"..cell_num, 	cell.x);
	ds_map_add(mech, "cell_y_"..cell_num, 	cell.y);
end

---Add a new weapon to the games obj_database
---@param weaponData weapon_data
function Database.AddWeapon(weaponData)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local weapon_stat_array = {};
	weapon_stat_array = obj_database.weapon_stat;

	local weapon_index = #weapon_stat_array + 1;
	weapon_stat_array[weapon_index] = ds_map_create();
	local weapon = weapon_stat_array[weapon_index];

	--ENGINEERING PRICE
	ds_map_add(weapon, "price_metallite",	weaponData.price_metallite);
	ds_map_add(weapon, "price_bjorn",		weaponData.price_bjorn);
	ds_map_add(weapon, "price_munilon",		weaponData.price_munilon);
	ds_map_add(weapon, "price_skalaknit",	weaponData.price_skalaknit);
	ds_map_add(weapon, "price_staff",		weaponData.price_staff);
	ds_map_add(weapon, "days",				weaponData.production_days);

	--STATS
	ds_map_add(weapon, "hp",				1000);	--a default value the game doesn't seem to use.
	ds_map_add(weapon, "number",			3);		--doesn't seem to do anything
	ds_map_add(weapon, "type",				weaponData.weapon_type);
	ds_map_add(weapon, "start_fire_speed",	weaponData.fire_rate);
	ds_map_add(weapon, "start_weight",		weaponData.weight);
	ds_map_add(weapon, "start_accuracy",	weaponData.accuracy);
	ds_map_add(weapon, "start_energy",		weaponData.energy);
	ds_map_add(weapon, "start_damage",		weaponData.damage);
	ds_map_add(weapon, "start_penetration",	weaponData.penetration);
	ds_map_add(weapon, "start_speed",		weaponData.projectile_speed);
	ds_map_add(weapon, "energy_buffed",		weaponData.energy_buffed);

	--SPRITES
	--small sprite
	local small_sprite = Common.AddSprite(weaponData.sprite_small, 0, false, false, 0, 0);
	ds_map_add(weapon, "sprite", small_sprite);
	--huge sprite
	local huge_sprite = Common.AddSprite(weaponData.sprite_huge, 0, false, false, 199, 134);
	--big sprite
	local big_sprite = Common.AddSprite(weaponData.sprite_big, 0, false, false, 199, 134);
	--merge the big and huge sprites
	Common.MergeSprite(big_sprite, huge_sprite);
	ds_map_add(weapon, "sprite_big", big_sprite);

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type modded_component
	local moddedComponent = {
		component_type = Types.ComponentTypes.weapon,
		index = weapon_index - 1,
		sprite = small_sprite,
		name = weaponData.name,
		component_size = weaponData.component_size,
		researched = weaponData.researched,
		CanBeConstructed = weaponData.CanBeConstructed,
		BlueLength = weaponData.BlueLength,
		WeaponDescription = weaponData.WeaponDescription
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.weapon_stat = weapon_stat_array;
end

---Add a new solenoid to the games obj_database
---@param solenoidData solenoid_data
function Database.AddSolenoid(solenoidData)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local solenoid_stat_array = {};
	solenoid_stat_array = obj_database.solenoid_stat;

	----------------------
	--HIGH TECH SOLONOID--
	----------------------
	local high_tech_solenoid_index = #solenoid_stat_array + 1;
	solenoid_stat_array[high_tech_solenoid_index] = ds_map_create();
	local high_tech_solenoid = solenoid_stat_array[high_tech_solenoid_index];

	--ENGINEERING PRICE
	ds_map_add(high_tech_solenoid, "price_metallite",	solenoidData.price_metallite);
	ds_map_add(high_tech_solenoid, "price_bjorn",		solenoidData.price_bjorn);
	ds_map_add(high_tech_solenoid, "price_munilon",		solenoidData.price_munilon);
	ds_map_add(high_tech_solenoid, "price_skalaknit",	solenoidData.price_skalaknit);
	ds_map_add(high_tech_solenoid, "price_staff",		solenoidData.price_staff);
	ds_map_add(high_tech_solenoid, "days",				solenoidData.production_days);

	--STATS
	ds_map_add(high_tech_solenoid, "hp",				1000);	--doesn't seem to do anything
	ds_map_add(high_tech_solenoid, "power",				solenoidData.power);
	ds_map_add(high_tech_solenoid, "induction",			solenoidData.induction);
	ds_map_add(high_tech_solenoid, "weight",			2);		--cant find an effect on the reactor so i left it at the same value as a regular solenoid
	ds_map_add(high_tech_solenoid, "type",				1);		--As far as i can see there is only type 1 for solenoids

	--SPRITE
	local high_tech_solenoid_sprite = Common.AddSprite(solenoidData.sprite, 0, false, false, 0, 0);
	ds_map_add(high_tech_solenoid, "sprite", high_tech_solenoid_sprite);

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type modded_component
	local moddedComponent = {
		component_type = Types.ComponentTypes.solenoid,
		index = high_tech_solenoid_index - 1,
		sprite = high_tech_solenoid_sprite,
		name = solenoidData.name,
		component_size = solenoidData.component_size,
		researched = solenoidData.researched,
		CanBeConstructed = solenoidData.CanBeConstructed,
		BlueLength = 0,
		WeaponDescription = ""
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.solenoid_stat = solenoid_stat_array;
end

---Use in the load_game_post_event function of obj_database.lua
---
---This Fixes the missing production sprites after loading a modded game
---Modded sprite data is not saved so we need to fix this after load
function Database.LoadModdedSpritesOnProductionItems()
	local obj_component_shop = Common.GetObjComponentShop();

	--Copy the array to the working set
	local hanger_mass = {};
	hanger_mass = obj_component_shop.hanger_mass;

	--Hanger identifiers
	local hangerTableIndexes = {
		component_type = 2,
		item_index = 3,
		logo = 5,
		logo_index = 11
	};

	--We step through the hanger/production items to find our modded items
	for _, hangar in ipairs(hanger_mass) do
		local componentType = hangar[hangerTableIndexes.component_type];
		local itemIndex = hangar[hangerTableIndexes.item_index];

		for _, modded_item in ipairs(Storage.ModdedComponentList) do
			if(componentType == modded_item.component_type and itemIndex == modded_item.index) then
				--When the reference matches the modded element we set the relevant mod sprite to the logo and logo index.
				hangar[hangerTableIndexes.logo] = modded_item.sprite;
				hangar[hangerTableIndexes.logo_index] = modded_item.sprite;
			end
		end
	end

	--send array back
	obj_component_shop.hanger_mass = hanger_mass;
end

local update_weapon_desc = true;
---Use in the draw_top_menu function of obj_database.lua
---
---We need to update the weapon descriptions in the draw call since the ini isn't loaded in the create function
---however we only need to update once so we set the update_weapon_desc to false after the update to prevent repeat function spamming
function Database.FixWeaponDescriptions()
	local obj_weapon_test = Common.GetObjWeaponTest();
	if(obj_weapon_test.load_ini == false) then
		return;
	end

	---
	if(update_weapon_desc == false) then
		return;
	end

	--Copy the array to the working set
	local weaponDescriptions = {};
	weaponDescriptions = obj_weapon_test.weapon_description;

	for _, component in ipairs(Storage.ModdedComponentList) do
		if(component.component_type == Types.ComponentTypes.weapon) then
			local descriptionIndex = component.index + 1;
			weaponDescriptions[descriptionIndex] = component.WeaponDescription;
		end
	end

	--return new data
	obj_weapon_test.weapon_description = weaponDescriptions;

	update_weapon_desc = false;
end

return Database;