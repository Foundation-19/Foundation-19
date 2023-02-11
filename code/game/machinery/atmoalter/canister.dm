#define CANISTER_FLAG_HASTANK 			(1<<0)
#define CANISTER_FLAG_ISCONNECTED 		(1<<1)
#define CANISTER_FLAG_PRESSURE_VERYLOW 	(1<<2)
#define CANISTER_FLAG_PRESSURE_LOW 		(1<<3)
#define CANISTER_FLAG_PRESSURE_HIGH 	(1<<4)
#define CANISTER_FLAG_PRESSURE_VERYHIGH (1<<5)

/obj/machinery/portable_atmospherics/canister
	name = "gas canister \[CAUTION\]"
	desc = "A semi-portable canister for holding pressurized gases."
	icon = 'icons/obj/atmos.dmi'
	icon_state = "yellow"
	density = TRUE
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	w_class = ITEM_SIZE_GARGANTUAN
	construct_state = null

	start_pressure = 45 * ONE_ATMOSPHERE
	volume = 1000
	interact_offline = TRUE // Allows this to be used when not in powered area.

	var/health = 100.0
	var/valve_open = FALSE
	var/release_pressure = ONE_ATMOSPHERE
	var/release_flow_rate = ATMOS_DEFAULT_VOLUME_PUMP //in L/s
	var/temperature_resistance = 1000 + T0C

	var/canister_color = "yellow"
	var/can_label = TRUE

	/// Bitflag containing information about this canister's status (wrenched, pressure, etc.) See defines in canister.dm for more details.
	var/update_flag = 0
	/// Associative list of gases for this canister to begin with and the moles to have. A negative value will fill the tank to its starting pressure with the gas.
	var/list/initial_gases = list()
	/// A temperature in Kelvin for this canister's air contents to begin with. Use this for pre-chilled gases.
	var/initial_temperature

/obj/machinery/portable_atmospherics/canister/LateInitialize(mapload)
	. = ..(mapload)
	if (prob(1))
		desc += " Does not hold GAS." // huhuhu
	if (!mapload) // Call gas creation after normal init if we're midround - otherwise, we'll runtime and have no gases
		addtimer(CALLBACK(src, .proc/create_initial_gases), 0)
	else
		create_initial_gases()

/// Fills this canister with gas based on its subtype's initial_gases list. Should only happen during initial creation.
/obj/machinery/portable_atmospherics/canister/proc/create_initial_gases()
	if (initial_gases?.len)
		for (var/gas_id in initial_gases)
			air_contents.adjust_gas(gas_id, initial_gases[gas_id] < 0 ? MolesForPressure() : initial_gases[gas_id])
	if (initial_temperature)
		air_contents.temperature = initial_temperature
	update_icon()

/obj/machinery/portable_atmospherics/canister/drain_power()
	return -1

/obj/machinery/portable_atmospherics/canister/examine(mob/user)
	. = ..()
	if (health >= initial(health))
		to_chat(user, SPAN_NOTICE("It looks to be in good condition."))
	else
		if (!destroyed)
			var/ratio = health / initial(health)
			if (ratio >= 0.6)
				to_chat(user, SPAN_WARNING("It looks slightly damaged."))
			else if (ratio >= 0.3)
				to_chat(user, SPAN_WARNING("It looks heavily damaged."))
			else
				to_chat(user, SPAN_WARNING("<b>It's on the verge of falling apart!</b>"))
		else
			to_chat(user, "It has been ruptured.")

/obj/machinery/portable_atmospherics/canister/sleeping_agent
	name = "gas canister \[N2O\]"
	icon_state = "redws"
	canister_color = "redws"
	can_label = FALSE
	initial_gases = list(
		GAS_N2O = -1
	)

/obj/machinery/portable_atmospherics/canister/nitrogen
	name = "gas canister \[N2\]"
	icon_state = "red"
	canister_color = "red"
	can_label = FALSE
	initial_gases = list(
		GAS_NITROGEN = -1
	)

/obj/machinery/portable_atmospherics/canister/nitrogen/prechilled
	name = "gas canister \[N2 (Cooling)\]"
	initial_temperature = 80

/obj/machinery/portable_atmospherics/canister/oxygen
	name = "gas canister \[O2\]"
	icon_state = "blue"
	canister_color = "blue"
	can_label = FALSE
	initial_gases = list(
		GAS_OXYGEN = -1
	)

