#define FEAR_MESSAGE_COOLDOWN 30000 // Cooldown in seconds before a player can be affected again
#define INDUCE_FEAR_COOLDOWN 20 SECONDS // Define a cooldown period of 10 seconds
/mob/living/scp080
	name = "SCP-080"
	desc = "A barely visible shadowy figure that instills a deep sense of dread."
	icon = 'icons/SCP/scp-080.dmi' // Placeholder for the actual icon file
	icon_state = "scp_080" // Placeholder for the actual icon state
	maxHealth = 100
	health = 100
	invisibility = INVISIBILITY_LEVEL_TWO  // SCP-080 is nearly invisible
	see_invisible = SEE_INVISIBLE_OBSERVER // SCP-080 can see invisible people
	status_flags = GODMODE // SCP-080 cannot be killed or gibbed
	a_intent = I_HELP // SCP-080 does not have aggressive intent

	// SCP-080 behavior flags
	var/induce_fear = TRUE // Can SCP-080 induce fear?
	var/fear_radius = 7 // Radius within which SCP-080 can affect characters
	var/fear_strength = 5 // Strength of the fear effect
	var/list/affected_mobs = list()
	var/fear_message_cooldown = FEAR_MESSAGE_COOLDOWN
	var/last_fear_induction = 0 // Variable to track the last time induce_fear_aura was called
/mob/living/scp080/Initialize()
	. = ..()

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"eery shadow", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_KETER, //Obj Class
		"080", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

