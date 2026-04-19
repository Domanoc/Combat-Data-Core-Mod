
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("obj_database.lua",""):gsub("/","\\");
	--Add current mod path to the package.path
	--This ensures we can load the mod framework in every file
	local mod_framework = current_file_path .. "ModFramework\\?.lua";
	package.path = package.path .. ";" .. mod_framework;
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	-----------------
	--MECHS----------
	-----------------	
	local mechModules = Mod.Types.MechModules;
	local componentSizes = Mod.Types.ComponentSizes;
	local weaponTypes = Mod.Types.WeaponTypes;

	-----------------
	--NOVA MECH------
	-----------------
	Mod.Database.AddMechToObjDB({
		name = 			   "nova_mech",
		component_size =   componentSizes.large,
		researched = 	   false,
		CanBeConstructed = true,
		price_metallite =  400,
		price_bjorn = 	   200,
		price_munilon =    320,
		price_skalaknit =  220,
		price_staff = 	   245,
		production_days =  4,
		heat_resist = 	   20,
		impact_resist =    15,
		current_resist =   40,
		has_melee = 	   1,
		passive_armor =    2,
		weight = 		   65,
		speed = 		   0.4,
		reload_time = 	   3,
		battle_time = 	   3,
		mech_cells = {
			{moduleType = mechModules.motor, 	x =   7, y =  6} --motor 1
			,{moduleType = mechModules.motor, 	x =  -7, y =  6} --motor 2
			,{moduleType = mechModules.motor, 	x =   7, y = 11} --motor 3
			,{moduleType = mechModules.motor, 	x =  -7, y = 11} --motor 4
			,{moduleType = mechModules.motor, 	x =   7, y = 16} --motor 5
			,{moduleType = mechModules.motor, 	x =  -7, y = 16} --motor 6
			,{moduleType = mechModules.reactor, x =   0, y = 18} --reactor
			,{moduleType = mechModules.reactor, x =  10, y = 35} --reactor
			,{moduleType = mechModules.reactor, x = -10, y = 35} --reactor
			,{moduleType = mechModules.gun, 	x =  14, y = 20} --gun 1
			,{moduleType = mechModules.gun, 	x = -14, y = 20} --gun 2
			,{moduleType = mechModules.cabin, 	x =   0, y = 25} --cabin
			,{moduleType = mechModules.aux, 	x =   6, y = 21} --aux 1
			,{moduleType = mechModules.aux, 	x =  -6, y = 21} --aux 2
			,{moduleType = mechModules.aux, 	x =   6, y = 27} --aux 3
			,{moduleType = mechModules.aux, 	x =  -6, y = 27} --aux 4
			,{moduleType = mechModules.aux, 	x =  11, y = 27} --aux 5
			,{moduleType = mechModules.aux, 	x = -11, y = 27} --aux 6
			,{moduleType = mechModules.aux, 	x =   0, y = 33} --aux 7
		},
		sprite_small = 			  current_file_path.."sprites/nova_small.png",
		sprite_big = 			  current_file_path.."sprites/nova_big.png",
		sprite_battle = 		  current_file_path.."sprites/nova_battle.png",
		sprite_battle_dead = 	  current_file_path.."sprites/nova_dead.png",
		sprite_battle_melee_ver = current_file_path.."sprites/nova_melee_vertical.png",
		sprite_battle_melee_hor = current_file_path.."sprites/nova_melee_horizontal.png"
	});

	----------------------
	--HIGH TECH SOLONOID--
	----------------------
	Mod.Database.AddSolenoidToObjDB({
		name = 			   "high_tech_solenoid",
		component_size =   componentSizes.small,
		researched =       false,
		CanBeConstructed = true,
		price_metallite =  150,
		price_bjorn = 	   150,
		price_munilon =    200,
		price_skalaknit =  25,
		price_staff = 	   70,
		production_days =  4,
		power = 		   3,
		induction = 	   1,
		sprite = 		   current_file_path.."sprites/high_tech_solenoid.png"
	});

	------------
	--HOWITZER--
	------------
	Mod.Database.AddWeaponToObjDB({
		name =			   "howitzer_weapon",
		component_size =   componentSizes.small,
		researched =       false,
		CanBeConstructed = true,
		price_metallite =  200,
		price_bjorn = 	   50,
		price_munilon =    30,
		price_skalaknit =  60,
		price_staff = 	   45,
		production_days =  4,
		weapon_type = 	   weaponTypes.white,
		fire_rate = 	   25,
		weight = 		   48,
		accuracy = 		   1.5,
		energy = 		   5,
		damage = 		   80,
		penetration = 	   15,
		projectile_speed = 18,
		energy_buffed =    0,
		BlueLength =      0,
		sprite_small =     current_file_path.."sprites/howitzer_small.png",
		sprite_big = 	   current_file_path.."sprites/howitzer_big.png",
		sprite_huge = 	   current_file_path.."sprites/howitzer_huge.png"
	});
	----------------------
	--LASER PULSE CANNON--
	----------------------
	Mod.Database.AddWeaponToObjDB({
		name =			   "laser_pulse_cannon_weapon",
		component_size =   componentSizes.small,
		researched =       false,
		CanBeConstructed = true,
		price_metallite =  250,
		price_bjorn = 	   245,
		price_munilon =    500,
		price_skalaknit =  130,
		price_staff = 	   110,
		production_days =  8,
		weapon_type = 	   weaponTypes.blue,
		fire_rate = 	   600,
		weight = 		   80,
		accuracy = 		   0,
		energy = 		   10,
		damage = 		   40,
		penetration = 	   5,
		projectile_speed = 0,
		energy_buffed =    0,
		BlueLength = 	   2000,
		sprite_small =     current_file_path.."sprites/laser_pulse_cannon_small.png",
		sprite_big = 	   current_file_path.."sprites/laser_pulse_cannon_big.png",
		sprite_huge = 	   current_file_path.."sprites/laser_pulse_cannon_huge.png"
	});
end

function save_game_pre_event(q)
	--saving system deletes the file and creates new one before saving new info
end

function save_game_post_event(q)
end

function load_game_pre_event(q)
end

function load_game_post_event(q)
	Mod.Database.LoadModdedSpritesOnProductionItems();
end

function draw_top_menu(q)
	Mod.Research.FixModdedResearch();
	Mod.Research.UnlockAllResearch();
end

function draw_debug(q)
end