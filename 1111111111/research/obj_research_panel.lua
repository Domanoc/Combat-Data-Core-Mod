
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)
	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("research/obj_research_panel.lua",""):gsub("/","\\");
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	local researchIcons = Mod.Types.ResearchIcons;
	local researchConditions = Mod.Types.ResearchConditions;
	local componentTypes = Mod.Types.ComponentTypes;

	Mod.Research.AddResearch({
		Name = "example_research_1",							--The name of the research, used to find its reference
		Position = 40,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchPosition = 51,						--the position of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
		Condition = researchConditions.Closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 0,										--the required available staff to start the research
		ReseachIcon = researchIcons.Research,					--the info on what icon to use
		Description = 											--the description text for the research
			"Example Research 1:#Text that will explain what this unlocks.",
		SpritePath = 											--path to the sprite used for the research
			current_file_path.."sprites/example_research.png",
		UnlockedComponents = {}									--the components that are unlocked by this research
	});

	local example_research_2_unlocks = Mod.Common.GetModdedComponents({
		{ Name = "example_mech", ComponentType = componentTypes.mech },
	});
	Mod.Research.AddResearch({
		Name = "example_research_2",							--The name of the research, used to find its reference
		Position = 31,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchPosition = 40,						--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		Condition = researchConditions.Closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 120,									--the required available staff to start the research
		ReseachIcon = researchIcons.Engineering,				--the info on what icon to use
		Description = 											--the description text for the research
			"Example Research 2:#Unlocks the example_mech.",
		SpritePath = 											--path to the sprite used for the research
			current_file_path.."sprites/example_research.png",
		UnlockedComponents = example_research_2_unlocks			--the components that are unlocked by this research
	});
end

---if activated = true
---@param q any
function step(q)
end

---if activated = true
---@param q any
function draw(q)
end