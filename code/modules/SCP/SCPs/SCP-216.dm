/obj/structure/scp216
	name = "safe"
	desc = "A metalic safe with multiple-dial combination lock."
	icon = 'icons/obj/structures.dmi'

	icon_state = "safe"
	anchored = TRUE
	density = TRUE

	//Config

	///Max items 216 can contain
	var/max_items = 10
	///Chance that items are generated for a code
	var/generate_chance = 75
	///Max amount of items that can be generated for a code
	var/max_items_generated = 9

	//Mechanics

	///Are we open?
	var/open = FALSE
	///Our currrent code.
	var/current_code = 0
	/// Assoc list of codes in use and items stored in them.
	var/list/all_codes = list()
	/// Codes that research has identified as "dimensionally resonant" (always yield contents)
	var/list/resonant_codes = list()

	/* Note: If editing, please keep the descending order by groups. More common items should be at the top. */
	// Unsorted
	// Medicine
	// Medical/Surgery tools
	// Tools
	// Power cells
	// Hats
	// Helmets
	// Clothing
	// Armor
	// Melee weapons
	// Ranged weapons
	// Antagonist stuff
	// SCP objects
	// Mobs
	/* TODO: Fix indendation check false-alarming at comments inside lists so we can put these in there */

	/// Weight list of potential atoms that can be generated inside on spawn. Path = Chance.
	var/list/random_items = list(
		/obj/item/a_gift = 600,
		/obj/item/bikehorn = 400,
		/obj/item/bikehorn/airhorn = 300,
		/obj/item/boombox = 300,
		/obj/item/device/personal_shield = 50,
		/obj/item/a_gift/anything = 30,
		/obj/item/FixOVein = 500,
		/obj/item/bonegel = 500,
		/obj/item/circular_saw = 500,
		/obj/item/crowbar = 500,
		/obj/item/device/multitool = 450,
		/obj/item/crowbar/crystal = 300,
		/obj/item/device/multitool/crystal = 250,
		/obj/item/cell/high = 500,
		/obj/item/cell/super = 450,
		/obj/item/cell/hyper = 400,
		/obj/item/cell/infinite = 5,
		/obj/item/clothing/head/beret = 500,
		/obj/item/clothing/head/bearpelt = 500,
		/obj/item/clothing/head/beret/sec/corporate/officer = 450,
		/obj/item/clothing/head/beret/sec/corporate/hos = 400,
		/obj/item/clothing/head/beret/scp/goc = 300,
		/obj/item/clothing/head/helmet = 500,
		/obj/item/clothing/head/helmet/ballistic = 500,
		/obj/item/clothing/head/helmet/riot = 500,
		/obj/item/clothing/head/bomb_hood/security = 400,
		/obj/item/clothing/head/helmet/merc = 300,
		/obj/item/clothing/head/helmet/swat = 250,
		/obj/item/clothing/under/casual_pants = 400,
		/obj/item/clothing/under/rank/guard = 400,
		/obj/item/clothing/under/rank/ntwork = 400,
		/obj/item/clothing/under/rank/guard/nanotrasen = 400,
		/obj/item/clothing/under/rank/ntwork/nanotrasen = 400,
		/obj/item/clothing/under/suit_jacket/corp/nanotrasen = 400,
		/obj/item/clothing/under/rank/guard/heph = 400,
		/obj/item/clothing/under/rank/scientist/zeng = 400,
		/obj/item/clothing/under/rank/scientist/executive/zeng = 400,
		/obj/item/clothing/under/casual_pants/classicjeans = 400,
		/obj/item/clothing/under/casual_pants/blackjeans = 400,
		/obj/item/clothing/under/casual_pants/greyjeans = 400,
		/obj/item/clothing/under/casual_pants/baggy/greyjeans = 400,
		/obj/item/clothing/under/casual_pants/baggy/track = 400,
		/obj/item/clothing/under/casual_pants/baggy/camo = 350,
		/obj/item/clothing/under/rank/security = 300,
		/obj/item/clothing/under/rank/dispatch = 300,
		/obj/item/clothing/under/rank/warden = 250,
		/obj/item/clothing/under/rank/warden/corp = 250,
		/obj/item/clothing/under/syndicate = 100,
		/obj/item/clothing/under/syndicate/combat = 100,
		/obj/item/clothing/under/syndicate/terragov = 100,
		/obj/item/clothing/suit/armor = 500,
		/obj/item/clothing/suit/armor/pcarrier/medium = 500,
		/obj/item/clothing/suit/armor/riot = 450,
		/obj/item/clothing/suit/armor/bulletproof = 450,
		/obj/item/clothing/suit/armor/laserproof = 450,
		/obj/item/clothing/suit/armor/vest/warden = 450,
		/obj/item/clothing/suit/armor/swat/officer = 400,
		/obj/item/clothing/suit/armor/vest/ert = 300,
		/obj/item/clothing/suit/armor/vest/ert/security = 300,
		/obj/item/clothing/suit/storage/vest/tactical = 250,
		/obj/item/clothing/suit/storage/vest/merc = 250,
		/obj/item/clothing/suit/armor/pcarrier/tan/tactical = 250,
		/obj/item/excalibur = 20,
		/obj/item/gun/projectile/pistol = 80,
		/obj/item/gun/projectile/pistol/military = 60,
		/obj/item/gun/projectile/automatic = 30,
		/obj/item/gun/projectile/heavysniper = 5,
		/obj/item/device/uplink_service/fake_crew_announcement = 60,
		/obj/item/device/uplink_service/fake_update_announcement = 60,
		/obj/item/device/soulstone = 50,
		/obj/item/device/chameleon = 30,
		/obj/item/device/flash/advanced = 20,
		/obj/item/reagent_containers/pill/scp500 = 10,
		/obj/item/storage/pill_bottle/scp500 = 1,
		/mob/living/simple_animal/friendly/mouse = 150,
		/mob/living/simple_animal/friendly/corgi = 100,
		/mob/living/simple_animal/slime = 80,
		/mob/living/simple_animal/hostile/carp = 50,
		/mob/living/simple_animal/hostile/giant_spider/hunter = 40,
		/mob/living/simple_animal/hostile/giant_spider/spitter = 40,
		)

