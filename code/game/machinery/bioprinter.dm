// GENERIC PRINTER - DO NOT USE THIS OBJECT.
// Flesh and robot printers are defined below this object.

/obj/machinery/organ_printer
	name = "organ printer"
	desc = "It's a machine that prints organs."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bioprinter"

	anchored = TRUE
	density = TRUE
	idle_power_usage = 40
	active_power_usage = 300
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null
	stat_immune = 0

	var/stored_matter = 0
	var/max_stored_matter = 0
	var/print_delay = 100
	var/printing

	// These should be subtypes of /obj/item/organ
	var/list/products = list()

/obj/machinery/organ_printer/state_transition(decl/machine_construction/default/new_state)
	. = ..()
	if (istype(new_state))
		updateUsrDialog()

/obj/machinery/organ_printer/on_update_icon()
	cut_overlays()
	if (panel_open)
		add_overlay("[icon_state]_panel_open")
	if (printing)
		add_overlay("[icon_state]_working")

/obj/machinery/organ_printer/examine(mob/user)
	. = ..()
	to_chat(user, SPAN_NOTICE("It is loaded with [stored_matter]/[max_stored_matter] matter units."))
	if (printing)
		to_chat(user, SPAN_NOTICE("It is currently printing."))

/obj/machinery/organ_printer/RefreshParts()
	print_delay = initial(print_delay)
	print_delay -= 10 * total_component_rating_of_type(/obj/item/stock_parts/manipulator)
	print_delay += 10 * number_of_components(/obj/item/stock_parts/manipulator)
	print_delay = max(0, print_delay)

	max_stored_matter = 50 * clamp(total_component_rating_of_type(/obj/item/stock_parts/matter_bin), 0, 20)
	. = ..()

/obj/machinery/organ_printer/components_are_accessible(path)
	return !printing && ..()

/obj/machinery/organ_printer/cannot_transition_to(path)
	if (printing)
		return SPAN_WARNING("You must wait for \the [src] to finish printing first!")
	return ..()

/obj/machinery/organ_printer/attackby(obj/item/I, mob/user)
	if (process_item(I, user))
		return
	. = ..()

/obj/machinery/organ_printer/interface_interact(mob/living/user)
	ui_interact(user)
	return TRUE

/obj/machinery/organ_printer/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null)
	var/data = list()

	data["special_data"] = get_special_data()
	data["print_time"] = print_delay / 10
	data["stored_matter"] = stored_matter
	data["max_matter"] = max_stored_matter
	data["printing"] = printing

	data["product_list"] = list()
	if (products)
		for (var/V in products)
			var/product_data = list()
			product_data["product"] = V
			product_data["req_matter"] = products[V][2]
			product_data["parsed_name"] = parse_zone(V)
			product_data["can_print"] = can_print(V)
			data["product_list"] += list(product_data)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data)
	if(!ui)
		ui = new(user, src, ui_key, "bioprinter.tmpl", name, 550, 700)
		ui.set_initial_data(data)
		ui.open()
		ui.auto_update_layout = TRUE
		ui.set_auto_update(1)

/// Attempts to run special logic for this item, such as turning it into matter or giving DNA samples. Return TRUE if you want to interrupt the normal attackby.
/obj/machinery/organ_printer/proc/process_item(obj/item/I, mob/living/user)
	return

/// Returns an joined list of HTML data for this organ printer's interface.
/obj/machinery/organ_printer/proc/get_ui_data()
	var/list/dat = list()
	dat += get_special_data()
	dat += "<b>Stored matter:</b> [stored_matter]/[max_stored_matter]"
	dat += "<b>Time to print:</b> [print_delay <= 0 ? "Instant" : "[print_delay / 10] second\s"]"
	dat += "<hr>"
	if (!printing)
		for (var/O in products)
			var/parsed_zone = parse_zone(O)
			var/print_cost = products[O][2]
			if (!can_print(O))
				dat += "Print [parsed_zone] - [stored_matter]/[print_cost] <b>[UI_FONT_BAD("\[INSUFFICIENT\]")]</b>"
			else
				dat += "[UIBUTTON("to_print=[O];print", "Print", null)] [parsed_zone] - [print_cost]/[print_cost]"
	else
		dat += UI_FONT_BAD("\The [name] is currently operating. Please wait...")
	return jointext(dat, "<br>")

