/obj/machinery/chemical_dispenser
	name = "chemical dispenser"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "dispenser"
	layer = BELOW_OBJ_LAYER
	clicksound = "button"
	clickvol = 20

	var/list/disp_reagents = null

	var/obj/item/reagent_containers/container = null

	var/ui_title = "Chemical Dispenser"

	var/accept_drinking = 0
	var/amount = 30

	idle_power_usage = 100
	density = TRUE
	anchored = TRUE
	obj_flags = OBJ_FLAG_ANCHORABLE
	core_skill = SKILL_CHEMISTRY
	var/can_contaminate = TRUE

/obj/machinery/chemical_dispenser/New()
	..()

/obj/machinery/chemical_dispenser/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/reagent_containers/glass) || istype(W, /obj/item/reagent_containers/food))
		if(container)
			to_chat(user, SPAN_WARNING("There is already \a [container] on \the [src]!"))
			return

		var/obj/item/reagent_containers/RC = W

		if(!accept_drinking && istype(RC,/obj/item/reagent_containers/food))
			to_chat(user, SPAN_WARNING("This machine only accepts beakers!"))
			return

		if(!RC.is_open_container())
			to_chat(user, SPAN_WARNING("You don't see how \the [src] could dispense reagents into \the [RC]."))
			return
		if(!user.unEquip(RC, src))
			return
		container =  RC
		update_icon()
		to_chat(user, SPAN_NOTICE("You set \the [RC] on \the [src]."))
		SSnano.update_uis(src) // update all UIs attached to src

	else
		..()
	return

/obj/machinery/chemical_dispenser/proc/eject_beaker(mob/user)
	if(!container)
		return
	var/obj/item/reagent_containers/B = container
	user.put_in_hands(B)
	container = null
	update_icon()

/obj/machinery/chemical_dispenser/ui_interact(mob/user, ui_key = "main",datum/nanoui/ui = null, force_open = 1)
	// this is the data which will be sent to the ui
	var/data[0]
	data["amount"] = amount
	data["isBeakerLoaded"] = container ? 1 : 0
	data["glass"] = accept_drinking
	var beakerD[0]
	if(container && container.reagents && container.reagents.reagent_list.len)
		for(var/datum/reagent/R in container.reagents.reagent_list)
			beakerD[++beakerD.len] = list("name" = R.name, "volume" = R.volume)
	data["beakerContents"] = beakerD

	if(container)
		data["beakerCurrentVolume"] = container.reagents.total_volume
		data["beakerMaxVolume"] = container.reagents.maximum_volume
	else
		data["beakerCurrentVolume"] = null
		data["beakerMaxVolume"] = null

	var chemicals[0]
	for(var/label in disp_reagents)
		chemicals[++chemicals.len] = list("label" = label)
	data["chemicals"] = chemicals

	// update the ui if it exists, returns null if no ui is passed/found
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "chem_disp.tmpl", ui_title, 390, 680)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/chemical_dispenser/OnTopic(mob/user, href_list)
	if(href_list["amount"])
		amount = round(text2num(href_list["amount"]), 1) // round to nearest 1
		amount = max(0, min(120, amount)) // Since the user can actually type the commands himself, some sanity checking
		return TOPIC_REFRESH

	if(href_list["dispense"])
		var/label = href_list["dispense"]
		if(!user.skill_check(core_skill, SKILL_BASIC) && prob(25))
			label = pick(disp_reagents)
		if(disp_reagents[label] && container && container.is_open_container())
			var/datum/reagent/R = disp_reagents[label]
			var/mult = 1 + (-0.5 + round(rand(), 0.1))*(user.skill_fail_chance(core_skill, 0.3, SKILL_TRAINED))
			container.reagents.add_reagent(R, amount*mult)
			var/contaminants_left = rand(0, max(SKILL_TRAINED - user.get_skill_value(core_skill), 0)) * can_contaminate
			var/choices = disp_reagents.Copy()
			while(length(choices) && contaminants_left)
				var/chosen_label = pick_n_take(choices)
				var/datum/reagent/choice = disp_reagents[chosen_label]
				if(choice == R)
					continue
				container.reagents.add_reagent(choice, round(rand()*amount/5, 0.1))
				contaminants_left--
			return TOPIC_REFRESH
		return TOPIC_HANDLED

	else if(href_list["ejectBeaker"])
		eject_beaker(user)
		return TOPIC_REFRESH



/obj/machinery/chemical_dispenser/AltClick(mob/user)
	if(CanDefaultInteract(user))
		eject_beaker(user)
	else
		..()

/obj/machinery/chemical_dispenser/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/chemical_dispenser/on_update_icon()
	cut_overlays()
	if(container)
		var/mutable_appearance/beaker_overlay
		beaker_overlay = image('icons/obj/chemical.dmi', src, "lil_beaker")
		beaker_overlay.pixel_x = rand(-10, 5)
		add_overlay(beaker_overlay)
