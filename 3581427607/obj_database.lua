--To prevent collisions of global variables between mods.
--I have prefixed global variables of this mod.
--If copying code please change the prefix to something unique for your mod.
local unique_mod_prefix = "CDC_";

--Game is made in GameMaker
--See the gamemaker documentation for the implimentation of the global functions
--example: variable_global_set, ds_map_add, sprite_add
--the exposed functions can be found in the list_of_functions.txt file found in the example mod

---@class mech_cell
---@field moduleType 1|2|3|4|5 module type (1-aux, 2-motor, 3-reactor, 4-gun, 5-cabin)
---@field x number the x coordinate for the cell, use the mod_mech_grid_help.png for help determining the location
---@field y number the y coordinate for the cell, use the mod_mech_grid_help.png for help determining the location
local mech_cell = {};

function create(q,v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	---------------------------
	--DEBUG SETTINGS-----------
	---------------------------
	variable_global_set(unique_mod_prefix.."debug_spawn_test_weapons", false);
	variable_global_set(unique_mod_prefix.."debug_spawn_test_mechs", true);
	variable_global_set(unique_mod_prefix.."debug_unlock_research", false);
	---------------------------
	---------------------------

	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("obj_database.lua","");

	-----------------
	--MECHS----------
	-----------------	
	
	--Copy the array to the working set
	local mech_stat_array = {};
	mech_stat_array = q.mech_stat;

	--Module identifiers
	local modules = {
		aux = 1,
		motor = 2,
		reactor = 3,
		gun = 4,
		cabin = 5
	};

	-----------------
	--NOVA MECH------
	-----------------
	local nova_mech_index = #mech_stat_array + 1;
	variable_global_set(unique_mod_prefix.."nova_mech_index", #mech_stat_array);
	local nova_mech = ds_map_create();
	mech_stat_array[nova_mech_index] = nova_mech;

	--ENGINEERING PRICE
	ds_map_add(nova_mech, "price_metallite",	400);
	ds_map_add(nova_mech, "price_bjorn",		200);
	ds_map_add(nova_mech, "price_munilon",		320);
	ds_map_add(nova_mech, "price_skalaknit",	220);
	ds_map_add(nova_mech, "price_staff",		245);
	ds_map_add(nova_mech, "days",				4);

	--RESISTANCES
	ds_map_add(nova_mech, "heat_resist",		20);
	ds_map_add(nova_mech, "impact_resist",		15);
	ds_map_add(nova_mech, "current_resist",		40);

	--STATS
	ds_map_add(nova_mech, "hp", 				1000);
	ds_map_add(nova_mech, "melee_option",		1);		--0 = false, 1 = true
	ds_map_add(nova_mech, "armor",				2);
	ds_map_add(nova_mech, "weight",				65);
	ds_map_add(nova_mech, "speed",				0.4);
	ds_map_add(nova_mech, "reload_time",		3);
	ds_map_add(nova_mech, "battle_time",		3);
	ds_map_add(nova_mech, "number_of_weapons",	2);
	ds_map_add(nova_mech, "number_of_aux",		7);

	--MODULE CELLS
	AddCells(nova_mech, {
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
	});

	--SPRITES
	--small sprite
	local nova_mech_sprite = sprite_add(current_file_path.."sprites/nova_small.png", 0, false, false, 23, 49);
	variable_global_set(unique_mod_prefix.."nova_sprite_small", nova_mech_sprite);
	ds_map_add(nova_mech, "sprite_small", nova_mech_sprite);
	--big sprite
	nova_mech_sprite = sprite_add(current_file_path.."sprites/nova_big.png", 0, false, false, 199, 343);				
	ds_map_add(nova_mech, "sprite_big", nova_mech_sprite);
	--battle sprite
	nova_mech_sprite = sprite_add(current_file_path.."sprites/nova_battle.png", 2, true, false, 25, 25);				
	ds_map_add(nova_mech, "sprite_battle", nova_mech_sprite);
	--dead sprite
	nova_mech_sprite = sprite_add(current_file_path.."sprites/nova_dead.png", 1, true, false, 23, 23);				
	ds_map_add(nova_mech, "sprite_battle_dead", nova_mech_sprite);
	--melee vertical
	nova_mech_sprite = sprite_add(current_file_path.."sprites/nova_melee_vertical.png", 7, true, false, 17, 25);		
	ds_map_add(nova_mech, "sprite_battle_melee_ver", nova_mech_sprite);
	--melee horizontal
	nova_mech_sprite = sprite_add(current_file_path.."sprites/nova_melee_horizontal.png", 7, true, false, 25, 25);	
	ds_map_add(nova_mech, "sprite_battle_melee_hor", nova_mech_sprite);

	-----------------
	--SENTINEL MECH--
	-----------------
	local sentinel_mech_index = #mech_stat_array + 1;
	variable_global_set(unique_mod_prefix.."sentinel_mech_index", #mech_stat_array);
	local sentinel_mech = ds_map_create();
	mech_stat_array[sentinel_mech_index] = sentinel_mech;
	
	--ENGINEERING PRICE
	ds_map_add(sentinel_mech, "price_metallite",	1050);
	ds_map_add(sentinel_mech, "price_bjorn",		730);
	ds_map_add(sentinel_mech, "price_munilon",		1030);
	ds_map_add(sentinel_mech, "price_skalaknit",	880);
	ds_map_add(sentinel_mech, "price_staff",		325);
	ds_map_add(sentinel_mech, "days",				6);

	--RESISTANCES
	ds_map_add(sentinel_mech, "heat_resist",		25);
	ds_map_add(sentinel_mech, "impact_resist",		90);
	ds_map_add(sentinel_mech, "current_resist",		80);

	--STATS
	ds_map_add(sentinel_mech, "hp", 				1000);		--1000 is the default for all mechs
	ds_map_add(sentinel_mech, "melee_option",		1);			--0 = false, 1 = true
	ds_map_add(sentinel_mech, "armor",				5);
	ds_map_add(sentinel_mech, "weight",				70);
	ds_map_add(sentinel_mech, "speed",				0.2);
	ds_map_add(sentinel_mech, "reload_time",		4);
	ds_map_add(sentinel_mech, "battle_time",		5);
	ds_map_add(sentinel_mech, "number_of_weapons",	4);
	ds_map_add(sentinel_mech, "number_of_aux",		8);

	--MODULE CELLS
	AddCells(sentinel_mech, {
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
	});

	--SPRITES
	--small sprite
	local sentinel_mech_sprite = sprite_add(current_file_path.."sprites/sentinel_small.png", 0, false, false, 23, 49);
	variable_global_set(unique_mod_prefix.."sentinel_sprite_small", sentinel_mech_sprite);
	ds_map_add(sentinel_mech, "sprite_small", sentinel_mech_sprite);
	--big sprite
	sentinel_mech_sprite = sprite_add(current_file_path.."sprites/sentinel_big.png", 0, false, false, 199, 343);				
	ds_map_add(sentinel_mech, "sprite_big", sentinel_mech_sprite);
	--battle sprite
	sentinel_mech_sprite = sprite_add(current_file_path.."sprites/sentinel_battle.png", 2, true, false, 25, 25);				
	ds_map_add(sentinel_mech, "sprite_battle", sentinel_mech_sprite);
	--dead sprite
	sentinel_mech_sprite = sprite_add(current_file_path.."sprites/sentinel_dead.png", 1, true, false, 23, 23);				
	ds_map_add(sentinel_mech, "sprite_battle_dead", sentinel_mech_sprite);
	--melee vertical
	sentinel_mech_sprite = sprite_add(current_file_path.."sprites/sentinel_melee_vertical.png", 7, true, false, 17, 25);		
	ds_map_add(sentinel_mech, "sprite_battle_melee_ver", sentinel_mech_sprite);
	--melee horizontal
	sentinel_mech_sprite = sprite_add(current_file_path.."sprites/sentinel_melee_horizontal.png", 7, true, false, 25, 25);	
	ds_map_add(sentinel_mech, "sprite_battle_melee_hor", sentinel_mech_sprite);

	-----------------
	--BEHEMOTH MECH--
	-----------------
	local behemoth_mech_index = #mech_stat_array + 1;
	variable_global_set(unique_mod_prefix.."behemoth_mech_index", #mech_stat_array);
	local behemoth_mech = ds_map_create();
	mech_stat_array[behemoth_mech_index] = behemoth_mech;
	
	--ENGINEERING PRICE
	ds_map_add(behemoth_mech, "price_metallite",	4130);
	ds_map_add(behemoth_mech, "price_bjorn",		1460);
	ds_map_add(behemoth_mech, "price_munilon",		2300);
	ds_map_add(behemoth_mech, "price_skalaknit",	2020);
	ds_map_add(behemoth_mech, "price_staff",		600);
	ds_map_add(behemoth_mech, "days",				8);

	--RESISTANCES
	ds_map_add(behemoth_mech, "heat_resist",		45);
	ds_map_add(behemoth_mech, "impact_resist",		95);
	ds_map_add(behemoth_mech, "current_resist",		95);

	--STATS
	ds_map_add(behemoth_mech, "hp", 				1000);		--1000 is the default for all mechs
	ds_map_add(behemoth_mech, "melee_option",		1);			--0 = false, 1 = true
	ds_map_add(behemoth_mech, "armor",				10);
	ds_map_add(behemoth_mech, "weight",				108);
	ds_map_add(behemoth_mech, "speed",				0.1);
	ds_map_add(behemoth_mech, "reload_time",		3);
	ds_map_add(behemoth_mech, "battle_time",		12);
	ds_map_add(behemoth_mech, "number_of_weapons",	12);
	ds_map_add(behemoth_mech, "number_of_aux",		8);

	--MODULE CELLS
	AddCells(behemoth_mech, {
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
	});

	--SPRITES
	--small sprite
	local behemoth_mech_sprite = sprite_add(current_file_path.."sprites/behemoth_small.png", 0, false, false, 23, 49);
	variable_global_set(unique_mod_prefix.."behemoth_sprite_small", behemoth_mech_sprite);
	ds_map_add(behemoth_mech, "sprite_small", behemoth_mech_sprite);
	--big sprite
	behemoth_mech_sprite = sprite_add(current_file_path.."sprites/behemoth_big.png", 0, false, false, 199, 343);				
	ds_map_add(behemoth_mech, "sprite_big", behemoth_mech_sprite);
	--battle sprite
	behemoth_mech_sprite = sprite_add(current_file_path.."sprites/behemoth_battle.png", 2, true, false, 25, 25);				
	ds_map_add(behemoth_mech, "sprite_battle", behemoth_mech_sprite);
	--dead sprite
	behemoth_mech_sprite = sprite_add(current_file_path.."sprites/behemoth_dead.png", 1, true, false, 23, 23);				
	ds_map_add(behemoth_mech, "sprite_battle_dead", behemoth_mech_sprite);
	--melee vertical
	behemoth_mech_sprite = sprite_add(current_file_path.."sprites/behemoth_melee_vertical.png", 7, true, false, 17, 25);		
	ds_map_add(behemoth_mech, "sprite_battle_melee_ver", behemoth_mech_sprite);
	--melee horizontal
	behemoth_mech_sprite = sprite_add(current_file_path.."sprites/behemoth_melee_horizontal.png", 7, true, false, 25, 25);	
	ds_map_add(behemoth_mech, "sprite_battle_melee_hor", behemoth_mech_sprite);

	-----------------
	--ECHO MECH------
	-----------------
	local echo_mech_index = #mech_stat_array + 1;
	variable_global_set(unique_mod_prefix.."echo_mech_index", #mech_stat_array);
	local echo_mech = ds_map_create();
	mech_stat_array[echo_mech_index] = echo_mech;

	--ENGINEERING PRICE
	ds_map_add(echo_mech, "price_metallite",	620);
	ds_map_add(echo_mech, "price_bjorn",		275);
	ds_map_add(echo_mech, "price_munilon",		520);
	ds_map_add(echo_mech, "price_skalaknit",	400);
	ds_map_add(echo_mech, "price_staff",		265);
	ds_map_add(echo_mech, "days",				5);

	--RESISTANCES
	ds_map_add(echo_mech, "heat_resist",		20);
	ds_map_add(echo_mech, "impact_resist",		30);
	ds_map_add(echo_mech, "current_resist",		20);

	--STATS
	ds_map_add(echo_mech, "hp", 				1000);
	ds_map_add(echo_mech, "melee_option",		0);		--0 = false, 1 = true
	ds_map_add(echo_mech, "armor",				3);
	ds_map_add(echo_mech, "weight",				80);
	ds_map_add(echo_mech, "speed",				0.4);
	ds_map_add(echo_mech, "reload_time",		2);
	ds_map_add(echo_mech, "battle_time",		4);
	ds_map_add(echo_mech, "number_of_weapons",	3);
	ds_map_add(echo_mech, "number_of_aux",		6);

	--MODULE CELLS
	AddCells(echo_mech, {
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
	});

	--SPRITES
	--small sprite
	local echo_mech_sprite = sprite_add(current_file_path.."sprites/echo_small.png", 0, false, false, 23, 49);
	variable_global_set(unique_mod_prefix.."echo_sprite_small", echo_mech_sprite);
	ds_map_add(echo_mech, "sprite_small", echo_mech_sprite);
	--big sprite
	echo_mech_sprite = sprite_add(current_file_path.."sprites/echo_big.png", 0, false, false, 199, 343);				
	ds_map_add(echo_mech, "sprite_big", echo_mech_sprite);
	--battle sprite
	echo_mech_sprite = sprite_add(current_file_path.."sprites/echo_battle.png", 2, true, false, 25, 25);				
	ds_map_add(echo_mech, "sprite_battle", echo_mech_sprite);
	--dead sprite
	echo_mech_sprite = sprite_add(current_file_path.."sprites/echo_dead.png", 1, true, false, 23, 23);				
	ds_map_add(echo_mech, "sprite_battle_dead", echo_mech_sprite);
	--melee vertical
	echo_mech_sprite = sprite_add(current_file_path.."sprites/echo_melee_vertical.png", 7, true, false, 17, 25);		
	ds_map_add(echo_mech, "sprite_battle_melee_ver", echo_mech_sprite);
	--melee horizontal
	echo_mech_sprite = sprite_add(current_file_path.."sprites/echo_melee_horizontal.png", 7, true, false, 25, 25);	
	ds_map_add(echo_mech, "sprite_battle_melee_hor", echo_mech_sprite);


	--return new data
	q.mech_stat = mech_stat_array;

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
	variable_global_set(unique_mod_prefix.."high_tech_solenoid_sprite_small", high_tech_solenoid_sprite);
	ds_map_add(high_tech_solenoid, "sprite", high_tech_solenoid_sprite);


	--return new data
	q.solenoid_stat = solenoid_stat_array;

	-----------------
	--WEAPONS--------
	-----------------
	
	--Copy the array to the working set
	local weapon_stat_array = {};
	weapon_stat_array = q.weapon_stat;

	--Weapon type identifiers
	local weapon_types = {
		white = "white",	--ballistic
		red = "red",		--rockets
		blue = "blue",		--laser/tesla
		yellow = "yellow",  --thermal
	};

	------------
	--HOWITZER--
	------------
	local howitzer_weapon_index = #weapon_stat_array + 1;
	variable_global_set(unique_mod_prefix.."howitzer_weapon_index", #weapon_stat_array);
	weapon_stat_array[howitzer_weapon_index] = ds_map_create();
	local howitzer = weapon_stat_array[howitzer_weapon_index];

	--ENGINEERING PRICE
	ds_map_add(howitzer, "price_metallite",		200);
	ds_map_add(howitzer, "price_bjorn",			50);
	ds_map_add(howitzer, "price_munilon",		30);
	ds_map_add(howitzer, "price_skalaknit",		60);
	ds_map_add(howitzer, "price_staff",			45);
	ds_map_add(howitzer, "days",				4);

	--STATS
	ds_map_add(howitzer, "hp",					1000);
	ds_map_add(howitzer, "type",				weapon_types.white); --type of weapon ("white", "red", "blue", "yellow")
	ds_map_add(howitzer, "number",				3);		--doesn't seem to do anything
	ds_map_add(howitzer, "start_fire_speed",	25);	--600 with full firespeed points will fill the firespeed bar completely
	ds_map_add(howitzer, "start_weight",		48);	--base weight
	ds_map_add(howitzer, "start_accuracy",		1.5);	--acceracy in degrees, 0 is perfect acceracy
	ds_map_add(howitzer, "start_energy",		5);		--energy requirement
	ds_map_add(howitzer, "start_damage",		80);	--base damage value
	ds_map_add(howitzer, "start_penetration",	15);	--base penetration value
	ds_map_add(howitzer, "start_speed",			18);	--the speed of the projectile
	ds_map_add(howitzer, "energy_buffed",		0);		--can't	be improved with bonus energy

	--SPRITES
	--small sprite
	local howitzer_small_sprite = sprite_add(current_file_path.."sprites/howitzer_small.png", 0, false, false, 0, 0);
	variable_global_set(unique_mod_prefix.."howitzer_sprite_small", howitzer_small_sprite);
	ds_map_add(howitzer, "sprite", howitzer_small_sprite);
	--huge sprite
	local howitzer_huge_sprite = sprite_add(current_file_path.."sprites/howitzer_huge.png", 0, false, false, 199, 134);
	--big sprite
	local howitzer_big_sprite = sprite_add(current_file_path.."sprites/howitzer_big.png", 0, false, false, 199, 134);
	--merge the big and huge sprites
	sprite_merge(howitzer_big_sprite, howitzer_huge_sprite);
	ds_map_add(howitzer, "sprite_big", howitzer_big_sprite);

	----------------------
	--LASER PULSE CANNON--
	----------------------
	local laser_pulse_cannon_weapon_index = #weapon_stat_array + 1;
	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_weapon_index", #weapon_stat_array);
	weapon_stat_array[laser_pulse_cannon_weapon_index] = ds_map_create();
	local exp = weapon_stat_array[laser_pulse_cannon_weapon_index];
	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_weapon_range", 2000);

	--ENGINEERING PRICE
	ds_map_add(exp, "price_metallite",		250);
	ds_map_add(exp, "price_bjorn",			245);
	ds_map_add(exp, "price_munilon",		500);
	ds_map_add(exp, "price_skalaknit",		130);
	ds_map_add(exp, "price_staff",			110);
	ds_map_add(exp, "days",					8);

	--STATS
	ds_map_add(exp, "hp",					1000);
	ds_map_add(exp, "type",					weapon_types.blue); --type of weapon ("white", "red", "blue", "yellow")
	ds_map_add(exp, "number",				3);		--doesn't seem to do anything
	ds_map_add(exp, "start_fire_speed",		600);	--600 with full firespeed points will fill the firespeed bar completely
	ds_map_add(exp, "start_weight",			80);	--base weight
	ds_map_add(exp, "start_accuracy",		0);		--acceracy in degrees, 0 is perfect acceracy
	ds_map_add(exp, "start_energy",			10);	--energy requirement
	ds_map_add(exp, "start_damage",			40);	--base damage value
	ds_map_add(exp, "start_penetration",	5);		--base penetration value
	ds_map_add(exp, "start_speed",			0);		--the speed of the projectile
	ds_map_add(exp, "energy_buffed",		0);		--can't	be improved with bonus energy

	--SPRITES
	--small sprite
	local laser_pulse_cannon_small_sprite = sprite_add(current_file_path.."sprites/laser_pulse_cannon_small.png", 0, false, false, 0, 0);
	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_small_sprite", laser_pulse_cannon_small_sprite);
	ds_map_add(exp, "sprite", laser_pulse_cannon_small_sprite);
	--huge sprite
	local laser_pulse_cannon_huge_sprite = sprite_add(current_file_path.."sprites/laser_pulse_cannon_huge.png", 0, false, false, 199, 134);
	--big sprite
	local laser_pulse_cannon_big_sprite = sprite_add(current_file_path.."sprites/laser_pulse_cannon_big.png", 0, false, false, 199, 134);
	--merge the big and huge sprites
	sprite_merge(laser_pulse_cannon_big_sprite, laser_pulse_cannon_huge_sprite);
	ds_map_add(exp, "sprite_big", laser_pulse_cannon_big_sprite);

	--return new data
	q.weapon_stat = weapon_stat_array;
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

	--Our modded item indexes
	local nova_mech_index = variable_global_get(unique_mod_prefix.."nova_mech_index");
	local sentinel_mech_index = variable_global_get(unique_mod_prefix.."sentinel_mech_index");
	local behemoth_mech_index = variable_global_get(unique_mod_prefix.."behemoth_mech_index");
	local echo_mech_index = variable_global_get(unique_mod_prefix.."echo_mech_index");
	local high_tech_solenoid_index = variable_global_get(unique_mod_prefix.."high_tech_solenoid_index");
	local howitzer_weapon_index = variable_global_get(unique_mod_prefix.."howitzer_weapon_index");
	local laser_pulse_cannon_weapon_index = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index");

	--Our Modded sprites
	local nova_sprite = variable_global_get(unique_mod_prefix.."nova_sprite_small");
	local sentinel_sprite = variable_global_get(unique_mod_prefix.."sentinel_sprite_small");
	local behemoth_sprite = variable_global_get(unique_mod_prefix.."behemoth_sprite_small");
	local echo_sprite = variable_global_get(unique_mod_prefix.."echo_sprite_small");
	local high_tech_solenoid_sprite = variable_global_get(unique_mod_prefix.."high_tech_solenoid_sprite_small");
	local howitzer_sprite = variable_global_get(unique_mod_prefix.."howitzer_sprite_small");
	local laser_pulse_cannon_small_sprite = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_small_sprite");
	
	--We step through the hanger/production items to find our modded items
	for _, hangar in ipairs(hanger_mass) do
		--Mechs
		if (hangar[hanger.component_type] == component_types.mech) then
			--When the reference matches the modded element we set the relevant mod sprite to the logo and logo indexes.
			if (hangar[hanger.item_index] == nova_mech_index) then
				hangar[hanger.logo] = nova_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
			elseif (hangar[hanger.item_index] == sentinel_mech_index) then
				hangar[hanger.logo] = sentinel_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
			elseif (hangar[hanger.item_index] == behemoth_mech_index) then
				hangar[hanger.logo] = behemoth_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
			elseif (hangar[hanger.item_index] == echo_mech_index) then
				hangar[hanger.logo] = echo_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
			end
		--Solenoids
		elseif (hangar[hanger.component_type] == component_types.solenoid) then
			if (hangar[hanger.item_index] == high_tech_solenoid_index) then
				hangar[hanger.logo] = high_tech_solenoid_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
			end
		--Weapons
		elseif (hangar[hanger.component_type] == component_types.weapon) then
			if (hangar[hanger.item_index] == howitzer_weapon_index) then
				hangar[hanger.logo] = howitzer_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
			elseif (hangar[hanger.item_index] == laser_pulse_cannon_weapon_index) then
				hangar[hanger.logo] = laser_pulse_cannon_small_sprite;
				hangar[hanger.logo_index] = hangar[hanger.logo];
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

---Adds the Cell data to the ds_map of the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cells mech_cell[] the cell data array for the mech
function AddCells(mech, cells)
	for i = 1, #cells, 1 do
		local cell = cells[i];
		AddCell(mech, i, cell);
	end
	ds_map_add(mech, "number_of_cells", #cells);
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