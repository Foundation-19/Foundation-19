//todo
/datum/artifact_effect/sleepy
	name = "sleepy"

/datum/artifact_effect/sleepy/New()
	..()
	effect_type = pick(EFFECT_PSIONIC, EFFECT_ORGANIC)

/datum/artifact_effect/sleepy/DoEffectTouch(mob/living/toucher)
	if(istype(toucher))
		var/weakness = GetAnomalySusceptibility(toucher)
		if(toucher.isSynthetic())
			to_chat(toucher, SPAN_WARNING("SYSTEM ALERT: CPU cycles slowing down."))
			return 1
		else if(ishuman(toucher) && prob(weakness * 100))
			var/mob/living/carbon/human/H = toucher
			to_chat(H, pick(SPAN_NOTICE("You feel like taking a nap."),SPAN_NOTICE("You feel a yawn coming on."),SPAN_NOTICE("You feel a little tired.")))
			H.adjust_drowsiness_up_to(rand(5 SECONDS, 25 SECONDS) * weakness, 1 MINUTE * weakness)
			H.adjust_eye_blur_up_to(rand(1 SECOND, 3 SECONDS) * weakness, 1 MINUTE * weakness)
			return 1

/datum/artifact_effect/sleepy/DoEffectAura()
	if(holder)
		var/turf/T = get_turf(holder)
		for (var/mob/living/carbon/human/H in range(src.effectrange,T))
			if(H.isSynthetic())
				to_chat(H, SPAN_WARNING("SYSTEM ALERT: CPU cycles slowing down."))
				continue
			var/weakness = GetAnomalySusceptibility(H)
			if(prob(weakness * 100))
				if(prob(10))
					to_chat(H, pick(SPAN_NOTICE("You feel like taking a nap."),SPAN_NOTICE("You feel a yawn coming on."),SPAN_NOTICE("You feel a little tired.")))
				H.adjust_drowsiness_up_to(1 SECOND * weakness, 30 SECONDS * weakness)
				H.adjust_eye_blur_up_to(1 SECOND * weakness, 30 SECONDS * weakness)
		for (var/mob/living/silicon/robot/R in range(src.effectrange,holder))
			to_chat(R, SPAN_WARNING("SYSTEM ALERT: CPU cycles slowing down."))
		return 1

/datum/artifact_effect/sleepy/DoEffectPulse()
	if(holder)
		var/turf/T = get_turf(holder)
		for(var/mob/living/carbon/human/H in range(src.effectrange, T))
			var/weakness = GetAnomalySusceptibility(H)
			if(prob(weakness * 100))
				to_chat(H, pick(SPAN_NOTICE("You feel like taking a nap."),SPAN_NOTICE("You feel a yawn coming on."),SPAN_NOTICE("You feel a little tired.")))
				H.adjust_drowsiness_up_to(rand(5 SECONDS, 15 SECONDS) * weakness, 1 MINUTE * weakness)
				H.adjust_eye_blur_up_to(rand(5 SECONDS, 15 SECONDS) * weakness, 1 MINUTE * weakness)
		for (var/mob/living/silicon/robot/R in range(src.effectrange,holder))
			to_chat(R, SPAN_WARNING("SYSTEM ALERT: CPU cycles slowing down."))
		return 1
