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

---Reseach index identifiers for the mres tables
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
Types.ResearchIndexes = Research;

---Research conditions
local ResearchConditions = {
	--It is closed, the prerequisites need to be completed
	Closed = 0,
	--It can be selected to start researching
	Opened = 1,
	--It is currently being researched
	Researching = 2,
	--The research is complete
	Researched = 3
};
Types.ResearchConditions = ResearchConditions;

---Research icons
---@type table<string, ReseachIcon>
local ResearchIcons = {
	Damage = 		{ IconType = 0 , IconSubType = 0 },
	Survival = 		{ IconType = 0 , IconSubType = 1 },
	Engineering = 	{ IconType = 1 , IconSubType = 0 },
	Production = 	{ IconType = 1 , IconSubType = 1 },
	Research = 		{ IconType = 1 , IconSubType = 2 },
	Plains = 		{ IconType = 2 , IconSubType = 0 },
	Ocean = 		{ IconType = 2 , IconSubType = 1 },
	Wasteland = 	{ IconType = 2 , IconSubType = 2 },
	Desert = 		{ IconType = 2 , IconSubType = 3 },
	Swamp = 		{ IconType = 2 , IconSubType = 4 },
	Volcano = 		{ IconType = 2 , IconSubType = 5 },
	Snow = 			{ IconType = 2 , IconSubType = 6 },
	City = 			{ IconType = 2 , IconSubType = 7 },
	Mountain = 		{ IconType = 2 , IconSubType = 8 },
	Cave = 			{ IconType = 2 , IconSubType = 9 },
}
Types.ResearchIcons = ResearchIcons;

---component sizes
---@class comp_sizes
---@field small 1
---@field large 5
local ComponentSizes = {
	small = 1, --1 construction slot
	large = 5  --5 construction slots, a full hanger row.
}
---@alias ComponentSize 1|5
Types.ComponentSizes = ComponentSizes;


---A non complete list of Virtual Keys
local VirtualKeys = {
	--Control keys

	Backspace = 8,
	Tab = 9,
	Enter = 13,
	Shift = 16,
	Ctrl = 17,
	Alt = 18,
	PauseBreak = 19,
	CapsLock = 20,
	Escape = 27,
	Space = 32,
	PageUp = 33,
	PageDown = 34,
	End = 35,
	Home = 36,
	ArrowLeft = 37,
	ArrowUp = 38,
	ArrowRight = 39,
	ArrowDown = 40,
	Insert = 45,
	Delete = 46,

	--Number row

	Number_0 = 48,
	Number_1 = 49,
	Number_2 = 50,
	Number_3 = 51,
	Number_4 = 52,
	Number_5 = 53,
	Number_6 = 54,
	Number_7 = 55,
	Number_8 = 56,
	Number_9 = 57,

	--Letters

	A = 65,
	B = 66,
	C = 67,
	D = 68,
	E = 69,
	F = 70,
	G = 71,
	H = 72,
	I = 73,
	J = 74,
	K = 75,
	L = 76,
	M = 77,
	N = 78,
	O = 79,
	P = 80,
	Q = 81,
	R = 82,
	S = 83,
	T = 84,
	U = 85,
	V = 86,
	W = 87,
	X = 88,
	Y = 89,
	Z = 90,

	--Numpad

	NumPad0 = 96,
	NumPad1 = 97,
	NumPad2 = 98,
	NumPad3 = 99,
	NumPad4 = 100,
	NumPad5 = 101,
	NumPad6 = 102,
	NumPad7 = 103,
	NumPad8 = 104,
	NumPad9 = 105,
	Multiply = 106,
	Add = 107,
	Subtract = 109,
	Divide = 111,

	--Function keys

	F1 = 112,
	F2 = 113,
	F3 = 114,
	F4 = 115,
	F5 = 116,
	F6 = 117,
	F7 = 118,
	F8 = 119,
	F9 = 120,
	F10 = 121,
	F11 = 122,
	F12 = 123,
}
Types.VirtualKeys = VirtualKeys;

return Types;