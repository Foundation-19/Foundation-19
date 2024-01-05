#define FEAR_MESSAGE_COOLDOWN 30000 // Cooldown in seconds before a player can be affected again
/mob/living/scp080
	name = "SCP-080"
	desc = "A barely visible shadowy figure that instills a deep sense of dread."
	icon = 'icons/SCP/scp-080.dmi' // Placeholder for the actual icon file
	icon_state = "scp_080" // Placeholder for the actual icon state
	maxHealth = 100
	health = 100
	invisibility = INVISIBILITY_OBSERVER // SCP-080 is nearly invisible
	see_invisible = SEE_INVISIBLE_OBSERVER // SCP-080 can see invisible people
	status_flags = GODMODE // SCP-080 cannot be killed or gibbed
	a_intent = I_HELP // SCP-080 does not have aggressive intent

	// SCP-080 behavior flags
	var/induce_fear = TRUE // Can SCP-080 induce fear?
	var/fear_radius = 7 // Radius within which SCP-080 can affect characters
	var/fear_strength = 5 // Strength of the fear effect
	var/list/affected_mobs = list()
	var/fear_message_cooldown = FEAR_MESSAGE_COOLDOWN

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

    if(induce_fear)
        induce_fear_aura()

/mob/living/scp080/proc/induce_fear_aura()
    for(var/mob/living/L in view(fear_radius, src))
        if(L.stat == DEAD || L.is_immune_to_fear==TRUE) // Check if the living entity is dead or immune to fear
            continue
        if(L in affected_mobs && world.time < (affected_mobs[L] + fear_message_cooldown * 10)) // Check if the mob is still on cooldown
            continue
        if(prob(50)) // 50% chance to induce fear each tick
            L.visible_message("<span class='warning'>[L] shivers as a cold, unseen presence brushes past them.</span>",
                              "<span class='userdanger'>You feel a terrifying chill down your spine as something unseen whispers your name...</span>")
            L.confused += 5 // Add confusion to the mob
            L.dizziness += 5 // Add dizziness to the mob
            #warn "this is for later" //L.add_status_effect(STATUS_EFFECT_FEAR, 10 SECONDS) // Add a custom fear status effect for 10 seconds
            affected_mobs[L] = world.time // Update the cooldown for the affected mob

    var/sound/fear_sound = null
    fear_sound.volume = 50
    for(var/mob/living/L in affected_mobs)
        if(world.time < (affected_mobs[L] + fear_message_cooldown * 10))
            continue
        L.playsound_local(L, fear_sound)

/mob/living/scp080/attack_hand(mob/living/carbon/human/H)
    // SCP-080 cannot be interacted with physically in a meaningful way
    if(H.a_intent == I_HELP)
        to_chat(H, "<span class='warning'>Your hand passes through [src], as if it wasn't there.</span>")
    else
        to_chat(H, "<span class='warning'>You can't seem to interact with [src].</span>")
    return TRUE


#undef FEAR_MESSAGE_COOLDOWN
