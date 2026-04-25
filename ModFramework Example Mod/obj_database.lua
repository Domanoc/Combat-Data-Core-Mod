
---One time script when the game is started
---@param q game_obj_database
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath("ModFramework Example Mod")

	--load needed types

	local mechModules = Mod.Types.MechModules
	local componentSizes = Mod.Types.ComponentSizes
	local weaponTypes = Mod.Types.WeaponTypes

	--An example for creating a modded mech
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
		PriceStaff = 	   10,					 --The amount of staff needed to produce this mech
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
	})

	--An example for creating a modded weapon
	Mod.Database.AddWeapon({
		Name = 			    "example_weapon",	  --The name of the mech, used to find its references
		--We can provide full language support like this, atleast 1 language is needed
		--LanguageFile variable should match the language file ini that the string targets
		--Value should contain the string in the correct language for that language file
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "Description text for this weapon." }
			,{ LanguageFile = "loc_french.ini", Value = "Texte descriptif de cette arme." }
			,{ LanguageFile = "loc_german.ini", Value = "Beschreibungstext für diese Waffe." }
			,{ LanguageFile = "loc_polish.ini", Value = "Tekst opisujący tę broń." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Texto descritivo para esta arma." }
			,{ LanguageFile = "loc_russian.ini", Value = "Описание данного оружия." }
			,{ LanguageFile = "loc_spanish.ini", Value = "Texto descriptivo de esta arma." }
			,{ LanguageFile = "loc_chinese.ini", Value = "该武器的描述文字。" }
			,{ LanguageFile = "loc_italian.ini", Value = "Testo descrittivo per quest'arma." }
			,{ LanguageFile = "japanese.ini", Value = "この武器の説明文。" }
		},
		ComponentSize =     componentSizes.Small, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	    false,				  --Set to true if its pre researched, else false.
		CanBeConstructed =  true,				  --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	    true,				  --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =    1000,				  --The amount of metallite needed to produce this weapon
		PriceBjorn = 	    1000,				  --The amount of bjorn needed to produce this weapon
		PriceMunilon =      1000,				  --The amount of munilon needed to produce this weapon
		PriceSkalaknit =    1000,				  --The amount of skalaknit needed to produce this weapon
		PriceStaff = 	    10,					  --The amount of staff needed to produce this weapon
		ProductionDays =    2,					  --The amount of days it takes to produce this weapon
		WeaponType =	    weaponTypes.Kinetic,  --the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)
		FireRate =		    25,					  --the base fire rate. higher values offer a faster rate, 600 with full firespeed points will fill the firespeed bar completely
		Weight = 		    48,					  --the base weight of the weapon
		Accuracy = 		    1.5,				  --the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
		EnergyCost = 		5,					  --the base energy cost of the weapon
		Damage = 		    80,					  --the base damage value of the weapon
		Penetration = 	    15,					  --the base penetration value of the weapon
		ProjectileSpeed =   18,					  --the base projectile speed of the weapon
		IsEnergyBuffed =    false,				  --whether the energy cost boost damage output, for energy weapons this is an additional increase on their native bonus.
		BlueLength =        0,					  --the range of a blue weapon, default is 750
		SpriteSmall =       modFilepath.."sprites/example_weapon_small.png",	--the small sprite for the weapon
		SpriteBig = 	    modFilepath.."sprites/example_weapon_big.png",		--the big sprite for the weapon
		SpriteHuge = 	    modFilepath.."sprites/example_weapon_huge.png",		--the huge sprite for the weapon
	})

	for i = 1, 9, 1 do
		Mod.Database.AddWeapon({
		Name = 			    "example_white_weapon"..i,  --The name of the mech, used to find its references
		--We can provide full language support like this, atleast 1 language is needed
		--LanguageFile variable should match the language file ini that the string targets
		--Value should contain the string in the correct language for that language file
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "Description text for this weapon." }
			,{ LanguageFile = "loc_french.ini", Value = "Texte descriptif de cette arme." }
			,{ LanguageFile = "loc_german.ini", Value = "Beschreibungstext für diese Waffe." }
			,{ LanguageFile = "loc_polish.ini", Value = "Tekst opisujący tę broń." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Texto descritivo para esta arma." }
			,{ LanguageFile = "loc_russian.ini", Value = "Описание данного оружия." }
			,{ LanguageFile = "loc_spanish.ini", Value = "Texto descriptivo de esta arma." }
			,{ LanguageFile = "loc_chinese.ini", Value = "该武器的描述文字。" }
			,{ LanguageFile = "loc_italian.ini", Value = "Testo descrittivo per quest'arma." }
			,{ LanguageFile = "japanese.ini", Value = "この武器の説明文。" }
		},
		ComponentSize =     componentSizes.Small, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	    true,				  --Set to true if its pre researched, else false.
		CanBeConstructed =  true,				  --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	    true,				  --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =    1000,				  --The amount of metallite needed to produce this weapon
		PriceBjorn = 	    1000,				  --The amount of bjorn needed to produce this weapon
		PriceMunilon =      1000,				  --The amount of munilon needed to produce this weapon
		PriceSkalaknit =    1000,				  --The amount of skalaknit needed to produce this weapon
		PriceStaff = 	    10,					  --The amount of staff needed to produce this weapon
		ProductionDays =    2,					  --The amount of days it takes to produce this weapon
		WeaponType =	    weaponTypes.Kinetic,  --the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)
		FireRate =		    25,					  --the base fire rate. higher values offer a faster rate, 600 with full firespeed points will fill the firespeed bar completely
		Weight = 		    48,					  --the base weight of the weapon
		Accuracy = 		    1.5,				  --the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
		EnergyCost = 		5,					  --the base energy cost of the weapon
		Damage = 		    80,					  --the base damage value of the weapon
		Penetration = 	    15,					  --the base penetration value of the weapon
		ProjectileSpeed =   18,					  --the base projectile speed of the weapon
		IsEnergyBuffed =    false,				  --whether the energy cost boost damage output, for energy weapons this is an additional increase on their native bonus.
		BlueLength =        0,					  --the range of a blue weapon, default is 750
		SpriteSmall =       modFilepath.."sprites/example_weapon_small.png",	--the small sprite for the weapon
		SpriteBig = 	    modFilepath.."sprites/example_weapon_big.png",		--the big sprite for the weapon
		SpriteHuge = 	    modFilepath.."sprites/example_weapon_huge.png",		--the huge sprite for the weapon
	})
	end
	for i = 1, 10, 1 do
		Mod.Database.AddWeapon({
		Name = 			    "example_blue_weapon"..i,  --The name of the mech, used to find its references
		--We can provide full language support like this, atleast 1 language is needed
		--LanguageFile variable should match the language file ini that the string targets
		--Value should contain the string in the correct language for that language file
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "Description text for this weapon." }
			,{ LanguageFile = "loc_french.ini", Value = "Texte descriptif de cette arme." }
			,{ LanguageFile = "loc_german.ini", Value = "Beschreibungstext für diese Waffe." }
			,{ LanguageFile = "loc_polish.ini", Value = "Tekst opisujący tę broń." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Texto descritivo para esta arma." }
			,{ LanguageFile = "loc_russian.ini", Value = "Описание данного оружия." }
			,{ LanguageFile = "loc_spanish.ini", Value = "Texto descriptivo de esta arma." }
			,{ LanguageFile = "loc_chinese.ini", Value = "该武器的描述文字。" }
			,{ LanguageFile = "loc_italian.ini", Value = "Testo descrittivo per quest'arma." }
			,{ LanguageFile = "japanese.ini", Value = "この武器の説明文。" }
		},
		ComponentSize =     componentSizes.Small, --The size of the component when constructing it. 1 for single slot or 5 for a full row
		IsResearched = 	    true,				  --Set to true if its pre researched, else false.
		CanBeConstructed =  true,				  --Set to true if it can be constructed in the component shop, false otherwise
		GiveFreeItem = 	    true,				  --Set to true to return a free copy when triggered as an unlock
		PriceMetallite =    1000,				  --The amount of metallite needed to produce this weapon
		PriceBjorn = 	    1000,				  --The amount of bjorn needed to produce this weapon
		PriceMunilon =      1000,				  --The amount of munilon needed to produce this weapon
		PriceSkalaknit =    1000,				  --The amount of skalaknit needed to produce this weapon
		PriceStaff = 	    10,					  --The amount of staff needed to produce this weapon
		ProductionDays =    2,					  --The amount of days it takes to produce this weapon
		WeaponType =	    weaponTypes.Energy,	  --the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)
		FireRate =		    25,					  --the base fire rate. higher values offer a faster rate, 600 with full firespeed points will fill the firespeed bar completely
		Weight = 		    48,					  --the base weight of the weapon
		Accuracy = 		    1.5,				  --the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
		EnergyCost = 		5,					  --the base energy cost of the weapon
		Damage = 		    80,					  --the base damage value of the weapon
		Penetration = 	    15,					  --the base penetration value of the weapon
		ProjectileSpeed =   18,					  --the base projectile speed of the weapon
		IsEnergyBuffed =    false,				  --whether the energy cost boost damage output, for energy weapons this is an additional increase on their native bonus.
		BlueLength =        0,					  --the range of a blue weapon, default is 750
		SpriteSmall =       modFilepath.."sprites/example_weapon_small.png",	--the small sprite for the weapon
		SpriteBig = 	    modFilepath.."sprites/example_weapon_big.png",		--the big sprite for the weapon
		SpriteHuge = 	    modFilepath.."sprites/example_weapon_huge.png",		--the huge sprite for the weapon
	})
	end
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

---The draw call thay runs every frame
---@param q game_obj_database
function draw_top_menu(q)
	--Here are some funtions to help with testing
	--Its recommended to remove these before releasing your mod
	local keys = Mod.Types.VirtualKeys
	if keyboard_check_pressed(keys.F9) then
		Mod.Common.ShowMessage("Unlocking all Research.")
		Mod.Research.UnlockAllResearch()
    end
	if keyboard_check_pressed(keys.F10) then
		Mod.Common.ShowMessage("Unlocking all components.")
		Mod.Production.UnlockAllShopComponents()
    end
end

---The draw call thay runs every frame while debug is active (F6)
---@param q game_obj_database
function draw_debug(q)
end