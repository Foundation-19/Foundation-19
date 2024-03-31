/datum/spell/aimed/corpse_explosion
	name = "Corpse Explosion"
	desc = "This spell causes a corpse of a living creature to violently explode in a bloody mist \
			dealing little damage, but confuses and causes vomiting for most people."
	deactive_msg = "You discharge the corpse explosion spell..."
	active_msg = "You charge the corpse explosion spell!"

	invocation = "none"
	invocation_type = INVOKE_NONE

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 0, UPGRADE_POWER = 2)

	charge_max = 30 SECONDS
	spell_flags = 0
	range = 5

	hud_state = "wiz_corpse_explosion"

	spell_cost = 3
	mana_cost = 10

	var/amt_confusion = 5
	var/amt_blurry = 10

/datum/spell/aimed/corpse_explosion/TargetCastCheck(mob/living/user, mob/living/target)
	if(!isliving(target) || target.stat != DEAD)
		to_chat(user, SPAN_WARNING("The target must be a corpse of a living creature!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/corpse_explosion/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/matrix/M = matrix(target.transform)
	M *= 1.5
	animate(target, transform = M, color = "#ffcccc", time = 5)
	target.visible_message(SPAN_DANGER("[target]'s lifeless body visibly bloats!"))
	addtimer(CALLBACK(src, PROC_REF(ExplodeCorpse), user, target), 6)

/datum/spell/aimed/corpse_explosion/proc/ExplodeCorpse(mob/living/user, mob/living/target)
	if(QDELETED(target) || target.stat != DEAD)
		return

	var/turf/T = get_turf(target)
	target.gib()
	for(var/mob/living/carbon/human/H in view(5, T))
		if(H.stat)
			continue
		if(H == user)
			continue
		to_chat(H, SPAN_USERDANGER("Disgusting mess of organs and blood splatters all over you!"))
		H.adjust_confusion(amt_confusion)
		H.adjust_eye_blur(amt_blurry)
		addtimer(CALLBACK(H, /mob/living/proc/empty_stomach, TRUE), rand(2, 10))
		for(var/i = 1 to rand(1, 4))
			addtimer(CALLBACK(H, /mob/living/proc/empty_stomach, TRUE), rand(10, 40) * (i + 1))

	var/datum/effect/effect/system/smoke_spread/bloody/smoke = new()
	smoke.set_up(6, 0, T)
	smoke.start()

/datum/spell/aimed/corpse_explosion/ImproveSpellPower()
	if(!..())
		return FALSE

	amt_confusion += 2
	amt_blurry += 5
	return "The [src] spell effects are now more powerful."
