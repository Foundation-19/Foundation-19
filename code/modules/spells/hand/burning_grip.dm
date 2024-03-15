/datum/spell/hand/burning_grip
	name = "Burning Grip"
	desc = "Cause someone to drop a held object by causing it to heat up intensly."
	range = 5
	spell_flags = 0
	invocation_type = INVOKE_NONE
	show_message = " throws sparks from their hands"
	spell_delay = 120
	hud_state = "wiz_burn"
	cast_sound = 'sounds/magic/fireball.ogg'
	compatible_targets = list(/mob/living/carbon/human)

	spell_cost = 1
	mana_cost = 5

/datum/spell/hand/burning_grip/valid_target(mob/living/L, mob/user)
	if(!..())
		return 0
	if(!L.l_hand && !L.r_hand)
		return 0
	return 1

/datum/spell/hand/burning_grip/cast_hand(mob/living/carbon/human/H, mob/user)
	. = ..()
	if(!.)
		return

	var/list/targets = list()
	if(H.l_hand)
		targets += BP_L_HAND
	if(H.r_hand)
		targets += BP_R_HAND

	var/obj/O = new /obj/effect/temp_visual/temporary(get_turf(H),3, 'icons/effects/effects.dmi', "fire_goon")
	O.alpha = 150

	for(var/organ in targets)
		var/obj/item/organ/external/E = H.get_organ(organ)
		E.take_external_damage(burn=10, used_weapon = "hot iron")
		if(E.can_feel_pain())
			H.grasp_damage_disarm(E)
		else
			E.take_external_damage(burn=6, used_weapon = "hot iron")
			to_chat(H, "<span class='warning'>You look down to notice that your [E] is burned.</span>")
