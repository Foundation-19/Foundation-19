/**
 * Delivery locker for mining, earns cash for materials sent.
 */
/obj/machinery/delivery_locker/materials
	name = "material delivery locker"
	desc = "Drop materials in here; get paid!"
	icon = 'icons/obj/pipes/delivery.dmi'
	icon_state = "materials"
	acceptable_items = list(/obj/item/ore)

// TODO: program for cargo to manage ore prices
/obj/machinery/delivery_locker/materials/handle_id_card(obj/item/card/id/id_card)
	var/total_cost = 0

	for(var/thing in (contents - component_parts))
		var/obj/item/ore/ore = thing

		if(!istype(ore))
			crash_with("[ore.type] isn't /obj/item/ore!")

		total_cost += ore.material.sale_price * 0.5	// d-class only get half the materials value

	if(total_cost >= SSsupply.points)
		display_error("not enough funds available!")
		return

	var/datum/money_account/account = get_account(id_card.associated_account_number)
	if(!account)
		display_error("account doesn't exist!")
		return
	if(account.suspended)
		display_error("account suspended!")
		return
	if(!account.deposit(total_cost, "Sold ore to logistics", name))
		display_error("cant deposit!")
		return

	SSsupply.points -= total_cost

	return TRUE

/obj/machinery/delivery_locker/MouseDrop_T(atom/movable/AM, mob/user)
	if(istype(AM, /obj/structure/ore_box))
		var/obj/structure/ore_box/OB = AM
		for(var/obj/item/ore/ore in OB)
			attackby(ore, user)
		OB.update_ore_count()
		return

	return ..()
