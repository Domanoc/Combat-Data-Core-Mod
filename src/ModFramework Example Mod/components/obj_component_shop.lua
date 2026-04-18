
---One time script when the game is started
---@param q game_obj_component_shop
function create(q)
    --load the mod framework as a global for use within this file
	Mod = require("ModFramework")
end

---Triggers when item is selected in the component shop. Used to update price information.
---@param q game_obj_component_shop
function update_prices(q)
end

---Triggers when a component production completes.
---@param q game_obj_component_shop
---@param i 1|2|3|4|5|6|7|8|9|10 The number of the hangar to check to check. Note you need to increase the value by 1 to get the correct Hanger slot.
function done(q, i)
    --load needed types
	local hangerIndexes = Mod.Types.HangerIndexes

    local hangerSlot = i + 1
    local hanger = q.hanger_mass[hangerSlot]
	local componentType = hanger[hangerIndexes.component_type]
	local component = Mod.Common.GetCustomComponentByType(componentType)

    --Check if we found a component and if the name matches the custom component we made
    if (component ~= nil and
        component.ReferenceName == "example_custom_component") then
        --The Staff used by the construction is already returned.
        --You only need to add whatever mod logic you need for this custom component
        --Example: Giving non standard things like pilots

        local emoticon = Mod.Common.GetPilotTemplateIndex("EMOTICON")
        if (emoticon ~= nil) then
            Mod.Hanger.AddPilot({
                Template = emoticon, 	--this wil determine the used sprite and the missing optional values.
                Age = 0,				--the age of the pilot
                IsCyborg = true,		--if true the pilot is a cyborg
                Name = "MR SMILE",      --the name of the pilot
                WorkExperience = {		--the text for the work experience
                    --Data that represents a string that will be localized. Its recommended to be in english for code readability
                    --The other actual values will be pulled from the mods localization files
                    --Use the GenerateLocalizationFiles() function to generate the mods localization files in development
                    LocalizedString = { LocalizedDefaultValue = "Example of a reused work experience text." },
                    --We can reuse a previous localized reference if the value is the same
                    ReferenceName = "example_pilot_reuse"
                },
            })
        end
    end
end

---Draw triggers when item is selected in the component shop.
---@param q game_obj_component_shop
---@param cur_item_type number
function draw_item_text(q, cur_item_type)
end