/obj/item/spacecash
	name = "0 dollars"
	desc = "It's worth 0 dollars."
	gender = PLURAL
	icon = 'icons/obj/cash.dmi'
	icon_state = "cash1"
	opacity = 0
	density = FALSE
	anchored = FALSE
	force = 1.0
	throwforce = 1.0
	throw_speed = 1
	throw_range = 2
	w_class = ITEM_SIZE_TINY
	var/access = list()
	access = ACCESS_CRATE_CASH
	var/worth = 0
	var/global/denominations = list(1000,500,200,100,50,20,10,1)

/obj/item/spacecash/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/spacecash))
		if(istype(W, /obj/item/spacecash/ewallet)) return 0

		var/obj/item/spacecash/bundle/bundle
		if(!istype(W, /obj/item/spacecash/bundle))
			var/obj/item/spacecash/cash = W
			bundle = new (src.loc)
			bundle.worth += cash.worth
			qdel(cash)
		else //is bundle
			bundle = W
		bundle.worth += src.worth
		bundle.update_icon()
		if(istype(user, /mob/living/carbon/human))
			var/mob/living/carbon/human/h_user = user
			h_user.drop_from_inventory(bundle)
			h_user.put_in_hands(bundle)
		to_chat(user, SPAN_NOTICE("You add [src.worth] [GLOB.using_map.local_currency_name] worth of money to the bundles.<br>It holds [bundle.worth] [GLOB.using_map.local_currency_name] now."))
		qdel(src)

	else if(istype(W, /obj/item/gun/launcher/money))
		var/obj/item/gun/launcher/money/L = W
		L.absorb_cash(src, user)

// 1:1 - Spawns gold, depending on the amount of cash
// Fine - Increase amount of cash in there; Has little chance (depending on amount of cash) to spawn random card.
/obj/item/spacecash/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_ONE_TO_ONE)
			var/material/material_def = SSmaterials.get_material_by_name(MATERIAL_GOLD)
			if(!material_def)
				return
			var/matter_amount = round(max(1, worth / 2000))
			material_def.place_sheet(get_turf(src), matter_amount)
			return null
		if(MODE_FINE)
			// Multiplier to the amount of cash for money to turn into other stuff
			var/transform_multiplier = 0.008
			if(prob(worth * transform_multiplier))
				var/C = pick(/obj/item/card/id/sciencelvl1, /obj/item/card/id/commslvl1)
				C = new C(get_turf(src))
				if(istype(C, /obj/item/spacecash/ewallet))
					var/obj/item/spacecash/ewallet/EC = C
					EC.worth = round(worth * pick(0.75, 0.9, 1.2, 1.5))
					EC.owner_name = user.real_name
				return C
			var/cash_multiplier = pick(1.5, 2)
			worth += round(worth * cash_multiplier)
			update_icon()
			return src
	return ..()

/obj/item/spacecash/proc/getMoneyImages()
	if(icon_state)
		return list(icon_state)

/obj/item/spacecash/bundle
	name = "pile of dollars"
	icon_state = "cash1"
	desc = "It's worth 0 dollars."
	worth = 0

/obj/item/spacecash/bundle/Initialize()
	. = ..()
	update_icon()

/obj/item/spacecash/bundle/getMoneyImages()
	. = list()
	var/sum = src.worth
	var/num = 0
	for(var/i in denominations)
		while(sum >= i && num < 10)
			sum -= i
			num++
			. += "cash[i]"
	if(num == 0) // Less than one dollar, let's just make it look like 1 for ease
		. += "cash1"

