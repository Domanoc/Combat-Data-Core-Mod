--To prevent collisions of global variables between mods.
--I have prefixed global variables of this mod.
--If copying code please change the prefix to something unique for your mod.
local unique_mod_prefix = "CDC_";

--Game is made in GameMaker
--See the gamemaker documentation for the implimentation of the global functions
--example: variable_global_set, ds_map_add, sprite_add
--the exposed functions can be found in the list_of_functions.txt file found in the example mod

--Module identifiers
local modules = {
	aux = 1,
	motor = 2,
	reactor = 3,
	gun = 4,
	cabin = 5
};

--Component types
local component_types = {
	mech = 1,
	cabin = 2,
	motor = 3,
	weapon = 4,
	reactor = 5,
	injector = 6,
	piston = 7,
	kernel = 8,
	safety = 9,
	magnet = 10,
	solenoid = 11,
	armor_layer_middle = 95,
	armor_layer_end = 96,
	rocket = 97,
	beacon = 98,
	city_parts = 99
};

--Weapon type identifiers
local weapon_types = {
	white = "white",	--ballistic
	red = "red",		--rockets
	blue = "blue",		--laser/tesla
	yellow = "yellow",  --thermal
};

---@class modded_hanger_item
---@field component_type 1|2|3|4|5|6|7|8|9|10|11|95|96|97|98|99 the type of component
---@field index number the index of the component
---@field sprite number the index of the component sprite 
local modded_hanger_item = {};

---@class mech_data dataset for adding a new mech
---@field price_metallite number the amount of metallite needed to produce this mech
---@field price_bjorn number the amount of bjorn needed to produce this mech
---@field price_munilon number the amount of munilon needed to produce this mech
---@field price_skalaknit number the amount of skalaknit needed to produce this mech
---@field price_staff number the amount of staff needed to produce this mech
---@field production_days number the amount of days it takes to produce this mech
---@field heat_resist number the heat resist value of the mech
---@field impact_resist number the impact resist value of the mech
---@field current_resist number the current resist value of the mech
---@field has_melee 0|1 Indicates if the mech can use a melee weapon
---@field passive_armor number the amount of passive armor the mech has
---@field weight number the base weight of the mech
---@field speed number the base speed of the mech
---@field reload_time number the base reload time of the mech
---@field battle_time number the base battle time of the mech (the lenght of time it has ammo reserves for to shoot)
---@field mech_cells mech_cell[] the dataset on what cells the mech has
---@field sprite_small string the small sprite for the mech
---@field sprite_big string the big sprite for the mech
---@field sprite_battle string the spritesheet for the mech used on the battle screen
---@field sprite_battle_dead string the sprite for a destroyed mech on the battle screen
---@field sprite_battle_melee_ver string|nil the vertical melee attack spritesheet used on the battle screen. optional if the mech has no melee
---@field sprite_battle_melee_hor string|nil the horizontal melee attack spritesheet used on the battle screen. optional if the mech has no melee
local mech_data = {};

---@class mech_cell dataset on what cells a mech has
---@field moduleType 1|2|3|4|5 module type (1-aux, 2-motor, 3-reactor, 4-gun, 5-cabin)
---@field x number the x coordinate for the cell, use the mod_mech_grid_help.png for help determining the location
---@field y number the y coordinate for the cell, use the mod_mech_grid_help.png for help determining the location
local mech_cell = {};

---@class weapon_data dataset for adding a new mech
---@field price_metallite number the amount of metallite needed to produce this mech
---@field price_bjorn number the amount of bjorn needed to produce this mech
---@field price_munilon number the amount of munilon needed to produce this mech
---@field price_skalaknit number the amount of skalaknit needed to produce this mech
---@field price_staff number the amount of staff needed to produce this mech
---@field production_days number the amount of days it takes to produce this mech
---@field weapon_type "white"|"red"|"blue"|"yellow" the type of weapon (white = ballistic, red = rockets, blue = laser/tesla, yellow = thermal)
---@field fire_rate number the base fire rate. higher values offer a faster rate, 600 with full firespeed points will fill the firespeed bar completely
---@field weight number the base weight of the weapon
---@field accuracy number the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
---@field energy number the base energy cost of the weapon
---@field damage number the base damage value of the weapon
---@field penetration number the base penetration value of the weapon
---@field projectile_speed number the base projectile speed of the weapon
---@field energy_buffed 0|1 whether the energy cost boost damage output, 1 = yes, for laser/tesla weapons this is an additional increase on their native bonus.
---@field sprite_small string the small sprite for the weapon
---@field sprite_big string the big sprite for the weapon
---@field sprite_huge string the huge sprite for the weapon
local weapon_data = {};

