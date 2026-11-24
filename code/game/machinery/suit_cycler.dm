/obj/machinery/suit_cycler

	name = "suit cycler unit"
	desc = "An industrial machine for painting and refitting voidsuits."
	anchored = TRUE
	density = TRUE

	icon = 'icons/obj/suitstorage.dmi'
	icon_state = "close"

	req_access = list(ACCESS_CAPTAIN, ACCESS_BRIDGE)

	var/active = 0          // PLEASE HOLD.
	var/safeties = 1        // The cycler won't start with a living thing inside it unless safeties are off.
	var/irradiating = 0     // If this is > 0, the cycler is decontaminating whatever is inside it.
	var/radiation_level = 2 // 1 is removing germs, 2 is removing blood, 3 is removing phoron.
	var/model_text = ""     // Some flavour text for the topic box.
	var/locked = 1          // If locked, nothing can be taken from or added to the cycler.
	var/can_repair = 1         // If set, the cycler can repair voidsuits.
	var/electrified = 0

	// Possible modifications to pick between
	var/list/available_modifications = list(
		/decl/item_modifier/space_suit/engineering,
		/decl/item_modifier/space_suit/mining,
		/decl/item_modifier/space_suit/medical,
		/decl/item_modifier/space_suit/security,
		/decl/item_modifier/space_suit/atmos,
		/decl/item_modifier/space_suit/science,
		/decl/item_modifier/space_suit/pilot
	)

	// Extra modifications to add when emagged, duplicates won't be added
	var/emagged_modifications = list(
		/decl/item_modifier/space_suit/engineering,
		/decl/item_modifier/space_suit/mining,
		/decl/item_modifier/space_suit/medical,
		/decl/item_modifier/space_suit/security,
		/decl/item_modifier/space_suit/atmos,
		/decl/item_modifier/space_suit/science,
		/decl/item_modifier/space_suit/pilot,
		/decl/item_modifier/space_suit/mercenary/emag
	)

	//Species that the suits can be configured to fit.
	var/list/species = list(SPECIES_HUMAN,SPECIES_SKRELL,SPECIES_UNATHI)

	var/decl/item_modifier/target_modification
	var/target_species

	var/mob/living/carbon/human/occupant = null
	var/obj/item/clothing/suit/space/void/suit = null
	var/obj/item/clothing/head/helmet/space/helmet = null

	wires = /datum/wires/suit_storage_unit

/obj/machinery/suit_cycler/Initialize()
	. = ..()
	if(!length(available_modifications) || !length(species))
		crash_with("Invalid setup: [log_info_line(src)]")
		return INITIALIZE_HINT_QDEL

	available_modifications = list_values(decls_repository.get_decls(available_modifications))

	target_modification = available_modifications[1]
	target_species = species[1]

/obj/machinery/suit_cycler/Destroy()
	DROP_NULL(occupant)
	DROP_NULL(suit)
	DROP_NULL(helmet)
	return ..()

