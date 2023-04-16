/obj/structure/scp_216
	name = "SCP 216"
	desc = "A metalic safe with munerical code lock."
	icon = 'icons/obj/structures.dmi'
	icon_state = "safe"
	anchored = TRUE
	density = TRUE
	var/open = FALSE
	var/current_code = 0
	/// Assoc list of codes in use and items stored in them.
	var/list/all_codes = list()
	// Note: If editing, please keep the descending order by groups. More common items should be at the top.
	/// Weight list of potential atoms that can be generated inside on spawn. Path = Chance.
	var/list/random_items = list(
		// Unsorted
		/obj/item/a_gift = 600,
		/obj/item/bikehorn = 400,
		/obj/item/bikehorn/airhorn = 300,
		/obj/item/boombox = 300,
		/obj/item/device/personal_shield = 50,
		/obj/item/a_gift/anything = 30,
		// Medicine
		/obj/item/FixOVein = 500,
		/obj/item/bonegel = 500,
		// Medical/Surgery tools
		/obj/item/circular_saw = 500,
		// Research
		// Tools
		/obj/item/crowbar = 500,
		/obj/item/device/multitool = 450,
		/obj/item/crowbar/crystal = 300,
		/obj/item/device/multitool/crystal = 250,
		// Power cells
		/obj/item/cell/high = 500,
		/obj/item/cell/super = 450,
		/obj/item/cell/hyper = 400,
		/obj/item/cell/infinite = 5,
		// Clothes
		// Hats
		/obj/item/clothing/head/beret = 500,
		/obj/item/clothing/head/bearpelt = 500,
		/obj/item/clothing/head/beret/sec/corporate/officer = 450,
		/obj/item/clothing/head/beret/sec/corporate/hos = 400,
		/obj/item/clothing/head/beret/scp/goc = 300,
		// Armor
		// Helmets
		/obj/item/clothing/head/helmet = 500,
		/obj/item/clothing/head/helmet/ballistic = 500,
		/obj/item/clothing/head/helmet/riot = 500,
		/obj/item/clothing/head/bomb_hood/security = 400,
		/obj/item/clothing/head/helmet/merc = 300,
		/obj/item/clothing/head/helmet/swat = 250,
		// Melee weapons
		/obj/item/excalibur = 20,
		// Ranged weapons
		// Antagonist stuff
		/obj/item/device/uplink_service/fake_crew_announcement = 60,
		/obj/item/device/uplink_service/fake_update_announcement = 60,
		/obj/item/device/soulstone = 50,
		/obj/item/device/chameleon = 30,
		/obj/item/device/flash/advanced = 20,
		// SCP objects
		/obj/item/reagent_containers/pill/scp500 = 10,
		/obj/item/storage/pill_bottle/scp500 = 1,
		// Mobs
		/mob/living/simple_animal/friendly/mouse = 150,
		/mob/living/simple_animal/friendly/corgi = 100,
		/mob/living/simple_animal/slime = 80,
		/mob/living/simple_animal/hostile/carp = 50,
		/mob/living/simple_animal/hostile/giant_spider/hunter = 40,
		/mob/living/simple_animal/hostile/giant_spider/spitter = 40,
		)

// Generate random loot for lucky people to find
/obj/structure/scp_216/Initialize()
	. = ..()
	for(var/i = 1 to rand(6,12))
		var/code = rand(0, 9999999)
		if(code in all_codes)
			i -= 1
			continue

		GenerateRandomItemsAt(code)

/obj/structure/scp_216/Destroy()
	for(var/atom/A in contents) // Forever gone
		QDEL_NULL(A)
	return ..()

/obj/structure/scp_216/on_update_icon()
	if(open)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = initial(icon_state)

/obj/structure/scp_216/attackby(obj/item/I, mob/user)
	if(!open)
		return ..()
	InsertItem(user, I, current_code)

/obj/structure/scp_216/attack_hand(mob/user)
	var/text_code = add_zero(num2text(current_code, 7), 7)
	var/dat = "<center>"
	dat += "<a href='?src=\ref[src];open=1'>[open ? "Close" : "Open"] [src]</a><br>"
	dat += "Current code: <a href='?src=\ref[src];change_code=1'>[text_code]</a><br>"
	if(open && (num2text(current_code, 7) in all_codes))
		dat += "<table>"
		for(var/atom/movable/A in all_codes[num2text(current_code, 7)])
			dat += "<tr><td><a href='?src=\ref[src];retrieve=\ref[A]'>[A.name]</a></td></tr>"
		dat += "</table></center>"
	var/datum/browser/popup = new(user, "safe", "Safe", 350, 300)
	popup.set_content(dat)
	popup.open()

/obj/structure/scp_216/Topic(href, href_list)
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/user = usr

	if(href_list["open"])
		to_chat(user, SPAN_NOTICE("You [open ? "close" : "open"] [src]."))
		open = !open
		update_icon()
		// JUMPSCARE!!
		if(open && (num2text(current_code, 7) in all_codes))
			for(var/mob/living/L in all_codes[num2text(current_code, 7)])
				L.forceMove(get_turf(src))
				visible_message(SPAN_DANGER("[L] falls out of \the [src]!"))
		attack_hand(user)
		return

	if(href_list["change_code"])
		if(open)
			to_chat(user, SPAN_WARNING("You have to close the safe before changing the code!"))
			return
		var/temp_code = text2num(input(user, "Enter the new code.", "SCP 216") as null|text)
		if(!isnum(temp_code))
			to_chat(user, SPAN_WARNING("Input a number!"))
			return
		if(temp_code > 9999999)
			to_chat(user, SPAN_WARNING("The code can be no longer than 7 numbers!"))
			return
		if(temp_code < 0)
			to_chat(user, SPAN_WARNING("The code can't be lower than zero!"))
			return
		current_code = temp_code
		attack_hand(user)
		return

	if(href_list["retrieve"])
		var/atom/movable/A = locate(href_list["retrieve"]) in all_codes[num2text(current_code, 7)]
		if(!A)
			to_chat(user, SPAN_WARNING("Couldn't find the item."))
			return
		if(!open)
			return
		if(!in_range(src, user))
			return
		RetrieveItem(user, A, current_code)

/obj/structure/scp_216/proc/GenerateRandomItemsAt(code)
	if(!(num2text(code, 7) in all_codes) || !islist(all_codes[num2text(code, 7)]))
		all_codes[num2text(code, 7)] = list()
	for(var/i = 1 to rand(1, 9))
		var/chosen_atom = pickweight(random_items)
		all_codes[num2text(code, 7)] += new chosen_atom(src)

/obj/structure/scp_216/proc/InsertItem(mob/living/carbon/human/user, atom/movable/A, code_loc = 0)
	if(!(num2text(code_loc, 7) in all_codes) || !islist(all_codes[num2text(code_loc, 7)]))
		all_codes[num2text(code_loc, 7)] = list()
	if(length(all_codes[num2text(code_loc, 7)]) >= 10)
		to_chat(user, SPAN_WARNING("There is already too many things in there!"))
		return
	if(!user.unEquip(A, src))
		return
	all_codes[num2text(code_loc, 7)] += A
	attack_hand(user)

/obj/structure/scp_216/proc/RetrieveItem(mob/living/carbon/human/user, atom/movable/A, code_loc = 0)
	if(!locate(A) in all_codes[num2text(code_loc, 7)])
		return
	all_codes[num2text(code_loc, 7)] -= A
	if(isitem(A))
		user.put_in_hands(A)
	else // In case we want to get funky and put mobs into it
		A.forceMove(get_turf(src))
	attack_hand(user)
