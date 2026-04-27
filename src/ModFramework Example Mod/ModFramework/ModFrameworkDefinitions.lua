---@alias ComponentSize 1|5 the amount of hangar slots used in construction

---@alias ComponentType 1|2|3|4|5|6|7|8|9|10|11|94|95|96|97|98|99 the type of component

---@alias WeaponType "white"|"red"|"blue"|"yellow" the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)

---@alias ResearchCondition 0|1|2|3 condition (0-closed, 1-opened, 2-researching, 3-researched)

---@alias ModuleType 1|2|3|4|5 module type (1-aux, 2-motor, 3-reactor, 4-gun, 5-cabin)

---@alias PilotVoices "male_indian"|"male_hispanic"|"male_aa"|"male_slovakian"|"male_romanian"|"male_russian"|"male_moroccan"|"male_scottish"|"female_italian"|"female_irish"|"female_japanese" the voice used by the pilot

---@alias PilotNames "BOB"|"MARK"|"DOM"|"JOE"|"JENIPHER"|"BARBARA"|"ZED"|"FREEZ"|"DONALD"|"ELLEN"|"GREGORY" the names of the existing pilots

---the possible research positions
---@alias ResearchPosition 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100|101|102|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|120|121|122|123|124|125|126|127|128|129|130|131|132|133|134|135|136|137|138|139|140|141|142|143|144|145|146|147|148|149

---@alias LocalizationSections "WeaponDescription"|"ResearchDescription"|"PilotWorkExperience" the sections for localization

---@class ModRegistration dataset containing the mod registration info
---@field LoadOrderId number the load order id of the mod
---@field Name string the name of the mod, equal to the folder name of the mod
---@field Path string the filepath to the mod folder

---@class ModdedComponent dataset containing relevant passthrough info for components
---@field ComponentType ComponentType the type of component
---@field Index number the index of the component
---@field Sprite number the index of the component sprite, used to fix production sprites on game load
---@field Name string the name of the component
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field ShopComponent ModdedShopComponent? the shop component to construct new items, or nil for an non constructable item
---@field GiveFreeItem boolean set to true to return a free copy when triggered as an unlock
---@field BlueLength number the range of a blue weapon
---@field WeaponDescription string the description text for a weapon component, empty string otherwise.

---@class MechData dataset for adding a new mech to the obj database
---@field Name string the name of the mech, used to find its references
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field GiveFreeItem boolean set to true to return a free copy when triggered as an unlock
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
---@field BattleTime number the base battle time of the mech (the length of time it has ammo reserves for to shoot)
---@field MechCells MechCell[] the dataset on what cells the mech has
---@field SpriteSmall string the small sprite for the mech
---@field SpriteBig string the big sprite for the mech
---@field SpriteBattle string the sprite sheet for the mech used on the battle screen
---@field SpriteBattleDead string the sprite for a destroyed mech on the battle screen
---@field SpriteMeleeVertical string? the vertical melee attack sprite sheet used on the battle screen. optional if the mech has no melee
---@field SpriteMeleeHorizontal string? the horizontal melee attack sprite sheet used on the battle screen. optional if the mech has no melee

---@class MechCell dataset on what cells a mech has
---@field ModuleType ModuleType module type (1-aux, 2-motor, 3-reactor, 4-gun, 5-cabin)
---@field X number the x coordinate for the cell, use the mod_mech_grid_help.png for help determining the location
---@field Y number the y coordinate for the cell, use the mod_mech_grid_help.png for help determining the location

