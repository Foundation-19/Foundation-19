/datum/spell/aimed/passage
	name = "Passage"
	desc = "throw a spell towards an area and teleport to it."
	feedback = "PA"
	school = "conjuration"
	charge_max = 250
	spell_flags = 0
	invocation = "A'YASAMA"
	invocation_type = INVOKE_SHOUT
	range = 15
	level_max = list(UPGRADE_TOTAL = 1, UPGRADE_SPEED = 0, UPGRADE_POWER = 1)
	spell_flags = 0
	duration = 15
	projectile_type = /obj/item/projectile/spell_projectile/passage
	var/amt_paralysis = 0

	active_msg = "You prepare to cast the bolt of passage!"
	deactive_msg = "You decide against using the bolt of passage."

	hud_state = "gen_project"
	cast_sound = 'sound/magic/lightning_bolt.ogg'

/datum/spell/aimed/passage/prox_cast(list/targets, atom/spell_holder)
	for(var/mob/living/L in targets)
		L.Paralyse(amt_paralysis)

	var/turf/T = get_turf(spell_holder)

	holder.forceMove(T)
	var/datum/effect/effect/system/smoke_spread/S = new /datum/effect/effect/system/smoke_spread()
	S.set_up(3,0,T)
	S.start()
	playsound(src, 'sound/magic/lightningshock.ogg', 50)
	show_sound_effect(T)

/datum/spell/aimed/passage/empower_spell()
	if(!..())
		return 0

	amt_paralysis += 2

	return "[src] now stuns those who get hit by it."

/obj/item/projectile/spell_projectile/passage
	name = "bolt of passage"
	icon_state = "energy2"
