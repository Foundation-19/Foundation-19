/mob/living/scp082
    name = "SCP-082"
    desc = "A hulking figure, its features grotesquely distorted. It wields a large cleaver and has a penchant for conversation... and cannibalism."
    icon = 'icons/SCP/scp-082.dmi' // Placeholder for the actual icon file
    icon_state = "082" // Placeholder for the actual icon state
    maxHealth = 300
    health = 300
    status_flags = CANPUSH | CANSTUN | CANWEAKEN | CANPARALYSE // SCP-082 can be affected by certain status effects but is resistant to others
    a_intent = I_HURT // SCP-082 has aggressive intent

/mob/living/scp082/Initialize(mapload)
	. = ..()

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"fat man", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_KETER, //Obj Class
		"082", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)
/mob/living/scp082/attack_hand(mob/living/carbon/human/H)
    if(H.a_intent == "help") // If someone tries to interact peacefully
        to_chat(H, "<span class='notice'>You attempt to engage SCP-082 in conversation. It seems amused, for now...</span>")
    else // If someone tries to attack
        to_chat(H, "<span class='warning'>SCP-082 laughs off your feeble attempt to harm it!</span>")
        H.adjustBruteLoss(10) // SCP-082 retaliates
        special_attack(H) // Attempt to perform a special attack

/mob/living/scp082/proc/take_damage(damage, damagetype = BRUTE, damage_flags = 0, sound_effect = TRUE)
    if((damagetype == BRUTE) || (damagetype == BURN))
        if(prob(50))
            visible_message("<span class='warning'>SCP-082's wounds start to close up at an alarming rate!</span>")
            heal_overall_damage(damage * 0.5, damage * 0.5)
            return


/mob/living/scp082/proc/special_attack(mob/living/carbon/human/target)
    if(prob(25)) // 25% chance to perform the special attack

        target.adjustBruteLoss(50) // Deal a significant amount of brute damage

        // Additional effects such as knocking the target back or stunning them
        var/knockback_distance = 3
        var/turf/target_original_turf = get_turf(target)
        var/turf/target_new_turf = get_ranged_target_turf(target_original_turf, get_dir(src, target_original_turf), knockback_distance)
        if(target_new_turf && !istype(target_new_turf, /turf))
            target.throw_at(target_new_turf, knockback_distance, 2, src, TRUE) // Knock the target back
            target.Stun(30) // Stun the target for a short duration

        if(target.stat == DEAD) // Check if the target is dead after the attack
            visible_message("<span class='warning'>SCP-082 lets out a satisfied grunt as it observes the carnage it has wrought upon [target].</span>")
            heal_overall_damage(20, 20)

        // Check for environmental effects, such as blood splatter or destruction of nearby objects
        var/turf/target_turf = get_turf(target)
        if(prob(50)) // 50% chance to cause environmental damage
            for(var/obj/O in range(1, target_turf))
            target_turf.add_blood(target) // Add blood splatter to the floor
