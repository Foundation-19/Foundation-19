//Powerful martial art for tator tors. Weaker version of carp

/obj/item/weapon/nanite_injector/brazil_karate
	name = "educational implant injector"
	desc = "A black implanter with red bar on top, capable of holding educational inplant. This one has marking \"Brazil Karate\". You can't find any way to remove implant from it."
	icon_state = "red_hypo"
	martial_art = new /datum/martial_art/brazil_karate

/datum/martial_art/brazil_karate
	name = "Brazil Karate"
	id = "brazil_karate"

	additional_hit_damage = 2

	desc = "Harm Harm Disarm Harm - Chestkick - damages victim and sends them flying\n\
			Disarm Disarm Harm - Kneehaul - knocks victim down into 2-second stun"

/datum/martial_art/brazil_karate/handle_streak(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/D)
	if(findtext(streak, "AADA"))
		owner.visible_message(SPAN_DANGER("[owner] kicks [D] square in the chest, sending them flying!"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		var/throwdir = get_dir(owner, D)
		D.throw_at(get_edge_target_turf(D, throwdir),200,3)
		D.apply_damage(10, BRUTE, BP_CHEST)
		D.Weaken(1)
		return TRUE

	if(findtext(streak, "DDA"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		if(D.lying)
			D.apply_damage(5, BRUTE, BP_HEAD)
			owner.visible_message(SPAN_DANGER("[owner] kicks [D] in the head!"))
			return TRUE
		D.apply_damage(7, BRUTE, BP_HEAD)
		D.Weaken(2)
		D.Stun(1)
		owner.visible_message(SPAN_DANGER("[owner] kicks [D] in the head, sending them face first into the floor!"))
		return TRUE

	return FALSE