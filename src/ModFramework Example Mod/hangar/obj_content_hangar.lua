
---One time script when the game is started
---@param q game_obj_content_hangar
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--This function is run everytime the game is started
	--We need to check if the this start is a new game or from a loaded save
	if(Mod.Common.IsLoadedGame()) then
		--Since we dont want to add new pilots on loaded saves we return the function here.
		return
	end

	--Adding pilots requires that the ini is loaded so the framework queues the add calls for later
	--By adding pilots here you can add them to the roster for a new game

	--example of a fully modded pilot
	Mod.Hanger.AddPilot({
		Template = "FREEZ", 		--this wil determine the used sprite and the missing optional values.
		Age = 22,					--the age of the pilot
		IsCyborg = false,			--if true the pilot is a cyborg
		--We can provide full language support like this, atleast 1 language is needed
		--LanguageFile variable should match the language file ini that the string targets
		--Value should contain the string in the correct language for that language file
		WorkExperience = {			--the text for the work experience
			 { LanguageFile = "loc_english.ini", Value = "Description text for this weapon." }
			,{ LanguageFile = "loc_french.ini", Value = "Texte descriptif de cette expérience professionnelle." }
			,{ LanguageFile = "loc_german.ini", Value = "Beschreibungstext für dieses Praktikum." }
			,{ LanguageFile = "loc_polish.ini", Value = "Tekst opisujący to doświadczenie zawodowe." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Descrição da experiência profissional." }
			,{ LanguageFile = "loc_russian.ini", Value = "Описание данной программы стажировки." }
			,{ LanguageFile = "loc_spanish.ini", Value = "Texto descriptivo para esta experiencia laboral." }
			,{ LanguageFile = "loc_chinese.ini", Value = "本次工作经历的描述文字。" }
			,{ LanguageFile = "chs.ini", Value = "本次工作经历的描述文字。" }
			,{ LanguageFile = "loc_italian.ini", Value = "Testo descrittivo di questa esperienza lavorativa." }
			,{ LanguageFile = "japanese.ini", Value = "この職場体験に関する説明文。" }
		},
		Name = "JOHN",				--the name of the pilot
		Voice = "male_scottish", 	--the voice used
		Level = 0,					--the level of the pilot
		LevelExperience = 10,		--the amount of experience in the current level
		Reaction = 77,				--the reaction stat of the pilot (0-100)
		Skill = 77,					--the skill stat of the pilot (0-100)
		Vitality = 77,				--the vitality stat of the pilot (0-100)
		StressResistance = 77,		--the resistance stat stat of the pilot (0-100)
	})

	--Not all fields are required so you can make one with a more limited set of data
	--Missing data will be provided by the template
	Mod.Hanger.AddPilot({
		Template = "ELLEN", --this wil determine the used sprite and the missing optional values.
		Age = 40,
		IsCyborg = false,
		--We can provide full language support like this, atleast 1 language is needed
		--LanguageFile variable should match the language file ini that the string targets
		--Value should contain the string in the correct language for that language file
		WorkExperience = {
			 { LanguageFile = "loc_english.ini", Value = "Description text for this weapon." }
			,{ LanguageFile = "loc_french.ini", Value = "Texte descriptif de cette expérience professionnelle." }
			,{ LanguageFile = "loc_german.ini", Value = "Beschreibungstext für dieses Praktikum." }
			,{ LanguageFile = "loc_polish.ini", Value = "Tekst opisujący to doświadczenie zawodowe." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Descrição da experiência profissional." }
			,{ LanguageFile = "loc_russian.ini", Value = "Описание данной программы стажировки." }
			,{ LanguageFile = "loc_spanish.ini", Value = "Texto descriptivo para esta experiencia laboral." }
			,{ LanguageFile = "loc_chinese.ini", Value = "本次工作经历的描述文字。" }
			,{ LanguageFile = "chs.ini", Value = "本次工作经历的描述文字。" }
			,{ LanguageFile = "loc_italian.ini", Value = "Testo descrittivo di questa esperienza lavorativa." }
			,{ LanguageFile = "japanese.ini", Value = "この職場体験に関する説明文。" }
		},
	})

	--Instead of a template name we can provide the index for new pilot template
	local emoticon = Mod.Common.GetPilotTemplateIndex("EMOTICON")
	if (emoticon ~= nil) then
		Mod.Hanger.AddPilot({
			Template = emoticon, --this wil determine the used sprite and the missing optional values.
			Age = 666,
			IsCyborg = false,
			--We can provide full language support like this, atleast 1 language is needed
			--LanguageFile variable should match the language file ini that the string targets
			--Value should contain the string in the correct language for that language file
			WorkExperience = {
				{ LanguageFile = "loc_english.ini", Value = "Description text for this weapon." }
				,{ LanguageFile = "loc_french.ini", Value = "Texte descriptif de cette expérience professionnelle." }
				,{ LanguageFile = "loc_german.ini", Value = "Beschreibungstext für dieses Praktikum." }
				,{ LanguageFile = "loc_polish.ini", Value = "Tekst opisujący to doświadczenie zawodowe." }
				,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Descrição da experiência profissional." }
				,{ LanguageFile = "loc_russian.ini", Value = "Описание данной программы стажировки." }
				,{ LanguageFile = "loc_spanish.ini", Value = "Texto descriptivo para esta experiencia laboral." }
				,{ LanguageFile = "loc_chinese.ini", Value = "本次工作经历的描述文字。" }
				,{ LanguageFile = "chs.ini", Value = "本次工作经历的描述文字。" }
				,{ LanguageFile = "loc_italian.ini", Value = "Testo descrittivo di questa esperienza lavorativa." }
				,{ LanguageFile = "japanese.ini", Value = "この職場体験に関する説明文。" }
			},
		})
	end
end

---every game tick if we are in the hangar menu and battle is not active
---@param q game_obj_content_hangar
function step_activated(q)
end

---when all conditions are met to spawn a giant (red sword)
---@param q game_obj_content_hangar
function spawn_giant_red(q)
end

---when all conditions are met to spawn a giant (gold sword)
---@param q game_obj_content_hangar
function spawn_giant_gold(q)
end

---when all conditions are met to launch a nuke
---@param q game_obj_content_hangar
function nuke_landed(q)
end

---check when placing city
---@param q game_obj_content_hangar
function place_city(q,q_p)
	--q_p = 1, if q_p = 0 can't place city on that cell
	--mx = mouse_x
	--my = mouse_y
	--ds_grid_get(data_map_biom,mx,my) for checking bioms
end

---skip day button
---if not defending city
---@param q game_obj_content_hangar
function skip_day_start(q)
end

---if not defending city
---@param q game_obj_content_hangar
function skip_day_end(q)
end

---after battle info
---@param q game_obj_content_hangar
function draw_battle_log(q)
end

---@param q game_obj_content_hangar
function draw_calendar(q)
end

---@param q game_obj_content_hangar
function draw_map(q)
end

---@param q game_obj_content_hangar
function draw_personal(q)
end

---@param q game_obj_content_hangar
function draw_battle_windowed(q)
end

---@param q game_obj_content_hangar
function draw_battle_fullscreen(q)
end
