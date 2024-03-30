#define UPGRADE_STEAL_DURATION "steal duration"

/datum/spell/aimed/spell_steal
	name = "Spell Steal"
	desc = "Temporarily grants you a perfect copy of the spell that was last cast by the target creature."
	deactive_msg = "You discharge the spell steal..."
	active_msg = "You charge the spell steal!"

	charge_max = 35 SECONDS
	cooldown_reduc = 10 SECONDS

	invocation = "Furtum!"
	invocation_type = INVOKE_SHOUT

	level_max = list(UPGRADE_TOTAL = 4, UPGRADE_SPEED = 2, UPGRADE_POWER = 2, UPGRADE_STEAL_DURATION = 2)
	upgrade_cost = list(UPGRADE_SPEED = 5, UPGRADE_POWER = 10, UPGRADE_STEAL_DURATION = 5)

	range = 5

	hud_state = "wiz_spell_steal"

	cast_sound = 'sounds/magic/spell_steal.ogg'

	spell_cost = 8
	mana_cost = 20

	var/stolen_spell_duration = 30 SECONDS
	var/list/blacklisted_spell_types = list(
		/datum/spell/aimed/spell_steal,

		)
	var/list/stolen_spells = list()

/datum/spell/aimed/spell_steal/Destroy()
	for(var/datum/spell/S in stolen_spells)
		QDEL_NULL(S)
	stolen_spells = null
	return ..()

/datum/spell/aimed/spell_steal/TargetCastCheck(mob/living/user, mob/living/target)
	if(!isliving(target) || !target.mind)
		to_chat(user, SPAN_WARNING("The target must be a living creature!"))
		return FALSE
	if(target == user)
		to_chat(user, SPAN_WARNING("You cannot steal spells from yourself!"))
		return FALSE
	if(!istype(target.mind.last_used_spell))
		to_chat(user, SPAN_WARNING("The target hasn't cast any spells recently!"))
		return FALSE
	if(target.mind.last_used_spell.type in blacklisted_spell_types)
		to_chat(user, SPAN_WARNING("The target's last spell is impossible to steal!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/spell_steal/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(target), target.dir, target)
	D.alpha = 125
	D.color = COLOR_GREEN
	animate(D, pixel_x = (user.x - target.x) * world.icon_size, pixel_y = (user.y - target.y) * world.icon_size, alpha = 55, time = 4)
	animate(alpha = 0, time = 2)
	var/datum/spell/S = new target.mind.last_used_spell.type
	for(var/datum/spell/SS in stolen_spells)
		if(SS.type == S.type)
			ForgetSpell(SS)
	// Do the upgrades!
	for(var/up_type in S.spell_levels)
		if(target.mind.last_used_spell.spell_levels[up_type])
			// Stolen spells will be upgraded to the same level as that of the original + our own power upgrade level
			for(var/i = 1 to target.mind.last_used_spell.spell_levels[up_type] + spell_levels[UPGRADE_POWER])
				S.ImproveSpell(up_type, TRUE)
	// To prevent shenanigans with "Consume Magic"
	S.total_points_used = 0
	user.add_spell(S)
	stolen_spells += S
	addtimer(CALLBACK(src, PROC_REF(ForgetSpell), S), stolen_spell_duration)

/datum/spell/aimed/spell_steal/ImproveSpell(upgrade_type)
	. = ..()
	if(!.)
		return

	if(upgrade_type == UPGRADE_STEAL_DURATION)
		return ImproveSpellStealDuration()

/datum/spell/aimed/spell_steal/ImproveSpellPower()
	return "The stolen spells are now stronger."

/datum/spell/aimed/spell_steal/proc/ImproveSpellStealDuration()
	stolen_spell_duration += 30 SECONDS
	return "The stolen spells now remain under your control for [stolen_spell_duration / 10] seconds!"

/datum/spell/aimed/spell_steal/proc/ForgetSpell(datum/spell/S)
	if(QDELETED(src) || QDELETED(S))
		return

	var/mob/living/user = holder
	to_chat(user, SPAN_WARNING(SPAN_BOLD("You forget how to use [S.name] spell!")))
	stolen_spells -= S
	user.remove_spell(S)

#undef UPGRADE_STEAL_DURATION
