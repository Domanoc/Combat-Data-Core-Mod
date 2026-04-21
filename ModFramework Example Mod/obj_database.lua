
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--path to the current file
	local currentFilepath = Mod.Common.GetModPath("ModFramework Example Mod");

	--load needed types
	local mechModules = Mod.Types.MechModules;
	local componentSizes = Mod.Types.ComponentSizes;
	local weaponTypes = Mod.Types.WeaponTypes;

	--create an example_mech
	Mod.Database.AddMech({
		Name = 			   "example_mech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		PriceMetallite =   1000,
		PriceBjorn = 	   1000,
		PriceMunilon =     1000,
		PriceSkalaknit =   1000,
		PriceStaff = 	   1000,
		ProductionDays =   2,
		HeatResist = 	   10,
		ImpactResist =     10,
		CurrentResist =    10,
		HasMelee = 	   	   1,
		PassiveArmor =     0,
		Weight = 		   60,
		Speed = 		   0.4,
		ReloadTime = 	   3,
		BattleTime = 	   3,
		MechCells = {
			 {ModuleType = mechModules.Reactor, X =   0, Y = 15} --reactor
			,{ModuleType = mechModules.Cabin, 	X =   0, Y = 22} --cabin
			,{ModuleType = mechModules.Motor, 	X =   5, Y =  4} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -5, Y =  4} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   5, Y =  9} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -5, Y =  9} --motor 4
			,{ModuleType = mechModules.Weapon, 	X =  10, Y = 16} --gun 1
			,{ModuleType = mechModules.Weapon, 	X = -10, Y = 16} --gun 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 23} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 23} --aux 2
		},
		SpriteSmall = 			currentFilepath.."sprites\\example_mech_small.png",
		SpriteBig = 			currentFilepath.."sprites\\example_mech_big.png",
		SpriteBattle = 		  	currentFilepath.."sprites\\example_mech_battle.png",
		SpriteBattleDead = 	  	currentFilepath.."sprites\\example_mech_dead.png",
		SpriteMeleeVertical = 	currentFilepath.."sprites\\example_mech_melee_vertical.png",
		SpriteMeleeHorizontal = currentFilepath.."sprites\\example_mech_melee_horizontal.png"
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