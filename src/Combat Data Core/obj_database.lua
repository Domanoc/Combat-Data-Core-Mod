
---Check if the ModFramework can be found
function CheckForModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
	if isLoaded ~= true then
		local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check an correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
	end
end

---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--Check if the ModFramework can be found
	CheckForModFramework()
	--load the mod framework as a global for use within this file
	Mod = require("ModFramework")

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath()

	--load needed types
	local mechModules = Mod.Types.MechModules
	local componentSizes = Mod.Types.ComponentSizes
	local weaponTypes = Mod.Types.WeaponTypes

	------------------------------------------------------------------------------
	--- MECHS --------------------------------------------------------------------
	------------------------------------------------------------------------------
	Mod.Database.AddMech({
		ReferenceName =	   "CDC_NovaMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   400,
		PriceBjorn = 	   200,
		PriceMunilon =     320,
		PriceSkalaknit =   220,
		PriceStaff = 	   245,
		ProductionDays =   4,
		HeatResist = 	   20,
		ImpactResist =     15,
		CurrentResist =    40,
		HasMelee = 	   	   true,
		PassiveArmor =     2,
		Weight = 		   65,
		Speed = 		   0.4,
		ReloadTime = 	   3,
		BattleTime = 	   3,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 25} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 18} --reactor
			,{ModuleType = mechModules.Motor, 	X =   7, Y =  6} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -7, Y =  6} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 11} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 11} --motor 4
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 16} --motor 5
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 16} --motor 6
			,{ModuleType = mechModules.Weapon, 	X =  14, Y = 20} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -14, Y = 20} --Weapon 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 21} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 21} --aux 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 27} --aux 3
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 27} --aux 4
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 27} --aux 5
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 27} --aux 6
			,{ModuleType = mechModules.Aux, 	X =   0, Y = 33} --aux 7
		},
		SpritePathProduction = 		modFilepath.."sprites\\nova_production.png",
		SpritePathBig = 			modFilepath.."sprites\\nova_big.png",
		SpritePathBattle = 		  	modFilepath.."sprites\\nova_battle.png",
		SpritePathDestroyed = 	  	modFilepath.."sprites\\nova_destroyed.png",
		SpritePathMeleeVertical = 	modFilepath.."sprites\\nova_melee_vertical.png",
		SpritePathMeleeHorizontal = modFilepath.."sprites\\nova_melee_horizontal.png"
	})

	Mod.Database.AddMech({
		ReferenceName =	   "CDC_SentinelMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   1050,
		PriceBjorn = 	   730,
		PriceMunilon =     1030,
		PriceSkalaknit =   880,
		PriceStaff = 	   325,
		ProductionDays =   6,
		HeatResist = 	   25,
		ImpactResist =     90,
		CurrentResist =    80,
		HasMelee = 	   	   true,
		PassiveArmor =     5,
		Weight = 		   70,
		Speed = 		   0.2,
		ReloadTime = 	   4,
		BattleTime = 	   5,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 32} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 24} --reactor
			,{ModuleType = mechModules.Motor, 	X =   8, Y =  6} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -8, Y =  6} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   8, Y = 11} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -8, Y = 11} --motor 4
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 16} --motor 5
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 16} --motor 6
			,{ModuleType = mechModules.Weapon, 	X =  14, Y = 22} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -14, Y = 22} --Weapon 2
			,{ModuleType = mechModules.Weapon, 	X =   7, Y = 41} --Weapon 3
			,{ModuleType = mechModules.Weapon, 	X =  -7, Y = 41} --Weapon 4
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 22} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 22} --aux 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 35} --aux 3
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 35} --aux 4
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 29} --aux 5
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 29} --aux 6
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 33} --aux 7
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 33} --aux 8
		},
		SpritePathProduction = 		modFilepath.."sprites\\sentinel_production.png",
		SpritePathBig = 			modFilepath.."sprites\\sentinel_big.png",
		SpritePathBattle = 		  	modFilepath.."sprites\\sentinel_battle.png",
		SpritePathDestroyed = 	  	modFilepath.."sprites\\sentinel_destroyed.png",
		SpritePathMeleeVertical = 	modFilepath.."sprites\\sentinel_melee_vertical.png",
		SpritePathMeleeHorizontal = modFilepath.."sprites\\sentinel_melee_horizontal.png"
	})

	Mod.Database.AddMech({
		ReferenceName =	   "CDC_BehemothMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   4130,
		PriceBjorn = 	   1460,
		PriceMunilon =     2300,
		PriceSkalaknit =   2020,
		PriceStaff = 	   600,
		ProductionDays =   8,
		HeatResist = 	   45,
		ImpactResist =     95,
		CurrentResist =    95,
		HasMelee = 	   	   true,
		PassiveArmor =     10,
		Weight = 		   108,
		Speed = 		   0.1,
		ReloadTime = 	   3,
		BattleTime = 	   12,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 30} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 22} --reactor
			,{ModuleType = mechModules.Motor, 	X =   7, Y =  5} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -7, Y =  5} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   7, Y =  9} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -7, Y =  9} --motor 4
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 13} --motor 5
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 13} --motor 6
			,{ModuleType = mechModules.Motor, 	X =   7, Y = 17} --motor 7
			,{ModuleType = mechModules.Motor, 	X =  -7, Y = 17} --motor 8
			,{ModuleType = mechModules.Weapon, 	X =  15, Y = 27} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -15, Y = 27} --Weapon 2
			,{ModuleType = mechModules.Weapon, 	X =  24, Y = 27} --Weapon 3
			,{ModuleType = mechModules.Weapon, 	X = -24, Y = 27} --Weapon 4
			,{ModuleType = mechModules.Weapon, 	X =  15, Y = 21} --Weapon 5
			,{ModuleType = mechModules.Weapon, 	X = -15, Y = 21} --Weapon 6
			,{ModuleType = mechModules.Weapon, 	X =  24, Y = 21} --Weapon 7
			,{ModuleType = mechModules.Weapon, 	X = -24, Y = 21} --Weapon 8
			,{ModuleType = mechModules.Weapon, 	X =  15, Y = 15} --Weapon 9
			,{ModuleType = mechModules.Weapon, 	X = -15, Y = 15} --Weapon 10
			,{ModuleType = mechModules.Weapon, 	X =  24, Y = 15} --Weapon 11
			,{ModuleType = mechModules.Weapon, 	X = -24, Y = 15} --Weapon 12
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 36} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 36} --aux 2
			,{ModuleType = mechModules.Aux, 	X =  11, Y = 36} --aux 3
			,{ModuleType = mechModules.Aux, 	X = -11, Y = 36} --aux 4
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 31} --aux 5
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 31} --aux 6
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 26} --aux 7
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 26} --aux 8
		},
		SpritePathProduction = 		modFilepath.."sprites\\behemoth_production.png",
		SpritePathBig = 			modFilepath.."sprites\\behemoth_big.png",
		SpritePathBattle = 		  	modFilepath.."sprites\\behemoth_battle.png",
		SpritePathDestroyed = 	  	modFilepath.."sprites\\behemoth_destroyed.png",
		SpritePathMeleeVertical = 	modFilepath.."sprites\\behemoth_melee.png",
		SpritePathMeleeHorizontal = modFilepath.."sprites\\behemoth_melee.png"
	})

	Mod.Database.AddMech({
		ReferenceName =	   "CDC_EchoMech",
		ComponentSize =    componentSizes.Large,
		IsResearched = 	   false,
		CanBeConstructed = true,
		GiveFreeItem = 	   true,
		PriceMetallite =   620,
		PriceBjorn = 	   275,
		PriceMunilon =     520,
		PriceSkalaknit =   400,
		PriceStaff = 	   265,
		ProductionDays =   5,
		HeatResist = 	   20,
		ImpactResist =     30,
		CurrentResist =    20,
		HasMelee = 	   	   false,
		PassiveArmor =     3,
		Weight = 		   80,
		Speed = 		   0.4,
		ReloadTime = 	   2,
		BattleTime = 	   4,
		MechCells = {
			 {ModuleType = mechModules.Cabin, 	X =   0, Y = 29} --cabin
			,{ModuleType = mechModules.Reactor, X =   0, Y = 22} --reactor
			,{ModuleType = mechModules.Motor, 	X =   9, Y =  7} --motor 1
			,{ModuleType = mechModules.Motor, 	X =  -9, Y =  7} --motor 2
			,{ModuleType = mechModules.Motor, 	X =   6, Y = 12} --motor 3
			,{ModuleType = mechModules.Motor, 	X =  -6, Y = 12} --motor 4
			,{ModuleType = mechModules.Motor, 	X =  13, Y = 15} --motor 5
			,{ModuleType = mechModules.Motor, 	X = -13, Y = 15} --motor 6
			,{ModuleType = mechModules.Motor, 	X =   0, Y = 16} --motor 7
			,{ModuleType = mechModules.Weapon, 	X =  13, Y = 28} --Weapon 1
			,{ModuleType = mechModules.Weapon, 	X = -13, Y = 28} --Weapon 2
			,{ModuleType = mechModules.Weapon, 	X =   7, Y = 35} --Weapon 3
			,{ModuleType = mechModules.Aux, 	X =   7, Y = 19} --aux 1
			,{ModuleType = mechModules.Aux, 	X =  -7, Y = 19} --aux 2
			,{ModuleType = mechModules.Aux, 	X =   6, Y = 24} --aux 3
			,{ModuleType = mechModules.Aux, 	X =  -6, Y = 24} --aux 4
			,{ModuleType = mechModules.Aux, 	X =   5, Y = 29} --aux 5
			,{ModuleType = mechModules.Aux, 	X =  -5, Y = 29} --aux 6
		},
		SpritePathProduction = 		modFilepath.."sprites\\echo_production.png",
		SpritePathBig = 			modFilepath.."sprites\\echo_big.png",
		SpritePathBattle = 		  	modFilepath.."sprites\\echo_battle.png",
		SpritePathDestroyed = 	  	modFilepath.."sprites\\echo_destroyed.png"
	})

	------------------------------------------------------------------------------
	--- SOLENOIDS ----------------------------------------------------------------
	------------------------------------------------------------------------------

	Mod.Database.AddSolenoid({
		ReferenceName = 	"CDC_HighTechSolenoid",
		ComponentSize =     componentSizes.Small,
		IsResearched = 	    false,
		CanBeConstructed =  true,
		GiveFreeItem = 	    true,
		PriceMetallite =    150,
		PriceBjorn = 	    150,
		PriceMunilon =      200,
		PriceSkalaknit =    25,
		PriceStaff = 	    70,
		ProductionDays =    4,
		Power = 		    3,
		Induction = 	    1,
		SpritePath = 		modFilepath.."sprites\\high_tech_solenoid.png"
	})

	------------------------------------------------------------------------------
	--- WEAPONS ------------------------------------------------------------------
	------------------------------------------------------------------------------

	Mod.Database.AddWeapon({
		ReferenceName =		"CDC_Howitzer",
		Description = {
			LocalizedDefaultValue = "240-MM HOWITZER GUN"
		},
		ComponentSize =     componentSizes.Small,
		IsResearched = 	    false,
		CanBeConstructed =  true,
		GiveFreeItem = 	    true,
		PriceMetallite =    200,
		PriceBjorn = 	    50,
		PriceMunilon =      30,
		PriceSkalaknit =    60,
		PriceStaff = 	    45,
		ProductionDays =    4,
		WeaponType =	    weaponTypes.Kinetic,
		FireRate =		    25,
		Weight = 		    48,
		Accuracy = 		    1.5,
		EnergyCost = 		5,
		Damage = 		    80,
		Penetration = 	    15,
		ProjectileSpeed =   18,
		IsEnergyBuffed =    false,
		BlueLength =        0,
		SpritePathProduction =	modFilepath.."sprites\\howitzer_production.png",
		SpritePathBig = 		modFilepath.."sprites\\howitzer_big.png",
	})

	Mod.Database.AddWeapon({
		ReferenceName =		"CDC_LaserPulseCannon",
		Description = {
			LocalizedDefaultValue = "EXTENDED RANGE LASER PULSE CANNON#Uses an internal power unit to provide most of the energy. Can be boosted by providing additional power."
		},
		ComponentSize =     componentSizes.Small,
		IsResearched = 	    false,
		CanBeConstructed =  true,
		GiveFreeItem = 	    true,
		PriceMetallite =    250,
		PriceBjorn = 	    245,
		PriceMunilon =      500,
		PriceSkalaknit =    130,
		PriceStaff = 	    110,
		ProductionDays =    8,
		WeaponType =	    weaponTypes.Energy,
		FireRate =		    600,
		Weight = 		    80,
		Accuracy = 		    0,
		EnergyCost = 		10,
		Damage = 		    40,
		Penetration = 	    5,
		ProjectileSpeed =   0,
		IsEnergyBuffed =    false,
		BlueLength =        2000,
		SpritePathProduction =	modFilepath.."sprites\\laser_pulse_cannon_production.png",
		SpritePathBig =			modFilepath.."sprites\\laser_pulse_cannon_big.png",
	})
end

---saving system deletes the file and creates new one before saving new info
---@param q any
function save_game_pre_event(q)
end

---@param q game_obj_database
function save_game_post_event(q)
end

---@param q game_obj_database
function load_game_pre_event(q)
end

---Called after the game is loaded
---@param q game_obj_database
function load_game_post_event(q)
end

---The draw call that runs every frame
---@param q game_obj_database
function draw_top_menu(q)
end

---The draw call that runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end