/obj/machinery/portable_atmospherics/canister/oxygen/prechilled
	name = "gas canister \[O2 (Cryo)\]"
	start_pressure = 20 * ONE_ATMOSPHERE
	initial_temperature = 80

/obj/machinery/portable_atmospherics/canister/hydrogen
	name = "gas canister \[Hydrogen\]"
	icon_state = "purple"
	canister_color = "purple"
	can_label = FALSE
	initial_gases = list(
		GAS_HYDROGEN = -1
	)

/obj/machinery/portable_atmospherics/canister/phoron
	name = "gas canister \[Phoron\]"
	icon_state = "orange"
	canister_color = "orange"
	can_label = FALSE
	initial_gases = list(
		GAS_PHORON = -1
	)

/obj/machinery/portable_atmospherics/canister/carbon_dioxide
	name = "gas canister \[CO2\]"
	icon_state = "black"
	canister_color = "black"
	can_label = FALSE
	initial_gases = list(
		GAS_CO2 = -1
	)

/obj/machinery/portable_atmospherics/canister/air
	name = "gas canister \[Air\]"
	icon_state = "grey"
	canister_color = "grey"
	can_label = FALSE
	// We don't have an initial_gases defined here because this is a mix of gases instead. Check the create_initial_gases() for details

/obj/machinery/portable_atmospherics/canister/air/create_initial_gases()
	var/list/air_mix = StandardAirMix()
	air_contents.adjust_multi(GAS_OXYGEN, air_mix[GAS_OXYGEN], GAS_NITROGEN, air_mix[GAS_NITROGEN])
	update_icon()

/obj/machinery/portable_atmospherics/canister/helium
	name = "gas canister \[Helium\]"
	icon_state = "black"
	canister_color = "black"
	can_label = FALSE
	initial_gases = list(
		GAS_HELIUM = -1
	)

/obj/machinery/portable_atmospherics/canister/methyl_bromide
	name = "gas canister \[Methyl Bromide\]"
	icon_state = "black"
	canister_color = "black"
	can_label = FALSE
	initial_gases = list(
		GAS_METHYL_BROMIDE = -1
	)

/obj/machinery/portable_atmospherics/canister/chlorine
	name = "gas canister \[Chlorine\]"
	icon_state = "black"
	canister_color = "black"
	can_label = FALSE
	initial_gases = list(
		GAS_CHLORINE = -1
	)

/obj/machinery/portable_atmospherics/canister/air/airlock
	start_pressure = 3 * ONE_ATMOSPHERE



/// Empty canister subtypes. These will start with no gas but will take the appearance of the defined canister_type.
/obj/machinery/portable_atmospherics/canister/empty
	start_pressure = 0
	can_label = TRUE
	var/obj/machinery/portable_atmospherics/canister/canister_type = /obj/machinery/portable_atmospherics/canister

/obj/machinery/portable_atmospherics/canister/empty/LateInitialize()
	. = ..()
	name = 	initial(canister_type.name)
	icon_state = initial(canister_type.icon_state)
	canister_color = initial(canister_type.canister_color)

/obj/machinery/portable_atmospherics/canister/empty/air
	icon_state = "grey"
	canister_type = /obj/machinery/portable_atmospherics/canister/air

/obj/machinery/portable_atmospherics/canister/empty/oxygen
	icon_state = "blue"
	canister_type = /obj/machinery/portable_atmospherics/canister/oxygen

/obj/machinery/portable_atmospherics/canister/empty/phoron
	icon_state = "orange"
	canister_type = /obj/machinery/portable_atmospherics/canister/phoron

/obj/machinery/portable_atmospherics/canister/empty/nitrogen
	icon_state = "red"
	canister_type = /obj/machinery/portable_atmospherics/canister/nitrogen

/obj/machinery/portable_atmospherics/canister/empty/carbon_dioxide
	icon_state = "black"
	canister_type = /obj/machinery/portable_atmospherics/canister/carbon_dioxide

/obj/machinery/portable_atmospherics/canister/empty/sleeping_agent
	icon_state = "redws"
	canister_type = /obj/machinery/portable_atmospherics/canister/sleeping_agent

/obj/machinery/portable_atmospherics/canister/empty/hydrogen
	icon_state = "purple"
	canister_type = /obj/machinery/portable_atmospherics/canister/hydrogen