/obj/machinery/suit_cycler/attackby(obj/item/I as obj, mob/user as mob)

	if(electrified != 0)
		if(shock(user, 100))
			return

	//Hacking init.
	if(isMultitool(I) || isWirecutter(I))
		if(panel_open)
			attack_hand(user)
		return
	//Other interface stuff.
	if(istype(I, /obj/item/grab))
		var/obj/item/grab/G = I

		if(!(ismob(G.affecting)))
			return

		if(locked)
			to_chat(user, SPAN_DANGER("The suit cycler is locked."))
			return

		if(contents.len > 0)
			to_chat(user, SPAN_DANGER("There is no room inside the cycler for [G.affecting.name]."))
			return

		visible_message(SPAN_NOTICE("[user] starts putting [G.affecting.name] into the suit cycler."), range = 3)

		if(do_after(user, 2.5 SECONDS, src, bonus_percentage = 25))
			if(!G || !G.affecting) return
			var/mob/M = G.affecting
			if (M.client)
				M.client.perspective = EYE_PERSPECTIVE
				M.client.eye = src
			M.forceMove(src)
			occupant = M

			add_fingerprint(user)
			qdel(G)

			SStgui.update_uis(src)

			return
	else if(isScrewdriver(I))

		panel_open = !panel_open
		to_chat(user, "You [panel_open ?  "open" : "close"] the maintenance panel.")
		SStgui.update_uis(src)
		return

	else if(istype(I,/obj/item/clothing/head/helmet/space) && !istype(I, /obj/item/clothing/head/helmet/space/rig))

		if(locked)
			to_chat(user, SPAN_DANGER("The suit cycler is locked."))
			return

		if(helmet)
			to_chat(user, SPAN_DANGER("The cycler already contains a helmet."))
			return

		if(!user.unEquip(I, src))
			return
		to_chat(user, "You fit \the [I] into the suit cycler.")
		helmet = I

		SStgui.update_uis(src)
		return

	else if(istype(I,/obj/item/clothing/suit/space/void))

		if(locked)
			to_chat(user, SPAN_DANGER("The suit cycler is locked."))
			return

		if(suit)
			to_chat(user, SPAN_DANGER("The cycler already contains a voidsuit."))
			return

		if(!user.unEquip(I, src))
			return
		to_chat(user, "You fit \the [I] into the suit cycler.")
		suit = I

		SStgui.update_uis(src)
		return

	..()

/obj/machinery/suit_cycler/emag_act(remaining_charges, mob/user)
	if(emagged)
		to_chat(user, SPAN_DANGER("The cycler has already been subverted."))
		return

	//Clear the access reqs, disable the safeties, and open up all paintjobs.
	to_chat(user, SPAN_DANGER("You run the sequencer across the interface, corrupting the operating protocols."))

	var/additional_modifications = list_values(decls_repository.get_decls(emagged_modifications))
	available_modifications |= additional_modifications

	emagged = TRUE
	safeties = 0
	req_access = list()
	SStgui.update_uis(src)
	return 1

/obj/machinery/suit_cycler/physical_attack_hand(mob/user)
	if(electrified != 0)
		if(shock(user, 100))
			return TRUE

/obj/machinery/suit_cycler/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/suit_cycler/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SuitCycler", name)
		ui.open()

/obj/machinery/suit_cycler/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["locked"] = locked
	data["model_text"] = model_text
	data["emagged"] = emagged
	data["can_unlock"] = allowed(user)
	data["helmet"] = helmet ? helmet.name : null
	data["suit"] = suit ? suit.name : null
	data["can_repair"] = can_repair && suit && suit.damage
	data["radiation_level"] = radiation_level
	data["target_modification"] = target_modification ? target_modification.name : null
	data["target_species"] = target_species
	var/list/modifications = list()
	for(var/decl/item_modifier/mod in available_modifications)
		modifications += list(list(
			"name" = mod.name,
			"ref" = REF(mod),
			"selected" = (mod == target_modification)))
	data["modifications"] = modifications
	var/list/species_list = list()
	for(var/spec in species)
		species_list += list(list(
			"name" = spec,
			"selected" = (spec == target_species)))
	data["species"] = species_list
	var/list/rad_levels = list()
	var/list/level_choices = emagged ? list(1,2,3,4,5) : list(1,2,3)
	for(var/level in level_choices)
		rad_levels += list(list(
			"level" = level,
			"selected" = (level == radiation_level)))
	data["rad_levels"] = rad_levels
	return data

