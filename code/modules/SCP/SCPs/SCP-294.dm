/obj/machinery/scp294
	name = "SCP-294"
	desc = "A standard coffee vending machine. This one seems to have a QWERTY keyboard."
	icon = 'icons/obj/scp294.dmi'
	icon_state = "coffee_294"
	layer = 2.9
	anchored = TRUE
	density = TRUE
	SCP = /datum/scp/scp_294

	var/usage_cooldown
	var/usage_cooldown_time = 40 SECONDS

	/// These reagents cannot be dispensed under any circumstances
	var/list/banned_chems = list(
	/datum/reagent/adminordrazine,
	/datum/reagent/nitroglycerin,
	/datum/reagent/glycerol,
	/datum/reagent/coolant,
	/datum/reagent/frostoil,
	/datum/reagent/zombie,
	/datum/reagent/jerraman,
	/datum/reagent/three_eye,
	/datum/reagent/mutation_toxin,
	/datum/reagent/advanced_mutation_toxin
	)
	/// List of name shortcuts for allowed chems: Name = Datum
	var/list/shortcut_chems = list(
		// Medicine
		"inap" = /datum/reagent/medicine/inaprovaline,
		"tric" = /datum/reagent/medicine/tricordrazine,
		"bica" = /datum/reagent/medicine/bicaridine,
		"mera" = /datum/reagent/medicine/meraline,
		"kelo" = /datum/reagent/medicine/kelotane,
		"derma" = /datum/reagent/medicine/dermaline,
		"dexa" = /datum/reagent/medicine/dexalin,
		"dexa+" = /datum/reagent/medicine/dexalin_plus,
		"dylo" = /datum/reagent/medicine/dylovene,
		"vena" = /datum/reagent/medicine/dylovene/venaxilin,
		"hyro" = /datum/reagent/medicine/hyronalin,
		"peri" = /datum/reagent/medicine/peridaxon,
		"alky" = /datum/reagent/medicine/alkysine,
		// Drugs/Narcotics
		"crypto" = /datum/reagent/cryptobiolin,
		"imped" = /datum/reagent/impedrezene,
		// Poison
		"venom" = /datum/reagent/toxin/venom,
		"spider" = /datum/reagent/toxin/venom,
		// Sedatives
		"sleep" = /datum/reagent/soporific,
		"chloral" = /datum/reagent/chloral_hydrate,
		"zombie" = /datum/reagent/toxin/zombie_powder,
	)

/datum/scp/scp_294
	name = "SCP-294"
	designation = "294"
	classification = EUCLID

/obj/machinery/scp294/attack_hand(mob/user)
	if(usage_cooldown > world.time)
		visible_message(SPAN_NOTICE("[src] displays 'NOT READY'."))
		return

	playsound(src, 'sound/machines/cb_button.ogg', 35, TRUE)
	var/chosen_reagent = replacetext(lowertext(input(user, "Enter the name of any liquid!", "SCP 294") as null|text), " ", "")
	if(shortcut_chems[chosen_reagent])
		chosen_reagent = shortcut_chems[chosen_reagent]
	else
		chosen_reagent = find_reagent(chosen_reagent)

	// "Ohoho, I am so smart, we'll use it with several people to avoid cooldown"
	if(usage_cooldown > world.time)
		visible_message(SPAN_NOTICE("[src] displays 'NOT READY'."))
		return

	// Reagent is banned / doesn't exist
	if(!chosen_reagent || (chosen_reagent in banned_chems))
		playsound(src, 'sound/machines/cb_button_fail.ogg', 35, TRUE)
		visible_message(SPAN_WARNING("[src] displays 'OUT OF RANGE'."))
		return

	// Pass
	usage_cooldown = world.time + usage_cooldown_time
	playsound(src, 'sound/scp/294/dispense1.ogg', 35, FALSE)
	visible_message(SPAN_NOTICE("[src] dispenses a small paper cup and starts filling it with some liquid."))
	log_and_message_staff("[user.real_name] used [src], dispensing [chosen_reagent]", user, get_turf(src))

	sleep(3 SECONDS)

	var/obj/item/reagent_containers/food/drinks/sillycup/D = new /obj/item/reagent_containers/food/drinks/sillycup(get_turf(src))
	D.reagents.add_reagent(chosen_reagent, 30)
	D.reagents.update_total()
	D.on_reagent_change()

/obj/machinery/scp294/proc/find_reagent(input)
	. = FALSE
	if(GLOB.chemical_reagents_list[input]) // Prefer paths, if one was provided.
		return input
	else
		return get_chem_id(input)
