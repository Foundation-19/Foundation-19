// SCP research tier countermeasures - reward items unlocked by advancing an SCP's research tier.
// Dispensed from the SCP research console once the linked SCP reaches the required tier.

GLOBAL_LIST_INIT(scp_countermeasure_registry, list(
	"513" = list(
		"type" = /obj/item/clothing/ears/scp_acoustic_dampener,
		"name" = "Acoustic Dampener Earpiece",
		"tier" = 3
	),
	"017" = list(
		"type" = /obj/item/scp_photonic_grenade,
		"name" = "Photonic Grenade",
		"tier" = 3
	),
	"280" = list(
		"type" = /obj/item/scp_photonic_grenade,
		"name" = "Photonic Grenade",
		"tier" = 3
	),
	"012" = list(
		"type" = /obj/item/device/scp_memetic_scrubber,
		"name" = "Memetic Scrubber",
		"tier" = 3
	),
	"895" = list(
		"type" = /obj/item/device/scp_memetic_scrubber,
		"name" = "Memetic Scrubber",
		"tier" = 3
	),
	"151" = list(
		"type" = /obj/item/device/scp_memetic_scrubber,
		"name" = "Memetic Scrubber",
		"tier" = 3
	),
	"066" = list(
		"type" = /obj/item/scp_harmonic_stabilizer,
		"name" = "Harmonic Stabilizer",
		"tier" = 3
	),
	"113" = list(
		"type" = /obj/item/clothing/gloves/scp_insulated,
		"name" = "Insulated Containment Gloves",
		"tier" = 2
	),
	"347" = list(
		"type" = /obj/item/clothing/glasses/scp_thermal,
		"name" = "Thermal Imaging Goggles",
		"tier" = 2
	),	"939" = list(
		"type" = /obj/item/clothing/glasses/scp_thermal,
		"name" = "Thermal Imaging Goggles",
		"tier" = 2
	),
	"013" = list(
		"type" = /obj/item/device/scp_amnestic_nebulizer,
		"name" = "Amnestic Nebulizer",
		"tier" = 2
	)
))

/proc/get_countermeasure_data(designation)
	var/list/entry = GLOB.scp_countermeasure_registry[designation]
	if(!entry)
		return null
	var/datum/scp_research/research = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_research(designation) : null
	var/current_tier = research ? research.research_level : 0
	return list(
		"name" = entry["name"],
		"type" = "[entry["type"]]",
		"required_tier" = entry["tier"],
		"current_tier" = current_tier,
		"unlocked" = current_tier >= entry["tier"]
	)

// ---------------- Acoustic Dampener Earpiece (SCP-513 T3) ----------------

/obj/item/clothing/ears/scp_acoustic_dampener
	name = "acoustic dampener earpiece"
	desc = "A Foundation-engineered earpiece that actively cancels anomalous auditory patterns. Renders the wearer immune to SCP-513's influence."
	icon_state = "secgear"
	item_state = "secgear"
	w_class = ITEM_SIZE_TINY

