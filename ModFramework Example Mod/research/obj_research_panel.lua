
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

	--When we want a research to include an unlock we need to include the references.
	--An component that is added as research unlock will, add a copy on completion and or unlock the production of item based on this setting.
	--With this function we can get our modded components that we made in "obj_database.lua".
	local unlocks = Mod.Common.GetModdedComponents({
		{ Name = "example_mech", ComponentType = componentTypes.Mech },
	});
	
	--We can create a new research and as a return value we get the new res number to create links with.
	local exampleResearchResNumber = Mod.Research.AddResearch({
		Name = "example_research_1",							--the name of the research, used to find its reference
		Position = 40,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchResNumber = 						--the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
			baseResearchResNumbers.FIRST_GENERATION_ENGINE,
		Condition = researchConditions.Opened,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 10,										--the required available staff to start the research
		ReseachIcon = researchIcons.Research,					--the info on what icon to use
		Description = {											--the description text for the research
			--We can provide full language support like this, atleast 1 language is needed
			--LanguageFile variable should match the language file ini that the string targets
			--Value should contain the string in the correct language for that language file
			 { LanguageFile = "loc_english.ini", Value = "Example Research 1:#Text that will explain what this unlocks." }
			,{ LanguageFile = "loc_french.ini", Value = "Exemple de recherche 1:#Texte qui expliquera ce que cela débloque." }
			,{ LanguageFile = "loc_german.ini", Value = "Beispielrecherche 1:#Text, der erklärt, was dadurch freigeschaltet wird." }
			,{ LanguageFile = "loc_polish.ini", Value = "Przykładowe badanie 1:#Tekst wyjaśniający, co to odblokowuje." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Exemplo de pesquisa 1: #Texto que explicará o que isso desbloqueia." }
			,{ LanguageFile = "loc_russian.ini", Value = "Пример исследования 1:#Текст, который объяснит, что это открывает." }
			,{ LanguageFile = "loc_spanish.ini", Value = "Ejemplo de investigación 1:#Texto que explicará qué desbloquea esto." }
			,{ LanguageFile = "loc_chinese.ini", Value = "研究示例 1:#解释这将解锁什么内容的文本" }
			,{ LanguageFile = "loc_italian.ini", Value = "Esempio di ricerca 1:#Testo che spiegherà cosa sblocca." }
		},
		SpritePath = 											--path to the sprite used for the research
			modFilepath.."sprites\\example_research.png",
		UnlockedComponents = unlocks							--the components that are unlocked by this research
	});

	--We can use the previous research return to set it as a prerequisite for a new research.
	Mod.Research.AddResearch({
		Name = "example_research_2",							--the name of the research, used to find its reference
		Position = 31,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		PrerequisiteResearchResNumber = 						--the res number of the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave nil for no prerequisite.
			exampleResearchResNumber,
		Condition = researchConditions.Closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		RequiredDays = 4,										--the required days to complete the research
		RequiredStaff = 10,										--the required available staff to start the research
		ReseachIcon = researchIcons.Survival,					--the info on what icon to use
		Description = {											--the description text for the research
			 { LanguageFile = "loc_english.ini", Value = "Example Research 1:#Text that will explain what this unlocks." }
		},
		SpritePath = 											--path to the sprite used for the research
			modFilepath.."sprites\\example_research.png",
		UnlockedComponents = {}									--the components that are unlocked by this research
	});

	--We can retrieve the data of a research that was added by the framework, even if it was made by another mod.
	--however if loading one from another mod that mod has to be before this mod in the load order.
	local example2 = Mod.Common.GetModdedResearch("example_research_2");

	--We can search for a single component to add as an unlock to an existing research
	local unlock = Mod.Common.GetModdedComponent("example_mech", componentTypes.Mech);
	--The existing research can be a base research or one from another mod.
	--However if adding one to a research from another mod that mod has to be before this mod in the load order.
	Mod.Research.AddUnlock(baseResearchResNumbers.NEW_MECH_PLATE, unlock);

	--We can move any research to a new position and it will keep its links.
	Mod.Research.MoveResearch(baseResearchResNumbers.ROCKET_LAUNCH, 0);

	--We can relink a research to a new prerequisite research.
	Mod.Research.ChangePrerequisite(baseResearchResNumbers.PROCESSOR_PROGRAMS, baseResearchResNumbers.REPAIR_SHOP);

	--We can clear the links a research has to make it easier to rearange the tech tree.
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