/obj/item/reagent_containers
	name = "Container"
	desc = "..."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	w_class = ITEM_SIZE_SMALL
	var/amount_per_transfer_from_this = 5
	var/possible_transfer_amounts = "5;10;15;25;30"
	var/volume = 30
	var/label_text

/obj/item/reagent_containers/proc/cannot_interact(mob/user)
	if(!CanPhysicallyInteract(user))
		to_chat(usr, SPAN_NOTICE("You're in no condition to do that!'"))
		return TRUE
	if(ismob(loc) && loc != user)
		to_chat(usr, SPAN_NOTICE("You can't set transfer amounts while [src] is being held by someone else."))
		return TRUE
	return FALSE

/obj/item/reagent_containers/verb/set_amount_per_transfer_from_this()
	set name = "Set transfer amount"
	set category = "Object"
	set src in range(1)
	if (cannot_interact(usr))
		return
	var/N = input("Amount per transfer from this:","[src]") as null|anything in cached_number_list_decode(possible_transfer_amounts)
	if (cannot_interact(usr)) // because input takes time and the situation can change
		return
	if(N)
		amount_per_transfer_from_this = N

/obj/item/reagent_containers/New()
	create_reagents(volume)
	..()
	if(!possible_transfer_amounts)
		src.verbs -= /obj/item/reagent_containers/verb/set_amount_per_transfer_from_this

/obj/item/reagent_containers/attack_self(mob/user as mob)
	return

/obj/item/reagent_containers/afterattack(obj/target, mob/user, flag)
	return

/obj/item/reagent_containers/proc/reagentlist() // For attack logs
	if(reagents)
		return reagents.get_reagents()
	return "No reagent holder"

/obj/item/reagent_containers/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/pen) || istype(W, /obj/item/device/flashlight/pen))
		var/tmp_label = sanitizeSafe(input(user, "Enter a label for [name]", "Label", label_text), MAX_NAME_LEN)
		if(length(tmp_label) > 10)
			to_chat(user, SPAN_NOTICE("The label can be at most 10 characters long."))
		else
			to_chat(user, SPAN_NOTICE("You set the label to \"[tmp_label]\"."))
			label_text = tmp_label
			update_name_label()
	else
		return ..()

/obj/item/reagent_containers/proc/update_name_label()
	if(label_text == "")
		SetName(initial(name))
	else
		SetName("[initial(name)] ([label_text])")

/obj/item/reagent_containers/proc/standard_dispenser_refill(mob/user, obj/structure/reagent_dispensers/target) // This goes into afterattack
	if(!istype(target))
		return 0

	if(!target.reagents || !target.reagents.total_volume)
		to_chat(user, SPAN_NOTICE("[target] is empty."))
		return 1

	if(reagents && !reagents.get_free_space())
		to_chat(user, SPAN_NOTICE("[src] is full."))
		return 1

	var/trans = target.reagents.trans_to_obj(src, target:amount_per_transfer_from_this)
	to_chat(user, SPAN_NOTICE("You fill [src] with [trans] units of the contents of [target]."))
	return 1

/obj/item/reagent_containers/proc/standard_splash_mob(mob/user, mob/target) // This goes into afterattack
	if(!istype(target))
		return

	if(user.a_intent == I_HELP)
		to_chat(user, SPAN_NOTICE("You can't splash people on help intent."))
		return 1

	if(!reagents || !reagents.total_volume)
		to_chat(user, SPAN_NOTICE("[src] is empty."))
		return 1

	if(target.reagents && !target.reagents.get_free_space())
		to_chat(user, SPAN_NOTICE("[target] is full."))
		return 1

	var/contained = reagentlist()
	if (reagents.should_admin_log())
		admin_attack_log(user, target, "Used \the [name] containing [contained] to splash the victim.", "Was splashed by \the [name] containing [contained].", "used \the [name] containing [contained] to splash")

	user.visible_message(SPAN_DANGER("[target] has been splashed with something by [user]!"), "<span class = 'notice'>You splash the solution onto [target].</span>")
	reagents.splash(target, reagents.total_volume)
	return 1

/obj/item/reagent_containers/proc/splashtarget(obj/target, mob/user)
	if (user.a_intent == I_HURT)
		if (standard_splash_mob(user,target))
			return TRUE
		if (reagents && reagents.total_volume)
			user.visible_message(
				SPAN_NOTICE("\The [user] splashes \the [src] onto \the [target]."),
				SPAN_NOTICE("You splash the contents of \the [src] onto \the [target]."),
				SPAN_NOTICE("You hear the sound of liquid splashing.")
			)
			reagents.splash(target, reagents.total_volume)
			return TRUE

/obj/item/reagent_containers/proc/self_feed_message(mob/user)
	to_chat(user, SPAN_NOTICE("You eat \the [src]"))

/obj/item/reagent_containers/proc/other_feed_message_start(mob/user, mob/target)
	user.visible_message(SPAN_WARNING("[user] is trying to feed [target] \the [src]!"))