/// Fetches HTML data unique to this subtype.
/obj/machinery/organ_printer/proc/get_special_data()
	return

/// Checks if this machine can print an organ. By default, this only checks for stored matter.
/obj/machinery/organ_printer/proc/can_print(choice)
	return stored_matter >= products[choice][2]

/// Creates an organ based on the provided choice and places it on our turf. Returns the created organ.
/obj/machinery/organ_printer/proc/print_organ(choice)
	var/new_organ = products[choice][1]
	var/obj/item/organ/O = new new_organ(get_turf(src))
	O.status |= ORGAN_CUT_AWAY
	return O

/// Attempts to print an organ based on the chosen type. Returns the created organ if it is made, or FALSE if it is not.
/obj/machinery/organ_printer/proc/attempt_to_print(choice, mob/living/user)
	update_use_power(POWER_USE_IDLE)
	printing = FALSE
	update_icon()
	if (!choice || inoperable())
		return FALSE
	if (!QDELETED(user) && CanPhysicallyInteract(user))
		ui_interact(user) // Refresh the window if we're still nearby
	return print_organ(choice)

/obj/machinery/organ_printer/OnTopic(mob/user, href_list, datum/topic_state/state)
	if (href_list["to_print"])
		if (operable() && !printing)
			visible_message(SPAN_NOTICE("\The [src] begins printing \the [parse_zone(href_list["to_print"])]."))
			stored_matter -= products[href_list["to_print"]][2]
			update_use_power(POWER_USE_ACTIVE)
			printing = TRUE
			update_icon()
			addtimer(CALLBACK(src, .proc/attempt_to_print, href_list["to_print"], user), print_delay)
			return TOPIC_REFRESH




////////////////////////////////////////////////
// PROSTHESES FABRICACTOR - Mechanical organs //
////////////////////////////////////////////////

/obj/machinery/organ_printer/robot
	name = "prostheses fabricator"
	desc = "It's a machine that fabricates mechanical limbs and organs from compressed steel."
	icon_state = "roboprinter"
	base_type = /obj/machinery/organ_printer/robot

	products = list(
		BP_HEART    = list(/obj/item/organ/internal/heart,      25),
		BP_LUNGS    = list(/obj/item/organ/internal/lungs,      25),
		BP_KIDNEYS  = list(/obj/item/organ/internal/kidneys,    20),
		BP_EYES     = list(/obj/item/organ/internal/eyes,       20),
		BP_LIVER    = list(/obj/item/organ/internal/liver,      25),
		BP_STOMACH  = list(/obj/item/organ/internal/stomach,    25),
		BP_L_ARM    = list(/obj/item/organ/external/arm,        65),
		BP_R_ARM    = list(/obj/item/organ/external/arm/right,  65),
		BP_L_LEG    = list(/obj/item/organ/external/leg,        65),
		BP_R_LEG    = list(/obj/item/organ/external/leg/right,  65),
		BP_L_FOOT   = list(/obj/item/organ/external/foot,       40),
		BP_R_FOOT   = list(/obj/item/organ/external/foot/right, 40),
		BP_L_HAND   = list(/obj/item/organ/external/hand,       40),
		BP_R_HAND   = list(/obj/item/organ/external/hand/right, 40),
		BP_CELL		= list(/obj/item/organ/internal/cell,       25)
	)

	machine_name = "prostheses fabricator"
	machine_desc = "Creates prosthetic limbs and organs by using steel sheets."
	var/matter_amount_per_sheet = 10
	var/matter_type = MATERIAL_STEEL

/obj/machinery/organ_printer/robot/mapped/Initialize()
	. = ..()
	stored_matter = max_stored_matter

/obj/machinery/organ_printer/robot/dismantle()
	if (stored_matter >= matter_amount_per_sheet)
		new /obj/item/stack/material/steel(get_turf(src), Floor(stored_matter/matter_amount_per_sheet))
	return ..()

/obj/machinery/organ_printer/robot/print_organ(choice)
	var/obj/item/organ/O = ..()
	O.robotize()
	O.status |= ORGAN_CUT_AWAY  // robotize() resets status to 0
	visible_message(SPAN_NOTICE("\The [src] churns for a moment, then spits out \a [O]."))
	playsound(src, 'sound/machines/ding.ogg', 50, TRUE)
	return O

