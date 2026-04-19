
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("obj_database.lua",""):gsub("/","\\");

	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--load needed types
	local mechModules = Mod.Types.MechModules;
	local componentSizes = Mod.Types.ComponentSizes;
	local weaponTypes = Mod.Types.WeaponTypes;

	--create an example_mech
	Mod.Database.AddMech({
		name = 			   "example_mech",
		component_size =   componentSizes.large,
		researched = 	   false,
		CanBeConstructed = true,
		price_metallite =  1000,
		price_bjorn = 	   1000,
		price_munilon =    1000,
		price_skalaknit =  1000,
		price_staff = 	   1000,
		production_days =  2,
		heat_resist = 	   10,
		impact_resist =    10,
		current_resist =   10,
		has_melee = 	   1,
		passive_armor =    0,
		weight = 		   60,
		speed = 		   0.4,
		reload_time = 	   3,
		battle_time = 	   3,
		mech_cells = {
			{moduleType = mechModules.motor, 	x =   5, y =  4} --motor 1
			,{moduleType = mechModules.motor, 	x =  -5, y =  4} --motor 2
			,{moduleType = mechModules.motor, 	x =   5, y =  9} --motor 3
			,{moduleType = mechModules.motor, 	x =  -5, y =  9} --motor 4
			,{moduleType = mechModules.reactor, x =   0, y = 15} --reactor
			,{moduleType = mechModules.gun, 	x =  10, y = 16} --gun 1
			,{moduleType = mechModules.gun, 	x = -10, y = 16} --gun 2
			,{moduleType = mechModules.cabin, 	x =   0, y = 22} --cabin
			,{moduleType = mechModules.aux, 	x =   6, y = 23} --aux 1
			,{moduleType = mechModules.aux, 	x =  -6, y = 23} --aux 2
		},
		sprite_small = 			  current_file_path.."sprites/example_mech_small.png",
		sprite_big = 			  current_file_path.."sprites/example_mech_big.png",
		sprite_battle = 		  current_file_path.."sprites/example_mech_battle.png",
		sprite_battle_dead = 	  current_file_path.."sprites/example_mech_dead.png",
		sprite_battle_melee_ver = current_file_path.."sprites/example_mech_melee_vertical.png",
		sprite_battle_melee_hor = current_file_path.."sprites/example_mech_melee_horizontal.png"
	});

--	----------------------
--	--HIGH TECH SOLONOID--
--	----------------------
--	Mod.Database.AddSolenoid({
--		name = 			   "high_tech_solenoid",
--		component_size =   componentSizes.small,
--		researched =       false,
--		CanBeConstructed = true,
--		price_metallite =  150,
--		price_bjorn = 	   150,
--		price_munilon =    200,
--		price_skalaknit =  25,
--		price_staff = 	   70,
--		production_days =  4,
--		power = 		   3,
--		induction = 	   1,
--		sprite = 		   current_file_path.."sprites/high_tech_solenoid.png"
--	});
--
--	------------
--	--HOWITZER--
--	------------
--	Mod.Database.AddWeapon({
--		name =			    "howitzer_weapon",
--		WeaponDescription = "240-MM HOWITZER GUN.",
--		component_size =    componentSizes.small,
--		researched =        false,
--		CanBeConstructed =  true,
--		price_metallite =   200,
--		price_bjorn = 	    50,
--		price_munilon =     30,
--		price_skalaknit =   60,
--		price_staff = 	    45,
--		production_days =   4,
--		weapon_type = 	    weaponTypes.white,
--		fire_rate = 	    25,
--		weight = 		    48,
--		accuracy = 		    1.5,
--		energy = 		    5,
--		damage = 		    80,
--		penetration = 	    15,
--		projectile_speed =  18,
--		energy_buffed =     0,
--		BlueLength =        0,
--		sprite_small =      current_file_path.."sprites/howitzer_small.png",
--		sprite_big = 	    current_file_path.."sprites/howitzer_big.png",
--		sprite_huge = 	    current_file_path.."sprites/howitzer_huge.png"
--	});
--	----------------------
--	--LASER PULSE CANNON--
--	----------------------
--	Mod.Database.AddWeapon({
--		name =			    "laser_pulse_cannon_weapon",
--		WeaponDescription = "EXTENDED RANGE LASER PULSE CANNON.#Uses an internal power unit to provide most of the energy. Can be boosted by providing additional power.",
--		component_size =    componentSizes.small,
--		researched =        false,
--		CanBeConstructed =  true,
--		price_metallite =   250,
--		price_bjorn = 	    245,
--		price_munilon =     500,
--		price_skalaknit =   130,
--		price_staff = 	    110,
--		production_days =   8,
--		weapon_type = 	    weaponTypes.blue,
--		fire_rate = 	    600,
--		weight = 		    80,
--		accuracy = 		    0,
--		energy = 		    10,
--		damage = 		    40,
--		penetration = 	    5,
--		projectile_speed =  0,
--		energy_buffed =     0,
--		BlueLength = 	    2000,
--		sprite_small =      current_file_path.."sprites/laser_pulse_cannon_small.png",
--		sprite_big = 	    current_file_path.."sprites/laser_pulse_cannon_big.png",
--		sprite_huge = 	    current_file_path.."sprites/laser_pulse_cannon_huge.png"
--	});
end

---saving system deletes the file and creates new one before saving new info
---@param q any
function save_game_pre_event(q)
end

function save_game_post_event(q)
end

function load_game_pre_event(q)
end

function load_game_post_event(q)
end

function draw_top_menu(q)
end

function draw_debug(q)
end