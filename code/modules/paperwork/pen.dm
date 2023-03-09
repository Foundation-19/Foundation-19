/* Pens!
 * Contains:
 *		Pens
 *		Sleepy Pens
 *		Parapens
 */


/*
 * Pens
 */
/obj/item/weapon/pen
	desc = "It's a normal black ink pen."
	name = "pen"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 0
	w_class = ITEM_SIZE_TINY
	throw_speed = 7
	throw_range = 15
	matter = list(DEFAULT_WALL_MATERIAL = 10)
	var/colour = "black"	//what colour the ink is!


/obj/item/weapon/pen/blue
	desc = "It's a normal blue ink pen."
	icon_state = "pen_blue"
	colour = "blue"

/obj/item/weapon/pen/red
	desc = "It's a normal red ink pen."
	icon_state = "pen_red"
	colour = "red"

/obj/item/weapon/pen/multi
	desc = "It's a pen with multiple colors of ink!"
	var/selectedColor = 1
	var/colors = list("black","blue","red")

/obj/item/weapon/pen/multi/attack_self(mob/user)
	if(++selectedColor > 3)
		selectedColor = 1

	colour = colors[selectedColor]

	if(colour == "black")
		icon_state = "pen"
	else
		icon_state = "pen_[colour]"

	to_chat(user, SPAN_NOTICE("Changed color to '[colour].'"))

/obj/item/weapon/pen/invisible
	desc = "It's an invisble pen marker."
	icon_state = "pen"
	colour = "white"


/obj/item/weapon/pen/attack(mob/M as mob, mob/user as mob)
	if(!ismob(M))
		return
	to_chat(user, SPAN_WARNING("You stab [M] with the pen."))
	admin_attack_log(user, M, "Stabbed using \a [src]", "Was stabbed with \a [src]", "used \a [src] to stab")

	return

/*
 * Reagent pens
 */

/obj/item/weapon/pen/reagent
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	origin_tech = list(TECH_MATERIAL = 2, TECH_ESOTERIC = 5)

/obj/item/weapon/pen/reagent/New()
	..()
	create_reagents(30)

/obj/item/weapon/pen/reagent/attack(mob/living/M, mob/user, target_zone)

	if(!istype(M))
		return

	. = ..()

	if(M.can_inject(user, target_zone))
		if(reagents.total_volume)
			if(M.reagents)
				var/contained_reagents = reagents.get_reagents()
				var/trans = reagents.trans_to_mob(M, 30, CHEM_BLOOD)
				admin_inject_log(user, M, src, contained_reagents, trans)

/*
 * Sleepy Pens
 */
/obj/item/weapon/pen/reagent/sleepy
	desc = "It's a black ink pen with a sharp point and a carefully engraved \"Waffle Co.\"."
	origin_tech = list(TECH_MATERIAL = 2, TECH_ESOTERIC = 5)

/obj/item/weapon/pen/reagent/sleepy/New()
	..()
	reagents.add_reagent(/datum/reagent/chloralhydrate, 15)	//Used to be 100 sleep toxin//30 Chloral seems to be fatal, reducing it to 22, reducing it further to 15 because fuck you OD code./N

/*
 * Crayons
 */

/obj/item/weapon/pen/crayon
	name = "crayon"
	desc = "A colourful crayon. Please refrain from eating it or putting it in your nose."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonred"
	w_class = ITEM_SIZE_TINY
	attack_verb = list("attacked", "coloured")
	colour = "#ff0000" //RGB
	var/shadeColour = "#220000" //RGB
	var/uses = 30 //0 for unlimited uses
	var/instant = 0
	var/colourName = "red" //for updateIcon purposes

	New()
		name = "[colourName] crayon"
		..()
