--------------------------
--Mod Framework Types   --
--------------------------

---Access to Types used by the framework.
local Types = {};

---MechModule identifiers
local MechModules = {
	aux = 1,
	motor = 2,
	reactor = 3,
	gun = 4,
	cabin = 5
};
Types.MechModules = MechModules;

---Component types
local ComponentTypes = {
	mech = 1,
	cabin = 2,
	motor = 3,
	weapon = 4,
	reactor = 5,
	injector = 6,
	piston = 7,
	kernel = 8,
	safety = 9,
	magnet = 10,
	solenoid = 11,
	armor_layer_middle = 95,
	armor_layer_end = 96,
	rocket = 97,
	beacon = 98,
	city_parts = 99
};
Types.ComponentTypes = ComponentTypes;

---Weapon type identifiers
local WeaponTypes = {
	white = "white",	--ballistic
	red = "red",		--rockets
	blue = "blue",		--laser/tesla
	yellow = "yellow",  --thermal
};
Types.WeaponTypes = WeaponTypes;

---Reseach index identifiers
local Research = {
	position = 1, 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	link_1 = 2,			--link 1, Link to open the next research. Should contain the number of the research from the array
	link_2 = 3,			--link 2, Link to open the next research. Should contain the number of the research from the array
	link_3 = 4,			--link 3, Link to open the next research. Should contain the number of the research from the array
	condition = 5,		--condition (0-closed, 1-opened, 2-researching, 3-researched)
	required_days = 6,	--the required days to complete the research
	required_staff = 7,	--the required available staff to start the research
	icon_type = 8,		--research icon type (0-combat, 1-production, 2-passability)
	icon_subtype = 9, 	--research icon subtype (see left column in the game in research menu)
	description = 10	--the description text for the research
};
Types.Research = Research;

---Research conditions
local ResearchConditions = {
	closed = 0,
	opened = 1,
	researching = 2,
	researched = 3
};
Types.ResearchConditions = ResearchConditions;

--Research icons
local ResearchIcons = {
	combat = 0,
	production = 1,
	passability = 2
};
Types.ResearchIcons = ResearchIcons;

--component sizes
---@class comp_sizes
---@field small 1
---@field large 5
local ComponentSizes = {
	small = 1, --1 construction slot
	large = 5  --5 construction slots, a full hanger row.
}
---@alias ComponentSize 1|5
Types.ComponentSizes = ComponentSizes;

return Types;