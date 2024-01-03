// Power Cells
/obj/item/cell
	name = "power cell"
	desc = "A rechargable electrochemical power cell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_state = "cell"
	origin_tech = list(TECH_POWER = 1)
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = ITEM_SIZE_NORMAL
	var/charge			                // Current charge
	var/maxcharge = 1000 // Capacity in Wh
	var/overlay_state
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 50, MATERIAL_PLASTIC = 20)

/obj/item/cell/Initialize()
	. = ..()
	if(type == /obj/item/cell)
		crash_with("Invalid use of cell base type")
		return INITIALIZE_HINT_QDEL
	if(isnull(charge))
		charge = maxcharge
	update_icon()

/obj/item/cell/drain_power(drain_check, surge, power = 0)

	if(drain_check)
		return 1

	if(charge <= 0)
		return 0

	var/cell_amt = power * CELLRATE

	return use(cell_amt) / CELLRATE

/obj/item/cell/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(95 to 100)
			new_overlay_state = "cell-o2"
		if(25 to 95)
			new_overlay_state = "cell-o1"
		if(0.05 to 25)
			new_overlay_state = "cell-o0"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		cut_overlays()
		if(overlay_state)
			add_overlay(image('icons/obj/power.dmi', overlay_state))

/obj/item/cell/proc/percent()		// return % charge of cell
	return maxcharge && (100.0*charge/maxcharge)

/obj/item/cell/proc/fully_charged()
	return (charge == maxcharge)

// checks if the power cell is able to provide the specified amount of charge
/obj/item/cell/proc/check_charge(amount)
	return (charge >= amount)

// use power from a cell, returns the amount actually used
/obj/item/cell/proc/use(amount)
	var/used = min(charge, amount)
	charge -= used
	update_icon()
	return used

// Checks if the specified amount can be provided. If it can, it removes the amount
// from the cell and returns 1. Otherwise does nothing and returns 0.
/obj/item/cell/proc/checked_use(amount)
	if(!check_charge(amount))
		return 0
	use(amount)
	return 1

/obj/item/cell/proc/give(amount)
	var/amount_used = min(maxcharge-charge,amount)
	charge += amount_used
	update_icon()
	return amount_used

/obj/item/cell/examine(mob/user)
	. = ..()
	to_chat(user, "The label places its capacity at [maxcharge] Wh.")
	to_chat(user, "Its charge meter is at [round(percent(), 0.1)]%.")

/obj/item/cell/emp_act(severity)
	//remove this once emp changes on dev are merged in
	if(isrobot(loc))
		var/mob/living/silicon/robot/R = loc
		severity *= R.cell_emp_mult

	// Lose 1/2, 1/4, 1/6 of the current charge per hit or 1/4, 1/8, 1/12 of the max charge per hit, whichever is highest
	charge -= max(charge / (2 * severity), maxcharge/(4 * severity))
	if (charge < 0)
		charge = 0
	..()


/obj/item/cell/proc/get_electrocute_damage()
	switch (charge)
		if (1000000 to INFINITY)
			return min(rand(50,160),rand(50,160))
		if (200000 to 1000000-1)
			return min(rand(25,80),rand(25,80))
		if (100000 to 200000-1)//Ave powernet
			return min(rand(20,60),rand(20,60))
		if (50000 to 100000-1)
			return min(rand(15,40),rand(15,40))
		if (1000 to 50000-1)
			return min(rand(10,20),rand(10,20))
		else
			return 0

/obj/item/cell/get_cell()
	return src //no shit Sherlock

// SUBTYPES BELOW

// Smaller variant, used by energy guns and similar small devices.
/obj/item/cell/device
	name = "device power cell"
	desc = "A small power cell designed to power handheld devices."
	icon_state = "device"
	w_class = ITEM_SIZE_SMALL
	force = 0
	throw_speed = 5
	throw_range = 7
	maxcharge = 100
	matter = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 5)

/obj/item/cell/device/Initialize()
	. = ..()
	if (type == /obj/item/cell/device)
		return INITIALIZE_HINT_QDEL

/obj/item/cell/device/variable/Initialize(mapload, charge_amount)
	maxcharge = charge_amount
	return ..(mapload)

/obj/item/cell/device/standard
	name = "standard device power cell"
	maxcharge = 25

/obj/item/cell/device/high
	name = "advanced device power cell"
	desc = "A small power cell designed to power more energy-demanding devices."
	icon_state = "hdevice"
	maxcharge = 100
	matter = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 6)

/obj/item/cell/crap
	name = "old power cell"
	desc = "A cheap old power cell. It's probably been in use for quite some time now."
	origin_tech = list(TECH_POWER = 0)
	maxcharge = 100
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 40, MATERIAL_PLASTIC = 20)

/obj/item/cell/crap/empty
	charge = 0

/obj/item/cell/standard
	name = "standard power cell"
	desc = "A standard and relatively cheap power cell, commonly used."
	origin_tech = list(TECH_POWER = 0)
	maxcharge = 500
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 40, MATERIAL_PLASTIC = 20)

/obj/item/cell/high
	name = "advanced power cell"
	desc = "An advanced high-grade power cell, for use in important systems."
	origin_tech = list(TECH_POWER = 2)
	icon_state = "hcell"
	maxcharge = 1000
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 60, MATERIAL_PLASTIC = 20)

/obj/item/cell/high/empty
	charge = 0