/obj/machinery/organ_printer/robot/process_item(obj/item/W, mob/living/user)
	var/add_matter = 0
	var/object_name = "[W]" // Cache the name of our object in case we use it up

	// Attempt to process material sheets into stored matter
	if (istype(W, /obj/item/stack/material) && W.get_material_name() == matter_type)
		if ((max_stored_matter - stored_matter) >= matter_amount_per_sheet)
			var/obj/item/stack/S = W
			var/space_left = max_stored_matter - stored_matter
			var/sheets_to_take = min(S.amount, Floor(space_left / matter_amount_per_sheet))
			if (sheets_to_take > 0)
				add_matter = min(max_stored_matter - stored_matter, sheets_to_take * matter_amount_per_sheet)
				object_name = "[sheets_to_take] [S.name]"
				S.use(sheets_to_take)

	// Attempt to process synthetic organs
	else if (istype(W, /obj/item/organ))
		var/obj/item/organ/O = W
		if ((O.organ_tag in products) && istype(O, products[O.organ_tag][1]))
			if (!BP_IS_ROBOTIC(O))
				to_chat(user, SPAN_WARNING("\The [src] only accepts robotic organs."))
				return
			var/recycle_worth = Floor(products[O.organ_tag][2] * 0.5)
			if ((max_stored_matter - stored_matter) >= recycle_worth)
				add_matter = recycle_worth
				qdel(O)
		else
			to_chat(user, SPAN_WARNING("\The [src] does not know how to recycle \the [O]."))
			return

	// We can't recycle this object - continue with normal attackby
	else
		return FALSE

	// If we got this far, we've attempted to process an item. Give feedback as a result
	if (add_matter)
		stored_matter += add_matter
		to_chat(user, SPAN_NOTICE("\The [src] recycles \the [object_name]. New matter level: [stored_matter]/[max_stored_matter]."))
	else
		to_chat(user, SPAN_WARNING("\The [src] can't hold any more material."))

	return TRUE // And finally block the normal attackby so we don't smack the fabricator with the item if we still have it

/obj/machinery/organ_printer/robot/get_special_data()
	return "<b>Some species cannot use prosthetic organs.</b>"




////////////////////////////////
// BIOPRINTER - Fleshy organs //
////////////////////////////////

/obj/machinery/organ_printer/flesh
	name = "bioprinter"
	desc = "It's a machine that flash-clones organs using biological stock and a provided DNA sample. Compatible with most species."
	icon_state = "bioprinter"
	base_type = /obj/machinery/organ_printer/flesh
	machine_name = "bioprinter"
	machine_desc = "Bioprinters can create surrogate organs for many species by using a blood sample from the intended recipient. Uses meat for biological matter."
	// Products are created for the bioprinter when it is given a valid blood sample. The list starts empty
	products = null
	// null amount means it will calculate the cost based on get_organ_cost()
	var/list/amount_list = list(
		/obj/item/reagent_containers/food/snacks/meat = 50,
		/obj/item/reagent_containers/food/snacks/rawcutlet = 15,
		/obj/item/organ = null
	)
	var/datum/dna/loaded_dna_datum
	var/datum/species/loaded_species //For quick referencing

/obj/machinery/organ_printer/flesh/mapped/Initialize()
	. = ..()
	stored_matter = max_stored_matter

/obj/machinery/organ_printer/flesh/dismantle()
	var/turf/T = get_turf(src)
	if (T)
		while(stored_matter >= amount_list[/obj/item/reagent_containers/food/snacks/meat])
			stored_matter -= amount_list[/obj/item/reagent_containers/food/snacks/meat]
			new /obj/item/reagent_containers/food/snacks/meat(T)
	return ..()

/obj/machinery/organ_printer/flesh/print_organ(choice)
	var/obj/item/organ/O
	var/new_organ
	if (loaded_species.has_organ[choice])
		new_organ = loaded_species.has_organ[choice]
	else if (loaded_species.has_limbs[choice])
		new_organ = loaded_species.has_limbs[choice]["path"]
	if (new_organ)
		O = new new_organ(get_turf(src), loaded_dna_datum)
		O.status |= ORGAN_CUT_AWAY
	else
		O = ..()
	O.name = "surrogate [O.name]"
	O.color = rgb(230, 255, 230, 255) // Give it a greenish tint to show it's artificially grown
	visible_message(SPAN_NOTICE("\The [src] churns for a moment, injects its stored DNA into the biomass, then spits out \a [O]."))
	playsound(src, 'sound/machines/ding.ogg', 50, TRUE)
	return O

