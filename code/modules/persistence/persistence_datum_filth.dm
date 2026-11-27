// Persistent filth — dirt, grime and trash that survives round restarts.
// Ported from Baystation12 code/modules/persistence (filth.dm +
// persistence_datum_filth.dm), adapted to F19:
//  - F19 decal base is /obj/effect/decal/cleanable (same var names)
//  - F19 trash items already exist at code/game/objects/items/trash.dm;
//    they get age tracking + persistence registration here

/obj/effect/decal/cleanable/filth
	name = "filth"
	desc = "Disgusting. Someone from last shift didn't do their job properly."
	gender = PLURAL
	icon = 'icons/effects/blood.dmi'
	icon_state = "mfloor1"
	random_icon_states = list("mfloor1", "mfloor2", "mfloor3", "mfloor4", "mfloor5", "mfloor6", "mfloor7")
	color = "#464f33"
	persistent = TRUE
	generic_filth = TRUE

/obj/effect/decal/cleanable/filth/Initialize()
	. = ..()
	alpha = rand(180, 220)

// ============================================================
// Persistence datum: survives round restarts, decays with age.
// generic_filth decals (vomit, smudges...) collapse into "filth"
// on save so the payload stays small; unique decals keep their type.
// ============================================================

/datum/persistent/filth
	name = "filth"
	entries_expire_at = 5
	has_admin_data = TRUE

/datum/persistent/filth/IsValidEntry(atom/entry)
	. = ..() && entry.invisibility == 0

/datum/persistent/filth/CheckTokenSanity(list/tokens)
	return ..() && ispath(tokens["path"])

/datum/persistent/filth/CheckTurfContents(turf/T, list/tokens)
	return !(locate(tokens["path"]) in T)

/datum/persistent/filth/FinalizeTokens(list/tokens)
	. = ..()
	if(.["path"] && !ispath(.["path"]))
		.["path"] = text2path(.["path"])
	. = tokens

/datum/persistent/filth/CreateEntryInstance(turf/creating, list/tokens)
	var/_path = tokens["path"]
	new _path(creating, tokens["age"] + 1)

/datum/persistent/filth/GetEntryAge(atom/entry)
	var/obj/effect/decal/cleanable/filth = entry
	return filth.age

/datum/persistent/filth/proc/GetEntryPath(atom/entry)
	var/obj/effect/decal/cleanable/filth = entry
	return filth.generic_filth ? /obj/effect/decal/cleanable/filth : filth.type

/datum/persistent/filth/CompileEntry(atom/entry)
	. = ..()
	.["path"] = "[GetEntryPath(entry)]"

// ============================================================
// Trash: real items (wrappers, empty cans...) dropped by crew and
// never picked up persist across rounds. Capped per turf to avoid
// rooms buried in wrappers.
// ============================================================

/datum/persistent/filth/trash
	name = "trash"

/datum/persistent/filth/trash/CheckTurfContents(turf/T, list/tokens)
	var/too_much_trash = 0
	for(var/obj/item/trash/trash in T)
		too_much_trash++
		if(too_much_trash >= 5)
			return FALSE
	return TRUE

/datum/persistent/filth/trash/GetEntryAge(atom/entry)
	var/obj/item/trash/trash = entry
	return trash.age

/datum/persistent/filth/trash/GetEntryPath(atom/entry)
	return entry.type
