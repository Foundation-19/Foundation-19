/datum/spell/aimed/counter_crystal
	name = "Counter Crystal"
	desc = "This spell places a crystal at designated location that lasts for a certain amount of time before collapsing. \
			All spells cast in its vicinity will deal burn damage to their users proportional to the amount of mana used."
	deactive_msg = "You discharge the counter crystal spell..."
	active_msg = "You charge the counter crystal spell!"

	charge_max = 50 SECONDS
	cooldown_reduc = 15 SECONDS
	// Defines for how long the crystal exists
	duration = 30 SECONDS

	invocation = "Contra Navitas!"
	invocation_type = INVOKE_SHOUT

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	spell_flags = 0
	range = 3

	hud_state = "wiz_counter_crystal"

	cast_sound = 'sounds/magic/blink.ogg'

	spell_cost = 6
	mana_cost = 20

	/// Damage multiplier to the amount of mana used to cast the spell
	var/crystal_damage_multiplier = 2

/datum/spell/aimed/counter_crystal/TargetCastCheck(mob/living/user, atom/target)
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	var/turf/T = get_turf(target)
	if(turf_contains_dense_objects(T))
		to_chat(user, SPAN_WARNING("The target floor must be clear of dense objects!"))
		return FALSE
	return ..()

/datum/spell/aimed/counter_crystal/fire_projectile(mob/living/user, atom/target)
	. = ..()
	var/turf/T = get_turf(target)
	var/datum/beam/B = user.Beam(T, icon_state = "lightning[rand(1, 12)]", time = 5)
	B.visuals.color = COLOR_MANA
	animate(B.visuals, alpha = 0, time = 5)
	user.visible_message(
		SPAN_WARNING("[user] manifests a crystal!"),
		SPAN_NOTICE("You place a counter-crystal!"),
		)
	var/obj/structure/cult/pylon/counter_crystal/CC = new (T)
	CC.creator = user
	CC.damage_multiplier = crystal_damage_multiplier
	addtimer(CALLBACK(CC, TYPE_PROC_REF(/obj/structure/cult/pylon/counter_crystal, TimedCollapse)), duration)

/datum/spell/aimed/counter_crystal/ImproveSpellPower()
	if(!..())
		return FALSE

	crystal_damage_multiplier += 1

	return "The [src] damage multiplier is now [crystal_damage_multiplier * 100]%."

////////////////////////
/* The crystal itself */
////////////////////////
/obj/structure/cult/pylon/counter_crystal
	name = "counter crystal"
	desc = "A floating crystal emitting pulses that are harmful to arcane energy."
	icon_state = "pylon_blue"
	light_max_bright = 1
	light_inner_range = 2
	light_outer_range = 7
	light_color = COLOR_MANA

	/// Creator of the crystal is unaffected by its primary effect
	var/mob/creator = null
	/// How far away can the caster be for crystal to trigger
	var/max_distance = 7
	/// Damage multiplier to the amount of mana used to cast the spell
	var/damage_multiplier = 2

/obj/structure/cult/pylon/counter_crystal/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_SPELL_CAST, PROC_REF(OnSpellCast))
	RegisterSignal(SSdcs, COMSIG_GLOB_SPELL_CAST_HAND, PROC_REF(OnSpellCastHand))

/obj/structure/cult/pylon/counter_crystal/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_SPELL_CAST)
	UnregisterSignal(SSdcs, COMSIG_GLOB_SPELL_CAST_HAND)
	return ..()

/obj/structure/cult/pylon/counter_crystal/examine(mob/user)
	. = ..()
	if(LAZYLEN(user.mind?.learned_spells))
		if(user == creator)
			to_chat(user, SPAN_NOTICE("It seems like using spells near this thing is a very bad idea, however this one is your creation and will not target you."))
			return
		to_chat(user, SPAN_WARNING("It seems like using spells near this thing is a very bad idea."))

/obj/structure/cult/pylon/counter_crystal/proc/OnSpellCast(datum/source, mob/living/caster, datum/spell/S, list/targets)
	SIGNAL_HANDLER

	Retalite(caster, S.mana_cost)

/obj/structure/cult/pylon/counter_crystal/proc/OnSpellCastHand(datum/source, mob/living/caster, datum/spell/hand/S, atom/target)
	SIGNAL_HANDLER

	Retalite(caster, S.mana_cost_per_cast)

/obj/structure/cult/pylon/counter_crystal/proc/Retalite(mob/living/caster, mana_used = 0)
	if(!mana_used)
		return

	if(caster == creator)
		return FALSE

	if(caster.z != z)
		return FALSE

	if(get_dist(src, caster) > max_distance)
		return FALSE

	var/datum/beam/B = Beam(caster, icon_state = "lightning[rand(1, 12)]", time = 10)
	B.visuals.color = COLOR_MANA
	animate(B.visuals, alpha = 0, color = COLOR_RED, time = 10)

	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(src), dir, src)
	D.alpha = 175
	var/matrix/M = matrix()
	M *= 2
	animate(D, alpha = 0, transform = M, time = 5)

	playsound(get_turf(caster), 'sounds/magic/lightningshock.ogg', 50, TRUE)
	playsound(get_turf(src), 'sounds/magic/lightningshock.ogg', 50, TRUE)

	visible_message(SPAN_DANGER("Rays of powerful electricity dart from \the [src] towards \the [caster]!"))
	to_chat(caster, SPAN_USERDANGER("The [src] strikes you with powerful blast of electricity!"))

	var/damage = clamp(mana_used * damage_multiplier, 20, 500)
	caster.adjustFireLoss(damage)
	caster.flash_eyes(FLASH_PROTECTION_MAJOR)
	caster.set_confusion_if_lower(3)

/obj/structure/cult/pylon/counter_crystal/proc/TimedCollapse()
	if(QDELETED(src))
		return

	visible_message(SPAN_DANGER("The [src] begins to collapse in on itself!"))
	var/matrix/M = matrix()
	M *= 1.5
	animate(src, transform = M, time = 5, easing = BACK_EASING)
	M *= 0.01
	animate(transform = M, time = 3, easing = CIRCULAR_EASING)
	QDEL_IN(src, 8)
