
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("research/obj_research_panel.lua",""):gsub("/","\\");
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	-----------------
	--RESEARCH-------
	-----------------
	local research = Mod.Types.Research;
	local researchIcons = Mod.Types.ResearchIcons;
	local researchConditions = Mod.Types.ResearchConditions;
	local componentTypes = Mod.Types.ComponentTypes;
	-------------
	--DATA CORE--
	-------------
	local data_core_research_index = Mod.Research.AddResearch({
		name = "data_core_research",							--The name of the research, used to find its reference
		position = 130,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = -4,								--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = researchConditions.researching,				--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 4,										--the required days to complete the research
		required_staff = 0,										--the required available staff to start the research
		icon_type = researchIcons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 2,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"DATA CORE:#The main AI is working on unlocking the combat data core. When completed it grants additional research options.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/data_core_research.png",
		UnlockedComponents = {}									--the components that are unlocked by this research
	});
	-----------------
	--NOVA MECH------
	-----------------
	local nova_research_unlocks = Mod.Common.GetModdedComponents({
		{ Name = "nova_mech", ComponentType = componentTypes.mech },
		{ Name = "high_tech_solenoid", ComponentType = componentTypes.solenoid },
		{ Name = "howitzer_weapon", ComponentType = componentTypes.weapon },
		{ Name = "laser_pulse_cannon_weapon", ComponentType = componentTypes.weapon },
	})
	local nova_research_index = Mod.Research.AddResearch({
		name = "nova_research",									--The name of the research, used to find its reference
		position = 140,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = data_core_research_index,		--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = researchConditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 4,										--the required days to complete the research
		required_staff = 120,									--the required available staff to start the research
		icon_type = researchIcons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 1,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"NEW MECH: NOVA#2 guns, 2 armor, 15 impact resistance, 40 water resistance. A mass produced combat mech with decent stats.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/nova_research.png",
		UnlockedComponents = nova_research_unlocks				--the components that are unlocked by this research
	});
end

function step(q)	--if activated = true
end

function draw(q)	--if activated = true
end

