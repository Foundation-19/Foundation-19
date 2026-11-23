/obj/structure/scp151
	name = "painting"
	desc = "A painting depicting a rising wave."
	icon = 'icons/obj/structures.dmi'

	icon_state = "great_wave"
	anchored = TRUE
	density = TRUE

	var/covered = FALSE
	var/obj/item/scp151_cover/cover_item

	//Config

	///How much oxygen damage we do per tick
	var/oxy_damage = 1.5
	///Message cooldown
	var/message_cooldown = 15 SECONDS
	///How much water is ingested per tick
	var/water_ingest = 2
	///How long it takes for the effect to fade after leaving line of sight
	var/effect_fade_time = 60 SECONDS

/obj/structure/scp151/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"painting",
		SCP_SAFE,
		"151",
		SCP_MEMETIC
	)

	SCP.memeticFlags = MVISUAL|MPERSISTENT|MSYNCED
	SCP.memetic_proc = TYPE_PROC_REF(/obj/structure/scp151, effect)
	SCP.compInit()

	START_PROCESSING(SSobj, src)

/obj/structure/scp151/Process()
	if(covered)
		return
	SCP.meme_comp.check_viewers()
	SCP.meme_comp.activate_memetic_effects()

/obj/structure/scp151/proc/cover(obj/item/scp151_cover/C, mob/user)
	if(covered)
		return
	covered = TRUE
	cover_item = C
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)
	visible_message(SPAN_NOTICE("\The [src] is covered by \the [C]."))
	update_icon()

/obj/structure/scp151/proc/uncover(mob/user)
	if(!covered)
		return
	covered = FALSE
	cover_item = null
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_BREACHED)
	visible_message(SPAN_WARNING("\The [src] is uncovered!"))
	update_icon()

/obj/structure/scp151/on_update_icon()
	overlays.Cut()
	if(covered)
		overlays += image('icons/obj/structures.dmi', "canvas_cover")

/obj/structure/scp151/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/scp151_cover))
		if(!covered)
			var/obj/item/scp151_cover/C = W
			user.unEquip(C)
			cover(C, user)
			return
	if(covered)
		to_chat(user, SPAN_WARNING("\The [src] is covered. Remove the cover first."))
		return
	. = ..()

/obj/structure/scp151/attack_hand(mob/user)
	if(covered)
		uncover(user)
		if(cover_item)
			cover_item.remove_cover()
			user.put_in_hands(cover_item)
			cover_item = null
		return
	. = ..()

// Mechanics

/obj/structure/scp151/proc/effect(mob/living/carbon/human/H)
	if(covered)
		return
	H.apply_damage(oxy_damage, OXY)

	var/obj/item/organ/internal/lungs/breathe_organ = H.internal_organs_by_name[H.species.breathing_organ]
	var/obj/item/organ/internal/stomach/stomach_organ = H.internal_organs_by_name[BP_STOMACH]

	stomach_organ.ingested.add_reagent(/datum/reagent/water, water_ingest)

	if((breathe_organ.get_oxygen_deprivation() > 10))
		if(stomach_organ.ingested.get_free_space() <= 5)
			H.vomit()
		else if(prob(breathe_organ.get_oxygen_deprivation() + 15))
			H.emote("cough")
	else if(prob(10) && ((world.time - H.humanStageHandler.getStage("151_message_cooldown")) > message_cooldown))
		to_chat(H, SPAN_NOTICE(pick("The taste of seawater permeates your mouth...", "Your lungs feel like they are filling with water...")))
		H.humanStageHandler.setStage("151_message_cooldown", world.time)

	if(prob(breathe_organ.get_oxygen_deprivation() + 30) && (breathe_organ.get_oxygen_deprivation() > 25) && ((world.time - H.humanStageHandler.getStage("151_message_cooldown")) > message_cooldown))
		to_chat(H, SPAN_WARNING(pick("Your lungs feel like they are filled with water!", "You try to breath but your lungs are filled with water!", "You cannot breath!")))
		H.humanStageHandler.setStage("151_message_cooldown", world.time)

/mob/living/carbon/human/proc/cure_scp151()
	var/obj/item/organ/internal/lungs/L = internal_organs_by_name[species.breathing_organ]
	if(L)
		L.damage = max(0, L.damage - 20)
	var/obj/item/organ/internal/stomach/S = internal_organs_by_name[BP_STOMACH]
	if(S && S.ingested)
		S.ingested.remove_reagent(/datum/reagent/water, S.ingested.get_reagent_amount(/datum/reagent/water))
	to_chat(src, SPAN_NOTICE("The water clears from your lungs. You can breathe again."))
