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
---@param mechData MechData dataset for adding a new mech
function Database.AddMech(mechData)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local mech_stat_array = {};
	mech_stat_array = obj_database.mech_stat;

	local mech_index = #mech_stat_array + 1;
	local mech = ds_map_create();
	mech_stat_array[mech_index] = mech;

	--ENGINEERING PRICE
	ds_map_add(mech, "price_metallite",	mechData.PriceMetallite);
	ds_map_add(mech, "price_bjorn",		mechData.PriceBjorn);
	ds_map_add(mech, "price_munilon",	mechData.PriceMunilon);
	ds_map_add(mech, "price_skalaknit",	mechData.PriceSkalaknit);
	ds_map_add(mech, "price_staff",		mechData.PriceStaff);
	ds_map_add(mech, "days",			mechData.ProductionDays);

	--RESISTANCES
	ds_map_add(mech, "heat_resist",		mechData.HeatResist);
	ds_map_add(mech, "impact_resist",	mechData.ImpactResist);
	ds_map_add(mech, "current_resist",	mechData.CurrentResist);

	--STATS
	ds_map_add(mech, "hp", 				1000);  --1000 is the default for all mechs, not sure if the game does something with this value
	ds_map_add(mech, "armor",			mechData.PassiveArmor);
	ds_map_add(mech, "weight",			mechData.Weight);
	ds_map_add(mech, "speed",			mechData.Speed);
	ds_map_add(mech, "reload_time",		mechData.ReloadTime);
	ds_map_add(mech, "battle_time",		mechData.BattleTime);

	--MODULE CELLS
	Private.AddCells(mech, mechData.MechCells);

	--SPRITES
	--small sprite
	local mech_sprite = Common.AddSprite(mechData.SpriteSmall, 0, false, false, 23, 49);
	ds_map_add(mech, "sprite_small", mech_sprite);
	--big sprite
	ds_map_add(mech, "sprite_big", Common.AddSprite(mechData.SpriteBig, 0, false, false, 200, 343));
	--battle sprite
	ds_map_add(mech, "sprite_battle", Common.AddSprite(mechData.SpriteBattle, 2, true, false, 25, 25));
	--dead sprite
	ds_map_add(mech, "sprite_battle_dead", Common.AddSprite(mechData.SpriteBattleDead, 1, true, false, 25, 25));

	--Melee
	if (mechData.HasMelee) then
		if(mechData.SpriteMeleeVertical == nil) then
			local message = "Trying add a melee function to the mech. But the vertical melee sprite is missing.\n";
			message = message.."Please check the spritepath for 'SpriteMeleeVertical'.\n";
			message = message.."Debug info:\nMech name: "..mechData.Name;
			Common.ShowError(message);
		end
		if(mechData.SpriteMeleeHorizontal == nil) then
			local message = "Trying add a melee function to the mech. But the horizontal melee sprite is missing.\n";
			message = message.."Please check the spritepath for 'SpriteMeleeHorizontal'.\n";
			message = message.."Debug info:\nMech name: "..mechData.Name;
			Common.ShowError(message);
		end

		ds_map_add(mech, "melee_option", mechData.HasMelee);
		--melee vertical sprite
		ds_map_add(mech, "sprite_battle_melee_ver", Common.AddSprite(mechData.SpriteMeleeVertical, 7, true, false, 25, 25));
		--melee horizontal sprite
		ds_map_add(mech, "sprite_battle_melee_hor", Common.AddSprite(mechData.SpriteMeleeHorizontal, 7, true, false, 25, 25));
	end

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type ModdedComponent
	local moddedComponent = {
		ComponentType = Types.ComponentTypes.Mech,
		Index = mech_index - 1,
		Sprite = mech_sprite,
		Name = mechData.Name,
		ComponentSize = mechData.ComponentSize,
		IsResearched = mechData.IsResearched,
		CanBeConstructed = mechData.CanBeConstructed,
		GiveFreeItem = mechData.GiveFreeItem,
		BlueLength = 0,
		WeaponDescription = ""
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.mech_stat = mech_stat_array;
end

---Adds the Cell data to the ds_map of the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cells MechCell[] the cell data array for the mech
function Private.AddCells(mech, cells)
	local auxCount = 0;
	local weaponCount = 0;

	for i = 1, #cells, 1 do
		local cell = cells[i];
		Private.AddCell(mech, i, cell);

		if(cell.ModuleType == Types.MechModules.Aux) then
			auxCount = auxCount + 1;
		end
		if(cell.ModuleType == Types.MechModules.Weapon) then
			weaponCount = weaponCount + 1;
		end
	end

	if (weaponCount > 12) then
		local message = "Trying add more than 12 weapons to a mech.\n";
		message = message.."Adding more than 12 weapons will result in the game crashing when the mech enters combat.\n";
		message = message.."Debug info:\nWeapon count: "..weaponCount;
		Common.ShowError(message);
	end

	ds_map_add(mech, "number_of_aux",	  auxCount);
	ds_map_add(mech, "number_of_weapons", weaponCount);
	ds_map_add(mech, "number_of_cells",   #cells);
end

---Adds a new cell to the ds_map for the mech
---@param mech ds_map the reference to the ds_map of the mech
---@param cell_num number the number of the newly added cell
---@param cell MechCell the data for the cell
function Private.AddCell(mech, cell_num, cell)
	ds_map_add(mech, "cell_"..cell_num, 	cell.ModuleType);
	ds_map_add(mech, "cell_x_"..cell_num, 	cell.X);
	ds_map_add(mech, "cell_y_"..cell_num, 	cell.Y);
end

---Add a new weapon to the games obj_database
---@param weaponData WeaponData
function Database.AddWeapon(weaponData)
	local obj_database = Common.GetObjDatabase();

	--Copy the array to the working set
	local weapon_stat = {};
	weapon_stat = obj_database.weapon_stat;

	local weaponIndex = #weapon_stat + 1;
	weapon_stat[weaponIndex] = ds_map_create();
	local weapon = weapon_stat[weaponIndex];

	--ENGINEERING PRICE
	ds_map_add(weapon, "price_metallite",	weaponData.PriceMetallite);
	ds_map_add(weapon, "price_bjorn",		weaponData.PriceBjorn);
	ds_map_add(weapon, "price_munilon",		weaponData.PriceMunilon);
	ds_map_add(weapon, "price_skalaknit",	weaponData.PriceSkalaknit);
	ds_map_add(weapon, "price_staff",		weaponData.PriceStaff);
	ds_map_add(weapon, "days",				weaponData.ProductionDays);

	--STATS
	ds_map_add(weapon, "hp",				1000);	--a default value the game doesn't seem to use.
	ds_map_add(weapon, "number",			3);		--doesn't seem to do anything
	ds_map_add(weapon, "type",				weaponData.WeaponType);
	ds_map_add(weapon, "start_fire_speed",	weaponData.FireRate);
	ds_map_add(weapon, "start_weight",		weaponData.Weight);
	ds_map_add(weapon, "start_accuracy",	weaponData.Accuracy);
	ds_map_add(weapon, "start_energy",		weaponData.EnergyCost);
	ds_map_add(weapon, "start_damage",		weaponData.Damage);
	ds_map_add(weapon, "start_penetration",	weaponData.Penetration);
	ds_map_add(weapon, "start_speed",		weaponData.ProjectileSpeed);
	ds_map_add(weapon, "energy_buffed",		weaponData.IsEnergyBuffed);

	--SPRITES
	--small sprite
	local smallSprite = Common.AddSprite(weaponData.SpriteSmall, 0, false, false, 0, 0);
	ds_map_add(weapon, "sprite", smallSprite);
	--huge sprite
	local hugeSprite = Common.AddSprite(weaponData.SpriteHuge, 0, false, false, 199, 134);
	--big sprite
	local bigSprite = Common.AddSprite(weaponData.SpriteBig, 0, false, false, 199, 134);
	--merge the big and huge sprites
	Common.MergeSprite(bigSprite, hugeSprite);
	ds_map_add(weapon, "sprite_big", bigSprite);

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type ModdedComponent
	local moddedComponent = {
		ComponentType = Types.ComponentTypes.Weapon,
		Index = weaponIndex - 1,
		Sprite = smallSprite,
		Name = weaponData.Name,
		ComponentSize = weaponData.ComponentSize,
		IsResearched = weaponData.IsResearched,
		CanBeConstructed = weaponData.CanBeConstructed,
		GiveFreeItem = weaponData.GiveFreeItem,
		BlueLength = weaponData.BlueLength,
		WeaponDescription = Common.SelectCorrectLocalizedString(weaponData.Description)
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.weapon_stat = weapon_stat;
end

---Add a new solenoid to the games obj_database
---@param solenoidData SolenoidData
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
	ds_map_add(high_tech_solenoid, "price_metallite",	solenoidData.PriceMetallite);
	ds_map_add(high_tech_solenoid, "price_bjorn",		solenoidData.PriceBjorn);
	ds_map_add(high_tech_solenoid, "price_munilon",		solenoidData.PriceMunilon);
	ds_map_add(high_tech_solenoid, "price_skalaknit",	solenoidData.PriceSkalaknit);
	ds_map_add(high_tech_solenoid, "price_staff",		solenoidData.PriceStaff);
	ds_map_add(high_tech_solenoid, "days",				solenoidData.ProductionDays);

	--STATS
	ds_map_add(high_tech_solenoid, "hp",				1000);	--doesn't seem to do anything
	ds_map_add(high_tech_solenoid, "power",				solenoidData.Power);
	ds_map_add(high_tech_solenoid, "induction",			solenoidData.Induction);
	ds_map_add(high_tech_solenoid, "weight",			2);		--cant find an effect on the reactor so i left it at the same value as a regular solenoid
	ds_map_add(high_tech_solenoid, "type",				1);		--As far as i can see there is only type 1 for solenoids

	--SPRITE
	local high_tech_solenoid_sprite = Common.AddSprite(solenoidData.Sprite, 0, false, false, 0, 0);
	ds_map_add(high_tech_solenoid, "sprite", high_tech_solenoid_sprite);

	--Add the newly modded item to the component list. So we can find the reference later.
	---@type ModdedComponent
	local moddedComponent = {
		ComponentType = Types.ComponentTypes.Solenoid,
		Index = high_tech_solenoid_index - 1,
		Sprite = high_tech_solenoid_sprite,
		Name = solenoidData.Name,
		ComponentSize = solenoidData.ComponentSize,
		IsResearched = solenoidData.IsResearched,
		CanBeConstructed = solenoidData.CanBeConstructed,
		GiveFreeItem = solenoidData.GiveFreeItem,
		BlueLength = 0,
		WeaponDescription = ""
	}
	table.insert(Storage.ModdedComponentList, moddedComponent);

	--return new data
	obj_database.solenoid_stat = solenoid_stat_array;
end

return Database;