/obj/structure/scp216/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"safe",
		SCP_SAFE,
		"216",
	)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)
	build_resonant_codes()

/obj/structure/scp216/forceMove(atom/dest)
	var/atom/old_loc = loc
	. = ..()
	if(loc != old_loc && SCP && SCP.research)
		SCP.research.set_containment_status(SCP_BREACHED)

/obj/structure/scp216/Destroy()
	LAZYCLEARLIST(all_codes) // Forever gone
	return ..()

/obj/structure/scp216/on_update_icon()
	if(open)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = initial(icon_state)

/obj/structure/scp216/attackby(obj/item/I, mob/user)
	if(!open)
		return ..()
	InsertItem(user, I, current_code)

/obj/structure/scp216/attack_hand(mob/user)
	tgui_interact(user)

/obj/structure/scp216/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SCP216", name)
		ui.open()

/obj/structure/scp216/tgui_data(mob/user)
	var/list/data = list()
	data["open"] = open
	data["current_code"] = add_zero(num2text(current_code, 7), 7)
	var/list/item_list = list()
	if(open && (num2text(current_code, 7) in all_codes))
		for(var/atom/movable/A in all_codes[num2text(current_code, 7)])
			item_list += list(list("name" = A.name, "ref" = "\ref[A]"))
	data["items"] = item_list
	return data

