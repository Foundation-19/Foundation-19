// Heals brute damage rapidly, in return for nutrition
/obj/item/organ/internal/heart/abomination
	name = "blood pump"
	var/heal_rate = 5

/obj/item/organ/internal/heart/abomination/Process()
	. = ..()
	if(!owner)
		return

	if(is_broken())
		return

	var/mob/living/carbon/human/H = owner
	// Do nothing if nutrition is too low or brute damage isn't high enough
	if(H.nutrition <= 200 || H.getBruteLoss() < 50)
		return

	H.adjustBruteLoss(-heal_rate)
	owner.adjust_nutrition(-heal_rate)

/obj/item/organ/internal/stomach/abomination
	name = "nutrient refinery"

/obj/item/organ/internal/lungs/abomination
	name = "gas pump"

/obj/item/organ/internal/liver/abomination
	name = "toxin filter"

/obj/item/organ/internal/kidneys/abomination
	name = "secondary filter"

/obj/item/organ/internal/brain/abomination
	name = "swarm link"

/obj/item/organ/internal/eyes/abomination
	name = "eyes" // Eyes, yes.

// Actual stuff
/obj/item/organ/internal/larva_producer
	name = "larvae storage"
	icon_state = "stomach"
	color = COLOR_MAROON
	organ_tag = BP_LARVA
	parent_organ = BP_CHEST
	can_be_printed = FALSE
	var/larva_cooldown = 0
	var/larva_cooldown_time = 300

/obj/item/organ/internal/larva_producer/Initialize()
	. = ..()
	larva_cooldown = larva_cooldown_time

/obj/item/organ/internal/larva_producer/Process()
	if(owner)
		var/cooldown_adjustment = 1 + round(owner.nutrition / 100)
		larva_cooldown = max(0, larva_cooldown - cooldown_adjustment)
		if(larva_cooldown == round(larva_cooldown_time * 0.3))
			to_chat(owner, SPAN_WARNING("Your [parent_organ] is vibrating ever so slighty..."))
		else if(larva_cooldown == round(larva_cooldown_time * 0.2))
			to_chat(owner, SPAN_DANGER("Something inside of your [parent_organ] is moving!"))
		else if(larva_cooldown == round(larva_cooldown_time * 0.1))
			to_chat(owner, SPAN_USERDANGER("\The [src] is about to produce a new larva!"))
		else if(larva_cooldown <= 0)
			var/mob/living/simple_animal/hostile/infestation/larva/L = new(get_turf(owner))
			owner.Stun(2)
			playsound(L, 'sounds/effects/splat.ogg', 50, TRUE)
			var/obj/item/organ/internal/stomach/stomach = owner.internal_organs_by_name[BP_STOMACH]
			var/obj/effect/decal/cleanable/vomit/splat = new /obj/effect/decal/cleanable/vomit(get_turf(owner))
			splat.color = COLOR_MAROON
			if(stomach.ingested.total_volume)
				stomach.ingested.trans_to_obj(splat, min(15, stomach.ingested.total_volume))
			visible_message(SPAN_DANGER("\The [owner] throws up, as something crawls out!"),
							SPAN_DANGER("You throw up, leading \the [L] outside."))
			larva_cooldown = larva_cooldown_time
			owner.adjust_nutrition(-100)
	return ..()
