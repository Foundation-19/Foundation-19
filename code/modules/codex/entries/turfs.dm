/datum/codex_entry/wall
	entry_text = "You can deconstruct a wall by <span codexlink='welder'welding</span> it, and then wrenching the girder.<br>\
	You can build a wall by using metal sheets to make a girder, then adding almost any material as plating.<br>\
	Walls are typically made of steel girders, plated with steel or plasteel."

/datum/codex_entry/wall/New()
	associated_paths += typesof(/turf/simulated/wall)
	. = ..()

/datum/codex_entry/floor
	entry_text = "You can remove floors by using a wrench.<br>\
You can build floor tiles by crafting it with steel then placing it on the respective tile.<br>\
Floors are typically made out of steel."

/datum/codex_entry/floor/New()
	associated_paths += typesof(/turf/simulated/floor)
	. = ..()