/obj/machinery/suit_cycler/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("eject_suit")
			if(!suit) return TRUE
			suit.dropInto(loc)
			suit = null
		if("eject_helmet")
			if(!helmet) return TRUE
			helmet.dropInto(loc)
			helmet = null
		if("select_department")
			var/decl/item_modifier/choice = locate(params["modification"])
			if(isnull(choice) || !(choice in available_modifications))
				return TRUE
			if(CanPhysicallyInteract(usr))
				target_modification = choice
		if("select_species")
			var/choice = params["species"]
			if(!(choice in species))
				return TRUE
			if(CanPhysicallyInteract(usr))
				target_species = choice
		if("select_rad_level")
			var/choice = text2num(params["level"])
			var/list/level_choices = emagged ? list(1,2,3,4,5) : list(1,2,3)
			if(!(choice in level_choices))
				return TRUE
			radiation_level = choice
		if("repair_suit")
			if(!suit || !can_repair) return TRUE
			active = 1
			spawn(100)
				repair_suit()
				finished_job()
		if("apply_paintjob")
			if(!suit && !helmet) return TRUE
			active = 1
			spawn(100)
				apply_paintjob()
				finished_job()
		if("toggle_safties")
			safeties = !safeties
		if("toggle_lock")
			if(allowed(usr))
				locked = !locked
				to_chat(usr, "You [locked ? "lock" : "unlock"] [src].")
			else
				to_chat(usr, FEEDBACK_ACCESS_DENIED)
		if("begin_decontamination")
			if(safeties && occupant)
				to_chat(usr, SPAN_DANGER("The cycler has detected an occupant. Please remove the occupant before commencing the decontamination cycle."))
				return TRUE
			active = 1
			irradiating = 10
			SStgui.update_uis(src)
			sleep(10)
			if(helmet)
				if(radiation_level > 2)
					helmet.decontaminate()
				if(radiation_level > 1)
					helmet.clean()
			if(suit)
				if(radiation_level > 2)
					suit.decontaminate()
				if(radiation_level > 1)
					suit.clean()
	SStgui.update_uis(src)
	return TRUE

/obj/machinery/suit_cycler/Process()
	if(electrified > 0)
		electrified--

	if(!active)
		return

	if(active && stat & (BROKEN|NOPOWER))
		active = 0
		irradiating = 0
		electrified = 0
		return

	if(irradiating == 1)
		finished_job()
		irradiating = 0
		return

	irradiating--

	if(occupant)
		if(prob(radiation_level*2)) occupant.emote("scream")
		if(radiation_level > 2)
			occupant.take_organ_damage(0,radiation_level*2 + rand(1,3))
		if(radiation_level > 1)
			occupant.take_organ_damage(0,radiation_level + rand(1,3))
		occupant.apply_damage(radiation_level*10, IRRADIATE, damage_flags = DAM_DISPERSED)

/obj/machinery/suit_cycler/proc/finished_job()
	var/turf/T = get_turf(src)
	T.visible_message("[icon2html(src, viewers(get_turf(src)))]<span class='notice'>\The [src] pings loudly.</span>")
	active = 0
	SStgui.update_uis(src)

/obj/machinery/suit_cycler/proc/repair_suit()
	if(!suit || !suit.damage || !suit.can_breach)
		return

	suit.breaches = list()
	suit.calc_breach_damage()

/obj/machinery/suit_cycler/verb/leave()
	set name = "Eject Cycler"
	set category = "Object"
	set src in oview(1)

	if (usr.incapacitated())
		return

	eject_occupant(usr)

/obj/machinery/suit_cycler/proc/eject_occupant(mob/user as mob)

	if(locked || active)
		to_chat(user, SPAN_WARNING("The cycler is locked."))
		return

	if (!occupant)
		return

	occupant.reset_view()
	occupant.dropInto(loc)
	occupant = null

	add_fingerprint(user)
	SStgui.update_uis(src)

	return

/obj/machinery/suit_cycler/proc/apply_paintjob()
	if(!target_species || !target_modification)
		return

	if(helmet) helmet.refit_for_species(target_species)
	if(suit) suit.refit_for_species(target_species)

	target_modification.RefitItem(helmet)
	target_modification.RefitItem(suit)

	if(helmet) helmet.SetName("refitted [helmet.name]")
	if(suit) suit.SetName("refitted [suit.name]")
