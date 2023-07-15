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

///List of ckeys that have seen a blurb of a given key.
GLOBAL_LIST_EMPTY(blurb_witnesses)
