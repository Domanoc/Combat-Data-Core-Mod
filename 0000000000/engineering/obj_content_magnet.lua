
---One time script when the game is started
---@param q any
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	--If its a game loaded from a save we dont add new items.
	if(Mod.Common.IsLoadedGame()) then
		return;
	end

	for i = 0, 2, 1 do
		for o = 1, 10, 1 do
			AddMagnet(i);
		end
	end
end


---Adds a component of type weapon
---@param magnet_number number the index of the magnet in the database.
function AddMagnet(magnet_number)
	local obj_content_magnet = asset_get_index("obj_content_magnet");

	--Copy the array to the working set
	local list_magnet = {};
	list_magnet = obj_content_magnet.list_magnet;

	local number_of_items = obj_content_magnet.number_of_items + 1;
	local obj_magnet_item = asset_get_index("obj_magnet_item");
	list_magnet[number_of_items] = instance_create_depth(0, 0, 0, obj_magnet_item);
	local added_magnet = list_magnet[number_of_items];
	added_magnet.my_num = 			number_of_items - 1;
	added_magnet.magnet_number = 	magnet_number;
	added_magnet.start_x = 			8;
	added_magnet.start_y = 			266;

	--return new data
	obj_content_magnet.list_magnet = list_magnet;
	obj_content_magnet.number_of_items = number_of_items;
end