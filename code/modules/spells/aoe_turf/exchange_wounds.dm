/datum/spell/aoe_turf/exchange_wounds
	name = "Exchange Wounds"
	desc = "Syphon the wounds from your allies."
	feedback = "EW"
	school = "transmutation"
	invocation = "Esh Yek Vai!"
	invocation_type = INVOKE_SHOUT
	charge_max = 400
	spell_flags = 0

	var/amt_healed = 0
	var/heal_max = 100
	range = 4
	inner_radius = 0
	number_of_channels = 0
	time_between_channels = 20

	hud_state = "wiz_exchange"

/datum/spell/aoe_turf/exchange_wounds/perform()
	amt_healed = 0
	..()

/datum/spell/aoe_turf/exchange_wounds/cast(list/targets, mob/living/user)
	new /obj/effect/temp_visual/temporary(get_turf(user),10,'icons/effects/effects.dmi',"purple_electricity_constant")
	for(var/t in targets)
		for(var/mob/living/L in t)
			if(L.faction != user.faction)
				continue
			new /obj/effect/temp_visual/temporary(get_turf(L),10,'icons/effects/effects.dmi',"green_sparkles")
			if(L.getBruteLoss() > 5)
				L.adjustBruteLoss(-5)
				user.adjustBruteLoss(2)
				amt_healed += 5
			if(L.getFireLoss() > 5)
				L.adjustFireLoss(-5)
				user.adjustFireLoss(2)
				amt_healed += 5
