/obj/item/gun/energy
	name = "energy gun"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/guns/basic_energy.dmi'
	icon_state = "energy"
	fire_sound = 'sounds/weapons/Taser.ogg'
	fire_sound_text = "laser blast"
	accuracy = 1

	var/obj/item/cell/power_supply //What type of power cell this uses
	var/charge_cost = 20 //How much energy is needed to fire.
	var/max_shots = 10 //Determines the capacity of the weapon's power cell. Specifying a cell_type overrides this value.
	var/cell_type = null
	var/projectile_type = /obj/item/projectile/beam/practice
	var/modifystate
	var/charge_meter = 1	//if set, the icon state will be chosen based on the current charge

	//self-recharging
	var/self_recharge = 0	//if set, the weapon will recharge itself
	var/use_external_power = 0 //if set, the weapon will look for an external power source to draw from, otherwise it recharges magically
	var/recharge_time = 4
	var/charge_tick = 0

/obj/item/gun/energy/switch_firemodes()
	. = ..()
	if(.)
		update_icon()

/obj/item/gun/energy/emp_act(severity)
	..()
	update_icon()

/obj/item/gun/energy/Initialize()
	. = ..()
	if(cell_type)
		power_supply = new cell_type(src)
	else
		power_supply = new /obj/item/cell/device/variable(src, max_shots*charge_cost)
	if(self_recharge)
		START_PROCESSING(SSobj, src)
	update_icon()

/obj/item/gun/energy/Destroy()
	if(self_recharge)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/gun/energy/get_cell()
	return power_supply

/obj/item/gun/energy/Process()
	if(self_recharge) //Every [recharge_time] ticks, recharge a shot for the cyborg
		charge_tick++
		if(charge_tick < recharge_time) return 0
		charge_tick = 0

		if(!power_supply || power_supply.charge >= power_supply.maxcharge)
			return 0 // check if we actually need to recharge

		if(use_external_power)
			var/obj/item/cell/external = get_external_power_supply()
			if(!external || !external.use(charge_cost)) //Take power from the borg...
				return 0

		power_supply.give(charge_cost) //... to recharge the shot
		update_icon()
	return 1

/obj/item/gun/energy/consume_next_projectile()
	if(!power_supply) return null
	if(!ispath(projectile_type)) return null
	if(!power_supply.checked_use(charge_cost)) return null
	return new projectile_type(src)

/obj/item/gun/energy/proc/get_external_power_supply()
	if(isrobot(loc) || istype(loc, /obj/item/rig_module) || istype(loc, /obj/item/mech_equipment))
		return loc.get_cell()

/obj/item/gun/energy/examine(mob/user)
	. = ..(user)
	if(!power_supply)
		to_chat(user, "Seems like it's dead.")
		return
	if (charge_cost == 0)
		to_chat(user, "This gun seems to have an unlimited number of shots.")
	else
		var/shots_remaining = round(power_supply.charge / charge_cost)
		to_chat(user, "Has [shots_remaining] shot\s remaining.")

/obj/item/gun/energy/on_update_icon()
	..()
	if(charge_meter && power_supply)
		var/ratio = power_supply.percent()

		//make sure that rounding down will not give us the empty state even if we have charge for a shot left.
		// Also make sure cells adminbussed with higher-than-max charge don't break sprites
		if(power_supply.charge < charge_cost)
			ratio = 0
		else
			ratio = Clamp(round(ratio, 25), 25, 100)

		if(modifystate)
			icon_state = "[modifystate][ratio]"
		else
			icon_state = "[initial(icon_state)][ratio]"
		update_held_icon()

GLOBAL_LIST_INIT(banned_914_energy_guns, list(
	/obj/item/gun/energy/pulse_rifle/destroyer,
	/obj/item/gun/energy/meteorgun,
	/obj/item/gun/energy/meteorgun/pen
	))

// Coarse - Returns random gun with lower max_shots or damage
// 1:1 - Returns random gun with similar max_shots value and similar projectile damage
// Fine or Very Fine - Returns random gun with higher max_shots, higher damage or self-recharging
/obj/item/gun/energy/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_COARSE)
			var/list/potential_return
			for(var/thing in (subtypesof(/obj/item/gun/energy) - GLOB.banned_914_energy_guns))
				var/obj/item/gun/energy/G = thing
				if(initial(G.max_shots) < max_shots * 0.8)
					potential_return += G
				var/obj/item/projectile/P = initial(G.projectile_type)
				var/obj/item/projectile/our_proj = projectile_type
				if(initial(P.damage) < initial(our_proj.damage) * 0.8)
					potential_return += G
			if(!LAZYLEN(potential_return))
				return src
			return pick(potential_return)
		if(MODE_ONE_TO_ONE)
			var/list/potential_return = list()
			for(var/thing in (subtypesof(/obj/item/gun/energy) - GLOB.banned_914_energy_guns))
				var/obj/item/gun/energy/G = thing
				if(initial(G.max_shots) > max_shots * 1.25 || initial(G.max_shots) < max_shots * 0.75)
					continue
				var/obj/item/projectile/P = initial(G.projectile_type)
				var/obj/item/projectile/our_proj = projectile_type
				if(initial(P.damage) > initial(our_proj.damage) * 1.25 || initial(P.damage) < initial(our_proj.damage) * 0.75)
					continue
				potential_return += G
			if(!LAZYLEN(potential_return))
				return src
			return pick(potential_return)
		if(MODE_FINE, MODE_VERY_FINE)
			var/mult_mod = (mode == MODE_VERY_FINE ? 2 : 1)
			if(prob(mult_mod ** 2))
				empulse(get_turf(src), 2, 5)
				return null
			var/list/potential_return = list()
			for(var/thing in (subtypesof(/obj/item/gun/energy) - GLOB.banned_914_energy_guns))
				var/obj/item/gun/energy/G = thing
				if(initial(G.max_shots) > max_shots * 1.25 * mult_mod && initial(G.max_shots) < max_shots * 2 * mult_mod)
					potential_return += G
				var/obj/item/projectile/P = initial(G.projectile_type)
				var/obj/item/projectile/our_proj = projectile_type
				if(initial(P.damage) > initial(our_proj.damage) * 1.25 * mult_mod && initial(P.damage) < initial(our_proj.damage) * 2 * mult_mod)
					potential_return += G
				if(initial(G.self_recharge) && !self_recharge && prob(33))
					potential_return += G
			if(!LAZYLEN(potential_return))
				return src
			return pick(potential_return)
	return ..()