/proc/wearing_scp_acoustic_dampener(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	var/obj/item/clothing/ears/E = H.get_equipped_item(slot_l_ear_str)
	if(istype(E, /obj/item/clothing/ears/scp_acoustic_dampener))
		return TRUE
	E = H.get_equipped_item(slot_r_ear_str)
	return istype(E, /obj/item/clothing/ears/scp_acoustic_dampener)

// ---------------- Photonic Grenade (SCP-017 / SCP-280 T3) ----------------

/obj/item/scp_photonic_grenade
	name = "photonic grenade"
	desc = "A white-phosphor photonic emitter. Detonates in a blinding pulse of pure light, severe damage to photophobic anomalies. Single use."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "flashbang"
	w_class = ITEM_SIZE_SMALL
	var/primed = FALSE

/obj/item/scp_photonic_grenade/attack_self(mob/user)
	if(primed)
		return
	primed = TRUE
	to_chat(user, SPAN_WARNING("You arm \the [src] - three seconds!"))
	playsound(src, 'sounds/weapons/armbomb.ogg', 60, TRUE)
	icon_state = "flashbang_active"
	addtimer(CALLBACK(src, PROC_REF(detonate)), 3 SECONDS)

/obj/item/scp_photonic_grenade/proc/detonate()
	var/turf/T = get_turf(src)
	if(!T)
		return
	visible_message(SPAN_DANGER("\The [src] erupts in a searing white light!"))
	playsound(T, 'sounds/weapons/flash.ogg', 80, TRUE)
	// blinding pulse for everyone nearby
	for(var/mob/living/carbon/human/H in viewers(T))
		H.flash_eyes()
	// direct damage to photophobic anomalies
	for(var/atom/A in range(7, T))
		if(!A.SCP)
			continue
		var/desg = A.SCP.designation
		if(desg == "017" || desg == "280")
			var/mob/living/M = A
			if(istype(M))
				M.adjustBruteLoss(100)
				M.visible_message(SPAN_DANGER("\The [M] recoils in agony as the light scorches it!"))
				if(A.SCP && A.SCP.research)
					A.SCP.research.add_research_points(25, "countermeasure_deployment")
	qdel(src)

// ---------------- Memetic Scrubber (SCP-012 / SCP-895 / SCP-151 T3) ----------------

/obj/item/device/scp_memetic_scrubber
	name = "memetic scrubber"
	desc = "An active-cancellation device that purges memetic contamination from affected personnel within its radius. Reloads a new cognitohazard scrub pattern after each use."
	icon = 'icons/obj/machines/scp_anomaly_scanner.dmi'
	icon_state = "scanner"
	w_class = ITEM_SIZE_SMALL
	var/next_scrub = 0
	var/scrub_cooldown = 60 SECONDS

/obj/item/device/scp_memetic_scrubber/attack_self(mob/user)
	if(world.time < next_scrub)
		to_chat(user, SPAN_WARNING("Scrub pattern recompiling. [round((next_scrub - world.time) / 10, 1)] seconds remaining."))
		return
	next_scrub = world.time + scrub_cooldown
	var/turf/T = get_turf(src)
	var/scrubbed = 0
	var/purged_viewers = 0
	for(var/atom/A in range(7, T))
		if(A.SCP && A.SCP.meme_comp)
			var/datum/component/memetic/MC = A.SCP.meme_comp
			var/before = length(MC.affected_mobs_weakref)
			MC.affected_mobs_weakref.Cut()
			purged_viewers += before
			if(before > 0)
				scrubbed++
	if(scrubbed)
		user.visible_message(SPAN_NOTICE("\The [src] whirs, emitting a soft pulse of scrambled light."))
		to_chat(user, SPAN_NOTICE("Scrub complete: [purged_viewers] affected personnel purged from [scrubbed] memetic anomalies."))
		playsound(T, 'sounds/machines/ping.ogg', 50, TRUE)
	else
		to_chat(user, SPAN_NOTICE("Scrub complete: no active memetic influence detected in radius."))

// ---------------- Harmonic Stabilizer (SCP-066 T3) ----------------

/obj/item/scp_harmonic_stabilizer
	name = "harmonic stabilizer"
	desc = "A tuning-fork array emitting a counter-harmonic field. SCP-066 cannot escalate to deafening noise events while within its field."
	icon = 'icons/obj/device.dmi'
	icon_state = "health"
	w_class = ITEM_SIZE_NORMAL
	var/field_range = 7

/obj/item/scp_harmonic_stabilizer/afterattack(atom/target, mob/user, proximity)
	if(istype(target, /turf) && proximity)
		user.unEquip(src, TRUE)
		src.forceMove(target)
		to_chat(user, SPAN_NOTICE("You deploy \the [src]. It hums steadily."))
		return TRUE
	return ..()

/proc/scp066_in_stabilizer_field(atom/scp066_atom)
	for(var/obj/item/scp_harmonic_stabilizer/S in range(7, get_turf(scp066_atom)))
		if(S.loc == get_turf(S))
			return TRUE
	return FALSE

// ---------------- Insulated Containment Gloves (SCP-113 T2) ----------------

/obj/item/clothing/gloves/scp_insulated
	name = "insulated containment gloves"
	desc = "Heavy Foundation gloves lined with layered insulating polymers. Their palms are rated to handle dimensional transmutation vectors - SCP-113 can be handled safely while wearing them."
	icon_state = "yellow"
	item_state = "ygloves"
	permeability_coefficient = 0.5
	w_class = ITEM_SIZE_NORMAL

// ---------------- Thermal Imaging Goggles (SCP-347 / SCP-939 T2) ----------------

/obj/item/clothing/glasses/scp_thermal
	name = "thermal imaging goggles"
	desc = "Prototype long-wave infrared optics tuned to body-heat signatures. Reveals thermal traces invisible to the naked eye."
	origin_tech = list(TECH_MAGNET = 3, TECH_ESOTERIC = 2)
	w_class = ITEM_SIZE_NORMAL

// ---------------- Amnestic Nebulizer (SCP-013 T2) ----------------

/obj/item/device/scp_amnestic_nebulizer
	name = "amnestic nebulizer"
	desc = "A field-grade inhalation device loaded with tailored amnestic aerosols. Calms the viewer-side symptoms of blue-light contamination without requiring pills."
	icon = 'icons/obj/device.dmi'
	icon_state = "health"
	w_class = ITEM_SIZE_SMALL
	var/next_use = 0
	var/use_cooldown = 30 SECONDS

/obj/item/device/scp_amnestic_nebulizer/attack_self(mob/user)
	if(world.time < next_use)
		to_chat(user, SPAN_WARNING("Aerosol canister pressurizing. [round((next_use - world.time) / 10, 1)] seconds remaining."))
		return
	next_use = world.time + use_cooldown
	var/target = user
	var/choice = alert(user, "Who should inhale the amnestic mist?", "Amnestic Nebulizer", "Myself", "Someone nearby", "Cancel")
	switch(choice)
		if("Myself")
			target = user
		if("Someone nearby")
			var/list/candidates = list()
			for(var/mob/living/carbon/human/H in view(1, user))
				if(H != user && H.client)
					candidates += H
			target = input(user, "Select subject:", "Amnestic Nebulizer") as null|mob in candidates
		else
			return
	if(!target || !istype(target, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/H = target
	// nebulizer halves the blue-lady stage progression, equivalent to a fast Class-E amnestic
	if(H.humanStageHandler && H.humanStageHandler.getStage("BlueLady"))
		H.humanStageHandler.adjustStage("BlueLady", -2)
		user.visible_message(SPAN_NOTICE("\The [user] holds \the [src] to [H]'s face and releases a hiss of vapor."))
		to_chat(H, SPAN_NOTICE("The amnestic mist dulls the strange blue compulsion."))
		playsound(get_turf(src), 'sounds/effects/bamf.ogg', 30, TRUE)
	else
		to_chat(user, SPAN_NOTICE("No blue-light contamination detected in the subject."))