/obj/machinery/portable_atmospherics/canister/proc/check_change()
	var/old_flag = update_flag
	update_flag = 0
	if (holding)
		update_flag |= CANISTER_FLAG_HASTANK
	if (connected_port)
		update_flag |= CANISTER_FLAG_ISCONNECTED

	var/tank_pressure = return_pressure()
	if (tank_pressure < 10)
		update_flag |= CANISTER_FLAG_PRESSURE_VERYLOW
	else if (tank_pressure < ONE_ATMOSPHERE)
		update_flag |= CANISTER_FLAG_PRESSURE_LOW
	else if (tank_pressure < 15 * ONE_ATMOSPHERE)
		update_flag |= CANISTER_FLAG_PRESSURE_HIGH
	else
		update_flag |= CANISTER_FLAG_PRESSURE_VERYHIGH

	if (update_flag == old_flag)
		return TRUE
	else
		return FALSE

/obj/machinery/portable_atmospherics/canister/on_update_icon()
/*
update_flag
1 = holding
2 = connected_port
4 = tank_pressure < 10
8 = tank_pressure < ONE_ATMOS
16 = tank_pressure < 15*ONE_ATMOS
32 = tank_pressure go boom.
*/

	if (destroyed)
		cut_overlays()
		icon_state = text("[]-1", canister_color)
		return

	if (icon_state != "[canister_color]")
		icon_state = "[canister_color]"

	if (check_change()) //Returns 1 if no change needed to icons.
		return

	cut_overlays()

	if (update_flag & CANISTER_FLAG_HASTANK)
		add_overlay("can-open")
	if (update_flag & CANISTER_FLAG_ISCONNECTED)
		add_overlay("can-connector")
	if (update_flag & CANISTER_FLAG_PRESSURE_VERYLOW)
		add_overlay("can-o0")
	if (update_flag & CANISTER_FLAG_PRESSURE_LOW)
		add_overlay("can-o1")
	else if (update_flag & CANISTER_FLAG_PRESSURE_HIGH)
		add_overlay("can-o2")
	else if (update_flag & CANISTER_FLAG_PRESSURE_VERYHIGH)
		add_overlay("can-o3")
	return

/obj/machinery/portable_atmospherics/canister/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if (exposed_temperature > temperature_resistance)
		health -= 5
		healthcheck()

/obj/machinery/portable_atmospherics/canister/proc/healthcheck()
	if (destroyed)
		return TRUE

	if (health <= 0) // Rupture!
		var/atom/location = loc
		location.assume_air(air_contents)

		destroyed = TRUE
		visible_message(SPAN_DANGER("\The [src] ruptures!"))
		playsound(src, 'sound/effects/spray.ogg', 10, 1, -3)
		set_density(FALSE)
		update_icon()

		if (holding)
			holding.dropInto(loc)
			holding = null

		return TRUE
	else
		return TRUE

/obj/machinery/portable_atmospherics/canister/Process()
	if (destroyed)
		return

	..()

	if (valve_open)
		var/datum/gas_mixture/environment
		if (holding)
			environment = holding.air_contents
		else
			environment = loc.return_air()

		var/env_pressure = environment.return_pressure()
		var/pressure_delta = release_pressure - env_pressure

		if ((air_contents.temperature > 0) && (pressure_delta > 0))
			var/transfer_moles = calculate_transfer_moles(air_contents, environment, pressure_delta)
			transfer_moles = min(transfer_moles, (release_flow_rate/air_contents.volume)*air_contents.total_moles) //flow rate limit

			var/returnval = pump_gas_passive(src, air_contents, environment, transfer_moles)
			if (returnval >= 0)
				update_icon()
				if (holding)
					holding.queue_icon_update()

	if (air_contents.return_pressure() < 1)
		can_label = TRUE
	else
		can_label = FALSE

	air_contents.react() //cooking up air cans - add phoron and oxygen, then heat above PHORON_MINIMUM_BURN_TEMPERATURE

/obj/machinery/portable_atmospherics/canister/proc/return_temperature()
	var/datum/gas_mixture/GM = return_air()
	if (GM && GM.volume>0)
		return GM.temperature
	return 0

/obj/machinery/portable_atmospherics/canister/proc/return_pressure()
	var/datum/gas_mixture/GM = return_air()
	if (GM && GM.volume>0)
		return GM.return_pressure()
	return 0

/obj/machinery/portable_atmospherics/canister/bullet_act(obj/item/projectile/P)
	if (!(P.damage_type == BRUTE || P.damage_type == BURN))
		return

	if (P.damage)
		playsound(src, 'sound/weapons/slice.ogg', 50, TRUE)
		health -= round(P.damage / 2)
		healthcheck()
	..()

