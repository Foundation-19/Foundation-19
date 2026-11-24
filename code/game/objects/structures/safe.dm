/*
CONTAINS:
SAFES
FLOOR SAFES
*/

//SAFES
/obj/structure/safe
	name = "safe"
	desc = "A huge chunk of metal with a dial embedded in it. Fine print on the dial reads \"Scarborough Arms - 2 tumbler safe, guaranteed thermite resistant, explosion resistant, and Class D resistant.\"."
	icon = 'icons/obj/structures.dmi'
	icon_state = "safe"
	anchored = TRUE
	density = TRUE
	var/open = 0		//is the safe open?
	var/tumbler_1_pos	//the tumbler position- from 0 to 72
	var/tumbler_1_open	//the tumbler position to open at- 0 to 72
	var/tumbler_2_pos
	var/tumbler_2_open
	var/dial = 0		//where is the dial pointing?
	var/dial_input = ""	//digits entered on the dial keypad
	var/space = 0		//the combined w_class of everything in the safe
	var/maxspace = 24	//the maximum combined w_class of stuff in the safe

/obj/structure/safe/Initialize()
	for(var/obj/item/I in loc)
		if(space >= maxspace)
			return
		if(I.w_class + space <= maxspace) //todo replace with internal storage or something
			space += I.w_class
			I.forceMove(src)
	. = ..()
	tumbler_1_pos = rand(0, 72)
	tumbler_1_open = rand(0, 72)

	tumbler_2_pos = rand(0, 72)
	tumbler_2_open = rand(0, 72)

/obj/structure/safe/proc/check_unlocked(mob/user as mob, canhear)
	if(user && canhear)
		if(tumbler_1_pos == tumbler_1_open)
			to_chat(user, SPAN_NOTICE("You hear a [pick("tonk", "krunk", "plunk")] from [src]."))
		if(tumbler_2_pos == tumbler_2_open)
			to_chat(user, SPAN_NOTICE("You hear a [pick("tink", "krink", "plink")] from [src]."))
	if(tumbler_1_pos == tumbler_1_open && tumbler_2_pos == tumbler_2_open)
		if(user) visible_message("<b>[pick("Spring", "Sprang", "Sproing", "Clunk", "Krunk")]!</b>")
		return 1
	return 0


/obj/structure/safe/proc/decrement(num)
	num -= 1
	if(num < 0)
		num = 71
	return num


/obj/structure/safe/proc/increment(num)
	num += 1
	if(num > 71)
		num = 0
	return num


/obj/structure/safe/proc/turn_dial(direction, mob/user, canhear)
	if(direction > 0)
		dial = increment(dial)
		if(dial == tumbler_1_pos - 1 || dial == tumbler_1_pos + 71)
			tumbler_1_pos = increment(tumbler_1_pos)
			if(canhear)
				to_chat(user, SPAN_NOTICE("You hear a [pick("clack", "scrape", "clank")] from [src]."))
			if(tumbler_1_pos == tumbler_2_pos - 37 || tumbler_1_pos == tumbler_2_pos + 35)
				tumbler_2_pos = increment(tumbler_2_pos)
				if(canhear)
					to_chat(user, SPAN_NOTICE("You hear a [pick("click", "chink", "clink")] from [src]."))
			check_unlocked(user, canhear)
	else
		dial = decrement(dial)
		if(dial == tumbler_1_pos + 1 || dial == tumbler_1_pos - 71)
			tumbler_1_pos = decrement(tumbler_1_pos)
			if(canhear)
				to_chat(user, SPAN_NOTICE("You hear a [pick("clack", "scrape", "clank")] from [src]."))
			if(tumbler_1_pos == tumbler_2_pos + 37 || tumbler_1_pos == tumbler_2_pos - 35)
				tumbler_2_pos = decrement(tumbler_2_pos)
				if(canhear)
					to_chat(user, SPAN_NOTICE("You hear a [pick("click", "chink", "clink")] from [src]."))
			check_unlocked(user, canhear)


/obj/structure/safe/proc/turn_to_position(target, mob/user, canhear)
	var/steps = 0
	while(dial != target && steps < 72)
		var/forward = (target - dial + 72) % 72
		var/backward = (dial - target + 72) % 72
		var/direction = 1
		if(backward < forward)
			direction = -1
		turn_dial(direction, user, canhear)
		steps++


/obj/structure/safe/on_update_icon()
	if(open)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = initial(icon_state)


/obj/structure/safe/attack_hand(mob/user as mob)
	tgui_interact(user)


/obj/structure/safe/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Safe", "Safe")
		ui.open()


/obj/structure/safe/tgui_data(mob/user)
	var/list/data = list()
	data["open"] = open
	data["dial"] = dial
	data["dial_input"] = dial_input
	var/list/item_list = list()
	if(open)
		for(var/obj/item/P in contents)
			item_list += list(list("name" = P.name, "ref" = "\ref[P]"))
	data["items"] = item_list
	return data


/obj/structure/safe/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!ishuman(usr))
		return TRUE
	var/mob/living/carbon/human/user = usr

	var/canhear = 0
	if(istype(user.l_hand, /obj/item/clothing/accessory/stethoscope) || istype(user.r_hand, /obj/item/clothing/accessory/stethoscope))
		canhear = 1

	switch(action)
		if("open")
			if(check_unlocked())
				to_chat(user, SPAN_NOTICE("You [open ? "close" : "open"] [src]."))
				open = !open
				update_icon()
			else
				to_chat(user, SPAN_NOTICE("You can't [open ? "close" : "open"] [src], the lock is engaged!"))
			return TRUE
		if("decrement")
			turn_dial(-1, user, canhear)
			return TRUE
		if("increment")
			turn_dial(1, user, canhear)
			return TRUE
		if("dial")
			var/digit = params["digit"]
			if(digit == null)
				return TRUE
			dial_input = "[dial_input][digit]"
			if(length(dial_input) > 2)
				dial_input = copytext(dial_input, length(dial_input) - 1)
			return TRUE
		if("clear")
			dial_input = ""
			return TRUE
		if("try")
			var/target = text2num(dial_input)
			dial_input = ""
			if(!isnum(target))
				return TRUE
			turn_to_position(clamp(round(target), 0, 71), user, canhear)
			return TRUE
		if("retrieve")
			var/obj/item/P = locate(params["ref"]) in src
			if(open)
				if(P && in_range(src, user))
					user.put_in_hands(P)
			return TRUE
	return FALSE


/obj/structure/safe/attackby(obj/item/I as obj, mob/user as mob)
	if(open)
		if(I.w_class + space <= maxspace)
			if(!user.unEquip(I, src))
				return
			space += I.w_class
			to_chat(user, SPAN_NOTICE("You put [I] in [src]."))
			SStgui.update_uis(src)
			return
		else
			to_chat(user, SPAN_NOTICE("[I] won't fit in [src]."))
			return
	else
		if(istype(I, /obj/item/clothing/accessory/stethoscope))
			to_chat(user, "Hold [I] in one of your hands while you manipulate the dial.")
			return


/obj/structure/safe/ex_act(severity)
	return

//FLOOR SAFES
/obj/structure/safe/floor
	name = "floor safe"
	icon_state = "floorsafe"
	density = FALSE
	level = 1	//underfloor
	layer = BELOW_OBJ_LAYER

/obj/structure/safe/floor/Initialize()
	. = ..()
	var/turf/T = loc
	if(istype(T) && !T.is_plating())
		hide(1)
	update_icon()

/obj/structure/safe/floor/hide(intact)
	set_invisibility(intact ? 101 : 0)

/obj/structure/safe/floor/hides_under_flooring()
	return 1
