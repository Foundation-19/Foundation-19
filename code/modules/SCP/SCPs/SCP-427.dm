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
	var/global/list/time_used = list()
	// The times are in process ticks; One process tick is around 1 second
	/// Time of use after which there is a probability to transform
	var/transformation_time_min = 90
	/// Time at which the probability rises to maximum
	var/transformation_time_max = 900
	/// Maximum probability of transforming per tick after reaching max use time
	var/transformation_max_prob = 4
	/// The type of a mob spawned upon "transformation"
	var/monster_type = /mob/living/simple_animal/hostile/meat/abomination

	// Looping sound vars
	var/datum/sound_token/sound_token
	var/sound_id
	var/effect_sound = 'sounds/scp/427/effect.ogg'
	// Ugly
	var/datum/sound_token/sound_token_transform
	var/sound_id_transform
	var/transform_sound = 'sounds/scp/427/transform.ogg'

/obj/item/clothing/accessory/scp_427/Initialize()
	. = ..()
	sound_id = "[type]_[sequential_id(/obj/item/clothing/accessory/scp_427)]"
	sound_id_transform = "[sound_id]_transform"

/obj/item/clothing/accessory/scp_427/Destroy()
	QDEL_NULL(sound_token)
	QDEL_NULL(sound_token_transform)
	return ..()

/obj/item/clothing/accessory/scp_427/Process()
	// Will work from any "first-layer" location on the mob, so, not in backpacks
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		if(sound_token_transform)
			sound_token_transform.Pause()
		return

	if(!open)
		return

	if(!(user in time_used))
		time_used[user] = 0
		RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(RemoveDeletedMob))

	time_used[user] += 1

	// Do healing
	user.heal_overall_damage(10, 10)
	user.adjustCloneLoss(-5)
	user.adjustOxyLoss(-5)
	user.radiation = max(user.radiation - 20, 0)
	// Heal minor effects
	user.adjustEarDamage(-5, -5)
	user.adjust_eye_blur(-3 SECONDS)
	user.adjust_temp_blindness(-3 SECONDS)
	user.adjust_confusion(-3 SECONDS)
	user.AdjustParalysis(-2)
	user.AdjustStunned(-2)
	user.AdjustWeakened(-2)
	user.sleeping = max(user.sleeping - 5, 0)
	user.adjust_slurring(-5 SECONDS)
	user.adjust_drugginess(-5 SECONDS)
	user.adjust_silence(-5 SECONDS)
	user.adjust_stutter(-5 SECONDS)
	// Nutrition
	user.adjust_nutrition(3)
	user.adjust_hydration(3)
	// Chemical effects
	user.add_chemical_effect(CE_ANTITOX, 2)
	user.add_chemical_effect(CE_BRAIN_REGEN, 2)
	// Fix organs
	var/obj/item/organ/internal/heart/heart = user.internal_organs_by_name[BP_HEART]
	if(user.should_have_organ(BP_HEART) && heart.pulse == PULSE_NONE && prob(25))
		user.resuscitate()
	for(var/obj/item/organ/internal/I in user.internal_organs)
		I.heal_damage(5)
	for(var/obj/item/organ/O in user.organs)
		if(istype(O, /obj/item/organ/external))
			var/obj/item/organ/external/E = O
			E.remove_pain(5)
		if(prob(15))
			O.status &= ~ORGAN_DEAD
		if(prob(25))
			O.status &= ~ORGAN_BROKEN
		if(prob(35))
			O.status &= ~ORGAN_TENDON_CUT
		if(prob(35))
			O.status &= ~ORGAN_ARTERY_CUT
		if(prob(50))
			O.status &= ~ORGAN_BLEEDING
	// And finally, update damage icons
	user.UpdateDamageIcon()

	// Over-use effects
	if(time_used[user] < transformation_time_min)
		if(sound_token_transform)
			sound_token_transform.Pause()
		return

	// Sound
	if(!sound_token_transform)
		sound_token_transform = GLOB.sound_player.PlayLoopingSound(src, sound_id_transform, transform_sound, 10, 3)
	else
		sound_token_transform.Unpause()

	// Check for transformation
	var/transform_prob = transformation_max_prob * min(1, time_used[user] / transformation_time_max)
	if(prob(transform_prob))
		var/turf/user_turf = get_turf(user)
		user.drop_from_inventory(src, user_turf)
		playsound(user_turf, transform_sound, 75, TRUE, 12)
		user.visible_message(
			SPAN_DANGER("\The [user] turns into unknown monstrosity as [src] falls to the ground!"),
			SPAN_USERDANGER("Your body turns into something unrecognizable! It's over!"),
			)
		user.dust()
		new monster_type(user_turf)

/obj/item/clothing/accessory/scp_427/attack_self(mob/user)
	if(!base_icon_state)
		base_icon_state = icon_state

	open = !open
	to_chat(user, "You flip \the [src] [open ? "open" : "closed"].")
	if(open)
		icon_state = "[base_icon_state]_open"
		START_PROCESSING(SSobj, src)
		if(!sound_token)
			sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, effect_sound, 20, 2)
		else
			sound_token.Unpause()
	else
		icon_state = "[base_icon_state]"
		STOP_PROCESSING(SSobj, src)
		sound_token.Pause()
		if(sound_token_transform)
			sound_token_transform.Pause()

// Coarse, 1:1 - Turns into SCP 500
// Fine, Very Fine - Turns into the monster
/obj/item/clothing/accessory/scp_427/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_COARSE, MODE_ONE_TO_ONE)
			return /obj/item/reagent_containers/pill/scp500
		if(MODE_FINE, MODE_VERY_FINE)
			return monster_type
	return ..()

/obj/item/clothing/accessory/scp_427/proc/RemoveDeletedMob(mob/target)
	SIGNAL_HANDLER

	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	time_used -= target