/mob/living/scp080/Life(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	// Existing fear induction logic
	if(induce_fear && world.time >= (last_fear_induction + INDUCE_FEAR_COOLDOWN))
		last_fear_induction = world.time // Update the last induction time
		induce_fear_aura()

	// New: Affect environment and check for teleportation
	affect_environment()
	if(!is_observed()) // Only attempt to teleport if not observed
		teleport_to_darkness()

	// New: Escalate fear effects on already affected mobs
	for(var/mob/living/L in affected_mobs)
		if(world.time >= (affected_mobs[L] + fear_message_cooldown * 10))
			escalate_fear_effects(L)



/mob/living/scp080/proc/induce_fear_aura()
	for(var/mob/living/L in view(fear_radius, src))
		if(L == src) // Check if the living entity is SCP-080 itself
			continue
		if(L.stat == DEAD) // Check if the living entity is dead or immune to fear
			continue
		if(L in affected_mobs && world.time < (affected_mobs[L] + fear_message_cooldown * 10)) // Check if the mob is still on cooldown
			continue
		// Increase the chance to induce fear based on how close the mob is to SCP-080
		var/distance = get_dist(src, L)
		var/fear_chance = max(50 - (distance * 5), 20) // Closer mobs have a higher chance, but not lower than 20%
		if(prob(fear_chance))
			var/message_type = prob(70) ? "warning" : "userdanger" // 70% chance for a warning message, 30% for a userdanger message
			var/warning_messages = list(
				"[L] feels their heart racing uncontrollably.",
				"[L] feels a chill run down their spine.",
				"[L] can't shake the feeling of being watched."
			)
			var/userdanger_messages = list(
				"You hear your heartbeat in your ears, drowning out all other sounds.",
				"A sudden fear grips you, but you can't understand why.",
				"Panic washes over you, making your hands tremble."
			)
			var/message_text = message_type == "warning" ? pick(warning_messages) : pick(userdanger_messages)
			L.visible_message("<span class='[message_type]'>[message_text]</span>")
			affected_mobs[L] = world.time // Update the cooldown for the affected mob

			// Introduce environmental effects based on proximity
			if(distance <= 2)
				// Whispering voices for those very close
				L << "<span class='userdanger'>Whispers fill your ears, speaking in tongues you can't understand.</span>"
			else if(distance <= 4)
				// Unsettling sounds for those a bit further away
				L << "<span class='warning'>The sound of footsteps approach you, yet nothing is there.</span>"

	// Play fear-inducing sounds at random intervals
	if(prob(20)) // 20% chance each tick to play a sound
		//var/list/fear_sounds = null //list('sound/ambience/ambiscp1.ogg', 'sound/ambience/ambiscp2.ogg', 'sound/ambience/ambiscp3.ogg')
		var/sound/fear_sound = null //pick(fear_sounds)
		fear_sound.volume = 50
		for(var/mob/living/L in affected_mobs)
			if(L == src || world.time < (affected_mobs[L] + fear_message_cooldown * 10))
				continue
			L.playsound_local(L, fear_sound, 50)

	// Gradually increase fear effects based on exposure time
	for(var/mob/living/L in affected_mobs)
		if(L == src || world.time < (affected_mobs[L] + fear_message_cooldown * 10))
			continue
		var/exposure_time = (world.time - affected_mobs[L]) / 10 // Time in seconds since first affected
		if(exposure_time > 30) // More than 30 seconds of exposure
			L << "<span class='userdanger'>Your vision begins to blur as panic takes hold.</span>"
		else if(exposure_time > 15) // More than 15 seconds of exposure
			L << "<span class='warning'>You start to see shadows darting at the edge of your vision.</span>"





/mob/living/scp080/attack_hand(mob/living/carbon/human/H)
	// SCP-080 cannot be interacted with physically in a meaningful way
	if(H.a_intent == I_HELP)
		to_chat(H, "<span class='warning'>Your hand passes through [src], as if it wasn't there.</span>")
	else
		to_chat(H, "<span class='warning'>You can't seem to interact with [src].</span>")
	return TRUE


/mob/living/scp080/proc/escalate_fear_effects()
	var/mob/living/carbon/L = usr
	var/exposure_time = (world.time - affected_mobs[L]) / 10 // Time in seconds since first affected
	switch(exposure_time)
		if(60 to INFINITY)
			// At this point, the victim is consumed by their fear, leading to a catatonic state
			if(prob(2))
				L.visible_message("<span class='warning'>[L] stops dead in their tracks, their eyes wide with unspeakable terror.</span>",
									"<span class='userdanger'>You are paralyzed by an overwhelming dread. You can't move... you can't even scream.</span>")
				L.Paralyse(5 SECONDS)
		if(45 to 60)
			// Hallucinations become more vivid, potentially causing the victim to see SCP-080's manifestations as real entities
			if(prob(10))
				L.hallucination(50, 50)
				L.visible_message("<span class='notice'>[L] starts screaming and batting at unseen horrors.</span>",
									"<span class='userdanger'>The shadows twist into horrifying figures, lunging at you from all directions!</span>")
		if(30 to 45)
			// Temporary paralysis and increased hallucinations
			if(prob(5))
				L.Paralyse(2 SECONDS)
				L.hallucination(20, 20)
				L.visible_message("<span class='notice'>[L] suddenly freezes, their eyes darting around in panic.</span>",
									"<span class='userdanger'>You can't move! Shadows creep closer, their forms becoming more terrifying.</span>")
		if(15 to 30)
			// Voices whispering, shadows moving at the edge of the victim's vision
			if(prob(20))
				L.audible_message("<span class='hear'>Whispers fill the air around [L], too quiet to make out any words.</span>",
									"<span class='userdanger'>You hear whispering all around you... are the shadows moving closer?</span>")
				L.hallucination(10, 10)
		if(0 to 15)
			// Initial fear response, slight unease
			if(prob(30))
				L.audible_message("<span class='notice'>[L] jumps at a sudden, but faint, noise.</span>",
									"<span class='userdanger'>You think you heard something... or was it just your imagination?</span>")

	// Check for any immediate effects that should be applied regardless of exposure time
	immediate_effects(L)

// A separate proc to handle any immediate effects that don't depend on exposure time
/mob/living/scp080/proc/immediate_effects(mob/living/L)
	// Example: Random chance to trip or hear a disturbing sound
	if(prob(5))
		L.visible_message("<span class='notice'>[L] stumbles as if pushed by an unseen force.</span>",
							"<span class='userdanger'>You feel a cold hand push you from behind!</span>")
		L.Weaken(2)
	if(prob(5))
		L.audible_message("<span class='hear'>A disturbing, unidentifiable noise briefly echoes around [L].</span>",
							"<span class='userdanger'>You hear a chilling sound that seems to come from nowhere... and everywhere.</span>")



/mob/living/scp080/proc/teleport_to_darkness()
	if(!is_observed() && prob(20)) // 20% chance to teleport if not observed
		var/list/dark_areas = list()
		for(var/turf/T in in_range(20))
			if(is_dark(T))
				dark_areas += T
		if(LAZYLEN(dark_areas))
			var/turf/new_location = pick(dark_areas)
			do_teleport(src, new_location)

/mob/living/scp080/proc/is_observed()
	for(var/mob/M in view(fear_radius, src))
		if(M.client)
			return TRUE
	return FALSE

/mob/living/scp080/proc/affect_environment()
	// Flicker lights in the vicinity
	for(var/obj/machinery/light/L in view(fear_radius, src))
		if(prob(30)) // 30% chance to flicker lights
			L.flicker()

	// Briefly manifest a visual anomaly (e.g., shadow figure, strange mist)
	if(prob(5)) // 5% chance to manifest a visual anomaly
		var/turf/T = pick(orange(fear_radius, src))
		var/obj/effect/temp_visual/scp_anomaly/A = new /obj/effect/temp_visual/scp_anomaly(T)
		A.lifetime = 5 SECONDS
/obj/effect/temp_visual/scp_anomaly
	icon = 'icons/scp/scp-017.dmi'
	icon_state = "shadow_figure" // Example icon state, replace with actual
	layer = ABOVE_HUMAN_LAYER
	var/lifetime = 0

/obj/effect/temp_visual/scp_anomaly/Initialize(mapload, time)
	. = ..()
	if(time)
		lifetime = time
	set_light(2, 0.8, "#5555AA") // Optional: eerie light
	addtimer(CALLBACK(src, PROC_REF(fade_out)), lifetime)

/obj/effect/temp_visual/scp_anomaly/proc/fade_out()
	animate(src, alpha = 0, time = 30)
	sleep(30)
	qdel(src)



#undef FEAR_MESSAGE_COOLDOWN
