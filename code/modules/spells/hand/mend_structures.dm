/datum/spell/hand/mend_structures
	name = "Mend Structures"
	desc = "Allows the user to repair most structures of any superficial damage."

	range = 1
	harmful = FALSE
	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 0, UPGRADE_POWER = 2)
	charge_max = 5
	invocation_type = INVOKE_WHISPER
	invocation = "Melius Murum"
	compatible_targets = list(
		/turf,
		/obj,
		)
	hud_state = "wiz_mend_structures"

	spell_cost = 1
	mana_cost = 2
	mana_cost_per_cast = 5

	/// Percentage of maximum integrity that gets repaired
	var/mend_percent = 0.2

/datum/spell/hand/mend_structures/cast_hand(atom/A, mob/user)
	. = ..()
	if(!.)
		return

	var/restore_amount = A.health_max * mend_percent
	if(!A.can_restore_health(restore_amount))
		to_chat(user, SPAN_WARNING("You are unable to repair [A]."))
		return FALSE

	A.restore_health(restore_amount)
	playsound(get_turf(A), 'sounds/items/Welder.ogg', 35, TRUE)
	to_chat(user, SPAN_NOTICE("You manage to repair some damage on [A]."))

	return TRUE

/datum/spell/hand/mend_structures/ImproveSpellPower()
	if(!..())
		return FALSE

	mend_percent += 0.2

	return "[src] now repairs [mend_percent * 100]% of structure damage."
