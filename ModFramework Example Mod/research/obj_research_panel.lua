
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath("ModFramework Example Mod");

	--load needed types
	local researchIcons = Mod.Types.ResearchIcons;
	local researchConditions = Mod.Types.ResearchConditions;
	local componentTypes = Mod.Types.ComponentTypes;
	local baseResearchResNumbers = Mod.Types.BaseResearchResNumbers;

	--Show example of research modding and adding
	--Adding a modded research with unlocks
	--Moving existing research
	--Relinking existing research
	--Adding unlocks to existing research

	--when we want a research to include an unlock we need to include the references
	--with this function we can get our modded components that we made in obj_database.lua
	local unlocks = Mod.Common.GetModdedComponents({
		{ Name = "example_mech", ComponentType = componentTypes.Mech },
	});
	
	Mod.Research.AddResearch({
		Name = "example_research_1",							--the name of the research, used to find its reference
		Position = 40,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchResNumber = 						--the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
			baseResearchResNumbers.FIRST_GENERATION_ENGINE,
		Condition = researchConditions.Closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 10,										--the required available staff to start the research
		ReseachIcon = researchIcons.Research,					--the info on what icon to use
		Description = 											--the description text for the research
			"Example Research 1:#Text that will explain what this unlocks.",
		SpritePath = 											--path to the sprite used for the research
			modFilepath.."sprites\\example_research.png",
		UnlockedComponents = unlocks							--the components that are unlocked by this research
	});

	--We can move any research to a new position will keeping its links
	Mod.Research.MoveResearch(baseResearchResNumbers.ROCKET_LAUNCH, 0);

	--We can relink a research to a new prerequisite research
	Mod.Research.ChangePrerequisite(baseResearchResNumbers.PROCESSOR_PROGRAMS, baseResearchResNumbers.REPAIR_SHOP);

	--We can clear the links a research has to make it easier to rearange the tech tree
	Mod.Research.ClearUnlockLinks(baseResearchResNumbers.NEW_MECH_PLATE);
end

---if activated = true
---@param q any
function step(q)
end

---if activated = true
---@param q any
function draw(q)
end