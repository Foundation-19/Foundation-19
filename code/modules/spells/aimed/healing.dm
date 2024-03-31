/datum/spell/aimed/heal_target
	name = "Cure Light Wounds"
	desc = "A rudimentary spell used mainly to heal light bruises and burns."
	deactive_msg = "You discharge the healing spell..."
	active_msg = "You charge the healing spell!"
	spell_flags = 0
	charge_max = 10 SECONDS
	cooldown_reduc = 5 SECONDS

	invocation = "Di'Nath!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 1, UPGRADE_POWER = 2)

	hud_state = "heal_minor"
	cast_sound = 'sounds/magic/staff_healing.ogg'

	/// Maximum distance between user and target
	range = 3
	var/brute_damage = -20
	var/burn_damage = -20
	var/tox_damage = 0
	var/oxy_damage = 0
	var/rad_damage = 0
	var/robo_damage = -10
	var/organ_heal = 0
	var/blood_heal = 0
	var/brain_damage = 0
	var/effect_state = "green_sparkles"
	var/effect_duration = 5
	var/effect_color = "#ffffff"

	// Vars expect a constant at compile time, so we can't use macros for spans here
	message = "<span class='notice'><b>You feel a pleasant rush of heat move through your body.</b></span>"

	categories = list(SPELL_CATEGORY_HEALING)
	spell_cost = 1
	mana_cost = 6

/datum/spell/aimed/heal_target/TargetCastCheck(mob/living/user, mob/living/target)
	if(!isliving(target))
		to_chat(user, SPAN_WARNING("The target must be a living creature!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/heal_target/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	target.adjustBruteLoss(brute_damage)
	target.adjustFireLoss(burn_damage)
	target.adjustToxLoss(tox_damage)
	target.adjustOxyLoss(oxy_damage)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		for(var/obj/item/organ/internal/affecting in H.internal_organs)
			if(affecting && istype(affecting))
				affecting.heal_damage(organ_heal, organ_heal)
		for(var/obj/item/organ/external/affecting in H.organs)
			if(affecting && istype(affecting))
				var/dam = BP_IS_ROBOTIC(affecting) ? -robo_damage : organ_heal
				affecting.heal_damage(dam, dam, robo_repair = BP_IS_ROBOTIC(affecting))
		H.vessel.add_reagent(/datum/reagent/blood, blood_heal)
		H.adjustBrainLoss(brain_damage)
		H.radiation += min(H.radiation, rad_damage)
		H.fixblood()
	target.regenerate_icons()

	if(effect_state)
		var/obj/o = new /obj/effect/temp_visual/temporary(get_turf(target), effect_duration, 'icons/effects/effects.dmi', effect_state)
		o.color = effect_color

	return TRUE

/datum/spell/aimed/heal_target/ImproveSpellPower()
	if(!..())
		return FALSE
	brute_damage -= 20
	burn_damage -= 20
	robo_damage -= 10
	blood_heal = 10
	return "The [src] spell now heals more and slightly restores lost blood."

/datum/spell/aimed/heal_target/major
	name = "Cure Major Wounds"
	desc = "A spell used to fix others that cannot be fixed with regular medicine."

	spell_flags = NEEDSCLOTHES
	invocation = "Borv Di'Nath!"
	range = 1
	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 1, UPGRADE_POWER = 1)

	charge_max = 40 SECONDS
	cooldown_reduc = 10 SECONDS

	hud_state = "heal_major"

	brute_damage = -60
	burn_damage  = -60
	robo_damage = -30
	blood_heal = 30

	message = "<span class='notice'><b>Your body feels like a warm, cozy fire.</b></span>"

	spell_cost = 4
	mana_cost = 20

/datum/spell/aimed/heal_target/major/ImproveSpellPower()
	if(!..())
		return FALSE

	brute_damage = -120
	burn_damage = -120
	robo_damage = -60
	blood_heal = 60
	organ_heal = 10
	brain_damage = -15
	rad_damage  = -50
	tox_damage = -20
	oxy_damage = -20

	return "The [src] spell now heals more, and heals organ damage and radiation."

/datum/spell/aimed/heal_target/sacrifice
	name = "Sacrifice"
	desc = "This spell heals immensily while damaging the user."
	invocation = "Ei'Nath Borv Di'Nath!"
	charge_type = SPELL_HOLDVAR
	holder_var_type = "fireloss"
	holder_var_amount = 100
	level_max = list(UPGRADE_TOTAL = 1, UPGRADE_SPEED = 0, UPGRADE_POWER = 1)

	range = 1
	brute_damage = -1000
	burn_damage = -1000
	robo_damage = -1000
	oxy_damage = -100
	tox_damage = -100
	blood_heal  = 280
	effect_color = "#ff0000"

	hud_state = "gen_dissolve"
	cast_sound = 'sounds/magic/disintegrate.ogg'

	spell_cost = 4
	mana_cost = 20

/datum/spell/aimed/heal_target/sacrifice/ImproveSpellPower()
	if(!..())
		return 0

	organ_heal = 50
	brain_damage  = -100
	rad_damage  = -1000

	return "You will now heal organ and brain damage, as well as virtually purge all radiation."

/datum/spell/aimed/heal_target/trance
	name = "Trance"
	desc = "A mighty spell of restoration that briefly forces its target into a deep, dreamless sleep, rapidly repairing their body and soul as their senses are dulled. The users of this mighty art are known for being short lived, slowly devolving into raving madness as the power they once relied on fails them with excessive use."
	invocation = "Di' Dae Nath!"

	charge_max = 2 MINUTES

	range = 1
	brute_damage = -2000
	burn_damage = -2000
	oxy_damage = -1000
	tox_damage = -1000
	robo_damage = -1000
	organ_heal = 100
	brain_damage  = -200
	rad_damage  = -5000
	hud_state = "trance"

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 0, UPGRADE_POWER = 0)

	spell_cost = 5
	mana_cost = 30

	var/obj/effect/effect

