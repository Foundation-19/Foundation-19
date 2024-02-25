/client/proc/fix_air(turf/simulated/T in world)
	set name = "Fix Air"
	set category = "Debug"
	set desc = "Fixes air in specified radius."

	if(!check_rights(R_ADMIN))
		return
	var/range=input("Enter range:","Num",2) as num
	if(range >= 17)
		to_chat(usr, SPAN_DANGER("Do not input range above 16! If you need to reset entire ship - use Fix-Atmospherics-Grief verb instead."))
		return
	var/list/changed_zones = new() // List of zones that have been already reset
	for(var/turf/simulated/F in range(range,T))
		if(F.blocks_air || (F.zone in changed_zones) || !F.initial_gas)
		//skip turfs that block air, don't have initial_gas or zones that have been updated.
			continue
		if(!F.zone || !F.zone.air || !F.zone.air.gas || !F.zone.air.temperature)
		//all required variables should be in place
			continue
		F.zone.air.gas = F.initial_gas.Copy()
		F.zone.air.temperature = F.temperature
		SSair.mark_zone_update(F.zone)
		changed_zones.Add(F.zone)
	if(changed_zones)
		log_and_message_staff("[usr] fixed air with range [range] in area [T.loc.name]. [changed_zones.len] [(changed_zones.len) > 1 ? "zones have" : "zone has"] been affected.")

/client/proc/fixatmos()
	set category = "Debug"
	set name = "Fix Atmospherics Grief"

	if(!check_rights(R_ADMIN|R_DEBUG)) return

	if(alert("WARNING: Executing this command will perform a full reset of atmosphere. All pipelines will lose any gas that may be in them, and all zones will be reset to contain air mix as on roundstart. Do not use unless the map is suffering serious atmospheric issues due to grief or bug.", "Full Atmosphere Reboot", "No", "Yes") == "No")
		return
	SSstatistics.add_field_details("admin_verb","FA")

	log_and_message_staff("Full atmosphere reset initiated by [usr].")
	to_world("<span class = 'danger'>Initiating restart of atmosphere. The server may lag a bit.</span>")
	sleep(10)
	var/current_time = world.timeofday

	// Remove all gases from all pipenets
	for(var/net in SSmachines.pipenets)
		var/datum/pipe_network/PN = net
		for(var/datum/gas_mixture/G in PN.gases)
			G.gas = list()
			G.update_values()

	to_chat(usr, "\[1/4\] - All pipenets purged of gas.")

	// Delete all zones.
	for(var/zone/Z in world)
		Z.c_invalidate()

	to_chat(usr, "\[2/4\] - All ZAS Zones removed.")

	var/list/unsorted_overlays = list()
	for(var/id in gas_data.tile_overlay)
		unsorted_overlays |= gas_data.tile_overlay[id]

	for(var/turf/simulated/T in world)
		T.air = null
		T.overlays.Remove(unsorted_overlays)
		T.zone = null

	to_chat(usr, "\[3/4\] - All turfs reset to roundstart values.")

	SSair.reboot()

	to_chat(usr, "\[4/4\] - ZAS Rebooted")
	to_world("<span class = 'danger'>Atmosphere restart completed in <b>[(world.timeofday - current_time)/10]</b> seconds.</span>")