--A list of the modded components used to fix the sprite references on load
---@type modded_hanger_item[]
local modded_component_list = {};

function create(q,v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	---------------------------
	--DEBUG SETTINGS-----------
	---------------------------
	variable_global_set(unique_mod_prefix.."debug_spawn_test_weapons", true);
	variable_global_set(unique_mod_prefix.."debug_spawn_test_mechs", true);
	variable_global_set(unique_mod_prefix.."debug_unlock_research", true);
	---------------------------
	---------------------------

	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("obj_database.lua","");

	-----------------
	--MECHS----------
	-----------------	

	-----------------
	--NOVA MECH------
	-----------------
	local nova_mech_index = AddMech({
		price_metallite = 400,
		price_bjorn = 	  200,
		price_munilon =   320,
		price_skalaknit = 220,
		price_staff = 	  245,
		production_days = 4,
		heat_resist = 	  20,
		impact_resist =   15,
		current_resist =  40,
		has_melee = 	  1,
		passive_armor =   2,
		weight = 		  65,
		speed = 		  0.4,
		reload_time = 	  3,
		battle_time = 	  3,
		mech_cells = {
			{moduleType = modules.motor, 	x =   7, y =  6} --motor 1
			,{moduleType = modules.motor, 	x =  -7, y =  6} --motor 2
			,{moduleType = modules.motor, 	x =   7, y = 11} --motor 3
			,{moduleType = modules.motor, 	x =  -7, y = 11} --motor 4
			,{moduleType = modules.motor, 	x =   7, y = 16} --motor 5
			,{moduleType = modules.motor, 	x =  -7, y = 16} --motor 6
			,{moduleType = modules.reactor, x =   0, y = 18} --reactor
			,{moduleType = modules.gun, 	x =  14, y = 20} --gun 1
			,{moduleType = modules.gun, 	x = -14, y = 20} --gun 2
			,{moduleType = modules.cabin, 	x =   0, y = 25} --cabin
			,{moduleType = modules.aux, 	x =   6, y = 21} --aux 1
			,{moduleType = modules.aux, 	x =  -6, y = 21} --aux 2
			,{moduleType = modules.aux, 	x =   6, y = 27} --aux 3
			,{moduleType = modules.aux, 	x =  -6, y = 27} --aux 4
			,{moduleType = modules.aux, 	x =  11, y = 27} --aux 5
			,{moduleType = modules.aux, 	x = -11, y = 27} --aux 6
			,{moduleType = modules.aux, 	x =   0, y = 33} --aux 7
		},
		sprite_small = 			  current_file_path.."sprites/nova_small.png",
		sprite_big = 			  current_file_path.."sprites/nova_big.png",
		sprite_battle = 		  current_file_path.."sprites/nova_battle.png",
		sprite_battle_dead = 	  current_file_path.."sprites/nova_dead.png",
		sprite_battle_melee_ver = current_file_path.."sprites/nova_melee_vertical.png",
		sprite_battle_melee_hor = current_file_path.."sprites/nova_melee_horizontal.png"
	});
	variable_global_set(unique_mod_prefix.."nova_mech_index", nova_mech_index);

	-----------------
	--SENTINEL MECH--
	-----------------
	local sentinel_mech_index = AddMech({
		price_metallite = 1050,
		price_bjorn = 	  730,
		price_munilon =   1030,
		price_skalaknit = 880,
		price_staff = 	  325,
		production_days = 6,
		heat_resist = 	  25,
		impact_resist =   90,
		current_resist =  80,
		has_melee = 	  1,
		passive_armor =   5,
		weight = 		  70,
		speed = 		  0.2,
		reload_time = 	  4,
		battle_time = 	  5,
		mech_cells = {
			{moduleType = modules.motor, 	x =   8, y =  6} --motor 1
			,{moduleType = modules.motor, 	x =  -8, y =  6} --motor 2
			,{moduleType = modules.motor, 	x =   8, y = 11} --motor 3
			,{moduleType = modules.motor, 	x =  -8, y = 11} --motor 4
			,{moduleType = modules.motor, 	x =   7, y = 16} --motor 5
			,{moduleType = modules.motor, 	x =  -7, y = 16} --motor 6
			,{moduleType = modules.reactor, x =   0, y = 24} --reactor
			,{moduleType = modules.gun, 	x =  14, y = 22} --gun 1
			,{moduleType = modules.gun, 	x = -14, y = 22} --gun 2
			,{moduleType = modules.gun, 	x =   7, y = 41} --gun 3
			,{moduleType = modules.gun, 	x =  -7, y = 41} --gun 4
			,{moduleType = modules.cabin, 	x =   0, y = 32} --cabin
			,{moduleType = modules.aux, 	x =   6, y = 22} --aux 1
			,{moduleType = modules.aux, 	x =  -6, y = 22} --aux 2
			,{moduleType = modules.aux, 	x =   6, y = 35} --aux 3
			,{moduleType = modules.aux, 	x =  -6, y = 35} --aux 4
			,{moduleType = modules.aux, 	x =   6, y = 29} --aux 5
			,{moduleType = modules.aux, 	x =  -6, y = 29} --aux 6
			,{moduleType = modules.aux, 	x =  11, y = 33} --aux 7
			,{moduleType = modules.aux, 	x = -11, y = 33} --aux 8
		},
		sprite_small = 			  current_file_path.."sprites/sentinel_small.png",
		sprite_big = 			  current_file_path.."sprites/sentinel_big.png",
		sprite_battle = 		  current_file_path.."sprites/sentinel_battle.png",
		sprite_battle_dead = 	  current_file_path.."sprites/sentinel_dead.png",
		sprite_battle_melee_ver = current_file_path.."sprites/sentinel_melee_vertical.png",
		sprite_battle_melee_hor = current_file_path.."sprites/sentinel_melee_horizontal.png"
	});
	variable_global_set(unique_mod_prefix.."sentinel_mech_index", sentinel_mech_index);

	-----------------
	--BEHEMOTH MECH--
	-----------------
	local behemoth_mech_index = AddMech({
		price_metallite = 4130,
		price_bjorn = 	  1460,
		price_munilon =   2300,
		price_skalaknit = 2020,
		price_staff = 	  600,
		production_days = 8,
		heat_resist = 	  45,
		impact_resist =   95,
		current_resist =  95,
		has_melee = 	  1,
		passive_armor =   10,
		weight = 		  108,
		speed = 		  0.1,
		reload_time = 	  3,
		battle_time = 	  12,
		mech_cells = {
			{moduleType = modules.motor, 	x =   7, y =  5} --motor 1
			,{moduleType = modules.motor, 	x =  -7, y =  5} --motor 2
			,{moduleType = modules.motor, 	x =   7, y =  9} --motor 3
			,{moduleType = modules.motor, 	x =  -7, y =  9} --motor 4
			,{moduleType = modules.motor, 	x =   7, y = 13} --motor 5
			,{moduleType = modules.motor, 	x =  -7, y = 13} --motor 6
			,{moduleType = modules.motor, 	x =   7, y = 17} --motor 7
			,{moduleType = modules.motor, 	x =  -7, y = 17} --motor 8
			,{moduleType = modules.reactor, x =   0, y = 22} --reactor
			,{moduleType = modules.gun, 	x =  15, y = 27} --gun 1
			,{moduleType = modules.gun, 	x = -15, y = 27} --gun 2
			,{moduleType = modules.gun, 	x =  24, y = 27} --gun 3
			,{moduleType = modules.gun, 	x = -24, y = 27} --gun 4
			,{moduleType = modules.gun, 	x =  15, y = 21} --gun 5
			,{moduleType = modules.gun, 	x = -15, y = 21} --gun 6
			,{moduleType = modules.gun, 	x =  24, y = 21} --gun 7
			,{moduleType = modules.gun, 	x = -24, y = 21} --gun 8
			,{moduleType = modules.gun, 	x =  15, y = 15} --gun 9
			,{moduleType = modules.gun, 	x = -15, y = 15} --gun 10
			,{moduleType = modules.gun, 	x =  24, y = 15} --gun 11
			,{moduleType = modules.gun, 	x = -24, y = 15} --gun 12
			,{moduleType = modules.cabin, 	x =   0, y = 30} --cabin
			,{moduleType = modules.aux, 	x =   6, y = 36} --aux 1
			,{moduleType = modules.aux, 	x =  -6, y = 36} --aux 2
			,{moduleType = modules.aux, 	x =  11, y = 36} --aux 3
			,{moduleType = modules.aux, 	x = -11, y = 36} --aux 4
			,{moduleType = modules.aux, 	x =   6, y = 31} --aux 5
			,{moduleType = modules.aux, 	x =  -6, y = 31} --aux 6
			,{moduleType = modules.aux, 	x =  11, y = 26} --aux 7
			,{moduleType = modules.aux, 	x = -11, y = 26} --aux 8
		},
		sprite_small = 			  current_file_path.."sprites/behemoth_small.png",
		sprite_big = 			  current_file_path.."sprites/behemoth_big.png",
		sprite_battle = 		  current_file_path.."sprites/behemoth_battle.png",
		sprite_battle_dead = 	  current_file_path.."sprites/behemoth_dead.png",
		sprite_battle_melee_ver = current_file_path.."sprites/behemoth_melee_vertical.png",
		sprite_battle_melee_hor = current_file_path.."sprites/behemoth_melee_horizontal.png"
	});
	variable_global_set(unique_mod_prefix.."behemoth_mech_index", behemoth_mech_index);

	-----------------
	--ECHO MECH------
	-----------------
	local echo_mech_index = AddMech({
		price_metallite = 620,
		price_bjorn = 	  275,
		price_munilon =   520,
		price_skalaknit = 400,
		price_staff = 	  265,
		production_days = 5,
		heat_resist = 	  20,
		impact_resist =   30,
		current_resist =  20,
		has_melee = 	  0,
		passive_armor =   3,
		weight = 		  80,
		speed = 		  0.4,
		reload_time = 	  2,
		battle_time = 	  4,
		mech_cells = {
			{moduleType = modules.motor, 	x =   9, y =  7} --motor 1
			,{moduleType = modules.motor, 	x =  -9, y =  7} --motor 2
			,{moduleType = modules.motor, 	x =   6, y = 12} --motor 3
			,{moduleType = modules.motor, 	x =  -6, y = 12} --motor 4
			,{moduleType = modules.motor, 	x =  13, y = 15} --motor 5
			,{moduleType = modules.motor, 	x = -13, y = 15} --motor 6
			,{moduleType = modules.motor, 	x =   0, y = 16} --motor 7
			,{moduleType = modules.reactor, x =   0, y = 22} --reactor
			,{moduleType = modules.gun, 	x =  13, y = 28} --gun 1
			,{moduleType = modules.gun, 	x = -13, y = 28} --gun 2
			,{moduleType = modules.gun, 	x =   7, y = 35} --gun 3
			,{moduleType = modules.cabin, 	x =   0, y = 29} --cabin
			,{moduleType = modules.aux, 	x =   7, y = 19} --aux 1
			,{moduleType = modules.aux, 	x =  -7, y = 19} --aux 2
			,{moduleType = modules.aux, 	x =   6, y = 24} --aux 3
			,{moduleType = modules.aux, 	x =  -6, y = 24} --aux 4
			,{moduleType = modules.aux, 	x =   5, y = 29} --aux 5
			,{moduleType = modules.aux, 	x =  -5, y = 29} --aux 6
		},
		sprite_small = 			  current_file_path.."sprites/echo_small.png",
		sprite_big = 			  current_file_path.."sprites/echo_big.png",
		sprite_battle = 		  current_file_path.."sprites/echo_battle.png",
		sprite_battle_dead = 	  current_file_path.."sprites/echo_dead.png",
	});
	variable_global_set(unique_mod_prefix.."echo_mech_index", echo_mech_index);

	-----------------
	--SOLENOIDS------
	-----------------

	--Copy the array to the working set
	local solenoid_stat_array = {};
	solenoid_stat_array = q.solenoid_stat;

	----------------------
	--HIGH TECH SOLONOID--
	----------------------
	local high_tech_solenoid_index = #solenoid_stat_array + 1;
	variable_global_set(unique_mod_prefix.."high_tech_solenoid_index", #solenoid_stat_array);
	solenoid_stat_array[high_tech_solenoid_index] = ds_map_create();
	local high_tech_solenoid = solenoid_stat_array[high_tech_solenoid_index];

	--ENGINEERING PRICE
	ds_map_add(high_tech_solenoid, "price_metallite",	150);
	ds_map_add(high_tech_solenoid, "price_bjorn",		150);
	ds_map_add(high_tech_solenoid, "price_munilon",		200);
	ds_map_add(high_tech_solenoid, "price_skalaknit",	25);
	ds_map_add(high_tech_solenoid, "price_staff",		70);
	ds_map_add(high_tech_solenoid, "days",				4);

	--STATS
	ds_map_add(high_tech_solenoid, "hp",				1000);
	ds_map_add(high_tech_solenoid, "power",				3);		--Lower numbers give more heat resist on reactor
	ds_map_add(high_tech_solenoid, "induction",			1);		--any deviation from 1 gives worse energy stats
	ds_map_add(high_tech_solenoid, "weight",			2);		--cant find an effect on the reactor so i left it at the same value as a regular solenoid
	ds_map_add(high_tech_solenoid, "type",				1);		--As far as i can see there is only type 1 for solenoids

	--SPRITE
	local high_tech_solenoid_sprite = sprite_add(current_file_path.."sprites/high_tech_solenoid.png", 0, false, false, 0, 0);
	ds_map_add(high_tech_solenoid, "sprite", high_tech_solenoid_sprite);

	--Add the newly modded item to the component list to make sure the sprite gets reset on load
	table.insert(modded_component_list, {
		component_type = component_types.solenoid,
		index = #solenoid_stat_array,
		sprite = high_tech_solenoid_sprite
	});


	--return new data
	q.solenoid_stat = solenoid_stat_array;

	-----------------
	--WEAPONS--------
	-----------------

	------------
	--HOWITZER--
	------------
	local howitzer_weapon_index = AddWeapon({
		price_metallite =  200,
		price_bjorn = 	   50,
		price_munilon =    30,
		price_skalaknit =  60,
		price_staff = 	   45,
		production_days =  4,
		weapon_type = 	   weapon_types.white,
		fire_rate = 	   25,
		weight = 		   48,
		accuracy = 		   1.5,
		energy = 		   5,
		damage = 		   80,
		penetration = 	   15,
		projectile_speed = 18,
		energy_buffed =    0,
		sprite_small =     current_file_path.."sprites/howitzer_small.png",
		sprite_big = 	   current_file_path.."sprites/howitzer_big.png",
		sprite_huge = 	   current_file_path.."sprites/howitzer_huge.png"
	});
	variable_global_set(unique_mod_prefix.."howitzer_weapon_index", howitzer_weapon_index);
	
	----------------------
	--LASER PULSE CANNON--
	----------------------
	local laser_pulse_cannon_weapon_index = AddWeapon({
		price_metallite =  250,
		price_bjorn = 	   245,
		price_munilon =    500,
		price_skalaknit =  130,
		price_staff = 	   110,
		production_days =  8,
		weapon_type = 	   weapon_types.blue,
		fire_rate = 	   600,
		weight = 		   80,
		accuracy = 		   0,
		energy = 		   10,
		damage = 		   40,
		penetration = 	   5,
		projectile_speed = 0,
		energy_buffed =    0,
		sprite_small =     current_file_path.."sprites/laser_pulse_cannon_small.png",
		sprite_big = 	   current_file_path.."sprites/laser_pulse_cannon_big.png",
		sprite_huge = 	   current_file_path.."sprites/laser_pulse_cannon_huge.png"
	});
	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_weapon_index", laser_pulse_cannon_weapon_index);
	--we want to mod the range later since this can only be done at runtime in battle or the object holder
	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_weapon_range", 2000);
end

function save_game_pre_event(q)
	--saving system deletes the file and creates new one before saving new info
end

function save_game_post_event(q)
end

function load_game_pre_event(q)
end

function load_game_post_event(q)
	--Modded sprite data is not saved so we need to fix this after load
	local obj_component_shop = asset_get_index("obj_component_shop");

	--Copy the array to the working set
	local hanger_mass = {};
	hanger_mass = obj_component_shop.hanger_mass;

	--Hanger identifiers
	local hanger = {
		component_type = 2,
		item_index = 3,
		logo = 5,
		logo_index = 11
	};

	--We step through the hanger/production items to find our modded items
	for _, hangar in ipairs(hanger_mass) do
		for _, modded_item in ipairs(modded_component_list) do
			if(hangar[hanger.component_type] == modded_item.component_type and hangar[hanger.item_index] == modded_item.index) then
				--When the reference matches the modded element we set the relevant mod sprite to the logo and logo index.
				hangar[hanger.logo] = modded_item.sprite;
				hangar[hanger.logo_index] = modded_item.sprite;
			end
		end
	end

	--send array back
	obj_component_shop.hanger_mass = hanger_mass;
end

local update_weapon_desc = true;
local fix_research = true;
function draw_top_menu(q)
	--We need to update the weapon descriptions in the draw call since the ini isn't loaded in the create function
	--however we only need to update once so we set the update_weapon_desc to false after the update to prevent repeat function spamming
	local weapon_strings = asset_get_index("obj_weapon_test");
	local is_ini_loaded = weapon_strings.load_ini;
	--Wait till the ini is loaded.
	if (is_ini_loaded == true and update_weapon_desc == true) then
		update_weapon_desc = false;

		--Copy the array to the working set
		local weapon_description_array = {};
		weapon_description_array = weapon_strings.weapon_description;

		local howitzer_weapon_index = variable_global_get(unique_mod_prefix.."howitzer_weapon_index") + 1; --need to offset by 1 to use the index here
		weapon_description_array[howitzer_weapon_index] = "240-MM HOWITZER GUN.";

		local laser_pulse_cannon_weapon_index = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index") + 1; --need to offset by 1 to use the index here
		weapon_description_array[laser_pulse_cannon_weapon_index] = "EXTENDED RANGE LASER PULSE CANNON.#Uses an internal power unit to provide most of the energy. Can be boosted by providing additional power.";

		--return new data
		weapon_strings.weapon_description = weapon_description_array;

		--Use the next line to print a debug of the recorded weapon descriptions
		--dump_obj_to_message(weapon_strings.weapon_description);
    end

	--We only fix the research after all the loading is done. so we can piggyback on the load flag for obj_weapon_test
	if(is_ini_loaded == true and fix_research == true) then
		fix_research = false;
		--In the event the mod is added to an existing save the newly added mod research is all defaulted to 0 days remaining and condition 0 (closed).
		--To fix this we need to validate the research states to see if its a valid state through gameplay or if its a state from loading into an existing state

		local loaded_research_list = variable_global_get(unique_mod_prefix.."loaded_research_list");
		local modded_research_list = variable_global_get(unique_mod_prefix.."modded_research_list");
		local data_core_research_index = variable_global_get(unique_mod_prefix.."data_core_research_index");

		for _, v in ipairs(modded_research_list) do
			local research = loaded_research_list[v + 1];
			
			if(v == data_core_research_index and research.condition == 0) then
				--special condition since this mod has a research that is set to condition 2 on mod load we need force it back to condition 2 if it was closed.
				--all other states should be fine: 
				--condition 1: it would mean the player stopped the research from continueing.
				--condition 2: was de desired state to begin with.
				--condition 3: it is already completed so should be a correct working data set.

				research.condition = 2;
				research.require_days = research.require_days_max;
			elseif(research.condition == 0 and research.require_days ~= research.require_days_max) then
				--Condition 0 (closed) -> research has never been started/unlocked it should have the default require_days values
				research.require_days = research.require_days_max;
			elseif(research.condition == 1 and research.require_days == 0)  then
				--Condition 1 (opened) -> it should have days remaining between 1 and require_days_max, 0 should be excluded as it would have moved to the condition 3
				--We only care about the case where require_days is at 0 since this would indicate a newly added research that was set to opened because the linked research was completed before.
				research.require_days = research.require_days_max;
			end

			--condition 2 (researching) -> should be a valid state, we can't conclude if the number of days remaining is correct other than it should be less or equal to the max value.
			--condition 3 (researched) -> require_days should be 0
			--both these conditions shouldn't need our attention as they are most likely part of normal gameplay
		end
	end
end

function draw_debug(q)
end

---Adds a new mech
---@param mech_data mech_data dataset for adding a new mech
---@return number index the index of the newly added mech
function AddMech(mech_data)
	local obj_database = asset_get_index("obj_database");

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
	AddCells(mech, mech_data.mech_cells);

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

	--Add the newly modded item to the component list to make sure the sprite gets reset on load
	table.insert(modded_component_list, {
		component_type = component_types.mech,
		index = mech_index - 1,
		sprite = mech_sprite
	});

	--return new data
	obj_database.mech_stat = mech_stat_array;

	return mech_index - 1;
end

---Adds the Cell data to the ds_map of the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cells mech_cell[] the cell data array for the mech
function AddCells(mech, cells)
	local aux_number = 0;
	local weapon_number = 0;

	for i = 1, #cells, 1 do
		local cell = cells[i];
		AddCell(mech, i, cell);

		if(cell.moduleType == modules.aux) then
			aux_number = aux_number + 1;
		end
		if(cell.moduleType == modules.gun) then
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
function AddCell(mech, cell_num, cell)
	ds_map_add(mech, "cell_"..		cell_num, 	cell.moduleType);
	ds_map_add(mech, "cell_x_"..	cell_num, 	cell.x);
	ds_map_add(mech, "cell_y_"..	cell_num, 	cell.y);
end

---Add a new weapon
---@param weapon_data weapon_data
---@return number index the index of the newly added weapon
function AddWeapon(weapon_data)
	local obj_database = asset_get_index("obj_database");

	--Copy the array to the working set
	local weapon_stat_array = {};
	weapon_stat_array = obj_database.weapon_stat;

	------------
	--HOWITZER--
	------------
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

	--Add the newly modded item to the component list to make sure the sprite gets reset on load
	table.insert(modded_component_list, {
		component_type = component_types.weapon,
		index = weapon_index - 1,
		sprite = small_sprite
	});

	--return new data
	obj_database.weapon_stat = weapon_stat_array;

	return weapon_index - 1;
end






--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

---Prints a messagebox with the key and values of the gamemaker struct or table
---provide the reference id to the table
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference or table reference
function dump_obj_to_message(ref)
	if(type(ref) == "table") then
		local values = {};
		for k, v in pairs(ref) do
			table.insert(values, tostring(k).."::"..tostring(v));
		end
		local message = table.concat(values, ",\n");
		show_message(message);
	else
		local values = {};
		for k, v in pairs(struct_get_names(ref)) do
			table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ref[v]));
		end
		local message = table.concat(values, ",\n");
		show_message(message);
	end
end

--Prints a messagebox with the key and values of the gamemaker ds_map
--provide the reference id to the ds_map
--The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the reference to the ds_map
function dump_ds_map_to_message(ref)
	local values = {};
    for k, v in pairs(ds_map_keys_to_array(ref)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(ref, v)));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end