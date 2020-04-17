if (global.pause_frames > 0) exit;

// the list of pigeons that this swing has collided with
var _pigeon_list = ds_list_create();
// check for collisions with pigeon
instance_place_list(x, y, obj_pigeon, _pigeon_list, false);

// if any collisions were found
if (ds_list_size(_pigeon_list)) {
	// iterate over every collision
	for (var _i = 0; _i < ds_list_size(_pigeon_list); _i++) {
		// the currently iterated pigeon
		var _current_pigeon = _pigeon_list[| _i];
		// indicate that the player killed this pigeon
		_current_pigeon.killer = player;
		// allow the corpse of this pigeon to kill other pigeons
		_current_pigeon.corpse_deadly = true;
		// destroy it
		instance_destroy(_current_pigeon);
		// give the player a point
		player.total_score++;
		player.current_annoyance = max(0, player.current_annoyance + annoyance_per_kill);
		global.pause_frames += 2;
		global.screenshake_frames += 5;
	}
}
// clean up the list
ds_list_destroy(_pigeon_list);

// the list of poop that this swing has collided with
var _poop_list = ds_list_create();
// if any collisions were found
instance_place_list(x, y, obj_poop, _poop_list, false);
// if any collisions were found
if (ds_list_size(_poop_list)) {
	// iterate over every collision
	for (var _i = 0; _i < ds_list_size(_poop_list); _i++) {
		// destroy it
		instance_destroy(_poop_list[| _i]);
		// give the player a point
		player.total_score++;
	}
}
// clean up the list
ds_list_destroy(_poop_list);