---@class WeaponData dataset for adding a new weapon
---@field Name string the name of the mech, used to find its references
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field GiveFreeItem boolean set to true to return a free copy when triggered as an unlock
---@field PriceMetallite number the amount of metallite needed to produce this weapon
---@field PriceBjorn number the amount of bjorn needed to produce this weapon
---@field PriceMunilon number the amount of munilon needed to produce this weapon
---@field PriceSkalaknit number the amount of skalaknit needed to produce this weapon
---@field PriceStaff number the amount of staff needed to produce this weapon
---@field ProductionDays number the amount of days it takes to produce this weapon
---@field WeaponType WeaponType the type of weapon (white = kinetic, red = missiles, blue = energy, yellow = thermal)
---@field FireRate number the base fire rate. higher values offer a faster rate, 600 with full fire speed points will fill the fire speed bar completely
---@field Weight number the base weight of the weapon
---@field Accuracy number the base accuracy for the weapon. accuracy in degrees, 0 is perfect accuracy
---@field EnergyCost number the base energy cost of the weapon
---@field Damage number the base damage value of the weapon
---@field Penetration number the base penetration value of the weapon
---@field ProjectileSpeed number the base projectile speed of the weapon
---@field IsEnergyBuffed boolean whether the energy cost boost damage output, for energy weapons this is an additional increase on their native bonus.
---@field SpriteSmall string the small sprite for the weapon
---@field SpriteBig string the big sprite for the weapon
---@field SpriteHuge string the huge sprite for the weapon
---@field BlueLength number the range of a blue weapon, default is 750
---@field Description LocalizedString the description text for a weapon. used when the weapon is added to the main slot in engineering.

---@class SolenoidData dataset for adding a new solenoid
---@field Name string the name of the mech, used to find its references
---@field ComponentSize ComponentSize the size of the component when constructing it.
---@field IsResearched boolean set to true if its pre researched, else false.
---@field CanBeConstructed boolean set to true if it can be constructed in the component shop, false otherwise
---@field GiveFreeItem boolean set to true to return a free copy when triggered as an unlock
---@field PriceMetallite number the amount of metallite needed to produce this solenoid
---@field PriceBjorn number the amount of bjorn needed to produce this solenoid
---@field PriceMunilon number the amount of munilon needed to produce this solenoid
---@field PriceSkalaknit number the amount of skalaknit needed to produce this solenoid
---@field PriceStaff number the amount of staff needed to produce this solenoid
---@field ProductionDays number the amount of days it takes to produce this solenoid
---@field Power number the power value of the solenoid, lower numbers give more heat resist on reactor
---@field Induction number the induction value of the solenoid, any deviation from 1 gives worse energy stats
---@field Sprite string the sprite for the solenoid

---@class PilotTemplateData dataset for creating a new pilot template
---@field Sprite string the sprite sheet for the pilot
---@field Voice PilotVoices the voice used by the pilot
---@field Name string the name of the pilot, also used as a value to lookup the reference, Recommended to use full uppercase as this is what the game does
---@field Level number the level of the pilot
---@field LevelExperience number the amount of experience in the current level
---@field Skill number the skill stat of the pilot (0-100)
---@field Reaction number the reaction stat of the pilot (0-100)
---@field Vitality number the vitality stat of the pilot (0-100)
---@field StressResistance number the stress resistance stat of the pilot (0-100)

---@class PilotData dataset for adding a new pilot
---@field Template number|PilotNames the base dataset to base the pilot on, either the index number in obj_database.pilot_stat or reference one of the existing pilots. this wil determine the used sprite.
---@field WorkExperience LocalizedString the description text for the work experience of the pilot.
---@field Age number the age of the pilot
---@field IsCyborg boolean if true the pilot is a cyborg
---@field Name string? the name for the pilot, leave nil to use the template settings
---@field Voice PilotVoices? the voice used by the pilot, leave nil to use the template settings
---@field Level number? the level of the pilot, leave nil to use the template settings
---@field LevelExperience number? the amount of experience in the current level
---@field Skill number? the skill stat of the pilot (0-100), leave nil to use the template settings
---@field Reaction number? the reaction stat of the pilot (0-100), leave nil to use the template settings
---@field Vitality number? the vitality stat of the pilot (0-100), leave nil to use the template settings
---@field StressResistance number? the stress resistance stat of the pilot (0-100), leave nil to use the template settings

