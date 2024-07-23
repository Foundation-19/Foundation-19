/mob/living/carbon/slime
	/// Stops the slime for attacking until X ticks have passed
	var/attack_cooldown_ticks = 0



/mob/living/carbon/slime/Initialize(mapload, colour)
	. = ..()
	STOP_PROCESSING(SSmobs,src)
	START_PROCESSING(SSfast_mobs, src)

/mob/living/carbon/slime/Destroy()
	. = ..()
	STOP_PROCESSING(SSfast_mobs, src)
