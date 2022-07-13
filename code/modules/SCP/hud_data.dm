/datum/hud_data/scp049
	has_a_intent = 1
	has_m_intent = 2
	has_warnings = 1
	has_pressure = 1
	has_nutrition = 0
	has_bodytemp = 1
	has_hands = 1
	has_drop = 1
	has_throw = 1
	has_resist = 1
	has_internals = 1
	gear = list()

/datum/hud_data/scp343
	has_a_intent = 1
	has_m_intent = 2
	has_warnings = 0
	has_pressure = 0
	has_nutrition = 0
	has_bodytemp = 0
	has_hands = 1
	has_drop = 1
	has_throw = 1
	has_resist = 1
	has_internals = 0
	gear = list(
		"gloves" =       list("loc" = ui_gloves,    "name" = "Gloves",       "slot" = slot_gloves,    "state" = "gloves", "toggle" = 1),
		"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = 1),
		"l_ear" =        list("loc" = ui_l_ear,     "name" = "Left Ear",     "slot" = slot_l_ear,     "state" = "ears",   "toggle" = 1),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = 1),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)
