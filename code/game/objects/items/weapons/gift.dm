/*
 * Gifts from the xmas tree
 */

GLOBAL_LIST_EMPTY(any_possible_gifts)

/obj/item/a_gift
	name = "gift"
	desc = "PRESENTS!!!! eek!"
	icon = 'icons/obj/items.dmi'
	icon_state = "gift1"
	item_state = "gift"
	randpixel = 10
	var/obj/item/contains_type

/obj/item/a_gift/Initialize()
	. = ..()
	contains_type = get_gift_type()
	if(initial(contains_type.w_class) > 0)
		var/gift_size = min(initial(contains_type.w_class), 5)
		icon_state = "gift[gift_size]"
		w_class = gift_size

/obj/item/a_gift/examine(mob/M)
	. = ..()
	if(istype(M, /mob/observer) || check_rights(show_msg=FALSE, C = M))
		to_chat(M, "It contains \a [initial(contains_type.name)].")

/obj/item/a_gift/attack_self(mob/M)
	qdel(src)

	var/obj/item/I = new contains_type(get_turf(M))
	M.visible_message(SPAN_NOTICE("[M] unwraps \the [src], finding \a [I] inside!"))
	M.put_in_hands(I)
	I.add_fingerprint(M)

/obj/item/a_gift/proc/get_gift_type()
	var/gift_type_list = list(
		/obj/item/storage/wallet,
		/obj/item/storage/photo_album,
		/obj/item/storage/box/snappops,
		/obj/item/storage/fancy/crayons,
		/obj/item/storage/backpack/holding,
		/obj/item/storage/belt/champion,
		/obj/item/storage/box/large/foam_gun,
		/obj/item/storage/box/large/foam_gun/burst,
		/obj/item/storage/box/large/foam_gun/revolver,
		/obj/item/pickaxe/silver,
		/obj/item/pen/invisible,
		/obj/item/lipstick/random,
		/obj/item/grenade/smokebomb,
		/obj/item/carvable/corncob,
		/obj/item/contraband/poster,
		/obj/item/book/manual/barman_recipes,
		/obj/item/book/manual/chef_recipes,
		/obj/item/bikehorn,
		/obj/item/beach_ball,
		/obj/item/beach_ball/holoball,
		/obj/item/gun/projectile/revolver/capgun,
		/obj/item/reagent_containers/food/snacks/grown/ambrosiadeus,
		/obj/item/reagent_containers/food/snacks/grown/ambrosiavulgaris,
		/obj/item/device/paicard,
		/obj/item/device/synthesized_instrument/violin,
		/obj/item/storage/belt/utility/full,
		/obj/item/clothing/under/pirate,
		/obj/item/clothing/under/soviet,
		/obj/item/clothing/under/redcoat,
		/obj/item/clothing/under/gladiator,
		/obj/item/clothing/accessory/horrible,
		/obj/item/clothing/accessory/red,
		/obj/item/clothing/accessory/red_long,
		/obj/item/clothing/accessory/blue,
		/obj/item/clothing/head/kitty,
		/obj/item/clothing/head/pirate,
		/obj/item/clothing/head/bandana,
		/obj/item/clothing/head/bowlerhat,
		/obj/item/clothing/head/fedora,
		/obj/item/clothing/head/fez,
		/obj/item/inflatable_duck,
		/obj/item/marshalling_wand,
		)

	// Any toys, except for balloons and 'master' types
	gift_type_list += subtypesof(/obj/item/toy) - (typesof(/obj/item/toy/balloon) + /obj/item/toy/prize + /obj/item/toy/figure + /obj/item/toy/plushie + /obj/item/toy/desk)
	// Colored jumpsuits
	gift_type_list += subtypesof(/obj/item/clothing/under/color)
	// Collectable hats
	gift_type_list += subtypesof(/obj/item/clothing/head/collectable)


	var/gift_type = pick(gift_type_list)

	return gift_type

/* A gift that can contain ANY item */
/obj/item/a_gift/anything
	name = "christmas gift"
	desc = "It could be anything!"

/obj/item/a_gift/anything/get_gift_type()
	if(!GLOB.any_possible_gifts.len)
		var/list/gift_types_list = subtypesof(/obj/item) // Madness
		for(var/V in gift_types_list)
			var/obj/item/I = V
			if(!initial(I.icon_state) || initial(I.anchored) || !initial(I.mouse_opacity) || (initial(I.w_class) >= ITEM_SIZE_NO_CONTAINER) || (initial(I.w_class) <= 0))
				gift_types_list -= V
		GLOB.any_possible_gifts = gift_types_list
	var/gift_type = pick(GLOB.any_possible_gifts)

	return gift_type