/obj/machinery/organ_printer/flesh/get_special_data()
	if (!loaded_dna_datum || !loaded_species)
		return UI_FONT_BAD("<b>No DNA saved. Insert a blood sample.</b>")
	else
		. = list()
		. += "<b>DNA hash:</b> [loaded_dna_datum.unique_enzymes]"
		. += "<b>DNA species:</b> [loaded_species.name]"
		. = jointext(., "<br>") // This proc call exemplifies byond.

/obj/machinery/organ_printer/flesh/process_item(obj/item/W, mob/living/user)
	// Attempt to process items for matter
	for (var/path in amount_list)
		if (istype(W, path))
			if (max_stored_matter == stored_matter)
				to_chat(user, SPAN_WARNING("\The [src] can't hold any more material."))
				return
			if (!user.unEquip(W))
				return
			var/add_matter = amount_list[path] ? amount_list[path] : 0.5 * get_organ_cost(W)
			stored_matter += min(add_matter, max_stored_matter - stored_matter)
			to_chat(user, SPAN_INFO("\The [src] processes \the [W]. New biomass: [stored_matter]/[max_stored_matter]."))
			qdel(W)
			return TRUE

	// Get DNA sample from a syringe
	if (istype(W,/obj/item/reagent_containers/syringe))
		var/obj/item/reagent_containers/syringe/S = W
		var/datum/reagent/blood/injected = locate() in S.reagents.reagent_list //Grab some blood
		if (injected && LAZYLEN(injected.data))
			var/loaded_dna = injected.data
			var/weakref/R = loaded_dna["donor"]
			var/mob/living/carbon/human/H = R.resolve()
			if (H && istype(H) && H.species && H.dna)
				loaded_species = H.species
				loaded_dna_datum = H.dna && H.dna.Clone()
				products = get_possible_products()
				S.reagents.remove_reagent(/datum/reagent/blood, S.amount_per_transfer_from_this)
				user.visible_message(
					SPAN_NOTICE("\The [user] injects \the [src] with a blood sample."),
					SPAN_NOTICE("You inject the blood sample into \the [src].")
				)
				return TRUE
		// Fail to get a blood sample, but still intercept the normal attackby
		to_chat(user, SPAN_WARNING("No viable blood can be obtained from \the [W]."))
		return TRUE

/// Returns a list of viable organs based on our blood sample. Certain species have different logic.
/obj/machinery/organ_printer/flesh/proc/get_possible_products()
	. = list()
	if (!loaded_species)
		return
	var/list/organs = list()
	for (var/organ in loaded_species.has_organ)
		organs += loaded_species.has_organ[organ]
	for (var/organ in loaded_species.has_limbs)
		if ((loaded_species.name == SPECIES_NABBER) || (organ == BP_GROIN))
			organs += loaded_species.has_limbs[organ]["path"]
	for (var/organ in organs)
		var/obj/item/organ/O = organ
		if (check_printable(organ))
			.[initial(O.organ_tag)] = list(O, get_organ_cost(O))

/// Gets the matter cost to print a biological organ based on its max damage amount.
/obj/machinery/organ_printer/flesh/proc/get_organ_cost(obj/item/organ/O)
	. = initial(O.print_cost)
	if (!.)
		. = round(0.75 * initial(O.max_damage))

/// Checks if a fleshy organ can be printed. Returns TRUE if it can, and FALSE if it cannot.
/obj/machinery/organ_printer/flesh/proc/check_printable(organtype)
	var/obj/item/organ/O = organtype
	if (!initial(O.can_be_printed))
		return FALSE
	if (initial(O.vital))
		return FALSE
	if (initial(O.status) & ORGAN_ROBOTIC)
		return FALSE
	if (ispath(organtype, /obj/item/organ/external))
		var/obj/item/organ/external/E = organtype
		if (initial(E.limb_flags) & ORGAN_FLAG_HEALS_OVERKILL)
			return FALSE
	return TRUE