/obj/machinery/portable_atmospherics/canister/attackby(obj/item/W, mob/living/user)
	if (isWelder(W) && (user.a_intent != I_HURT || destroyed))
		var/obj/item/weldingtool/WT = W
		if (!WT.isOn())
			to_chat(user, SPAN_WARNING("Turn \the [WT] on first."))
			return
		else if (air_contents.return_pressure() > ONE_ATMOSPHERE * 0.5 && !destroyed)
			to_chat(user, SPAN_WARNING("\The [src] has too much gas to safely cut apart."))
			return
		else if (air_contents.get_by_flag(XGM_GAS_FUEL) && user.a_intent == I_HELP)
			if (alert(user, "\The [src] has trace amounts of dangerous gas. Continue anyway?", name, "Continue", "Cancel") != "Continue")
				return
		else if (!WT.remove_fuel(1, user))
			to_chat(user, SPAN_WARNING("\The [WT] doesn't have enough fuel."))
			return
		user.visible_message(
			SPAN_NOTICE("\The [user] starts deconstructing \the [src] with \the [W]."),
			SPAN_NOTICE("You start cutting through \the [src], slicing at its weak points."),
			SPAN_NOTICE("You hear the sound of \a [W].")
		)
		playsound(src, 'sound/items/Welder.ogg', 50, TRUE)
		if (!user.do_skilled(6 SECONDS, SKILL_CONSTRUCTION, src))
			return
		var/returned_sheets = destroyed ? 5 : 10
		if (!destroyed)
			user.visible_message(
				SPAN_NOTICE("\The [user] cuts apart \the [src]."),
				SPAN_NOTICE("You slice through \the [src]'s seams, and it falls apart into metal sheets."),
				SPAN_NOTICE("You hear sheets of metal collapsing.")
			)
		else
			user.visible_message(
				SPAN_NOTICE("\The [user] cuts apart \the [src]'s remains'."),
				SPAN_NOTICE("You deconstruct what remains of \the [src], reclaiming some of its material."),
				SPAN_NOTICE("You hear sheets of metal collapsing.")
			)
		playsound(src, 'sound/items/Welder2.ogg', 50, TRUE)
		var/turf/location = get_turf(src)
		if (!destroyed)
			location.assume_air(air_contents)
			if (holding)
				holding.dropInto(location)
				holding = null
		if (connected_port)
			disconnect()
		new /obj/item/stack/material/steel(location, returned_sheets)
		qdel(src)
		return

	if (istype(W, /obj/item/tape_roll) && user.a_intent != I_HURT)
		if (destroyed)
			to_chat(user, SPAN_WARNING("It's a little too late to repair \the [src]."))
			return
		else if (health >= initial(health))
			to_chat(user, SPAN_NOTICE("\The [src] is already in mint condition."))
			return
		user.visible_message(
			SPAN_NOTICE("\The [user] starts patching damage to \the [src]."),
			SPAN_NOTICE("You start sealing the damage to \the [src]."),
			SPAN_NOTICE("You hear tape being used.")
		)
		playsound(src, 'sound/effects/tape.ogg', 25)
		if (!user.do_skilled((initial(health) - health) * 0.5, SKILL_CONSTRUCTION, src) || destroyed)
			return
		user.visible_message(
			SPAN_NOTICE("\The [user] repairs \the [src]!"),
			SPAN_NOTICE("You patch up \the [src], sealing the worst of its damage."),
			SPAN_NOTICE("You hear tape being used.")
		)
		playsound(src, 'sound/effects/tape.ogg', 25)
		health = initial(health)
		return

	if (istype(user, /mob/living/silicon/robot) && istype(W, /obj/item/tank/jetpack))
		var/datum/gas_mixture/thejetpack = W:air_contents
		var/env_pressure = thejetpack.return_pressure()
		var/pressure_delta = min(10 * ONE_ATMOSPHERE - env_pressure, (air_contents.return_pressure() - env_pressure) / 2)
		//Can not have a pressure delta that would cause environment pressure > tank pressure
		var/transfer_moles = 0
		if ((air_contents.temperature > 0) && (pressure_delta > 0))
			transfer_moles = pressure_delta*thejetpack.volume/(air_contents.temperature * R_IDEAL_GAS_EQUATION) //Actually transfer the gas
			var/datum/gas_mixture/removed = air_contents.remove(transfer_moles)
			thejetpack.merge(removed)
			to_chat(user, SPAN_NOTICE("You pulse-pressurize your jetpack from the tank."))
		return

	if (!isWrench(W) && !istype(W, /obj/item/tank) && !istype(W, /obj/item/device/scanner/gas) && !istype(W, /obj/item/modular_computer/pda))
		if (W.force < 5 || W.damtype != BRUTE)
			visible_message(SPAN_WARNING("\The [user] hits \the [src] with \the [W], but it bounces off!"))
		else
			visible_message(SPAN_DANGER("\The [user] hits \the [src] with \the [W]!"))
			health -= W.force
			healthcheck()
		user.do_attack_animation(src)
		user.setClickCooldown(W.attack_cooldown + W.w_class) // Mirror the logic from base attack cooldowns
		playsound(user, 'sound/weapons/smash.ogg', 50, TRUE)
		return

	. = ..()

	SSnano.update_uis(src) // Update all NanoUIs attached to src

