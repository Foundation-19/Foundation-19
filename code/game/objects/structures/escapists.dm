/obj/structure/phonebooth
	name = "phone booth"
	desc = "A phone booth the Class-Ds use, it looks a little... off. There's a <span class='notice'>bluespace teleportation device rigged up to it.</span>"
	icon = 'icons/obj/escapists.dmi'
	icon_state = "phone"
	layer = 2.9
	anchored = TRUE
	density = FALSE
	var/cashainside = 0
	var/list/buyables = list(
		/obj/item/handcuffs,
		/obj/item/material/knife/kitchen,
		/obj/item/reagent_containers/glass/beaker/thermite,
		/obj/item/gun/projectile/revolver/holdout,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/flame/lighter/random,
		/obj/item/flame/lighter/zippo/random,
		/obj/item/reagent_containers/pill/tramadol,
		/obj/item/reagent_containers/pill/bicaridine,
		/obj/item/bananapeel
	)

/obj/structure/phonebooth/attackby(obj/item/spacecash/O, mob/user)
	. = ..()
	if(istype(O, /obj/item/spacecash/bundle))
		qdel(O)
		src.cashainside += O.worth
		to_chat(user, SPAN_NOTICE("You insert the [O] into the [src]."))
	return

/obj/structure/phonebooth/AltClick(mob/user)
	. = ..()
	if(src.cashainside >= 10)
		cashainside -= 10
		new /obj/item/spacecash/bundle/c10(get_turf(src))
		to_chat(user, SPAN_NOTICE("You eject 10 dollars from the [src]."))
	return

/obj/structure/phonebooth/attack_hand(mob/living/user)
	. = ..()
	var/randomgooditem = pick(buyables)
	if(user.mind.assigned_role == "Class D")
		if(src.cashainside > 0)
			if(src.cashainside >= 30)
				src.cashainside -= 30
				new randomgooditem(get_turf(src))
				to_chat(user, SPAN_NOTICE("Item dispensed, have a nice day."))
			else
				to_chat(user, SPAN_WARNING("ERR: Please insert more capital."))
	else
		user.visible_message(SPAN_WARNING("[src] buzzes!"))
	return

/obj/item/reagent_containers/glass/beaker/thermite
	name = "suspicious beaker"
	desc = "There's a paper label glued to the beaker, it says 'SPLASH & BURN'."

/obj/item/reagent_containers/glass/beaker/thermite/New()
	..()
	reagents.add_reagent(/datum/reagent/thermite, 30)
	update_icon()