/obj/structure/scp216/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!ishuman(usr))
		return TRUE
	var/mob/living/carbon/human/user = usr

	switch(action)
		if("open")
			to_chat(user, SPAN_NOTICE("You [open ? "close" : "open"] [src]."))
			open = !open
			update_icon()
			// JUMPSCARE!!
			if(open && (num2text(current_code, 7) in all_codes))
				for(var/mob/living/L in all_codes[num2text(current_code, 7)])
					L.forceMove(get_turf(src))
					visible_message(SPAN_DANGER("[L] falls out of \the [src]!"))
			return TRUE

		if("change_code")
			if(open)
				to_chat(user, SPAN_WARNING("You have to close the safe before changing the code!"))
				return TRUE
			var/temp_code = text2num(input(user, "Enter the new code.", "SCP 216") as null|text)
			if(!isnum(temp_code))
				to_chat(user, SPAN_WARNING("Input a number!"))
				return TRUE
			if(temp_code > 9999999)
				to_chat(user, SPAN_WARNING("The code can be no longer than 7 numbers!"))
				return TRUE
			if(temp_code < 0)
				to_chat(user, SPAN_WARNING("The code can't be lower than zero!"))
				return TRUE
			current_code = temp_code
			if(!(num2text(current_code, 7) in all_codes))
				GenerateRandomItemsAt(current_code)
			return TRUE

		if("retrieve")
			var/atom/movable/A = locate(params["ref"]) in all_codes[num2text(current_code, 7)]
			if(!A)
				to_chat(user, SPAN_WARNING("Couldn't find the item."))
				return TRUE
			if(!open)
				return TRUE
			if(!in_range(src, user))
				return TRUE
			RetrieveItem(user, A, current_code)
			return TRUE
	return FALSE

/obj/structure/scp216/proc/GenerateRandomItemsAt(code)
	if(!(num2text(code, 7) in all_codes) || !islist(all_codes[num2text(code, 7)]))
		all_codes[num2text(code, 7)] = list()
	var/gen_chance = generate_chance
	var/research_tier = SCP && SCP.research ? SCP.research.research_level : 0
	// Tier unlocks: T1 +5%, T2 +10%, T3 +15%, T4 guarantees generation (dimensional insight)
	if(research_tier >= 4)
		gen_chance = 100
	else
		gen_chance += research_tier * 5
	// Resonant codes identified by research always yield contents
	if(num2text(code, 7) in resonant_codes)
		gen_chance = 100
	if(!(prob(gen_chance)))
		return
	for(var/i = 1 to rand(1, max_items_generated))
		var/chosen_atom = pickweight(random_items)
		all_codes[num2text(code, 7)] += new chosen_atom(src)

/obj/structure/scp216/proc/InsertItem(mob/living/carbon/human/user, atom/movable/A, code_loc = 0)
	if(!(num2text(code_loc, 7) in all_codes) || !islist(all_codes[num2text(code_loc, 7)]))
		all_codes[num2text(code_loc, 7)] = list()
	if(length(all_codes[num2text(code_loc, 7)]) >= max_items)
		to_chat(user, SPAN_WARNING("There is already too many things in there!"))
		return
	if(!user.unEquip(A, src))
		return
	all_codes[num2text(code_loc, 7)] += A

GLOBAL_LIST_INIT(scp216_known_codes, null)

/obj/structure/scp216/proc/build_resonant_codes()
	GLOB.scp216_known_codes = null
	resonant_codes.Cut()
	for(var/i = 1 to 12)
		resonant_codes += "[rand(0, 9999999)]"

/proc/get_scp216_known_codes(tier)
	if(!GLOB.scp216_known_codes && tier > 0)
		for(var/obj/structure/scp216/S in GLOB.SCP_list)
			if(!length(S.resonant_codes))
				S.build_resonant_codes()
			GLOB.scp216_known_codes = S.resonant_codes
			break
	if(GLOB.scp216_known_codes)
		return GLOB.scp216_known_codes.Copy(1, min(tier * 3, length(GLOB.scp216_known_codes)) + 1)
	return null

/obj/structure/scp216/proc/RetrieveItem(mob/living/carbon/human/user, atom/movable/A, code_loc = 0)
	if(!locate(A) in all_codes[num2text(code_loc, 7)])
		return
	all_codes[num2text(code_loc, 7)] -= A
	if(isitem(A))
		user.put_in_hands(A)
	else // In case we want to get funky and put mobs into it
		A.forceMove(get_turf(src))
	SStgui.update_uis(src)
