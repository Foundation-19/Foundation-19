#define BOTTLE_SPRITES list("bottle-1", "bottle-2", "bottle-3", "bottle-4") //list of available bottle sprites
#define MAX_PILL_SPRITE 25 //max icon state of the pill sprites

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define CHEMMASTER_OPTIONS_BASE "BASE"
#define CHEMMASTER_OPTIONS_CONDIMENTS "CONDIMENTS"
#define CHEMMASTER_SWITCH_SPRITE_PILL "PILL"
#define CHEMMASTER_SWITCH_SPRITE_BOTTLE "BOTTLE"

/obj/machinery/chem_master
	name = "\improper ChemMaster 3000"
	desc = "This large machine uses a complex filtration system to split, merge, condense, or bottle up any kind of chemical, for all your medicinal* needs."
	density = TRUE
	anchored = TRUE
	icon = 'icons/obj/chemical.dmi'
	icon_state = "mixer0"
	layer = BELOW_OBJ_LAYER
	idle_power_usage = 20
	clicksound = SFX_MACHINE_BUTTON
	clickvol = 20
	core_skill = SKILL_CHEMISTRY
	var/obj/item/reagent_containers/beaker = null
	var/obj/item/storage/pill_bottle/loaded_pill_bottle = null

	var/to_beaker = FALSE // If TRUE, reagents will move from buffer -> beaker. If FALSE, reagents will be destroyed when moved from the buffer.
	var/useramount = 30 // Last used amount
	var/pillamount = 10
	var/max_pill_count = 20

	var/bottle_dosage = 60
	var/pill_dosage = 30

	var/bottlesprite = "bottle-1" //yes, strings
	var/pillsprite = "1"
	var/sloppy = TRUE // Whether reagents will not be fully purified (sloppy = TRUE) or there will be reagent loss (sloppy = FALSE) on reagent transfer.
	var/production_options = CHEMMASTER_OPTIONS_BASE // Determines what the machine can make from its buffer. A condimaster can't make pills, and so on
	var/reagent_limit = 120
	var/datum/reagent/analyzed_reagent = null // Datum housing the reagent we're currently trying to fetch data about
	var/switching_sprite = null // If equal to one of the above defines, will show a separate window for switching pill/bottle sprites.

/obj/machinery/chem_master/New()
	create_reagents(reagent_limit)
	..()

/obj/machinery/chem_master/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return

/obj/machinery/chem_master/attackby(obj/item/B as obj, mob/user as mob)

	if(istype(B, /obj/item/reagent_containers/glass))

		if(beaker)
			to_chat(user, "A beaker is already loaded into the machine.")
			return
		if(!user.unEquip(B, src))
			return
		beaker = B
		to_chat(user, "You add the beaker to the machine!")
		icon_state = "mixer1"
		atom_flags |= ATOM_FLAG_OPEN_CONTAINER

	else if(istype(B, /obj/item/storage/pill_bottle))

		if(loaded_pill_bottle)
			to_chat(user, "A pill bottle is already loaded into the machine.")
			return
		if(!user.unEquip(B, src))
			return
		loaded_pill_bottle = B
		to_chat(user, "You add the pill bottle into the dispenser slot!")

/obj/machinery/chem_master/proc/eject_beaker(mob/user)
	if(!beaker)
		return
	var/obj/item/reagent_containers/B = beaker
	user.put_in_hands(B)
	beaker = null
	reagents.clear_reagents()
	icon_state = "mixer0"
	atom_flags &= ~ATOM_FLAG_OPEN_CONTAINER

/obj/machinery/chem_master/proc/get_remaining_volume()
	return Clamp(reagent_limit - reagents.total_volume, 0, reagent_limit)

/obj/machinery/chem_master/AltClick(mob/user)
	if(CanDefaultInteract(user))
		eject_beaker(user)
	else
		..()

