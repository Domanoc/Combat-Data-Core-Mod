------------------------------------------------------------------------------
--- INTERNAL COMPONENT SHOP FUNCTIONS ----------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Component shop.
---@class ModFrameworkInternalComponentShop
local ComponentShop = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalComponentShopPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to Types used by the framework.
local Types = require("ModFrameworkTypes")


---The spacing of the shop components
---@type number
local componentSpacing = 97
---The page status for the additional section
---@type ShopPagination
local additionalPage = { CurrentPage = 0, MaxPage = 1 }
---The page status for the mechs section
---@type ShopPagination
local mechsPage = { CurrentPage = 0, MaxPage = 1 }
---The page status for the weapons section
---@type ShopPagination
local weaponsPage = { CurrentPage = 0, MaxPage = 1 }
---The page status for the support section
---@type ShopPagination
local supportPage = { CurrentPage = 0, MaxPage = 1 }
---The page status for the reactors section
---@type ShopPagination
local reactorsPage = { CurrentPage = 0, MaxPage = 1 }

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Use in the create function of obj_database.lua
---
---Loads the needed shop sprites, so we can add buttons and rearrange the layout
function ComponentShop.LoadShopSprites()
	local modPath = Common.GetModPath("ModFramework");
	Storage.SpriteShopButtonLeft = Common.AddSprite(modPath.."sprites//ShopButtonLeft.png", 2, false, false, 0, 0)
	Storage.SpriteShopButtonRight = Common.AddSprite(modPath.."sprites//ShopButtonRight.png", 2, false, false, 0, 0)

	--We change the shop background sprite to allow better rearranging of the items
	local engineeringSprite = asset_get_index("spr_back_shop")
	sprite_replace(engineeringSprite, modPath.."sprites\\spr_back_shop.png", 1, false, false, 0, 0)

	--The robot sprite was bleeding out of the construction box
	local robotSprite = asset_get_index("spr_engineer_robot")
	sprite_replace(robotSprite, modPath.."sprites\\spr_engineer_robot.png", 1, false, false, 0, 0)
end

function ComponentShop.RearrangeShopComponents()
	--if the components are set skip
	if (Storage.IsShopUpdateNeeded == false) then
		return
	end

	for _, value in pairs(Storage.AllShopComponents) do
		value.researched = true;
		value.x = 0
		value.y = 0
	end

	Private.ArrangeWeaponComponents()

	--18 slots under additional
--	local startX = 20
--	local startY = 485
--	for i = 0, 17, 1 do
--		local x = startX + 97 * (i % 3)
--		local y = startY + 97 * (i // 3)
--		local index = i + 1
--
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--30 slots under mech
--	local startX = 320
--	local startY = 485
--	for i = 0, 29, 1 do
--		local x = startX + 97 * (i % 5)
--		local y = startY + 97 * (i // 5)
--		local index = i + 1
--
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--24 slots under weapons
--	local startX = 1120
--	local startY = 221
--	for i = 0, 23, 1 do
--		local x = startX + 97 * (i // 3)
--		local y = startY + 97 * (i % 3)
--		local index = i + 1
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--8 slots under support
--	local startX = 1120
--	local startY = 595
--	for i = 0, 7, 1 do
--		local x = startX + 97 * (i % 8)
--		local y = startY + 97 * (i // 8)
--		local index = i + 1
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--24 slots under reactors
--	local startX = 1120
--	local startY = 765
--	for i = 0, 23, 1 do
--		local x = startX + 97 * (i % 8)
--		local y = startY + 97 * (i // 8)
--		local index = i + 1
--		Storage.AllShopComponents[index].x = x
--		Storage.AllShopComponents[index].y = y
--	end

	--we only need to run this once so we set the flag to false
	Storage.IsShopUpdateNeeded = false
end

---Draw call for the modded shop buttons and events
function ComponentShop.ShopDraw()
	local obj_component_shop = Common.GetObjComponentShop()
	if (obj_component_shop.activated == true) then

		--Buttons for additional
		Private.DrawButton(Storage.SpriteShopButtonLeft, 86, 454, Private.AdditionalLeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 284, 454, Private.AdditionalRightButtonPressed)

		--Buttons for mechs
		Private.DrawButton(Storage.SpriteShopButtonLeft, 454, 454, Private.MechsLeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 652, 454, Private.MechsRightButtonPressed)

		--Buttons for weapons
		if (weaponsPage.MaxPage > 0) then
			Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 174, Private.WeaponsLeftButtonPressed)
		    Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 174, Private.WeaponsRightButtonPressed)
		end

		--Buttons for support
		Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 542, Private.SupportLeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 542, Private.SupportRightButtonPressed)

		--Buttons for reactors
		Private.DrawButton(Storage.SpriteShopButtonLeft, 1398, 728, Private.ReactorsLeftButtonPressed)
		Private.DrawButton(Storage.SpriteShopButtonRight, 1598, 728, Private.ReactorsRightButtonPressed)
	end
end

---Draws a button and listens for mouse left button press
---@param image number the index of the image
---@param x number the x coordinate where to draw
---@param y number the y coordinate where to draw
---@param func fun() the action on mouse left button press
function Private.DrawButton(image, x, y, func)
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local isButtonDown
	if (mx > x and mx < x + 22 and my > y and my < y + 24) then
		isButtonDown = 1;
		if (mouse_check_button_pressed(Types.MouseButtons.Left)) then
			func()
		end
	else
		isButtonDown = 0
	end
	draw_sprite(image, isButtonDown, x, y)
end

function Private.ArrangeWeaponComponents()

	--24 slots under weapons
	local slots = 24
	local pageWidth = 776
	local startX = 1120 - (pageWidth * weaponsPage)
	local startY = 221
	local index = 0
	local cadence = 3

	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.kineticWeapons, index, slots, cadence, startX, startY)
	if (index % cadence ~= 0) then
		index = index + (cadence - (index % cadence))
	end
	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.missileWeapons, index, slots, cadence, startX, startY)
	if (index % cadence ~= 0) then
		index = index + (cadence - (index % cadence))
	end
	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.energyWeapons, index, slots, cadence, startX, startY)
	if (index % cadence ~= 0) then
		index = index + (cadence - (index % cadence))
	end
	index = Private.ArrangeLoopVertical(Storage.WeaponsComponents.thermalWeapons, index, slots, cadence, startX, startY)
