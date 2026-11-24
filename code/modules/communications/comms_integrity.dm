// Comms integrity subsystem — department radio channels degrade during
// containment breaches (simulating panic crosstalk / overloaded relay
// capacity). The Communications Officer must physically visit the affected
// department's telecomms server in the Server Farm and reboot it to restore
// the channel. Gives the comms officer a real job during incidents.

SUBSYSTEM_DEF(comms_integrity)
	name = "Comms Integrity"
	wait = 10 SECONDS
	flags = SS_BACKGROUND
	var/list/datum/comms_channel_state/channels = list()
	var/list/rebooting = list()          // "channel_name" -> world.time when reboot completes
	var/degradation_active = FALSE
	var/static/list/department_channels = list(
		"Command"     = "network_hub_alpha",
		"Science"     = "network_server_sci",
		"Medical"     = "network_server_med",
		"Engineering" = "network_server_eng",
		"Supply"      = "network_server_sup",
		"Service"     = "network_server_srv",
		"HCZ-Security" = "network_server_sechcz",
		"LCZ-Security" = "network_server_seclcz",
		"ECZ-Security" = "network_server_sececz",
	)

/datum/controller/subsystem/comms_integrity/Initialize(start_timeofday)
	for(var/ch_name in department_channels)
		var/datum/comms_channel_state/CS = new
		CS.channel_name = ch_name
		CS.integrity = 100
		channels[ch_name] = CS
	log_game("Comms Integrity: tracking [channels.len] department channels.")
	return ..()

/datum/controller/subsystem/comms_integrity/fire()
	// Recovery: rebooted channels come back online after the reboot timer.
	for(var/ch_name in rebooting)
		if(world.time >= rebooting[ch_name])
			rebooting -= ch_name
			var/datum/comms_channel_state/CS = channels[ch_name]
			if(CS)
				CS.integrity = 100
				CS.degraded = FALSE
			announce_recovery(ch_name)
	// Active degradation while breaches are ongoing.
	if(SSscp_security && SSscp_security.tracked_breaches.len)
		if(!degradation_active)
			degradation_active = TRUE
			log_game("Comms Integrity: breach crosstalk degradation active.")
		apply_breach_degradation()
	else if(degradation_active)
		degradation_active = FALSE

/datum/controller/subsystem/comms_integrity/proc/apply_breach_degradation()
	for(var/ch_name in channels)
		var/datum/comms_channel_state/CS = channels[ch_name]
		// Channels near the breached zone degrade faster; security channels
		// take crosstalk load during any breach.
		var/degradation = 1
		if(findtext(CS.channel_name, "Security"))
			degradation = 2
		CS.integrity = max(0, CS.integrity - degradation * rand(1, 3))
		CS.check_degraded()

// Called by the comm console when the officer reboots a channel's server.
/datum/controller/subsystem/comms_integrity/proc/reboot_channel(ch_name, mob/user)
	var/datum/comms_channel_state/CS = channels[ch_name]
	if(!CS)
		return FALSE
	if(rebooting[ch_name])
		to_chat(user, SPAN_WARNING("[ch_name] server is already rebooting."))
		return FALSE
	if(CS.integrity >= 100)
		to_chat(user, SPAN_NOTICE("[ch_name] relay is running at full capacity — reboot unnecessary."))
		return FALSE
	rebooting[ch_name] = world.time + 1 MINUTES
	to_chat(user, SPAN_NOTICE("Rebooting [ch_name] relay... channel will be restored in approximately one minute."))
	log_game("Comms Integrity: [key_name(user)] rebooted [ch_name] relay (integrity was [CS.integrity]).")
	return TRUE

/datum/controller/subsystem/comms_integrity/proc/announce_recovery(ch_name)
	priority_announcement.Announce(
		"Relay capacity restored: [ch_name] communications channel has returned to full capacity.",
		"Telecommunications Notice"
	)

/datum/comms_channel_state
	var/channel_name
	var/integrity = 100
	var/degraded = FALSE

/datum/comms_channel_state/proc/check_degraded()
	var/new_degraded = integrity < 50
	if(new_degraded && !degraded)
		degraded = TRUE
		// First crossing: warn the site.
		priority_announcement.Announce(
			"Warning: [channel_name] communications relay is at [integrity]% capacity due to increased traffic. Messages on this channel may be distorted or lost. Telecommunications staff should inspect the affected relay.",
			"Telecommunications Warning"
		)
		log_game("Comms Integrity: [channel_name] degraded to [integrity]%.")

// SCP-035 hazard: the mask's host bleeds influence into the Command channel.
// Listeners on Command hear whispers (sanity damage); the officer cuts the
// relay via the console to silence it.
/datum/controller/subsystem/comms_integrity/proc/begin_035_hazard(obj/item/clothing/mask/scp035/mask)
	hazard_source = mask
	log_game("Comms Integrity: SCP-035 influence detected on Command channel.")
	priority_announcement.Announce(
		"Warning: anomalous signal contamination detected on the Command frequency. Do not linger on channel. Telecommunications staff: isolate the contaminated relay immediately.",
		"Telecommunications Anomaly"
	)

/datum/controller/subsystem/comms_integrity/proc/end_035_hazard()
	if(!hazard_source)
		return
	hazard_source = null
	log_game("Comms Integrity: SCP-035 signal contamination cleared from Command channel.")
	priority_announcement.Announce(
		"Command frequency signal contamination has been isolated and cleared. Channel restored to nominal operation.",
		"Telecommunications Notice"
	)

/datum/controller/subsystem/comms_integrity/proc/cut_035_hazard(mob/user)
	if(!hazard_source)
		to_chat(user, SPAN_NOTICE("No anomalous signal contamination is currently present."))
		return FALSE
	log_and_message_staff("COMMS: [key_name(user)] cut the contaminated Command relay, silencing SCP-035's channel influence.")
	end_035_hazard()
	return TRUE

/datum/controller/subsystem/comms_integrity
	var/hazard_source = null

// Public query used by the radio send path.
/proc/get_channel_integrity(channel_name)
	if(!SScomms_integrity)
		return 100
	var/datum/comms_channel_state/CS = SScomms_integrity.channels[channel_name]
	return CS ? CS.integrity : 100

// Server Farm reboot: telecomms servers in the Server Farm restore the
// channel they carry when interacted with (opens the comm console's
// integrity panel for remotes, but a hands-on reboot always works).
/obj/machinery/telecomms/attack_hand(mob/user)
	if(..())
		return TRUE
	var/ch_name = null
	for(var/ch in SScomms_integrity?.channels)
		// Each server preset carries channel traffic; approximate mapping by
		// matching names in the channel state list.
		if(istype(src, /obj/machinery/telecomms/server))
			var/obj/machinery/telecomms/server/S = src
			var/server_name = "[S.name]"
			for(var/possible in SScomms_integrity.channels)
				if(findtext(lowertext(server_name), lowertext(copytext(possible, 1, 5))))
					ch_name = possible
					break
		if(ch_name)
			break
	if(ch_name && SScomms_integrity.rebooting[ch_name])
		to_chat(user, SPAN_WARNING("The [ch_name] relay is already cycling down for a reboot."))
		return TRUE
	if(ch_name && get_channel_integrity(ch_name) < 100)
		to_chat(user, SPAN_NOTICE("You run a manual integrity cycle on the [ch_name] relay."))
		SScomms_integrity.reboot_channel(ch_name, user)
		return TRUE
	return FALSE