/datum/spell/aimed/heal_target/trance/fire_projectile(mob/living/user, mob/living/target)
	var/time = max(30 SECONDS, (target.getBruteLoss() + target.getFireLoss()) * 20)
	. = ..()
	var/turf/T = get_turf(target)
	effect = new /obj/effect/rift(T)
	effect.color = "f0e68c"
	target.forceMove(effect)
	target.status_flags &= GODMODE
	to_chat(target, SPAN_NOTICE("You will be in stasis for [time/10] second\s."))
	addtimer(CALLBACK(src, PROC_REF(CancelRift)), time)

/datum/spell/aimed/heal_target/trance/Destroy()
	CancelRift()
	return ..()

/datum/spell/aimed/heal_target/trance/proc/CancelRift()
	if(effect)
		var/mob/living/L = locate() in effect
		L.status_flags &= ~GODMODE
		L.forceMove(get_turf(L))
		charge_max += 300
		QDEL_NULL(effect)

/obj/effect/rift
	name = "rift"
	desc = "a tear in space and time."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "rift"
	anchored = TRUE
	density = FALSE

/obj/effect/rift/Destroy()
	for(var/atom/movable/M in contents)
		M.dropInto(loc)
	. = ..()

/datum/spell/aimed/revoke_death
	name = "Revoke Death"
	desc = "Revoke that of death itself."
	deactive_msg = "You discharge the revoke death spell..."
	active_msg = "You charge the revoke death spell!"

	charge_max = 120 SECONDS
	cooldown_reduc = 50 SECONDS

	invocation = "Di Le Nal Yen Nath!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 2, UPGRADE_POWER = 0)

	cast_sound = 'sounds/magic/churchbell.ogg'
	hud_state = "heal_revoke"

	categories = list(SPELL_CATEGORY_HEALING, SPELL_CATEGORY_FORBIDDEN)
	spell_cost = 12
	mana_cost = 50

	range = 1

/datum/spell/aimed/revoke_death/TargetCastCheck(mob/living/user, mob/living/target)
	if(!isliving(target))
		to_chat(user, SPAN_WARNING("The target must be a living creature!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	if(target.stat != DEAD)
		to_chat(user, SPAN_NOTICE("\The [target] is not dead..."))
		return FALSE
	return ..()

/datum/spell/aimed/revoke_death/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	for(var/atom/movable/A in view(7, user))
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(A), A.dir, A)
		D.alpha = 145
		animate(D, pixel_x = A.pixel_x + rand(-12, 12), pixel_y = A.pixel_y + rand(-12, 12), alpha = 0, time = rand(7, 20))
	for(var/i = 1 to 25)
		addtimer(CALLBACK(src, PROC_REF(PerformTargetEffect), target), i * 2)
	addtimer(CALLBACK(src, PROC_REF(DoRevive), target), 6 SECONDS)

/datum/spell/aimed/revoke_death/proc/PerformTargetEffect(mob/living/target)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(target), target.dir, target)
	D.alpha = 5
	D.pixel_x = target.pixel_x + rand(-20, 20)
	D.pixel_y = target.pixel_y + rand(-20, 20)
	animate(D, pixel_x = target.pixel_x, pixel_y = target.pixel_y, alpha = 175, time = rand(4, 8))
	animate(alpha = 0, time = 3)

/datum/spell/aimed/revoke_death/proc/DoRevive(mob/living/target)
	for(var/i = 1 to 12)
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(target), target.dir, target)
		D.alpha = 5
		D.pixel_x = target.pixel_x + pick(rand(-26, -14), rand(14, 26))
		D.pixel_y = target.pixel_y + pick(rand(-26, -14), rand(14, 26))
		animate(D, pixel_x = target.pixel_x, pixel_y = target.pixel_y, alpha = 175, time = rand(2, 4))
		animate(alpha = 0, time = 2)
	playsound(target, 'sounds/magic/staff_healing.ogg', 50, FALSE, 14)
	target.revive()
	target.adjust_confusion(30)
	target.visible_message(SPAN_WARNING("\The [target] rises once more!"))
