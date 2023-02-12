/datum/martial_art/nanite/eaglestyle
	name = "Eagle Brawl Style"
	id = "eagle_style"

	speedboost = 0.25 //Speed-based martial art
	reflect_prob = 15 //15%, doudging cuz of speed
	block_modifier = 1.5 //Fast reactions

	desc = "Disarm Harm Disarm - Backflip - you jump off the victim, throwing you backwards and stunning him.\n\
			Harm Disarm Harm Harm - Neckchop - stuns victim up to 2 seconds\n\
			Disarm on self - Roll - you rapidly roll. Be careful in the small rooms!\n\
			Harm on self - Dash - you dash forward, moving 2 tiles. Don't slam into walls!"

/datum/martial_art/nanite/eaglestyle/handle_streak(mob/living/carbon/human/owner, mob/living/carbon/human/D)
	if(findtext(streak, "DAD"))
		owner.visible_message(SPAN_DANGER("[owner] jumps backwards, pushing [D] with his legs!"))
		playsound(owner.loc, 'sound/weapons/thudswoosh.ogg', 25, 1, -1)
		var/throwdir = get_dir(owner, D)
		D.throw_at(get_edge_target_turf(D, throwdir),1,1)
		throwdir = get_dir(D, owner)
		owner.throw_at(get_edge_target_turf(owner, throwdir),1	,1)
		owner.AdjustStunned(-5)
		owner.AdjustWeakened(-5)
		return TRUE

	if(findtext(streak, "ADAA"))
		owner.visible_message(SPAN_DANGER("[owner] performs a line of tactical attacks into [D]'s neck, knocking him down!"))
		playsound(owner.loc, 'sound/weapons/punch2.ogg', 25, 1, -1)
		D.apply_damage(7, BRUTE, BP_HEAD)
		D.Weaken(2)
		D.Stun(1)
		return TRUE

	if(findtext(streak, "D") && owner == D)
		owner.visible_message(SPAN_WARNING("[owner] rapidly rolls from danger!"))
		playsound(owner.loc, 'sound/weapons/thudswoosh.ogg', 25, 1, -1)
		var/orig_dir = owner.dir
		var/escape_dir = 2
		if(owner.dir <= 2)
			escape_dir = pick(4, 8)
		else
			escape_dir = pick(1, 2)
		owner.throw_at(get_edge_target_turf(owner, escape_dir),1,1)
		owner.AdjustStunned(-5)
		owner.AdjustWeakened(-5)
		owner.dir = orig_dir
		return TRUE

	if(findtext(streak, "A") && owner == D)
		owner.visible_message(SPAN_WARNING("[owner] dashes forward!"))
		owner.throw_at(get_edge_target_turf(owner, owner.dir),2,1)
		owner.AdjustStunned(-5)
		owner.AdjustWeakened(-5)

	return FALSE

/obj/item/weapon/nanite_injector/eaglestyle
	name = "combat nanite injector"
	desc = "A black autoinjector with blue bar on top, which can transfer combat nanites to your body. This one has marking \"Eagle Brawl Wtyle\"."
	icon_state = "blue_hypo"
	martial_art = new /datum/martial_art/nanite/eaglestyle

//A simple, yet useful martial art for close combat. Can be deadly even against victims with guns. Slam + esword = easy frag

/datum/martial_art/cqc
	name = "CQC"
	id = "cqc"

	block_modifier = 2 //It is CQC
	additional_hit_damage = 3 //Only pain

	desc = "Harm Harm Harm - Legkick - throws victim back and damages them\n\
			Grab Harm - Floorslam - stuns victim\n\
			Disarm Disarm - Lightning Strike - stuns victim, but without damage\n\
			Disarm Harm Disarm - Headkick - knocks victim unconsious if lying on the floor, else stuns him"

/datum/martial_art/cqc/handle_streak(mob/living/carbon/human/owner, mob/living/carbon/human/D)
	if(findtext(streak, "AAA"))
		owner.visible_message(SPAN_DANGER("[owner] kicks [D] in the chest!"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		var/throwdir = get_dir(owner, D)
		D.throw_at(get_edge_target_turf(D, throwdir),1,1)
		D.apply_damage(10, BRUTE, BP_CHEST)
		return TRUE

	if(findtext(streak, "GA"))
		owner.visible_message(SPAN_DANGER("[owner] slams [D] onto the ground!"))
		playsound(owner.loc, 'sound/weapons/punch2.ogg', 25, 1, -1)
		D.apply_damage(7, BRUTE, owner.zone_sel.selecting)
		D.Weaken(0.2)
		return TRUE

	if(findtext(streak, "DD"))
		owner.visible_message(SPAN_DANGER("[owner] lightly strikes into [D]'s chest!"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		D.Weaken(1)
		return TRUE

	if(findtext(streak, "DAD"))
		if(D.lying)
			owner.visible_message(SPAN_DANGER("[owner] kicks [D] into head, knocking him unconsious!"))
			D.sleeping = 10
			D.Weaken(1)
			playsound(owner.loc, 'sound/weapons/punch3.ogg', 25, 1, -1)
			return TRUE
		owner.visible_message(SPAN_DANGER("[owner] strikes into [D]'s chest!"))
		playsound(owner.loc, 'sound/weapons/genhit2.ogg', 25, 1, -1)
		D.apply_damage(5, BRUTE, BP_CHEST)
		D.Weaken(0.5)
		return TRUE
	return FALSE

/obj/item/weapon/nanite_injector/cqc
	name = "combat nanite injector"
	desc = "A black autoinjector with green bar on top, which can transfer combat nanites to your body. This one has marking \"CQC\"."
	icon_state = "green_hypo"
	martial_art = new /datum/martial_art/cqc
