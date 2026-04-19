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
---@param mech_data mech_data dataset for adding a new mech
function Database.AddMechToObjDB(mech_data)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local mech_stat_array = {};
	mech_stat_array = obj_database.mech_stat;

	local mech_index = #mech_stat_array + 1;
	local mech = ds_map_create();
	mech_stat_array[mech_index] = mech;

	--ENGINEERING PRICE
	ds_map_add(mech, "price_metallite",	mech_data.price_metallite);
	ds_map_add(mech, "price_bjorn",		mech_data.price_bjorn);
	ds_map_add(mech, "price_munilon",	mech_data.price_munilon);
	ds_map_add(mech, "price_skalaknit",	mech_data.price_skalaknit);
	ds_map_add(mech, "price_staff",		mech_data.price_staff);
	ds_map_add(mech, "days",			mech_data.production_days);

	--RESISTANCES
	ds_map_add(mech, "heat_resist",		mech_data.heat_resist);
	ds_map_add(mech, "impact_resist",	mech_data.impact_resist);
	ds_map_add(mech, "current_resist",	mech_data.current_resist);

	--STATS
	ds_map_add(mech, "hp", 				1000);  --1000 is the default for all mechs, not sure if the game does something with this value
	ds_map_add(mech, "melee_option",	mech_data.has_melee);
	ds_map_add(mech, "armor",			mech_data.passive_armor);
	ds_map_add(mech, "weight",			mech_data.weight);
	ds_map_add(mech, "speed",			mech_data.speed);
	ds_map_add(mech, "reload_time",		mech_data.reload_time);
	ds_map_add(mech, "battle_time",		mech_data.battle_time);

	--MODULE CELLS
	Private.AddCells(mech, mech_data.mech_cells);

	--SPRITES
	--small sprite
	local mech_sprite = sprite_add(mech_data.sprite_small, 0, false, false, 23, 49);
	ds_map_add(mech, "sprite_small", mech_sprite);
	--big sprite
	ds_map_add(mech, "sprite_big", sprite_add(mech_data.sprite_big, 0, false, false, 199, 343));
	--battle sprite
	ds_map_add(mech, "sprite_battle", sprite_add(mech_data.sprite_battle, 2, true, false, 25, 25));
	--dead sprite
	ds_map_add(mech, "sprite_battle_dead", sprite_add(mech_data.sprite_battle_dead, 1, true, false, 23, 23));
	--melee vertical
	if(mech_data.sprite_battle_melee_ver ~= nil) then
		ds_map_add(mech, "sprite_battle_melee_ver", sprite_add(mech_data.sprite_battle_melee_ver, 7, true, false, 17, 25));
	end
	--melee horizontal
	if(mech_data.sprite_battle_melee_hor ~= nil) then
		ds_map_add(mech, "sprite_battle_melee_hor", sprite_add(mech_data.sprite_battle_melee_hor, 7, true, false, 25, 25));
	end

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type modded_component
	local moddedComponent = {
		component_type = Types.ComponentTypes.mech,
		index = mech_index - 1,
		sprite = mech_sprite,
		name = mech_data.name,
		component_size = mech_data.component_size,
		researched = mech_data.researched,
		CanBeConstructed = mech_data.CanBeConstructed,
		BlueLength = 0
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
---@param weapon_data weapon_data
function Database.AddWeaponToObjDB(weapon_data)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local weapon_stat_array = {};
	weapon_stat_array = obj_database.weapon_stat;

	local weapon_index = #weapon_stat_array + 1;
	weapon_stat_array[weapon_index] = ds_map_create();
	local weapon = weapon_stat_array[weapon_index];

	--ENGINEERING PRICE
	ds_map_add(weapon, "price_metallite",	weapon_data.price_metallite);
	ds_map_add(weapon, "price_bjorn",		weapon_data.price_bjorn);
	ds_map_add(weapon, "price_munilon",		weapon_data.price_munilon);
	ds_map_add(weapon, "price_skalaknit",	weapon_data.price_skalaknit);
	ds_map_add(weapon, "price_staff",		weapon_data.price_staff);
	ds_map_add(weapon, "days",				weapon_data.production_days);

	--STATS
	ds_map_add(weapon, "hp",				1000);	--a default value the game doesn't seem to use.
	ds_map_add(weapon, "number",			3);		--doesn't seem to do anything
	ds_map_add(weapon, "type",				weapon_data.weapon_type);
	ds_map_add(weapon, "start_fire_speed",	weapon_data.fire_rate);
	ds_map_add(weapon, "start_weight",		weapon_data.weight);
	ds_map_add(weapon, "start_accuracy",	weapon_data.accuracy);
	ds_map_add(weapon, "start_energy",		weapon_data.energy);
	ds_map_add(weapon, "start_damage",		weapon_data.damage);
	ds_map_add(weapon, "start_penetration",	weapon_data.penetration);
	ds_map_add(weapon, "start_speed",		weapon_data.projectile_speed);
	ds_map_add(weapon, "energy_buffed",		weapon_data.energy_buffed);

	--SPRITES
	--small sprite
	local small_sprite = sprite_add(weapon_data.sprite_small, 0, false, false, 0, 0);
	ds_map_add(weapon, "sprite", small_sprite);
	--huge sprite
	local huge_sprite = sprite_add(weapon_data.sprite_huge, 0, false, false, 199, 134);
	--big sprite
	local big_sprite = sprite_add(weapon_data.sprite_big, 0, false, false, 199, 134);
	--merge the big and huge sprites
	sprite_merge(big_sprite, huge_sprite);
	ds_map_add(weapon, "sprite_big", big_sprite);

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type modded_component
	local moddedComponent = {
		component_type = Types.ComponentTypes.weapon,
		index = weapon_index - 1,
		sprite = small_sprite,
		name = weapon_data.name,
		component_size = weapon_data.component_size,
		researched = weapon_data.researched,
		CanBeConstructed = weapon_data.CanBeConstructed,
		BlueLength = weapon_data.BlueLength
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.weapon_stat = weapon_stat_array;
end

---Add a new solenoid to the games obj_database
---@param solenoid_data solenoid_data
function Database.AddSolenoidToObjDB(solenoid_data)
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
	ds_map_add(high_tech_solenoid, "price_metallite",	solenoid_data.price_metallite);
	ds_map_add(high_tech_solenoid, "price_bjorn",		solenoid_data.price_bjorn);
	ds_map_add(high_tech_solenoid, "price_munilon",		solenoid_data.price_munilon);
	ds_map_add(high_tech_solenoid, "price_skalaknit",	solenoid_data.price_skalaknit);
	ds_map_add(high_tech_solenoid, "price_staff",		solenoid_data.price_staff);
	ds_map_add(high_tech_solenoid, "days",				solenoid_data.production_days);

	--STATS
	ds_map_add(high_tech_solenoid, "hp",				1000);	--doesn't seem to do anything
	ds_map_add(high_tech_solenoid, "power",				solenoid_data.power);
	ds_map_add(high_tech_solenoid, "induction",			solenoid_data.induction);
	ds_map_add(high_tech_solenoid, "weight",			2);		--cant find an effect on the reactor so i left it at the same value as a regular solenoid
	ds_map_add(high_tech_solenoid, "type",				1);		--As far as i can see there is only type 1 for solenoids

	--SPRITE
	local high_tech_solenoid_sprite = sprite_add(solenoid_data.sprite, 0, false, false, 0, 0);
	ds_map_add(high_tech_solenoid, "sprite", high_tech_solenoid_sprite);

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type modded_component
	local moddedComponent = {
		component_type = Types.ComponentTypes.solenoid,
		index = high_tech_solenoid_index - 1,
		sprite = high_tech_solenoid_sprite,
		name = solenoid_data.name,
		component_size = solenoid_data.component_size,
		researched = solenoid_data.researched,
		CanBeConstructed = solenoid_data.CanBeConstructed,
		BlueLength = 0
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

return Database;