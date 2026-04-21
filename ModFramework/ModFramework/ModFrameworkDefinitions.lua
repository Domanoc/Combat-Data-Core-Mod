---@class ModRegistration dataset containing the mod registration info
---@field LoadOrderId number the load order id of the mod
---@field Name string the name of the mod, equal to the folder name of the mod
---@field Path string the filepath to the mod folder

---@class ModdedComponent dataset containing relevant passtrough info for components
---@field ComponentType ComponentType the type of component
---@field Index number the index of the component
---@field Sprite number the index of the component sprite, used to fix production sprites on game load
---@field Name string the name of the component
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field ShopComponent ModdedShopComponent? the shop component to construct new items, or nil for an unconstructable item
---@field BlueLength number the range of a blue weapon
---@field WeaponDescription string the description text for a weapon component, empty string otherwise.

---@class MechData dataset for adding a new mech to the obj database
---@field Name string the name of the mech, used to find its references
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field PriceMetallite number the amount of metallite needed to produce this mech
---@field PriceBjorn number the amount of bjorn needed to produce this mech
---@field PriceMunilon number the amount of munilon needed to produce this mech
---@field PriceSkalaknit number the amount of skalaknit needed to produce this mech
---@field PriceStaff number the amount of staff needed to produce this mech
---@field ProductionDays number the amount of days it takes to produce this mech
---@field HeatResist number the heat resist value of the mech
---@field ImpactResist number the impact resist value of the mech
---@field CurrentResist number the current resist value of the mech
---@field HasMelee boolean Indicates if the mech can use a melee weapon
---@field PassiveArmor number the amount of passive armor the mech has
---@field Weight number the base weight of the mech
---@field Speed number the base speed of the mech
---@field ReloadTime number the base reload time of the mech
---@field BattleTime number the base battle time of the mech (the lenght of time it has ammo reserves for to shoot)
---@field MechCells MechCell[] the dataset on what cells the mech has
---@field SpriteSmall string the small sprite for the mech
---@field SpriteBig string the big sprite for the mech
---@field SpriteBattle string the spritesheet for the mech used on the battle screen
---@field SpriteBattleDead string the sprite for a destroyed mech on the battle screen
---@field SpriteMeleeVertical string? the vertical melee attack spritesheet used on the battle screen. optional if the mech has no melee
---@field SpriteMeleeHorizontal string? the horizontal melee attack spritesheet used on the battle screen. optional if the mech has no melee

---@class MechCell dataset on what cells a mech has
---@field ModuleType ModuleType module type (1-aux, 2-motor, 3-reactor, 4-gun, 5-cabin)
---@field X number the x coordinate for the cell, use the mod_mech_grid_help.png for help determining the location
---@field Y number the y coordinate for the cell, use the mod_mech_grid_help.png for help determining the location

---@class WeaponData dataset for adding a new weapon
---@field Name string the name of the mech, used to find its references
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field PriceMetallite number the amount of metallite needed to produce this weapon
---@field PriceBjorn number the amount of bjorn needed to produce this weapon
---@field PriceMunilon number the amount of munilon needed to produce this weapon
---@field PriceSkalaknit number the amount of skalaknit needed to produce this weapon
---@field PriceStaff number the amount of staff needed to produce this weapon
---@field ProductionDays number the amount of days it takes to produce this weapon
---@field WeaponType WeaponType the type of weapon (white = ballistic, red = rockets, blue = laser/tesla, yellow = thermal)
---@field FireRate number the base fire rate. higher values offer a faster rate, 600 with full firespeed points will fill the firespeed bar completely
---@field Weight number the base weight of the weapon
---@field Accuracy number the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
---@field EnergyCost number the base energy cost of the weapon
---@field Damage number the base damage value of the weapon
---@field Penetration number the base penetration value of the weapon
---@field ProjectileSpeed number the base projectile speed of the weapon
---@field IsEnergyBuffed boolean whether the energy cost boost damage output, for laser/tesla weapons this is an additional increase on their native bonus.
---@field SpriteSmall string the small sprite for the weapon
---@field SpriteBig string the big sprite for the weapon
---@field SpriteHuge string the huge sprite for the weapon
---@field BlueLength number the range of a blue weapon, default is 750
---@field WeaponDescription string the description text for a weapon. used when the weapon is added to the main slot in engineering.

---@class SolenoidData dataset for adding a new solenoid
---@field Name string the name of the mech, used to find its references
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field PriceMetallite number the amount of metallite needed to produce this solenoid
---@field PriceBjorn number the amount of bjorn needed to produce this solenoid
---@field PriceMunilon number the amount of munilon needed to produce this solenoid
---@field PriceSkalaknit number the amount of skalaknit needed to produce this solenoid
---@field PriceStaff number the amount of staff needed to produce this solenoid
---@field ProductionDays number the amount of days it takes to produce this solenoid
---@field Power number the power value of the solenoid, lower numbers give more heat resist on reactor
---@field Induction number the induction value of the solenoid, any deviation from 1 gives worse energy stats
---@field Sprite string the sprite for the solenoid

---@class ResearchData dataset for a new research item
---@field Name string the name of the research item, used to find its references
---@field Position number position number on the research tree. You can see positions in the game with f6 (debug mode)
---@field PrerequisiteResearchPosition number? the position of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
---@field Condition ResearchCondition condition (0-closed, 1-opened, 2-researching, 3-researched)
---@field RequiredDays number the required days to complete the research
---@field RequiredStaff number the required available staff to start the research
---@field ReseachIcon ReseachIcon the info on what icon to use
---@field Description string the description text for the research
---@field SpritePath string path to the sprite used for the research
---@field UnlockedComponents ModdedComponent[] the components that are unlocked by this research

---@class ReseachIcon the information on the icon and sub icon for the research item
---@field IconType number 0|1|2 research icon type (0-combat, 1-production, 2-passability)
---@field IconSubType number research icon subtype (see left column in the game in research menu)

---@class ModdedResearch dataset for a stored modded research item
---@field Index number the assigned index for the modded research item
---@field ResNumber number the number for the research as found in the debug (F6) of the research screen (upper left white number)
---@field InitialCondition ResearchCondition the condition the modded research item was created with (0-closed, 1-opened, 2-researching, 3-researched)
---@field Name string the name of the research item
---@field UnlockedComponents ModdedComponent[] the components that are unlocked by this research

---@class ModdedShopComponent
---@field Index number the assigned index for the modded shop component

---@class ModdedComponentSearchCriteria
---@field Name string the name of the component
---@field ComponentType ComponentType the type of component

---@alias ComponentSize 1|5 the amount of hangar slots used in construction

---@alias ComponentType 1|2|3|4|5|6|7|8|9|10|11|95|96|97|98|99 the type of component

---@alias WeaponType "white"|"red"|"blue"|"yellow" the type of weapon (white = ballistic, red = rockets, blue = laser/tesla, yellow = thermal)

---@alias ResearchCondition 0|1|2|3 condition (0-closed, 1-opened, 2-researching, 3-researched)

---@alias ModuleType 1|2|3|4|5 module type (1-aux, 2-motor, 3-reactor, 4-gun, 5-cabin)