/obj/machinery/chem_master/proc/fetch_contaminants(mob/user, datum/reagents/reagents, datum/reagent/main_reagent)
	. = list()
	for(var/datum/reagent/reagent in reagents.reagent_list)
		if(reagent == main_reagent)
			continue
		if(prob(user.skill_fail_chance(core_skill, 100)))
			. += reagent

/obj/machinery/chem_master/proc/get_chem_info(datum/reagent/reagent, heading = "Chemical Analysis", detailed_blood = 1)
	if(!beaker || !reagent)
		return
	. = list()
	. += "<TITLE>[name]</TITLE>"
	. += "<h2>[heading] - [reagent.name]</h2>"
	if(detailed_blood && istype(reagent, /datum/reagent/blood))
		var/datum/reagent/blood/B = reagent
		. += "<br><b>Species of Origin:</b> [B.data["species"]]<br><b>Blood Type:</b> [B.data["blood_type"]]<br><b>DNA Hash:</b> [B.data["blood_DNA"]]"
	else
		. += "<br>[reagent.description]"
	. = JOINTEXT(.)

/obj/machinery/chem_master/proc/create_bottle(mob/user)
	var/bottle_name = reagents.total_volume ? reagents.get_master_reagent_name() : "glass"
	var/name = sanitizeSafe(input(usr, "Name:", "Name your bottle!", bottle_name) as null|text, MAX_NAME_LEN)
	if (!name)
		return
	var/obj/item/reagent_containers/glass/bottle/P = new/obj/item/reagent_containers/glass/bottle(loc)
	P.SetName("[name] bottle")
	P.icon_state = bottlesprite
	reagents.trans_to_obj(P, bottle_dosage)
	P.update_icon()

/obj/machinery/chem_master/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/chem_master/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChemMaster", name, 575, 600)
		ui.open()

/obj/machinery/chem_master/tgui_data(mob/user)
	var/data = list()
	if (analyzed_reagent)
		data["analyzedReagent"] = "\ref[analyzed_reagent]"
		data["analyzedName"] = analyzed_reagent.name
		data["analyzedDesc"] = analyzed_reagent.description
		if(istype(analyzed_reagent, /datum/reagent/blood))
			var/datum/reagent/blood/B = analyzed_reagent
			data["analyzedBloodSpecies"] = B.data["species"]
			data["analyzedBloodType"] = B.data["blood_type"]
			data["analyzedBloodDNA"] = B.data["blood_DNA"]
			data["analyzedIsBlood"] = 1

	data["loadedContainer"] = beaker ? 1 : 0

	if (loaded_pill_bottle)
		data["loadedPillBottle"] = 1
		data["pillBottleCount"] = loaded_pill_bottle.contents.len
		data["pillBottleMax"] = loaded_pill_bottle.max_storage_space

	data["isSloppy"] = sloppy
	data["isTransferringToBeaker"] = to_beaker
	data["productionOptions"] = production_options

	data["containerChemicals"] = list()
	if (beaker && beaker.reagents && beaker.reagents.reagent_list)
		for (var/datum/reagent/R in beaker.reagents.reagent_list)
			var/reagent_data = list()
			reagent_data["name"] = R.name
			reagent_data["desc"] = R.description
			reagent_data["volume"] = R.volume
			reagent_data["ref"] = "\ref[R]"
			data["containerChemicals"] += list(reagent_data)

	data["bufferChemicals"] = list()
	if (reagents && reagents.reagent_list)
		for (var/datum/reagent/R in reagents.reagent_list)
			var/reagent_data = list()
			reagent_data["name"] = R.name
			reagent_data["desc"] = R.description
			reagent_data["volume"] = R.volume
			reagent_data["ref"] = "\ref[R]"
			data["bufferChemicals"] += list(reagent_data)

	data["pillDosage"] = pill_dosage
	data["bottleDosage"] = bottle_dosage
	data["pillSprite"] = pillsprite
	data["bottleSprite"] = bottlesprite
	data["switchingSprite"] = switching_sprite

	data["maxPillSprite"] = MAX_PILL_SPRITE
	data["bottleSprites"] = BOTTLE_SPRITES

	return data