/obj/item/reagent_containers/proc/other_feed_message_finish(mob/user, mob/target)
	user.visible_message(SPAN_WARNING("[user] has fed [target] \the [src]!"))

/obj/item/reagent_containers/proc/feed_sound(mob/user)
	return

/obj/item/reagent_containers/proc/standard_feed_mob(mob/user, mob/target) // This goes into attack
	if(!istype(target))
		return 0

	if(!reagents || !reagents.total_volume)
		to_chat(user, SPAN_NOTICE("\The [src] is empty."))
		return 1

	// only carbons can eat
	if(istype(target, /mob/living/carbon))
		if(target == user)
			if(istype(user, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = user
				if (user.a_intent == I_HURT)
					return
				if (!H.check_has_mouth())
					to_chat(user, "Where do you intend to put \the [src]? You don't have a mouth!")
					return
				var/obj/item/blocked = H.check_mouth_coverage()
				if (blocked)
					to_chat(user, SPAN_WARNING("\The [blocked] is in the way!"))
					return

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN) //puts a limit on how fast people can eat/drink things
			self_feed_message(user)
			reagents.trans_to_mob(user, issmall(user) ? ceil(amount_per_transfer_from_this/2) : amount_per_transfer_from_this, CHEM_INGEST)
			feed_sound(user)
			add_trace_DNA(user)
			return 1


		else
			if (user.a_intent == I_HURT)
				return
			var/mob/living/carbon/H = target
			if (!H.check_has_mouth())
				to_chat(user, "Where do you intend to put \the [src]? \The [H] doesn't have a mouth!")
				return
			var/obj/item/blocked = H.check_mouth_coverage()
			if (blocked)
				to_chat(user, SPAN_WARNING("\The [blocked] is in the way!"))
				return

			other_feed_message_start(user, target)

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			if(!do_after(user, 3 SECONDS, target))
				return

			other_feed_message_finish(user, target)

			var/contained = reagentlist()
			admin_attack_log(user, target, "Fed the victim with [name] (Reagents: [contained])", "Was fed [src] (Reagents: [contained])", "used [src] (Reagents: [contained]) to feed")

			reagents.trans_to_mob(target, amount_per_transfer_from_this, CHEM_INGEST)
			feed_sound(user)
			add_trace_DNA(target)
			return 1

	return 0

/obj/item/reagent_containers/proc/standard_pour_into(mob/user, atom/target) // This goes into afterattack and yes, it's atom-level
	if(!target.reagents)
		return 0

	// Ensure we don't splash beakers and similar containers.
	if(!target.is_open_container() && istype(target, /obj/item/reagent_containers))
		to_chat(user, SPAN_NOTICE("\The [target] is closed."))
		return 1
	// Otherwise don't care about splashing.
	else if(!target.is_open_container())
		return 0

	if(!reagents || !reagents.total_volume)
		to_chat(user, SPAN_NOTICE("[src] is empty."))
		return 1

	if(!target.reagents.get_free_space())
		to_chat(user, SPAN_NOTICE("[target] is full."))
		return 1

	var/trans = reagents.trans_to(target, amount_per_transfer_from_this)
	playsound(src, 'sound/effects/pour.ogg', 25, 1)
	to_chat(user, SPAN_NOTICE("You transfer [trans] unit\s of the solution to \the [target].  \The [src] now contains [src.reagents.total_volume] units."))
	return 1

/obj/item/reagent_containers/do_surgery(mob/living/carbon/M, mob/living/user)
	if(user.zone_sel.selecting != BP_MOUTH) //in case it is ever used as a surgery tool
		return ..()

/obj/item/reagent_containers/AltClick(mob/user)
	if(possible_transfer_amounts)
		set_amount_per_transfer_from_this()
	else
		return ..()

/obj/item/reagent_containers/examine(mob/user, distance)
	. = ..()
	if(!reagents)
		return
	if(distance < 2 && is_open_container() && reagents.has_reagent(/datum/reagent/drink/ice))
		if(reagents.get_reagent_amount(/datum/reagent/drink/ice) == reagents.total_volume)
			to_chat(user, SPAN_NOTICE("It's completely frozen.")) //If ice volume = total volume, then there is only ice in here
		else
			to_chat(user, SPAN_NOTICE("You see some ice floating around in it."))
	if(hasHUD(user, HUD_SCIENCE))
		var/prec = user.skill_fail_chance(SKILL_CHEMISTRY, 10)
		to_chat(user, SPAN_NOTICE("The [src] contains: [reagents.get_reagents(precision = prec)]."))
	else if((loc == user) && user.skill_check(SKILL_CHEMISTRY, SKILL_EXPERIENCED))
		to_chat(user, SPAN_NOTICE("Using your chemistry knowledge, you identify the following reagents in \the [src]: [reagents.get_reagents(!user.skill_check(SKILL_CHEMISTRY, SKILL_MASTER), 5)]."))

/obj/item/reagent_containers/ex_act(severity)
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			R.ex_act(src, severity)
	..()
