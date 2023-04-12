GLOBAL_DATUM_INIT(apostle_antag, /datum/antagonist/apostle, new)
GLOBAL_LIST_EMPTY(apostles)

/datum/antagonist/apostle
	id = "apostle"
	role_text = "Apostle"
	role_text_plural = "Apostles"
	blacklisted_jobs = list(/datum/job/ai, /datum/job/classd, /datum/job/captain, /datum/job/hos, /datum/job/rd, /datum/job/ethicsliaison, /datum/job/tribunal, /datum/job/commsofficer, /datum/job/enlistedofficerez, /datum/job/enlistedofficerlcz, /datum/job/enlistedofficerhcz, /datum/job/ncoofficerez, /datum/job/ncoofficerlcz, /datum/job/ncoofficerhcz, /datum/job/ltofficerez, /datum/job/ltofficerlcz, /datum/job/ltofficerhcz, /datum/job/goirep,)
	flags = ANTAG_SUSPICIOUS
	antaghud_indicator = "hudchangeling"
	faction = "apostle"

/datum/antagonist/apostle/add_antagonist(datum/mind/player, ignore_role, do_not_equip, move_to_spawn, do_not_announce, preserve_appearance)
	..()
	GLOB.apostles += player

/datum/antagonist/apostle/remove_antagonist(datum/mind/player, show_message, implanted)
	if(!..())
		return 0
	GLOB.apostles -= player

/datum/antagonist/apostle/can_become_antag(datum/mind/player, ignore_role)
	return 1

/datum/antagonist/apostle/proc/rapture(mob/living/carbon/human/H)
	return

/datum/antagonist/apostle/proc/prophet_death(mob/living/carbon/human/H)
	to_chat(H, FONT_LARGE(SPAN_OCCULT("The prophet is dead...")))
	H.visible_message(SPAN_DANGER("[H.real_name] briefly looks above..."), SPAN_DANGER("You see the light above..."))
	H.emote("scream")
	H.Stun(200)
	addtimer(CALLBACK(src, .proc/soundd_in, H), (6)) // ADD NUMBER LATER

/datum/antagonist/apostle/proc/soundd_in(mob/living/carbon/human/H)
	var/turf/T = get_turf(H)
	playsound(H, 'sound/effects/apostle/mob/apostle_death_final.ogg', 100, TRUE, TRUE)
	new /obj/effect/temp_visual/sparkle(T)
	addtimer(CALLBACK(src, .proc/drop_dust, H, T), 25)

/datum/antagonist/apostle/proc/drop_dust(mob/living/carbon/human/H, turf/T)
	new /obj/effect/temp_visual/runeconvert(T)
	H.dust()
