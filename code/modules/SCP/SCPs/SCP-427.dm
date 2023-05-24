/obj/item/clothing/accessory/scp_427
	name = "SCP 427"
	desc = "A small, ornately carved locket made out of polished silver material."
	icon_state = "locket"
	item_state = "locket"
	slot_flags = 0
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_MASK | SLOT_TIE
	var/base_icon_state = "locket"
	var/open = FALSE
	/// Associative list, where mob ref = time used
	var/list/time_used = list()
	// The times are in process ticks, keep that in mind; One tick is around ~2 seconds
	/// Time of use after which there is a probability to transform
	var/transformation_time_min = 90
	/// Time at which the probability raises to maximum
	var/transformation_time_max = 180
	/// Maximum probability of transforming per tick after reaching max use time
	var/transformation_max_prob = 10

	// Looping sound vars
	var/datum/sound_token/sound_token
	var/sound_id
	var/effect_sound = 'sound/scp/427/effect.ogg'
	var/transform_sound = 'sound/scp/427/transform.ogg'

/obj/item/clothing/accessory/scp_427/Initialize()
	. = ..()
	sound_id = "[type]_[sequential_id(/obj/item/clothing/accessory/scp_427)]"

/obj/item/clothing/accessory/scp_427/Destroy()
	QDEL_NULL(sound_token)
	time_used = null
	return ..()

/obj/item/clothing/accessory/scp_427/Process()
	// Will work from any "first-layer" location on the mob, so, not in backpacks
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		sound_token.sound = effect_sound
		return

	if(!open)
		return

	if(!(user in time_used))
		time_used[user] = 0
		GLOB.destroyed_event.register(user, src, .proc/RemoveDeletedMob)

	time_used[user] += 1

	// Do healing
	user.heal_overall_damage(15, 15)
	user.adjustCloneLoss(-10)
	user.adjustOxyLoss(-10)
	user.radiation = max(user.radiation - 30, 0)
	user.add_chemical_effect(CE_ANTITOX, 2)
	user.add_chemical_effect(CE_BRAIN_REGEN, 2)
	var/obj/item/organ/internal/heart/heart = user.internal_organs_by_name[BP_HEART]
	if(user.should_have_organ(BP_HEART) && heart.pulse == PULSE_NONE && prob(25))
		user.resuscitate()
	for(var/obj/item/organ/internal/I in user.internal_organs)
		I.heal_damage(5)
	for(var/obj/item/organ/external/E in user.organs)
		E.remove_pain(5)
		if(prob(25))
			E.status &= ~ORGAN_BROKEN
		if(prob(25))
			E.status &= ~ORGAN_TENDON_CUT
		if(prob(25))
			E.status &= ~ORGAN_ARTERY_CUT

	// Over-use effects
	if(time_used[user] < transformation_time_min)
		sound_token.sound = effect_sound
		return

	sound_token.sound = transform_sound

	// Check for transformation
	var/transform_prob = transformation_max_prob * min(1, time_used[user] / transformation_time_max)
	if(prob(transform_prob))
		var/turf/user_turf = get_turf(user)
		forceMove(user_turf)
		playsound(user_turf, transform_sound, 75, TRUE, 12)
		user.visible_message(
			SPAN_DANGER("\The [user] turns into unknown monstrosity as [src] falls to the ground!"),
			SPAN_USERDANGER("Your body turns into something unrecognizable! It's over!"),
			)
		user.dust()
		new /mob/living/simple_animal/hostile/meat/abomination(user_turf)

/obj/item/clothing/accessory/scp_427/attack_self(mob/user)
	if(!base_icon_state)
		base_icon_state = icon_state

	open = !open
	to_chat(user, "You flip \the [src] [open ? "open" : "closed"].")
	if(open)
		icon_state = "[base_icon_state]_open"
		START_PROCESSING(SSobj, src)
		if(!sound_token)
			sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, effect_sound, volume = 35)
		else
			sound_token.Unpause()
	else
		icon_state = "[base_icon_state]"
		STOP_PROCESSING(SSobj, src)
		sound_token.Pause()

/obj/item/clothing/accessory/scp_427/proc/RemoveDeletedMob(mob/target)
	GLOB.destroyed_event.unregister(target, src, .proc/RemoveDeletedMob)
	time_used -= target
