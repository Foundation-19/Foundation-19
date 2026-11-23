/obj/machinery/chemical_dispenser
	name = "chemical dispenser"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "dispenser"
	layer = BELOW_OBJ_LAYER
	clicksound = SFX_MACHINE_BUTTON
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
		SStgui.update_uis(src)

/obj/machinery/chemical_dispenser/proc/eject_beaker(mob/user)
	if(!container)
		return
	var/obj/item/reagent_containers/B = container
	user.put_in_hands(B)
	container = null
	update_icon()

/obj/machinery/chemical_dispenser/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/chemical_dispenser/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChemicalDispenser", ui_title)
		ui.open()

/obj/machinery/chemical_dispenser/tgui_data(mob/user)
	var/list/data = list()
	data["amount"] = amount
	data["isBeakerLoaded"] = container ? 1 : 0
	data["glass"] = accept_drinking
	var/list/beakerD = list()
	if(container && container.reagents && container.reagents.reagent_list.len)
		for(var/datum/reagent/R in container.reagents.reagent_list)
			beakerD.Add(list(list("name" = R.name, "volume" = R.volume)))
	data["beakerContents"] = beakerD

	if(container)
		data["beakerCurrentVolume"] = container.reagents.total_volume
		data["beakerMaxVolume"] = container.reagents.maximum_volume
	else
		data["beakerCurrentVolume"] = null
		data["beakerMaxVolume"] = null

	var/list/chemicals = list()
	for(var/label in disp_reagents)
		chemicals.Add(list(list("label" = label)))
	data["chemicals"] = chemicals
	return data

/obj/machinery/chemical_dispenser/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	switch(action)
		if("amount")
			amount = round(text2num(params["amount"]), 1)
			amount = max(0, min(120, amount))
			return TRUE
		if("dispense")
			var/label = params["dispense"]
			if(!usr.skill_check(core_skill, SKILL_BASIC) && prob(25))
				label = pick(disp_reagents)
			if(disp_reagents[label] && container && container.is_open_container())
				var/datum/reagent/R = disp_reagents[label]
				var/mult = 1 + (-0.5 + round(rand(), 0.1))*(usr.skill_fail_chance(core_skill, 0.3, SKILL_TRAINED))
				container.reagents.add_reagent(R, amount*mult)
				var/contaminants_left = rand(0, max(SKILL_TRAINED - usr.get_skill_value(core_skill), 0)) * can_contaminate
				var/choices = disp_reagents.Copy()
				while(length(choices) && contaminants_left)
					var/chosen_label = pick_n_take(choices)
					var/datum/reagent/choice = disp_reagents[chosen_label]
					if(choice == R)
						continue
					container.reagents.add_reagent(choice, round(rand()*amount/5, 0.1))
					contaminants_left--
			return TRUE
		if("ejectBeaker")
			eject_beaker(usr)
			return TRUE

/obj/machinery/chemical_dispenser/on_update_icon()
	cut_overlays()
	if(container)
		var/mutable_appearance/beaker_overlay
		beaker_overlay = image('icons/obj/chemical.dmi', src, "lil_beaker")
		beaker_overlay.pixel_x = rand(-10, 5)
		add_overlay(beaker_overlay)