/obj/item/cell/super
	name = "enhanced power cell"
	desc = "A very advanced power cell with increased energy density, for use in critical applications."
	origin_tech = list(TECH_POWER = 5)
	icon_state = "scell"
	maxcharge = 2000
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 70, MATERIAL_ALUMINIUM = 20)

/obj/item/cell/super/empty
	charge = 0

/obj/item/cell/hyper
	name = "superior power cell"
	desc = "Pinnacle of power storage technology, this very expensive power cell provides the best energy density reachable with conventional electrochemical cells."
	origin_tech = list(TECH_POWER = 6)
	icon_state = "hpcell"
	maxcharge = 3000
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 80, MATERIAL_ALUMINIUM = 20)

/obj/item/cell/hyper/empty
	charge = 0

/obj/item/cell/hyper/adherent
	name = "crystal-ceramic grid"
	desc = "A dense, smooth blue polygon the size of a clenched fist. It's etched with symmetrical facets that are filled with a thick, gelatinous material."
	icon = 'icons/mob/human_races/species/adherent/organs.dmi'
	icon_state = "cell"

/obj/item/cell/infinite
	name = "experimental power cell"
	desc = "This special experimental power cell has both very large capacity, and ability to recharge itself by draining power from contained bluespace pocket."
	icon_state = "icell"
	origin_tech =  null
	maxcharge = 3000
	matter = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 80, MATERIAL_ALUMINIUM = 20)

/obj/item/cell/infinite/check_charge()
	return 1

/obj/item/cell/infinite/use(amount)
	return amount


/obj/item/cell/potato
	name = "potato battery"
	desc = "A rechargable starch based power cell."
	origin_tech = list(TECH_POWER = 1)
	icon = 'icons/obj/power.dmi' //'icons/obj/harvest.dmi'
	icon_state = "potato_cell" //"potato_battery"
	maxcharge = 20


/obj/item/cell/slime
	name = "charged slime core"
	desc = "A yellow slime core infused with phoron, it crackles with power."
	origin_tech = list(TECH_POWER = 2, TECH_BIO = 4)
	icon = 'icons/mob/simple_animal/slimes.dmi' //'icons/obj/harvest.dmi'
	icon_state = "yellow slime extract" //"potato_battery"
	maxcharge = 200
	matter = null

// Self-charging power cell.
/obj/item/cell/mantid
	name = "mantid microfusion plant"
	desc = "An impossibly tiny fusion reactor of mantid design."
	icon = 'icons/obj/ascent.dmi'
	icon_state = "plant"
	maxcharge = 1500
	w_class = ITEM_SIZE_NORMAL
	var/recharge_amount = 12

/obj/item/cell/mantid/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/item/cell/mantid/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/cell/mantid/Process()
	if(charge < maxcharge)
		give(recharge_amount)

// Coarse - returns cell with worse max charge, or reduces charge of itself
// Fine - returns cell with better max charge, charges itself a bit, or EXPLODES(with low chance)!
// Very fine - returns cell with much better max charge, fully charges, upgrades, or EXPLODES(with high chance)!
/obj/item/cell/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_COARSE)
			if(prob(50))
				var/list/potential_cells
				for(var/thing in subtypesof(/obj/item/cell) - /obj/item/cell/infinite)
					var/obj/item/cell/C = thing
					if(initial(C.maxcharge) < maxcharge)
						potential_cells += C
				if(LAZYLEN(potential_cells))
					playsound(src, 'sounds/machines/synth_no.ogg', 50, TRUE)
					return pick(potential_cells)
			use(maxcharge * pick(0.2, 0.3, 0.4))
			playsound(src, 'sounds/effects/sparks3.ogg', 50, TRUE)
			return src
		if(MODE_FINE)
			if(prob(maxcharge * 0.002))
				explosion(get_turf(src), -1, -1, 2, 4, FALSE)
				return null
			if(prob(50))
				var/list/potential_cells
				for(var/thing in subtypesof(/obj/item/cell) - /obj/item/cell/infinite)
					var/obj/item/cell/C = thing
					if(initial(C.maxcharge) > maxcharge && initial(C.maxcharge) <= maxcharge * 2)
						potential_cells += C
				if(LAZYLEN(potential_cells))
					playsound(src, 'sounds/machines/synth_yes.ogg', 50, TRUE)
					return pick(potential_cells)
			give(maxcharge * pick(0.3, 0.4, 0.5))
			playsound(src, 'sounds/effects/sparks3.ogg', 50, TRUE)
			return src
		if(MODE_VERY_FINE)
			if(prob(maxcharge * 0.01)) // It's a VERY HIGH chance to explode
				explosion(get_turf(src), -1, prob(20), 4, 7, FALSE)
				return null
			if(prob(50))
				var/list/potential_cells
				for(var/thing in subtypesof(/obj/item/cell))
					var/obj/item/cell/C = thing
					if(initial(C.maxcharge) > maxcharge && initial(C.maxcharge) <= maxcharge * 4)
						potential_cells += C
				if(LAZYLEN(potential_cells))
					playsound(src, 'sounds/machines/synth_yes.ogg', 50, TRUE)
					return pick(potential_cells)
			if(prob(50)) // Upgrade!
				maxcharge += clamp(maxcharge * pick(0.25, 0.5), 100, 1000)
				playsound(src, 'sounds/magic/charge.ogg', 50, TRUE, 7)
				color = COLOR_BLUE_LIGHT
				name = "weird [initial(name)]"
				desc = "[initial(desc)] It has a weird blue tint."
				return src
			give(maxcharge)
			return src
	return ..()

