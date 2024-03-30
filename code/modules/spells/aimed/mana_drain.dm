/datum/spell/aimed/mana_drain
	name = "Mana Drain"
	desc = "This spell drains the mana out of the target, giving it to you instead."
	deactive_msg = "You discharge the mana drain spell..."
	active_msg = "You charge the mana drain spell!"

	charge_max = 25 SECONDS
	cooldown_reduc = 5 SECONDS

	invocation = "Exhaurire!"
	invocation_type = INVOKE_SHOUT

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 1, UPGRADE_POWER = 2)

	range = 5

	hud_state = "wiz_mana_drain"

	cast_sound = 'sounds/magic/drain.ogg'

	spell_cost = 3
	mana_cost = 5
	categories = list(SPELL_CATEGORY_ANTIMAGIC)

	/// Amount of mana drained every second; If target's mana is below this - the spell will end.
	var/mana_drain_rate = 2
	/// How far can the target be away once the drain has started
	var/mana_drain_range = 7
	/// Cannot drain mana for more than this amount of times
	var/max_iterations = 100
	var/datum/beam/current_beam = null

/datum/spell/aimed/mana_drain/Destroy()
	QDEL_NULL(current_beam)
	return ..()

/datum/spell/aimed/mana_drain/TargetCastCheck(mob/living/user, mob/living/target)
	if(!GetManaDatum(target))
		to_chat(user, SPAN_WARNING("The target must be capable of holding mana!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/mana_drain/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	to_chat(user, SPAN_NOTICE("You begin draining mana from \the [target]"))
	to_chat(target, SPAN_DANGER("Your mana is being drained by \the [user]!"))
	playsound(target, 'sounds/magic/drain.ogg', 50, TRUE)

	QDEL_NULL(current_beam)
	current_beam = user.Beam(target, icon_state = "drainbeam")
	current_beam.visuals.color = COLOR_MANA
	DoTheDrain(user, target)

/datum/spell/aimed/mana_drain/ImproveSpellPower()
	mana_drain_rate += initial(mana_drain_rate)

	return "The [src] spell now drains [mana_drain_rate * 2] mana per second."

/datum/spell/aimed/mana_drain/proc/DoTheDrain(mob/living/user, atom/movable/target, iteration = 1)
	if(QDELETED(target) || QDELETED(user) || !istype(target) || !istype(user))
		QDEL_NULL(current_beam)
		return

	if(get_dist(user, target) > mana_drain_range)
		QDEL_NULL(current_beam)
		to_chat(user, SPAN_WARNING("\The [target] is too far away to continue the mana drain!"))
		return

	var/datum/mana/user_mana = GetManaDatum(user)
	var/datum/mana/target_mana = GetManaDatum(target)
	if(!istype(user_mana) || !istype(target_mana))
		QDEL_NULL(current_beam)
		return

	if(iteration >= max_iterations || target_mana.mana_level < mana_drain_rate)
		QDEL_NULL(current_beam)
		to_chat(user, SPAN_NOTICE("You finish draining mana out of \the [target]."))
		return

	user_mana.AddMana(mana_drain_rate)
	target_mana.UseMana(target, mana_drain_rate)

	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(target), target.dir, target)
	D.alpha = 125
	D.color = COLOR_MANA
	animate(D, alpha = 0, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), time = rand(8, 18))

	addtimer(CALLBACK(src, PROC_REF(DoTheDrain), user, target, iteration + 1), (0.5 SECONDS))