---@class LocalizedPilotData localized dataset for adding a new pilot
---@field Template number|PilotNames the base dataset to base the pilot on, either the index number in obj_database.pilot_stat or reference one of the existing pilots. this wil determine the used sprite.
---@field WorkExperience string the description text for the work experience of the pilot.
---@field Age number the age of the pilot
---@field IsCyborg boolean if true the pilot is a cyborg
---@field Name string? the name for the pilot, leave nil to use the template settings
---@field Voice PilotVoices? the voice used by the pilot, leave nil to use the template settings
---@field Level number? the level of the pilot, leave nil to use the template settings
---@field LevelExperience number? the amount of experience in the current level
---@field Skill number? the skill stat of the pilot (0-100), leave nil to use the template settings
---@field Reaction number? the reaction stat of the pilot (0-100), leave nil to use the template settings
---@field Vitality number? the vitality stat of the pilot (0-100), leave nil to use the template settings
---@field StressResistance number? the stress resistance stat of the pilot (0-100), leave nil to use the template settings

---@class PilotDsMap the converted dataset for a pilot ds_map
---@field Index number the index of the ds_map in obj_database.pilot_stat
---@field Sprite number the sprite index
---@field SoundIndex string the sound index value
---@field PhraseNumber number the phrase number
---@field Name string the name of the pilot
---@field Level number the level of the pilot
---@field LevelExperience number the amount of experience in the current level
---@field Skill number the skill stat of the pilot (0-100)
---@field Reaction number the reaction stat of the pilot (0-100)
---@field Vitality number the vitality stat of the pilot (0-100)
---@field StressResistance number the stress resistance stat of the pilot (0-100)

---@class ResearchData dataset for a new research item
---@field Name string the name of the research item, used to find its references
---@field Position ResearchPosition position number on the research tree. You can see positions in the game with f6 (debug mode)
---@field PrerequisiteResearchResNumber number? the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
---@field Condition ResearchCondition? condition (0-closed, 1-opened, 2-researching, 3-researched), leave nil for closed
---@field RequiredDays number the required days to complete the research
---@field RequiredStaff number the required available staff to start the research
---@field ResearchIcon ResearchIcon the info on what icon to use
---@field Description LocalizedString the description text for the research
---@field SpritePath string path to the sprite used for the research
---@field UnlockedComponents ModdedComponent[] the components that are unlocked by this research

---@class ResearchIcon the information on the icon and sub icon for the research item
---@field IconType number 0|1|2 research icon type (0-combat, 1-production, 2-passability)
---@field IconSubType number research icon subtype (see left column in the game in research menu)

---@class ModdedResearch dataset for a stored modded research item
---@field Index number the assigned index for the modded research item
---@field ResNumber number the number for the research as found in the debug view (F6) of the research screen (upper left white number)
---@field InitialCondition ResearchCondition the condition the modded research item was created with (0-closed, 1-opened, 2-researching, 3-researched)
---@field Name string the name of the research item
---@field UnlockedComponents ModdedComponent[] the components that are unlocked by this research

---@class ModdedShopComponent
---@field Index number the assigned index for the modded shop component

---@class ModdedComponentSearchCriteria
---@field Name string the name of the component
---@field ComponentType ComponentType the type of component

---Data that represents a string that will be localized, 
---the value that is requested is the default value and recommended to be in english for code readability
---The other actual values will be pulled from the mods localization files
---
---Use the GenerateLocalizationFiles() function to generate the mods localization files in development
---@class LocalizedString
---@field LocalizedDefaultValue string the default localization value, recommended to be in english for code readability

---@class ShopPagination dataset containing the pagination info for a section
---@field CurrentPage number the current page the shop section is on
---@field MaxPage number the max number of pages that exists for this section

---@class ArrangeSettings dataset containing the info needed to arrange components
---@field CurrentPage number the current page (based on a 0 index)
---@field SlotsPerPage number the amount of slots on a page
---@field Cadence number the amount of items in a row/column
---@field StartX number the starting x position
---@field StartY number the starting y position

---@class WeaponIndicatorLocation dataset containing the information to display a weapon indicator sprite
---@field X number the x position
---@field Y number the y position
---@field SubImageIndex 0|1|2|3 the sub image that needs to be shown 