/obj/machinery/scp294
	name = "coffee machine"
	desc = "A standard coffee vending machine. This one seems to have a QWERTY keyboard."
	icon = 'icons/SCP/scp294.dmi'

	icon_state = "coffee_294"
	anchored = TRUE
	density = TRUE

	//Config

	///How long to wait until we can use again
	var/usage_cooldown = 15 MINUTES
	///How many times we can use the machine before it needs to cooldown
	var/max_uses = 30

	//Mechanical

	///Tracks our usage cooldown
	var/usage_cooldown_tracker
	///Tracks our uses
	var/uses_tracker
	///Have we started restock?
	var/started_restock = FALSE
	///Our currently maintained list of global reagent datums
	var/list/weakref/globalReagents = list();
	///Reagent types

	///Shortcut names for things like "poision" or "death" where it dosent match a reagent name exactly
	var/list/shortcut_chems = list(
		"spider" = /datum/reagent/toxin/venom,
		"sleep" = /datum/reagent/soporific,
		"kidnap" = /datum/reagent/chloral_hydrate,
		"zombie" = /datum/reagent/scp008,
		"death" = /datum/reagent/toxin/cyanide,
		"joe" = /datum/reagent/blood,
		"008" = /datum/reagent/scp008,
		"health" = /datum/reagent/scp500
	)

	///Blacklisted reagents DO NOT USE THIS UNLESS ABSOLUTLEY NECCESARY, I DISLIKE PEOPLE IDIOT PROOFING SCPS - Dark
	var/list/blacklist = list(
		/datum/reagent/scp008
	)

	///Blacklisted containers to take from
	var/list/container_blacklist = list(

	)

/obj/machinery/scp294/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"coffee machine", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"294", //Numerical Designation
	)
//Mechanics

///Cycles through all reagents datums and picks out ones that contain the chemical we are looking for
/obj/machinery/scp294/proc/find_reagents_to_fill_from_path(input_path)
	var/list/datum/reagents/reagents_to_fill_from = list()
	if(!ispath(input_path))
		return FALSE

	//Iterates through that list
	for(var/datum/reagents/reagent_container in resolveWeakrefList(globalReagents))
		var/amount_contained = reagent_container.get_reagent_amount(input_path)
		var/turf/reagent_turf = get_turf(reagent_container.my_atom)
		if(!amount_contained || !reagent_turf || !(reagent_turf.z in GetConnectedZlevels(src.z)))
			continue
		LAZYADD(reagents_to_fill_from, reagent_container)
	return reagents_to_fill_from

///Cycles through all reagents datums and picks out the one that contains the given name
/obj/machinery/scp294/proc/find_reagents_to_fill_from_cont_name(container_name)
	var/list/datum/reagents/reagents_to_fill_from = list()

	//Iterates through global reagents
	for(var/datum/reagents/reagent_container in resolveWeakrefList(globalReagents))
		var/turf/reagent_turf = get_turf(reagent_container.my_atom)
		if(!(findtext(reagent_container.my_atom.name, container_name,1, length(reagent_container.my_atom.name) + 1)) || !reagent_turf || !(reagent_turf.z in GetConnectedZlevels(src.z)))
			continue
		LAZYADD(reagents_to_fill_from, reagent_container)
	return reagents_to_fill_from

///Updates our global_reagents
/obj/machinery/scp294/proc/update_global_reagents()
	//Creats a list of reagents by distance
	for(var/datum/reagents/reagent_container in GLOB.reagents_datums)
		if(!istype(reagent_container.my_atom))
			continue
		if(reagent_container.total_volume <= 0)
			continue
		if(reagent_container.my_atom.type in container_blacklist)
			continue
		if(weakref(reagent_container) in globalReagents)
			continue
		ADD_SORTED(globalReagents, weakref(reagent_container), GLOBAL_PROC_REF(cmp_distance_reagents_weakref_asc))
	addtimer(CALLBACK(src, PROC_REF(update_global_reagents)), 5 MINUTES, TIMER_UNIQUE)

