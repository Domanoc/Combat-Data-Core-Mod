
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath("ModFramework Example Mod");

	--load needed types
	local mechModules = Mod.Types.MechModules;
	local componentSizes = Mod.Types.ComponentSizes;
	local weaponTypes = Mod.Types.WeaponTypes;

	--An example on creating a modded mech
	Mod.Database.AddMech({
		Name = 			   "example_mech",		 --The name of the mech, used to find its references
		ComponentSize =    componentSizes.Large, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	   false,				 --Set to true if its pre researched, else false.
		CanBeConstructed = true,				 --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	   true,				 --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =   1000,				 --The amount of metallite needed to produce this mech
		PriceBjorn = 	   1000,				 --The amount of bjorn needed to produce this mech
		PriceMunilon =     1000,				 --The amount of munilon needed to produce this mech
		PriceSkalaknit =   1000,				 --The amount of skalaknit needed to produce this mech
		PriceStaff = 	   1000,				 --The amount of staff needed to produce this mech
		ProductionDays =   2,					 --The amount of days it takes to produce this mech
		HeatResist = 	   10,					 --The heat resist value of the mech
		ImpactResist =     10,					 --The impact resist value of the mech
		CurrentResist =    10,					 --The current resist value of the mech
		HasMelee = 	   	   true,				 --Indicates if the mech can use a melee weapon, if true the sprites for vertical and horizontal are expected
		PassiveArmor =     0,					 --The amount of passive armor the mech has
		Weight = 		   60,					 --The base weight of the mech
		Speed = 		   0.4,					 --The base speed of the mech
		ReloadTime = 	   3,					 --The base reload time of the mech
		BattleTime = 	   3,					 --The base battle time of the mech (the lenght of time it has ammo reserves for to shoot)
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 22} --cabin, the game is design for mechs to have only 1 cabin. adding more might result in issues	or unexpected behavior
			,{ModuleType = mechModules.Reactor, X =   0, Y = 15} --reactor, the game is design for mechs to have only 1 reactor. adding more might result in issues	or unexpected behavior
			,{ModuleType = mechModules.Motor, 	X =   5, Y =  4} --motor 1, you can add more motors.
			,{ModuleType = mechModules.Motor, 	X =  -5, Y =  4} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   5, Y =  9} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -5, Y =  9} --motor 4
			,{ModuleType = mechModules.Weapon, 	X =  10, Y = 16} --gun 1, you can add a maximum of 12 guns, the game throws errors when a mech has more
			,{ModuleType = mechModules.Weapon, 	X = -10, Y = 16} --gun 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 23} --aux 1, you can add more auxiliary slots.
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 23} --aux 2
		},
		SpriteSmall = 			modFilepath.."sprites\\example_mech_small.png", 			--The sprite used at the production screen
		SpriteBig = 			modFilepath.."sprites\\example_mech_big.png",				--The paintable mech sprite
		SpriteBattle = 		  	modFilepath.."sprites\\example_mech_battle.png",			--The shoot and idle frames during battle
		SpriteBattleDead = 	  	modFilepath.."sprites\\example_mech_dead.png",				--The death sprite when the mech gets destroyed during battle
		SpriteMeleeVertical = 	modFilepath.."sprites\\example_mech_melee_vertical.png",    --The animation atlas for a vertical melee, optional if the mech has no melee
		SpriteMeleeHorizontal = modFilepath.."sprites\\example_mech_melee_horizontal.png"   --The animation atlas for a horizontal melee,  optional if the mech has no melee
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