/obj/machinery/chem_master/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	var/mob/user = usr

	if(action == "ejectp")
		if(loaded_pill_bottle)
			loaded_pill_bottle.dropInto(loc)
			loaded_pill_bottle = null
		return TRUE

	if(beaker)
		var/datum/reagents/R = beaker.reagents

		if(action == "analyze")
			var/datum/reagent/reagent = locate(params["analyze"]) in R.reagent_list
			if (!reagent)
				reagent = locate(params["analyze"]) in reagents.reagent_list
			if (reagent)
				analyzed_reagent = reagent
			return TRUE

		else if (action == "add")
			if(params["amount"])
				var/datum/reagent/their_reagent = locate(params["add"]) in R.reagent_list
				if(their_reagent)
					var/mult = 1
					var/amount = Clamp((text2num(params["amount"])), 0, get_remaining_volume())
					if(sloppy)
						var/contaminants = fetch_contaminants(user, R, their_reagent)
						for(var/datum/reagent/reagent in contaminants)
							R.trans_type_to(src, reagent.type, round(rand()*amount/5, 0.1))
					else
						mult -= 0.4 * (SKILL_MAX - user.get_skill_value(core_skill))/(SKILL_MAX-SKILL_MIN)
					R.trans_type_to(src, their_reagent.type, amount, mult)
			return TRUE

		else if (action == "addcustom")
			var/datum/reagent/their_reagent = locate(params["addcustom"]) in R.reagent_list
			if(their_reagent)
				useramount = input("Select the amount of reagents to transfer.", 30, useramount) as null|num
				if(useramount)
					useramount = Clamp(useramount, 0, 200)
					tgui_act("add", list("amount" = "[useramount]", "add" = params["addcustom"]), ui, state)
			return TRUE

		else if (action == "remove")
			if(params["amount"] && beaker)
				var/datum/reagent/my_reagents = locate(params["remove"]) in reagents.reagent_list
				if(my_reagents)
					var/amount = Clamp((text2num(params["amount"])), 0, 200)
					var/contaminants = fetch_contaminants(user, reagents, my_reagents)
					if(to_beaker)
						reagents.trans_type_to(beaker, my_reagents.type, amount)
						for(var/datum/reagent/reagent in contaminants)
							reagents.trans_type_to(beaker, reagent.type, round(rand()*amount, 0.1))
					else
						reagents.remove_reagent(my_reagents.type, amount)
						for(var/datum/reagent/reagent in contaminants)
							reagents.remove_reagent(reagent.type, round(rand()*amount, 0.1))
			return TRUE

		else if (action == "removecustom")
			var/datum/reagent/my_reagents = locate(params["removecustom"]) in reagents.reagent_list
			if(my_reagents)
				useramount = input("Select the amount to transfer.", 30, useramount) as null|num
				if(useramount)
					useramount = Clamp(useramount, 0, 200)
					tgui_act("remove", list("amount" = "[useramount]", "remove" = params["removecustom"]), ui, state)
			return TRUE

		else if (action == "pill_dosage")
			var/initial_dosage = initial(pill_dosage)
			var/new_dosage = input("Select a new dosage for your pills.", initial_dosage, "Pill Dosage") as null|num
			if (!new_dosage)
				return TRUE
			new_dosage = Clamp(new_dosage, 0, initial_dosage)
			pill_dosage = new_dosage
			to_chat(user, SPAN_NOTICE("You configure \the [src] to create pills with a maximum dosage of [pill_dosage] units."))
			return TRUE

		else if (action == "bottle_dosage")
			var/initial_dosage = initial(bottle_dosage)
			var/new_dosage = input("Select a new dosage for your bottles.", initial_dosage, "Bottle Dosage") as null|num
			if (!new_dosage)
				return TRUE
			new_dosage = Clamp(new_dosage, 0, initial_dosage)
			bottle_dosage = new_dosage
			to_chat(user, SPAN_NOTICE("You configure \the [src] to fill bottles with [bottle_dosage] units of reagents."))
			return TRUE

		else if (action == "toggle")
			to_beaker = !to_beaker
			return TRUE

		else if (action == "toggle_sloppy")
			sloppy = !sloppy
			return TRUE

		else if (action == "main")
			analyzed_reagent = null
			switching_sprite = null
			return TRUE

		else if (action == "eject")
			eject_beaker(user)
			return TRUE

		else if (action == "createpill" || action == "createpill_multiple")
			if (!reagents.total_volume)
				to_chat(user, SPAN_WARNING("\The [src] doesn't have any reagents to make into a pill."))
				return TRUE
			var/count = 1

			if(reagents.total_volume/count < 1)
				return TRUE

			if (action == "createpill_multiple")
				count = input("Select the number of pills to make.", "Max [max_pill_count]", pillamount) as null|num
				if (!count)
					return TRUE
				count = Clamp(count, 1, max_pill_count)

			if(reagents.total_volume/count < 1)
				return TRUE

			var/amount_per_pill = reagents.total_volume / count
			if (amount_per_pill > pill_dosage)
				amount_per_pill = pill_dosage

			var/pill_name = sanitizeSafe(input(usr, "Name:", "Name your pill!", "[reagents.get_master_reagent_name()] ([amount_per_pill]u)") as null|text, MAX_NAME_LEN)
			if (!pill_name)
				return TRUE

			if(reagents.total_volume/count < 1)
				return TRUE

			while (count-- && count >= 0)
				var/obj/item/reagent_containers/pill/P = new/obj/item/reagent_containers/pill(loc)
				if(!pill_name) pill_name = reagents.get_master_reagent_name()
				P.SetName("[pill_name] pill")
				P.icon_state = "pill"+pillsprite
				if(P.icon_state in list("pill1", "pill2", "pill3", "pill4", "pill5"))
					P.color = reagents.get_color()
				reagents.trans_to_obj(P,amount_per_pill)
				if(loaded_pill_bottle)
					if(loaded_pill_bottle.contents.len < loaded_pill_bottle.max_storage_space)
						P.forceMove(loaded_pill_bottle)
			return TRUE

		else if (action == "createbottle")
			create_bottle(user)
			return TRUE
		else if(action == "change_pill")
			switching_sprite = CHEMMASTER_SWITCH_SPRITE_PILL
			return TRUE
		else if(action == "change_bottle")
			switching_sprite = CHEMMASTER_SWITCH_SPRITE_BOTTLE
			return TRUE
		else if(action == "pill_sprite")
			pillsprite = params["pill_sprite"]
			return TRUE
		else if(action == "bottle_sprite")
			bottlesprite = params["bottle_sprite"]
			return TRUE

	return TRUE

/obj/machinery/chem_master/condimaster
	name = "\improper CondiMaster 3000"
	desc = "A machine pre-supplied with plastic condiment containers to bottle up reagents for use with foods."
	core_skill = SKILL_COOKING
	production_options = CHEMMASTER_OPTIONS_CONDIMENTS

/obj/machinery/chem_master/condimaster/get_chem_info(datum/reagent/reagent)
	return ..(reagent, "Condiment Info", 0)

/obj/machinery/chem_master/condimaster/create_bottle(mob/user)
	var/obj/item/reagent_containers/food/condiment/P = new/obj/item/reagent_containers/food/condiment(loc)
	reagents.trans_to_obj(P, 50)

#undef CHEMMASTER_OPTIONS_BASE
#undef CHEMMASTER_OPTIONS_CONDIMENTS

#undef CHEMMASTER_SWITCH_SPRITE_PILL
#undef CHEMMASTER_SWITCH_SPRITE_BOTTLE
