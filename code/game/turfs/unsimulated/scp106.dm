/turf/unsimulated/floor/scp106
	name = "strange corrosive void"
	icon_state = "pocket_dimension"

/turf/unsimulated/floor/scp106/Initialize()
	. = ..()
	START_PROCESSING(SSturf, src)

/turf/unsimulated/floor/scp106/Destroy()
	STOP_PROCESSING(SSturf, src)
	return ..()

/turf/unsimulated/floor/scp106/Process()
	for(var/mob/living/L in contents)
		if(isscp106(L))
			// since we "take" 0.1x damage in the PD, these actually become -5
			L.adjustBruteLoss(-50)
			L.adjustFireLoss(-50)
			L.adjustToxLoss(-50)
			L.adjustCloneLoss(-50)
		else
			if(L.stat != DEAD)
				if(iscarbon(L))
					var/mob/living/carbon/C = L
					for(var/organ in shuffle(C.organs))
						var/obj/item/organ/I = organ
						if(I.scp106_vulnerable && !(I.status & ORGAN_DEAD) && prob(10))
							I.scp106_affected = TRUE
							break
				L.adjustFireLoss(3)
			else if(ishuman(L))
				var/mob/living/carbon/human/H = L
				if(++H.pocket_dimension_decay >= 300) // 5 minutes
					new /obj/effect/decal/cleanable/molten_item(src)
					qdel(H)

/turf/unsimulated/floor/scp106/get_footstep_sound(mob/caller)
	return pick(\
				'sound/effects/footstep/scp106/step1.ogg',
				'sound/effects/footstep/scp106/step2.ogg',
				'sound/effects/footstep/scp106/step3.ogg')

// Walls
/turf/unsimulated/wall/scp106
	name = "void wall"
	color = "#000000"

/turf/unsimulated/wall/scp106/is_phasable()
	return FALSE