/obj/machinery/portable_atmospherics/canister/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/portable_atmospherics/canister/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1)
	// this is the data which will be sent to the ui
	var/data[0]
	data["name"] = name
	data["canLabel"] = can_label ? 1 : 0
	data["portConnected"] = connected_port ? 1 : 0
	data["tankPressure"] = round(air_contents.return_pressure() ? air_contents.return_pressure() : 0)
	data["releasePressure"] = round(release_pressure ? release_pressure : 0)
	data["minReleasePressure"] = round(ONE_ATMOSPHERE/10)
	data["maxReleasePressure"] = round(10*ONE_ATMOSPHERE)
	data["valveOpen"] = valve_open ? 1 : 0

	data["hasHoldingTank"] = holding ? 1 : 0
	if (holding)
		data["holdingTank"] = list("name" = holding.name, "tankPressure" = round(holding.air_contents.return_pressure()))

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "canister.tmpl", "canister", 480, 400)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/portable_atmospherics/canister/OnTopic(mob/user, href_list, state)
	if (href_list["toggle"])
		if (!valve_open)
			if (!holding)
				log_open()
		valve_open = !valve_open
		. = TOPIC_REFRESH

	else if (href_list["remove_tank"])
		if (!holding)
			return TOPIC_HANDLED
		if (valve_open)
			valve_open = FALSE
		if (istype(holding, /obj/item/tank))
			holding.manipulated_by = user.real_name
		holding.dropInto(loc)
		holding = null
		update_icon()
		. = TOPIC_REFRESH

	else if (href_list["pressure_adj"])
		var/diff = text2num(href_list["pressure_adj"])
		if (diff > 0)
			release_pressure = min(10*ONE_ATMOSPHERE, release_pressure+diff)
		else
			release_pressure = max(ONE_ATMOSPHERE/10, release_pressure+diff)
		. = TOPIC_REFRESH

	else if (href_list["relabel"])
		if (!can_label)
			return 0
		var/list/colors = list(\
			"\[N2O\]" = "redws", \
			"\[N2\]" = "red", \
			"\[O2\]" = "blue", \
			"\[Phoron\]" = "orange", \
			"\[CO2\]" = "black", \
			"\[H2\]" = "purple", \
			"\[Air\]" = "grey", \
			"\[CAUTION\]" = "yellow", \
		)
		var/label = input(user, "Choose canister label", name) as null|anything in colors
		if (label && CanUseTopic(user, state))
			canister_color = colors[label]
			icon_state = colors[label]
			SetName("gas canister [label]")
		update_icon()
		. = TOPIC_REFRESH

/obj/machinery/portable_atmospherics/canister/CanUseTopic()
	if (destroyed)
		return STATUS_CLOSE
	return ..()



// Special types used for engine setup admin verb. They contain double the amount of gas as a normal canister.
/obj/machinery/portable_atmospherics/canister/nitrogen/engine_setup
	start_pressure = 90 * ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/carbon_dioxide/engine_setup
	start_pressure = 90 * ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/phoron/engine_setup
	start_pressure = 90 * ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/hydrogen/engine_setup
	start_pressure = 90 * ONE_ATMOSPHERE

#undef CANISTER_FLAG_HASTANK
#undef CANISTER_FLAG_ISCONNECTED
#undef CANISTER_FLAG_PRESSURE_VERYLOW
#undef CANISTER_FLAG_PRESSURE_LOW
#undef CANISTER_FLAG_PRESSURE_HIGH
#undef CANISTER_FLAG_PRESSURE_VERYHIGH