///Adds reagent we want to passed cup from list made in find_reagents_to_fill_from
/obj/machinery/scp294/proc/add_reagent_to_cup(input_path, obj/item/reagent_containers/food/drinks/sillycup/scp294cup/D, reagents_to_fill_from, getMaster = FALSE)
	var/amount_need_filled = D.volume
	if(!(ispath(input_path) || getMaster) || !istype(D) || !islist(reagents_to_fill_from))
		return
	for(var/datum/reagents/reagent_container in reagents_to_fill_from)
		var/amount_contained = reagent_container.get_reagent_amount(getMaster ? reagent_container.get_master_reagent_type() : input_path)

		amount_contained = Clamp(amount_contained, 0, amount_need_filled)
		reagent_container.trans_to_obj(D, amount_contained)
		amount_need_filled -= amount_contained

		if(amount_need_filled <= 0)
			break

	D.reagents.update_total()
	D.on_reagent_change()

//Overrides
/obj/machinery/scp294/Initialize()
	. = ..()
	update_global_reagents()

/obj/machinery/scp294/attack_hand(mob/user)
	if(user.a_intent != I_HELP)
		return ..()

	if(((world.time - usage_cooldown_tracker) > usage_cooldown) && uses_tracker >= max_uses)
		uses_tracker = 0
		started_restock = FALSE

	if(uses_tracker >= max_uses)
		balloon_alert(user, "RESTOCKING...")
		if(!started_restock)
			usage_cooldown_tracker = world.time
			started_restock = TRUE
		return

	playsound(src, 'sounds/machines/cb_button.ogg', 35, TRUE)
	var/chosen_reagent_text = tgui_input_text(user, "Please type in your preffered beverage.", "[src] Keyboard")
	if(!chosen_reagent_text)
		return

	var/datum/reagent/chosen_reagent

	for(var/reagent_name in shortcut_chems)
		if(findtext(chosen_reagent_text, reagent_name, 1, length(chosen_reagent_text) + 1))
			chosen_reagent = shortcut_chems[reagent_name]
			break

	if(!chosen_reagent)
		for(var/possible in GLOB.chemical_reagents_list)
			if(is_abstract(possible))
				continue
			var/datum/reagent/possible_reagent = possible
			var/chem_name = initial(possible_reagent.name) //It dosent work if we dont do this black magic
			if(findtext(chosen_reagent_text, chem_name))
				chosen_reagent = possible_reagent
				break

	var/list/reagents_to_fill_from = list();
	if(!chosen_reagent)
		reagents_to_fill_from = find_reagents_to_fill_from_cont_name(chosen_reagent_text)

	if(!(chosen_reagent || LAZYLEN(reagents_to_fill_from)) || (chosen_reagent in blacklist))
		balloon_alert(user, "OUT OF RANGE")
		playsound(src, 'sounds/machines/cb_button_fail.ogg', 35, TRUE)
		return

	if(!LAZYLEN(reagents_to_fill_from))
		reagents_to_fill_from = find_reagents_to_fill_from_path(chosen_reagent)
	if(!LAZYLEN(reagents_to_fill_from))
		balloon_alert(user, "OUT OF RANGE")
		playsound(src, 'sounds/machines/cb_button_fail.ogg', 35, TRUE)
		return

	uses_tracker++
	playsound(src, 'sounds/scp/294/dispense1.ogg', 35, FALSE)
	visible_message(SPAN_NOTICE("[src] dispenses a small paper cup and starts filling it with a liquid."))
	log_and_message_staff("[user.ckey]/[user.real_name] used SCP-[SCP.designation], dispensing [chosen_reagent]", user, get_turf(src))

	var/obj/item/reagent_containers/food/drinks/sillycup/scp294cup/D = new /obj/item/reagent_containers/food/drinks/sillycup/scp294cup(get_turf(src))
	D.anchored = TRUE
	spawn(3 SECONDS)
		add_reagent_to_cup(chosen_reagent, D, reagents_to_fill_from, chosen_reagent ? FALSE : TRUE) //if we are taking by container name we wouldent have chosen reagent set
		D.anchored = FALSE