end

---Arrange components to a grid in vertical columns
---@param array game_obj_component[]
---@param index number
---@param startX number 
---@param startY number
---@return number
function Private.ArrangeLoopVertical(array, index, slots, cadence, startX, startY)
	for _, weapon in ipairs(array) do
		local x = startX + componentSpacing * (index // cadence)
		local y = startY + componentSpacing * (index % cadence)
		local upperBounds = (slots - 1) + (slots * weaponsPage)
		local lowerBounds = slots * weaponsPage
		if (weapon.researched == false) then
		elseif (index > upperBounds) then
			index = index + 1
		elseif (index < lowerBounds) then
			index = index + 1
		else
			weapon.x = x
			weapon.y = y
			index = index + 1
		end
	end
	return index
end

------------------------------------------------------------------------------
--- BUTTON EVENTS ------------------------------------------------------------
------------------------------------------------------------------------------

---The left button event for the additional section
function Private.AdditionalLeftButtonPressed()
    additionalPage.CurrentPage = additionalPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (additionalPage.CurrentPage < 0) then
		additionalPage.CurrentPage = additionalPage.MaxPage
	end
end

---The right button event for the additional section
function Private.AdditionalRightButtonPressed()
	additionalPage.CurrentPage = additionalPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (additionalPage.CurrentPage > additionalPage.MaxPage) then
		additionalPage.CurrentPage = 0
	end
end

---The left button event for the mechs section
function Private.MechsLeftButtonPressed()
    mechsPage.CurrentPage = mechsPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (mechsPage.CurrentPage < 0) then
		mechsPage.CurrentPage = mechsPage.MaxPage
	end
end

---The right button event for the mechs section
function Private.MechsRightButtonPressed()
	mechsPage.CurrentPage = mechsPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (mechsPage.CurrentPage > mechsPage.MaxPage) then
		mechsPage.CurrentPage = 0
	end
end

---The left button event for the weapon section
function Private.WeaponsLeftButtonPressed()
	weaponsPage.CurrentPage = weaponsPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (weaponsPage.CurrentPage < 0) then
		weaponsPage.CurrentPage = weaponsPage.MaxPage
	end
end

---The right button event for the weapon section
function Private.WeaponsRightButtonPressed()
	weaponsPage.CurrentPage = weaponsPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (weaponsPage.CurrentPage > weaponsPage.MaxPage) then
		weaponsPage.CurrentPage = 0
	end
end

---The left button event for the support section
function Private.SupportLeftButtonPressed()
    supportPage.CurrentPage = supportPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (supportPage.CurrentPage < 0) then
		supportPage.CurrentPage = supportPage.MaxPage
	end
end

---The right button event for the support section
function Private.SupportRightButtonPressed()
	supportPage.CurrentPage = supportPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (supportPage.CurrentPage > supportPage.MaxPage) then
		supportPage.CurrentPage = 0
	end
end

---The left button event for the reactors section
function Private.ReactorsLeftButtonPressed()
    reactorsPage.CurrentPage = reactorsPage.CurrentPage - 1
	Storage.IsShopUpdateNeeded = true
	if (reactorsPage.CurrentPage < 0) then
		reactorsPage.CurrentPage = reactorsPage.MaxPage
	end
end

---The right button event for the reactors section
function Private.ReactorsRightButtonPressed()
	reactorsPage.CurrentPage = reactorsPage.CurrentPage + 1
	Storage.IsShopUpdateNeeded = true
	if (reactorsPage.CurrentPage > reactorsPage.MaxPage) then
		reactorsPage.CurrentPage = 0
	end
end


------------------------------------------------------------------------------
--- EXPORT INTERNAL COMPONENT SHOP -------------------------------------------
------------------------------------------------------------------------------

return ComponentShop