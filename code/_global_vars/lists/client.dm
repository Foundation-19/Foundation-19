// This is a mapping from JS keys to Byond - ref: https://keycode.info/
GLOBAL_LIST_INIT(_kbMap, list(
	"UP" = "North",
	"RIGHT" = "East",
	"DOWN" = "South",
	"LEFT" = "West",
	"INSERT" = "Insert",
	"HOME" = "Northwest",
	"PAGEUP" = "Northeast",
	"DEL" = "Delete",
	"END" = "Southwest",
	"PAGEDOWN" = "Southeast",
	"SPACEBAR" = "Space",
	"ALT" = "Alt",
	"SHIFT" = "Shift",
	"CONTROL" = "Ctrl",
))

// Without alt, shift, ctrl and etc because its not necessary
GLOBAL_LIST_INIT(_kbMap_reverse, list(
	"North" = "Up",
	"East" = "Right",
	"South" = "Down",
	"West" = "Left",
	"Northwest" = "Home",
	"Northeast" = "PageUp",
	"Southwest" = "End",
	"Southeast" = "PageDown",
))

GLOBAL_LIST_EMPTY(hotkey_keybinding_list_by_key)
GLOBAL_LIST_EMPTY(classic_keybinding_list_by_key)
GLOBAL_LIST_INIT(keybindings_by_name, init_keybindings())

/// Creates and sorts all the keybinding datums
/proc/init_keybindings()
	. = list()
	for(var/KB in subtypesof(/datum/keybinding))
		var/datum/keybinding/keybinding = KB
		if(!initial(keybinding.name))
			continue
		add_keybinding(new keybinding, .)
	//init_emote_keybinds()

/// Adds an instanced keybinding to the global tracker
/proc/add_keybinding(datum/keybinding/instance, var/list/to_add_to)
	to_add_to[instance.name] = instance

	// Classic
	if(LAZYLEN(instance.classic_keys))
		for(var/bound_key in instance.classic_keys)
			LAZYADD(GLOB.classic_keybinding_list_by_key[bound_key], list(instance.name))

	// Hotkey
	if(LAZYLEN(instance.hotkey_keys))
		for(var/bound_key in instance.hotkey_keys)
			LAZYADD(GLOB.hotkey_keybinding_list_by_key[bound_key], list(instance.name))