/obj/item/spacecash/bundle/on_update_icon()
	cut_overlays()
	var/list/images = src.getMoneyImages()

	icon_state = images[1]	// since images are overlayed on top of the icon, we need to use one of the images as the icon state
	images -= images[1]

	for(var/A in images)
		var/image/banknote = image('icons/obj/cash.dmi', A)
		var/matrix/M = matrix()
		M.Translate(rand(-6, 6), rand(-4, 8))
		M.Turn(pick(-90, -45, 0, 0, 0, 0, 45, 90))
		banknote.transform = M
		src.add_overlay(banknote)

	src.desc = "It's worth [worth][GLOB.using_map.local_currency_name_short]."
	if(worth in denominations)
		src.SetName("[worth] [GLOB.using_map.local_currency_name]")
	else
		src.SetName("pile of [GLOB.using_map.local_currency_name]")

	if(overlays.len <= 2)
		w_class = ITEM_SIZE_TINY
	else
		w_class = ITEM_SIZE_SMALL

/obj/item/spacecash/bundle/attack_hand(mob/user as mob)
	if (user.get_inactive_hand() == src)
		var/amount = input(usr, "How many [GLOB.using_map.local_currency_name] do you want to take? (0 to [src.worth])", "Take Money", 20) as num
		amount = round(Clamp(amount, 0, src.worth))
		if (amount==0) return 0

		src.worth -= amount
		src.update_icon()
		if (amount in list(1000,500,200,100,50,20,1))
			var/cashtype = text2path("/obj/item/spacecash/bundle/c[amount]")
			var/obj/cash = new cashtype (usr.loc)
			usr.put_in_hands(cash)
		else
			var/obj/item/spacecash/bundle/bundle = new (usr.loc)
			bundle.worth = amount
			bundle.update_icon()
			usr.put_in_hands(bundle)
		if (!worth)
			qdel(src)
	else
		..()

/obj/item/spacecash/bundle/c1
	name = "1 dollar"
	icon_state = "cash1"
	desc = "It's worth 1 dollar."
	worth = 1

/obj/item/spacecash/bundle/c10
	name = "10 dollars"
	icon_state = "cash10"
	desc = "It's worth 10 dollars."
	worth = 10

/obj/item/spacecash/bundle/c20
	name = "20 dollars"
	icon_state = "cash20"
	desc = "It's worth 20 dollars."
	worth = 20

/obj/item/spacecash/bundle/c50
	name = "50 dollars"
	icon_state = "cash50"
	desc = "It's worth 50 dollars."
	worth = 50

/obj/item/spacecash/bundle/c100
	name = "100 dollars"
	icon_state = "cash100"
	desc = "It's worth 100 dollars."
	worth = 100

/obj/item/spacecash/bundle/c200
	name = "200 dollars"
	icon_state = "cash200"
	desc = "It's worth 200 dollars."
	worth = 200

/obj/item/spacecash/bundle/c500
	name = "500 dollars"
	icon_state = "cash500"
	desc = "It's worth 500 dollars."
	worth = 500

/obj/item/spacecash/bundle/c1000
	name = "1000 dollars"
	icon_state = "cash1000"
	desc = "It's worth 1000 dollars."
	worth = 1000

/proc/spawn_money(sum, spawnloc, mob/living/carbon/human/human_user as mob)
	if(sum in list(1000,500,200,100,50,20,10,1))
		var/cash_type = text2path("/obj/item/spacecash/bundle/c[sum]")
		var/obj/cash = new cash_type (usr.loc)
		if(ishuman(human_user) && !human_user.get_active_hand())
			human_user.put_in_hands(cash)
	else
		var/obj/item/spacecash/bundle/bundle = new (spawnloc)
		bundle.worth = sum
		bundle.update_icon()
		if (ishuman(human_user) && !human_user.get_active_hand())
			human_user.put_in_hands(bundle)
	return

/obj/item/spacecash/ewallet
	name = "Charge card"
	icon_state = "efundcard"
	desc = "A card that holds an amount of money."
	var/owner_name = "" //So the ATM can set it so the EFTPOS can put a valid name on transactions.

/obj/item/spacecash/ewallet/examine(mob/user, distance)
	. = ..(user)
	if (distance > 2 && user != loc) return
	to_chat(user, SPAN_NOTICE("Charge card's owner: [src.owner_name]. [GLOB.using_map.local_currency_name] remaining: [src.worth]."))
