//Legal martial arts for security, nothing special. Can be used for more efficient melee combat against criminals

/obj/item/weapon/nanite_injector/krav_maga
	name = "educational implant injector"
	desc = "A black implanter with yellow bar on top, capable of holding educational inplant. This one has marking \"Krav Maga\". You can't find any way to remove implant from it."
	icon_state = "yellow_hypo"
	martial_art = new /datum/martial_art/krav_maga

/datum/martial_art/krav_maga
	name = "Krav Maga"
	id = "krav_maga"

	desc = "Grab Disarm Harm - Floorslam - Slams victim's head against the floor, stunning them\n\
			Harm Disarm Harm - Kick - Kicks victim into chest, dealing some damage and stunning them for a bit"

/datum/martial_art/krav_maga/handle_streak(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/D)
	if(findtext(streak, "GDA"))
		D.Weaken(1)
		D.Stun(0.2)
		owner.visible_message(SPAN_DANGER("[owner] slams [D] into the floor!"), SPAN_DANGER("You slam [D] into the floor!"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		return TRUE

	if(findtext(streak, "ADA"))
		D.Weaken(1)
		D.apply_damage(10, BRUTE, BP_CHEST)
		owner.visible_message(SPAN_DANGER("[owner] kicks [D] in the chest!"), SPAN_DANGER("You kick [D] in the chest!"))
		playsound(owner.loc, 'sound/weapons/punch2.ogg', 25, 1, -1)
		return TRUE
	return FALSE